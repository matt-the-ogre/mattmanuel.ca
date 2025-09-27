#!/bin/bash

echo "🔍 Running markdown linter on docs/*.md files..."

# Check if markdownlint-cli is installed
if ! command -v markdownlint &> /dev/null; then
    echo "❌ markdownlint-cli not found. Installing..."
    npm install -g markdownlint-cli
fi

# Run markdownlint on all markdown files in docs directory
markdownlint docs/*.md

if [ $? -eq 0 ]; then
    echo "✅ All markdown files passed linting!"
else
    echo "❌ Markdown linting failed. Please fix the issues above."
    exit 1
fi