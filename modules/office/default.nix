{ config, lib, pkgs, currentUser, ... }:
let
  custom-packages = import ./packages.nix  { inherit pkgs; };
in{
  specialisation.office.configuration = {
    system.nixos.tags = [ "OFFICE" ];

    # --- Using KDE plasma 6 desktop env ---
    services.displayManager.sddm.enable = lib.mkForce true;
    services.desktopManager.plasma6.enable = lib.mkForce true;

    # --- Cleaning others environment env ---
    services.xserver.desktopManager.xfce.enable = lib.mkForce false;
    programs.hyprland.enable = lib.mkForce false;

    environment.systemPackages = custom-packages ++ (with pkgs; [
    ]);

    # Welcome message
    services.getty.helpLine = lib.mkForce ''
      [ OFFICE MODE ACTIVATED ]
    '';
  };
}