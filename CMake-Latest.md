Installing the Latest CMake from a Source Tarball
=====================================================

In certain situations, installing the latest version of CMake from a source tarball may be necessary. The following scenarios illustrate the benefits of doing so:

### Reasons for Installing from a Source Tarball

1. **Outdated Distribution Version**: Many Linux distributions come with a pre-installed version of CMake, which may be outdated. Older versions of CMake can also be found in Linux distribution repositories. If a project requires a newer version of CMake, installing from a source tarball provides access to the latest features and bug fixes.
2. **New CMake Features**: The latest version of CMake may introduce new features, such as improved support for certain cross-compilers (e.g., Raspberry Pi Pico SDK), languages, or build systems. Installing CMake from a source tarball ensures compatibility with projects that rely on these new features. The CMake version needed for a given project could be higher than what is available in the distribution repositories for the build setup. In those situations, the most recent CMake can be useful.
3. **Essential Bug Fixes**: Sometimes, a specific bug in an earlier version of CMake can cause issues with a project's build process. Installing the latest version from a source tarball provides the necessary bug fixes, ensuring a smooth build experience.
4. **Custom or Non-Standard Build Configurations**: Certain projects may require custom or non-standard build configurations, which can be better supported by the latest version of CMake. Installing from a source tarball allows for more flexibility in configuring the build process.
5. **Cross-Compilation or Embedded Systems Development**: When working with cross-compilation or embedded systems development, the version of CMake provided by the distribution may not be suitable. Installing CMake from a source tarball provides the necessary customisation options for these specialised use cases.
6. **Package Manager Limitations**: In some cases, the package manager (e.g., apt, yum, or Homebrew) may not provide the latest version of CMake or may have limitations on the versions available. Installing from a source tarball bypasses these limitations, allowing for the installation of the desired version.
7. **Development or Testing Environments**: Developers or testers may need to test their projects with different versions of CMake, including the latest one. Installing CMake from a source tarball provides an easy way to manage multiple versions and test environments.

### Building and Installing CMake from a Source Tarball on Linux

The following steps outline the process of building and installing CMake from a source tarball on Linux, tested on Debian Bookworm.

#### Step 1: Check the Existing Version

To verify the currently installed version of CMake, run the following command:

```bash
cmake --version
```

The output will display the version number, similar to:

```
cmake version 3.25.1

CMake suite maintained and supported by Kitware (kitware.com/cmake).
```

#### Step 2: Download the Latest CMake Source

Download the latest CMake source from the [Kitware CMake GitHub repository](https://github.com/Kitware/CMake/releases). Select the "Source code" option in `(tar.gz)` format, and download the `CMake-{version number}.tar.gz` file.

#### Step 3: Extract the Source Tarball

Navigate to the `~/Downloads` directory (_for example_) and extract the source tarball:

```bash
cd ~/Downloads/
```

```bash
tar -zxvf 'CMake-{version number}.tar.gz'
```

#### Step 4: Bootstrap and Build CMake

Enter the extracted source directory and bootstrap the build process:

```bash
cd CMake-{version number}/
```

```bash
./bootstrap
```

Use `gmake` to run the build process:

```bash
gmake
```

#### Step 5: Install CMake

If the build process completes successfully, install the built binary using `sudo` privileges:

```bash
sudo gmake install
```

#### Step 6: Verify the Installation

To confirm the installation, check the CMake version number:

```bash
cmake --version
```

The output should display the newly installed version, similar to:

```
cmake version 3.31.3

CMake suite maintained and supported by Kitware (kitware.com/cmake).
```

By following these steps, users can ensure they have the latest version of CMake installed, providing access to the latest features, bug fixes, and customisation options for their projects.
