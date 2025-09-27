#!/bin/bash

echo "🔗 Checking links in docs/*.md files..."

# Check if markdown-link-check is installed
if ! command -v markdown-link-check &> /dev/null; then
    echo "📦 markdown-link-check not found. Installing..."
    npm install -g markdown-link-check
fi

# Initialize exit code
exit_code=0

# Check links in all markdown files in docs directory
for file in docs/*.md; do
    if [ -f "$file" ]; then
        echo "🔍 Checking links in $file..."
        markdown-link-check "$file"
        if [ $? -ne 0 ]; then
            exit_code=1
        fi
    fi
done

if [ $exit_code -eq 0 ]; then
    echo "✅ All links are working!"
else
    echo "❌ Some links are broken. Please fix the issues above."
    exit 1
fi