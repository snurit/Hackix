{ config, lib, pkgs, currentUser, ... }:
let
  custom-packages = import ./packages.nix  { inherit pkgs; };
in{
  specialisation.osint.configuration = {
    system.nixos.tags = [ "OSINT" ];
    # Making system disappear when shutting down computer (no electricity = no persistance)
    fileSystems."/" = lib.mkForce {
      device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=8G" "mode=755" ];
    };

    # Protect /nix of any writing when running this specialisation
    fileSystems."/nix".options = lib.mkForce [ "ro" "noatime" ];

    environment.systemPackages = custom-packages ++ (with pkgs; [
    ]);

    # --- Activation de l'interface graphique KDE Plasma 6 ---
    services.displayManager.sddm.enable = lib.mkForce true;
    services.desktopManager.plasma6.enable = lib.mkForce true;

    # --- Nettoyage : Désactivation forcée des autres environnements ---
    services.xserver.desktopManager.xfce.enable = lib.mkForce false;
    programs.hyprland.enable = lib.mkForce false;

    # Network security
    services.tor = {
      enable = lib.mkForce true;
      client.enable = lib.mkForce true;
      settings = {
        # Port pour le proxy transparent
        TransPort = [ 9040 ];
        # Port pour la résolution DNS anonymisée
        DNSPort = [ 5353 ];
        # Sécurité accrue : isole les circuits
        IsolateDestAddr = lib.mkForce true;
        IsolateDestPort = lib.mkForce true;
      };
    };

    networking.nameservers = [ "127.0.0.1" ];
    networking.resolvconf.useLocalResolver = true;

    networking.firewall = {
      enable = true;
      # Redirecting to Tor
      extraCommands = ''
        # Cleaning previous rules
        iptables -t nat -F
        
        # Redirecting DNS to DNS Tor socket
        iptables -t nat -A OUTPUT -p udp --dport 53 -j REDIRECT --to-ports 5353
        iptables -t nat -A OUTPUT -p tcp --dport 53 -j REDIRECT --to-ports 5353

        # Redirecting all TCP traffic to TransPort Tor (9040)
        # Excluding 'tor' user for avoiding infinite loop
        iptables -t nat -A OUTPUT -p tcp -m owner ! --uid-owner tor -j REDIRECT --to-ports 9040

        # Block all but not TCP
        iptables -A OUTPUT -m owner ! --uid-owner tor -o lo -j ACCEPT
        iptables -A OUTPUT -m owner ! --uid-owner tor -p udp ! --dport 5353 -j REJECT
        iptables -A OUTPUT -m owner ! --uid-owner tor -p icmptype echo-request -j REJECT
      '';
      
      # Cleaning at specialisation exit
      extraStopCommands = ''
        iptables -t nat -F
      '';
    };

    # Welcome message
    services.getty.helpLine = lib.mkForce ''
      [ OSINT MODE ACTIVATED ]
      - Root : tmpfs (RAM)
    '';
  };
}