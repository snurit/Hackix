{ pkgs }: with pkgs; [
  # system and other common tools
  nano
  git
  rsync
  curl
  wget
  brave
  keepassxc
  veracrypt
  parted
  gparted
  
  # productivity tools
  trilium-desktop
  obsidian
  vlc
  texlive.combined.scheme-medium
  vscodium
  brave

  # security
  bleachbit
  wipe

  # Network security
  mullvad-vpn
  protonvpn-gui

  # Archive
  zip
  unzip
  p7zip
  gnutar
  atool
  ark
]