# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a personal website for Matt Manuel built using MkDocs with Material theme. The site is containerized with Docker and uses a multi-stage build process to generate static HTML from Markdown content and serve it via Nginx.

## Architecture

- **Content**: Markdown files in the `docs/` directory (currently just `index.md`)
- **Configuration**: `mkdocs.yml` configures the Material theme with hidden navigation
- **Build Process**: Multi-stage Docker build that uses Python Alpine to generate static files, then serves them via Nginx Alpine
- **Deployment**: Uses CapRover deployment system (configured via `captain-definition`)

## Development Commands

### Local Development
```bash
# Activate virtual environment
source .venv/bin/activate

# Install dependencies
pip3 install -r requirements.txt

# Serve locally with hot reload
mkdocs serve

# Build static site
mkdocs build
```

### Docker Operations
```bash
# Build Docker image
docker build -t mattmanuel-site .

# Run container locally
docker run -p 8080:80 mattmanuel-site
```

## Key Files

- `mkdocs.yml`: MkDocs configuration with Material theme
- `docs/index.md`: Main content file containing personal/professional information
- `Dockerfile`: Multi-stage build (Python for MkDocs build, Nginx for serving)
- `requirements.txt`: Python dependencies (mkdocs, mkdocs-material)
- `captain-definition`: CapRover deployment configuration
- `.env.example`: Environment variables template

## Content Structure

The site currently has a single page (`docs/index.md`) containing:
- Professional background and current roles
- Career history across major tech companies
- Personal projects and publications
- Social media and external links
- never add attribution to Claude in git commit messages nor pull request descriptions