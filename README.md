# Fedora-Setup a Post Install Helper Script

## What's all this then?

Fedora-Setup is a personal script I created to help with post install tasks such as tweaks and software installs. It's written in Bash and utilises Dialog for a friendlier menu system.

Dialog must be installed for the menu system to work and as such the script will check to see if Dialog is installed. If not, it will ask you to install it.

## Usage

1. Run `./setup.sh`

## Files

- **dnf-erase.txt** - This file contains a list of packages to be erased from the system.
- **dnf-install.txt** - This file contains a list of all applications that will be installed to the system.
- **flatpak-install.txt** - This file contains a list of all Flatpak packages to install.

## Options

### Speed up DNF
  - Enables fastest mirror
  - Sets max parallel downloads to 10
  - Enables DeltaRPMs

### Remove Software
  - Removes packages defined in `dnf-erase.txt`.
  - These are packages that are not needed to be installed or will be re-installed as a Flatpak.

### Update System
  - Runs `dnf upgrade --refresh` to install all available updates from enabled repos.

### Install Software
  - Installs packages defined in `dnf-install.txt`.

### Enable Flatpak and Packages
  - Adds the `flathub` repo.
  - Installs packages defined in `flatpak-install.txt`.

### Install Oh-My-ZSH
  - Installs Oh-My-Zsh - [A ZSH configuration management framework](https://ohmyz.sh/)

### Install powerlevel10k Prompt
  - Installs the powerlevel10k prompt for ZSH - [A popular cross-shell highly customisable prompt](https://github.com/romkatv/powerlevel10k)
