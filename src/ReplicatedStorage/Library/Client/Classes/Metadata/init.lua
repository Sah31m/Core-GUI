--// Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

--// Network
local Knit = require(ReplicatedStorage.Knit)
local Exports = require(ReplicatedStorage.Exports)
local Fusion = Knit.GetModule("Fusion")
local Utilities = Knit.GetModule("Utilities")
local Janitor = Knit.GetModule("Janitor")
local HUD = Knit.GetModule("HUD")

--// General
local Metadata = {}
Metadata.__index = Metadata
local Value, Observer, Computed, ForKeys, ForValues, ForPairs,Create, Children, OnEvent, OnChange, Out, Ref, Cleanup, cleanup, Hydrate, Tween, Spring = Fusion.Value, Fusion.Observer, Fusion.Computed, Fusion.ForKeys, Fusion.ForValues, Fusion.ForPairs,Fusion.New, Fusion.Children, Fusion.OnEvent, Fusion.OnChange, Fusion.Out, Fusion.Ref, Fusion.Cleanup, Fusion.cleanup, Fusion.Hydrate, Fusion.Tween, Fusion.Spring
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")




function Metadata.new() : Exports.Metadata

    local self = setmetatable({}, Metadata)

    --// General
    self.Player = Player
    self.Character = Player.Character 
    self.Humanoid = self.Character:WaitForChild("Humanoid")

    --// GUI 
    self.HUD = HUD{
        Metadata = self
    }

    --// Classes
    self._Janitor = Janitor.new()

    self._Janitor:Add(self.HUD)
    
    return self

end


function Metadata:Destroy() : nil

   self._Janitor:Destroy()
   setmetatable(self,nil)
   self = nil

end


return Metadata