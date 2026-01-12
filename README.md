# crescentrose's dotfiles

|   |   |
|---|---|
|![screenshot](./resources/screenshot-clean.png)|![screenshot](./resources/screenshot-dirty.png)|

## Setup

There are two variants: a pure NixOS variant with a custom desktop shell, and a
macOS variant that shares a small part of the command-line configuration for
consistency with my work machine.

> [!TIP]
> Activate the development environment (`nix develop`) to use the provided
> scripts for (re)building on the appropriate platform. 

### NixOS

This is a standard Nix flake. so on a NixOS system, running `sudo nixos-rebuild
--flake ./nixos#starlight switch` should do the trick. Note that you will need a
handful of _secrets_ - refer to the flake files for details. Also, the wallpaper
directory is not distributed as a part of this repo as that would be rude to
the artists - find your own wallpapers! Improving the setup experience is on my
to-do list, but it's not yet ready.

This set-up is tweaked for my desktop PC and is currently not very modular or
extensible. Improving this is also on my to-do list.

### macOS

The macOS variant assumes [Determinate Nix] as it has a better setup experience
and plays better with various corporate tools.

In addition to Determinate Nix, you should also set up [Homebrew].

For initial set-up, run:

```sh
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .
```

Afterwards, you can use `darwin-rebuild` to apply changes:

```sh
sudo darwin-rebuild switch --flake .
```

[Determinate Nix]: https://determinate.systems/nix/
[Homebrew]: https://brew.sh

## Attribution

Due to popular demand, there's now a license in this repo.

Except specific files which bear a different mention, this programme is licensed
under the [EUPL-1.2 or later]. Official translations are available on the
[website of the European Commission].

[EUPL-1.2 or later]: ./LICENSE
[website of the European Commission]: https://interoperable-europe.ec.europa.eu/collection/eupl/eupl-text-eupl-12
