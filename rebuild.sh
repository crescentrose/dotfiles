#!/bin/sh

sudo nixos-rebuild --flake ./nixos#streaming-heart --impure --recreate-lock-file switch
