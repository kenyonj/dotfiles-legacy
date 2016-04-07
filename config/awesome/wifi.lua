local wibox = require("wibox")
local awful = require("awful")
local helpers = require("./helpers")

local widget = {}

-- {{{ Define the adapter
local adapter = "wlan0"

-- Test adapter
widget.haswifi = helpers:test("iwconfig " .. adapter)

-- Try another adapter name
if not widget.haswifi then 
    adapter = "wlp3s0"
    widget.haswifi = helpers:test("iwconfig " .. adapter)
end
-- }}}

-- {{{ Define subwidgets
widget.text = wibox.widget.textbox()
widget.icon = wibox.widget.imagebox()

-- Change the draw method so icons can be drawn smaller
helpers:set_draw_method(widget.icon)
-- }}}

-- {{{ Define interactive behaviour
widget.icon:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("gnome-control-center network") end)
))
-- }}}

-- {{{ Update method
function widget:update()
    spacer = " "
     
    local f = io.popen("iwconfig " .. adapter)
    local wifi = f:read("*all")
    local connected = string.match(wifi, "ESSID:\"(%w*)\"")
    local wifiMin, wifiMax = string.match(wifi, "(%d?%d)/(%d?%d)")

    wifiMin = tonumber(wifiMin) or 0
    wifiMax = tonumber(wifiMax) or 70

    local quality = math.floor(wifiMin / wifiMax * 100)
    local text = quality .. "%"

    if connected then
        text = text .. " (" .. connected .. ")"
    end

    widget.text:set_markup(text)

    local iconpath = "/usr/share/icons/gnome/scalable/status/network-wireless-signal"
    
    if quality <= 0 then
        iconpath = iconpath .. "-none"
    
    elseif quality < 25 then
        iconpath = iconpath .. "-weak"

    elseif quality < 50 then
        iconpath = iconpath .. "-ok"
    
    elseif quality < 75 then
        iconpath = iconpath .. "-good"
    
    else
        iconpath = iconpath .. "-excellent"
    
    end

    iconpath = iconpath .. "-symbolic.svg"

    widget.icon:set_image(iconpath)

    f:close()
end
-- }}}

-- {{{ Listen if signal was found
if widget.haswifi then
    helpers:listen(widget)
end
-- }}}

return widget;
