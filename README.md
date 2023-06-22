# My Personal NixOS / Nix-Darwin Configuration

This is my personal NixOS / Nix-Darwin / Home-Manager configuration. It always is work in progress and is
constantly changing. It should not be used as a reference for how to do things the best way.

## Structure

- `/hosts`
  - System configuration for both of my hosts. (One for NixOS, one for Nix-Darwin)
- `/util`
  - Utility scripts, functions, ...
- `/home`
  - Home-Manager configuration, split into a common part and specific configuration for the different hosts.
- `/modules`
  - NixOS and Nix-Darwin modules.
  - `/common`
    - Common configuration between the sibling directories.
  - `/darwin`
    - Modules specific to Nix-Darwin.
  - `/services`
    - Modules for services. (e.g. systemd units)
  - `/system`
    - Modules for system-related configuration. (e.g. bootconfig, networking, ...)
