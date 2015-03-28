#set xmodmap
if [ -s ~/.xmodmap-jkarch ]; then
  xmodmap ~/.xmodmap-jkarch
fi

#set cursor
xsetroot -cursor_name left_ptr

# load Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

#start i3
exec i3
