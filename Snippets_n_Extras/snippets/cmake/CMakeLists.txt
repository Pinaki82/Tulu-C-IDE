# A basic CMake script (for project-specific custom header files).
#
# mkdir build
# cd build
# cmake -G "MinGW Makefiles" ..
# or,
# cmake -DCMAKE_BUILD_TYPE=Debug -G "MinGW Makefiles" ..
# make -j4
# or,
# mingw32-make -j4

cmake_minimum_required(VERSION 3.0)
project(`<your_project_name>`)


# https://stackoverflow.com/questions/13703647/how-to-properly-add-include-directories-with-cmake
include_directories(include)
add_executable(`<your_project_name>`
  src/main.c
  src/`<another_c_file.c>`
  include/`<header.h>`
 )


# Add compiler flags for GCC and Clang
if(CMAKE_C_COMPILER_ID MATCHES "GNU|Clang")
  target_compile_options(`<your_project_name>` PRIVATE -Wall -Wextra)
endif()

# Add compiler flags for MSVC
if(MSVC)
  target_compile_options(`<your_project_name>` PRIVATE /W4)
endif()

# Set linker flags for all builds
if(WIN32)
  # For Windows systems (MinGW-w64 or MSVC)
  target_link_options(`<your_project_name>` PRIVATE -static-libgcc -static-libstdc++)
  if(MSVC)
    # For MSVC on Windows
    target_compile_options(`<your_project_name>` PRIVATE /W4 /WX)
  endif()
else()
  # For non-Windows systems (GCC or Clang)
  target_link_options(`<your_project_name>` PRIVATE -static)
  target_compile_options(`<your_project_name>` PRIVATE -Werror)
endif()

# Set build type to Release by default
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

# Set compiler and linker flags for Debug and Release builds
target_compile_options(`<your_project_name>` PRIVATE
  $<$<CONFIG:Debug>:-O0 -g>
  $<$<CONFIG:Release>:-O3>
)

if(WIN32 AND MSVC)
  target_link_options(`<your_project_name>` PRIVATE
    $<$<CONFIG:Debug>:/DEBUG:FULL>
    $<$<CONFIG:Release>:/DEBUG:NONE>
  )
else()
  target_link_options(`<your_project_name>` PRIVATE
    # $<$<CONFIG:Debug>:-Wl,--export-all-symbols>
  )
endif()

