export def --env to-env [] {
  let secrets = (from-op)
  load-env $secrets
  $env.SECRETS_LOADED = ($secrets | columns | length)
}

export def from-op [] {
  op signin --account my.1password.com
  op item get "Shell Environment" --vault "Development" --format json
    | jq '.fields | map(select(.section.label == "Environment")) | map({(.label): .value}) | add'
    | from json
}
