# AGENTS.md

## Project

`my-omp` is a standalone Nix flake that packages T0modachi's OMP (Oh My Pi) configuration.

- Exposes `homeManagerModules.default` for Home Manager.
- Re-exports packages: `omp`, `codegraph`, `context7-mcp`, `tavily-mcp`.
- Installs OMP config files into `~/.omp/agent/`.
- Configures agent skills via `agent-skills-nix`.

## Repository structure

| Path | Purpose |
|------|---------|
| `flake.nix` | Flake inputs, outputs, module and packages. |
| `module/default.nix` | Home Manager module: packages, dotfiles, skills. |
| `config/config.yml` | OMP UI/model configuration. |
| `config/mcp.json` | MCP server configuration. |
| `config/RULES.md` | Agent behavior rules (loaded into OMP). |
| `lsp.nix` | LSP/DAP/linter packages used by OMP. |
| `.codegraph/` | CodeGraph index (auto-generated). |

## Rules for working here

- Default communication mode: `caveman` ultra.
- Engineering mode: `ponytail` full; apply the ladder (YAGNI, reuse, stdlib, native, installed deps, one-liner, minimal code).
- This is a Nix/NixOS project. Do not use global installers (`npm install -g`, `pip install`, etc.). Add tools to the Nix flake or Home Manager config instead.
- Keep the flake minimal. Only add new inputs/packages if they are necessary for the OMP configuration.
- Prefer existing patterns over introducing new ones.
- Do not modify auto-generated files or `CHANGELOG.md` manually.
- When adding a new skill or MCP to the configuration (in `module/default.nix` or `config/mcp.json`), update the "Skills & MCPs" catalog in README.md with the new item's name, description, and trigger.
- When editing Nix files, prefer the existing formatting style; if a formatter is present, run it before finishing.
- There are no automated tests. Verify changes by evaluating the flake or checking the Home Manager configuration.

## Common tasks

- Update tool versions: `nix flake update` (or bump specific inputs in `flake.nix`).
- Check the flake: `nix flake check`.
- Format Nix files: use the project's formatter if available; otherwise keep style consistent.
- Re-index the graph after large changes: `codegraph init` (or `codegraph init .`).

## Contact / intent

This repo is personal infrastructure. Only make changes that directly improve the OMP configuration or the tooling it delivers. Avoid speculative abstractions.
