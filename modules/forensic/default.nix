{ inputs, lib, pkgs, currentUser, ... }:
let
  custom-packages = import ./packages.nix { inherit pkgs; };
in{
  specialisation.forensic.configuration = {
    system.nixos.tags = [ "FORENSIC" ];

    # Mount hackix in RAM
    fileSystems."/" = lib.mkForce {
      device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=8G" "mode=755" ]; # Plus de RAM car les images disk sont lourdes
    };

    # Protect /nix of any writing when running this specialisation
    fileSystems."/nix".options = lib.mkForce [ "ro" "noatime" ];

    # Force persistant folder for saving findings
    fileSystems."/home/${currentUser}/findings" = lib.mkForce {
      device = "/dev/disk/by-label/FINDINGS";
      fsType = "ext4";
      options = [ "rw" "noatime" "sync" ]; 
    };

    # SWAP deactivation for avoid data leak
    swapDevices = lib.mkForce [];

    # Kernel optimisation to avoid data modification
    boot.kernel.sysctl = {
      "kernel.dmesg_restrict" = 1;
      "kernel.kptr_restrict" = 2;
    };
    boot.kernelParams = [
      "ro"
      "nosmap"
      "page_poison=1"
      "noswap"
    ];

    # auto mount and indexing deactivation
    services.udisks2.enable = lib.mkForce false;
    services.gvfs.enable = lib.mkForce false;

    # XFCE Desktop environment
    services.xserver.enable = lib.mkForce true;
    services.xserver.desktopManager.xfce.enable = lib.mkForce true;
    services.displayManager.ly.enable = lib.mkForce true;

    # Force stop others desktop environments
    programs.hyprland.enable = lib.mkForce false;
    services.desktopManager.plasma6.enable = lib.mkForce false;
    services.displayManager.sddm.enable = lib.mkForce false;

    environment.systemPackages = custom-packages ++ (with pkgs; [
    ]);

    # Welcome message
    services.getty.helpLine = lib.mkForce ''
      [ FORENSIC MODE ACTIVATED ]
      - Root : tmpfs (RAM)
      - SWAP : deactivated
      - Store : Read-Only
      - Auto mount : deactivated
    '';

    # For evidence preservation, mount any disk to analyze with this options :
    # mount -o ro,loop,noatime,nodiratime,nodev,noexec
  };
}