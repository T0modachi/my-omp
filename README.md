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

## Skills & MCPs

This module enables the following skills and MCP servers.

### Skills

| Skill | Description | Trigger |
|-------|-------------|---------|
| `caveman` | Ultra-compressed communication mode. Drops articles, filler, hedging. Levels: lite/full/ultra/wenyan. | "caveman mode", "be brief", `/caveman` |
| `cavecrew` | Decision guide for delegating to caveman-style subagents (investigator/builder/reviewer). Compressed output saves ~60% context. | "delegate to subagent", "use cavecrew" |
| `caveman-commit` | Ultra-compressed commit message generator. Conventional Commits format. | "write a commit", `/commit` |
| `caveman-compress` | Compress memory files (CLAUDE.md, todos) into caveman format to save input tokens. | `/caveman-compress FILEPATH` |
| `caveman-help` | Quick-reference card for all caveman modes and commands. | `/caveman-help` |
| `caveman-review` | Ultra-compressed code review comments. One line per finding. | "review this PR", `/review` |
| `caveman-stats` | Show real token usage and estimated savings for current session. | `/caveman-stats` |
| `frontend-design` | Guidance for distinctive, intentional visual design. Aesthetic direction, typography, avoiding templated defaults. | Building new UI or reshaping existing one |
| `ponytail` | Lazy senior dev mode. YAGNI, stdlib first, no unrequested abstractions. Levels: lite/full/ultra. | "ponytail", "be lazy", "simplest solution" |
| `ponytail-audit` | Whole-repo audit for over-engineering. Ranked list of what to delete/simplify. | "audit this codebase", "find bloat" |
| `ponytail-debt` | Harvest every `ponytail:` comment into a debt ledger. | "ponytail debt", "what did ponytail defer" |
| `ponytail-gain` | Show ponytail's measured impact as a scoreboard (less code, less cost, more speed). | `/ponytail-gain` |
| `ponytail-help` | Quick-reference card for all ponytail modes and commands. | `/ponytail-help` |
| `ponytail-review` | Code review focused on over-engineering. One line per finding. | "review for over-engineering", "simplify review" |
| `lavish` | Turn complex responses into rich HTML artifacts for visual review and annotation. | "visual artifact", "interactive prototype", `/lavish` |
| `chrome-devtools-axi` | Agent-ergonomic Chrome DevTools CLI. Wraps chrome-devtools-mcp with TOON-encoded output (~57% fewer input tokens vs raw MCP). Use for any task that needs a real browser: navigate, click, fill forms, snapshot DOM, debug console/network, audit performance. | Any task needing a real browser (auto-loaded when detected; `user-invocable: false`) |

### MCPs

| MCP | Description | Trigger |
|-----|-------------|---------|
| `codegraph` | SQLite knowledge graph of codebase symbols, edges, and files. Provides code intelligence: symbol navigation, call paths, blast radius. | Automatic when querying code structure |
| `context7` | Fetches up-to-date documentation and code examples for libraries/frameworks. Two-step: resolve library ID, then query docs. | When user asks about libraries, frameworks, or API references |
