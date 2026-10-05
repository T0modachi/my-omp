{ inputs }:
{ config, pkgs, lib, ... }:
{
  imports = [
    inputs.agent-skills-nix.homeManagerModules.default
  ];

  config = {
    # OMP packages
    home.packages = [
      inputs.llm-agents.packages.${pkgs.system}.omp
      inputs.llm-agents.packages.${pkgs.system}.codegraph
      inputs.mcp-servers-nix.packages.${pkgs.system}.context7-mcp
      inputs.mcp-servers-nix.packages.${pkgs.system}.tavily-mcp
      pkgs.nodejs_22
    ] ++ import ../lsp.nix { inherit pkgs; };

    # OMP config files. ~/.omp/agent/config.yml is intentionally NOT
    # managed: OMP owns it and writes it at runtime (TUI settings, setup
    # wizard). Model roles are delivered as a read-only overlay through
    # PI_CONFIG_FILES, which takes precedence over OMP's own config.
    # force = true: the repo always wins over manual edits at the target.
    home.file = {
      ".omp/agent/models.yml" = {
        source = ../config/models.yml;
        force = true;
      };
      ".omp/agent/mcp.json" = {
        source = ../config/mcp.json;
        force = true;
      };
      ".omp/agent/RULES.md" = {
        source = ../config/RULES.md;
        force = true;
      };
    };

    # Model roles overlay (runtime > overlay > project > global > default).
    home.sessionVariables.PI_CONFIG_FILES = "${config.home.homeDirectory}/.omp/agent/models.yml";

    # Skills configuration
    programs.agent-skills = {
      enable = true;
      sources = {
        caveman = {
          path = inputs.caveman.outPath;
          subdir = "skills";
        };
        anthropic = {
          path = inputs.anthropic-skills.outPath;
          subdir = "skills";
        };
        ponytail = {
          path = inputs.ponytail.outPath;
          subdir = "skills";
        };
        lavish = {
          path = inputs.lavish-axi.outPath;
          subdir = "skills";
        };
        chrome-devtools = {
          path = inputs.chrome-devtools-axi.outPath;
          subdir = "skills";
        };
        mattpocock-engineering = {
          path = inputs.mattpocock-skills.outPath;
          subdir = "skills/engineering";
        };
        mattpocock-productivity = {
          path = inputs.mattpocock-skills.outPath;
          subdir = "skills/productivity";
        };
      };
      skills = {
        enable = [
          # Caveman skills
          "caveman"
          "cavecrew"
          "caveman-commit"
          "caveman-compress"
          "caveman-help"
          "caveman-review"
          "caveman-stats"

          # Anthropic skills
          "frontend-design"

          # Ponytail skills
          "ponytail"
          "ponytail-audit"
          "ponytail-debt"
          "ponytail-gain"
          "ponytail-help"
          "ponytail-review"

          # Lavish
          "lavish"

          # Chrome DevTools
          "chrome-devtools-axi"

          # Matt Pocock - engineering
          "ask-matt"
          "code-review"
          "codebase-design"
          "diagnosing-bugs"
          "domain-modeling"
          "grill-with-docs"
          "implement"
          "improve-codebase-architecture"
          "prototype"
          "research"
          "setup-matt-pocock-skills"
          "tdd"
          "to-spec"
          "to-tickets"
          "triage"
          "wayfinder"
          # Matt Pocock - productivity
          "grill-me"
          "grilling"
          "handoff"
          "teach"
          "writing-for-agents"
        ];
      };
      targets = {
        pi.enable = true;
        omp = {
          enable = true;
          dest = "$HOME/.omp/agent/skills";
          structure = "symlink-tree";
        };
      };
    };
  };
}
