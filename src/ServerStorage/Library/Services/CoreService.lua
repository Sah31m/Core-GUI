--// Services
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Network
local Knit = require(ReplicatedStorage.Knit)
local Utilities = Knit.GetModule("Utilities")
local StateService = Knit.GetModule("StateService")

--// General
local CoreService = Knit.CreateService {
    Name = "CoreService",
    Client = {},
}


--// Publics




--// Privates
local function CharacterAdded(Character) : nil

    CollectionService:AddTag(Character,"Living")

end

local function PlayerAdded(Player) : nil

    Player.CharacterAdded:Connect(CharacterAdded)

end

local function PlayerRemoving(Player : Player) : nil


end

function CoreService:KnitStart()
    
    Players.PlayerAdded:Connect(PlayerAdded)
    Players.PlayerRemoving:Connect(PlayerRemoving)

end

function CoreService:KnitInit()
    
end


return CoreService
