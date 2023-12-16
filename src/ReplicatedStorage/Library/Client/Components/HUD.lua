--// Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Network
local Knit = require(ReplicatedStorage.Knit)
local Exports = require(ReplicatedStorage.Exports)
local Fusion = Knit.GetModule("Fusion")
local Utilities = Knit.GetModule("Utilities")
local Core = Knit.GetModule("Core")
 

--// General
local Value, Observer, Computed, ForKeys, ForValues, ForPairs,Create, Children, OnEvent, OnChange, Out, Ref, Cleanup, cleanup, Hydrate, Tween, Spring = Fusion.Value, Fusion.Observer, Fusion.Computed, Fusion.ForKeys, Fusion.ForValues, Fusion.ForPairs,Fusion.New, Fusion.Children, Fusion.OnEvent, Fusion.OnChange, Fusion.Out, Fusion.Ref, Fusion.Cleanup, Fusion.cleanup, Fusion.Hydrate, Fusion.Tween, Fusion.Spring




export type Prop = {
    Parent : PlayerGui,
    Metadata : Exports.Metadata,
}

return function(Props : Prop) : Prop

    local Metadata : Exports.Metadata = Props.Metadata

    return Create("ScreenGui"){

        Name = "HUD",
        Parent = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui"),

        [Children] = {

            Core = Core{
                Metadata = Metadata
            }

        }

    }

end
