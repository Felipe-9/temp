{ lib, config, pkgs, inputs, ...}: 
{
  options.nixvim.enable = lib.mkEnableOption "Enable neovim wrapper module";

  config = lib.mkIf config.nixvim.enable {
    environment.systemPackages = with pkgs; [
      inputs.nixvim-wrapped.packages.${system}.default
    ];
    programs.neovim.enable = false;
  };
}
