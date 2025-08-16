QUESTION_NUMBER="$1"
DATABASE_FILE="$2"
if [ -z "$DATABASE_FILE" ]; then
    DATABASE_FILE="datasets/db.duckdb"
fi
if [ -z "$QUESTION_NUMBER" ]; then
    echo "Usage: $0 <question_number> [database_file]"
    echo "Example: $0 1 datasets/db.duckdb"
    exit 1
fi
duckdb ${DATABASE_FILE} -f "questions/${QUESTION_NUMBER}/answer.sql" 