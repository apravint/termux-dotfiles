#!/data/data/com.termux/files/usr/bin/zsh
# Start Termux:X11 on :1 with XFCE. Usage: x11 [--iram] (--iram uses the i3 desktop)
WALLPAPER="$HOME/wallpaper.jpg"
IRAM_SESSION="$HOME/termux-dotfiles/iram-x11/session"

mode=xfce
if [[ "${1:-}" == "--iram" ]]; then
  missing=()
  for c in i3 polybar rofi picom feh; do command -v $c >/dev/null || missing+=($c); done
  if (( $#missing )); then
    echo "⚠️  Iram desktop needs: pkg install $missing"
    echo "   Starting XFCE instead."
  else
    mode=iram
  fi
fi

"$HOME/stop-x11.sh" --quiet || exit 1

if [[ $mode == iram ]]; then
  termux-x11 :1 -xstartup "dbus-launch --exit-with-session $IRAM_SESSION" &
else
  termux-x11 :1 -xstartup "dbus-launch --exit-with-session xfce4-session" &
fi
sleep 2
if ! pgrep -x termux-x11 >/dev/null && ! pgrep -f 'termux-x11|com.termux.x11' >/dev/null; then
  echo "❌ termux-x11 failed to start." >&2
  exit 1
fi

if [[ $mode == xfce ]]; then
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
fi

echo "✅ X server is up on :1 ($mode). Open the Termux:X11 app to see the desktop."
echo "   Stop it with: stop-x11"
