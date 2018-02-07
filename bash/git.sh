# Checks out the first branch that contains the passed string in the name
git_checkout() {

  # Arguments check
  if [ -z $1 ]; then
    echo -e "-- ERROR: No branch expression provided!" \
     "\n\n\tusage: co <expression> [remote]\n\n" \
     "\n\nco/checkout finds a git branch by expression and checks it out."
    return
  fi

  # Workout the variables
  REMOTE=${2:-origin}
  BRANCH=$(git branch -r --list *$REMOTE*$1* | sed -e 's/[\* ]*$REMOTE\///;q')
  if [ -z $BRANCH ]; then
      echo "-- ERROR: No branch found for expression '$1'"
      return 1
  fi

  # At last the checkout.
  echo "-- Found branch: '"$BRANCH"'" 
  git checkout $BRANCH

}

_find_dest(){

  # Default clone destination is HOME but you can specify a subfolder if you
  # want.
  DEST=${DEST:-$HOME}
  if [ -n "$1" ]; then
    DEST=$DEST/$1
  fi
  if [ ! -d "$DEST" ]; then
    mkdir -p $DEST
    echo -e "-- Creating '$DEST'"
  fi

}

# Clones a repository in the current folder from github.
clono(){

  local URL=https://github.com/$(git config --get user.github)/$1.git

  _find_dest $2
  git -C $DEST clone $URL

}

# Check if 'user.baseurl' is defined and clones from that host. If not proceed
# with github.
clon(){

  # Checking for the repository argument
  if [ -z "$1" ]; then
    echo -e "-- ERROR: No repository specified!" \
      "\n\n\tusage: $1 <repository> [workspace]" \
      "\n\nIf 'user.baseurl' is defined in 'git.config' then $0 will try to " \
      " clone from that host else github will be used."
    return 
  fi

  local HOST=$(git config --get user.baseurl)

  # Fallback to github if no 'user.baseurl' defined.
  if [ -z "$HOST" ]; then
    clono $1 $2
    return
  fi

  # Actual clone from defined host.
  _find_dest $2
  git -C $DEST clone $HOST/$1.git

}
