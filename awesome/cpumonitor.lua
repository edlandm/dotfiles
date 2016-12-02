-- Heat monitor
myheatmon = widget({ type = "textbox", name = "myheatmon", align = "right" })
function heat_status ()
    local output = {} -- output buffer
    local fd = io.popen("acpitool -t", "r") -- list present thermal zones
    local line = fd:read()
    while line do -- there might be several thermal zones
        local heat_num = string.match(line, "Thermal zone (%d+)")
        local heat_load = string.match(line, "(%d+) C")
        if heat_num and heat_load then
            table.insert(output, "<span color=\"#"
                .. hex(255 * tonumber(heat_load) / 105)
                .. hex(255 * (105 - tonumber(heat_load)) / 105)
                .. "00\">" .. heat_load .. "&#8451;</span>")
        end
        line=fd:read() -- read next line
    end
    return table.concat(output," ")
end
myheatmon.text = heat_status() .. " "
my_heatmon_timer = timer({timeout = 19})
my_heatmon_timer:add_signal("timeout", function()
    myheatmon.text = heat_status() .. " "
end)
my_heatmon_timer:start()