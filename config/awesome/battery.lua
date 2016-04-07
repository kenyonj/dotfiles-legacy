local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")
local helpers = require("./helpers")

local widget = {}

-- {{{ Define adapter
local adapter = "BAT0"
local charge = "charge"

-- Test identifier
widget.hasbattery = helpers:test("cat /sys/class/power_supply/" .. adapter .. "/" .. charge .. "_now")

-- Try another identifier
if not widget.hasbattery then
    charge = "energy"
    widget.hasbattery = helpers:test("cat /sys/class/power_supply/" .. adapter .. "/" .. charge .. "_now")
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
    awful.button({ }, 1, function () awful.util.spawn("gnome-control-center power") end)
))
-- }}}

-- {{{ Update method
function widget:update()
    local fcur = io.popen("cat /sys/class/power_supply/" ..adapter .. "/" .. charge .. "_now")    
    local fcap = io.popen("cat /sys/class/power_supply/" ..adapter .. "/" .. charge .. "_full")
    local fsta = io.popen("cat /sys/class/power_supply/" ..adapter .. "/status")
    local cur = fcur:read()
    local cap = fcap:read()
    local sta = fsta:read()

    if cur and cap then
        local battery = math.floor(cur * 100 / cap)
        local iconpath = "/usr/share/icons/gnome/scalable/status/battery"
       
        if(battery < 10) then
            iconpath = iconpath .. "-caution"
        
        elseif(battery < 25) then
            iconpath = iconpath .. "-low"
        
        elseif(battery < 75) then
            iconpath = iconpath .. "-good"
        
        else
            iconpath = iconpath .. "-full"
        
        end

        if sta:match("Charging") then
            iconpath = iconpath .. "-charging" 

        elseif sta:match("Discharging") then
        
        end
        
        iconpath = iconpath .. "-symbolic.svg"
        
        widget.icon:set_image(iconpath)
        widget.text:set_markup(battery .. "%")
    
    else
        widget.text:set_markup("N/A")
    
    end

    fcur:close()
    fcap:close()
    fsta:close()
end
-- }}}

-- {{{ Listen if signal was found
if widget.hasbattery then
    helpers:listen(widget)
end
-- }}}

return widget
