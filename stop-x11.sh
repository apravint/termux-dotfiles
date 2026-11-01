#!/data/data/com.termux/files/usr/bin/zsh
# Stop the X11 desktop: ask politely, force-kill only what is left.
procs=(xfce4-session xfwm4 xfce4-panel xfdesktop termux-x11 Xwayland termux-vnc vncserver)
running() { for p in $procs; do pgrep -x "$p" >/dev/null && return 0; done; return 1; }

if ! running; then
  [[ "${1:-}" == "--quiet" ]] || echo "X11 desktop is not running."
  exit 0
fi
for p in $procs; do pkill -TERM -x "$p" 2>/dev/null; done
for i in {1..10}; do running || break; sleep 0.5; done
if running; then
  echo "Some processes ignored SIGTERM; force-killing them."
  for p in $procs; do pkill -KILL -x "$p" 2>/dev/null; done
fi
# Only the desktop's session bus, never every dbus-daemon
pkill -TERM -f 'dbus-daemon.*--session' 2>/dev/null
sleep 0.5
if running; then echo "❌ X11 processes are still running." >&2; exit 1; fi
[[ "${1:-}" == "--quiet" ]] || echo "✅ X11 desktop stopped."
