--// Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Network
local Knit = require(ReplicatedStorage.Knit)
local Exports = require(ReplicatedStorage.Exports)
local Core = Knit.GetModule("Core")

--// General
local Player = Players.LocalPlayer
local Metadata : Exports.Metadata



local function Init(Character : Model) : Exports.Metadata

    local Meta = Knit.GetModule("Metadata")

    if Metadata then Metadata:Destroy() end

    Metadata = Meta.new(Character)

    return Metadata

end



repeat task.wait() until Player.Character

if Player.Character then Init(Player.Character) end

Player.CharacterAdded:Connect(Init)