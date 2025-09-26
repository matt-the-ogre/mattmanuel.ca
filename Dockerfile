# ---- build stage ----
FROM python:3.12-alpine AS build

# Install build dependencies
RUN apk add --no-cache git

# Install Python packages
WORKDIR /src
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . /src
RUN mkdocs build --site-dir /out --strict

# ---- run stage ----
FROM nginx:alpine

# Enhanced nginx configuration
RUN rm -rf /usr/share/nginx/html/* && \
    printf 'server { \
      listen 80; \
      server_name _; \
      root /usr/share/nginx/html; \
      index index.html; \
      \
      # Gzip compression \
      gzip on; \
      gzip_vary on; \
      gzip_min_length 1024; \
      gzip_types text/css application/javascript application/json image/svg+xml text/plain text/xml application/xml+rss text/javascript; \
      \
      # Security headers \
      add_header X-Frame-Options "SAMEORIGIN" always; \
      add_header X-Content-Type-Options "nosniff" always; \
      add_header Referrer-Policy "strict-origin-when-cross-origin" always; \
      \
      # Cache control \
      location ~* \.(css|js|png|jpg|jpeg|gif|ico|svg)$ { \
        expires 1y; \
        add_header Cache-Control "public, immutable"; \
      } \
      \
      location / { \
        try_files $uri $uri/ /index.html; \
        add_header Cache-Control "public, max-age=300"; \
      } \
    }' > /etc/nginx/conf.d/default.conf

COPY --from=build /out /usr/share/nginx/html
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost/ || exit 1