--fetch config file
local config = mwse.loadConfig("config_test")
if not config then
    config = { blocked = {} }
end

local function registerModConfig()
    EasyMCM = require("easyMCM.EasyMCM")
    local template = EasyMCM.createTemplate("Alchemy Expanded")
    local page = template:createPage()
    local category = page:createCategory("Settings")
    category:createButton{ buttonText = "Press" }
    EasyMCM.register(template)
end

event.register("modConfigReady", registerModConfig)