function directory() {
  echo "%F{032}[%~]%f"
}

function git() {
echo "%F{208}$(git_prompt_info)%f"
}

function arrow() {
  echo "%(?:%F{082}%f:%F{red}%f)"
}

ZSH_THEME_GIT_PROMPT_PREFIX="[:"
ZSH_THEME_GIT_PROMPT_SUFFIX="]"

PROMPT="$(directory)$(git) $(arrow) "