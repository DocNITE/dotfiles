
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

# Build nix(flake) config and switch. Config should be placed in 'home/{user}/.nix-config'
function flake-rebuild() {
  local ppath="$(pwd)"
  
  # Change to the tools directory
  if cd ~/.nix-config/tools; then
    # Run the build script with the hostname
    if ! sh build.sh "$(hostname)"; then
      echo "Error: build.sh failed to execute."
    fi
  else
    echo "Error: Failed to change directory to ~/.nix-config/tools."
  fi

  # Return to the original directory
  cd "$ppath" || echo "Warning: Could not change back to $ppath."
}

# Update flake repository
function flake-update() {
  local ppath="$(pwd)"
  
  # Change to the tools directory
  if cd ~/.nix-config/tools; then
    # Run the build script with the hostname
    if ! sh update.sh; then
      echo "Error: update.sh failed to execute."
    else 
      flake-rebuild
    fi
  else
    echo "Error: Failed to change directory to ~/.nix-config/tools."
  fi

  # Return to the original directory
  cd "$ppath" || echo "Warning: Could not change back to $ppath."
}
