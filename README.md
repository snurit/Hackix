# Hackix
A NixOS flake for making a reproductible and always ready to use security assessment environment (pentest, OSINT, ...).

## How to use it
- Install a fresh version of NixOS without desktop environment
- give the label NIXOS_ROOT to your hard drive
- Activate flake support (add **nix.settings.experimental-features = [ "nix-command" "flakes" ];** to your **/etc/nixos/configuration.nix**)
- Clone the hackix repository and open it
- Copy yours **/etc/nixos/configuration.nix** and **etc/nixos/hardware-configuration.nix** to **/common**
- In the root flake.nix, customize **currentUser** (your NixOS username) and **persistantFolder** (ex : a folder in your home for saving findings, in OSINT environment too)
- Build Hackix

## How to build Hackix
Some different options called "specialisations" are available :
- OSINT : for OSINT investigations, no persistence (Hackix is loaded only in RAM : impermanence)
- Pentest-AD : For pentesting Windows environments
- Pentest-Web : For pentesting web apps
- Pentest-full : install all pentesting tools (OSINT excluded)