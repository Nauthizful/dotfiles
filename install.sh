#!/usr/bin/env bash
set -e

# 1. Installer Oh My Zsh en mode non-interactif s'il n'est pas déjà présent
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# 2. Cloner les plugins externes
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
[ ! -d "$ZSH_CUSTOM/plugins/fzf-tab" ] && git clone https://github.com/Aloxaf/fzf-tab "$ZSH_CUSTOM/plugins/fzf-tab"

# 3. Installer le binaire fzf si absent
if ! command -v fzf >/dev/null 2>&1; then
  git clone --depth 1 https://github.com/junegunn/fzf.git /tmp/fzf
  /tmp/fzf/install --bin
  sudo cp /tmp/fzf/bin/fzf /usr/local/bin/
  rm -rf /tmp/fzf
fi

# 4. Déployer tes fichiers de configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cp "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"
cp "$SCRIPT_DIR/.nanorc" "$HOME/.nanorc"

echo "Configuration déployée avec succès ! Lance 'zsh' pour l'utiliser."
