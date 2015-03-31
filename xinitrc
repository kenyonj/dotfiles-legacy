#set xmodmap
if [ -s ~/.xmodmap-jkarch ]; then
  xmodmap ~/.xmodmap-jkarch
fi

#set font
xset +fp /usr/share/fonts/TTF
xset fp rehash
fc-cache -fv

#set cursor
xsetroot -cursor_name left_ptr

#set locale
export LANG=en_US.UTF-8

# load Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# load monitor settings
xrandr --output DP1 --auto --left-of LVDS1

#start i3
exec i3 -V >> ~/i3log-$(date +'%F-%k-%M-%S') 2>&1
