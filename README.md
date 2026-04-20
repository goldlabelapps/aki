## AKI° Abgeschottete künstliche Intelligenz (Air-gapped AI)

AKI° is an Open Source document assistant designed to help comply with legal and regulatory requirements when working with sensitive documents. 

By running all AI processing locally, AKI° ensures that confidential files and prompts never leave your device—helping you avoid accidental data leaks and stay on the right side of the law (e.g., GDPR, attorney/client privilege, or other professional secrecy obligations). 


#### Local AI Models

This project uses [Ollama](https://ollama.com/) to run large language models (LLMs) locally, ensuring your data never leaves your machine. Ollama is an open-source tool that lets you run and manage LLMs on your own device.

#### Ollama

Ollama is a platform for running open-source LLMs locally. It provides a simple way to download, run, and interact with models like Llama, Phi-3, and others, without sending data to external servers.

#### Phi-3

[Phi-3](https://azure.microsoft.com/en-us/blog/introducing-phi-3-redefining-whats-possible-with-slms/) is a family of lightweight, high-performance language models developed by Microsoft. In this project, you can run Phi-3 locally using Ollama for private, fast, and secure AI-powered document management.

Many other LLMs, both free and expensive are available.

#### Prerequisites

| Tool | Version | Notes |
|------|---------|-------|
| [Node.js](https://nodejs.org) | 20 LTS or later | |
| [Yarn](https://yarnpkg.com) | 4.x (Berry) | Enabled via `corepack enable` |
| [Ollama](https://ollama.com) | latest | Runs the local LLM |

#### Install Ollama with Phi-3

1. **Install Ollama**
	- Visit [https://ollama.com/download](https://ollama.com/download) and download the installer for your operating system (macOS, Windows, or Linux).
	- Follow the installation instructions on the website, but command line is best

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
	- You can also run other models for instance CodeLlama:
	  ```sh
	  ollama run codellama
	  ```

**Note:** `package.json` includes scripts to start Ollama and run these models for convenience.

1. Clone the repository

```bash
git clone https://github.com/goldlabelapps/aki.git
cd aki
```

2. Install dependencies

```bash
corepack enable   # activates Yarn 4 from package.json#packageManager
yarn install
```

3. Install Ollama and pull the model

Download Ollama from <https://ollama.com/download>, then pull the default model:

```bash
ollama pull phi3
```

4. Start AKI°

This command starts the Ollama LLM server and loads the phi3 model.

```bash
yarn start
```

#### Test Prompts

> Simple cut+paste propmts to try. See if AKI° can give a sensible answer

Explain what machine learning weights which make LLM's work are in kindergarten terms

Wie könnten große Sprachmodelle deutschen Anwaltskanzleien bei der Recherche helfen?

What does the GDPR mean for a law firm in Europe that processes personal data?

What risks arise if companies send confidential files to a public AI service like ChatGPT?

Erkläre in einfachen Worten, was das Berufsgeheimnis für deutsche Rechtsanwälte bedeutet. 

Explain in simple terms what professional secrecy means for UK lawyers.

What confidentiality obligations do firms have toward their clients?

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md) for guidelines on how to get involved.

## License

MIT — see [LICENSE](./LICENSE).

