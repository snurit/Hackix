{ pkgs }: with pkgs; [
  # --- PLATEFORMES & FRAMEWORKS ---
  maltego             # Interface graphique pour la cartographie d'entités et liens
  spiderfoot          # Automatisation de collecte OSINT via APIs
  recon-ng            # Framework modulaire de reconnaissance (similaire à Metasploit)

  # --- INVESTIGATION DE PSEUDONYMES & RÉSEAUX SOCIAUX (SOCMINT) ---
  sherlock            # Recherche de noms d'utilisateur sur des centaines de sites
  sherlock-launcher   # Interface ou script de lancement simplifié pour Sherlock
  maigret             # Collecte de profils et dossiers à partir d'un pseudo
  ghunt               # Investigation avancée sur les comptes Google (E-mail, GaiaID)
  instaloader         # Outil de récupération de données et médias Instagram

  # --- DNS, IP & ÉNUMÉRATION D'INFRASTRUCTURE ---
  amass               # Énumération d'actifs et cartographie de surface d'attaque
  assetfinder         # Recherche de domaines et sous-domaines liés à un domaine cible
  subfinder           # Découverte de sous-domaines via sources passives
  jsubfinder          # Recherche de sous-domaines et secrets dans les fichiers JS
  dnsenum             # Énumération DNS (transfert de zone, brute force, Google scraping)
  ipinfo              # Utilitaire CLI pour obtenir des détails géographiques et ASN d'IP
  theharvester        # Collecte d'emails, sous-domaines et noms d'employés

  # --- EXIF EXTRACTION & EXPLOITATION ---
  exiftool            # Le standard pour lire/écrire les métadonnées de fichiers
  exifprobe           # Analyse structurelle approfondie des métadonnées d'images
  exiflooter          # Recherche automatique de coordonnées GPS dans les images via URL/fichiers

  # --- EMAIL, PHONE & BREACH GATHERING ---
  holehe              # Vérifie si un email est utilisé sur 120+ services
  h8mail              # Recherche de mots de passe fuités et analyse de brèches
  python313Packages.ignorant # Vérifie si un numéro de téléphone est enregistré sur diverses apps

  # --- ANONYMAT & TRANSFERT SÉCURISÉ ---
  onionshare-gui      # Partage de fichiers et sites anonymes via le réseau Tor
  tor-browser-bundle-bin # Navigateur Tor pour une navigation anonymisée

  # --- OUTILS DE PRÉSERVATION & ANALYSE ---
  yt-dlp              # Archivage de vidéos (YouTube, Twitter, etc.)
  gallery-dl          # Téléchargement massif d'images
  mat2                # Nettoyage des métadonnées avant diffusion de rapport
  sqlitebrowser       # Exploration de bases de données (historique, apps)
  obsidian            # Gestion de la connaissance et rapports d'investigation

  nyx
  torsocks

  # TO BE CONTINUED
]