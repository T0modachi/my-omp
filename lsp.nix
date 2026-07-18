{ pkgs }:
with pkgs; [
  # Language Servers
  typescript-language-server
  vscode-langservers-extracted
  yaml-language-server
  lua-language-server
  nil
  marksman
  pyright
  gopls
  terraform-ls
  ruby-lsp
  phpactor

  # Linters/Formatters
  ruff
  statix
  yamllint
  alejandra
  prettierd
  prettier
  stylua
  yamlfmt

  # Debuggers
  python3Packages.debugpy
]
