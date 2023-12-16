--// Services
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
 
--// Network
local Knit = require(ReplicatedStorage.Knit)
local Presets = require(script.Presets)
local Utilities = Knit.GetModule("Utilities")
local Janitor = Knit.GetModule("Janitor")

--// General
local StateService = Knit.CreateService {
    Name = "StateService",
    Client = {},
}
StateService.Cache = {}
StateService.Query =  Utilities.QueryState
StateService.Status = "Paused"








--// Publics
function StateService.Client:Get(Player : Player, Character : Model) : any

    return self.Server.Cache[Character]

end

function StateService:ChangeState(Character : Model, State : string, Value : any , Duration : number)

    Character:SetAttribute(State,Value);

    _ = Duration and self:AddTask(Character,State,Duration,function()

        local CallbackValue = typeof(Value) == "boolean" and not(Value) or Presets[State]
        Character:SetAttribute(State,CallbackValue)

    end)

end


--// Privates
local function GetKinetics(Character)

    local Stunned = StateService.Query(Character,{Stunned = true,})
    local Blocking = StateService.Query(Character,{Blocking = true,})
    local Knocked = StateService.Query(Character,{Knocked = true,})
    local PlayingFrameData = (Character:GetAttribute("FrameState") ~= nil)
    local Running = StateService.Query(Character,{Running = true,})
    local TotalZero = (
        StateService.Query(Character,{Reviving = true}) or 
        StateService.Query(Character,{Revived = true})  or                                                 
        StateService.Query(Character,{Executing = true}) or
        StateService.Query(Character,{Executed = true}) or
        StateService.Query(Character,{InAir = true})
                    )   

    if Stunned then 

        return 0,0
    
    elseif TotalZero then

        return 0,0
    
    elseif Blocking then
        
        return 5,0

    elseif Knocked then

        return 3,0

    elseif PlayingFrameData then

        return 7,0

    else

        return (Running and 20 or 14),Character:GetAttribute("ComboString") ~= "" and 0 or 50

    end

end

local function OnStepped()

    for Character,State in pairs(StateService.Cache) do
        
		for StateIndex,Value in pairs(State) do

            if typeof(Value) == "RBXScriptConnection" then continue end

			if os.clock() - Value[2] >= Value[1] then

				StateService.Cache[Character][StateIndex] = nil

				local Callback = Value[3] and Value[3]() or nil

			end

		end

	end

end

function StateService:Add(Character : Model, StateIndex : string , Duration : number, Callback)

    local Humanoid = Character.Humanoid

    self.Cache[Character] = {}

    for State,PresetValue in pairs(Presets) do
        
        Character:SetAttribute(State,PresetValue)

    end

    local C0 = Character.AttributeChanged:Connect(function()

       Humanoid.WalkSpeed,Humanoid.JumpPower = GetKinetics(Character)

    end)

    self.Cache[Character]["OnAttributeChanged"] = C0

end

function StateService:Remove(Character)

    self.Cache[Character] = nil

end

function StateService:AddTask(Character : Model, StateIndex : string , Duration : number, Callback)

    if self.Status == "Paused" then

        self.Status = "Running"
        self.OnStepped = RunService.Stepped:Connect(OnStepped)

    end

    if not self.Cache[Character] then
        
        self.Cache[Character] = {}

    end

    self.Cache[Character][StateIndex] = {Duration,os.clock(),Callback}

end

function StateService:KnitStart()

    CollectionService:GetInstanceAddedSignal("Living"):Connect(function(Character)

        self:Add(Character)

    end)

    CollectionService:GetInstanceRemovedSignal("Living"):Connect(function(Character)
        
        self:Remove(Character)

    end)

    for _, Character in pairs(CollectionService:GetTagged("Living")) do

        self:Add(Character)

    end

end

function StateService:KnitInit()
    
    

end







return StateService