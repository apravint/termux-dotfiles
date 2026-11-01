#!/data/data/com.termux/files/usr/bin/zsh
# Start Termux:X11 on :1 with an XFCE session.
WALLPAPER="$HOME/wallpaper.jpg"
"$HOME/stop-x11.sh" --quiet || exit 1

termux-x11 :1 -xstartup "dbus-launch --exit-with-session xfce4-session" &
sleep 2
if ! pgrep -x termux-x11 >/dev/null && ! pgrep -f 'termux-x11|com.termux.x11' >/dev/null; then
  echo "❌ termux-x11 failed to start." >&2
  exit 1
fi

# Apply the wallpaper once xfdesktop is up (up to 60s), instead of guessing with a fixed sleep
(
  export DISPLAY=:1
  for i in {1..60}; do
    props=($(xfconf-query -c xfce4-desktop -l 2>/dev/null | grep last-image))
    (( $#props )) && pgrep -x xfdesktop >/dev/null && break
    sleep 1
  done
  for prop in $props; do xfconf-query -c xfce4-desktop -p "$prop" -s "$WALLPAPER" 2>/dev/null; done
  for prop in $(xfconf-query -c xfce4-desktop -l 2>/dev/null | grep image-style); do
    xfconf-query -c xfce4-desktop -p "$prop" -s 5 2>/dev/null
  done
) &!

echo "✅ X server is up on :1. Open the Termux:X11 app to see XFCE."
echo "   Stop it with: stop-x11"
