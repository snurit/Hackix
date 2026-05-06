{ pkgs }: with pkgs; [
  # --- document editing / reading ---
  libreoffice-fresh
  hyphenDicts.fr_FR   # dictionnary - custom for your needs
  pandoc
  zathura
  
  # --- Internet ---
  thunderbird
  
  # --- Graphisme & Captures ---
  drawio
  flameshot
]