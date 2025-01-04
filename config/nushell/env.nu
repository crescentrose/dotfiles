# Nushell Environment Config File
#
# version = "0.90.2"

$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

let custom_paths = [
    '/opt/homebrew/bin'
    ([$env.HOME ".bun/bin"] | path join)
    ([$env.HOME ".local/bin"] | path join)
    ([$env.HOME ".cargo/bin"] | path join)
    ([$env.HOME "bin"] | path join)
]

# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
]

# Directories to search for plugin binaries when calling register
# The default for this is $nu.default-config-dir/plugins
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

if not ("VIRTUAL_ENV" in $env) {
  $env.PATH = ($env.PATH | split row (char esep) | prepend $custom_paths)
}

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ": "
$env.PROMPT_INDICATOR_VI_NORMAL = "〉"
$env.PROMPT_MULTILINE_INDICATOR = "::: "

$env.EDITOR = "nvim"

$env.BAT_THEME = "ansi" # basic bitch...

# Completions
$env.CARAPACE_BRIDGES = 'carapace,bash,zsh,yargs,complete,clap'
if (not ("~/.cache/carapace/init.nu" | path exists)) {
  mkdir ~/.cache/carapace
  carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
}

# Other configuration files
$env.RIPGREP_CONFIG_PATH = ($env.HOME | path join ".config/.ripgreprc")
$env.MISE_GO_DEFAULT_PACKAGES_FILE = ($env.HOME | path join ".config/mise/default-go-packages")
