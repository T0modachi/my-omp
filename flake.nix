{
  description = "T0modachi's OMP (Oh My Pi) configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # OMP and tools
    llm-agents.url = "github:numtide/llm-agents.nix";
    mcp-servers-nix.url = "github:natsukium/mcp-servers-nix";
    agent-skills-nix.url = "github:Kyure-A/agent-skills-nix";

    # Skill sources
    caveman = {
      url = "github:JuliusBrussee/caveman";
      flake = false;
    };
    anthropic-skills = {
      url = "github:anthropics/skills";
      flake = false;
    };
    ponytail = {
      url = "github:DietrichGebert/ponytail";
      flake = false;
    };
    lavish-axi = {
      url = "github:kunchenguid/lavish-axi";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    homeManagerModules.default = import ./module { inherit inputs; };

    # Re-export packages for direct use if needed
    packages = nixpkgs.lib.genAttrs [ "x86_64-linux" ] (system: {
      inherit (inputs.llm-agents.packages.${system}) omp codegraph;
      inherit (inputs.mcp-servers-nix.packages.${system}) context7-mcp tavily-mcp;
      default = self.packages.${system}.omp;
    });
  };
}
