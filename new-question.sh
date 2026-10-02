#!/bin/bash

# --- new-question.sh ---
# Scaffolds a new question directory with the standard files:
#   questions/<N>/question-statement.md
#   questions/<N>/answer.sql
#   questions/<N>/solution.sql
#
# Usage:
#   ./new-question.sh <number> [title] [difficulty] [dataset]
#
# Examples:
#   ./new-question.sh 11
#   ./new-question.sh 11 "Pivot Sales Data" Medium "datasets/gaming.duckdb"

# ── Argument parsing ──────────────────────────────────────────────────────────

if [ -z "$1" ]; then
    echo "Usage: $0 <question_number> [title] [difficulty] [dataset]"
    echo ""
    echo "Arguments:"
    echo "  question_number  Required. The number for the new question (e.g. 11)"
    echo "  title            Optional. Short title for the question (default: 'New Question')"
    echo "  difficulty       Optional. Easy | Medium | Hard  (default: 'Medium')"
    echo "  dataset          Optional. Path to the duckdb/csv file needed (default: none)"
    echo ""
    echo "Examples:"
    echo "  $0 11"
    echo "  $0 11 \"Pivot Sales Data\" Hard \"datasets/gaming.duckdb\""
    exit 1
fi

QUESTION_NUMBER="$1"
TITLE="${2:-New Question}"
DIFFICULTY="${3:-Medium}"
DATASET="$4"

QUESTION_DIR="questions/${QUESTION_NUMBER}"

# ── Guard: don't overwrite an existing question ───────────────────────────────

if [ -d "$QUESTION_DIR" ] && [ "$(ls -A "$QUESTION_DIR")" ]; then
    echo "Error: '$QUESTION_DIR' already exists and is not empty."
    echo "Choose a different question number or remove the directory first."
    exit 1
fi

# ── Create directory ──────────────────────────────────────────────────────────

mkdir -p "$QUESTION_DIR"

# ── Build the run-command block (only if a dataset was provided) ──────────────

if [ -n "$DATASET" ]; then
    RUN_BLOCK="### How to Run Your Solution

\`\`\`bash
duckdb ${DATASET} -f ${QUESTION_DIR}/answer.sql
\`\`\`"
else
    RUN_BLOCK="### How to Run Your Solution

\`\`\`bash
duckdb -f ${QUESTION_DIR}/answer.sql
\`\`\`"
fi

# ── question-statement.md ─────────────────────────────────────────────────────

cat > "${QUESTION_DIR}/question-statement.md" <<EOF
## Question ${QUESTION_NUMBER}: ${TITLE}

#### **Difficulty:** ${DIFFICULTY}

**Problem:**
<!-- Describe the problem here -->

**Your Objective:**
<!-- Describe what the student needs to write -->

-----

**Hints:**
<!-- Add hints or documentation links here, e.g.:
- [DuckDB docs](https://duckdb.org/docs/stable/)
-->

-----

${RUN_BLOCK}
EOF

# ── answer.sql ────────────────────────────────────────────────────────────────

cat > "${QUESTION_DIR}/answer.sql" <<EOF
-- Question ${QUESTION_NUMBER}: ${TITLE}
-- Write your SQL query below:

EOF

# ── solution.sql ──────────────────────────────────────────────────────────────

cat > "${QUESTION_DIR}/solution.sql" <<EOF
-- Question ${QUESTION_NUMBER}: ${TITLE}
-- Solution:

EOF

# ── Done ──────────────────────────────────────────────────────────────────────

echo ""
echo "✅ Question ${QUESTION_NUMBER} scaffolded successfully!"
echo ""
echo "   📁 ${QUESTION_DIR}/"
echo "   ├── question-statement.md  ← fill in the problem description"
echo "   ├── answer.sql             ← student writes their answer here"
echo "   └── solution.sql           ← add your solution here"
echo ""
echo "Next steps:"
echo "  1. Edit ${QUESTION_DIR}/question-statement.md"
echo "  2. Add your solution to ${QUESTION_DIR}/solution.sql"
echo "  3. Run: ./check.sh ${QUESTION_NUMBER}${DATASET:+ ${DATASET}}"
