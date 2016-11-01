. ~/.scripts/file_search.sh
. ~/.scripts/git.sh

# git alias #
#############

alias s="git status"
alias c="git commit -m"
alias ca="git commit -a -m"
alias aa="git add -A"
alias au="git add -u"
alias push="git push"
alias pus="git push"
alias pull="git pull"
alias pul="git pull"
alias co=git_checkout
alias checkout=git_checkout
alias re="git reset"
alias reset="git reset"
alias d="git diff"
alias diff="git diff"
alias me="git merge"
alias merge="git merge"
alias stash="git stash"
alias stas="git stash"
alias binfo="git branch -vv"

# bash alias #
##############
alias reload="source ~/.bashrc"
# path alias #
##############

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias cd..="cd .."
alias cd...="cd ../.."
alias cd....="cd ../../.."

alias cd-="cd -"

# grep alias #
##############

alias usages=list_occurrences
alias count=count_occurrences
alias replace=replace_text

# apt-get alias #
#################

alias sgi="sudo apt-get install"
 
# stylish alias #
#################
alias style="astyle --style=allman --indent=force-tab --indent-cases --break-blocks --pad-oper --pad-header -k1 -W1 -j -O"
alias pre="style *.cpp *.h"
