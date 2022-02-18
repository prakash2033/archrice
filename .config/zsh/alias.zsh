alias glNoGraph='git log --color=always \
--format="%C(cyan)%h%Creset %C(blue)%ar%Creset%C(auto)%d%Creset \
%C(yellow)%s%+b %C(black)%ae%Creset" "$@"'

_gitLogLineToHash="echo {} |
grep -o '[a-f0-9]\{7\}' |
head -1"

_viewGitLogLine="$_gitLogLineToHash |
xargs -I % sh -c 'git show --color=always % |
diff-so-fancy'"

gcop() {	# search for commit with preview and copy hash
	glNoGraph |
		fzf -i -e --no-sort --reverse \
			--tiebreak=index --no-multi \
			--ansi --preview="$_viewGitLogLine" \
			--header "enter: view, C-c: copy hash" \
			--bind "enter:execute:$_viewGitLogLine   |
            less -R" \
			--bind "ctrl-c:execute:$_gitLogLineToHash |
            xclip -r -selection clipboard"
}
