--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Network
local Knit = require(ReplicatedStorage.Knit)
local Fusion = Knit.GetModule("Fusion")

return {

    Fusion = Fusion,
    storyRoots = {
        script.Parent.Parent.Components
    }
    
}

