{ pkgs }: with pkgs; [
  # --- ACQUISITION ET IMAGING ---
  guymager            # Interface graphique pour l'acquisition d'images disque
  dc3dd               # Version patchée de dd pour les besoins forensiques
  ewf-tools           # Outils pour manipuler le format Expert Witness (.E01)

  # --- ANALYSE DE SYSTÈMES DE FICHIERS ---
  sleuthkit           # La suite de référence (fls, mactime) pour l'analyse de partitions
  autopsy             # Interface graphique pour l'analyse forensique de disques
  dislocker           # Lecture de partitions chiffrées BitLocker[cite: 1]
  apfs-fuse           # Support pour le système de fichiers Apple APFS[cite: 1]

  # --- RÉCUPÉRATION DE DONNÉES (CARVING) ---
  testdisk            # Récupération de partitions perdues[cite: 1]
  photorec            # Carving de fichiers basé sur les signatures[cite: 1]
  foremost            # Extraction de fichiers basée sur les headers/footers[cite: 1]
  bulk-extractor      # Extraction massive de patterns (emails, URL) sans parsing FS[cite: 1]

  # --- ANALYSE MÉMOIRE (RAM) ---
  volatility3         # Le framework leader pour l'analyse de dumps mémoire[cite: 1]
  avml                # Acquéreur de mémoire volatile pour Linux (par Microsoft)[cite: 1]

  # --- REVERSE ENGINEERING (STATIQUE & DYNAMIQUE) ---
  ghidra-bin          # Suite de reverse engineering de la NSA (décompilateur performant)[cite: 1]
  cutter              # Interface graphique moderne pour Rizin/Radare2[cite: 1]
  rizin               # Fork de Radare2, framework de reverse engineering en CLI[cite: 1]
  iaito               # Interface graphique officielle pour Rizin (alternative à Cutter)[cite: 1]
  gdb                 # Le débogueur standard GNU[cite: 1]
  pwndbg              # Extension GDB orientée exploit dev et reverse[cite: 1]
  radare2             # Framework complet d'analyse binaire et de désassemblage[cite: 1]
  floss               # Extraction automatique de chaînes de caractères obfusquées dans les malwares[cite: 1]
  upx                 # Compression et décompression d'exécutables[cite: 1]
  strace              # Monitoring des appels système[cite: 1]
  ltrace              # Monitoring des appels aux bibliothèques partagées[cite: 1]

  # --- ANALYSE DE FICHIERS ET BINAIRES ---
  exiftool            # Lecture de métadonnées (images, documents)[cite: 1]
  binwalk             # Recherche de fichiers et code cachés dans des binaires[cite: 1]
  imhex               # Éditeur hexadécimal moderne avec éditeur de patterns[cite: 1]
  file                # Identification du type de fichier[cite: 1]
  strings             # Extraction de chaînes de caractères imprimables[cite: 1]

  # --- ANALYSE WINDOWS & REGISTRE ---
  chntpw              # Édition du registre Windows et reset de mots de passe[cite: 1]
  regripper           # Extraction automatisée de données depuis le registre[cite: 1]
  hivex               # Manipulation des ruches du registre Windows[cite: 1]

  # --- CRYPTOGRAPHIE & TIMELINES ---
  hashdeep            # Hachage récursif multi-algorithmes[cite: 1]
  bruteforce-luks     # Tentatives de récupération de clés LUKS
  plaso               # Outil de création de timelines massives (Log2Timeline)[cite: 1]
  john                # Cassage de mots de passe de fichiers protégés[cite: 1]
  
  # --- DIVERS ---
  sqlite              # Analyse de bases de données (historique, apps mobiles)[cite: 1]
  rsync               # Copie de fichiers robuste préservant les attributs[cite: 1]
]