
# yazi shell wrapper
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Wallpaper changer
function change-wallpaper() {
  source ~/.config/sh/change-wallpaper.sh 
}

# Emoji picker
function emopicker9000() {
  sh ~/.config/sh/emopicker9000.sh
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
