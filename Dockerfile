# syntax=docker/dockerfile:1

FROM node:20-bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    poppler-utils \
    tesseract-ocr \
    tesseract-ocr-deu \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN corepack enable

COPY package.json yarn.lock .yarnrc.yml* ./
COPY .yarn ./.yarn

RUN yarn install --immutable

COPY . .

EXPOSE 1975 4000

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
