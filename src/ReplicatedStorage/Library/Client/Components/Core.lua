--// Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

--// Network
local Knit = require(ReplicatedStorage.Knit)
local Exports = require(ReplicatedStorage.Exports)
local Fusion = Knit.GetModule("Fusion")

--// General
local TimeFunction = RunService:IsRunning() and time or os.clock
local Player = Players.LocalPlayer
local Value, Observer, Computed, ForKeys, ForValues, ForPairs,Create, Children, OnEvent, OnChange, Out, Ref, Cleanup, cleanup, Hydrate, Tween, Spring = Fusion.Value, Fusion.Observer, Fusion.Computed, Fusion.ForKeys, Fusion.ForValues, Fusion.ForPairs,Fusion.New, Fusion.Children, Fusion.OnEvent, Fusion.OnChange, Fusion.Out, Fusion.Ref, Fusion.Cleanup, Fusion.cleanup, Fusion.Hydrate, Fusion.Tween, Fusion.Spring
local Assets = ReplicatedStorage.Assets
local UI = Assets.UI






export type Prop = {

    Metadata : Exports.Metadata
}

return function(Props : Prop)

    --// Metadata Variables
    local Metadata = Props.Metadata
    local Character = Metadata.Character
    local Humanoid = Metadata.Humanoid

    --// General Variables
    local LastIteration, Start
    local FrameUpdateTable = {}

    --// Fusion Values
    local Health,MaxHealth = Value(0),Value(0)
    local Mana,MaxMana = Value(0),Value(0)
    local Stamina,MaxStamina = Value(0),Value(0)
    local FPS = Value(0)

    --// Updaters & Getters
    local function UpdateHealth()

        Health:set(Humanoid.Health)
        MaxHealth:set(Humanoid.MaxHealth)

    end

    local function UpdateMana()

        Mana:set(Character:GetAttribute("Mana"))
        MaxMana:set(Character:GetAttribute("MaxMana"))

    end

    local function UpdateStamina()

        Stamina:set(Character:GetAttribute("Stamina"))
        MaxStamina:set(Character:GetAttribute("MaxStamina"))

    end

    local function GetFPS()

        LastIteration = TimeFunction()

        for Index = #FrameUpdateTable, 1, -1 do

            FrameUpdateTable[Index + 1] = FrameUpdateTable[Index] >= LastIteration - 1 and FrameUpdateTable[Index] or nil

        end

        FrameUpdateTable[1] = LastIteration
        local Val = tostring(math.floor(TimeFunction() - Start >= 1 and #FrameUpdateTable or #FrameUpdateTable / (TimeFunction() - Start))).. " | FPS"

        FPS:set(Val)

    end

    --// Computeds
    local OnHealthChange = Computed(function()

        return UDim2.new(Health:get() / MaxHealth:get(),0,1,0)

    end)

    local OnManaChange = Computed(function()

        return UDim2.new(Mana:get() / MaxMana:get(),0,1,0)

    end)

    local OnStaminaChange = Computed(function()

        return UDim2.new(Stamina:get() / MaxStamina:get(),0,1,0)

    end)

    --// Updaters
    UpdateHealth()
    UpdateMana()
    UpdateStamina()
    Start = TimeFunction()

    --// Connections for Cleanup
    local Connections = {

        Humanoid:GetPropertyChangedSignal("Health"):Connect(UpdateHealth),
        Humanoid:GetPropertyChangedSignal("MaxHealth"):Connect(UpdateHealth),
        Character:GetAttributeChangedSignal("Mana"):Connect(UpdateMana),
        Character:GetAttributeChangedSignal("MaxMana"):Connect(UpdateMana),
        Character:GetAttributeChangedSignal("Stamina"):Connect(UpdateStamina),
        Character:GetAttributeChangedSignal("MaxStamina"):Connect(UpdateStamina),
        RunService.Heartbeat:Connect(GetFPS),

        OnHealthChange,
        OnManaChange,
        OnStaminaChange,

    }

    return Create("Frame"){

        AnchorPoint = Vector2.new(0, 1),
        BorderSizePixel = 0,
        Size = UDim2.new(0.2, 0, 0.138, 0),
        Position = UDim2.new(0, 5, 0.975, 0),
        BackgroundTransparency = 1,
        Name = "Core",
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),

        [Children] = {
            UIRatio = Create("UIAspectRatioConstraint"){
                AspectRatio = 4.75,
                Name = "UIRatio",
                AspectType = Enum.AspectType.ScaleWithParentSize,
                DominantAxis = Enum.DominantAxis.Height
            },
            Main = Create("ImageLabel"){
                BorderSizePixel = 0,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                AnchorPoint = Vector2.new(0, 1),
                Image = "rbxassetid://12176568026",
                Size = UDim2.new(1, 0, 1, 0),
                Name = "Background",
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 0, 1, 0),
                [Children] = {
                    UIAspectRatioConstraint = Create("UIAspectRatioConstraint"){},
                    Exp = Create("Frame"){
                        AnchorPoint = Vector2.new(0.5, 0.48),
                        BorderSizePixel = 0,
                        Size = UDim2.new(0.6, 0, 0.6, 0),
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        BackgroundTransparency = 1,
                        Name = "Exp",
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        [Children] = {
                            Heading = Create("TextLabel"){
                                TextWrapped = true,
                                BorderSizePixel = 0,
                                TextScaled = true,
                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                                TextSize = 14,
                                Name = "Heading",
                                Size = UDim2.new(1, 0, 0.15, 0),
                                TextColor3 = Color3.fromRGB(255, 255, 255),
                                Text = "Lvl",
                                Position = UDim2.new(0, 0, 0.33, 0),
                                BackgroundTransparency = 1
                            },
                            Level = Create("TextLabel"){
                                TextWrapped = true,
                                BorderSizePixel = 0,
                                TextScaled = true,
                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                                AnchorPoint = Vector2.new(0.5, 0),
                                TextSize = 14,
                                Name = "Level",
                                Size = UDim2.new(0.9, 0, 0.2, 0),
                                TextColor3 = Color3.fromRGB(255, 255, 255),
                                Text = "1",
                                Position = UDim2.new(0.5, 0, 0.48, 0),
                                BackgroundTransparency = 1
                            },
                            UIRatio_1 = Create("UIAspectRatioConstraint"){
                                Name = "UIRatio"
                            },
                            BG = Create("ImageLabel"){
                                ImageColor3 = Color3.fromRGB(55, 55, 55),
                                BorderSizePixel = 0,
                                BackgroundColor3 = Color3.fromRGB(55, 55, 55),
                                Image = "rbxassetid://12814042313",
                                Size = UDim2.new(1, 0, 1, 0),
                                Name = "BG",
                                BackgroundTransparency = 1
                            },
                            RightClip = Create("Frame"){
                                BorderSizePixel = 0,
                                Size = UDim2.new(0.5, 0, 1, 0),
                                Position = UDim2.new(0.5, 0, 0, 0),
                                BackgroundTransparency = 1,
                                ClipsDescendants = true,
                                Name = "RightClip",
                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                [Children] = {
                                    Right = Create("ImageLabel"){
                                        ImageColor3 = Color3.fromRGB(255, 255, 127),
                                        BorderSizePixel = 0,
                                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                        Image = "rbxassetid://12814058195",
                                        Size = UDim2.new(2, 0, 1, 0),
                                        Name = "Right",
                                        BackgroundTransparency = 1,
                                        Position = UDim2.new(-1, 0, 0, 0),
                                        [Children] = {
                                            UIGradient = Create("UIGradient"){
                                                Offset = Vector2.new(-0.01, 0),
                                                Transparency = NumberSequence.new{ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 0.00538), NumberSequenceKeypoint.new(0.501, 1), NumberSequenceKeypoint.new(1, 1) },
                                                Rotation = 180
                                            },
                                        }
                                    },
                                }
                            },
                            LeftClip = Create("Frame"){
                                BorderSizePixel = 0,
                                Size = UDim2.new(0.5, 0, 1, 0),
                                BackgroundTransparency = 1,
                                ClipsDescendants = true,
                                Name = "LeftClip",
                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                [Children] = {
                                    Left = Create("ImageLabel"){
                                        ImageColor3 = Color3.fromRGB(255, 255, 127),
                                        BorderSizePixel = 0,
                                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                        Image = "rbxassetid://12814049845",
                                        Size = UDim2.new(2, 0, 1, 0),
                                        Name = "Left",
                                        BackgroundTransparency = 1,
                                        [Children] = {
                                            UIGradient_1 = Create("UIGradient"){
                                                Offset = Vector2.new(0.01, 0),
                                                Transparency = NumberSequence.new{ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.499, 1), NumberSequenceKeypoint.new(0.501, 0), NumberSequenceKeypoint.new(1, 0) },
                                                Rotation = 10
                                            },
                                        }
                                    },
                                }
                            },
                        }
                    },
                    FPS = Create("TextLabel"){
                        TextWrapped = true,
                        TextScaled = true,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                        AnchorPoint = Vector2.new(0.5, 0),
                        TextSize = 14,
                        Name = "FPS",
                        Size = UDim2.new(0.55, 0, 0.125, 0),
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        Text = FPS,
                        Position = UDim2.new(0.2, 0, 0.7, 0),
                        Rotation = 45,
                        BackgroundTransparency = 1
                    },
                }
            },
            States = Create("Frame"){
                AnchorPoint = Vector2.new(0, 1),
                BorderSizePixel = 0,
                Size = UDim2.new(0.386738, 0, 0.314149, 0),
                Position = UDim2.new(0.151082, 0, 1.12128, 0),
                BackgroundTransparency = 1,
                Name = "States",
                BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                [Children] = {
                    UIListLayout = Create("UIListLayout"){
                        FillDirection = Enum.FillDirection.Horizontal,
                        VerticalAlignment = Enum.VerticalAlignment.Bottom,
                        SortOrder = Enum.SortOrder.LayoutOrder
                    },
                }
            },
            Yul = Create("TextLabel"){
                TextWrapped = true,
                TextScaled = true,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                TextSize = 14,
                Name = "Yul",
                Size = UDim2.new(0.25, 0, 0.175, 0),
                TextColor3 = Color3.fromRGB(255, 205, 0),
                Text = "0000",
                Position = UDim2.new(0.25, 0, 0.140809, 0),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                [Children] = {
                    Icon = Create("ImageLabel"){
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        AnchorPoint = Vector2.new(1, 0),
                        Image = "rbxassetid://12929193133",
                        Size = UDim2.new(1, 0, 1, 0),
                        Name = "Icon",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(-0.025, 0, 0, 0),
                        [Children] = {
                            UIAspectRatioConstraint_1 = Create("UIAspectRatioConstraint"){},
                        }
                    },
                }
            },
            Cosmetics = Create("Folder"){
                Name = "Cosmetics",
                [Children] = {
                    ImageLabel = Create("ImageLabel"){
                        ZIndex = 0,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Image = "rbxassetid://12835503041",
                        Size = UDim2.new(1.5, 0, 1.5, 0),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0.104095, 0, 0.377731, 0),
                        [Children] = {
                            UIAspectRatioConstraint_2 = Create("UIAspectRatioConstraint"){},
                        }
                    },
                    ImageLabel_1 = Create("ImageLabel"){
                        ZIndex = 0,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Image = "rbxassetid://13942655828",
                        Size = UDim2.new(1, 0, 1, 0),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0.104095, 0, 0.377731, 0),
                        [Children] = {
                            UIAspectRatioConstraint_3 = Create("UIAspectRatioConstraint"){},
                        }
                    },
                }
            },
            HBar = Create("Frame"){
                AnchorPoint = Vector2.new(0, 1),
                ZIndex = 3,
                Size = UDim2.new(1.35154, 0, 0.136233, 0),
                Position = UDim2.new(0.183187, 0, 0.5, 0),
                BackgroundTransparency = 1,
                ClipsDescendants = true,
                Name = "HBar",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                [Children] = {
                    Underlay = Create("ImageLabel"){
                        ZIndex = 0,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Image = "rbxassetid://12801041539",
                        Size = UDim2.new(0.9, 0, 0.713633, 0),
                        Name = "Underlay",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0.536212, 0, 0.489182, 0),
                        [Children] = {
                            UIAspectRatioConstraint_4 = Create("UIAspectRatioConstraint"){
                                AspectRatio = 16.0686
                            },
                        }
                    },
                    UIAspectRatioConstraint_5 = Create("UIAspectRatioConstraint"){
                        AspectRatio = 12.7412
                    },
                    Bar = Create("ImageLabel"){
                        ZIndex = 1,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        ImageTransparency = 1,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Image = "rbxassetid://12801041647",
                        ClipsDescendants = true,
                        Size = UDim2.new(0.876275, 0, 0.713633, 0),
                        Name = "Bar",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0.544512, 0, 0.48, 0),
                        [Children] = {
                            Clipping = Create("Frame"){
                                Size = UDim2.new(1.00902, 0, 1, 0),
                                Position = UDim2.new(-0.00902377, 0, 0, 0),
                                BackgroundTransparency = 1,
                                ClipsDescendants = true,
                                Name = "Clipping",
                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                [Children] = {
                                    Top = Create("ImageLabel"){
                                        ImageColor3 = Color3.fromRGB(255, 0, 0),
                                        ZIndex = 0,
                                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                        Image = "rbxassetid://12918933711",
                                        ClipsDescendants = true,
                                        Size = OnHealthChange,
                                        Name = "Top",
                                        BackgroundTransparency = 1,
                                        [Children] = {
                                            Empty = Create("UIGradient"){
                                                Name = "Empty",
                                                Color = ColorSequence.new{ ColorSequenceKeypoint.new(0, Color3.fromRGB(102, 102, 102)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }
                                            },
                                        }
                                    },
                                    Glow = Create("ImageLabel"){
                                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                        Image = "rbxassetid://12919442644",
                                        ClipsDescendants = true,
                                        Size = UDim2.new(1.00173, 0, 1, 0),
                                        Name = "Glow",
                                        BackgroundTransparency = 1,
                                        Position = UDim2.new(-0.00173221, 0, 0, 0)
                                    },
                                }
                            },
                        }
                    },
                    Overlay = Create("ImageLabel"){
                        ZIndex = 3,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Image = "rbxassetid://12801041789",
                        ClipsDescendants = true,
                        Size = UDim2.new(1, 0, 1, 0),
                        Name = "Overlay",
                        BackgroundTransparency = 1,
                        [Children] = {
                            UIAspectRatioConstraint_6 = Create("UIAspectRatioConstraint"){
                                AspectRatio = 12.7412
                            },
                        }
                    },
                }
            },
            SBar = Create("Frame"){
                ZIndex = 1,
                Size = UDim2.new(1.352, 0, 0.136, 0),
                Position = UDim2.new(0.155, 0, 0.635, 0),
                BackgroundTransparency = 1,
                ClipsDescendants = true,
                Name = "SBar",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                [Children] = {
                    UIAspectRatioConstraint_7 = Create("UIAspectRatioConstraint"){
                        AspectRatio = 12.7412
                    },
                    Overlay_1 = Create("ImageLabel"){
                        ZIndex = 3,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Image = "rbxassetid://12801130175",
                        ClipsDescendants = true,
                        Size = UDim2.new(1, 0, 1, 0),
                        Name = "Overlay",
                        BackgroundTransparency = 1
                    },
                    Underlay_1 = Create("ImageLabel"){
                        ZIndex = 0,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Image = "rbxassetid://12801130375",
                        Size = UDim2.new(0.9, 0, 0.714, 0),
                        Name = "Underlay",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0.536, 0, 0.489, 0),
                        [Children] = {
                            UIAspectRatioConstraint_8 = Create("UIAspectRatioConstraint"){
                                AspectRatio = 16.119
                            },
                        }
                    },
                    Bar_1 = Create("ImageLabel"){
                        ZIndex = 0,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        ImageTransparency = 1,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Image = "rbxassetid://12801130529",
                        ClipsDescendants = true,
                        Size = UDim2.new(0.886378, 0, 0.746352, 0),
                        Name = "Bar",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0.53946, 0, 0.496359, 0),
                        [Children] = {
                            Clipping_1 = Create("Frame"){
                                Size = UDim2.new(1, 0, 1, 0),
                                BackgroundTransparency = 1,
                                ClipsDescendants = true,
                                Name = "Clipping",
                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                [Children] = {
                                    Top_1 = Create("ImageLabel"){
                                        ImageColor3 = Color3.fromRGB(0, 170, 255),
                                        ZIndex = 0,
                                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                        Image = "rbxassetid://12801130529",
                                        ClipsDescendants = true,
                                        Size = OnStaminaChange,
                                        Name = "Top",
                                        BackgroundTransparency = 1,
                                        [Children] = {
                                            Empty_1 = Create("UIGradient"){
                                                Name = "Empty",
                                                Color = ColorSequence.new{ ColorSequenceKeypoint.new(0, Color3.fromRGB(102, 102, 102)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }
                                            },
                                        }
                                    },
                                    Glow_1 = Create("ImageLabel"){
                                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                        Image = "rbxassetid://12919642734",
                                        ClipsDescendants = true,
                                        Size = UDim2.new(0.992715, 0, 1, 0),
                                        Name = "Glow",
                                        BackgroundTransparency = 1,
                                        Position = UDim2.new(0.0072845, 0, 0, 0)
                                    },
                                }
                            },
                        }
                    },
                }
            },
            MBar = Create("Frame"){
                ZIndex = 3,
                Size = UDim2.new(1.352, 0, 0.136, 0),
                Position = UDim2.new(0.183187, 0, 0.5, 0),
                BackgroundTransparency = 1,
                ClipsDescendants = true,
                Name = "MBar",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                [Children] = {
                    Underlay_2 = Create("ImageLabel"){
                        ZIndex = 0,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Image = "rbxassetid://12801130375",
                        Size = UDim2.new(0.9, 0, 0.714, 0),
                        Name = "Underlay",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0.536, 0, 0.489, 0),
                        [Children] = {
                            UIAspectRatioConstraint_9 = Create("UIAspectRatioConstraint"){
                                AspectRatio = 16.119
                            },
                        }
                    },
                    UIAspectRatioConstraint_10 = Create("UIAspectRatioConstraint"){
                        AspectRatio = 12.7412
                    },
                    Bar_2 = Create("ImageLabel"){
                        ZIndex = 1,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        ImageTransparency = 1,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Image = "rbxassetid://12801130529",
                        ClipsDescendants = true,
                        Size = UDim2.new(0.886378, 0, 0.746352, 0),
                        Name = "Bar",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0.53946, 0, 0.496359, 0),
                        [Children] = {
                            Clipping_2 = Create("Frame"){
                                Size = UDim2.new(1, 0, 1, 0),
                                BackgroundTransparency = 1,
                                ClipsDescendants = true,
                                Name = "Clipping",
                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                [Children] = {
                                    Top_2 = Create("ImageLabel"){
                                        ZIndex = 1,
                                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                        Image = "rbxassetid://12801130529",
                                        ClipsDescendants = true,
                                        Size = OnManaChange,
                                        Name = "Top",
                                        BackgroundTransparency = 1,
                                        [Children] = {
                                            Empty_2 = Create("UIGradient"){
                                                Name = "Empty",
                                                Color = ColorSequence.new{ ColorSequenceKeypoint.new(0, Color3.fromRGB(102, 102, 102)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }
                                            },
                                        }
                                    },
                                    Glow_2 = Create("ImageLabel"){
                                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                        Image = "rbxassetid://12919642734",
                                        ClipsDescendants = true,
                                        Size = UDim2.new(0.992715, 0, 1, 0),
                                        Name = "Glow",
                                        BackgroundTransparency = 1,
                                        Position = UDim2.new(0.0072845, 0, 0, 0)
                                    },
                                }
                            },
                        }
                    },
                    Overlay_2 = Create("ImageLabel"){
                        ZIndex = 3,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Image = "rbxassetid://12801130175",
                        ClipsDescendants = true,
                        Size = UDim2.new(1, 0, 1, 0),
                        Name = "Overlay",
                        BackgroundTransparency = 1
                    },
                }
            },
            Shard = Create("TextLabel"){
                TextWrapped = true,
                TextScaled = true,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                AnchorPoint = Vector2.new(0, 0.5),
                TextSize = 14,
                Name = "Shard",
                Size = UDim2.new(0.25, 0, 0.175, 0),
                TextColor3 = Color3.fromRGB(169, 160, 206),
                Text = "0000",
                Position = UDim2.new(0.25, 0, 0, 0),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                [Children] = {
                    Icon_1 = Create("ImageLabel"){
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        AnchorPoint = Vector2.new(1, 0),
                        Image = "rbxassetid://13869476534",
                        Size = UDim2.new(1, 0, 1, 0),
                        Name = "Icon",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(-0.025, 0, 0, 0),
                        [Children] = {
                            UIAspectRatioConstraint_11 = Create("UIAspectRatioConstraint"){},
                        }
                    },
                }
            },
        },

        [Cleanup] = Connections,

    }

end