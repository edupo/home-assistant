! tty -s && return  # Guard against non interactive shells.

stty erase ^H intr ^C kill ^U start ^Q stop ^S susp ^Z eof ^D
set -o emacs
umask 027

export EDITOR=vim
export SERI_EDITOR=${EDITOR}
export FCEDIT=${EDITOR}
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well
export MANWIDTH=90


if [[ -f "${HOME}/.bash_aliases" ]]
then
	source "/home/vagrant/ws/home-assistant/bash/git.sh"
	source "${HOME}/.bash_aliases"
fi


if [[ -f "/home/vagrant/ws/home-assistant/bash/prompt.sh" ]]
then
    source "/home/vagrant/ws/home-assistant/bash/prompt.sh"
else
	H=$(hostname)
	# Pick your favorite PS1
		export PS1="$LOGNAME@${H%%.*}\$ "
fi

if [[ -f "${HOME}/.env" ]]
then
	source "${HOME}/.env"
fi

if [[ -f "${HOME}/ws/.venv/bin/activate" ]]
then
	source "${HOME}/ws/.venv/bin/activate"
fi