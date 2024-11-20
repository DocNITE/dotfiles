# yazi shell wrapper
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Emoji picker
function emopicker9000() {
    # Get user selection via wofi from emoji file.
    chosen=$(cat $HOME/.emoji | rofi -dmenu | awk '{print $1}')

    # Exit if none chosen.
    [ -z "$chosen" ] && exit

    # If you run this command with an argument, it will automatically insert the
    # character. Otherwise, show a message that the emoji has been copied.
    if [ -n "$1" ]; then
	    ydotool type "$chosen"
    else
        printf "$chosen" | wl-copy
	    notify-send "'$chosen' copied to clipboard." &
    fi
}
