#!/bin/bash
# Post-edit linting hook for Claude Code
# Runs syntax/type checks after Edit or Write operations on Python/TypeScript files

# The tool input is passed via stdin as JSON
INPUT=$(cat)

# Extract the file path from the tool input
FILE_PATH=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('file_path',''))" 2>/dev/null)

if [ -z "$FILE_PATH" ] || [ ! -f "$FILE_PATH" ]; then
    exit 0
fi

EXT="${FILE_PATH##*.}"

case "$EXT" in
    py)
        # Python syntax check
        OUTPUT=$(python3 -m py_compile "$FILE_PATH" 2>&1)
        if [ $? -ne 0 ]; then
            echo "LINT WARNING: Python syntax error in $FILE_PATH"
            echo "$OUTPUT"
            exit 0
        fi
        ;;
    ts|tsx)
        # TypeScript check - only if tsconfig exists nearby
        DIR=$(dirname "$FILE_PATH")
        while [ "$DIR" != "/" ]; do
            if [ -f "$DIR/tsconfig.json" ]; then
                OUTPUT=$(cd "$DIR" && npx tsc --noEmit --pretty false "$FILE_PATH" 2>&1 | head -10)
                if [ $? -ne 0 ]; then
                    echo "LINT WARNING: TypeScript errors in $FILE_PATH"
                    echo "$OUTPUT"
                fi
                break
            fi
            DIR=$(dirname "$DIR")
        done
        ;;
esac

exit 0
