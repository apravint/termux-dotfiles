#!/data/data/com.termux/files/usr/bin/zsh

# Terminate all running X11 graphical environments, window managers, and dbus sessions
killall -9 termux-x11 Xwayland xfce4-session xfwm4 dbus-daemon dbus-launch termux-vnc vncserver 2>/dev/null || true

echo "=========================================================="
echo "          Termux:X11 Server Stopped Cleanly               "
echo "=========================================================="
echo "Display server and XFCE4 session have been terminated."
echo "=========================================================="
