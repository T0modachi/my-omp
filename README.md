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
| `engineering/code-review` | Two-axis review: Standards (coding standards) and Spec (matches issue/PRD). Runs both in parallel sub-agents. | "review since X", "review this branch/PR" |
| `engineering/codebase-design` | Shared vocabulary for designing deep modules (module, interface, seam, adapter, leverage). Use when designing or improving module interfaces. | "design module interface", "find deepening opportunities" |
| `engineering/diagnosing-bugs` | Diagnosis loop for hard bugs and performance regressions. Builds tight feedback loops. | "diagnose", "debug this", reports broken/slow behavior |
| `engineering/domain-modeling` | Build and sharpen domain model, pin down terminology, record ADRs. Active discipline for ubiquitous language. | "define domain terms", "record ADR", "build ubiquitous language" |
| `engineering/grill-with-docs` | Relentless interview to sharpen a plan/design, creating ADRs and glossary as we go. | "grill me with docs", "interview and document" |
| `engineering/implement` | Implement work based on a spec or set of tickets. Uses TDD where possible, runs code-review when done. | "implement this", "build from tickets/spec" |
| `engineering/improve-codebase-architecture` | Scan codebase for deepening opportunities, present as visual HTML report, then grill through your choice. | "improve architecture", "architectural review" |
| `engineering/prototype` | Build throwaway prototype to answer design question - sanity-check state models or explore UI options. | "prototype this", "sanity check design", "explore UI" |
| `engineering/research` | Investigate question against primary sources, capture findings as Markdown in repo. | "research this", "investigate docs/API", "gather facts" |
| `engineering/resolving-merge-conflicts` | Resolve in-progress git merge/rebase conflicts. Preserves both intents where possible. | Merge/rebase conflicts |
| `engineering/setup-matt-pocock-skills` | Configure repo for engineering skills - set up issue tracker, triage labels, domain doc layout. Run once before first use. | "setup skills", "configure issue tracker", first-time setup |
| `engineering/tdd` | Test-driven development. Build features or fix bugs test-first with red-green-refactor. | "tdd", "red-green-refactor", "test first" |
| `engineering/to-spec` | Turn current conversation into a spec and publish to issue tracker. Synthesis, no interview. | "to spec", "publish conversation as spec" |
| `engineering/to-tickets` | Break plan/spec/conversation into tracer-bullet tickets with blocking edges, published to tracker. | "to tickets", "break into tickets" |
| `engineering/triage` | Move issues and PRs through state machine of triage roles - categorize, verify, grill, write agent-ready briefs. | "triage issues", "categorize PRs" |
| `engineering/wayfinder` | Plan huge work as shared map of decision tickets on issue tracker, resolve one at a time. | "wayfinder", "plan big effort", "chart the way" |
| `productivity/grill-me` | Get relentlessly interviewed about a plan or design until every branch of the decision tree is resolved. | "grill me", `/grill-me` |
| `productivity/teach` | Teach user a new skill/concept over multiple sessions in a workspace with mission, resources, lessons, and learning records. | "teach me", "learn about X" |

### MCPs

| MCP | Description | Trigger |
|-----|-------------|---------|
| `codegraph` | SQLite knowledge graph of codebase symbols, edges, and files. Provides code intelligence: symbol navigation, call paths, blast radius. | Automatic when querying code structure |
| `context7` | Fetches up-to-date documentation and code examples for libraries/frameworks. Two-step: resolve library ID, then query docs. | When user asks about libraries, frameworks, or API references |
