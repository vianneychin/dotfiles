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
alias vim="nvim"
alias vi="nvim"
alias nvim-config="nvim ~/.config/nvim/init.lua"
alias ld-up="(cd ~/Dev/laradock;docker-compose up -d nginx mysql redis)"
alias ld-down="(cd ~/Dev/laradock;docker-compose down)"
alias ld-ssh="(cd ~/Dev/laradock;docker-compose exec workspace bash)"
alias ld-redis-cli="(cd ~/Dev/laradock;docker-compose run redis redis-cli -h redis)"



# ---------------------------------------------------------------------------------------------
# HISTORY SETTINGS
# ---------------------------------------------------------------------------------------------
HISTSIZE=10000
SAVEHIST=10000
zstyle ':completion:*' menu select



# ---------------------------------------------------------------------------------------------
# PATH & ENVIRONMENT VARIABLES
# ---------------------------------------------------------------------------------------------
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"



# ---------------------------------------------------------------------------------------------
# CUSTOM FUNCTIONS
# ---------------------------------------------------------------------------------------------
function addtolastcommit() {
    git add .
    git commit --amend --no-edit
}

# ---------------------------------------------------------------------------------------------
# MISC SETTINGS
# ---------------------------------------------------------------------------------------------
autoload -Uz compinit && compinit
export BAT_THEME=Material-Theme-Palenight
setopt NO_CASE_GLOB
if [ -f "$HOME/.zshrc.dmm" ]; then
    source "$HOME/.zshrc.dmm"
fi