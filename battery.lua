local awful = require("awful")

local DEFAULT_WIDTH = 7
local plenty_color = "#666666"
local charging_color = "#FFFFFF"
local little_color = "#AA8800"
local less_color = "#FF0000"
local border_color = "#666666"
local background_color = "#000000"

function update_bat(bar)
	fh = assert(io.popen("acpi|cut -d% -f1|cut -d' ' -f4", "r"))
	local remain = fh:read() + 0
	fh:close()
	fh = assert(io.popen("acpi|cut -d, -f1|cut -d' ' -f3", "r"))
	local charging = fh:read()
	fh:close()
	bar:set_value(remain)
	if remain == 100 then
		bar:set_width(1)
	else
		bar:set_width(DEFAULT_WIDTH)
	end
	if remain > 30 then
		bar:set_color(plenty_color)
	elseif remain > 12 then
		bar:set_color(little_color)
	else
		bar:set_color(less_color)
	end
	if charging == "Charging" then
		bar:set_color(charging_color)
	end
end

bat_widget = awful.widget.progressbar()
bat_widget:set_border_color(border_color)
bat_widget:set_background_color(background_color)
bat_widget:set_vertical(true)
bat_widget:set_max_value(100)

update_bat(bat_widget)
batwidgettimer = timer({timeout = 30})
batwidgettimer:connect_signal("timeout", function() update_bat(bat_widget) end)
batwidgettimer:start()

