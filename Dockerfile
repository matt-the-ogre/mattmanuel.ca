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
FROM python:3.12-alpine

WORKDIR /app
COPY --from=build /out ./static
EXPOSE 8000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8000/ || exit 1

CMD ["python", "-m", "http.server", "8000", "--directory", "static", "--bind", "0.0.0.0"]