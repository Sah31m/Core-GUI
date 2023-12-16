--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

--// General
game.Workspace.Retargeting = Enum.AnimatorRetargetingMode.Disabled

--// Procedure
local Knit = require(ReplicatedStorage.Knit)
Knit.AddServices(ServerStorage.Library.Services)
Knit.AddServices(ReplicatedStorage.Library.Shared.Services)
Knit.Start():catch(warn)