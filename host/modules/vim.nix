# modules/vim.nix
{
  config,
  pkgs,
  ...
}: {
  programs = {
    nano.enable = false; # garbage

    neovim = {
      enable = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      # build tools

      # c
      cmake
      gcc13

      # nix
      nixd # nix language server
      nix-direnv # nix intergration for direnv
      alejandra # black-inspired formatting
      statix # linter

      # lua
      lua-language-server
      stylua

      # java
      jdt-language-server

      # web
      nodePackages.vscode-langservers-extracted
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.prettier
      nodePackages.eslint

      # go
      go
      gopls
    ];
  };
}
