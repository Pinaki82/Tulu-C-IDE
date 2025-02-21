# Installation Guide for SafeCLib (Linux)

## Uninstalling Older Versions

Before installing the new version of SafeCLib, ensure that any older versions are removed from your system. Run the following commands with administrative privileges (NOTE: examples only):

```bash
sudo rm -rf /usr/local/include/safeclib
sudo rm /usr/local/lib/libsafec.so /usr/local/lib/libsafec.so.3 /usr/local/lib/libsafec.so.3.0.7 /usr/local/lib/libsafec.so.3.0.9
sudo rm /usr/local/lib/libsafec.a
sudo rm /usr/local/lib/libsafec.la
```

These commands will remove all traces of the older SafeCLib installation.

## Installing the New Version

1. **Clone the SafeCLib Repository**
   
   First, clone the SafeCLib repository from GitHub:
   
   ```bash
   git clone https://github.com/rurban/safeclib.git
   cd safeclib/
   ```

2. **Generate the Build Scripts**
   
   Run the `autogen.sh` script to generate the necessary build scripts:
   
   ```bash
   ./build-aux/autogen.sh
   ```

3. **Configure the Build**
   
   Configure the build with the option to enable static libraries:
   
   ```bash
   ./configure --enable-static
   ```

4. **Build the Release Version**
   
   Compile the Release version of SafeCLib:
   
   ```bash
   make config=Release
   ```

5. **Install SafeCLib**
   
   Install the compiled binaries to your system:
   
   ```bash
   sudo make config=Release install
   ```

These steps will install the latest version of SafeCLib on your Linux system, ensuring that all necessary files are properly configured and ready for use.
