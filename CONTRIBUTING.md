# Contributing to AKI

Thank you for your interest in contributing! Here's how to get started.

## Prerequisites

- Node.js 20 LTS or later
- Yarn 4 (Berry) — run `corepack enable` once to activate it
- Ollama with a model pulled (e.g. `ollama pull phi3`)
- poppler-utils (`pdftotext` / `pdftoppm`)

## Setting up the development environment

```bash
git clone https://github.com/goldlabelapps/aki.git
cd aki
corepack enable
yarn install
```

## Running in development mode

The fastest way to work on the project is to run the frontend and backend in
separate terminals so you get proper hot-reload for each.

**Terminal 1 — Ollama**
```bash
ollama serve
ollama run phi3
```

**Terminal 2 — Backend (TypeScript watch)**
```bash
yarn backend        # runs: cd aki-backend && yarn dev
```

**Terminal 3 — Frontend (Next.js watch)**
```bash
yarn frontend       # runs: cd aki-frontend && yarn dev
```

Or just run everything at once:
```bash
yarn start
```

## Project layout

```
aki-backend/src/
  lib/        shared helpers (database, header, endpoints)
  routes/
    db/       raw database inspection endpoints
    ki/       LLM summarisation endpoints
    log/      logging endpoints
    pdf/      upload / read / delete / rip / thumbnail
    test/     smoke-test endpoints

aki-frontend/src/
  app/        Next.js app-router pages
  gl-core/    Redux store, hooks, shared UI components
```

## Making changes

1. Fork the repository and create a feature branch from `main`:
   ```bash
   git checkout -b feat/my-feature
   ```
2. Make your changes with small, focused commits.
3. Ensure the TypeScript compiler is happy in both packages:
   ```bash
   cd aki-backend && yarn build
   cd ../aki-frontend && yarn build
   ```
4. Open a Pull Request against `main` with a clear description of what you
   changed and why.

## Code style

- TypeScript strict mode is enabled in both packages — keep it passing.
- Follow the existing file/folder conventions (one route per file, named exports).
- Keep comments concise; prefer self-documenting code.

## Reporting bugs

Please open a GitHub Issue with:
- Steps to reproduce
- Expected vs actual behaviour
- Your OS, Node version, and Ollama version

## Swapping the LLM model

The default model is `phi3`. To use a different one:

1. Pull it: `ollama pull <model-name>`
2. Update the `model` field in `aki-backend/src/routes/ki/summarise.ts`
3. Update the `yarn phi3` script in the root `package.json` (or add a new one)
4. Update `start.mjs` to call the new script

## License

By contributing you agree that your contributions will be licensed under the
[MIT License](./LICENSE).
