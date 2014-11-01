local wibox = require("wibox")
local awful = require("awful")

volume_widget = wibox.widget.textbox()
volume_widget:set_align("right")

mytimer = timer({ timeout = 3 })
mytimer:connect_signal("timeout", function ()
	volume_widget:set_text("")
	mytimer:stop()
end)

function update_volume(widget)
   local fd = io.popen("amixer sget Master")
   local status = fd:read("*all")
   fd:close()

   local volume = string.match(status, "(%d?%d?%d)%%")
   volume = string.format("% 3d", volume)

   status = string.match(status, "%[(o[^%]]*)%]")

   if string.find(status, "on", 1, true) then
	   volume = volume .. "%"
   else
	   volume = volume .. "M"
   end
   widget:set_text(" Vol:" .. volume)
   mytimer:again()
end

update_volume(volume_widget)

