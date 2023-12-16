--// Services
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

--// Modules
local Config = require(script.Config)

--// General
local Utilities = {}



--// Utilities
function Utilities.GetColourConfig(Character)

    local Colours = {}

    for _,Category in ipairs(Config.CC_Base) do
        
        Colours[Category] = Character:GetAttribute(Category)

    end

    return Colours

end

--// Queries the Attributes of the Character
function Utilities.QueryState(Character : Model,QueryList : any) 

    if type(QueryList) == "string" then

        QueryList = Config.Queries[QueryList]

    end

    for Attribute, Value in pairs(QueryList) do

        local AttributeValue = Character:GetAttribute(Attribute) == nil and "Nil" or Character:GetAttribute(Attribute)

        Value = Value == "Nil" and nil or Value

        if type(Value) == "table" then
 
            if not table.find(Value,AttributeValue) then return false end

        elseif AttributeValue ~= Value then

            return false

		end

	end

	return true

end

--// Changes Humanoid states to parsed dictioanry
function Utilities.ApplyHumanoidState(Humanoid : Humanoid,States : any) 

    for State,Value in pairs(States) do

        Humanoid:ChangeState(Enum.HumanoidStateType[State],Value)

    end

end

--// Apply properties to an instance with exteriror properties such as Delay and Duration
function Utilities.ApplyProperties(Obj : any,Properties : any) 
	
    for Property,Value in next,Properties do

        if Property == "Parent" or Property == "Delay" or Property == "Duration" or string.find(Property,"_") then continue end

        Obj[Property] = Value

    end

    _ = Properties.Delay and task.wait(Properties.Delay)

    Obj.Parent = Properties.Parent or Obj.Parent

end

--// Effecient Instance Method
function Utilities.Create(Class : string,Properties : any) 

    local Creation = type(Class) == "string" and Instance.new(Class) or Class

    Properties = Properties or {}
    
    Utilities.ApplyProperties(Creation,Properties)

    _ = Properties.Duration and Debris:AddItem(Creation,Properties.Duration)

    return Creation

end

--// Returns Players in a certain radius (Typically used for firing clients)
function Utilities.GetPlayersNear(Arg : any,Radius : number) 

    local Pos = Arg:IsA("BasePart") and Arg.Position or typeof(Arg) == "Vector3" and Arg or Arg:IsA("Model") and Arg.PrimaryPart.Position or Arg
    Radius = Radius or 750
    local PlayersFound = {}
    local PlayerSearch = Players:GetChildren()

    for i = 1,#PlayerSearch do

        local Player = PlayerSearch[i]
        local Character = Player.Character

        if not(Character) then continue end

        local Check = (Character.HumanoidRootPart.Position - Pos).magnitude <= Radius
        _ = Check and table.insert(PlayersFound, Player) or nil

    end
    
    return PlayersFound

end

--// Returns whether a table is an Array or Dictionary
function Utilities.ReturnTableType(Table) 

    for i,_ in pairs(Table) do

        if type(i) ~= "number" then

            return "Dictionary"

        end

    end

    return "Array"
    
end

--// Destroys class of descendants 
function Utilities.DestroyClass(Character,Class) 

    local Search = Character:GetDescendants()

    for _,Obj in ipairs(Search) do

        if Obj.ClassName ~= Class then continue end

        Obj.Destroy()

    end

end

--// Gets length of dictionary
function Utilities.GetLengthOfDict(Dict) 

    local Counter = 0

    for _,_ in pairs(Dict) do

        Counter +=1

    end
    
    return Counter

end

--// Emits Parents decendants
function Utilities.EmitDescendants(Parent)

    local Search = Parent:GetDescendants()

    for _,Obj in ipairs(Search) do

        if not Obj:IsA("ParticleEmitter") then continue end

        local Delay = Obj:GetAttribute("Delay")

        local EmitCount = Obj:GetAttribute("EmitCount")

        coroutine.wrap(function()

            _ = Delay and task.wait(Delay)

            Obj:Emit(EmitCount)

        end)()

    end

end    

--// Changes the Property of Parents descendants to Switch
function Utilities.EnableDescendants(Parent,Switch)

    local Search = Parent:GetDescendants()

    for _,Obj in ipairs(Search) do

        if not Obj:IsA("ParticleEmitter") then continue end

        Obj.Enabled = Switch

    end

end

--// Gets the players Data Folder
function Utilities.GetFolder(Player)

    local Data = ReplicatedStorage.Data
  
    return Data:FindFirstChild(Player.Name)

end

--// Gets Players Current File Under Data
function Utilities.GetFile(Player)

    local Folder = Utilities.GetFolder(Player)
    
    local CurrentFile = Folder.CurrentFile.Value

    return Folder:FindFirstChild("File") or Folder.Files:FindFirstChild(CurrentFile)

end

--// Returns Object that has attribute with specified value
function Utilities.GetAttributeWithValue(Parent,Attribute,Value)

    local Search = Parent:GetDescendants()

    for _,Obj in ipairs(Search) do

        if Obj:GetAttribute(Attribute) ~= Value then continue end

        return Obj

    end

end

--// Merges tables parsed 
function Utilities.MergeTables(Tables)

    local MergedTable = {}

    for _,Value in ipairs(Tables) do
        
        for _,Index in ipairs(Value) do
            
            table.insert(MergedTable,Index)

        end

    end

    return MergedTable

end

function Utilities.ClearClass(Parent,Class)

    local Search = Parent:GetDescendants()

    for _,Obj in ipairs(Search) do
        
        if Obj:IsA(Class) or Obj.ClassName == Class then Obj:Destroy()  end

    end

end

function Utilities.SetMassless(Parent,Value)

    for _,v in pairs(Parent:GetChildren()) do

        if not v:IsA("BasePart") then continue end

        v.Massless = Value

    end

end

function Utilities.GUIObstructed(GUI)

    local Player = Players.LocalPlayer
    local Mouse = Player:GetMouse()
    local MouseGUI = Player.PlayerGui.Mouse

    local guiList = Player.PlayerGui:GetGuiObjectsAtPosition(Mouse.X, Mouse.Y)
    
    for _, guiObject in ipairs(guiList) do

        if guiObject == GUI or guiObject:IsDescendantOf(GUI) or guiObject:IsDescendantOf(MouseGUI) or guiObject.BackgroundTransparency == 1 or guiObject.Parent.Name == "Design" or guiObject.Parent.Name == "Cosmetics" then continue end

        if guiObject:IsA("GuiObject") then
 
            return true 

        end

    end
    
    return false

end

function Utilities.IsOnScreen(Parent)

    local GUIService = game:GetService("GuiService")

    local GUIInset = GUIService:GetGuiInset()
    
    local CurrentCamera = workspace.CurrentCamera
    local Viewport = Parent
    local Pos = Viewport.AbsolutePosition + GUIInset

    return Pos.X + Viewport.AbsoluteSize.X <= CurrentCamera.ViewportSize.X and Pos.X >= 0
           and Pos.Y + Viewport.AbsoluteSize.Y <= CurrentCamera.ViewportSize.Y and Pos.Y >= 0

end

function Utilities.DeepCopy(original)

    if type(original) ~= "table" then

        return original  -- Return non-table values as-is

    end

    local copy = {}

    for key, value in pairs(original) do
        copy[Utilities.DeepCopy(key)] = Utilities.DeepCopy(value)
    end

    return copy

end

function Utilities.Compile(Parent,Options)

    local Deep = Options and Options.Deep

    local Search = Deep and Parent:GetDescendants() or Parent:GetChildren()

    local Compilation = {}

    for _,Obj in ipairs(Search) do

        if not Obj:IsA("ModuleScript") then continue end

        Compilation[Obj.Name] = require(Obj)

    end

    return Compilation

end

 

















return Utilities