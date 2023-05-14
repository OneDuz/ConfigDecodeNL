-- fix the select delete config numbers and Decoded configs list

local clipboard = require('neverlose/clipboard')
local base64 = require('neverlose/base64')
local mtools = require('neverlose/mtools')
files.create_folder("nl/ConfigmanagerNL")
function printConfigNames()
    local max_configs = 100
    local configs = {}
    local recent_config = ""
    
    for i = 1, max_configs do
        local file_name = "nl/ConfigmanagerNL/Config" .. i .. ".lua"
        if files.read(file_name) then
            if files.read(file_name) then
                recent_config = file_name
            end
            local config_name = "config" .. i
            table.insert(configs, config_name)
        end
    end

    if #configs == 0 then
        print_raw("No config files found.")
        configdecoder3:update("")
    else
        configdecoder3:update(configs)
    end
end


function importstuff()
    local clipboardstuff = clipboard.get()
    local decoded = base64.decode(clipboardstuff)
    local i = 1
    local file_name = "nl/ConfigmanagerNL/Config" .. i .. ".lua"
    while files.read(file_name) do
        i = i + 1
        file_name = "nl/ConfigmanagerNL/Config" .. i .. ".lua"
    end
    local DATE2 = files.write(file_name, decoded, false)
    print_raw("Created config file: " .. "config" .. i .. ".lua")
    printConfigNames()
end
function printselected()
    local config_index = configdecoder3:get()
    local file_name = "nl/ConfigmanagerNL/Config" .. config_index .. ".lua"
    local config_file = files.read(file_name)
    if config_file == "" then
        print_raw("Nothing found")
    end
    if config_file then
        print_raw(config_file)
    else
        print_raw("File was not found")
    end
end
function deleteselected()
    local config_index = configdecoder3:get()
    local file_name = "Config" .. config_index .. ".lua"
    print(file_name)
    mtools.FileSystem:DeleteFile("nl/ConfigmanagerNL/", file_name, true)
    printConfigNames()
end
SimpleInformation = ui.create(ui.get_icon("house-laptop").."\aF65151c8Home", " Info")
configdecoder1 = SimpleInformation:button("\aF65151c8Decode Config", importstuff, true)
configdecoder2 = SimpleInformation:button("\aF65151c8Print Selected Config", printselected, true)
configdecoder5 = SimpleInformation:button("\aF65151c8Delete Selected Config", deleteselected, true)
configdecoder4 = SimpleInformation:label("\aF65151c8It could be that some configs encode differently it wont work 100%")
configdecoder3 = SimpleInformation:list("\aF65151c8Decoded Configs")
printConfigNames()