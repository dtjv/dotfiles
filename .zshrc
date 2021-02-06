################################################################################
# interactive shell configuration
################################################################################

# TODO - keep?
#setopt ALIASES
#setopt ALWAYS_TO_END
#setopt AUTO_CD
#setopt AUTO_MENU
#setopt AUTO_PUSHD
#setopt BEEP
#setopt COMPLETE_IN_WORD
#setopt CORRECT
#setopt MULTIOS
#unsetopt NOMATCH  # allow [, ], ?, etc.
#setopt NOTIFY
setopt PROMPT_SUBST
#setopt PUSHD_IGNORE_DUPS
#setopt PUSHD_TO_HOME
#setopt RM_STAR_SILENT
#setopt SUNKEYBOARDHACK

################################################################################
# history
################################################################################

# TODO - keep?
#setopt EXTENDED_HISTORY
#setopt HIST_FIND_NO_DUPS
#setopt HIST_IGNORE_DUPS
#setopt HIST_IGNORE_SPACE
#setopt SHARE_HISTORY

#export HISTFILE="$HOME/.history"
#export HISTFILESIZE=50000000
#export HISTSIZE=5000000
#export SAVEHIST=$HISTSIZE

################################################################################
# prompt
################################################################################
set -o vi

autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%F{100}[%b]%f'

PROMPT='%F{242}%~ ${vcs_info_msg_0_} %F{68}%# %f'


################################################################################
# colors
################################################################################

export CLICOLOR=1
export LSCOLORS='Dxfxcxdxbxegedabagacad'

################################################################################
# alias configuration
################################################################################

alias vi='vim'

alias ll='ls -AlF'
alias ls='ls -AlF'
alias tree="tree -CF -I 'node_modules|.git'"

cl() { cd "$@" && ll; }

alias ..="cl .."
alias ...="cl ../.."
alias ....="cl ../../.."
alias .....="cl ../../../.."
alias -- -="cl -"

alias c="clear"

alias grep="grep --color=auto"

alias gs="git status"
alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gd="git diff"
alias go="git checkout"
alias gh="git log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
alias gl="git log | less"
alias gm="git merge"
alias gr="git remote -v"
alias gt="git tag"

alias dk="docker"
alias kb="kubectl"

alias ss="python -m SimpleHTTPServer 8080"
alias ss2="simplehttp2server -listen :4000"

################################################################################
# misc
################################################################################

# +X means don't execute, only load
autoload -Uz +X compaudit compinit
autoload -Uz +X bashcompinit

# Only bother with rebuilding, auditing, and compiling the compinit file once a
# whole day has passed. The -C flag bypasses both the check for rebuilding the
# dump file and the usual call to compaudit.
setopt EXTENDEDGLOB
for dump in $HOME/.zcompdump(N.mh+24); do
  echo 'Re-initializing ZSH completions'
  touch $dump
  compinit
  bashcompinit
  if [[ -s "$dump" && (! -s "$dump.zwc" || "$dump" -nt "$dump.zwc") ]]; then
    zcompile "$dump"
  fi
done
unsetopt EXTENDEDGLOB
compinit -C


################################################################################
# git new (gn)
#
# creates a repo on github for local git repo. sets origin and pushes upstream.
#
# required settings in git config:
#
# [github]
#   user = <git username> 
#   create-repo-token = <github personal access token>
#
# Usage:
#   $ cd <local git repo>
#   $ gn
################################################################################
gn() {
  handle_error() {
    echo "ERROR: ${1:-"Unknown Error"}" 1>&2
    exit 1
  }

  repo_name=$1

  dir_name=`basename $(pwd)`

  if [ "$repo_name" = "" ]; then
    echo ""
    echo -n "repo name: $dir_name (default) "
    read repo_name
  fi

  if [ "$repo_name" = "" ]; then
    repo_name=$dir_name
  fi

  username=`git config github.user`
  if [ "$username" = "" ]; then
    handle_error "no github.user"
  fi

  token=`git config github.create-repo-token`
  if [ "$token" = "" ]; then
    handle_error "no github.create-repo-token"
  fi

  repo_url="https://github.com/$username/$repo_name.git"

  echo ""
  echo "creating repo '$repo_name' on github... "

  result=`curl -u "$username:$token" https://api.github.com/user/repos -d \
    '{"name":"'$repo_name'"}' 2>&1 1>/dev/null`

  if [ "$?" -ne 0 ]; then
    handle_error $result
  fi

  echo ""
  echo "pushing local repo($dir_name) to remote($repo_name)... "

  git remote add origin $repo_url > /dev/null 2>&1
  git push -u origin main > /dev/null 2>&1

  echo ""
  echo "success!"
}
