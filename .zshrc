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
source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme


# ---------------------------------------------------------------------------------------------
#
# FZF SHELL INTEGRATAION
# ---------------------------------------------------------------------------------------------
source <(fzf --zsh)
# Unbind Ctrl+T from fzf
bindkey -r '^T'



# ---------------------------------------------------------------------------------------------
# DOTFILES VERSION CONTROL VIA GIT
# ---------------------------------------------------------------------------------------------
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# After sourcing the .zshrc file with the dotfiles alias, run the following commands:
#   - dotfiles config --local status.showUntrackedFiles no
#   - git clone --bare https://github.com/vianneychin/dotfiles $HOME/.dotfiles
#   - dotfiles checkout



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
alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'
alias c="clear"
alias vim="nvim" # xd
alias vi="nvim" # xd
alias ld-up="(cd ~/Projects/laradock;docker-compose up -d nginx mysql redis)"
alias ld-down="(cd ~/Projects/laradock;docker-compose down)"
alias ld-ssh="(cd ~/Projects/laradock;docker-compose exec workspace bash)"
alias ld-redis-cli="(cd ~/Projects/laradock;docker-compose run redis redis-cli -h redis)"



# ---------------------------------------------------------------------------------------------
# HISTORY SETTINGS
# ---------------------------------------------------------------------------------------------
HISTSIZE=10000
SAVEHIST=10000
zstyle ':completion:*' menu select



# ---------------------------------------------------------------------------------------------
# CUSTOM FUNCTIONS
# ---------------------------------------------------------------------------------------------
function pushDotFiles() {
    dotfiles add -u
    dotfiles commit -m "Update dotfiles"
    dotfiles push origin main
}

function addtolastcommit() {
    git add .
    git commit --amend --no-edit
}

function addToPath() {
    if [[ "$PATH" != *"$1"* ]]; then
        export PATH=$PATH:$1
    fi
}

function addToPathFront() {
    if [[ "$PATH" != *"$1"* ]]; then
        export PATH=$1:$PATH
    fi
}




# ---------------------------------------------------------------------------------------------
# PATH & ENVIRONMENT VARIABLES
# ---------------------------------------------------------------------------------------------
addToPath $HOME/go/bin
addToPath ":/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
addToPathFront $HOME/.local/scripts




# ---------------------------------------------------------------------------------------------
# MISC SETTINGS
# ---------------------------------------------------------------------------------------------
autoload -Uz compinit && compinit
export BAT_THEME=Material-Theme-Palenight
setopt NO_CASE_GLOB
bindkey -v
if [ -f "$HOME/.zshrc.dmm" ]; then
    source "$HOME/.zshrc.dmm"
fi
if [ -f "$HOME/.zshrc.wowsims" ]; then
    source "$HOME/.zshrc.wowsims"
fi

bindkey -s ^t "tmux-sessionizer\n"
# Source the file since the cd $target won't persists in a subshell script
bindkey -s ^f "source ~/.local/scripts/nvim-quick-open-folder\n"
