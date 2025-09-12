# Get current keyboard layout (Hyprland)
layout=$(hyprctl devices | grep "active keymap:" | head -1 | awk '{print $3}')

echo "⌨️ $layout"
