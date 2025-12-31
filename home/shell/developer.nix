{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # 🤓 C
    gcc
    pkg-config

    # 🐳 Docker
    docker-language-server

    # 🐭 Go
    go
    gopls
    delve
    golangci-lint
    golangci-lint-langserver

    # ☁️ Google Cloud
    google-cloud-sdk
    kubectl

    # ☕ Javascript
    nodejs_24
    pnpm
    typescript-language-server # javascript, typescript
    vscode-langservers-extracted # html, css, json, eslint

    # ❄️ Nix
    nixd
    nixfmt-rfc-style # nix formatter

    # 🐍 Python
    uv

    # 🦀 Rust
    rustup

    # 🏗️ Terraform
    terraform
    terraform-ls

    # 📝 TOML
    taplo
  ];
}
