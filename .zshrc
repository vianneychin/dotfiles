# ---------------------------------------------------------------------------------------------
# POWERLEVEL10K & INITIAL SETUP
# ---------------------------------------------------------------------------------------------
# Enable Powerlevel10k instant prompt. Must be at the top for optimal performance.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source ~/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# ---------------------------------------------------------------------------------------------
# ALIASES
# ---------------------------------------------------------------------------------------------
# Simplify commands for efficiency and convenience.
alias g='git'
alias hosts='code /private/etc/hosts'
alias zed="open -a /Applications/Zed.app -n"

export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"


# ---------------------------------------------------------------------------------------------
# HISTORY SETTINGS
# ---------------------------------------------------------------------------------------------
HISTSIZE=10000
SAVEHIST=10000
zstyle ':completion:*' menu select


# ---------------------------------------------------------------------------------------------
# MISC SETTINGS
# ---------------------------------------------------------------------------------------------
autoload -Uz compinit && compinit