#!/data/data/com.termux/files/usr/bin/zsh

# Kill any running X11 or VNC processes to clean up previous sessions
killall -9 termux-x11 Xwayland termux-vnc vncserver 2>/dev/null || true

# Start the Termux:X11 X server on display :1 and launch XFCE session
termux-x11 :1 -xstartup "dbus-launch --exit-with-session xfce4-session" &

# Background process to apply the custom dark liquid wallpaper once the desktop finishes loading
(
  sleep 4
  export DISPLAY=:1
  for prop in $(xfconf-query -c xfce4-desktop -l 2>/dev/null | grep last-image); do
    xfconf-query -c xfce4-desktop -p "$prop" -s "/data/data/com.termux/files/home/wallpaper.jpg" 2>/dev/null
  done
  for prop in $(xfconf-query -c xfce4-desktop -l 2>/dev/null | grep image-style); do
    xfconf-query -c xfce4-desktop -p "$prop" -s 5 2>/dev/null
  done
) &

echo "=========================================================="
echo "          Termux:X11 Server Started Successfully          "
echo "=========================================================="
echo "1. Ensure you have the 'Termux:X11' companion app installed."
echo "2. Open the Termux:X11 app on your Android phone."
echo "3. The XFCE4 Desktop will load instantly at native speed."
echo "=========================================================="
echo "To exit: Close the Termux:X11 app and press Ctrl+C in Termux."
