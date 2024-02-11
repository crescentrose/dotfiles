# A place to put all the extra commands and aliases that I might need.

def kctx [] {
  kubectl config use-context (kubectl config get-contexts -o=name | fzf --height=30% --reverse)
}