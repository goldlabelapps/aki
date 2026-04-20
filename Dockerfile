# syntax=docker/dockerfile:1

# ── Build stage ──────────────────────────────────────────────────────────────
FROM node:20-bookworm-slim AS builder

# Install poppler-utils (pdftotext / pdftoppm) and other native deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    poppler-utils \
    tesseract-ocr \
    tesseract-ocr-deu \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Enable corepack so Yarn 4 (Berry) is available
RUN corepack enable

# Copy manifests first for better layer caching
COPY package.json yarn.lock .yarnrc.yml* ./
COPY .yarn ./.yarn
COPY aki-backend/package.json ./aki-backend/
COPY aki-frontend/package.json ./aki-frontend/

RUN yarn install --immutable

# Copy the rest of the source
COPY . .

# Build the TypeScript backend
RUN cd aki-backend && yarn build

# Build the Next.js frontend
RUN cd aki-frontend && yarn build

# ── Runtime stage ─────────────────────────────────────────────────────────────
FROM node:20-bookworm-slim AS runtime

RUN apt-get update && apt-get install -y --no-install-recommends \
    poppler-utils \
    tesseract-ocr \
    tesseract-ocr-deu \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN corepack enable

# Copy built artefacts and production dependencies
COPY --from=builder /app/package.json /app/yarn.lock ./
COPY --from=builder /app/.yarn ./.yarn
COPY --from=builder /app/aki-backend/package.json ./aki-backend/
COPY --from=builder /app/aki-frontend/package.json ./aki-frontend/
COPY --from=builder /app/aki-backend/dist ./aki-backend/dist
COPY --from=builder /app/aki-frontend/.next ./aki-frontend/.next
COPY --from=builder /app/aki-frontend/public ./aki-frontend/public
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/aki-backend/node_modules ./aki-backend/node_modules
COPY --from=builder /app/aki-frontend/node_modules ./aki-frontend/node_modules

# The database lives at the repo root (one level above aki-backend)
VOLUME ["/app/data"]
ENV AKI_DB_PATH=/app/data/aki.db

EXPOSE 1975 4000

# Start both servers via a simple shell script
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
