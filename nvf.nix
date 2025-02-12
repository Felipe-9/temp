{ lib, config, inputs, pkgs, ... }:
{
  options.nvf.enable = lib.mkEnableOption "enable nvf module";
  config.environment.systemPackages = lib.mkIf config.nvf.enable [
    inputs.nvf.packages.${pkgs.system}.default
  ];
}
