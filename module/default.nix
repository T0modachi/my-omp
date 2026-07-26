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

    # OMP config files
    home.file = {
      ".omp/agent/config.yml".source = ../config/config.yml;
      ".omp/agent/mcp.json".source = ../config/mcp.json;
      ".omp/agent/RULES.md".source = ../config/RULES.md;
    };

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
          "resolving-merge-conflicts"
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
          "writing-great-skills"
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
