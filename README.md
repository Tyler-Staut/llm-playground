# llm-playground

A simple Docker stack for tinkering with free tier LLMs.  
Spin it up, paste in some API keys, and start chatting.

> **NOTE:** copy `.env.example` to `.env` and fill in any provider keys before launching. See `Makefile` for helper commands.

## What's inside

| Service | URL | Purpose |
|---|---|---|
| **OpenWebUI** | http://localhost:3000 | Chat UI |
| **LiteLLM UI** | http://localhost:4000/ui | Model & key management |
| **Open Terminal Docs** | http://localhost:8080/docs | Interactive API explorer |
| **Postgres** | internal | LiteLLM state/logging |

## Free model providers included

| Provider | Free tier | Sign-up |
|---|---|---|
| **NVIDIA NIM** | Several large models | https://build.nvidia.com |
| **OpenRouter** | 10+ models with `:free` suffix | https://openrouter.ai |
| **Google Gemini** | Gemini Flash (generous limits) | https://aistudio.google.com |
| **Ollama** | Fully local, no API key | *(optional, see below)* |

## Quick start

```bash
# 1. Clone
git clone https://github.com/Tyler-Staut/llm-playground.git
cd llm-playground

# 2. Configure
make setup        # copies .env.example if needed
# edit .env and add at least one API key

# 3. Launch
make up           # or: docker compose up -d

# 4. Open
open http://localhost:3000
```

On first launch, OpenWebUI will ask you to create an admin account.  
The model list is pulled automatically from LiteLLM and you should see all configured models in the model selector.
Feel free to make additional changes in OpenWebUI to add search and other capabilities!

## LiteLLM UI

The LiteLLM proxy ships with a management UI at http://localhost:4000/ui
Log in with the credentials set in your `.env` (`LITELLM_MASTER_KEY`, defaults: `admin` / `playground`).  
From there you can add virtual keys, view usage, and manage models without touching config files.

## Adding / removing models

Edit in the ui at http://localhost:4000/ui if you have postgres set up which is easiest however I have prepared some in the config.
Edit `litellm/config.yaml`. Each entry is a `model_name` (display name) + `litellm_params` block.  
Restart LiteLLM after changes:

```bash
docker compose restart litellm
```

See the full provider list at https://docs.litellm.ai/docs/providers.

## Optional: Ollama (local models)

Want to run models locally? You'll need:
- A reasonably capable machine (8 GB+ RAM for small models, GPU recommended)
- [nvidia-container-toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html) for GPU passthrough

Steps:
1. Uncomment the `ollama` service block in `docker-compose.yml`
2. Uncomment the `ollama_data` volume at the top of the same file
3. Uncomment the Ollama model entry in `litellm/config.yaml`
4. `docker compose up -d`
5. Pull a model: `docker exec playground-ollama ollama pull llama3.2`

## Stack

- [OpenWebUI](https://github.com/open-webui/open-webui)
- [LiteLLM](https://github.com/BerriAI/litellm)
- [Open Terminal](https://github.com/open-webui/open-terminal)
- [PostgreSQL](https://www.postgresql.org/)
- [Ollama](https://ollama.com/) *(optional)*

## License

MIT