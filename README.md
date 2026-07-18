# my-omp

Standalone flake packaging T0modachi's OMP (Oh My Pi) configuration.

## What it provides

- `homeManagerModules.default` - Home Manager module that installs OMP packages, symlinks config files, and configures agent skills.
- Re-exported packages: `omp`, `codegraph`, `context7-mcp`, `tavily-mcp`.

## Usage

Import from `~/.dotfiles` flake:

```nix
inputs.my-omp.url = "path:../repos/my-omp";

outputs = { self, my-omp, ... }@inputs: {
  homeManagerConfigurations.T0modachi = home-manager.lib.homeManagerConfiguration {
    modules = [
      ./home
      inputs.my-omp.homeManagerModules.default
    ];
  };
};
```

## Contents

- `flake.nix` - Main flake exposing module and packages.
- `module/default.nix` - Home Manager module.
- `config/` - OMP config files (`config.yml`, `mcp.json`, `RULES.md`).
- `lsp.nix` - LSP/DAP/linter packages for OMP integration.
