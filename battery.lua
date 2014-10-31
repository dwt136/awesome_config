local awful = require("awful")

function update_bat(bar)
	fh = assert(io.popen("acpi|cut -d% -f1|cut -d' ' -f4", "r"))
	local remain = fh:read() + 0
	fh:close()
	bar:set_value(remain)
	if remain > 30 then
		bar:set_color("#666666")
	elseif remain > 12 then
		bar:set_color("#AA8800")
	else
		bar:set_color("#FF0000")
	end
end

bat_widget = awful.widget.progressbar()
bat_widget:set_width(8)
bat_widget:set_border_color("#666666")
bat_widget:set_background_color("#000000")
bat_widget:set_vertical(true)
bat_widget:set_max_value(100)

update_bat(bat_widget)
batwidgettimer = timer({timeout = 30})
batwidgettimer:connect_signal("timeout", function() update_bat(bat_widget) end)
batwidgettimer:start()


