![Screenshot 2026 03 14-1](assets/Screenshot2026-03-14-1.png)
![Screenshot 2026 03 14-2](assets/Screenshot2026-03-14-2.png)

# nixos-configuration

![NixOS](https://img.shields.io/badge/NixOS-25.11-7C3AED?style=for-the-badge&logo=nixos&logoColor=white)
![Built with Nix](https://img.shields.io/badge/Built%20with-Nix-5277C3?style=for-the-badge&logo=nixos&logoColor=white)
![Branch: main](https://img.shields.io/badge/Branch-main-2ECC71?style=for-the-badge&logo=git&logoColor=white)

#### ❄️ NixOS Configuration:

> Declarative system configuration for my NixOS machines using reproducible infrastructure.

This repository contains my NixOS system configuration, including system modules, packages, and host-specific settings.
It is designed to be reproducible, modular, and easy to maintain.


#### 🎯 Features:

- Declarative system configuration
- Modular NixOS setup
- Reproducible builds
- Version-controlled infrastructure
- Easy host management
- Simple system rebuild workflow


#### 📁 Configuration file structure:
```plaintext
/etc/nixos/
│
├── users/
│     └── alex/
│          ├── wallpapers/
│          │      ├── mountain_wallpaper_nord.jpg
│          │      └── nixos_wallpaper_main.png
│          ├── bashrc
│          ├── config.jsonc
│          ├── kitty.conf
│          └── starship.toml
│
├── configuration.nix
├── hardware-configuration.nix
└── README.md
```
