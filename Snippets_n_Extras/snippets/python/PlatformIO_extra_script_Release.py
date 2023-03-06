# https://docs.platformio.org/en/latest/scripting/examples/extra_linker_flags.html
#
# PlatformIO Extra linker flags without -Wl, prefix
# Contains a GCC Linker Flag (-s: Strip Bytes) to reduce file size
# File name: PlatformIO_extra_script_Release.py
#

Import("env")

env.Append(
  LINKFLAGS=[
      "-s"
  ]
)
