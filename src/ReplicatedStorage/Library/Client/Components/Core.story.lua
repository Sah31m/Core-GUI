--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Network
local Knit = require(ReplicatedStorage.Knit)
local Fusion = Knit.GetModule("Fusion")
local Children = Fusion.Children
local Create = Fusion.New
local Hydrate = Fusion.Hydrate
local Core = require(script.Parent.Core)



return {

    summary = "A generic button.",

    story = function(Parent : ScreenGui)

        return Hydrate(Parent){

            [Children] = {

                Core {
                    LabelText = "Testing"
                }

            }

        }

    end

}