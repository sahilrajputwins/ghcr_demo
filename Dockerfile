FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
# Install exact versions from lock-file and prune dev-deps
RUN npm ci --only=production
# Copy application source
COPY server.js .


FROM alpine:3.19

# Install runtime essentials
RUN apk add --no-cache \
        nodejs-current \
        nginx && \
    mkdir -p /usr/share/nginx/html /var/run/nginx

# ---- Static frontend ----
COPY public/ /usr/share/nginx/html/

# ---- Nginx configuration ----
COPY nginx.conf /etc/nginx/nginx.conf

# ---- Node server + node_modules from builder ----
COPY --from=builder /app /app
WORKDIR /app

EXPOSE 80

# ---- Launch Node (port 8080) and Nginx (port 80) ----
CMD ["sh", "-c", "node server.js & nginx -g 'daemon off;'"]
