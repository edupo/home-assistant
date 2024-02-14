#!/bin/sh

# Copyright (c) <year> <copyright holders>

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

ALIAS_FILE="$HOME/.bash_aliases"
SHRC_FILE="$HOME/.bashrc"
GITIGNORE_FILE="$HOME/gitignore"

# Add some colors to this script in case the shell supports it.
COLORS=$(tput colors 2> /dev/null)
if [ $? = 0 ] && [ "$COLORS" -gt 2 ]; then
    ESC='\033['
    N="${ESC}0m";      R="${ESC}31m";     G="${ESC}32m"; 
    Y="${ESC}33m";     B="${ESC}34m";     P="${ESC}35m"; 
    C="${ESC}36m";     W="${ESC}37m"
else
    N='';           R='';           G='';            
    Y='';           B='';           P='';     
    C='';           W=''
fi

# Some helper functions.
msg() {
    if [ -z "$3" ]; then
        echo -e "[${1}${N}] ${C}${2}${N}"
    else
        echo -e "[${1}${N}] ${C}${2}${N}: ${3}"
    fi 
}

info() { 
    msg "${B}I" "${1}" "${2}" 
}

skip() { 
    msg "${Y}S" "${1}" "${2}" 
}

info "version" "2024.0.1"

################################################################################
# bash 
################################################################################

cat > "$ALIAS_FILE" <<EOF
alias cd-="cd -"
alias cd....="cd ../../.."
alias cd...="cd ../.."
alias cd..="cd .."

alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'

alias run="docker run --rm -ti -v\$PWD:\$PWD:Z -w \$PWD"
alias ports="netstat -tulpn"
alias reload="source ~/.bashrc"
alias shred="shred -vzun 10"
alias shredir="find . -type f -exec shred -vzun 10 {} \;"
EOF

cat > "$SHRC_FILE" <<EOF
! tty -s && return
umask 027

export EDITOR=vim
export SERI_EDITOR=\${EDITOR}
export FCEDIT=\${EDITOR}
export HISTCONTROL=\$HISTCONTROL\${HISTCONTROL+,}ignoredups
export HISTIGNORE=\$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well

source "\${HOME}/.bash_aliases" 2> /dev/null
source "\${HOME}/.env" 2> /dev/null
source "/etc/bash_completion" 2> /dev/null || source "/etc/profile.d/bash_completion.sh" 2> /dev/null

vcs_prompt (){
if [ -d .git ]; then
	ref=\$(git symbolic-ref HEAD 2> /dev/null)
	PS_VCS_SERVICE="git"
	PS_VCS_BRANCH="\${ref#refs/heads/}"
elif [ -d .svn ]; then
	PS_VCS_SERVICE="svn"
	PS_VCS_BRANCH="\$(svn info|awk '/Revision/{print \$2}')"
elif [ -d .hg ]; then
	PS_VCS_SERVICE="hg"
	PS_VCS_BRANCH="\$(hg branch)"
else
	PS_VCS_SERVICE=''
	PS_VCS_BRANCH=''
fi
}

_RS="\033[0m"
_RE="\033[31m"
_GR="\033[32m"
_BL="\033[34m"
_YE="\033[93m"
_DY="\033[33m"

PROMPT_COMMAND=vcs_prompt

PS_BRANCH="\$_DY\\\$PS_VCS_SERVICE \$_YE\\\$PS_VCS_BRANCH"
PS_BRANCH_SIZE="\\\${#PS_VCS_SERVICE}-\\\${#PS_VCS_BRANCH}"
PS_VCS="\[\033[\\\$((COLUMNS-1-\$PS_BRANCH_SIZE))G\] \$_YE\$PS_BRANCH"

PS_INFO="\$_GR\u@\h\$_RS:\$_BL\w"

export PS1="\$_RS\${PS_INFO} \${PS_VCS}\${_RS}\n\$ "

EOF

################################################################################
# git
################################################################################

if [ "$(which git)" ]; then


    _git_config() {
        if [ ! "$(git config --global "$1")" ]; then
            read -rp "Type $2: " _T
            git config --global "$1" "$_T"
        fi
    }
    info "git" 
	git config --global core.excludesfile "$GITIGNORE_FILE"
	git config --global credential.helper cache
	git config --global credential.helper 'cache --timeout=3600'
	git config --global push.default simple
	git config --global credential.helper store
	git config --global push.autoSetupRemote true
    # https://blog.gitbutler.com/fosdem-git-talk/
	git config --global rerere.enabled true
	_git_config "user.name" "complete user name"
	_git_config "user.email" "user email"
	_git_config "user.company" "company name"
	_git_config "user.github" "github user"
	# _git_config "user.baseurl" "url of your main git repository"

    cat >> "$ALIAS_FILE" <<EOF
alias aa="git add -A"
alias amend="git commit --amend --no-edit"
alias ap="git add -u; git commit --amend --no-edit; git push --force-with-lease"
alias au="git add -u"
alias binfo="git branch -vv"
alias c="git commit -m"
alias ca="git commit -a -m"
alias d="git diff"
alias diff="git diff"
alias merge="git merge"
alias pull="git pull"
alias push="git push"
alias reset="git reset"
alias s="git status"
alias stash="git stash"
alias subm="git submodule update --init --recursive"
EOF

    cat >> "$SHRC_FILE" <<EOF
bclean() {
  DEFAULT_BRANCH="\$(git symbolic-ref refs/remotes/origin/HEAD \
    | sed 's@^refs/remotes/origin/@@')"
  git branch --merged "\$DEFAULT_BRANCH" \
    | grep -v "\$DEFAULT_BRANCH" \
    | xargs -n 1 git branch -d
}

co() {
  if [ -z "\$1" ]; then
    echo -e "-- ERROR: No branch expression provided!\
     \n\n\tusage: co <expression> [remote]\n\n\
     \n\nco/checkout finds a git branch by expression and checks it out."
    return
  fi
  if [ -z \$2 ]; then
    BRANCH="\$(git branch --list "*\$1*" | sed -e 's/^[\* ]*//;q')"
  else
    BRANCH="\$(git branch -r --list "*\$2*\$1*" | sed -e 's/[\* ]*//;q')"
  fi
  if [ -z "\$BRANCH" ]; then
    echo "-- No branch found for expression '\$1'"
    return
  fi
  echo "-- Found branch: \$BRANCH"
  git checkout "\$BRANCH"
}
EOF

else
    skip "git" "Not detected"
fi

################################################################################
# tmux 
################################################################################

if [ "$(which tmux)" ]; then
    info "tmux" 
    cat > "$HOME/.tmux.conf" <<EOF
# Sets copy-mode to vi
set-window-option -g mode-keys vi

# Enabling vim style pane navigation
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
EOF
else
    skip "tmux" "Not detected"
fi

################################################################################
# vim
################################################################################

if [ "$(which tmux)" ]; then
    info "vim" 
    cat > "$HOME/.vimrc" <<EOF
syntax enable
set number
set textwidth=80
set expandtab
set tabstop=2
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
EOF
else
    skip "vim" "Not detected"
fi