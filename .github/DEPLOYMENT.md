# CapRover Deployment Setup

This repository uses GitHub Actions to automatically deploy to CapRover when code is pushed to the main branch.

## Required Secrets

Configure these secrets in your GitHub repository settings (`Settings` → `Secrets and variables` → `Actions`):

### CAPROVER_APP_TOKEN
- **Description**: App-specific deployment token from CapRover
- **How to get**:
  1. Log into your CapRover dashboard at https://captain.mattmanuel.ca
  2. Go to Apps → `www` → Deployment tab
  3. Enable "App Token" and copy the generated token
  4. Add this token as `CAPROVER_APP_TOKEN` in GitHub secrets

### CAPROVER_PASSWORD (Alternative)
- **Description**: Your CapRover admin password (less secure than app token)
- **Usage**: Only use if app token method doesn't work
- **How to get**: This is your CapRover admin login password

## Deployment Workflow

The workflow (`deploy-caprover.yml`) will:

1. **Trigger**: Automatically on pushes to `main` branch, or manually via GitHub Actions UI
2. **Validate**: Check that required secrets and files are present
3. **Deploy**: Use the official CapRover GitHub Action to deploy your Dockerized MkDocs site
4. **Verify**: Confirm deployment success and log relevant information
5. **Notify**: Log detailed error information if deployment fails

## App Configuration

- **App Name**: `www`
- **CapRover URL**: `https://captain.mattmanuel.ca`
- **Deployment Method**: Docker (using multi-stage build)

## Troubleshooting

### Common Issues

1. **Invalid app token**: Regenerate the app token in CapRover and update the GitHub secret
2. **App not found**: Ensure the app name `www` exists in your CapRover instance
3. **Docker build failures**: Check that your Dockerfile builds successfully locally
4. **captain-definition errors**: Validate JSON syntax in the captain-definition file

### Manual Deployment

If automated deployment fails, you can deploy manually:

```bash
# Install CapRover CLI
npm install -g caprover

# Deploy manually
caprover deploy --caproverUrl https://captain.mattmanuel.ca --appName www
```

### Monitoring

- Check deployment status in GitHub Actions tab
- Monitor app health in CapRover dashboard
- Review nginx logs in CapRover if the site isn't loading properly

## Security Best Practices

- Use app tokens instead of admin passwords when possible
- Regularly rotate deployment tokens
- Monitor deployment logs for any suspicious activity
- Keep CapRover and dependencies updated