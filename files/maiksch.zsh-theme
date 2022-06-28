function directory_info() {
  echo "%F{032}[%~]%f"
}

function custom_git_prompt_info() {
	echo "%F{208}$(git_prompt_info)%f"
}

function arrow_prompt() {
  echo "%(?:%F{082}%f:%F{red}%f)"
}

ZSH_THEME_GIT_PROMPT_PREFIX="[:"
ZSH_THEME_GIT_PROMPT_SUFFIX="]"

PROMPT="$(directory_info)$(custom_git_prompt_info) $(arrow_prompt) "
