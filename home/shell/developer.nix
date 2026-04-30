{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # 🤓 C
    gcc
    pkg-config

    # 🐳 Docker
    docker-language-server

    # 🐭 Go
    go_1_26
    gopls
    delve
    golangci-lint
    golangci-lint-langserver

    # ☁️ Google Cloud
    (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])
    kubectl

    # ☕ Javascript
    nodejs_24
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

    # 💎 Ruby
    ruby_4_0
    ruby-lsp

    # 📝 TOML
    taplo
  ];
}
