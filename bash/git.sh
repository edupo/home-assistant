# Checks the remote if a remote exists and returns its name
git_checkremote() {
	REMOTE=""
	if [ ! -z $1 ]; then
		REMOTE=$(git remote | grep $1 -c)
		if [ "$REMOTE" -eq 0 ]; then
			echo "No remote found for the expression '$1'"
			return 1
		fi
		if [ "$REMOTE" -gt 1 ]; then
			echo "$REMOTE remotes found for the expression '$1'. Please, be concrete."
			return 1
		fi
		REMOTE=$(git remote | grep $1) 
		return 0
	else
		return 1
	fi
}

# Checks out the first branch that contains the passed string in the name
git_checkout() {
	if [ ! -z $1 ]; then

		if [ ! -z $2 ]; then
			if git_checkremote "$2"; then
				BRANCH=$(git branch -r --list *$REMOTE*$1* | sed -e 's/[\* ]*//;q')
			else
				return 1
			fi
		else
			BRANCH=$(git branch -r --list *origin*$1* | sed -e 's/[\* ]*origin\///;q')
		fi

		if [ -z $BRANCH ]; then
			echo "No branch found for expression '$1'"
		else
			echo "Found branch: '"$BRANCH"'" 
			git checkout $BRANCH
		fi

	else

		printf "co/checkout finds a git branch by expression and check it out.\n\n\tusage: co <expression> [remote]\n\n"

	fi
}

# Clones a repository in the current folder from github.
clono(){

  local GHUSER=$(git config --get user.github)
  local URL=https://github.com/$GHUSER/$1.git

  git clone $URL

}

# Check if 'user.baseurl' is defined and clones from that host. If not proceed
# with github.
clon(){

  if [ -z "$1" ]; then

    echo -e "\nNo repository specified!\n\n\tusage: $1 <repository>"
    echo -e "\nIf 'user.baseurl' is defined git will try to clone from that host else github will be used."
    
  else

    local BASEURL=$(git config --get user.baseurl)
    echo $BASEURL
    if [ -z "$BASEURL" ]; then
      clono $1
    else
      git clone $BASEURL/$1.git
    fi

  fi

}
