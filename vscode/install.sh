#!/bin/sh

CURRENT_DIR=$(pwd)

if command -v code >/dev/null; then
  if [ "$(uname -s)" = "Darwin" ]; then
    VSCODE_HOME="$HOME/Library/Application Support/Code"
  else
    VSCODE_HOME="$HOME/.config/Code"
  fi
  mkdir -p "$VSCODE_HOME/User"

  ln -sf "$CURRENT_DIR/vscode/settings.json" "$VSCODE_HOME/User/settings.json"
  ln -sf "$CURRENT_DIR/vscode/keybindings.json" "$VSCODE_HOME/User/keybindings.json"

  while read -r module; do
    code --install-extension "$module" || true
  done <"$CURRENT_DIR/vscode/extensions.txt"
fi