#!/usr/bin/env bash

# install mise if not already installed to local path
if ! command -v mise &>/dev/null; then
    echo "Load mise into your path (add to your ~/.zshrc profile to always be available): "
    echo '   echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc'
    eval "$(~/.local/bin/mise activate bash)"
else
    eval "$(mise activate bash)"
fi

mise install -y
