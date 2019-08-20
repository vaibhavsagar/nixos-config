#!/usr/bin/env bash

set -euxo pipefail

TARGET="root@147.75.38.113"

PROFILE_PATH="$(nix-build --no-out-link default.nix)"
nix-copy-closure --to --use-substitutes $TARGET $PROFILE_PATH
ssh $TARGET -- "nix-env --profile /nix/var/nix/profiles/system --set $PROFILE_PATH && /nix/var/nix/profiles/system/bin/switch-to-configuration switch"
