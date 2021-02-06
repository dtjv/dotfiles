################################################################################
# paths
################################################################################

[ -d "$HOME/local/bin" ] && export PATH="$HOME/local/bin:$PATH"
[ -d "$HOME/local/sbin" ] && export PATH="$HOME/local/sbin:$PATH"


########################################################################
# nvm
########################################################################
export NVM_DIR="$HOME/.nvm"
export NVM_HOMEBREW="/usr/local/opt/nvm/nvm.sh"
[ -s "$NVM_HOMEBREW" ] && \. "$NVM_HOMEBREW"


########################################################################
# python
########################################################################

# TODO: keep?
#export PIP_DISABLE_PIP_VERSION_CHECK=1
#export PIP_NO_CACHE_DIR=1
#export PYTHONDONTWRITEBYTECODE=1
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
#(( ${+commands[pyenv]} )) &&
#  eval "$(pyenv init -)"  &&
#  eval "$(pyenv virtualenv-init -)"

# TODO: keep?
#function _pip_completion {
#  local words cword
#  read -Ac words
#  read -cn cword
#  reply=( $( COMP_WORDS="$words[*]" \
#             COMP_CWORD=$(( cword-1 )) \
#             PIP_AUTO_COMPLETE=1 $words[1] ) )
#}
#compctl -K _pip_completion pip


########################################################################
# ruby
########################################################################

# (( ${+commands[rbenv]} )) && eval "$(rbenv init -)"
