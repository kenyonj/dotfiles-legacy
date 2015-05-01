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

# set correct monitor position
function connect(){
  xrandr --output VIRTUAL1 --off --output DP3 --off --output DP2 --off --output DP1 --mode 2560x1600 --pos 0x0 --rotate normal --output HDMI3 --off --output HDMI2 --off --output HDMI1 --off --output LVDS1 --mode 1600x900 --pos 2704x752 --rotate normal --output VGA1 --off
}

function disconnect(){
  xrandr --output VIRTUAL1 --off --output DP3 --off --output DP2 --off --output DP1 --off --output HDMI3 --off --output HDMI2 --off --output HDMI1 --off --output LVDS1 --mode 1600x900 --pos 192x132 --rotate normal --output VGA1 --off
}

xrandr | grep "DP1 connected" &> /dev/null && connect || disconnect

#start i3
exec i3 -V >> ~/i3log-$(date +'%F-%k-%M-%S') 2>&1
