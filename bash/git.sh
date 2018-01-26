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
git_clone(){
  local BASEURL=$(git config --get user.baseurl)
  echo "Cloning $BASEURL/$1.git"
  git clone $BASEURL/$1.git
}
