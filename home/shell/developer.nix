{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # 🤓 C
    gcc
    pkg-config

    # 🐳 Docker
    docker-language-server

    # 🐭 Go
    go_1_27
    gopls
    delve
    golangci-lint
    golangci-lint-langserver

    # ☁️ Google Cloud
    (google-cloud-sdk.withExtraComponents [
      google-cloud-sdk.components.gke-gcloud-auth-plugin
      google-cloud-sdk.components.package-go-module
    ])
    kubectl

    # ☕ Javascript
    nodejs_26
    pnpm
    typescript-language-server # javascript, typescript
    vscode-langservers-extracted # html, css, json, eslint

    # ❄️ Nix
    nixd
    nixfmt # nix formatter
    nil # language server

    # 🐍 Python
    uv

    # 🦀 Rust
    rustup

    # SQL
    pgcli

    # 📝 TOML
    taplo
  ];
}
