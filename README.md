# Matt Manuel's Personal Website

A clean, minimal personal website built with MkDocs and Material theme, deployed on CapRover.

🌐 **Live Site**: [www.mattmanuel.ca](https://www.mattmanuel.ca)

## Features

- **Fast & Lightweight**: Static site generation with MkDocs
- **Modern Design**: Material Design theme with clean typography
- **Containerized**: Docker-based deployment with multi-stage builds
- **Auto-Deploy**: CapRover integration for seamless deployments
- **Responsive**: Mobile-friendly design

## Tech Stack

- **Framework**: [MkDocs](https://www.mkdocs.org/) with [Material theme](https://squidfunk.github.io/mkdocs-material/)
- **Containerization**: Docker with Python Alpine base
- **Deployment**: [CapRover](https://caprover.com/) PaaS
- **Hosting**: Self-hosted on DigitalOcean

## Architecture

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   docs/         │    │   Docker         │    │   CapRover      │
│   └── index.md  │───▶│   Multi-stage    │───▶│   captain.      │
│   mkdocs.yml    │    │   Build          │    │   mattmanuel.ca │
└─────────────────┘    └──────────────────┘    └─────────────────┘
```

### Docker Build Process

1. **Build Stage**: Python Alpine container builds MkDocs site
2. **Runtime Stage**: Lightweight Python HTTP server serves static files
3. **Health Check**: Ensures container is healthy before traffic routing

## Quick Start

### Local Development

```bash
# Clone the repository
git clone https://github.com/mattmanuel/mattmanuel.ca.git
cd mattmanuel.ca

# Set up Python environment
python3 -m venv .venv
source .venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Serve locally with hot reload
mkdocs serve
# Visit http://localhost:8000
```

### Docker Development

```bash
# Build the Docker image
docker build -t mattmanuel-site .

# Run locally
docker run -p 8080:8000 mattmanuel-site
# Visit http://localhost:8080
```

## Deployment

The site auto-deploys to CapRover when changes are pushed to the main branch.

### Manual Deployment

```bash
# Deploy to CapRover
caprover deploy --caproverUrl https://captain.mattmanuel.ca --appName www --branch main
```

### CapRover Configuration

- **Container Port**: 8000
- **Memory Limit**: 128MB
- **CPU Limit**: 0.25 cores
- **Health Check**: HTTP check on port 8000
- **SSL**: Auto-managed Let's Encrypt certificates

## Project Structure

```
mattmanuel.ca/
├── docs/
│   └── index.md           # Main content
├── scripts/
│   └── deploy-captain.sh  # Deployment script
├── captain-definition     # CapRover config
├── Dockerfile            # Multi-stage Docker build
├── mkdocs.yml            # MkDocs configuration
├── requirements.txt      # Python dependencies
├── CLAUDE.md            # AI assistant guidance
└── README.md            # This file
```

## Key Design Decisions

### Why Python HTTP Server over Nginx?

- **Simplicity**: Single base image (Python Alpine) vs multi-stage with Nginx
- **Sufficient Performance**: Personal website doesn't need Nginx's advanced features
- **Easier Debugging**: Simpler container structure for troubleshooting
- **Smaller Attack Surface**: Fewer components to maintain and secure

### Why CapRover?

- **Self-hosted**: Full control over infrastructure
- **Docker-native**: Perfect fit for containerized applications
- **Auto-SSL**: Automatic Let's Encrypt certificate management
- **Simple Deployments**: Git-based deployment workflow

## Content Management

Content is written in Markdown and stored in the `docs/` directory. The main page (`docs/index.md`) contains:

- Professional background and current roles
- Career history and achievements
- Personal projects and publications
- Contact information and social links

## Performance

- **Build Time**: ~2-3 seconds for MkDocs generation
- **Image Size**: ~50MB (Python Alpine + static files)
- **Load Time**: <1 second (static files + CDN)
- **Health Check**: 30-second intervals with 3-retry tolerance

## Troubleshooting

### Common Issues

1. **502 Bad Gateway**: Check container health and port configuration
2. **Build Failures**: Verify all dependencies in `requirements.txt`
3. **SSL Issues**: Ensure DNS is properly configured for domain

### Debugging Commands

```bash
# Check CapRover app logs
# (Access via CapRover dashboard at captain.mattmanuel.ca)

# Test container locally
docker run -p 8080:8000 mattmanuel-site
curl http://localhost:8080

# Health check test
docker exec <container> wget --spider http://127.0.0.1:8000/
```

## Contributing

This is a personal website, but suggestions and improvements are welcome:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test locally with Docker
5. Submit a pull request

## License

This project is open source and available under the [MIT License](LICENSE).

---

Built with ❤️ using MkDocs, Docker, and CapRover