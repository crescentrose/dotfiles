# @crescentrose's currently used apps and utilities.

tap "hashicorp/tap"
tap "homebrew/autoupdate"
tap "homebrew/bundle"
tap "homebrew/cask-fonts"
tap "homebrew/services"
tap "rsteube/homebrew-tap"

# Pass the desired features to the `HOMEBREW_FEATURES` environment variable
features = ::ENV.fetch("HOMEBREW_FEATURES", "basic,dev,desktop,mac,cloud").split(",").map(&:to_sym)

# 💻 Basic {{{

if features.include? :basic
  # World's greatest terminal emulator.
  cask "kitty"
  # Unix shell (command interpreter)
  brew "zsh"
  # Modern shell for the GitHub era
  brew "nushell"
  # GNU File, Shell and Text utilities
  brew "coreutils"

  # Free monospaced font with programming ligatures
  cask "font-fira-code-nerd-font"
  # Developer targeted fonts with a high number of glyphs
  cask "font-fantasque-sans-mono-nerd-font"
  # Symbols Nerd Font (Symbols Only)
  cask "font-symbols-only-nerd-font"

  # A cat(1) clone with wings.
  brew "bat"
  # 🌸 A command-line fuzzy finder
  brew "fzf"
  # Improved top (interactive process viewer)
  brew "htop"
  # Search tool like grep and The Silver Searcher
  brew "ripgrep"
  # Lightweight and flexible command-line JSON processor
  brew "jq"
  # Git large file support
  brew "git-lfs"
  # Cross-shell prompt for astonauts
  brew "starship"
  # Multi-shell multi-command argument completer
  brew "rsteube/tap/carapace"
  # Render markdown on the CLI
  brew "glow"
  # nvim
  brew "nvim"
end

# }}}

# 💎 Development - Languages, Databases, Tools {{{

if features.include? :dev
  # Command-line interface for SQLite
  brew "sqlite"
  # Interpreted, interactive, object-oriented programming language
  brew "python"
  # Rust toolchain installer
  brew "rustup"
  # Polyglot runtime manager (asdf rust clone)
  brew "mise"

  # Utility that creates projects from templates
  brew "cookiecutter"
  # GitHub command-line tool
  brew "gh"
  # Framework for managing multi-language pre-commit hooks
  brew "pre-commit"
  # Tools for the WireGuard secure network tunnel
  brew "wireguard-tools"
end

# }}}

# 🐭 Desktop Apps {{{

if features.include? :desktop
  # Password manager that keeps all passwords secure behind one password
  cask "1password"
  # Music player focusing on visuals
  cask "plexamp"
  # Knowledge base that works on top of a local folder of plain text Markdown files
  cask "obsidian"
  # Control your tools with a few keystrokes
  cask "raycast"
  # Assign keys, and then decorate and label them
  cask "elgato-stream-deck"
  # Open-source code editor
  cask "visual-studio-code"
end

# }}}

# 🍎 Mac App Store apps {{{

if features.include? :mac
  # Simple CLI interface for the Mac App Store
  brew "mas"
  # Fill and save your passwords
  mas "1Password for Safari", id: 1569813296
  # Adblock and privacy
  mas "AdGuard for Safari", id: 1440147259
  # Hide menubar items
  mas "Hidden Bar", id: 1452453066
  # Organize Your Workspace
  mas "Magnet", id: 441258766
end

# }}}

# ☁  Cloud development {{{

if features.include? :cloud
  # Pack, ship and run any application as a lightweight container
  brew "docker"
  # Isolated development environments using Docker
  brew "docker-compose"
  # Toolkit for embedding hypervisor capabilities in your application. Required
  # for minikube.
  brew "hyperkit"
  # Run a Kubernetes cluster locally.
  brew "minikube"
  # OpenShift command-line interface tools
  brew "openshift-cli"
  # Terraform enables you to safely and predictably create, change, and improve
  # infrastructure
  brew "hashicorp/tap/terraform"
  # Manage Secrets & Protect Sensitive Data
  brew "hashicorp/tap/vault"
  # The Kubernetes Package Manager
  brew "helm"
  # Set of tools to manage resources and applications hosted on Google Cloud
  cask "google-cloud-sdk"
  # Kubernetes CLI To Manage Your Clusters In Style!
  brew "k9s"
end

# }}}

# vim: fdm=marker fdl=0 ft=ruby
