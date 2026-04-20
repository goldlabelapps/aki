# AKI

## Abgeschottet KI
### Ringfenced AI powered Document Management for SMEs

## Ollama and Phi-3: Local AI Models

This project uses [Ollama](https://ollama.com/) to run large language models (LLMs) locally, ensuring your data never leaves your machine. Ollama is an open-source tool that makes it easy to run and manage LLMs on your own hardware.

### What is Ollama?
Ollama is a platform for running open-source LLMs locally. It provides a simple way to download, run, and interact with models like Llama, Phi-3, and others, without sending data to external servers.

### What is Phi-3?
Phi-3 is a family of lightweight, high-performance language models developed by Microsoft. In this project, you can run Phi-3 locally using Ollama for private, fast, and secure AI-powered document management.

### How to Install Ollama and Phi-3

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

---

> This Private repo contains a Ring-Fenced environment which runs on a local LLM alongside a Node front & backend

```
[GIN] 2025/07/29 - 16:27:52 | 200 |          1m2s |       127.0.0.1 | POST     "/api/generate"
time=2025-07-29T16:28:09.214+02:00 level=WARN source=runner.go:128 msg="truncating input prompt" limit=4096 prompt=6280 keep=4 new=4096
```



#### Test Prompts

> Some simple propmts to try giving the LLM. Try these example prompts to see if AKI can give a sensible answer

Explain what machine learning weights are in simple terms

Wie könnten große Sprachmodelle deutschen Anwaltskanzleien bei der Recherche helfen?

What risks arise if companies send confidential files to a public AI service like ChatGPT?

### General legal reasoning

Erkläre in einfachen Worten, was das Berufsgeheimnis für deutsche Rechtsanwälte bedeutet.  

Explain in simple terms what professional secrecy means for German lawyers.



Welche Pflichten zur Vertraulichkeit haben deutsche Kanzleien gegenüber ihren Mandanten?  

What confidentiality obligations do firms have toward their clients?



Was bedeutet DSGVO für eine Anwaltskanzlei in Deutschland, die personenbezogene Daten verarbeitet?  

What does the GDPR mean for a law firm in Europe that processes personal data?

---

### AI in law

Wie könnten große Sprachmodelle deutschen Anwaltskanzleien bei der Recherche helfen?  

How could large language models help firms with legal research?



Welche Risiken entstehen, wenn Anwälte vertrauliche Akten an eine öffentliche KI wie ChatGPT schicken?  

What risks arise if lawyers send confidential files to a public AI service like ChatGPT?



Nenne Beispiele, wie KI den Arbeitsalltag in einer Kanzlei erleichtern könnte, ohne Mandantendaten zu gefährden.  

Give examples of how AI could make day‑to‑day work in a law firm easier without endangering client data.

### Ring‑fencing and compliance

Was bedeutet es technisch, ein LLM abzuschotten, damit keine Daten das interne Netzwerk verlassen?  

What does it technically mean to ring‑fence an LLM so that no data leaves the internal network?



Wie kann ein abgeschottetes LLM dabei helfen, die Geheimhaltungspflichten einer Kanzlei einzuhalten?  

How can a ring‑fenced LLM help a law firm meet its confidentiality obligations?



Wenn eine deutsche Kanzlei ein internes LLM einsetzt, welche rechtlichen Anforderungen müsste sie dabei beachten?  

If a German law firm uses an internal LLM, what legal requirements would it need to observe?

### Directly exploring the concern you raised

Hilft der Ansatz eines abgeschotteten LLMs dabei, die rechtlichen Herausforderungen von deutschen Kanzleien zu lösen, die Angst haben, dass ihre Mitarbeiter sensible Daten an externe KI-Dienste wie OpenAI schicken?  

Does the approach of using a ring‑fenced LLM help solve the legal challenges faced by German law firms that are afraid their employees might send sensitive data to external AI services like OpenAI?

Warum ist es für deutsche Kanzleien gefährlich, ein öffentliches LLM zu verwenden, und wie unterscheidet sich ein abgeschottetes LLM in diesem Punkt?  

Why is it dangerous for firms to use a public LLM, and how does a ring‑fenced LLM differ in this respect?



Welche organisatorischen Maßnahmen sollte eine Kanzlei ergänzend zu einem abgeschotteten LLM ergreifen, um Datenlecks zu verhindern?  

What organizational measures should a law firm take in addition to a ring‑fenced LLM to prevent data leaks?
