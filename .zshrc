# ---------------------------------------------------------------------------------------------
#
# POWERLEVEL10K & INITIAL SETUP
# ---------------------------------------------------------------------------------------------
# Enable Powerlevel10k instant prompt. Must be at the top for optimal performance.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ---------------------------------------------------------------------------------------------
# ZSH SYNTAX HIGHLIGHTING
# ---------------------------------------------------------------------------------------------
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ---------------------------------------------------------------------------------------------
# ZSH AUTOSUGGESTIONS
# ---------------------------------------------------------------------------------------------
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# ---------------------------------------------------------------------------------------------
# ALIASES
# ---------------------------------------------------------------------------------------------
# Simplify commands for efficiency and convenience.
alias g='git'
alias hosts='code /private/etc/hosts'
alias zed="open -a /Applications/Zed.app -n"
# alias cat="bat"
# alias ls="eza --color=always --long --git --no-filesize --no-time --no-user --no-permissions"
alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'
alias c="clear"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

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
source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme

# Set up fzf key bindings and fuzzy completions
eval "$(fzf --zsh)"

# Use fd instead of fzf
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}


export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

alias cd="z"

export BAT_THEME=Material-Theme-Palenight
setopt NO_CASE_GLOB


# Herd injected NVM configuration
export NVM_DIR="/Users/vc/Library/Application Support/Herd/config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

[[ -f "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh" ]] && builtin source "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh"

# Herd injected PHP binary.
export PATH="/Users/vc/Library/Application Support/Herd/bin/":$PATH


# Herd injected PHP 8.3 configuration.
export HERD_PHP_83_INI_SCAN_DIR="/Users/vc/Library/Application Support/Herd/config/php/83/"
