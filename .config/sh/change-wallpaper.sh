local wallpaper_variation="light" 

# Check if $1 is not null
if [[ -n $ENV_WALLPAPER_VARIATION ]]; then
    echo "Changing wallpaper from '${ENV_WALLPAPER_VARIATION}'..."
else
    echo "No argument was provided."
    exit 1
fi

# Check variation
if [[ $ENV_WALLPAPER_VARIATION == "light" ]]; then
  wallpaper_variation="dark"
else
  wallpaper_variation="light"
fi

hyprctl hyprpaper wallpaper "eDP-1,~/.config/hypr/wallpapers/berserk-${wallpaper_variation}.jpg"
hyprctl hyprpaper wallpaper "HDMI-A-1,~/.config/hypr/wallpapers/berserk-${wallpaper_variation}.jpg"

export ENV_WALLPAPER_VARIATION=$wallpaper_variation

echo "Wallpaper was changed on '${ENV_WALLPAPER_VARIATION}' variation!"
