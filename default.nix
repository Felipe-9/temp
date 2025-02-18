{ lib, config, pkgs, umport, ... }:
{
  # imports = umport { path = ./.; };
  # imports = builtins.trace (umport { path = ./.; exclude = [./default.nix]; }) (umport { path = ./.; exclude = [./default.nix]; });
  imports = [
    ./nixvim.nix
    ./nvf.nix
  ];

  options = {
    vscode.enable = lib.mkEnableOption "add vscode to config";
    nvim = {
      enable = lib.mkEnableOption "enable nvim configuration";
      suite = lib.mkOption {
        type = lib.types.enum [ "nixvim" "nvf" ];
        default = "nixvim";
        description = ''
          chose which neovim configuration to use:
          "nixvim" default and more reliable and more complete
          "nvf" very new and very incomplete
        '';
      };
    };
  };

  config = {
    environment.systemPackages = with pkgs; [
      (lib.mkIf config.vscode.enable vscode)
    ];
    nixvim.enable = config.nvim.enable && config.nvim.suite == "nixvim";
    nvf.enable    = config.nvim.enable && config.nvim.suite == "nvf";
  };
}
