# Package installation/uninstallation in MSYS2

### MSYS2 uses "Pacman" as its package manager.

##### References:

1. https://www.maketecheasier.com/mastering-pacman-for-arch-linux/

2. https://www.maketecheasier.com/clear-package-cache-arch-linux/

# Update the System:

```
pacman -Syu
```

## Force a full refresh of the package database and update the system:

```
pacman -Syuu
```

## Search for Packages:

_pacman -Ss {keyword}_

_pacman -Ss vim_

```
pacman -Ss package_name
```

## Search for installed packages:

```
pacman -Qs package_name
```

## Installing Packages:

```
pacman -S package1 package2
```

## Update the system and install packages simultaneously:

```
pacman -Syu package1 package2
```

## Listing Installed Packages:

```
pacman -Ql
```

## Download Packages without installing:

```
pacman -Sw package_name
```

# Uninstall a Package

```
pacman -R package
```

## Remove a package and its dependencies that aren’t used by other packages:

```
pacman -Rsu package
```

## Check for orphan files:

```
pacman -Qdt
```

## Remove unused packages/orphans and their configuration files:

```
pacman -Rsnu $(pacman -Qtdq)
```

## Clean up the Package Cache:

**Clear** out **cached packages that aren’t currently installed:**

This option will delete all the cached packages in `/var/cache/pacman/pkg/` except for the versions matching packages installed on your system.

```
pacman -Sc
```

**Keep all the installers** of packages that are installed on the system **plus one previous** version of each installer in the cache directory. It **also deletes** installers of **any package not installed/found** on the system, much like `pacman -Sc` with an extra option.

```
paccache -rk 1
```

`paccache -rk 2` will keep two older versions of each installer.

## Remove the tarballs of all packages not currently installed on your system.

```
paccache -ruk0
```
