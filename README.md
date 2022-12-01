# crescentrose's dotfiles

Dotfiles managed by [Dotbot](https://github.com/anishathalye/dotbot).

## setup

this is a personal setup, it will install the apps and tools i use. if you do
not want that, make your own dotfiles repo.

- perform initial machine setup
  - log in to iCloud, App Store
  - install Homebrew `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
- `cd ~ && mkdir Code && cd Code && git clone git@github.com:crescentrose/dotfiles.git && cd dotfiles`
- `./install`
  - dotfiles get symlinked
  - vim plugins get installed
  - Brewfile gets executed and installs Homebrew packages
  - personal config file for Git gets opened for editing
- import gpg signing keys
  - `gpg --allow-secret-key-import --import private.key`
  - edit `~/.config/.gitconfig.local`

## screenshots

![zsh](doc/zsh.png)

![vim](doc/vim.png)
