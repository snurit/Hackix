{
    description = "Hackix - A flavoured version of NixOS for security auditors and pentesters";

    # Based on Nixos-unstable
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };

    outputs = { self, nixpkgs, ... }@inputs: 
    let
        system = "x86_64-linux";
        currentUser = "auditor";        # Customize with your username
        persistantFolder = "findings";  # Customize with the destination folder for your findings
    in {
    nixosConfigurations.hackix = nixpkgs.lib.nixosSystem {
        inherit system;
        # On passe myUser aux sous-modules pour la persistance
        specialArgs = { 
            inherit currentUser;
            inherit inputs;
        };
        
        modules = [
            ./common/configuration.nix
            ./common/hardware-configuration.nix
            ./modules/office
            ./modules/osint
            ./modules/forensic
            ./modules/pentest

            # Common configuration inherited by all specialisations
            ({ pkgs, ... }: {
                system.stateVersion = "25.11";
                networking.networkmanager.enable = true;
                networking.hostName = "localhost"; # generic name - change it if you want to
                networking.firewall.enable = true;

                # Defining / label name
                fileSystems."/" = {
                    device = "/dev/disk/by-label/NIXOS_ROOT"; # The label NIXOS_ROOT must be applied on your hard drive
                    fsType = "ext4";
                };

                # Defining the /nix folder on hard drive for working in air-gapped environments
                fileSystems."/nix" = {
                    device = "/dev/disk/by-label/NIXOS_ROOT";
                    fsType = "ext4";
                    neededForBoot = true;
                };

                # Defining findings drive for saving datas (can be a partition, an USB stick...) and must be labeled FINDINGS
                fileSystems."/home/${currentUser}/findings" = {
                device = "/dev/disk/by-label/FINDINGS";
                fsType = "ext4";
                options = [ 
                    "rw" 
                    "noatime" 
                    "sync"
                    "nofail" # avoid boot freeze if USB key or disk partition is missing
                    "x-systemd.device-timeout=5s" # wait 5 secs
                    ]; 
                };

                # LUKS management for FINDINGS disk or USB key
                boot.initrd.luks.devices."findings_crypt" = {
                    device = "/dev/disk/by-label/FINDINGS";
                    preLVM = true;
                    allowDiscards = true;
                };

                environment.systemPackages = import ./common/common-tools.nix { inherit pkgs; };

                # System wide docker activation
                virtualisation.docker.enable = true;

                users.users.${currentUser} = {
                    isNormalUser = true;
                    extraGroups = [ "wheel" "networkmanager" ];
                };

                # Improving network security
                networking.networkmanager = {
                    enable = true;
                    wifi.scanRandMacAddress = true;
                    
                    extraConfig = ''
                    [device]
                    wifi.scan-rand-mac-address=yes

                    [connection]
                    wifi.cloned-mac-address=stable
                    ethernet.cloned-mac-address=stable

                    hostname-mode=none
                    '';
                };
                services.pvpn.enable = true;

                boot.kernel.sysctl = {
                    # Ignore ICMP requests
                    "net.ipv4.icmp_echo_ignore_all" = lib.mkDefault 1;

                    # IP spoofing protection
                    "net.ipv4.conf.all.rp_filter" = lib.mkDefault 1;
                    "net.ipv4.conf.default.rp_filter" = lib.mkDefault 1;

                    # Reject ICMP redirection
                    "net.ipv4.conf.all.accept_redirects" = lib.mkDefault 0;
                    "net.ipv4.conf.default.accept_redirects" = lib.mkDefault 0;
                    "net.ipv6.conf.all.accept_redirects" = lib.mkDefault 0;
                    "net.ipv6.conf.default.accept_redirects" = lib.mkDefault 0;
                };
            })
        ];
        };
    };
}