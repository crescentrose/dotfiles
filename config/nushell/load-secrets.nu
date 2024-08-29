export def get-secrets [] {
  op signin --account my.1password.com
  op item get "Shell Environment" --vault "Development" --format json
    | jq '.fields | map(select(.section.label == "Environment")) | map({(.label): .value}) | add'
    | from json
}

export def --env from-1password [] {
  let secrets = (get-secrets)
  load-env $secrets
  $env.SECRETS_LOADED = ($secrets | columns | length)
}
