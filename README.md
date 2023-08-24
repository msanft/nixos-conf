# My Personal NixOS / Nix-Darwin Configuration

This is my personal NixOS / Nix-Darwin / Home-Manager configuration. It always is work in progress and is
constantly changing. It should not be used as a reference for how to do things the best way.

## Structure

- `/hosts`
  - System configuration for both of my hosts. (Currently one for NixOS, one for Nix-Darwin)
- `/modules`
  - NixOS and Nix-Darwin modules.
  - `/home`
    - [Home-Manager](https://github.com/nix-community/home-manager) (per-user) modules.
  - `/common`
    - Common configuration data shared between the sibling directories.
  - `/darwin`
    - Modules specific to  [Nix-Darwin](https://github.com/LnL7/nix-darwin).
  - `/nix`
    - Modules to configure Nix and Nixpkgs.
  - `/services`
    - Modules for services. (e.g. systemd units)
  - `/system`
    - Modules for system-related configuration. (e.g. bootconfig, networking, ...)
