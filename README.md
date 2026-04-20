# AKI — Abgeschottet KI

> **Ringfenced AI-powered Document Management for SMEs**  
> Ask questions about your own documents. Everything runs locally — no data ever leaves your machine.

![AKI Screenshot](https://live.staticflickr.com/65535/54679640252_e024743596_o.jpg)

---

## What is AKI?

AKI is an open-source, privacy-first document assistant. Upload PDFs, extract their text, and ask an AI to summarise or answer questions about them — all powered by a local Large Language Model (LLM) via [Ollama](https://ollama.com). Your files and prompts never touch a third-party server.

**Key features**
- 📄 Upload and manage PDF documents
- 🔍 Automatic text extraction (native text layer + OCR fallback)
- 🤖 AI summarisation powered by a local LLM (phi3 by default)
- 🗄️ SQLite database — zero external database setup
- 🌐 Next.js frontend + Express backend — both written in TypeScript

---

## Architecture

```
Browser  ──►  Next.js frontend   (http://localhost:1975)
                    │
                    ▼
              Express backend    (http://localhost:4000)
                    │
          ┌─────────┴──────────┐
          │                    │
       SQLite (aki.db)    Ollama LLM     (http://localhost:11434)
```

---

## Prerequisites

| Tool | Version | Notes |
|------|---------|-------|
| [Node.js](https://nodejs.org) | 20 LTS or later | |
| [Yarn](https://yarnpkg.com) | 4.x (Berry) | Enabled via `corepack enable` |
| [Ollama](https://ollama.com) | latest | Runs the local LLM |
| [poppler-utils](https://poppler.freedesktop.org) | any | Provides `pdftotext` / `pdftoppm` |

### Install poppler-utils

```bash
# macOS
brew install poppler

# Ubuntu / Debian
sudo apt-get install poppler-utils

# Windows (via scoop)
scoop install poppler
```

---

## Quick Start

### 1. Clone the repository

```bash
git clone https://github.com/goldlabelapps/aki.git
cd aki
```

### 2. Install dependencies

```bash
corepack enable   # activates Yarn 4 from package.json#packageManager
yarn install
```

### 3. Install Ollama and pull the model

Download Ollama from <https://ollama.com/download>, then pull the default model:

```bash
ollama pull phi3
```

> **Tip:** You can swap to a different model by editing `start.mjs` and the
> model name in `aki-backend/src/routes/ki/summarise.ts`.

### 4. Start AKI

```bash
yarn start
```

This command starts four concurrent processes in your terminal:

| Process | What it does |
|---------|-------------|
| `ollama serve` | Runs the Ollama LLM server |
| `ollama run phi3` | Loads the phi3 model |
| Next.js dev server | Frontend on port **1975** |
| Express dev server | Backend API on port **4000** |

Your browser will open automatically at <http://localhost:1975/database/table/pdfs> after ~5 seconds.

---

## Running services individually

```bash
# Frontend only
yarn frontend

# Backend only
yarn backend

# Ollama server only
yarn ollama

# Backend TypeScript watch (hot-reload)
cd aki-backend && yarn dev

# Frontend Next.js watch
cd aki-frontend && yarn dev
```

---

## Docker (alternative setup)

If you prefer not to install Node.js and Yarn locally, use Docker Compose:

```bash
docker compose up --build
```

This builds a container for the Node.js app and starts an Ollama sidecar. Once running, pull the model inside the Ollama container:

```bash
docker compose exec ollama ollama pull phi3
```

Then open <http://localhost:1975/database/table/pdfs>.

> **GPU acceleration:** Add `deploy.resources.reservations.devices` to the
> `ollama` service in `docker-compose.yml` to pass through an NVIDIA GPU.

---

## Project structure

```
aki/
├── aki-backend/          # Express + TypeScript API
│   └── src/
│       ├── lib/          # Database helpers, shared utils
│       └── routes/       # /db  /ki  /log  /pdf  /test
├── aki-frontend/         # Next.js 15 + MUI frontend
│   └── src/
│       ├── app/          # Next.js app router pages
│       └── gl-core/      # Shared Redux store + UI primitives
├── aki.db.sql            # SQLite schema (no data)
├── start.mjs             # Cross-platform launcher
└── package.json          # Yarn workspaces root
```

---

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md) for guidelines on how to get involved.

---

## License

MIT — see [LICENSE](./LICENSE).

