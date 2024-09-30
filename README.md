# My .dotfiles and NixOS configuration

## What is this?
This is my personal config files for nix-darwin using flakes and home-manager. This is a work in progress and will be updated as I go along.

## Overviews

#### `Makefile`
This is where the magic happens. This file is responsible for building, running, testing and installing the configuration. 

#### `nix-darwin_configuration`
This directory contains the configuration for Nix Darwin, this will manage the configuration for macOS using nix as the package manager.  

#### `home`
This directory contains all the programs and modules that are used to configure the user level. These are primarily programs. If a program has additional, non Nix, configuration files, then the program is placed in it's own directory with those files in a `config` directory and a `default.nix` file to import it with.
