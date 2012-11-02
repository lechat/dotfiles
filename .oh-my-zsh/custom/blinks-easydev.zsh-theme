# https://github.com/blinks zsh theme

ZSH_THEME_GIT_PROMPT_PREFIX=" [%{%B%F{blue}%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{%f%k%b%B%F{green}%}]"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{%F{red}%}*%{%f%k%b%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# PROMPT='%{%f%k%b%}
PROMPT='%{%B%F{green}%}%n%{%B%F{blue}%}@%{%B%F{cyan}%}easydev%{%B%F{green}%} %{%b%F{yellow}%}%~%{%B%F{green}%}$(git_prompt_info)%E%{%f%k%b%}
%#>%{%f%k%b%} '

RPROMPT='!%{%B%F{cyan}%}%!%{%f%k%b%}'
