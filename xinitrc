# load Xresources
xrdb -load ~/.Xresources &
xrdb -merge ~/.Xresources

#start i3
exec i3-gnome
