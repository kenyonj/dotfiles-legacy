# load Xresources
xrdb -load ~/.Xresources &
xrdb -merge ~/.Xresources

#load xmodmap
xmodmap ~/.Xmodmap

#start i3
exec i3
