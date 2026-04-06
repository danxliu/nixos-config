# NixOS Configuration

## Directory Structure
```
.
├── flake.lock
├── flake.nix
├── hosts # Host-specific configurations
│   └── host
│       ├── configuration.nix
│       └── hardware-configuration.nix
├── modules # Reusable NixOS modules
│   └── core
│       └── default.nix
└── users # User-specific Home Manager configurations.
    └── user
        └── home.nix
```

## Commands
| Action | Command |
| :--- | :--- |
| **Apply Configuration** | `sudo nixos-rebuild switch --flake .#<hostname>` |
| **Build Configuration** | `nixos-rebuild build --flake .#<hostname>` |
| **Dry Run (Check)** | `nixos-rebuild dry-run --flake .#<hostname>` |
| **Check Flake Syntax** | `nix flake check` |
| **Show Flake Outputs** | `nix flake show` |
| **Update Inputs** | `nix flake update` |
