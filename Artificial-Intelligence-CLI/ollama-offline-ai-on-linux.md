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

**Model Storage and Backup Guidelines**

The Ollama models are stored in one of the following locations:

- `/usr/share/ollama/.ollama/models`
- `$HOME/.ollama/models`

Configuration files are stored in `$HOME/.ollama`. To create a backup of the models, use `tar` to compress the `models` directory:

```bash
sudo tar -cvf '/mnt/hdd/backup/models.tar' '/usr/share/ollama/.ollama/models'
```

or

```bash
tar -cvf '/mnt/hdd/backup/models.tar' '$HOME/.ollama/models'
```

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

## A better approach.

### config.ini

```ini
[Paths]
ollama-ui-path = /mnt/hdd2/PortablePrograms/ollama-ui/
make-command = make

[Browser]
browser-command = firefox
# Alternatives (not tested with):
# browser-command = brave-browser
# browser-command = microsoft-edge
url = http://127.0.0.1:8000/
```

### ollama_runner.c

```c
// Last Change: 2025-01-29  Wednesday: 05:51:57 PM

/*
   Program Description:
   This program is a wrapper for Ollama and Ollama-UI.
   It allows you to run Ollama and Ollama-UI in the background.
   It also opens an intuitive webpage in your browser.
*/

/*
  Assisted by Ollama: qwen2.5-coder:3b
  Minor glitches were ironed out by Anthropic Claude Sonnet 2025.01.29
*/

/*
  Installation:
  BASH Shell:
    Open $HOME/.bashrc or $HOME/.bash_aliases with a text editor and
    paste the following line in the beginning:
      export PATH="$HOME/.local/bin/:$PATH"

  Run: source $HOME/.bashrc && source $HOME/.bash_aliases to reload the configuration.

  Fish Shell:
    Open $HOME/.config/fish/config.fish with a text editor and
    paste the following lines in the beginning:
      # --------------
      # $HOME/.local/bin
      export PATH="$HOME/.local/bin/:$PATH"
      export PATH
      # --------------
      Run: source $HOME/.config/fish/config.fish to reload the configuration.

  Now, compile this program:
    gcc -g -Wall -Wextra -pedantic -fstack-protector-all ollama_runner.c -o ollama_runner -s
  Run the commands given below.

  install -m +x ollama_runner $HOME/.local/bin
  mkdir -p $HOME/.config/ollama_runner && cp config.ini $HOME/.config/ollama_runner
  To start Ollama and Ollam-UI, type ollama_runner. The URL will also open in Firefox.
*/

// Restrict to UNIX-like systems only
#if !( defined( __unix__ ) || defined(_POSIX_VERSION) )
  #error "For UNIX-like Operating Systems Only"
#endif

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h> // chdir()
#include <ctype.h>   // isspace()

#define  _POSIX_C_SOURCE 200809L
#define  _XOPEN_SOURCE 500L

#define MAX_LINE_LENGTH 256
#define MAX_CMD_LENGTH 1024
#define PATH_MAX 1024

void enter_config_path(void);
void execute_command(const char *command);
void launch_browser(const char *browser_command, const char *url);

// Function to enter $HOME/.config/olama_runner to load configuration from a specified file, config.ini
void enter_config_path(void) {
  // Get home directory
  const char *home_dir = getenv("HOME");

  if(!home_dir) {
    fprintf(stderr, "Failed to get home directory\n");
    exit(EXIT_FAILURE);
  }

  // Construct the full config path
  char config_path[PATH_MAX];
  snprintf(config_path, sizeof(config_path), "%s/.config/ollama_runner", home_dir);
  // Create a directory using mkdir with system() (this is fine as it's not about changing dirs)
  char mkdir_cmd[MAX_CMD_LENGTH];
  snprintf(mkdir_cmd, sizeof(mkdir_cmd) + 2048, "mkdir -p %s", config_path);
  system(mkdir_cmd);

  // Change to the config directory using chdir()
  if(chdir(config_path) != 0) {
    fprintf(stderr, "Failed to change to config directory: %s\n", config_path);
    exit(EXIT_FAILURE);
  }

  // Verify config.ini exists
  if(access("config.ini", F_OK) != 0) {
    fprintf(stderr, "No config file found in %s\n", config_path);
    exit(EXIT_FAILURE);
  }

  // Print current working directory for verification
  char cwd[PATH_MAX];

  if(getcwd(cwd, sizeof(cwd)) != NULL) {
    printf("Current working directory: %s\n", cwd);
  }
}

typedef struct {
  char *ollama_ui_path;
  char *make_command;
  char *browser_command;
  char *url;
} Config;

Config load_config(const char *filename) {
  void enter_config_path(void);
  FILE *file = fopen(filename, "r");

  if(!file) {
    perror("Failed to open config file");
    exit(EXIT_FAILURE);
  }

  Config config = {NULL, NULL, NULL, NULL}; // Initialise all pointers to NULL
  char line[MAX_LINE_LENGTH];
  int section = -1;

  while(fgets(line, sizeof(line), file)) {
    // Trim trailing newline
    char *newline = strchr(line, '\n');

    if(newline) {
      *newline = '\0';
    }

    // Skip empty lines and comments
    if(line[0] == '#' || line[0] == '\0') {
      continue;
    }

    // Determine the section
    if(!strcmp(line, "[Paths]")) {
      section = 1;
      continue;
    }

    else if(!strcmp(line, "[Browser]")) {
      section = 2;
      continue;
    }

    // Parse the key-value pairs
    char *key = line;
    char *value = strchr(line, '=');

    if(!value) {
      fprintf(stderr, "Invalid format in config file: missing '=' in line: %s\n", line);
      fclose(file);
      exit(EXIT_FAILURE);
    }

    // Split key and value
    *value = '\0';  // Terminate key string
    value++;        // Move to start of value

    // Trim whitespace from key and value
    while(isspace(*key)) {
      key++;
    }

    while(isspace(*value)) {
      value++;
    }

    char *end = key + strlen(key) - 1;

    while(end > key && isspace(*end)) {
      *end-- = '\0';
    }

    end = value + strlen(value) - 1;

    while(end > value && isspace(*end)) {
      *end-- = '\0';
    }

    // Assign values to the configuration structure
    if(section == 1) {
      if(!strcmp(key, "ollama-ui-path")) {
        config.ollama_ui_path = strdup(value);

        if(!config.ollama_ui_path) {
          fprintf(stderr, "Memory allocation failed for ollama-ui-path\n");
          fclose(file);
          exit(EXIT_FAILURE);
        }

        // Check if directory exists
        if(access(config.ollama_ui_path, F_OK) != 0) {
          fprintf(stderr, "Invalid ollama-ui-path: No such file or directory: %s\n", config.ollama_ui_path);
          free(config.ollama_ui_path);
          fclose(file);
          exit(EXIT_FAILURE);
        }
      }

      else if(!strcmp(key, "make-command")) {
        config.make_command = strdup(value);

        if(!config.make_command) {
          fprintf(stderr, "Memory allocation failed for make-command\n");
          fclose(file);
          exit(EXIT_FAILURE);
        }
      }
    }

    else if(section == 2) {
      if(!strcmp(key, "browser-command")) {
        config.browser_command = strdup(value);

        if(!config.browser_command) {
          fprintf(stderr, "Memory allocation failed for browser-command\n");
          fclose(file);
          exit(EXIT_FAILURE);
        }
      }

      else if(!strcmp(key, "url")) {
        config.url = strdup(value);

        if(!config.url) {
          fprintf(stderr, "Memory allocation failed for url\n");
          fclose(file);
          exit(EXIT_FAILURE);
        }
      }
    }
  }

  // Verify all required fields are set
  if(!config.ollama_ui_path || !config.make_command ||
     !config.browser_command || !config.url) {
    fprintf(stderr, "Missing required configuration fields\n");
    fclose(file);
    exit(EXIT_FAILURE);
  }

  fclose(file);
  return config;
}

void execute_command(const char *command) {
  char background_cmd[MAX_CMD_LENGTH];
  snprintf(background_cmd, sizeof(background_cmd), "%s &", command);

  if(system(background_cmd)) {
    perror("Failed to execute command");
    exit(EXIT_FAILURE);
  }
}

void launch_browser(const char *browser_command, const char *url) {
  char browser_cmd[MAX_CMD_LENGTH];
#ifdef __linux__
  // On Linux, use nohup to detach the browser process
  snprintf(browser_cmd, sizeof(browser_cmd),
           "nohup %s %s > /dev/null 2>&1 &",
           browser_command, url);
#elif __APPLE__
  // On macOS, use open command
  snprintf(browser_cmd, sizeof(browser_cmd),
           "open -a \"%s\" %s",
           browser_command, url);
#else
  // Default fallback
  snprintf(browser_cmd, sizeof(browser_cmd),
           "%s %s &",
           browser_command, url);
#endif

  if(system(browser_cmd) == -1) {
    fprintf(stderr, "Failed to launch browser: %s\n", browser_cmd);
    // Don't exit on browser launch failure - the server might still be running
  }
}

int main() {
  enter_config_path();
  Config config = load_config("config.ini");

  // Change directory
  if(chdir(config.ollama_ui_path)) {
    perror("Failed to change directory");
    return EXIT_FAILURE;
  }

  // Execute make command
  execute_command(config.make_command);
  // Small delay to allow make to start
  sleep(1);
  // Launch browser in background
  launch_browser(config.browser_command, config.url);
  // Clean up allocated memory
  free(config.ollama_ui_path);
  free(config.make_command);
  free(config.browser_command);
  free(config.url);
  return EXIT_SUCCESS;
}
```

### ollama_runner.desktop

```desktop
[Desktop Entry]
Type=Application
Name=Ollama-UI-wrapper (Firefox Browser)
Comment=A simple wrapper for Ollama and Ollama-UI. Also opens an intuitive webpage in Firefox.
Icon=xfce4-sample-plugin
Exec=sh -c "exec $HOME/.local/bin/ollama_runner"
#  The `sh -c "exec $HOME/..."` trick is a common and effective way to handle environment variables and path issues in .desktop files. (Google Gemini)
Terminal=false
Categories=;
```

The code can be found in the [ollama_runner.zip](https://github.com/Pinaki82/Tulu-C-IDE/tree/main/Artificial-Intelligence-CLI/ollama_runner.zip) archive.
