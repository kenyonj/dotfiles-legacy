#set xmodmap
if [ -s ~/.xmodmap-jkarch ]; then
  xmodmap ~/.xmodmap-jkarch
fi

#set cursor
xsetroot -cursor_name left_ptr

#start i3
exec i3
