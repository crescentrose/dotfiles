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
- `brew bundle install`
  - Brewfile gets executed and installs Homebrew packages
- import gpg signing keys
  - this is now done through 1Password, yay!

kitty icon: [whiskers](https://github.com/igrmk/whiskers)
([instructions](https://sw.kovidgoyal.net/kitty/faq/#i-do-not-like-the-kitty-icon))

## screenshots

![zsh](doc/zsh.png)

![vim](doc/vim.png)
