# load Xresources
xrdb -load ~/.Xresources &
xrdb -merge ~/.Xresources

#load xmodmap
xmodmap ~/.Xmodmap

# start ssh-agent
eval $(ssh-agent)

#start i3
exec i3
