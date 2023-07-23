if status is-interactive
    pfetch
end
# Aliases
if [ -f $HOME/.config/fish/alias.fish ]
	source $HOME/.config/fish/alias.fish
end

set -g fish_prompt_pwd_dir_length 1

function fish_prompt 
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`

	 printf '%s%s %s󰁔 ' (set_color cyan)  (echo -n (prompt_pwd)) (set_color black) $git_branch 
end
