export-env {
  $env.MISE_SHELL = "nu"
  add-hook pre_prompt {
    condition: { "MISE_SHELL" in $env }
    code: { mise_hook }
  }
  add-hook env_change.PWD {
    condition: { "MISE_SHELL" in $env }
    code: { mise_hook }
  }
}

def --env add-hook [field hook] {
  let field = $field | split row . | prepend hooks | into cell-path
  let hooks = $env.config | get --ignore-errors $field | default []
  $env.config = ($env.config | upsert $field ($hooks ++ $hook))
}

def "parse vars" [] {
  $in | lines | parse "{op},{name},{value}"
}

export def --wrapped main [command?: string, --help, ...rest: string] {
  let commands = ["shell", "deactivate"]

  if ($command == null) {
    ^"/opt/homebrew/bin/mise"
  } else if ($command == "activate") {
    $env.MISE_SHELL = "nu"
  } else if ($command in $commands) {
    ^"/opt/homebrew/bin/mise" $command ...$rest
    | parse vars
    | update-env
  } else {
    ^"/opt/homebrew/bin/mise" $command ...$rest
  }
}

def --env "update-env" [] {
  for $var in $in {
    if $var.op == "set" {
      load-env {($var.name): $var.value}
    } else if $var.op == "hide" {
      hide-env $var.name
    }
  }
}

def --env mise_hook [] {
  ^"/usr/bin/env" mise hook-env -s nu
    | parse vars
    | update-env
}

