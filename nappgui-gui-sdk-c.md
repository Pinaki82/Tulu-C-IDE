# NAppGUI - Cross-Platform C SDK

A toolkit for building portable desktop applications for Windows, macOS and Linux using C programming language.

## Overview

- Official website: [nappgui.com](https://nappgui.com)
- Source code: [GitHub Repository](https://github.com/frang75/nappgui_src.git)
- Documentation: Available as a [PDF guide](https://nappgui.com/res/nappgui_en.pdf)

## Setting Up the Development Environment

### Required System Libraries

For Debian/Debian-variant Linux systems, install the following dependencies:

```bash
sudo apt install libgtk-3-dev libcurl4-openssl-dev libwebkit2gtk-4.1-dev mesa-common-dev libgl1-mesa-dev
```

### Installing NAppGUI SDK

1. Download the source code:
   
   ```bash
   cd ~/
   git clone --depth 1 https://github.com/frang75/nappgui_src.git
   cd nappgui_src
   ```

2. Build and install as a static library:
   
   ```bash
   cmake -S . -B build -DNAPPGUI_DEMO=NO -DCMAKE_BUILD_TYPE=Release
   cmake --build build -j 4
   sudo cmake --install build --config Release --prefix /usr/local/nappgui
   ```

3. Clean up the source files:
   
   ```bash
   rm -rf ~/nappgui_src
   ```

## Creating Your First Application

1. Create a new project directory:
   
   ```bash
   mkdir nappgui_test
   cd nappgui_test
   ```

2. Create `CMakeLists.txt` with the following contents:
   
   ```cmake
   cmake_minimum_required(VERSION 3.0)
   project(NAppHello)
   find_package(nappgui REQUIRED)
   include("${NAPPGUI_ROOT_PATH}/prj/NAppProject.cmake")
   include("${NAPPGUI_ROOT_PATH}/prj/NAppCompilers.cmake")
   nap_config_compiler()
   nap_project_desktop_app(NAppHello hello)
   ```

3. Create `main.c` with the example code for a simple GUI application (see below).

4. Build your application:
   
   ```bash
   cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
   cmake --build build
   ```

5. Run the application:
   
   ```bash
   cd build/Release/bin
   ./NAppHello
   ```

![Image](https://private-user-images.githubusercontent.com/16861933/405109175-8e3f8c4a-1415-4f37-b4c3-159d72615c73.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Mzc0NDM5NjksIm5iZiI6MTczNzQ0MzY2OSwicGF0aCI6Ii8xNjg2MTkzMy80MDUxMDkxNzUtOGUzZjhjNGEtMTQxNS00ZjM3LWI0YzMtMTU5ZDcyNjE1YzczLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNTAxMjElMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjUwMTIxVDA3MTQyOVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWM3Yjg3Zjg5NWQ2NDdjMTdhNzNmNTVlMzliYmVmNzQ1N2M5OGU5Zjg0N2Q2ZGM4NGY3ZjUyMmI5NDRkYTIzNTUmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.P6XnHN5ZPalPG7EGaDtJr6F06G3_Y4ikbOwTGXHlxkc)

## Example Application Code

Here's a simple "Hello World" application that demonstrates basic NAppGUI functionality:

```c
#include <nappgui.h>

typedef struct _app_t App;

struct _app_t
{
    Window *window;
    TextView *text;
    uint32_t clicks;
};

static void i_OnButton(App *app, Event *e)
{
    textview_printf(app->text, "Button click (%d)\n", app->clicks);
    app->clicks += 1;
    unref(e);
}

static Panel *i_panel(App *app)
{
    Panel *panel = panel_create();
    Layout *layout = layout_create(1, 3);
    Label *label = label_create();
    Button *button = button_push();
    TextView *text = textview_create();

    app->text = text;
    label_text(label, "Hello!, I'm a label");
    button_text(button, "Click Me!");
    button_OnClick(button, listener(app, i_OnButton, App));

    layout_label(layout, label, 0, 0);
    layout_button(layout, button, 0, 1);
    layout_textview(layout, text, 0, 2);
    layout_hsize(layout, 0, 250);
    layout_vsize(layout, 2, 100);
    layout_margin(layout, 5);
    layout_vmargin(layout, 0, 5);
    layout_vmargin(layout, 1, 5);

    panel_layout(panel, layout);
    return panel;
}

static void i_OnClose(App *app, Event *e)
{
    osapp_finish();
    unref(app);
    unref(e);
}

static App *i_create(void)
{
    App *app = heap_new0(App);
    Panel *panel = i_panel(app);
    app->window = window_create(ekWINDOW_STD);
    window_panel(app->window, panel);
    window_title(app->window, "Hello, World!");
    window_origin(app->window, v2df(500, 200));
    window_OnClose(app->window, listener(app, i_OnClose, App));
    window_show(app->window);
    return app;
}

static void i_destroy(App **app)
{
    window_destroy(&(*app)->window);
    heap_delete(app, App);
}

#include <osapp/osmain.h>
osmain(i_create, i_destroy, "", App)
```

This example creates a window with a label, button, and text view. The button click counter demonstrates basic event handling and GUI updates.

## Create every reference GUI example application that the SDK provides:

```bash
cd ~/
git clone --depth 1 https://github.com/frang75/nappgui_src.git
cd nappgui_src
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build -j 4
```
