#!/bin/bash

# --- DuckDB Answer Checker & Performance Benchmarking Script ---
# Compares SQL answer with solution and measures performance statistics.

SHOW_PROFILE=0
RUN_BENCH=1
BENCH_ITERATIONS=20

QUESTION_NUMBER=""
DATABASE_FILE=""

# Parse flags and positional arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --profile)
            SHOW_PROFILE=1
            shift
            ;;
        --no-bench)
            RUN_BENCH=0
            shift
            ;;
        --bench)
            BENCH_ITERATIONS="$2"
            shift 2
            ;;
        *)
            if [ -z "$QUESTION_NUMBER" ]; then
                QUESTION_NUMBER="$1"
            elif [ -z "$DATABASE_FILE" ]; then
                DATABASE_FILE="$1"
            fi
            shift
            ;;
    esac
done

if [ -z "$QUESTION_NUMBER" ]; then
    echo "Usage: $0 <question_number> [database_file] [--bench N] [--no-bench] [--profile]"
    echo "Example: $0 10 datasets/lemonade.db --bench 20 --profile"
    exit 1
fi

if [ -z "$DATABASE_FILE" ]; then
    DATABASE_FILE="datasets/lemonade.db"
fi

ANSWER_FILE="questions/${QUESTION_NUMBER}/answer.sql"
SOLUTION_FILE="questions/${QUESTION_NUMBER}/solution.sql"

# Step 1: Validate files
if [ ! -f "$ANSWER_FILE" ]; then
    echo "Error: The answer file '${ANSWER_FILE}' does not exist."
    exit 1
fi

if [ ! -s "$ANSWER_FILE" ]; then
    echo "Error: The answer file '${ANSWER_FILE}' is empty."
    exit 1
fi

if [ ! -f "$SOLUTION_FILE" ]; then
    echo "Error: The solution file '${SOLUTION_FILE}' does not exist."
    exit 1
fi

if [ ! -f "$DATABASE_FILE" ]; then
    echo "Error: The database file '${DATABASE_FILE}' does not exist."
    exit 1
fi

echo "Checking question #${QUESTION_NUMBER}..."

# Ensure duckdb is available
DUCKDB_BIN=$(which duckdb 2>/dev/null || echo "$HOME/.local/bin/duckdb")
if [ ! -x "$DUCKDB_BIN" ] && ! command -v duckdb &>/dev/null; then
    echo "Error: duckdb binary not found."
    exit 1
fi

# Step 2: Compare outputs
"$DUCKDB_BIN" "${DATABASE_FILE}" -box -c ".read ${ANSWER_FILE}" > "temp_answer_output.txt" 2>&1
"$DUCKDB_BIN" "${DATABASE_FILE}" -box -c ".read ${SOLUTION_FILE}" > "temp_solution_output.txt" 2>&1

diff -q "temp_answer_output.txt" "temp_solution_output.txt" > /dev/null
IS_CORRECT=$?

if [ $IS_CORRECT -eq 0 ]; then
    echo "✅ Correct! Your answer matches the solution."
else
    echo "❌ Incorrect. The results do not match."
    echo ""
    echo "--- Differences ---"
    diff "temp_answer_output.txt" "temp_solution_output.txt"
fi

rm -f "temp_answer_output.txt" "temp_solution_output.txt"

# Exit early if answer is incorrect and benchmarking not forced
if [ $IS_CORRECT -ne 0 ]; then
    echo ""
    echo "Skipping performance benchmarking due to incorrect query result."
    exit 1
fi

# Step 3: Performance Benchmarking (Mean & Std Dev over N iterations)
if [ $RUN_BENCH -eq 1 ]; then
    echo ""
    echo "⏱️  Running Performance Benchmark (${BENCH_ITERATIONS} iterations)..."

    python3 - "$DATABASE_FILE" "$ANSWER_FILE" "$SOLUTION_FILE" "$BENCH_ITERATIONS" << 'EOF'
import sys, subprocess, re, statistics

db_file = sys.argv[1]
ans_file = sys.argv[2]
sol_file = sys.argv[3]
n_iter = int(sys.argv[4])

def run_bench(sql_file, iterations):
    times = []
    # Warm-up run
    subprocess.run(["duckdb", db_file, "-c", ".timer on", "-c", f".read {sql_file}"], capture_output=True, text=True)
    for _ in range(iterations):
        res = subprocess.run(["duckdb", db_file, "-c", ".timer on", "-c", f".read {sql_file}"], capture_output=True, text=True)
        m = re.search(r'Run Time \(s\): real ([\d\.]+)', res.stdout + res.stderr)
        if m:
            times.append(float(m.group(1)) * 1000.0)
    
    if not times:
        return 0.0, 0.0, 0.0, 0.0
    
    mean = statistics.mean(times)
    stdev = statistics.stdev(times) if len(times) > 1 else 0.0
    return mean, stdev, min(times), max(times)

m_ans, s_ans, min_ans, max_ans = run_bench(ans_file, n_iter)
m_sol, s_sol, min_sol, max_sol = run_bench(sol_file, n_iter)

print("\n📊 Performance Summary:")
print("┌────────────────────┬────────────────────────┬─────────────┬─────────────┐")
print("│ Query              │ Mean Execution Time    │ Min Time    │ Max Time    │")
print("├────────────────────┼────────────────────────┼─────────────┼─────────────┤")
print(f"│ Your Answer        │ {m_ans:6.3f} ms ± {s_ans:5.3f} ms │ {min_ans:6.3f} ms  │ {max_ans:6.3f} ms  │")
print(f"│ Official Solution  │ {m_sol:6.3f} ms ± {s_sol:5.3f} ms │ {min_sol:6.3f} ms  │ {max_sol:6.3f} ms  │")
print("└────────────────────┴────────────────────────┴─────────────┴─────────────┘")

if m_sol > 0 and m_ans > 0:
    diff_pct = ((m_sol - m_ans) / m_sol) * 100.0
    if diff_pct > 0:
        print(f"⚡ Your query ran {abs(diff_pct):.1f}% FASTER than the official solution!\n")
    elif diff_pct < 0:
        print(f"🐢 Your query ran {abs(diff_pct):.1f}% SLOWER than the official solution.\n")
    else:
        print("⚖️ Both queries executed with identical average performance.\n")
EOF
fi

# Step 4: Optional Profiling (`EXPLAIN ANALYZE`)
if [ $SHOW_PROFILE -eq 1 ]; then
    echo "🔍 Query Profiling (EXPLAIN ANALYZE):"
    echo "========================================"
    echo "--- Your Answer Profile ---"
    python3 - "$DATABASE_FILE" "$ANSWER_FILE" << 'EOF'
import sys, subprocess

db_file = sys.argv[1]
sql_file = sys.argv[2]

with open(sql_file) as f:
    sql = f.read().strip()

if not sql.upper().startswith("EXPLAIN"):
    sql = "EXPLAIN ANALYZE " + sql

res = subprocess.run(["duckdb", db_file, "-c", sql], capture_output=True, text=True)
print(res.stdout or res.stderr)
EOF

    echo "--- Official Solution Profile ---"
    python3 - "$DATABASE_FILE" "$SOLUTION_FILE" << 'EOF'
import sys, subprocess

db_file = sys.argv[1]
sql_file = sys.argv[2]

with open(sql_file) as f:
    sql = f.read().strip()

if not sql.upper().startswith("EXPLAIN"):
    sql = "EXPLAIN ANALYZE " + sql

res = subprocess.run(["duckdb", db_file, "-c", sql], capture_output=True, text=True)
print(res.stdout or res.stderr)
EOF
fi