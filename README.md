# crescentrose's dotfiles

> [!NOTE]
> This branch contains only the dotfiles for my macOS set-up. You can find my NixOS set-up in the
> [`experimental`](https://github.com/crescentrose/dotfiles/tree/experimental) branch.


## setup

Clone the repository with submodules:

```sh
git clone --recursive git@github.com:crescentrose/dotfiles.git
```

### apps

The `Brewfile` should contain most apps I use on a regular basis, as well as all the CLI tools
referenced in this repo. It is divided into feature groups - by default, running `brew bundle` will
install all packages, but you can customize it by setting the `HOMEBREW_FEATURES` environment
variable to a comma-separated list of groups, like so:

```sh
HOMEBREW_FEATURES=basic,dev brew bundle # installs only `basic` and `dev` groups
HOMEBREW_FEATURES=cloud brew bundle # only set up the cloud development tools
```

The groups are:

| Group     | Contents                                                                       |
| --------- | ------------------------------------------------------------------------------ |
| `basic`   | core dependencies: terminal emulator, shell, coreutils, fonts, basic CLI tools |
| `dev`     | development tools: version managers, compilers/interpreters, other tools       |
| `desktop` | desktop apps served as casks                                                   |
| `mac`     | desktop apps from the Mac App Store                                            |
| `cloud`   | cloud development tools like docker, openshift, k8s, google cloud, terraform   |

After the setup, remember to **create a local gitconfig file** at `~/.config/gitconfig.local`. It
should, at minimum, contain your name, email and signing key, but I usually put in the 1password
signing config and any other private repo configuration I might have.

### starship (prompt)

starship requires some extra setup with `nushell`:

```nu
mkdir ~/.cache/starship                                 # set up cache directory
starship init nu | save -f ~/.cache/starship/init.nu    # initialize cache
```

[source](https://starship.rs/guide/#%F0%9F%9A%80-installation)

## links

Dotfiles are managed with [Dotbot](https://github.com/anishathalye/dotbot).
