#!/bin/bash

# --- DuckDB Answer Checker Script ---
# This script compares the output of a student's SQL answer
# with a provided solution using a persistent DuckDB database.

# Define the path to the DuckDB database file.
DATABASE_FILE=$2

# Check if a question number was provided as an argument.
if [ -z "$1" ]; then
    echo "Usage: $0 <question_number>"
    echo "Example: $0 1"
    exit 1
fi

# Store the question number from the first command-line argument.
QUESTION_NUMBER="$1"

# Define file paths for the student's answer and your solution.
ANSWER_FILE="questions/${QUESTION_NUMBER}/answer.sql"
SOLUTION_FILE="questions/${QUESTION_NUMBER}/solution.sql"

# --- Step 1: Validate that the required files exist. ---
if [ ! -f "$ANSWER_FILE" ]; then
    echo "Error: The answer file '${ANSWER_FILE}' does not exist."
    exit 1
fi

if [ ! -s "$answer_file" ] ; then
    echo "Error: The answer file '${ANSWER_FILE}' is empty."
    exit 1
fi

if [ ! -f "$SOLUTION_FILE" ]; then
    echo "Error: The solution file '${SOLUTION_FILE}' does not exist."
    exit 1
fi

# Check if the database file exists.
if [ ! -f "$DATABASE_FILE" ]; then
    echo "Error: The database file '${DATABASE_FILE}' does not exist."
    exit 1
fi

echo "Checking question #${QUESTION_NUMBER}..."

# --- Step 2: Run both SQL files and capture their output. ---
# The `-box` option ensures consistent, text-based output that is easy to compare.
# We redirect the output to temporary files.
# The database file path is now provided as the first argument to duckdb.
duckdb "${DATABASE_FILE}" -box -c ".read ${ANSWER_FILE}" > "temp_answer_output.txt"
duckdb "${DATABASE_FILE}" -box -c ".read ${SOLUTION_FILE}" > "temp_solution_output.txt"

# --- Step 3: Compare the two output files using `diff`. ---
# The `-q` flag for `diff` runs quietly, only reporting if the files differ.
# We store the exit code of `diff` to check for equality.
diff -q "temp_answer_output.txt" "temp_solution_output.txt" > /dev/null

# The special variable `$?` holds the exit code of the last command.
# `0` means the files are identical; `1` means they are different.
if [ $? -eq 0 ]; then
    echo "✅ Correct! Your answer matches the solution."
else
    echo "❌ Incorrect. The results do not match."
    echo ""
    echo "--- Differences ---"
    # To show the student where they went wrong, we run `diff` again without `-q`.
    diff "temp_answer_output.txt" "temp_solution_output.txt"
fi

# --- Step 4: Clean up temporary files. ---
rm "temp_answer_output.txt" "temp_solution_output.txt"