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
alias grep='rg --hidden'

# Makes Claude code 14x faster
# https://machinedreams.blog/posts/tips-to-make-claude-code-work-faster/
alias find='fd'
alias ls='eza'
alias cat='bat'
alias sed='sd'
alias du='dust'
alias top='btm'
alias ps='procs'

alias g='git'
alias hosts='sudo nvim /private/etc/hosts'
alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'
alias c="clear"
alias vim="nvim"
alias vi="nvim"

alias ld-up="(cd ~/Projects/laradock;docker-compose up -d nginx mysql redis)"
alias ld-down="(cd ~/Projects/laradock;docker-compose down)"
alias ld-restart="ld-down; ld-up"
alias ld-ssh="(cd ~/Projects/laradock;docker-compose exec workspace bash)"
alias ld-redis-cli="(cd ~/Projects/laradock;docker-compose run redis redis-cli -h redis)"

# alias ld-wdl-up="(cd ~/Projects/laradock-wdl;docker-compose up -d nginx mysql redis)"
# alias ld-wdl-down="(cd ~/Projects/laradock-wdl;docker-compose down)"
# alias ld-wdl-restart="ld-wdl-down; ld-wdl-up"
# alias ld-wdl-ssh="(cd ~/Projects/laradock-wdl;docker-compose exec workspace bash)"
# alias ld-wdl-redis-cli="(cd ~/Projects/laradock-wdl;docker-compose run redis redis-cli -h redis)"


# ---------------------------------------------------------------------------------------------
# HISTORY SETTINGS
# ---------------------------------------------------------------------------------------------
HISTSIZE=10000
SAVEHIST=10000
zstyle ':completion:*' menu select



# ---------------------------------------------------------------------------------------------
# CUSTOM FUNCTIONS
# ---------------------------------------------------------------------------------------------
function pushdotfiles() {
    dotfiles add -u;
    dotfiles add ~/.config/nvim;
    dotfiles add ~/.config/ghostty;
    dotfiles add ~/.claude/settings.json;
    dotfiles commit -m "(Auto message) Update dotfiles";
    dotfiles push origin main --force;
    echo "\033[32mSuccessfully pushed dotfiles.\033[0m"
}

function pulldotfiles() {
    dotfiles pull origin main
    tmux source-file ~/.config/tmux/tmux.conf                                                                                                                                                                                                                      17:17:02
    source ~/.zshrc
    echo "\033[32mSuccessfully pulled dotfiles and reloaded configurations.\033[0m"
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

function rebuildLaradockPhp() {
    cd ~/Projects/laradock;docker-compose down
    docker-compose build php-fpm
    docker-compose build workspace
    cd ~/Projects/laradock;docker-compose up -d nginx mysql redis
}




# ---------------------------------------------------------------------------------------------
# PATH & ENVIRONMENT VARIABLES
# ---------------------------------------------------------------------------------------------
addToPathFront $HOME/.local/scripts
addToPath $HOME/go/bin
addToPath ":/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
addToPath "/opt/homebrew/opt/ruby/bin:$PATH"
addToPath $HOME/.cargo/bin
addToPath $HOME/.local/share/bob/nvim-bin
# addToPath "/opt/homebrew/bin/composer"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "/Users/vc/.composer/vendor/bin" ] ; then
    PATH="/Users/vc/.composer/vendor/bin:$PATH"
fi



# ---------------------------------------------------------------------------------------------
# MISC SETTINGS
# ---------------------------------------------------------------------------------------------
autoload -Uz compinit && compinit
export BAT_THEME=Material-Theme-Palenight
setopt NO_CASE_GLOB

if [ -f "$HOME/.zshrc.dmm" ]; then
    source "$HOME/.zshrc.dmm"
fi
if [ -f "$HOME/.zshrc.wowsims" ]; then
    source "$HOME/.zshrc.wowsims"
fi

# Keybindings for running script files
bindkey -s "^t" "tmux-sessionizer\n"
bindkey -s "^f" "source ~/.local/scripts/nvim-quick-open-folder\n"

eval "$(rbenv init -)"

# pnpm
export PNPM_HOME="/Users/vc/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
alias ld-ssh="(cd ~/Projects/laradock;docker-compose exec workspace bash -c \"cd /var/www/work && exec bash\")"
