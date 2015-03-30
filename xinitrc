#set xmodmap
if [ -s ~/.xmodmap-jkarch ]; then
  xmodmap ~/.xmodmap-jkarch
fi

#set cursor
xsetroot -cursor_name left_ptr

#set locale
export LANG=en_US.UTF-8

# load Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

#start i3
exec i3
