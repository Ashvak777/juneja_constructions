#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
ENV_FILE="github-auth.local.env"
if [[ ! -f "$ENV_FILE" ]]; then
  echo "Missing $ENV_FILE — copy github-auth.local.env.example to $ENV_FILE and add GITHUB_TOKEN."
  exit 1
fi
# shellcheck source=/dev/null
set -a
source "$ENV_FILE"
set +a
if [[ -z "${GITHUB_TOKEN:-}" || "$GITHUB_TOKEN" == "" ]]; then
  echo "Set GITHUB_TOKEN in $ENV_FILE then run ./push.sh again."
  exit 1
fi
if [[ "$GITHUB_TOKEN" == "XXX" ]]; then
  echo "Replace XXX in GITHUB_TOKEN=$ENV_FILE with your real token, then run ./push.sh again."
  exit 1
fi
REMOTE="https://${GITHUB_USERNAME:-Ashvak777}:${GITHUB_TOKEN}@github.com/Ashvak777/juneja_constructions.git"
git remote set-url origin "$REMOTE"
git push -u origin main
git remote set-url origin https://github.com/Ashvak777/juneja_constructions.git
echo "Pushed. Remote reset to HTTPS without token."
