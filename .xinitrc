xrandr --output eDP-1 --off
xrandr --output VGA-1 --auto
xrandr --output HDMI-1 --auto --right-of VGA-1
xsetroot -solid black
xset -b
exec i3
