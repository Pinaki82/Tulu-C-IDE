# Ollama AI on Linux

## A Comprehensive Setup Guide

This comprehensive guide walks you through setting up an offline AI environment on Linux using Ollama. While the instructions have been verified on Debian Bookworm, they should work on most Linux distributions with minimal adaptation.

## Setting Up [Ollama](https://ollama.com/)

### Installation

1. Install Ollama using the official installation script:
   
   ```bash
   curl -fsSL https://ollama.com/install.sh | sh
   ```

### Model Management

1. Download a recommended lightweight model:
   
   ```bash
   ollama pull phi3
   ```

**Important Notes:**

- Model files are stored in `/usr/share/ollama/.ollama/models`
- Configuration files are located in `$HOME/.ollama`
- The models' directory can be relocated using symbolic links (`sudo ln -s`)

### Server Management

Start the Ollama server:

```bash
ollama serve &
```

Verify the server status by visiting:

```
http://127.0.0.1:11434/
```

You should see the message "Ollama is running" if the setup is successful.

### Basic Command-Line Operations

Start an interactive session:

```bash
ollama run phi3
```

Common management commands:

```bash
ollama ps          # List running models
ollama stop phi3   # Stop a specific model
/bye              # Exit an interactive session
```

## Installing the Ollama UI

The Ollama UI provides a user-friendly web interface for interacting with your models.

### Setup Instructions

```bash
git clone https://github.com/ollama-ui/ollama-ui
cd ollama-ui
make
```

Access the UI at `http://127.0.0.1:8000/`

## System Integration

### Creating Launcher Scripts

1. Create a server startup script:
   
   ```bash
   #!/bin/sh
   cd /path/to/ollama-ui/
   make
   ```
   
   Save as: `$HOME/.local/share/applications/ollama-start-server.sh`

2. Create desktop entries for easy access:

**Server Launcher:**

```desktop
[Desktop Entry]
Type=Application
Name=Ollama-UI Server
Comment=A simple HTML UI for Ollama
Icon=xfce4-sample-plugin
Exec=/home/${USER}/.local/share/applications/ollama-start-server.sh
Terminal=true
Categories=Development;AI;
```

Save as: `$HOME/.local/share/applications/ollama-ui-server.desktop`

**UI Launcher:**

```desktop
[Desktop Entry]
Type=Application
Name=Ollama-UI (Browser)
Comment=A simple HTML UI for Ollama
Icon=xfce4-sample-plugin
Exec=firefox http://127.0.0.1:8000/
Terminal=false
Categories=Development;AI;
```

Save as: `$HOME/.local/share/applications/ollama-ui-firefox-browser.desktop`

Remember to make all scripts executable:

```bash
chmod +x $HOME/.local/share/applications/ollama-start-server.sh
chmod +x $HOME/.local/share/applications/ollama-ui-server.desktop
chmod +x $HOME/.local/share/applications/ollama-ui-firefox-browser.desktop
```

## Recommended Models

Several models are available depending on your needs:

- `hhao/qwen2.5-coder-tools:0.5b` - Specialised coding tools
- `qwen2.5:0.5b` - Balanced performance for general tasks
- `deepseek-r1:1.5b` - General purpose lightweight model
- `deepseek-coder:6.7b` - Comprehensive coding assistance
- `starling-lm` - Advanced language processing
- `mistral` - General purpose
- `llama2-uncensored` - General purpose
- `phi3` - General purpose lightweight model

## LibreOffice Integration

### LocalWriter

- Adds local AI inference capabilities
- Repository: [LocalWriter on GitHub](https://github.com/balisujohn/localwriter)

## Additional Resources

For detailed command reference, use:

```bash
ollama --help
```

## Troubleshooting

If you encounter issues:

1. Verify the Ollama server is running (`http://127.0.0.1:11434/`)
2. Check model status using `ollama ps`
3. Ensure proper file permissions for desktop entries and scripts
4. Confirm network accessibility for the UI (`http://127.0.0.1:8000/`)
