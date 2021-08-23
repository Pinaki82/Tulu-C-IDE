# Generated Cmake Pico project file

cmake_minimum_required(VERSION 3.13)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_EXPORT_COMPILE_COMMANDS 1)

# initalize pico_sdk from installed location
# (note this can come from environment, CMake cache etc)
set(PICO_SDK_PATH "E:/VSARM/sdk/pico/pico-sdk")

# Pull in Raspberry Pi Pico SDK (must be before project)
include(pico_sdk_import.cmake)

project(test3 C CXX ASM)

# Initialise the Raspberry Pi Pico SDK
pico_sdk_init()

# Add executable. Default name is the project name, version 0.1

add_executable(test3 test3.c )

pico_set_program_name(test3 "test3")
pico_set_program_version(test3 "0.1")

pico_enable_stdio_uart(test3 1)
pico_enable_stdio_usb(test3 0)

# Add the standard library to the build
target_link_libraries(test3 pico_stdlib)

pico_add_extra_outputs(test3)

