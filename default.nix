{ lib, config, pkgs, umport, ... }:
{
  imports = umport { path = ./.; };
  # imports = [
  #   ./nixvim.nix
  #   ./nvf.nix
  # ];

  options.texteditors = {
    enable = lib.mkEnableOption "enable texteditor module";
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

  config = lib.mkIf config.texteditors.enable {
    environment.systemPackages = with pkgs; [
      (lib.mkIf config.texteditors.vscode vscode)
    ];
    nixvim.enable = config.texteditors.nvim.suite == "nixvim";
    nvf.enable = config.texteditors.nvim.suite == "nvf";
  };
}
