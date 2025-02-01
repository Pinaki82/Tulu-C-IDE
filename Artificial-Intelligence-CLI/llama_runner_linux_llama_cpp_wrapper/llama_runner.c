// Last Change: 2025-02-01  Saturday: 08:48:07 PM

/*
   Program Description:
   This program is a wrapper for llama.cpp CLI and server.
   It allows you to run llama.cpp CLI and server in the background.
   It also opens an intuitive webpage in your browser.
*/

/*
  Assisted by Kimi: 2025.02.01
  https://kimi.moonshot.cn
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
    gcc -g -Wall -Wextra -pedantic -fstack-protector-all -O2 llama_runner.c -o llama_runner -s
  Run the commands given below.

  install -m +x llama_runner $HOME/.local/bin
  mkdir -p $HOME/.config/llama_runner && cp llama_runner.ini $HOME/.config/llama_runner
  To start llama.cpp CLI and server, type llama_runner.
*/

/*
   Llama.cpp homepage: https://github.com/ggerganov/llama.cpp
   Installation instructions: https://github.com/ggerganov/llama.cpp/blob/master/docs/build.md

   Dependencies:
   - Install OpenBLAS library:
     sudo apt install libopenblas-dev

   Build instructions:
   - Enable BLAS support with OpenBLAS:
     cmake -B build -DGGML_BLAS=ON -DGGML_BLAS_VENDOR=OpenBLAS
   - Build the project in Release mode with 4 parallel jobs:
     cmake --build build --config Release -j 4

   Basic CLI chat server:
   - Start the llama-server with a model and specify the port:
     llama-server -m model.gguf --port 8080

   Accessing the server:
   - Basic web UI can be accessed via browser: http://localhost:8080
   - Chat completion endpoint: http://localhost:8080/v1/chat/completions

   Server and browser examples:
   - Example 1: Start the server with a specific model:
     ./llama-server -m '/mnt/hdd2/LmStudio/models/Qwen/Qwen2.5-0.5B-Instruct-GGUF/qwen2.5-0.5b-instruct-q4_0.gguf' --port 8080
   - Example 2: Start the server with another model:
     ./llama-server -m '/mnt/hdd2/LmStudio/models/SandLogicTechnologies/DeepSeek-R1-Distill-Qwen-1.5B-GGUF/DeepSeek-R1-Distill-Qwen-1.5B-Q4_K_M.gguf' --port 8080

   One-liner command to start the server:
   - sh -c "cd '/mnt/hdd2/llama.cpp/build/bin/' && ./llama-server -m '/mnt/hdd2/LmStudio/models/Qwen/Qwen2.5-0.5B-Instruct-GGUF/qwen2.5-0.5b-instruct-q4_0.gguf' --port 8080"

   Autocompletion example:
   - Use llama-cli for text completion:
     ./llama-cli -m '/mnt/hdd2/LmStudio/models/Qwen/Qwen2.5-0.5B-Instruct-GGUF/qwen2.5-0.5b-instruct-q4_0.gguf' -p "Any advice or suggestion will be very" -n 7 -no-cnv
*/

// Restrict to UNIX-like systems only
#if !( defined( __unix__ ) || defined(_POSIX_VERSION) )
  #error "For UNIX-like Operating Systems Only"
#endif

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h> // chdir(), system()
#include <ctype.h>   // isspace()
#include <sys/types.h>
#include <sys/wait.h>
#include <signal.h>

#define  _POSIX_C_SOURCE 200809L
#define  _XOPEN_SOURCE 500L

#define MAX_LINE_LENGTH 256
#define MAX_CMD_LENGTH 1024
#define PATH_MAX 1024
#define MAX_MODELS 16
#define MEMORYBUFFEREXTRA 1024

typedef struct {
  char *llama_cpp_bin_path;
  char *model_paths[MAX_MODELS];
  char *browser_command;
  char *port;
} Config;

void enter_config_path(void);
Config load_config(const char *filename);
void execute_command(const char *command);
void launch_browser(const char *browser_command, const char *url);
void kill_existing_processes(const char *process_name);

void enter_config_path(void) {
  const char *home_dir = getenv("HOME");

  if(!home_dir) {
    fprintf(stderr, "Failed to get home directory\n");
    exit(EXIT_FAILURE);
  }

  char config_path[PATH_MAX];
  snprintf(config_path, sizeof(config_path), "%s/.config/llama_runner", home_dir);
  char mkdir_cmd[MAX_CMD_LENGTH];
  snprintf(mkdir_cmd, sizeof(mkdir_cmd) + MEMORYBUFFEREXTRA, "mkdir -p %s", config_path);
  system(mkdir_cmd);

  if(chdir(config_path) != 0) {
    fprintf(stderr, "Failed to change to config directory: %s\n", config_path);
    exit(EXIT_FAILURE);
  }

  if(access("llama_runner.ini", F_OK) != 0) {
    fprintf(stderr, "No config file found in %s\n", config_path);
    exit(EXIT_FAILURE);
  }

  char cwd[PATH_MAX];

  if(getcwd(cwd, sizeof(cwd)) != NULL) {
    printf("Current working directory: %s\n", cwd);
  }
}

Config load_config(const char *filename) {
  FILE *file = fopen(filename, "r");

  if(!file) {
    perror("Failed to open config file");
    exit(EXIT_FAILURE);
  }

  Config config = {NULL, {NULL}, NULL, NULL};
  char line[MAX_LINE_LENGTH];
  int section = -1;
  int model_index = 0;

  while(fgets(line, sizeof(line), file)) {
    char *newline = strchr(line, '\n');

    if(newline) {
      *newline = '\0';
    }

    if(line[0] == '#' || line[0] == '\0') {
      continue;
    }

    if(!strcmp(line, "[appmode]")) {
      section = 0; // Skip this section
      continue;
    }

    else if(!strcmp(line, "[programbindirpath]")) {
      section = 1;
      continue;
    }

    else if(!strcmp(line, "[modelspath]")) {
      section = 2;
      continue;
    }

    else if(!strcmp(line, "[Browser]")) {
      section = 3;
      continue;
    }

    else if(!strcmp(line, "[port]")) {
      section = 4;
      continue;
    }

    if(section == 0) {
      // Skip [appmode] section
      continue;
    }

    char *key = line;
    char *value = strchr(line, '=');

    if(!value) {
      fprintf(stderr, "Invalid format in config file: missing '=' in line: %s\n", line);
      fclose(file);
      exit(EXIT_FAILURE);
    }

    *value = '\0';
    value++;

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

    if(section == 1) {
      if(!strcmp(key, "llama-cpp-bin-path")) {
        config.llama_cpp_bin_path = strdup(value);

        if(!config.llama_cpp_bin_path) {
          fprintf(stderr, "Memory allocation failed for llama-cpp-bin-path\n");
          fclose(file);
          exit(EXIT_FAILURE);
        }
      }
    }

    else if(section == 2) {
      if(model_index < MAX_MODELS) {
        config.model_paths[model_index] = strdup(value);

        if(!config.model_paths[model_index]) {
          fprintf(stderr, "Memory allocation failed for model-path\n");
          fclose(file);
          exit(EXIT_FAILURE);
        }

        model_index++;
      }
    }

    else if(section == 3) {
      if(!strcmp(key, "browser-command")) {
        config.browser_command = strdup(value);

        if(!config.browser_command) {
          fprintf(stderr, "Memory allocation failed for browser-command\n");
          fclose(file);
          exit(EXIT_FAILURE);
        }
      }
    }

    else if(section == 4) {
      if(!strcmp(key, "port")) {
        config.port = strdup(value);

        if(!config.port) {
          fprintf(stderr, "Memory allocation failed for port\n");
          fclose(file);
          exit(EXIT_FAILURE);
        }
      }
    }
  }

  if(!config.llama_cpp_bin_path || !config.browser_command || !config.port) {
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
  snprintf(browser_cmd, sizeof(browser_cmd), "nohup %s %s > /dev/null 2>&1 &", browser_command, url);
#elif __APPLE__
  snprintf(browser_cmd, sizeof(browser_cmd), "open -a \"%s\" %s", browser_command, url);
#else
  snprintf(browser_cmd, sizeof(browser_cmd), "%s %s &", browser_command, url);
#endif

  if(system(browser_cmd) == -1) {
    fprintf(stderr, "Failed to launch browser: %s\n", browser_cmd);
  }
}

void kill_existing_processes(const char *process_name) {
  char kill_cmd[MAX_CMD_LENGTH];
  snprintf(kill_cmd, sizeof(kill_cmd), "pkill -f %s", process_name);

  if(system(kill_cmd)) {
    fprintf(stderr, "Failed to kill existing processes: %s\n", process_name);
  }

  else {
    printf("Existing processes of %s have been killed.\n", process_name);
  }
}

int main() {
  enter_config_path();
  Config config = load_config("llama_runner.ini");
  printf("Configuration loaded:\n");
  printf("llama_cpp_bin_path: %s\n", config.llama_cpp_bin_path);
  printf("browser_command: %s\n", config.browser_command);
  printf("port: %s\n", config.port);
  int choice;
  printf("Choose an option:\n");
  printf("1) Start llama.cpp server\n");
  printf("2) Kill existing llama-cli processes\n");
  printf("3) Kill existing llama-server processes\n");
  printf("4) Exit\n");
  printf("Enter your choice: ");
  scanf("%d", &choice);

  if(choice == 1) {
    printf("Available models:\n");

    for(int i = 0; config.model_paths[i] != NULL && i < MAX_MODELS; i++) {
      printf("%d) %s\n", i + 1, config.model_paths[i]);
    }

    int model_choice;
    printf("Choose a model (enter the number): ");
    scanf("%d", &model_choice);

    if(model_choice < 1 || model_choice > MAX_MODELS || config.model_paths[model_choice - 1] == NULL) {
      printf("Invalid model choice. Exiting...\n");
      return EXIT_FAILURE;
    }

    char *selected_model = config.model_paths[model_choice - 1];

    // Change directory to the llama.cpp bin path
    if(chdir(config.llama_cpp_bin_path)) {
      perror("Failed to change directory");
      return EXIT_FAILURE;
    }

    // Extract port number from the URL
    char *port_num = strrchr(config.port, ':');

    if(port_num == NULL || port_num[1] == '\0') {
      fprintf(stderr, "Invalid port format in config file\n");
      return EXIT_FAILURE;
    }

    port_num++;
    // Execute llama-server command
    char server_cmd[MAX_CMD_LENGTH];
    snprintf(server_cmd, sizeof(server_cmd), "./llama-server -m %s --port %s", selected_model, port_num);
    printf("Executing command: %s\n", server_cmd);
    execute_command(server_cmd);
    // Launch browser
    launch_browser(config.browser_command, config.port);
  }

  else if(choice == 2) {
    kill_existing_processes("llama-cli");
  }

  else if(choice == 3) {
    kill_existing_processes("llama-server");
  }

  else if(choice == 4) {
    printf("Exiting...\n");
  }

  else {
    printf("Invalid choice. Exiting...\n");
  }

  // Clean up allocated memory
  free(config.llama_cpp_bin_path);

  for(int i = 0; i < MAX_MODELS && config.model_paths[i] != NULL; i++) {
    free(config.model_paths[i]);
  }

  free(config.browser_command);
  free(config.port);
  return EXIT_SUCCESS;
}
