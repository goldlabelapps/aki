
## AKI° Abgeschottete künstliche Intelligenz (Air-gapped AI)

AKI° is an open-source document assistant designed to help comply with legal and regulatory requirements when working with sensitive documents. 

By running all AI processing locally, AKI° ensures that confidential files and prompts never leave your device—helping you avoid accidental data leaks and stay on the right side of the law (e.g., GDPR, attorney-client privilege, or other professional secrecy obligations). 

Upload PDFs, extract their text, and ask an AI to summarise or answer questions about them—all powered by a local Large Language Model (LLM) via [Ollama](https://ollama.com).

#### Ollama and Phi-3: Local AI Models

This project uses [Ollama](https://ollama.com/) to run large language models (LLMs) locally, ensuring your data never leaves your machine. Ollama is an open-source tool that lets you run and manage LLMs on your own device.

#### What is Ollama?

Ollama is a platform for running open-source LLMs locally. It provides a simple way to download, run, and interact with models like Llama, Phi-3, and others, without sending data to external servers.

#### What is Phi-3?

Phi-3 is a family of lightweight, high-performance language models developed by Microsoft. In this project, you can run Phi-3 locally using Ollama for private, fast, and secure AI-powered document management.

#### How to Install Ollama and Phi-3

1. **Install Ollama**
	- Visit [https://ollama.com/download](https://ollama.com/download) and download the installer for your operating system (macOS, Windows, or Linux).
	- Follow the installation instructions on the website.

2. **Start the Ollama server**
	- In your terminal, run:
	  ```sh
	  ollama serve
	  ```

3. **Download and run the Phi-3 model**
	- In your terminal, run:
	  ```sh
	  ollama run phi3
	  ```
	- This will download the Phi-3 model and start it locally.

4. **(Optional) Run other models**
	- You can also run other models like CodeLlama:
	  ```sh
	  ollama run codellama
	  ```

**Note:** The `package.json` includes scripts to start Ollama and run these models for convenience.

#### Test Prompts

> Some simple propmts to try giving the LLM. See if AKI can give a sensible answer

Explain what machine learning weights are in simple terms

Wie könnten große Sprachmodelle deutschen Anwaltskanzleien bei der Recherche helfen?



#### General legal reasoning

What does the GDPR mean for a law firm in Europe that processes personal data?

What risks arise if companies send confidential files to a public AI service like ChatGPT?

Erkläre in einfachen Worten, was das Berufsgeheimnis für deutsche Rechtsanwälte bedeutet.  

Explain in simple terms what professional secrecy means for UK lawyers.

Welche Pflichten zur Vertraulichkeit haben deutsche Kanzleien gegenüber ihren Mandanten?  

What confidentiality obligations do firms have toward their clients?

Was bedeutet DSGVO für eine Anwaltskanzlei in Deutschland, die personenbezogene Daten verarbeitet?  



#### Features

- 📄 Upload and manage PDF documents
- 🔍 Automatic text extraction (native text layer + OCR fallback)
- 🤖 AI summarisation powered by a local LLM (phi3 by default)
- 🗄️ SQLite database — zero external database setup
- 🌐 TypeScript Next.js frontend + Express backend

#### Architecture

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

### 4. Start AKI°

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

