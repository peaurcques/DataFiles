local function registerModConfig()
    EasyMCM = require("easyMCM.EasyMCM")
    local template = EasyMCM.createTemplate("Enchanting Expanded")
    local page = template:createPage()
    local category = page:createCategory("Settings")
    category:createButton{ buttonText = "Press" }
    EasyMCM.register(template)
end

event.register("modConfigReady", registerModConfig)