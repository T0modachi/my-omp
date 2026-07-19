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
      };
      skills = {
        # Caveman skills
        caveman.enable = true;
        cavecrew.enable = true;
        caveman-commit.enable = true;
        caveman-compress.enable = true;
        caveman-help.enable = true;
        caveman-review.enable = true;
        caveman-stats.enable = true;

        # Anthropic skills (only frontend-design)
        frontend-design.enable = true;

        # Ponytail skills
        ponytail.enable = true;
        ponytail-audit.enable = true;
        ponytail-debt.enable = true;
        ponytail-gain.enable = true;
        ponytail-help.enable = true;
        ponytail-review.enable = true;

        # Lavish skills
        lavish.enable = true;

        # Chrome DevTools skill
        chrome-devtools-axi.enable = true;
      };
      targets = {
        pi.enable = true;
      };
    };
  };
}
