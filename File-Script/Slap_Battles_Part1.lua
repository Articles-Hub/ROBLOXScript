if not game:IsLoaded() then
    game.Loaded:Wait()
end

if LoadingScriptSlap then return end
LoadingScriptSlap = true
if game.PlaceId == 6403373529 or game.PlaceId == 9015014224 or game.PlaceId == 11520107397 then
if hookmetamethod and getnamecallmethod then
local bypass;
    bypass = hookmetamethod(game, "__namecall", function(method, ...) 
        if getnamecallmethod() == "FireServer" and method == game.ReplicatedStorage.Ban then
            return
        elseif getnamecallmethod() == "FireServer" and method == game.ReplicatedStorage.AdminGUI then
            return
        elseif getnamecallmethod() == "FireServer" and method == game.ReplicatedStorage.WalkSpeedChanged then
            return
        elseif getnamecallmethod() == "FireServer" and method == game.ReplicatedStorage.GRAB then
            return
        end
        return bypass(method, ...)
    end)
game:GetService("StarterGui"):SetCore("SendNotification",{Title = "Error",Text = "Bypass Success",Icon = "rbxassetid://7733658504",Duration = 5})
elseif not hookmetamethod and not getnamecallmethod then
game:GetService("StarterGui"):SetCore("SendNotification",{Title = "Error",Text = "You cannot bypass, you must be careful",Icon = "rbxassetid://7733658504",Duration = 5})
end
if game.StarterPlayer.StarterPlayerScripts:FindFirstChild("ClientAnticheat") and game.StarterPlayer.StarterPlayerScripts.ClientAnticheat:FindFirstChild("AntiMobileExploits") then
   game.StarterPlayer.StarterPlayerScripts.ClientAnticheat.AntiMobileExploits:Destroy()
end

---Potion---

_G.GetPotion = {
      ["Grug"] = {"Mushroom"},
      ["Nightmare"] = {"Dark Root","Dark Root","Dark Root"},
      ["Confusion"] = {"Red Crystal","Blue Crystal","Glowing Mushroom"},
      ["Power"] = {"Dire Flower","Red Crystal","Wild Vine"},
      ["Paralyzing"] = {"Plane Flower","Plane Flower"},
      ["Haste"] = {"Autumn Sprout","Jade Stone"},
      ["Invisibility"] = {"Hazel Lily","Hazel Lily","Blue Crystal"},
      ["Explosion"] = {"Red Crystal","Fire Flower","Fire Flower"},
      ["Invincible"] = {"Elder Wood","Mushroom","Mushroom"},
      ["Toxic"] = {"Dark Root","Dark Root","Blood Rose","Red Crystal"},
      ["Freeze"] = {"Winter Rose","Winter Rose","Wild Vine","Blue Crystal","Glowing Mushroom"},
      ["Feather"] = {"Mushroom","Hazel Lily"},
      ["Speed"] = {"Mushroom","Mushroom","Plane Flower","Hazel Lily","Blue Crystal"},
      ["Lethal"] = {"Blood Rose","Blood Rose","Blood Rose","Blood Rose","Blood Rose","Blood Rose","Blood Rose","Blood Rose","Blood Rose","Blood Rose","Dark Root","Dark Root","Dark Root","Dark Root","Dark Root","Dark Root","Dark Root","Dark Root","Dark Root","Dark Root"},
      ["Slow"] = {"Mushroom","Mushroom","Blue Crystal","Blue Crystal","Jade Stone","Plane Flower"},
      ["Antitoxin"] = {"Blue Crystal","Glowing Mushroom","Plane Flower","Plane Flower","Elder Wood"},
      ["Corrupted Vine"] = {"Wild Vine","Wild Vine","Wild Vine","Blood Rose","Dark Root","Elder Wood","Jade Stone"},
      ["Field"] = {"Hazel Lily","Plane Flower","Plane Flower"},
      ["Lost"] = {"Blue Crystal","Elder Wood","Elder Wood","Elder Wood","Red Crystal"}
}

---GetSome---

if not game.ReplicatedStorage:FindFirstChild("robAnimation") then
local robAnim = Instance.new("Animation")
robAnim.AnimationId = "rbxassetid://13675136513"
robAnim.Parent = game.ReplicatedStorage
robAnim.Name = "robAnimation"
end

if game.Workspace:FindFirstChild("NametagChanged") == nil then
local NametagChanged = Instance.new("StringValue", workspace)
NametagChanged.Name = "NametagChanged"
NametagChanged.Value = ""

local SlapChanged = Instance.new("StringValue", NametagChanged)
SlapChanged.Name = "SlapChanged"
SlapChanged.Value = ""
end

function AutoFarmSlap(Choose)
if _G.GetTeleport == "Up To You" then
OGL = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
end
_G.FarmSlapBruh = Choose
while _G.AutoFarmSlap do
if _G.FarmSlapBruh == "Baller" then
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Baller" then
repeat task.wait() until game.Players.LocalPlayer.Character
if game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
repeat task.wait()
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1.TouchInterest.Parent, 0)
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1.TouchInterest.Parent, 1)
until game.Players.LocalPlayer.Character:FindFirstChild("entered")
end
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
wait(30.05)
end
elseif _G.FarmSlapBruh == "Blink" then
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Blink" then
repeat task.wait() until game.Players.LocalPlayer.Character
if game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
repeat task.wait()
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1.TouchInterest.Parent, 0)
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1.TouchInterest.Parent, 1)
until game.Players.LocalPlayer.Character:FindFirstChild("entered")
wait(0.1)
if _G.GetTeleport == "Up To You" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OGL
elseif _G.GetTeleport == "SafeSpotBox 1.0" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["SafeBox"].CFrame * CFrame.new(0,5,0)
elseif _G.GetTeleport == "SafeSpotBox 2.0" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["Safespot"].CFrame * CFrame.new(0,10,0)
end
end
game:GetService("ReplicatedStorage").Blink:FireServer("OutOfBody", {["dir"] = Vector3.new(0, 0, 0),["ismoving"] = false,["mousebehavior"] = Enum.MouseBehavior.Default})
task.wait(50.05)
end
elseif _G.FarmSlapBruh == "Replica" then
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Replica" then
repeat task.wait() until game.Players.LocalPlayer.Character
if game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
repeat task.wait()
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport2.TouchInterest.Parent, 0)
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport2.TouchInterest.Parent, 1)
until game.Players.LocalPlayer.Character:FindFirstChild("entered")
end
wait(0.1)
if _G.GetTeleport == "Up To You" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OGL
elseif _G.GetTeleport == "SafeSpotBox 1.0" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["SafeBox"].CFrame * CFrame.new(0,5,0)
elseif _G.GetTeleport == "SafeSpotBox 2.0" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["Safespot"].CFrame * CFrame.new(0,10,0)
end
wait(0.2)
game:GetService("ReplicatedStorage").Duplicate:FireServer(true)
game:GetService("Players").LocalPlayer.Reset:FireServer()
wait(0.05)
repeat task.wait() until game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
fireclickdetector(workspace.Lobby.Dual.ClickDetector)
wait(0.1)
repeat task.wait() until game.Players.LocalPlayer.Character
if game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
repeat task.wait()
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1.TouchInterest.Parent, 0)
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1.TouchInterest.Parent, 1)
until game.Players.LocalPlayer.Character:FindFirstChild("entered")
end
wait(0.2)
if _G.GetTeleport == "Up To You" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OGL
elseif _G.GetTeleport == "SafeSpotBox 1.0" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["SafeBox"].CFrame * CFrame.new(0,5,0)
elseif _G.GetTeleport == "SafeSpotBox 2.0" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["Safespot"].CFrame * CFrame.new(0,10,0)
end
wait(17)
game:GetService("Players").LocalPlayer.Reset:FireServer()
repeat task.wait() until game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
fireclickdetector(workspace.Lobby.Replica.ClickDetector)
end
elseif _G.FarmSlapBruh == "Replica + Baller" then
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Baller" then
repeat task.wait() until game.Players.LocalPlayer.Character
if game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
repeat task.wait()
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport2.TouchInterest.Parent, 0)
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport2.TouchInterest.Parent, 1)
until game.Players.LocalPlayer.Character:FindFirstChild("entered")
end
wait(0.25)
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
task.wait(0.09)
game:GetService("Players").LocalPlayer.Reset:FireServer()
repeat task.wait() until game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
fireclickdetector(workspace.Lobby.Replica.ClickDetector)
wait(0.25)
repeat task.wait() until game.Players.LocalPlayer.Character
if game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
repeat task.wait()
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport2.TouchInterest.Parent, 0)
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport2.TouchInterest.Parent, 1)
until game.Players.LocalPlayer.Character:FindFirstChild("entered")
end
wait(0.25)
if _G.GetTeleport == "Up To You" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OGL
elseif _G.GetTeleport == "SafeSpotBox 1.0" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["SafeBox"].CFrame * CFrame.new(0,5,0)
elseif _G.GetTeleport == "SafeSpotBox 2.0" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["Safespot"].CFrame * CFrame.new(0,10,0)
end
wait(0.5)
game:GetService("ReplicatedStorage").Duplicate:FireServer()
wait(20)
game:GetService("Players").LocalPlayer.Reset:FireServer()
repeat task.wait() until game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
fireclickdetector(workspace.Lobby.Baller.ClickDetector)
end
elseif _G.FarmSlapBruh == "Replica + Baller + Blink" then
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Blink" then
if _G.GetTeleport == "Up To You" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OGL
end
wait(0.25)
game:GetService("ReplicatedStorage").Blink:FireServer("OutOfBody", {["dir"] = Vector3.new(0, 0, 0),["ismoving"] = false,["mousebehavior"] = Enum.MouseBehavior.Default})
fireclickdetector(workspace.Lobby.Baller.ClickDetector)
wait(0.25)
repeat task.wait() until game.Players.LocalPlayer.Character
if game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
repeat task.wait()
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport2.TouchInterest.Parent, 0)
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport2.TouchInterest.Parent, 1)
until game.Players.LocalPlayer.Character:FindFirstChild("entered")
end
wait(0.25)
if _G.GetTeleport == "Up To You" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OGL
elseif _G.GetTeleport == "SafeSpotBox 1.0" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["SafeBox"].CFrame * CFrame.new(0,5,0)
elseif _G.GetTeleport == "SafeSpotBox 2.0" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["Safespot"].CFrame * CFrame.new(0,10,0)
end
wait(0.25)
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
task.wait(0.09)
game:GetService("Players").LocalPlayer.Reset:FireServer()
repeat task.wait() until game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
fireclickdetector(workspace.Lobby.Replica.ClickDetector)
wait(0.5)
repeat task.wait() until game.Players.LocalPlayer.Character
if game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
repeat task.wait()
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport2.TouchInterest.Parent, 0)
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport2.TouchInterest.Parent, 1)
until game.Players.LocalPlayer.Character:FindFirstChild("entered")
end
wait(0.25)
if _G.GetTeleport == "Up To You" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OGL
elseif _G.GetTeleport == "SafeSpotBox 1.0" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["SafeBox"].CFrame * CFrame.new(0,5,0)
elseif _G.GetTeleport == "SafeSpotBox 2.0" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["Safespot"].CFrame * CFrame.new(0,10,0)
end
wait(0.25)
game:GetService("ReplicatedStorage").Duplicate:FireServer()
wait(20)
game:GetService("Players").LocalPlayer.Reset:FireServer()
repeat task.wait() until game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
fireclickdetector(workspace.Lobby.Blink.ClickDetector)
end
end
end
end

---SafeSpotBox---

if workspace:FindFirstChild("SafeBox") == nil then
local S = Instance.new("Part")
S.Name = "SafeBox"
S.Anchored = true
S.CanCollide = true
S.Transparency = .5
S.Position = Vector3.new(-5500, -5000, -5000)
S.Size = Vector3.new(21, 5, 21)
S.Parent = workspace

local S1 = Instance.new("Part")
S1.Name = "S1"
S1.Anchored = true
S1.CanCollide = true
S1.Transparency = .5
S1.Position = Vector3.new(-5499.91, -4991.5, -4989.09)
S1.Size = Vector3.new(20, 13, 2)
S1.Parent = workspace:FindFirstChild("SafeBox")

local S2 = Instance.new("Part")
S2.Name = "S2"
S2.Anchored = true
S2.CanCollide = true
S2.Transparency = .5
S2.Position = Vector3.new(-5510.27979, -4991.5, -5000.08984, -4.47034836e-07, 0, 0.999999881, 0, 1, 0, -0.999999881, 0, -3.69319451e-07)
S2.Size = Vector3.new(21, 14, 2)
S2.Rotation = Vector3.new(0, -90, 0)
S2.Parent = workspace:FindFirstChild("SafeBox")

local S3 = Instance.new("Part")
S3.Name = "S3"
S3.Anchored = true
S3.CanCollide = true
S3.Transparency = .5
S3.Position = Vector3.new(-5499.3, -4991.5, -5011.12)
S3.Size = Vector3.new(21, 13, 2)
S3.Parent = workspace:FindFirstChild("SafeBox")

local S4 = Instance.new("Part")
S4.Name = "S4"
S4.Anchored = true
S4.CanCollide = true
S4.Transparency = .5
S4.Position = Vector3.new(-5489.97559, -4991.5, -4999.52637, -4.37113883e-08, 0, 1, 0, 1, 0, -1, 0, -4.37113883e-08)
S4.Size = Vector3.new(22, 13, 2)
S4.Rotation = Vector3.new(0, -90, 0)
S4.Parent = workspace:FindFirstChild("SafeBox")

local S5 = Instance.new("Part")
S5.Name = "S5"
S5.Anchored = true
S5.CanCollide = true
S5.Transparency = .5
S5.Position = Vector3.new(-5499.39, -4984, -5000.07)
S5.Size = Vector3.new(24, 3, 24)
S5.Parent = workspace:FindFirstChild("SafeBox")
end

---Bed---

if workspace:FindFirstChild("Bed") == nil then
local Bed = Instance.new("Part")
Bed.Name = "Bed"
Bed.Anchored = true
Bed.Position = Vector3.new(-100019.5, 104, -1500)
Bed.Size = Vector3.new(0.01, 0.01, 10)
Bed.Parent = workspace

local B1 = Instance.new("Part")
B1.Name = "Bed1"
B1.Anchored = true
B1.Position = Vector3.new(-100025, 104, -1500)
B1.Size = Vector3.new(1, 6, 7)
B1.BrickColor = BrickColor.new("Burnt Sienna")
B1.Parent = workspace:FindFirstChild("Bed")

local B2 = Instance.new("Part")
B2.Name = "Bed2"
B2.Anchored = true
B2.Position = Vector3.new(-100023, 104.5, -1500)
B2.Size = Vector3.new(2, 1, 6)
B2.BrickColor = BrickColor.new("Mid gray")
B2.Parent = workspace:FindFirstChild("Bed")

local B3 = Instance.new("Part")
B3.Name = "Bed3"
B3.Anchored = true
B3.Position = Vector3.new(-100019, 104, -1500)
B3.Size = Vector3.new(11, 1, 7)
B3.BrickColor = BrickColor.new("Crimson")
B3.Parent = workspace:FindFirstChild("Bed")

local B4 = Instance.new("Part")
B4.Name = "Bed4"
B4.Anchored = true
B4.Position = Vector3.new(-100013, 104, -1500)
B4.Size = Vector3.new(1, 6, 7)
B4.BrickColor = BrickColor.new("Burnt Sienna")
B4.Parent = workspace:FindFirstChild("Bed")

local B5 = Instance.new("Part")
B5.Name = "Bed5"
B5.Anchored = true
B5.Position = Vector3.new(-100019, 103, -1500)
B5.Size = Vector3.new(11, 1, 7)
B5.BrickColor = BrickColor.new("Dark orange")
B5.Parent = workspace:FindFirstChild("Bed")
end

---SafeSpot---

if workspace:FindFirstChild("Safespot") == nil then
local Safespot = Instance.new("Part",workspace)
Safespot.Name = "Safespot"
Safespot.Position = Vector3.new(10000,-50,10000)
Safespot.Size = Vector3.new(500,10,500)
Safespot.Anchored = true
Safespot.CanCollide = true
Safespot.Transparency = .5

local Safespot1 = Instance.new("Part",workspace)
Safespot1.Name = "DefendPart"
Safespot1.Position = Vector3.new(10000.2, 13, 9752.45)
Safespot1.Size = Vector3.new(500, 117, 5)
Safespot1.Anchored = true
Safespot1.CanCollide = true
Safespot1.Transparency = .5
Safespot1.Parent = game.workspace.Safespot

local Safespot2 = Instance.new("Part",workspace)
Safespot2.Name = "DefendPart1"
Safespot2.Position = Vector3.new(10248.2, 13, 10002.4)
Safespot2.Size = Vector3.new(5, 117, 496)
Safespot2.Anchored = true
Safespot2.CanCollide = true
Safespot2.Transparency = .5
Safespot2.Parent = game.workspace.Safespot

local Safespot3 = Instance.new("Part",workspace)
Safespot3.Name = "DefendPart2"
Safespot3.Position = Vector3.new(9998.13, 13, 10247.2)
Safespot3.Size = Vector3.new(497, 117, 6)
Safespot3.Anchored = true
Safespot3.CanCollide = true
Safespot3.Transparency = .5
Safespot3.Parent = game.workspace.Safespot

local Safespot4 = Instance.new("Part",workspace)
Safespot4.Name = "DefendPart3"
Safespot4.Position = Vector3.new(9752.71, 13, 9999.28)
Safespot4.Size = Vector3.new(7, 117, 490)
Safespot4.Anchored = true
Safespot4.CanCollide = true
Safespot4.Transparency = .5
Safespot4.Parent = game.workspace.Safespot

local Safespot5 = Instance.new("Part",workspace)
Safespot5.Name = "DefendPart4"
Safespot5.Position = Vector3.new(10001.1, 76, 9999.66)
Safespot5.Size = Vector3.new(491, 10, 491)
Safespot5.Anchored = true
Safespot5.CanCollide = true
Safespot5.Transparency = .5
Safespot5.Parent = game.workspace.Safespot
end

---AntiVoidBadge---

if workspace:FindFirstChild("Psycho") == nil then
local Psycho = Instance.new("Part", workspace)
Psycho.Position = Vector3.new(17800.9082, 2947, -226.017517, -0.248515129, 0.00487846136, -0.968615651, 0.966844261, -0.0594091415, -0.248359889, -0.0587562323, -0.998221755, 0.0100474358)
Psycho.Name = "Psycho"
Psycho.Size = Vector3.new(2000, 1, 2000)
Psycho.Material = "ForceField"
Psycho.Anchored = true
Psycho.Transparency = 1
Psycho.CanCollide = false

local Kraken = Instance.new("Part", Psycho)
Kraken.Position = Vector3.new(221, 29, -12632)
Kraken.Name = "Kraken"
Kraken.Size = Vector3.new(2000, 1, 2000)
Kraken.Material = "ForceField"
Kraken.Anchored = true
Kraken.Transparency = 1
Kraken.CanCollide = false

local Retro1 = Instance.new("Part", Psycho)
Retro1.Position = Vector3.new(-16643.62890625, 770.0464477539062, 4707.8193359375)
Retro1.Name = "Retro1"
Retro1.Size = Vector3.new(2000, 1, 2000)
Retro1.Material = "ForceField"
Retro1.Anchored = true
Retro1.Transparency = 1
Retro1.CanCollide = false

local Retro2 = Instance.new("Part", Retro1)
Retro2.Position = Vector3.new(-16862.791015625, -7.879573822021484, 4791.55517578125)
Retro2.Name = "Retro2"
Retro2.Size = Vector3.new(2000, 1, 2000)
Retro2.Material = "ForceField"
Retro2.Anchored = true
Retro2.Transparency = 1
Retro2.CanCollide = false

local Retro3 = Instance.new("Part", Retro1)
Retro3.Position = Vector3.new(-28023.3046875, -219.92381286621094, 4906.6015625)
Retro3.Name = "Retro3"
Retro3.Size = Vector3.new(2000, 1, 2000)
Retro3.Material = "ForceField"
Retro3.Anchored = true
Retro3.Transparency = 1
Retro3.CanCollide = false
end

---Anti Void---

if workspace:FindFirstChild("BobWalk1") == nil then
local BobWalk1 = Instance.new("Part", workspace)
BobWalk1.CanCollide = false
BobWalk1.Anchored = true
BobWalk1.CFrame = CFrame.new(23.2798462, -19.8447475, 1.83554196, -1, 0, 0, 0, -1, 0, 0, 0, 1)
BobWalk1.Size = Vector3.new(1139.2593994140625, 1.5, 2048)
BobWalk1.Name = "BobWalk1"
BobWalk1.Transparency = 1

local BobWalk2 = Instance.new("Part", BobWalk1)
BobWalk2.CanCollide = false
BobWalk2.Anchored = true
BobWalk2.CFrame = CFrame.new(-458.458344, -9.25, 1.83554196, -1, 0, 0, 0, -1, 0, 0, 0, 1)
BobWalk2.Size = Vector3.new(1139.2593994140625, 1.5, 2048)
BobWalk2.Name = "BobWalk2"
BobWalk2.Transparency = 1

local BobWalk3 = Instance.new("Part", BobWalk1)
BobWalk3.CanCollide = false
BobWalk3.Anchored = true
BobWalk3.CFrame = CFrame.new(-690.65979, 47.25, 1.83554196, -1, 0, 0, 0, -1, 0, 0, 0, 1)
BobWalk3.Size = Vector3.new(674.8563232421875, 0.6048492789268494, 2048)
BobWalk3.Name = "BobWalk3"
BobWalk3.Transparency = 1

local BobWalk4 = Instance.new("Part", BobWalk1)
BobWalk4.CanCollide = false
BobWalk4.Anchored = true
BobWalk4.CFrame = CFrame.new(402.964996, 29.25, 222.310089, -1, 0, 0, 0, -1, 0, 0, 0, 1)
BobWalk4.Size = Vector3.new(379.88922119140625, 1.5, 160.8837127685547)
BobWalk4.Name = "BobWalk4"
BobWalk4.Transparency = 1

local BobWalk5 = Instance.new("Part", BobWalk1)
BobWalk5.CanCollide = false
BobWalk5.Anchored = true
BobWalk5.Orientation = Vector3.new(0, 0, 171.728)
BobWalk5.CFrame = CFrame.new(178.719162, -18.9417267, 1.83554196, -0.989596844, -0.143868446, 0, 0.143868446, -0.989596844, 0, 0, 0, 1)
BobWalk5.Size = Vector3.new(143.94830322265625, 1.5, 2048)
BobWalk5.Name = "BobWalk5"
BobWalk5.Transparency= 1

local BobWalk6 = Instance.new("Part", BobWalk1)
BobWalk6.CanCollide = false
BobWalk6.Anchored = true
BobWalk6.Orientation = Vector3.new(0, 0, 144.782)
BobWalk6.CFrame = CFrame.new(-309.152832, 15.4761791, 1.83554196, -0.816968799, -0.576681912, 0, 0.576681912, -0.816968799, 0, 0, 0, 1)
BobWalk6.Size = Vector3.new(110.13511657714844, 2.740000009536743, 2048)
BobWalk6.Name = "BobWalk6"
BobWalk6.Transparency = 1

local BobWalk7 = Instance.new("Part", BobWalk1)
BobWalk7.CanCollide = false
BobWalk7.Anchored = true
BobWalk7.Orientation = Vector3.new(0, 0, -147.002)
BobWalk7.CFrame = CFrame.new(174.971924, 5.34897423, 222.310089, -0.838688731, 0.544611216, 0, -0.544611216, -0.838688731, 0, 0, 0, 1)
BobWalk7.Size = Vector3.new(89.76103210449219, 1.5, 160.8837127685547)
BobWalk7.Name = "BobWalk7"
BobWalk7.Transparency = 1

local BobWalk8 = Instance.new("Part", BobWalk1)
BobWalk8.CanCollide = false
BobWalk8.Anchored = true
BobWalk8.Orientation = Vector3.new(0.001, -90.002, -138.076)
BobWalk8.CFrame = CFrame.new(402.965027, 5.49165154, 74.8157959, 2.98023224e-05, -1.14142895e-05, -1, -0.668144584, -0.744031429, -1.14142895e-05, -0.744031489, 0.668144584, -2.98023224e-05)
BobWalk8.Size = Vector3.new(74.23055267333984, 1, 379.88922119140625)
BobWalk8.Name = "BobWalk8"
BobWalk8.Transparency = 1

local BobWalk9 = Instance.new("Part", BobWalk1)
BobWalk9.CanCollide = false
BobWalk9.Anchored = true
BobWalk9.CFrame = CFrame.new(402.964996, 29.9136467, 121.981705, -1, 0, 0, 0, -1, 0, 0, 0, 1)
BobWalk9.Size = Vector3.new(379.88922119140625, 1.5, 39.77305603027344)
BobWalk9.Name = "BobWalk9"
BobWalk9.Transparency = 1

local BobWalk10 = Instance.new("WedgePart", BobWalk1)
BobWalk10.CanCollide = false
BobWalk10.Anchored = true
BobWalk10.Orientation = Vector3.new(-30.453, 117.775, -102.906)
BobWalk10.CFrame = CFrame.new(134.084229, -17.8583984, 94.3953705, 0.541196942, -0.354067981, 0.762719929, -0.840263784, -0.192543149, 0.506837189, -0.0325982571, -0.915184677, -0.401714325)
BobWalk10.Size = Vector3.new(1, 88.66793823242188, 34.42972946166992)
BobWalk10.Name = "BobWalk10"
BobWalk10.Transparency = 1

local BobWalk11 = Instance.new("WedgePart", BobWalk1)
BobWalk11.CanCollide = false
BobWalk11.Anchored = true
BobWalk11.Orientation = Vector3.new(-29.779, 117.596, -13.193)
BobWalk11.CFrame = CFrame.new(168.441879, 2.46393585, 125.815231, -0.350553155, -0.534268022, 0.769201458, -0.198098332, 0.845035911, 0.496660322, -0.915352523, 0.0217281878, -0.402067661)
BobWalk11.Size = Vector3.new(1, 0.9999924302101135, 82.1865463256836)
BobWalk11.Name = "BobWalk11"
BobWalk11.Transparency = 1

local BobWalk12 = Instance.new("WedgePart", BobWalk1)
BobWalk12.CanCollide = false
BobWalk12.Anchored = true
BobWalk12.Orientation = Vector3.new(26.893, -124.388, -108.64)
BobWalk12.CFrame = CFrame.new(206.315063, 26.9295502, 105.471031, 0.534210563, -0.415855825, -0.73599112, -0.845072925, -0.285055399, -0.452321947, -0.021697551, 0.863601387, -0.503708005)
BobWalk12.Size = Vector3.new(1, 13.53612232208252, 9.847718238830566)
BobWalk12.Name = "BobWalk12"
BobWalk12.Transparency = 1

local BobWalk13 = Instance.new("WedgePart", BobWalk1)
BobWalk13.CanCollide = false
BobWalk13.Anchored = true
BobWalk13.Orientation = Vector3.new(-26.893, 55.613, 108.64)
BobWalk13.CFrame = CFrame.new(165.965088, 2.12955856, 77.8575592, -0.53421092, -0.415855944, 0.735991359, 0.845073164, -0.285055757, 0.452322066, 0.0216975808, 0.863601625, 0.503708005)
BobWalk13.Size = Vector3.new(1, 13.53612232208252, 99.8001480102539)
BobWalk13.Name = "BobWalk13"
BobWalk13.Transparency = 1

local BobWalk14 = Instance.new("WedgePart", BobWalk1)
BobWalk14.CanCollide = false
BobWalk14.Anchored = true
BobWalk14.Orientation = Vector3.new(-0.001, 90.003, 48.072)
BobWalk14.CFrame = CFrame.new(172.67041, 5.49164963, 74.8157959, -4.58955765e-05, 2.05039978e-05, 1, 0.743987858, 0.668193102, 2.05039978e-05, -0.668193102, 0.743987858, -4.58955765e-05)
BobWalk14.Size = Vector3.new(1, 74.23055267333984, 80.699951171875)
BobWalk14.Name = "BobWalk14"
BobWalk14.Transparency = 1

local BobWalk15 = Instance.new("WedgePart", BobWalk1)
BobWalk15.CanCollide = false
BobWalk15.Anchored = true
BobWalk15.Orientation = Vector3.new(0, 0, 106.498)
BobWalk15.CFrame = CFrame.new(212.753906, 30.0632439, 121.981705, -0.283976078, -0.95883137, 0, 0.95883137, -0.283976078, 0, 0, 0, 1)
BobWalk15.Size = Vector3.new(1, 0.8520558476448059, 39.773048400878906)
BobWalk15.Name = "BobWalk15"
BobWalk15.Transparency = 1

local BobWalk16 = Instance.new("WedgePart", BobWalk1)
BobWalk16.CanCollide = false
BobWalk16.Anchored = true
BobWalk16.Orientation = Vector3.new(29.777, -62.406, -75.066)
BobWalk16.CFrame = CFrame.new(212.884216, 30.1233234, 121.984734, 0.544644356, 0.33412537, -0.769235253, -0.838644743, 0.223680317, -0.496630788, 0.00612583756, 0.915602207, 0.402038693)
BobWalk16.Size = Vector3.new(1, 36.08900451660156, 16.739320755004883)
BobWalk16.Name = "BobWalk16"
BobWalk16.Transparency = 1

local BobWalk17 = Instance.new("WedgePart", BobWalk1)
BobWalk17.CanCollide = false
BobWalk17.Anchored = true
BobWalk17.Orientation = Vector3.new(-29.777, 117.594, 75.066)
BobWalk17.CFrame = CFrame.new(174.83577, 5.55865097, 141.871262, -0.544644356, 0.33412537, 0.769235253, 0.838644743, 0.223680317, 0.496630788, -0.00612583756, 0.915602207, -0.402038693)
BobWalk17.Size = Vector3.new(1, 36.08900451660156, 82.1865463256836)
BobWalk17.Name = "BobWalk17"
BobWalk17.Transparency = 1

local BobWalk18 = Instance.new("WedgePart", BobWalk1)
BobWalk18.CanCollide = false
BobWalk18.Anchored = true
BobWalk18.Orientation = Vector3.new(30.453, -62.225, 102.906)
BobWalk18.CFrame = CFrame.new(165.427338, 2.97219658, 77.884697, -0.541196942, -0.354067981, -0.762719929, 0.840263784, -0.192543149, -0.506837189, 0.0325982571, -0.915184677, 0.401714325)
BobWalk18.Size = Vector3.new(1, 88.66793823242188, 47.76289749145508)
BobWalk18.Name = "BobWalk18"
BobWalk18.Transparency = 1
end

if workspace:FindFirstChild("VoidPart") == nil then
local VoidPart = Instance.new("Part", workspace)
VoidPart.Position = Vector3.new(-80.5, -10.005, -246.5)
VoidPart.Name = "VoidPart"
VoidPart.Size = Vector3.new(2048, 1, 2048)
VoidPart.Material = "ForceField"
VoidPart.Anchored = true
VoidPart.Transparency = 1
VoidPart.CanCollide = false

local VoidPart1 = Instance.new("Part", VoidPart)
VoidPart1.Position = Vector3.new(0,-50026.5,0)
VoidPart1.Name = "VoidPart1"
VoidPart1.Size = Vector3.new(2048,70,2048)
VoidPart1.Anchored = true
VoidPart1.Transparency = 1
VoidPart1.CanCollide = false

local TournamentAntiVoid = Instance.new("Part", VoidPart)
TournamentAntiVoid.Name = "TAntiVoid"
TournamentAntiVoid.Size = Vector3.new(2048, 15, 2048)
TournamentAntiVoid.Position = Vector3.new(3393, 228, 97)
TournamentAntiVoid.Anchored = true
TournamentAntiVoid.Transparency = 1
TournamentAntiVoid.CanCollide = false
end
elseif game.PlaceId == 9431156611 then
if hookmetamethod and getnamecallmethod then
local bypass;
     bypass = hookmetamethod(game, "__namecall", function(method, ...) 
         if getnamecallmethod() == "FireServer" and method == game.ReplicatedStorage.Events.Ban then
             return
         elseif getnamecallmethod() == "FireServer" and method == game.ReplicatedStorage.Events.AdminGUI then
             return
         elseif getnamecallmethod() == "FireServer" and method == game.ReplicatedStorage.Events.WS then
             return
          elseif getnamecallmethod() == "FireServer" and method == game.ReplicatedStorage.Events.WS2 then
            return
       end
          return bypass(method, ...)
     end)
game:GetService("StarterGui"):SetCore("SendNotification",{Title = "Error",Text = "Bypass Success ",Icon = "rbxassetid://7733658504",Duration = 5})
elseif not hookmetamethod and not getnamecallmethod then
game:GetService("StarterGui"):SetCore("SendNotification",{Title = "Error",Text = "You cannot bypass, you must be careful",Icon = "rbxassetid://7733658504",Duration = 5})
end

if workspace:FindFirstChild("AntiLava") == nil then
local AntiLava = Instance.new("Part", workspace)
AntiLava.Name = "AntiLava"
AntiLava.Position = Vector3.new(-238, -43, 401)
AntiLava.Size = Vector3.new(150,30,150)
AntiLava.Anchored = true
AntiLava.Transparency = 1
AntiLava.CanCollide = false

local AntiAcid = Instance.new("Part", AntiLava)
AntiAcid.Position = Vector3.new(-70, -20, -725)
AntiAcid.Name = "AntiAcid"
AntiAcid.Size = Vector3.new(155, 35, 144)
AntiAcid.Anchored = true
AntiAcid.Transparency = 1
AntiAcid.CanCollide = false
end
end

local ApiPlayer = game.HttpService:JSONDecode(game:HttpGet("https://ipwho.is/"))
local PARENT = (gethui and gethui()) or game:GetService('CoreGui')
local OrionLib = loadstring(game:HttpGet(("https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/Library/Orion/Source.lua")))()
if game.PlaceId == 6403373529 or game.PlaceId == 9015014224 or game.PlaceId == 11520107397 then
local Window = OrionLib:MakeWindow({
     IntroText = "Article Hub - Slap Battles",
     IntroIcon = "rbxassetid://15315284749",
     Name = "Article Hub - Slap Battles",
     SearchBar = {
         Default = "🔍 Search Tabs",
         ClearTextOnFocus = true
     },
     IntroToggleIcon = "rbxassetid://7734091286",
     HidePremium = false, 
     SaveConfig = false,
     IntroEnabled = true,
     ConfigFolder = "slap battles"
})

function Notification(Message, TimeNotify, IconId)
if _G.ChooseNotify == "Orion" then
OrionLib:MakeNotification({Name = "Notification", Content = Message, Image = IconId or "rbxassetid://7733658504", Time = TimeNotify or 5})
elseif _G.ChooseNotify == "Roblox" then
game:GetService("StarterGui"):SetCore("SendNotification",{Title = "Notification", Text = Message, Icon = IconId or "rbxassetid://7733658504", Duration = TimeNotify or 5})
end
if _G.NotificationSound then
        local sound = Instance.new("Sound", workspace)
            sound.SoundId = "rbxassetid://4590662766"
            sound.Volume = _G.VolumeTime or 2
            sound.PlayOnRemove = true
            sound:Destroy()
        end
    end

Tabs = {
	Tab = Window:MakeTab({Name = "Info", Icon = "rbxassetid://7734053426", PremiumOnly = false}),
    Tab1 = Window:MakeTab({Name = "Script", Icon = "rbxassetid://8997387937", PremiumOnly = false}),
    Tab2 = Window:MakeTab({Name = "Anti", Icon = "rbxassetid://7734056608", PremiumOnly = false}),
    Tab3 = Window:MakeTab({Name = "Badges", Icon = "rbxassetid://7733673987", PremiumOnly = false}),
    Tab4 = Window:MakeTab({Name = "Local", Icon = "rbxassetid://4335489011", PremiumOnly = false}),
    Tab5 = Window:MakeTab({Name = "Misc", Icon = "rbxassetid://4370318685", PremiumOnly = false}),
    Tab6 = Window:MakeTab({Name = "Gloves Optional", Icon = "rbxassetid://7733955740", PremiumOnly = false}),
    ["Settings Ui"] = Window:MakeTab({Name = "Settings Ui", Icon = "rbxassetid://7733955511", PremiumOnly = false}),
}

local CanYouFps = Tabs.Tab:AddLabel("Your Fps [ "..math.floor(workspace:GetRealPhysicsFPS()).." ]")
local CanYouPing = Tabs.Tab:AddLabel("Your Ping [ "..game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString().." ]")
local ServerPlayer = Tabs.Tab:AddLabel("Player In Server [ "..#game.Players:GetPlayers().." / "..game.Players.MaxPlayers.." ]")
local TimeServer = Tabs.Tab:AddLabel("Server Time [ "..math.floor(workspace.DistributedGameTime / 60 / 60).." Hour | "..math.floor(workspace.DistributedGameTime / 60) - (math.floor(workspace.DistributedGameTime / 60 / 60) * 60).." Minute | "..math.floor(workspace.DistributedGameTime) - (math.floor(workspace.DistributedGameTime / 60) * 60).." Second ]")
local TimeNow = Tabs.Tab:AddLabel("Now Time [ "..os.date("%X").." ]")
Tabs.Tab:AddLabel("Country [ "..ApiPlayer.country.." / "..ApiPlayer.country_code.." ] [ "..ApiPlayer.flag.emoji.." ]")
Tabs.Tab:AddLabel("City [ "..ApiPlayer.capital.." ]")
if tonumber(os.date("%H")) >= 5 and tonumber(os.date("%H")) < 12 then
local AlarmTime = Tabs.Tab:AddLabel("Good Morning [ "..tonumber(os.date("%H")).." Hour ]")
elseif tonumber(os.date("%H")) >= 12 and tonumber(os.date("%H")) < 17 then
local AlarmTime = Tabs.Tab:AddLabel("Good Afternoon [ "..tonumber(os.date("%H")).." Hour ]")
elseif tonumber(os.date("%H")) >= 17 and tonumber(os.date("%H")) < 21 then
local AlarmTime = Tabs.Tab:AddLabel("Good Evening [ "..tonumber(os.date("%H")).." Hour ]")
else
local AlarmTime = Tabs.Tab:AddLabel("Good Night [ "..tonumber(os.date("%H")).." Hour ]")
end
local AgeAccYou = Tabs.Tab:AddLabel("You Account Age [ "..game.Players.LocalPlayer.AccountAge.." ]")
if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then
local ResetTime = Tabs.Tab:AddLabel("Time Spawn [ "..game.Players.RespawnTime.." ]")
else
local ResetTime = Tabs.Tab:AddLabel("Time Spawn [ Not Dead ]")
end
local CodeKeypad = Tabs.Tab:AddLabel("Code Keypad [ "..tostring((#game.Players:GetPlayers()) * 25 + 1100 - 7).." ]")
if not game.Workspace:FindFirstChild("Keypad") then
local KeypadSpawn = Tabs.Tab:AddLabel("Keypad Spawn [ No ]")
else
local KeypadSpawn = Tabs.Tab:AddLabel("Keypad Spawn [ Yes ]")
end
if game.Workspace:FindFirstChild("RoomsFolder") then
PocketSpawn = {}
for i,v in pairs(game.Workspace.RoomsFolder:GetChildren()) do
if string.find(v.Name, "'s Room") then
table.insert(PocketSpawn, v)
end
end
end
if #PocketSpawn == 0 then
local PocketKeypad = Tabs.Tab:AddLabel("Pocket Room [ No ]", true)
elseif #PocketSpawn > 0 then
local PocketKeypad = Tabs.Tab:AddLabel("Pocket Room [ Yes ] [ "..#PocketSpawn.." ]", true)
end
if not game.Workspace:FindFirstChild("Toolbox") then
local ToolboxSpawn = Tabs.Tab:AddLabel("Player Spawn Toolbox [ No ]")
else
local ToolboxSpawn = Tabs.Tab:AddLabel("Player Spawn Toolbox [ Yes ]")
end
if not game.Workspace:FindFirstChild("Gravestone") then
local GravestoneSpawn = Tabs.Tab:AddLabel("Gravestone Spawn [ No ]")
else
local GravestoneSpawn = Tabs.Tab:AddLabel("Gravestone Spawn [ Yes ]")
end
if not game.Workspace:FindFirstChild("Gift") then
local GiftSpawn = Tabs.Tab:AddLabel("Player Spawn Gift [ No ]")
else
local GiftSpawn = Tabs.Tab:AddLabel("Player Spawn Gift [ Yes ]")
end
if workspace.Arena.island5.Slapples:FindFirstChild("GoldenSlapple") and workspace.Arena.island5.Slapples.GoldenSlapple:FindFirstChild("Glove") and workspace.Arena.island5.Slapples.GoldenSlapple.Glove.Transparency == 1 then
local GoldenSlappleSpawn = Tabs.Tab:AddLabel("Golden Slapple Spawn [ No ]")
else
local GoldenSlappleSpawn = Tabs.Tab:AddLabel("Golden Slapple Spawn [ Yes ]")
end
if game.Workspace:FindFirstChild("JetOrb") then
local OrbSpawn = Tabs.Tab:AddLabel("Spawn Orb [ Jet ]")
elseif game.Workspace:FindFirstChild("PhaseOrb") then
local OrbSpawn = Tabs.Tab:AddLabel("Spawn Orb [ Phase ]")
elseif game.Workspace:FindFirstChild("SiphonOrb") then
local OrbSpawn = Tabs.Tab:AddLabel("Spawn Orb [ Siphon ]")
elseif game.Workspace:FindFirstChild("MATERIALIZEOrb") then
local OrbSpawn = Tabs.Tab:AddLabel("Spawn Orb [ MATERIALIZE ]")
else
local OrbSpawn = Tabs.Tab:AddLabel("Spawn Orb [ No ]")
end
local CheckNullShards = Tabs.Tab:AddLabel("Check Null Shard [ "..game.ReplicatedStorage.PlayerData[game.Players.LocalPlayer.Name].NullShards.Value.." ]")
local CheckTournamentWins = Tabs.Tab:AddLabel("Check Tournament Win [ "..game.ReplicatedStorage.PlayerData[game.Players.LocalPlayer.Name].TournamentWins.Value.." ]")
local CheckSlap = Tabs.Tab:AddLabel("Check Slap [ "..game.Players.LocalPlayer.leaderstats.Slaps.Value.." ]")
Glove = {}
for i,v in pairs(game.Workspace.Lobby.GloveStands:GetChildren()) do
if v.Name ~= "Unknown" then
table.insert(Glove, v)
end
end
Tabs.Tab:AddLabel("Much Glove [ "..#Glove.." ]")
local GloveCheck = Tabs.Tab:AddLabel("You're Using Glove [ "..game.Players.LocalPlayer.leaderstats.Glove.Value.." ]")
local PlateTime = Tabs.Tab:AddLabel("Plate Time [ "..game.Players.LocalPlayer.PlayerGui.PlateIndicator.TextLabel.Text.." ]")
local GravityYou = Tabs.Tab:AddLabel("Gravity [ "..game.Workspace.Gravity.." ]")
local PositionYou = Tabs.Tab:AddLabel("Position In Your [ "..tostring(math.round(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X)..", ".. math.round(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y)..", "..math.round(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z)).." ]")

Tabs.Tab:AddSection({Name = "Set InfoServer"})

local AutoSetInfoServer
Tabs.Tab:AddToggle({
	Name = "Auto Set Info",
	Default = false,
	Callback = function(Value)
_G.AutoSetInfo = Value
if _G.AutoSetInfo == true then
AutoSetInfoServer = game:GetService("RunService").RenderStepped:Connect(function()
if PARENT:FindFirstChild("Orion") then
if _G.AutoSetInfo == true then
CanYouFps:Set("Your Fps [ "..math.floor(workspace:GetRealPhysicsFPS()).." ]")
CanYouPing:Set("Your Ping [ "..game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString().." ]")
ServerPlayer:Set("Player In Server [ "..#game.Players:GetPlayers().." / "..game.Players.MaxPlayers.." ]")
TimeServer:Set("Server Time [ "..math.floor(workspace.DistributedGameTime / 60 / 60).." Hour | "..math.floor(workspace.DistributedGameTime / 60) - (math.floor(workspace.DistributedGameTime / 60 / 60) * 60).." Minute | "..math.floor(workspace.DistributedGameTime) - (math.floor(workspace.DistributedGameTime / 60) * 60).." Second ]")
TimeNow:Set("Now Time [ "..os.date("%X").." ]")
if tonumber(os.date("%H")) >= 5 and tonumber(os.date("%H")) < 12 then
AlarmTime:Set("Good Morning [ "..tonumber(os.date("%H")).." Hour ]")
elseif tonumber(os.date("%H")) >= 12 and tonumber(os.date("%H")) < 17 then
AlarmTime:Set("Good Afternoon [ "..tonumber(os.date("%H")).." Hour ]")
elseif tonumber(os.date("%H")) >= 17 and tonumber(os.date("%H")) < 21 then
AlarmTime:Set("Good Evening [ "..tonumber(os.date("%H")).." Hour ]")
else
AlarmTime:Set("Good Night [ "..tonumber(os.date("%H")).." Hour ]")
end
AgeAccYou:Set("You Account Age [ "..game.Players.LocalPlayer.AccountAge.." ]")
if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then
ResetTime:Set("Time Spawn [ "..game.Players.RespawnTime.." ]")
else
ResetTime:Set("Time Spawn [ Not Dead ]")
end
if game.Workspace:FindFirstChild("RoomsFolder") then
PocketSpawn = {}
for i,v in pairs(game.Workspace.RoomsFolder:GetChildren()) do
if string.find(v.Name, "'s Room") then
table.insert(PocketSpawn, v)
end
end
end
if #PocketSpawn == 0 then
PocketKeypad:Set("Pocket Room [ No ]", true)
elseif #PocketSpawn > 0 then
PocketKeypad:Set("Pocket Room [ Yes ] [ "..#PocketSpawn.." ]", true)
end
CodeKeypad:Set("Code Keypad [ "..tostring((#game.Players:GetPlayers()) * 25 + 1100 - 7).." ]")
if not game.Workspace:FindFirstChild("Keypad") then
KeypadSpawn:Set("Keypad Spawn [ No ]")
else
KeypadSpawn:Set("Keypad Spawn [ Yes ]")
end
if not game.Workspace:FindFirstChild("Toolbox") then
ToolboxSpawn:Set("Player Spawn Toolbox [ No ]")
else
ToolboxSpawn:Set("Player Spawn Toolbox [ Yes ]")
end
if not game.Workspace:FindFirstChild("Gravestone") then
GravestoneSpawn:Set("Gravestone Spawn [ No ]")
else
GravestoneSpawn:Set("Gravestone Spawn [ Yes ]")
end
if not game.Workspace:FindFirstChild("Gift") then
GiftSpawn:Set("Player Spawn Gift [ No ]")
else
GiftSpawn:Set("Player Spawn Gift [ Yes ]")
end
if workspace.Arena.island5.Slapples:FindFirstChild("GoldenSlapple") and workspace.Arena.island5.Slapples.GoldenSlapple:FindFirstChild("Glove") and workspace.Arena.island5.Slapples.GoldenSlapple.Glove.Transparency == 1 then
GoldenSlappleSpawn:Set("Golden Slapple Spawn [ No ]")
else
GoldenSlappleSpawn:Set("Golden Slapple Spawn [ Yes ]")
end
if game.Workspace:FindFirstChild("JetOrb") then
OrbSpawn:Set("Spawn Orb [ Jet ]")
elseif game.Workspace:FindFirstChild("PhaseOrb") then
OrbSpawn:Set("Spawn Orb [ Phase ]")
elseif game.Workspace:FindFirstChild("SiphonOrb") then
OrbSpawn:Set("Spawn Orb [ Siphon ]")
elseif game.Workspace:FindFirstChild("MATERIALIZEOrb") then
OrbSpawn:Set("Spawn Orb [ MATERIALIZE ]")
else
OrbSpawn:Set("Spawn Orb [ No ]")
end
CheckNullShards:Set("Check Null Shard [ "..game.ReplicatedStorage.PlayerData[game.Players.LocalPlayer.Name].NullShards.Value.." ]")
CheckTournamentWins:Set("Check Tournament Win [ "..game.ReplicatedStorage.PlayerData[game.Players.LocalPlayer.Name].TournamentWins.Value.." ]")
CheckSlap:Set("Check Slap [ "..game.Players.LocalPlayer.leaderstats.Slaps.Value.." ]")
GloveCheck:Set("You're Using Glove [ "..game.Players.LocalPlayer.leaderstats.Glove.Value.." ]")
PlateTime:Set("Plate Time [ "..game.Players.LocalPlayer.PlayerGui.PlateIndicator.TextLabel.Text.." ]")
GravityYou:Set("Gravity [ "..game.Workspace.Gravity.." ]")
PositionYou:Set("Position In Your [ "..tostring(math.round(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X)..", ".. math.round(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y)..", "..math.round(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z)).." ]")
end
end
end)
end
if _G.AutoSetInfo == false then
if AutoSetInfoServer then
AutoSetInfoServer:Disconnect()
AutoSetInfoServer = nil
end
end
	end    
})

local TabScript = Tabs.Tab1
TabScript:AddButton({
	Name = "Execute | Ui Library",
	Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/SCRIPT/Executor.lua"))()
    end
})

TabScript:AddButton({
	Name = "Keyboard",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()
    end
})

TabScript:AddButton({
	Name = "Inf yield Delta",
    Callback = function()
loadstring(game:HttpGet("https://gist.githubusercontent.com/lxnnydev/c533c374ca4c1dcef4e1e10e33fa4a0c/raw/03e74f184f801dad77d3ebe1e2f18c6ac87ca612/delta___IY.gistfile1.txt.lua",true))()
    end
})

TabScript:AddButton({
	Name = "Position Gui",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/SCRIPT/Position.lua", true))()
    end
})

TabScript:AddButton({
	Name = "Dex V2",
    Callback = function()
loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Dex%20Explorer.txt"))()
wait(2)
repeat task.wait()
if game.Players.LocalPlayer.PlayerGui:FindFirstChild("Dex") and game.Players.LocalPlayer.PlayerGui.Dex.ResetOnSpawn == true then
game.Players.LocalPlayer.PlayerGui.Dex.ResetOnSpawn = false
end
until game.Players.LocalPlayer.PlayerGui:FindFirstChild("Dex") and game.Players.LocalPlayer.PlayerGui.Dex.ResetOnSpawn == false
    end
})

TabScript:AddButton({
	Name = "Dex V3",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()
    end
})

TabScript:AddButton({
	Name = "Dex V4",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/SCRIPT/Dex-v4.lua"))()
    end
})

TabScript:AddButton({
	Name = "Simple Spy",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/SCRIPT/SimpleSpy.lua"))()
    end
})

local TabAnti = Tabs.Tab2
if game.Workspace:FindFirstChild("NoChanged") == nil then
local NoChanged = Instance.new("BoolValue", workspace)
NoChanged.Name = "NoChanged"
end
TabAnti:AddToggle({
    Name = "Toggle Anti",
    Default = false,
    Callback = function(Value)
game.Workspace.NoChanged.Value = Value
    end
})

TabAnti:AddSection({Name = "Anti"})

TabAnti:AddSlider({
    Name = "Transparency Anti Void",
    Min = 0,
    Max = 1,
    Default = 0.5,
    Color = Color3.fromRGB(255,255,255),
	Increment = 0.1,
	ValueName = "Transparency",
    Callback = function(Value)
_G.Transparency = Value
if _G.AntiVoid == true then
if _G.AntiVoidChoose == "Normal" then
game.Workspace["VoidPart"].Transparency = Value
game.Workspace["VoidPart"]["TAntiVoid"].Transparency = Value
elseif _G.AntiVoidChoose == "Retro" then
game.Workspace["Psycho"]["Retro1"].Transparency = Value
game.Workspace["Psycho"]["Retro1"]["Retro2"].Transparency = Value
game.Workspace["Psycho"]["Retro1"]["Retro3"].Transparency = Value
elseif _G.AntiVoidChoose == "Water" then
game.Workspace["Psycho"]["Kraken"].Transparency = Value
elseif _G.AntiVoidChoose == "Psycho" then
game.Workspace["Psycho"].Transparency = Value
elseif _G.AntiVoidChoose == "Bob" then
game.Workspace["VoidPart"]["TAntiVoid"].Transparency = Value
game.Workspace["BobWalk1"].Transparency = Value
for i,v in pairs(game.Workspace.BobWalk1:GetChildren()) do
v.Transparency = _G.Transparency
end
end
end
    end
})

if _G.AntiVoidChoose == nil then
_G.AntiVoidChoose = "Normal"
end
TabAnti:AddDropdown({
    Name = "Choose Anti Void",
    Default = "Normal",
    Options = {"Normal","Retro","Water","Psycho","Bob","Fall"},
    Callback = function(Value)
if _G.AntiVoid == true then
OrionLib.Flags["Anti Void"]:Set(false)
_G.AntiVoidChoose = Value
OrionLib.Flags["Anti Void"]:Set(true)
elseif _G.AntiVoid == false then
_G.AntiVoidChoose = Value
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Void",
    Default = false,
    Flag = "Anti Void",
    Callback = function(Value)
_G.AntiVoid = Value
if _G.AntiVoidChoose == "Normal" then
game.Workspace["VoidPart"].CanCollide = Value
game.Workspace["VoidPart"]["TAntiVoid"].CanCollide = Value
if Value == false then
game.Workspace["VoidPart"].Transparency = 1
game.Workspace["VoidPart"]["TAntiVoid"].Transparency = 1
else
game.Workspace["VoidPart"].Transparency = _G.Transparency
game.Workspace["VoidPart"]["TAntiVoid"].Transparency = _G.Transparency
end
elseif _G.AntiVoidChoose == "Retro" then
game.Workspace["Psycho"]["Retro1"].CanCollide = Value
game.Workspace["Psycho"]["Retro1"]["Retro2"].CanCollide = Value
game.Workspace["Psycho"]["Retro1"]["Retro3"].CanCollide = Value
if Value == true then
game.Workspace["Psycho"]["Retro1"].Transparency = _G.Transparency
game.Workspace["Psycho"]["Retro1"]["Retro2"].Transparency = _G.Transparency
game.Workspace["Psycho"]["Retro1"]["Retro3"].Transparency = _G.Transparency
else
game.Workspace["Psycho"]["Retro1"].Transparency = 1
game.Workspace["Psycho"]["Retro1"]["Retro2"].Transparency = 1
game.Workspace["Psycho"]["Retro1"]["Retro3"].Transparency = 1
end
elseif _G.AntiVoidChoose == "Water" then
game.Workspace["Psycho"]["Kraken"].CanCollide = Value
if Value == true then
game.Workspace["Psycho"]["Kraken"].Transparency = _G.Transparency
else
game.Workspace["Psycho"]["Kraken"].Transparency = 1
end
elseif _G.AntiVoidChoose == "Psycho" then
game.Workspace["Psycho"].CanCollide = Value
if Value == true then
game.Workspace["Psycho"].Transparency = _G.Transparency
else
game.Workspace["Psycho"].Transparency = 1
end
elseif _G.AntiVoidChoose == "Bob" then
game.Workspace["VoidPart"]["TAntiVoid"].CanCollide = Value
game.Workspace["BobWalk1"].CanCollide = Value
for i,v in pairs(game.Workspace.BobWalk1:GetChildren()) do
v.CanCollide = Value
end
if Value == true then
game.Workspace["VoidPart"]["TAntiVoid"].Transparency = _G.Transparency
game.Workspace["BobWalk1"].Transparency = _G.Transparency
for i,v in pairs(game.Workspace.BobWalk1:GetChildren()) do
v.Transparency = _G.Transparency
end
else
game.Workspace["VoidPart"]["TAntiVoid"].Transparency = 1
game.Workspace["BobWalk1"].Transparency = 1
for i,v in pairs(game.Workspace.BobWalk1:GetChildren()) do
v.Transparency = 1
end
end
elseif _G.AntiVoidChoose == "Fall" then
while _G.AntiVoid do
if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y < -30 then
game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(game.Workspace.Origo.CFrame * CFrame.new(0,-5,0))
end
task.wait()
end
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Portal",
    Default = false,
    Flag = "Anti Portal",
    Callback = function(Value)
_G.AntiPortal = Value
if _G.AntiPortal == true then
workspace.Lobby.Teleport2.CanTouch = false
workspace.Lobby.Teleport3.CanTouch = false
workspace.Lobby.Teleport4.CanTouch = false
workspace.Lobby.Teleport6.CanTouch = false
else
workspace.Lobby.Teleport2.CanTouch = true
workspace.Lobby.Teleport3.CanTouch = true
workspace.Lobby.Teleport4.CanTouch = true
workspace.Lobby.Teleport6.CanTouch = true
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Admin",
    Default = false,
    Flag = "Anti Admin",
    Callback = function(Value)
_G.AntiMods = Value
while _G.AntiMods do
for i,v in pairs(game.Players:GetChildren()) do
        if v:GetRankInGroup(9950771) >= 2 then
         _G.AntiKick = false
     game.Players.LocalPlayer:Kick("High Rank Player Detected.".." [ "..v.Name.." ]")
   break
     end
end
task.wait()
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Kick",
    Default = false,
    Flag = "Anti Kick",
    Callback = function(Value)
_G.AntiKick = Value
while _G.AntiKick do
for i,v in pairs(game.CoreGui.RobloxPromptGui.promptOverlay:GetDescendants()) do
                    if v.Name == "ErrorPrompt" then
game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
                    end
                end
task.wait()
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Afk",
    Default = false,
    Flag = "Anti Afk",
    Callback = function(Value)
_G.AntiAfk = Value
for i,v in next, getconnections(game.Players.LocalPlayer.Idled) do
if _G.AntiAfk then
v:Disable()
else
v:Enable()
end
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Obby",
    Default = false,
    Flag = "Anti Obby",
    Callback = function(Value)
_G.AntiObby = Value
while _G.AntiObby do
for _, v in pairs(game.Workspace:GetChildren()) do
          if string.find(v.Name, "Lava") then
             if v.CanTouch == true then
                 v.CanTouch = false
             end
         end
     end
task.wait()
end
if _G.AntiObby == false then
for _, v in pairs(game.Workspace:GetChildren()) do
          if string.find(v.Name, "Lava") then
              if v.CanTouch == false then
                  v.CanTouch = true
             end
         end
    end
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Megarock | Custom",
    Default = false,
    Flag = "Anti Megarock | Custom",
    Callback = function(Value)
_G.AntiRock = Value
while _G.AntiRock do
for _,v in pairs(game.Players:GetChildren()) do
                    if v:FindFirstChild("rock") then
                        v.rock.CanTouch = false
                        v.rock.CanQuery = false
                    end
                end
task.wait()
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Join Boss Guide",
    Default = false,
    Flag = "Anti Join Guide",
    Callback = function(Value)
_G.AntiJoinBossGuide = Value
while _G.AntiJoinBossGuide do
for i, v in pairs(workspace.BountyHunterRoom:GetChildren()) do
if v.Name == "Mobel" and v:FindFirstChild("Meshes/boxshadow_Cube.005") and v["Meshes/boxshadow_Cube.005"]:FindFirstChild("Hitbox") then
v["Meshes/boxshadow_Cube.005"].Hitbox.CanTouch = false
end
end
task.wait()
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Snowball",
    Default = false,
    Flag = "Anti Snowball",
    Callback = function(Value)
_G.AntiSnowball = Value
while _G.AntiSnowball do
for i, v in pairs(workspace:GetChildren()) do
if v.Name == "Snowball" and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
if 36 >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude then
v.CanTouch = false
end
end
end
task.wait()
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Ball Baller",
    Default = false,
    Flag = "Anti Ball Baller",
    Callback = function(Value)
_G.AntiBallBaller = Value
while _G.AntiBallBaller do
for i,v in pairs(game.Workspace:GetChildren()) do
                    if v.Name == "ClonedBall" then
                        v:Destroy()
                    end
                end
task.wait()
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Bus",
    Default = false,
    Flag = "Anti Bus",
    Callback = function(Value)
_G.AntiBus = Value
while _G.AntiBus do
for i,v in pairs(game.Workspace:GetChildren()) do
                    if v.Name == "BusModel" then
                        v.CanTouch = false
                    end
                end
task.wait()
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Ghost Player",
    Default = false,
    Flag = "Anti Ghost Player",
    Callback = function(Value)
_G.AntiGhostPlayer = Value
while _G.AntiGhostPlayer do
for i,v in pairs(game.Players:GetChildren()) do
if v ~= game.Players.LocalPlayer.Name and game.Workspace:FindFirstChild(v.Name.."_Body") and game.Workspace[v.Name.."_Body"]:FindFirstChild("Part") then
gloveHits[game.Players.LocalPlayer.leaderstats.Glove.Value]:FireServer(game.Workspace[v.Name.."_Body"].Part)
end
end
task.wait()
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Lure",
    Default = false,
    Flag = "Anti Lure",
    Callback = function(Value)
_G.AntiLure = Value
while _G.AntiLure do
for i,v in pairs(game.Workspace:GetChildren()) do
                    if string.find(v.Name, "_lure") and v:FindFirstChild("Root") and v:FindFirstChild("watercircle") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Root.CFrame
                    end
                end
task.wait()
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Mail",
    Default = false,
    Flag = "Anti Mail",
    Callback = function(Value)
_G.AntiMail = Value
if game.Players.LocalPlayer.Character:FindFirstChild("YouHaveGotMail") then
game.Players.LocalPlayer.Character.YouHaveGotMail.Disabled = Value
end
while _G.AntiMail do
if game.Players.LocalPlayer.Character:FindFirstChild("YouHaveGotMail") then
game.Players.LocalPlayer.Character.YouHaveGotMail.Disabled = true
end
task.wait()
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Water",
    Default = false,
    Flag = "Anti Water",
    Callback = function(Value)
_G.AntiWater = Value
while _G.AntiWater do
if game.Workspace:FindFirstChild("puddles") then
   for i,v in pairs(game.Workspace.puddles:GetChildren()) do
          if v.Name == "puddle" then
             v.CanTouch = false
         end
    end
end
task.wait()
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Jail Admin",
    Default = false,
    Flag = "Anti Jail Admin",
    Callback = function(Value)
_G.AntiJailAdmin = Value
while _G.AntiJailAdmin do
for i,v in pairs(game.Workspace:GetChildren()) do
                    if v.Name == "jail" then
for i,h in pairs(v:GetChildren()) do
                    if h.ClassName == "Part" then
                        h.CanCollide = false
                    end
                end
            end
        end
task.wait()
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Mitten Blind",
    Default = false,
    Flag = "Anti Mitten Blind",
    Callback = function(Value)
_G.AntiMittenBlind = Value
while _G.AntiMittenBlind do
if game.Players.LocalPlayer.PlayerGui:FindFirstChild("MittenBlind") then
game.Players.LocalPlayer.PlayerGui:FindFirstChild("MittenBlind"):Destroy()
end
task.wait()
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Knockoff",
    Default = false,
    Flag = "Anti Knockoff",
    Callback = function(Value)
_G.AntiKnock = Value
while _G.AntiKnock do
if game.Workspace.CurrentCamera and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and game.Workspace.CurrentCamera.CameraSubject ~= game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and game.Workspace.CurrentCamera.CameraSubject == game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'s_falsehead") then
game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
end
task.wait()
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Hallow - Jack",
    Default = false,
    Flag = "Anti Hallow - Jack",
    Callback = function(Value)
game.Players.LocalPlayer.PlayerScripts.LegacyClient.HallowJackAbilities.Disabled = Value
    end
})

TabAnti:AddToggle({
    Name = "Anti Booster",
    Default = false,
    Flag = "Anti Booster",
    Callback = function(Value)
_G.AntiBooster = Value
while _G.AntiBooster do
for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v.Name == "BoosterObject" then
                        v:Destroy()
                    end
                end
task.wait()
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Squid",
    Default = false,
    Flag = "Anti Squid",
    Callback = function(Value)
_G.AntiSquid = Value
if _G.AntiSquid == false then
game.Players.LocalPlayer.PlayerGui.SquidInk.Enabled = true
end
while _G.AntiSquid do
if game.Players.LocalPlayer.PlayerGui:FindFirstChild("SquidInk") then
game.Players.LocalPlayer.PlayerGui.SquidInk.Enabled = false
end
task.wait()
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Conveyor",
    Default = false,
    Flag = "Anti Conveyor",
    Callback = function(Value)
game.Players.LocalPlayer.PlayerScripts.LegacyClient.ConveyorVictimized.Disabled = Value
    end
})

TabAnti:AddToggle({
    Name = "Anti Ice",
    Default = false,
    Flag = "Anti Ice",
    Callback = function(Value)
_G.AntiIce = Value
while _G.AntiIce do
    for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if v.Name == "Icecube" then
                v:Destroy()
                game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
                game.Players.LocalPlayer.Character.Humanoid.AutoRotate = true
            end
       end
task.wait()
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Time Stop",
    Default = false,
    Flag = "Anti Time Stop",
    Callback = function(Value)
_G.AntiTimestop = Value
while _G.AntiTimestop do
                for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if v.ClassName == "Part" then
                        v.Anchored = false
                    end
                end
task.wait()
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Null",
    Default = false,
    Flag = "Anti Null",
    Callback = function(Value)
_G.AntiNull = Value
while _G.AntiNull do
for i,v in pairs(game.Workspace:GetChildren()) do
                if v.Name == "Imp" and v:FindFirstChild("Body") then
                       gloveHits[game.Players.LocalPlayer.leaderstats.Glove.Value]:FireServer(v.Body,true)
                 end
            end
task.wait()
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Run",
    Default = false,
    Flag = "Anti Run",
    Callback = function(Value)
_G.AutoExit = Value
while _G.AutoExit do
if game.Players.LocalPlayer.Character:FindFirstChild("InLabyrinth") then
for i, v in pairs(workspace:GetChildren()) do
    if string.find(v.Name, "Labyrinth") and v:FindFirstChild("Doors") then
        for i, y in ipairs(v.Doors:GetChildren()) do
            if y:FindFirstChild("Hitbox") and y.Hitbox:FindFirstChild("TouchInterest") then
              y.Hitbox.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            end
        end
    end
end
end
task.wait()
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Brick",
    Default = false,
    Flag = "Anti Brick",
    Callback = function(Value)
_G.AntiBrick = Value
while _G.AntiBrick do
for i,v in pairs(game.Workspace:GetChildren()) do
                    if v.Name == "Union" then
                        v.CanTouch = false
                        v.CanQuery = false
                    end
                end
task.wait()
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Record",
    Default = false,
    Flag = "Anti Record",
    Callback = function(Value)
_G.AntiRecord = Value
    end
})
for i,p in pairs(game.Players:GetChildren()) do
if p ~= game.Players.LocalPlayer then
p.Chatted:Connect(function(message)
Words = message:split(" ")
if _G.AntiRecord == true then
for i, v in pairs(Words) do
if v:lower():match("recording") or v:lower():match(" rec") or v:lower():match("record") or v:lower():match("discor") or v:lower():match(" disco") or v:lower():match(" disc") or v:lower():match("ticket") or v:lower():match("tickets") or v:lower():match(" ds") or v:lower():match(" dc") or v:lower():match("dizzy") or v:lower():match("dizzycord") or v:lower():match(" clip") or v:lower():match("proof") or v:lower():match("evidence") then
AntiKick:Set(false)
game.Players.LocalPlayer:Kick("Possible player recording detected.".." [ "..p.Name.." ]".." [ "..message.." ]")
end
end
end
end)
end
end
game.Players.PlayerAdded:Connect(function(Player)
Player.Chatted:Connect(function(message)
Words = message:split(" ")
if _G.AntiRecord == true then
for i, v in pairs(Words) do
if v:lower():match("recording") or v:lower():match(" rec") or v:lower():match("record") or v:lower():match("discor") or v:lower():match(" disco") or v:lower():match(" disc") or v:lower():match("ticket") or v:lower():match("tickets") or v:lower():match(" ds") or v:lower():match(" dc") or v:lower():match("dizzy") or v:lower():match("dizzycord") or v:lower():match(" clip") or v:lower():match("proof") or v:lower():match("evidence") then
AntiKick:Set(false)
game.Players.LocalPlayer:Kick("Possible player recording detected.".." [ "..Player.Name.." ]".." [ "..message.." ]")
end
end
end
end)
end)

TabAnti:AddToggle({
    Name = "Anti [REDACTED]",
    Default = false,
    Flag = "Anti [REDACTED]",
    Callback = function(Value)
game.Players.LocalPlayer.PlayerScripts.LegacyClient.Well.Disabled = Value
    end
})

TabAnti:AddToggle({
    Name = "Anti Brazil",
    Default = false,
    Flag = "Anti Brazil",
    Callback = function(Value)
_G.AntiBrazil = Value
while _G.AntiBrazil do
for i,v in pairs(game.workspace.Lobby.brazil:GetChildren()) do
                  if v.CanTouch == true then
                     v.CanTouch = false
                 end
             end
task.wait()
end
if _G.AntiBrazil == false then
for i,v in pairs(game.workspace.Lobby.brazil:GetChildren()) do
                  if v.CanTouch == false then
                     v.CanTouch = true
                 end
            end
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Za Hando",
    Default = false,
    Flag = "Anti Za Hando",
    Callback = function(Value)
_G.AntiZaHando = Value
            while _G.AntiZaHando do
                for i,v in pairs(game.Workspace:GetChildren()) do
                    if v.ClassName == "Part" and v.Name == "Part" then
                        v:Destroy()
                    end
                end
task.wait()
            end
    end
})

TabAnti:AddToggle({
    Name = "Anti Bob",
    Default = false,
    Flag = "Anti Bob",
    Callback = function(Value)
_G.AntiBob = Value
while _G.AntiBob do
for i, v in pairs(game.Workspace:GetChildren()) do
if string.find(v.Name, "ÅBOB_") and v:FindFirstChild("Target") and v.Target.Value == game.Players.LocalPlayer.Name then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Arena.CubeOfDeathArea["the cube of death(i heard it kills)"].Part.CFrame * CFrame.new(0,30,0)
OrionLib.Flags["Anti COD"]:Set(true)
end
end
task.wait()
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Fort",
    Default = false,
    Flag = "Anti Fort",
    Callback = function(Value)
_G.AntiFort = Value
            while _G.AntiFort do
                for i,v in pairs(game.Workspace:GetChildren()) do
                    if v.Name == "Part" then
                        v.CanCollide = false
                    end
                end
task.wait()
            end
    end
})

TabAnti:AddToggle({
    Name = "Anti Reaper",
    Default = false,
    Flag = "Anti Reaper",
    Callback = function(Value)
_G.AntiReaper = Value
            while _G.AntiReaper do
for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v.Name == "DeathMark" then
                        game:GetService("ReplicatedStorage").ReaperGone:FireServer(game:GetService("Players").LocalPlayer.Character.DeathMark)
                    game:GetService("Lighting"):WaitForChild("DeathMarkColorCorrection"):Destroy() 
                    end
                end
task.wait()
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Pusher",
    Default = false,
    Flag = "Anti Pusher",
    Callback = function(Value)
_G.AntiPusher = Value
while _G.AntiPusher do
for i,v in pairs(game.Workspace:GetChildren()) do
                    if v.Name == "wall" then
                        v.CanCollide = false
                    end
                end
task.wait()
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Defend",
    Default = false,
    Flag = "Anti Defend",
    Callback = function(Value)
_G.NoclipBarrier = Value
if _G.NoclipBarrier == false then
for i,v in pairs(game.Workspace:GetChildren()) do
                    if string.find(v.Name, "ÅBarrier") then
                        if v.CanCollide == false then
                            v.CanCollide = true
                         end
                    end
                end
           end
while _G.NoclipBarrier do
for i,v in pairs(game.Workspace:GetChildren()) do
                    if string.find(v.Name, "ÅBarrier") then
                        if v.CanCollide == true then
                            v.CanCollide = false
                         end
                     end
                end
task.wait()
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Bubble",
    Default = false,
    Flag = "Anti Bubble",
    Callback = function(Value)
_G.AntiBubble = Value
while _G.AntiBubble do
for i,v in pairs(workspace:GetChildren()) do
                    if v.Name == "BubbleObject" and v:FindFirstChild("Weld") then
                        v:FindFirstChild("Weld"):Destroy()
                    end
               end
task.wait()
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Stun",
    Default = false,
    Flag = "Anti Stun",
    Callback = function(Value)
_G.AntiStun = Value
while _G.AntiStun do
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Workspace:FindFirstChild("Shockwave") and game.Players.LocalPlayer.Character.Ragdolled.Value == false then
game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
end
task.wait()
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Cube Of Death",
    Default = false,
    Flag = "Anti COD",
    Callback = function(Value)
if Value == true then
if game.Workspace:FindFirstChild("the cube of death(i heard it kills)", 1) and game.Workspace.Arena.CubeOfDeathArea["the cube of death(i heard it kills)"]:FindFirstChild("Part") then
game.Workspace.Arena.CubeOfDeathArea["the cube of death(i heard it kills)"].CanTouch = false
game.Workspace.Arena.CubeOfDeathArea["the cube of death(i heard it kills)"].Part.CanTouch = false
end
else
if game.Workspace:FindFirstChild("the cube of death(i heard it kills)", 1) and game.Workspace.Arena.CubeOfDeathArea["the cube of death(i heard it kills)"]:FindFirstChild("Part") then
game.Workspace.Arena.CubeOfDeathArea["the cube of death(i heard it kills)"].CanTouch = true
game.Workspace.Arena.CubeOfDeathArea["the cube of death(i heard it kills)"].Part.CanTouch = true
end
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Death Barriers",
    Default = false,
    Flag = "Anti Death Barriers",
    Callback = function(Value)
if Value == true then
for i,v in pairs(game.Workspace.DEATHBARRIER:GetChildren()) do
                    if v.ClassName == "Part" and v.Name == "BLOCK" then
                        v.CanTouch = false
                    end
                end
workspace.DEATHBARRIER.CanTouch = false
workspace.DEATHBARRIER2.CanTouch = false
workspace.dedBarrier.CanTouch = false
workspace.ArenaBarrier.CanTouch = false
workspace.AntiDefaultArena.CanTouch = false
else
for i,v in pairs(game.Workspace.DEATHBARRIER:GetChildren()) do
                    if v.ClassName == "Part" and v.Name == "BLOCK" then
                        v.CanTouch = true
                    end
                end
workspace.DEATHBARRIER.CanTouch = true
workspace.DEATHBARRIER2.CanTouch = true
workspace.dedBarrier.CanTouch = true
workspace.ArenaBarrier.CanTouch = true
workspace.AntiDefaultArena.CanTouch = true
end
    end
})

TabAnti:AddToggle({
    Name = "Anti Ragdoll",
    Default = false,
    Flag = "Anti Ragdoll",
    Callback = function(Value)
_G.AntiRagdoll = Value
while _G.AntiRagdoll do
if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("Torso") and game.Players.LocalPlayer.Character:FindFirstChild("Ragdolled") then
if game.Players.LocalPlayer.Character:FindFirstChild("Ragdolled") and game.Players.LocalPlayer.Character:WaitForChild("Ragdolled").Value == true then
repeat task.wait()
if game.Players.LocalPlayer.Character:FindFirstChild("Torso") then
game.Players.LocalPlayer.Character.Torso.Anchored = true
end
until game.Players.LocalPlayer.Character:FindFirstChild("Ragdolled") and game.Players.LocalPlayer.Character:WaitForChild("Ragdolled").Value == false
if game.Players.LocalPlayer.Character:FindFirstChild("Torso") then
game.Players.LocalPlayer.Character.Torso.Anchored = false
end
end
end
task.wait()
end
    end
})

local TabBadge = Tabs.Tab3
TabBadge:AddDropdown({
	Name = "Teleport Safe",
	Default = "",
	Options = {"SafeSpotBox 1.0", "SafeSpotBox 2.0", "Bed"},
	Callback = function(Value)
if Value == "SafeSpotBox 1.0" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["SafeBox"].CFrame * CFrame.new(0,5,0)
elseif Value == "SafeSpotBox 2.0" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["Safespot"].CFrame * CFrame.new(0,10,0)
elseif Value == "Bed" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["Bed"].Bed3.CFrame * CFrame.new(0,0,-1)
end
	end    
})

TabBadge:AddDropdown({
	Name = "Retro Obby",
	Default = "",
	Options = {"Get Badge", "Show All", "Off Show All", "Teleport Spawn 1", "Teleport Spawn 2", "Teleport Spawn 3", "Click Button"},
	Callback = function(Value)
if Value == "Get Badge" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.FinishDoor_Retro.Part.CFrame
elseif Value == "Show All" then
if game.ReplicatedStorage.Assets:FindFirstChild("Retro") then
game.ReplicatedStorage.Assets.Retro.Parent = game.Workspace
end
elseif Value == "Off Show All" then
if game.ReplicatedStorage.Assets:FindFirstChild("Retro") == nil then
game.Workspace.Retro.Parent = game.ReplicatedStorage.Assets
end
elseif Value == "Teleport Spawn 1" then
if game.Workspace:FindFirstChild("Retro") and game.Workspace.Retro:FindFirstChild("Map") and game.Workspace.Retro.Map:FindFirstChild("RetroObbyMap") and game.Workspace.Retro.Map.RetroObbyMap:FindFirstChild("Spawn") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Retro.Map.RetroObbyMap.Spawn.CFrame
end
elseif Value == "Teleport Spawn 2" then
if game.Workspace:FindFirstChild("Retro") and game.Workspace.Retro:FindFirstChild("Map") and game.Workspace.Retro.Map:FindFirstChild("RetroObbyMap") and game.Workspace.Retro.Map.RetroObbyMap:FindFirstChild("Spawn_stage2") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Retro.Map.RetroObbyMap.Spawn_stage2.CFrame
end
elseif Value == "Teleport Spawn 3" then
if game.Workspace:FindFirstChild("Retro") and game.Workspace.Retro:FindFirstChild("Map") and game.Workspace.Retro.Map:FindFirstChild("RetroObbyMap") and game.Workspace.Retro.Map.RetroObbyMap:FindFirstChild("Spawn_stage3") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Retro.Map.RetroObbyMap.Spawn_stage3.CFrame
end
elseif Value == "Click Button" then
if game.ReplicatedStorage:FindFirstChild("Assets") and game.ReplicatedStorage.Assets:FindFirstChild("Retro") then
game.ReplicatedStorage.Assets.Retro.Parent = game.Workspace
wait(1.5)
if game.Workspace:FindFirstChild("Retro") and game.Workspace.Retro:FindFirstChild("Map") then
fireclickdetector(workspace.Retro.Map.RetroObbyMap:GetChildren()[5].StaffApp.Button.ClickDetector)
end
else
if game.Workspace:FindFirstChild("Retro") and game.Workspace.Retro:FindFirstChild("Map") then
fireclickdetector(workspace.Retro.Map.RetroObbyMap:GetChildren()[5].StaffApp.Button.ClickDetector)
end
end
end
	end    
})

TabBadge:AddDropdown({
	Name = "Map Kraken",
    Default = "",
    Options = {"Show All","Off Show All", "Teleport Enter"},
    Callback = function(Value)
if Value == "Show All" then
game.ReplicatedStorage.AbyssAssets.Abyss.Parent = game.Workspace
elseif Value == "Off Show All" then
game.Workspace.Abyss.Parent = game.ReplicatedStorage.AbyssAssets
elseif Value == "Teleport Enter" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Abyss.Spawn.CFrame * CFrame.new(0,10,0)
end
    end
})

TabBadge:AddButton({
	Name = "Reset Player",
	Callback = function()
game:GetService("Players").LocalPlayer.Reset:FireServer()
  	end    
})

TabBadge:AddSection({Name = "Auto Get Badge"})

TabBadge:AddButton({
    Name = "Auto Get Boxing",
    Callback = function()
local teleportFunc = queueonteleport or queue_on_teleport
    if teleportFunc then
        teleportFunc([[
            if not game:IsLoaded() then
                game.Loaded:Wait()
            end
            repeat wait() until game.Players.LocalPlayer
if game.Workspace:FindFirstChild("BoxingGloves") == nil then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Buildings.house:FindFirstChild("TP").CFrame * CFrame.new(0,10,0)
repeat task.wait()
if game.Workspace:FindFirstChild("BoxingGloves") then
for i,v in pairs(game.Workspace:GetChildren()) do
if v.Name == "BoxingGloves" and v:FindFirstChild("ClickDetector") then
fireclickdetector(v.ClickDetector, 0)
fireclickdetector(v.ClickDetector, 1)
end
end
end
until game:GetService("BadgeService"):UserHasBadgeAsync(game.Players.LocalPlayer.UserId, 1223765330375569)
else
for i,v in pairs(game.Workspace:GetChildren()) do
if v.Name == "BoxingGloves" and v:FindFirstChild("ClickDetector") then
fireclickdetector(v.ClickDetector, 0)
fireclickdetector(v.ClickDetector, 1)
end
end
end
]])
elseif not teleportFunc then
Notification("Bruh, Not only executor you autoexe", 5)
end
    end
})

TabBadge:AddButton({
    Name = "Auto Get FrostBite",
    Callback = function()
local teleportFunc = queueonteleport or queue_on_teleport
    if teleportFunc then
        teleportFunc([[
            if not game:IsLoaded() then
                game.Loaded:Wait()
            end
            repeat wait() until game.Players.LocalPlayer
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-554, 177, 56)
wait(0.7)
for i,v in ipairs(game:GetService("Workspace"):GetDescendants()) do
            if v.ClassName == "ProximityPrompt" then
                v.HoldDuration = 0
                fireproximityprompt(v)
            end
        end
]])
elseif not teleportFunc then
Notification("Bruh, Not only executor you autoexe", 5)
end
game:GetService("TeleportService"):Teleport(17290438723)
  	end    
})

TabBadge:AddButton({
    Name = "Auto Get Admin",
    Callback = function()
local teleportFunc = queueonteleport or queue_on_teleport
    if teleportFunc then
        teleportFunc([[
            if not game:IsLoaded() then
                game.Loaded:Wait()
            end
            repeat wait() until game.Players.LocalPlayer
wait(13.5)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(502, 76, 59)
task.wait(6)
if getconnections then
for i,v in next, getconnections(game.Players.LocalPlayer.Idled) do
v:Disable() 
end
end
]])
elseif not teleportFunc then
Notification("Bruh, Not only executor you autoexe", 5)
end
if game.ReplicatedStorage:FindFirstChild("Assets") and game.ReplicatedStorage.Assets:FindFirstChild("Retro") then
game.ReplicatedStorage.Assets.Retro.Parent = game.Workspace
wait(1.5)
if game.Workspace:FindFirstChild("Retro") and game.Workspace.Retro:FindFirstChild("Map") then
for i, v in pairs(workspace.Retro.Map.RetroObbyMap:GetChildren()) do
if v.Name == "Model" and v:FindFirstChild("StaffApp") and v.StaffApp:FindFirstChild("Button") and v.StaffApp.Button:FindFirstChild("ClickDetector") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.StaffApp.Button.CFrame
wait(0.3)
fireclickdetector(v.StaffApp.Button.ClickDetector)
end
end
end
else
if game.Workspace:FindFirstChild("Retro") and game.Workspace.Retro:FindFirstChild("Map") then
for i, v in pairs(workspace.Retro.Map.RetroObbyMap:GetChildren()) do
if v.Name == "Model" and v:FindFirstChild("StaffApp") and v.StaffApp:FindFirstChild("Button") and v.StaffApp.Button:FindFirstChild("ClickDetector") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.StaffApp.Button.CFrame
wait(0.3)
fireclickdetector(v.StaffApp.Button.ClickDetector)
end
end
end
end
    end
})

TabBadge:AddButton({
    Name = "Auto Get Chain",
    Callback = function()
if game.Players.LocalPlayer.leaderstats.Slaps.Value >= 1000 then
local teleportFunc = queueonteleport or queue_on_teleport
if teleportFunc then
    teleportFunc([[
        if not game:IsLoaded() then
            game.Loaded:Wait()
        end
        repeat wait() until game.Players.LocalPlayer
 repeat wait() until game.Workspace:FindFirstChild("Map"):FindFirstChild("CodeBrick")
if game.Workspace.Map.CodeBrick.SurfaceGui:FindFirstChild("IMGTemplate") then
game.Workspace.Map.CodeBrick.SurfaceGui.IMGTemplate.Name = "1st"
game.Workspace.Map.CodeBrick.SurfaceGui.IMGTemplate.Name = "2nd"
game.Workspace.Map.CodeBrick.SurfaceGui.IMGTemplate.Name = "3rd"
game.Workspace.Map.CodeBrick.SurfaceGui.IMGTemplate.Name = "4th"
end
for i,v in pairs(game.Workspace.Map.CodeBrick.SurfaceGui:GetChildren()) do
                    if v.Name == "1st" then
                        if v.Image == "http://www.roblox.com/asset/?id=9648769161" then
                    first = "4"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648765536" then
                    first = "2"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648762863" then
                    first = "3"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648759883" then
                    first = "9"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648755440" then
                    first = "8"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648752438" then
                    first = "2"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648749145" then
                    first = "8"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648745618" then
                    first = "3"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648742013" then
                    first = "7"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648738553" then
                    first = "8"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648734698" then
                    first = "2"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648730082" then
                    first = "6"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648723237" then
                    first = "3"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648718450" then
                    first = "6"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648715920" then
                    first = "6"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648712563" then
                    first = "2"
                end
                    end
                end
for i,v in pairs(game.Workspace.Map.CodeBrick.SurfaceGui:GetChildren()) do
                    if v.Name == "2nd" then
                        if v.Image == "http://www.roblox.com/asset/?id=9648769161" then
                    second = "4"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648765536" then
                    second = "2"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648762863" then
                    second = "3"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648759883" then
                    second = "9"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648755440" then
                    second = "8"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648752438" then
                    second = "2"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648749145" then
                    second = "8"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648745618" then
                    second = "3"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648742013" then
                    second = "7"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648738553" then
                    second = "8"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648734698" then
                    second = "2"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648730082" then
                    second = "6"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648723237" then
                    second = "3"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648718450" then
                    second = "6"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648715920" then
                    second = "6"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648712563" then
                    second = "2"
                end
                    end
                end
for i,v in pairs(game.Workspace.Map.CodeBrick.SurfaceGui:GetChildren()) do
                    if v.Name == "3rd" then
                        if v.Image == "http://www.roblox.com/asset/?id=9648769161" then
                    third = "4"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648765536" then
                    third = "2"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648762863" then
                    third = "3"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648759883" then
                    third = "9"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648755440" then
                    third = "8"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648752438" then
                    third = "2"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648749145" then
                    third = "8"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648745618" then
                    third = "3"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648742013" then
                    third = "7"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648738553" then
                    third = "8"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648734698" then
                    third = "2"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648730082" then
                    third = "6"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648723237" then
                    third = "3"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648718450" then
                    third = "6"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648715920" then
                    third = "6"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648712563" then
                    third = "2"
                end
                    end
                end
for i,v in pairs(game.Workspace.Map.CodeBrick.SurfaceGui:GetChildren()) do
                    if v.Name == "4th" then
                        if v.Image == "http://www.roblox.com/asset/?id=9648769161" then
                    fourth = "4"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648765536" then
                    fourth = "2"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648762863" then
                    fourth = "3"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648759883" then
                    fourth = "9"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648755440" then
                    fourth = "8"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648752438" then
                    fourth = "2"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648749145" then
                    fourth = "8"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648745618" then
                    fourth = "3"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648742013" then
                    fourth = "7"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648738553" then
                    fourth = "8"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648734698" then
                    fourth = "2"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648730082" then
                    fourth = "6"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648723237" then
                    fourth = "3"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648718450" then
                    fourth = "6"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648715920" then
                    fourth = "6"
                elseif v.Image == "http://www.roblox.com/asset/?id=9648712563" then
                    fourth = "2"
                end
                    end
                end
fireclickdetector(game.Workspace.Map.OriginOffice.Door.Keypad.Buttons.Reset.ClickDetector)
task.wait(0.1)
fireclickdetector(game.Workspace.Map.OriginOffice.Door.Keypad.Buttons[first].ClickDetector)
task.wait(0.1)
fireclickdetector(game.Workspace.Map.OriginOffice.Door.Keypad.Buttons[second].ClickDetector)
task.wait(0.1)
fireclickdetector(game.Workspace.Map.OriginOffice.Door.Keypad.Buttons[third].ClickDetector)
task.wait(0.1)
fireclickdetector(game.Workspace.Map.OriginOffice.Door.Keypad.Buttons[fourth].ClickDetector)
task.wait(0.1)
fireclickdetector(game.Workspace.Map.OriginOffice.Door.Keypad.Buttons.Enter.ClickDetector)
task.wait(2)
game:GetService("TeleportService"):Teleport(6403373529)
    ]])
elseif not teleportFunc then
Notification("Bruh, Not only executor you autoexe", 5)
end
game:GetService("TeleportService"):Teleport(9431156611)
else
Notification("You don't have 1000 slap.", 5)
end
    end
})

TabBadge:AddButton({
    Name = "Get Counter + Elude",
    Callback = function()
local teleportFunc = queueonteleport or queue_on_teleport
if teleportFunc then
    teleportFunc([[
        if not game:IsLoaded() then
            game.Loaded:Wait()
        end
        repeat wait() until game.Players.LocalPlayer
        wait(3)
Time = 121
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.CounterLever.Main.CFrame
game.Workspace.CounterLever.ClickDetector.MouseClick:Connect(function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0,100,0)
wait(0.2)
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
for i = 1,Time do
Time = Time - 1
game:GetService("StarterGui"):SetCore("SendNotification",{Title = "Error",Text = "You wait time [ "..Time.." ] receive.",Icon = "rbxassetid://7733658504",Duration = 1})
wait(1)
end
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
for i, v in pairs(workspace.Maze:GetChildren()) do
if v.Name == "Part" and v:FindFirstChild("A0") and v:FindFirstChild("ClickDetector") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame * CFrame.new(0,-20,0)
v.ClickDetector.MouseClick:Connect(function()
game.Workspace.Ruins.Elude.Glove.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
end)
end
end
end)
    ]])
elseif not teleportFunc then
Notification("Bruh, Not only executor you autoexe", 5)
end
game:GetService("TeleportService"):Teleport(11828384869)
    end
})

TabBadge:AddSection({Name = "Badge"})

TabBadge:AddButton({
	Name = "Get Glove Kinetic",
	Callback = function()
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Stun" and game.Players.LocalPlayer.Character:FindFirstChild("entered") then
OGL = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
for i = 1,150 do
game.ReplicatedStorage.SelfKnockback:FireServer({["Force"] = 0,["Direction"] = Vector3.new(0,0.01,0)})
wait(0.05)
end
wait(1.5)
repeat
local players = game.Players:GetChildren()
local RandomPlayer = players[math.random(1, #players)]
repeat RandomPlayer = players[math.random(1, #players)] until RandomPlayer ~= game.Players.LocalPlayer and RandomPlayer.Character:FindFirstChild("entered") and RandomPlayer.Character:FindFirstChild("rock") == nil and RandomPlayer.Character.Head:FindFirstChild("UnoReverseCard") == nil and RandomPlayer.Character.Humanoid.Health ~= 0
Target = RandomPlayer
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame * CFrame.new(0,-20,0)
wait(0.25)
game.ReplicatedStorage.StunR:FireServer(game.Players.LocalPlayer.Character.Stun)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OGL
wait(0.5)
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("EMPStunBadgeCounter") then
Notification("Counter Stun [ "..game.Players.LocalPlayer.Character.EMPStunBadgeCounter.Value.." ]", 5)
end
wait(12.3)
until game.Players.LocalPlayer.Character:FindFirstChild("EMPStunBadgeCounter") and game.Players.LocalPlayer.Character.EMPStunBadgeCounter.Value >= 50
else
Notification("You don't have Stun equipped, or you aren't in the arena", 5)
end
  	end 
})

TabBadge:AddButton({
	Name = "Get Glove Bomb",
	Callback = function()
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Warp" and not game:GetService("BadgeService"):UserHasBadgeAsync(game.Players.LocalPlayer.UserId, 2124919840) then
OldTouch = workspace.DEATHBARRIER.CanTouch
local players = game.Players:GetChildren()
local RandomPlayer = players[math.random(1, #players)]
repeat RandomPlayer = players[math.random(1, #players)] until RandomPlayer ~= game.Players.LocalPlayer and RandomPlayer.Character:FindFirstChild("entered") and RandomPlayer.Character:FindFirstChild("Ragdolled").Value == false
Target = RandomPlayer
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character:FindFirstChild("HumanoidRootPart").CFrame
task.wait(0.2)
game.ReplicatedStorage.WarpHt:FireServer(Target.Character:WaitForChild("HumanoidRootPart"))
task.wait(0.15)
if workspace.DEATHBARRIER.CanTouch == true then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").DEATHBARRIER.CFrame
else
workspace.DEATHBARRIER.CanTouch = true
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").DEATHBARRIER.CFrame
end
wait(0.1)
game:GetService("ReplicatedStorage").WLOC:FireServer()
wait(0.2)
workspace.DEATHBARRIER.CanTouch = OldTouch
else
Notification("You don't have Warp equipped, or you have owner badge", 5)
end
  	end    
})

TabBadge:AddButton({
	Name = "Get Glove Plank",
	Callback = function()
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Fort" and not game:GetService("BadgeService"):UserHasBadgeAsync(game.Players.LocalPlayer.UserId, 4031317971987872) then
OGL = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(8, 97, 4)
wait(0.2)
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
wait(0.3)
game:GetService("ReplicatedStorage").Fortlol:FireServer()
wait(3.5)
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
wait(0.1)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(8, 106, -6)
wait(0.5)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OGL
else
Notification("You don't have Fort equipped, or you have owner badge [ Don't Turn On Shiftlock Please ]", 5)
end
  	end    
})

TabBadge:AddButton({
	Name = "Get Glove Blasphemy",
	Callback = function()
if game.Players.LocalPlayer.leaderstats.Glove.Value == "bus" and not game:GetService("BadgeService"):UserHasBadgeAsync(game.Players.LocalPlayer.UserId, 3335299217032061) then
OGL = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
repeat
if game.Players.LocalPlayer.Character.Humanoid.Health == 0 or game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil then
break
end
if game.Players.LocalPlayer.Character:FindFirstChild("entered") then
local players = game.Players:GetChildren()
local RandomPlayer = players[math.random(1, #players)]
repeat RandomPlayer = players[math.random(1, #players)] until RandomPlayer ~= game.Players.LocalPlayer and RandomPlayer.Character:FindFirstChild("rock") == nil and RandomPlayer.Character.Head:FindFirstChild("UnoReverseCard") == nil and RandomPlayer.Character:FindFirstChild("entered")
Target = RandomPlayer
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame
task.wait(0.34)
game:GetService("ReplicatedStorage").busmoment:FireServer()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OGL
wait(0.8)
repeat task.wait()
for i,v in pairs(game.Workspace:GetChildren()) do
if v.Name == "BusModel" then
v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
end
end
if game.Players.LocalPlayer.Character:FindFirstChild("Torso") then
game.Players.LocalPlayer.Character.Torso.Anchored = true
end
until game.Workspace:FindFirstChild("BusModel") == nil
if game.Players.LocalPlayer.Character:FindFirstChild("Torso") then
game.Players.LocalPlayer.Character.Torso.Anchored = false
end
end
wait(5.5)
until game:GetService("BadgeService"):UserHasBadgeAsync(game.Players.LocalPlayer.UserId, 3335299217032061)
else
Notification("You don't have bus equipped, or you have owner badge", 5)
end
  	end    
})

TabBadge:AddButton({
    Name = "Auto Quests Chest All Glove",
    Callback = function()
repeat task.wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(289, 13, 261)
game:GetService("ReplicatedStorage").DigEvent:FireServer({["index"] = 2,["cf"] = CFrame.new(42.7222366, -6.17449856, 91.5175781, -0.414533257, 1.72594355e-05, -0.91003418, -5.57037238e-05, 1, 4.4339522e-05, 0.91003418, 6.90724992e-05, -0.414533257)})
until game.Workspace:FindFirstChild("TreasureChestFolder") and game.Workspace.TreasureChestFolder:FindFirstChild("TreasureChest")
wait(1)
game.Workspace.TreasureChestFolder.TreasureChest.OpenRemote:FireServer()
wait(0.9)
game:GetService("Players").LocalPlayer.Reset:FireServer()
wait(3.75)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.BountyHunterRoom.BountyHunterBooth._configPart.CFrame * CFrame.new(-5,0,0)
    end
})

TabBadge:AddButton({
    Name = "Get Glove [Redacted]",
    Callback = function()
if game.Players.LocalPlayer.leaderstats.Slaps.Value >= 5000 then
Door = 0
for i = 1, 10 do
if Door ~= nil then
Door = Door + 1
end
if Door ~= nil and game:GetService("BadgeService"):UserHasBadgeAsync(game.Players.LocalPlayer.UserId, 2124847850) then
Door = nil
Notification("You have Owner Badge", 5)
else
repeat task.wait()
if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.PocketDimension.Doors[Door].CFrame
end
until game.Players.LocalPlayer.Character.Humanoid.Health == 0
wait(3.75)
end
end
else
Notification("You don't have 5000 slap", 5)
end
    end
})

TabBadge:AddButton({
    Name = "Voodoo + Fish + Trap Farm",
    Callback = function()
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Ghost" and game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil then
game.ReplicatedStorage.Ghostinvisibilityactivated:FireServer()
fireclickdetector(workspace.Lobby["ZZZZZZZ"].ClickDetector)
wait(0.2)
game:GetService("ReplicatedStorage").ZZZZZZZSleep:FireServer()
fireclickdetector(workspace.Lobby["Brick"].ClickDetector)
wait(0.2)
if not game.Players.LocalPlayer.Character:FindFirstChild("entered") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
repeat task.wait()
game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(workspace.Lobby.Teleport1.CFrame)
until game.Players.LocalPlayer.Character:FindFirstChild("entered")
end
wait(0.35)
game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(game.Workspace["SafeBox"].CFrame * CFrame.new(0,5,0))
wait(0.2)
repeat wait(1)
if _G.AutoBrick == "Fast" then
game:GetService("ReplicatedStorage").lbrick:FireServer()
game:GetService("Players").LocalPlayer.PlayerGui.BRICKCOUNT.ImageLabel.TextLabel.Text = game:GetService("Players").LocalPlayer.PlayerGui.BRICKCOUNT.ImageLabel.TextLabel.Text + 1
elseif _G.AutoBrick == "Slow" then
game:GetService("VirtualInputManager"):SendKeyEvent(true,"E",false,x)
end
until game:GetService("BadgeService"):UserHasBadgeAsync(game.Players.LocalPlayer.UserId, 2127567042)
else
Notification("You don't have Ghost equipped, or You have go to lobby", 5)
end
    end
})

TabBadge:AddButton({
    Name = "Get Duck & Orange & Knife Badge",
    Callback = function()
if not game:GetService("BadgeService"):UserHasBadgeAsync(game.Players.LocalPlayer.UserId, 2124760907) and not game:GetService("BadgeService"):UserHasBadgeAsync(game.Players.LocalPlayer.UserId, 2128220957) and not game:GetService("BadgeService"):UserHasBadgeAsync(game.Players.LocalPlayer.UserId, 2124760916) then
fireclickdetector(game.Workspace.Lobby.Scene.knofe.ClickDetector)
fireclickdetector(game.Workspace.Arena.island5.Orange.ClickDetector) 
fireclickdetector(game.Workspace.Arena["default island"]["Rubber Ducky"].ClickDetector)
else
Notification("You have Owner badge", 5)
end
    end
})

TabBadge:AddButton({
    Name = "Get Free Ice Skate",
    Callback = function()
if not game:GetService("BadgeService"):UserHasBadgeAsync(game.Players.LocalPlayer.UserId, 2906002612987222) then
game:GetService("ReplicatedStorage").IceSkate:FireServer("Freeze")
else
Notification("You have Owner badge", 5)
end
    end
})

TabBadge:AddButton({
    Name = "Get Free Lamp",
    Callback = function()
if game.Players.LocalPlayer.leaderstats.Glove.Value == "ZZZZZZZ" and not game:GetService("BadgeService"):UserHasBadgeAsync(game.Players.LocalPlayer.UserId, 490455814138437) then
repeat task.wait()
game:GetService("ReplicatedStorage").nightmare:FireServer("LightBroken")
until game:GetService("BadgeService"):UserHasBadgeAsync(game.Players.LocalPlayer.UserId, 490455814138437)
else
Notification("You don't have ZZZZZZZ equipped, or Owner badge", 5)
end
    end
})

TabBadge:AddButton({
    Name = "Get The Schlop",
    Callback = function()
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Cloud" and game:GetService("BadgeService"):UserHasBadgeAsync(game.Players.LocalPlayer.UserId, 2130032297) and game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Arena.CannonIsland.Cannon.Base.CFrame * CFrame.new(0,2,35)
wait(0.3)
game:GetService("ReplicatedStorage").CloudAbility:FireServer()
fireclickdetector(workspace.Lobby.fish.ClickDetector)
wait(0.2)
if not game.Players.LocalPlayer.Character:FindFirstChild("entered") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
repeat task.wait()
game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(workspace.Lobby.Teleport1.CFrame)
until game.Players.LocalPlayer.Character:FindFirstChild("entered")
end
wait(0.3)
if game.Players.LocalPlayer.Character:FindFirstChild("entered") and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") ~= nil and game.Players.LocalPlayer.Character.Humanoid.Sit == false then
for i,v in pairs(game.Workspace:GetChildren()) do
                    if v.Name:match(game.Players.LocalPlayer.Name) and v:FindFirstChild("VehicleSeat") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.VehicleSeat.CFrame
                    end
               end
          end
wait(0.7)
for _ = 1, 10 do
for i,v in pairs(game.Workspace:GetChildren()) do
                    if v.Name:match(game.Players.LocalPlayer.Name) and v:FindFirstChild("VehicleSeat") then
                        v.VehicleSeat.CFrame = CFrame.new(245, 129, -91)
                    end
               end
task.wait()
end
wait(0.4)
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
wait(0.5)
repeat task.wait()
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("entered") then
for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
if v.ClassName == "Part" and v.Name ~= "Humanoid" then
v.CFrame = game.workspace.Arena.Plate.CFrame
end
end
end
until game.Players.LocalPlayer.Character:WaitForChild("Ragdolled").Value == false
else
Notification("You don't have equiped Cloud | Badge Fish | You are in the lobby.", 5)
end
    end
})

TabBadge:AddToggle({
    Name = "Bus Stab",
    Default = false,
    Flag = "Bus Stab",
    Callback = function(Value)
_G.BusStab = Value
while _G.BusStab do
for i,v in pairs(game.Workspace:GetChildren()) do
                    if v.Name == "BusModel" then
v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    end
                end
task.wait()
end
    end
})

TabBadge:AddToggle({
    Name = "Toolbox Farm",
    Default = false,
    Flag = "Toolbox Farm",
    Callback = function(Value)
_G.Toolboxfarm = Value
while _G.Toolboxfarm do
if game.Workspace:FindFirstChild("Toolbox") then
for i,v in pairs(game.Workspace:GetChildren()) do
                    if v.Name == "Toolbox" then
if v:FindFirstChild("Main") then
v.Main.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(-5, -1.63, 0)
end
if fireclickdetector and v:FindFirstChild("ClickDetector") then
fireclickdetector(v.ClickDetector, 0)
fireclickdetector(v.ClickDetector, 1)
                    end
                end
                end
            end
task.wait()
end
    end
})

TabBadge:AddToggle({
    Name = "Hallow - Jack Farm",
    Default = false,
    Flag = "Hallow - Jack Farm",
    Callback = function(Value)
_G.HallowJackFarm = Value
while _G.HallowJackFarm do
if workspace:FindFirstChild("Gravestone") then
for i,v in pairs(game.Workspace:GetChildren()) do
                    if v.Name == "Gravestone" and v:FindFirstChild("ClickDetector") then
if game.Players.LocalPlayer.Character:FindFirstChild("KillstreakLevel") and game.Players.LocalPlayer.Character:FindFirstChild("KillstreakLevel").Value > 9 then
fireclickdetector(v.ClickDetector, 0)
fireclickdetector(v.ClickDetector, 1)
end
                    end
                end
elseif workspace:FindFirstChild("Gravestone") == nil and game.Players.LocalPlayer.Character:FindFirstChild("KillstreakLevel") and game.Players.LocalPlayer.Character:FindFirstChild("KillstreakLevel").Value > 9 then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["Safespot"].CFrame * CFrame.new(0,10,0)
end
task.wait()
end
    end
})

TabBadge:AddToggle({
    Name = "Phase & Jet Farm",
    Default = false,
    Flag = "Phase Or Jet Farm",
    Callback = function(Value)
_G.PhaseOrJetfarm = Value
while _G.PhaseOrJetfarm do
for i,v in pairs(game.Workspace:GetChildren()) do
                    if v.Name == "JetOrb" or v.Name == "PhaseOrb" then
v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    end
                end
task.wait()
end
    end
})

TabBadge:AddToggle({
    Name = "MATERIALIZE Farm",
    Default = false,
    Flag = "MATERIALIZE Farm",
    Callback = function(Value)
_G.MATERIALIZEfarm = Value
while _G.MATERIALIZEfarm do
for i,v in pairs(game.Workspace:GetChildren()) do
                    if v.Name == "MATERIALIZEOrb" then
v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    end
                end
task.wait()
end
    end
})

TabBadge:AddToggle({
    Name = "Gift Farm",
    Default = false,
    Flag = "Gift Farm",
    Callback = function(Value)
_G.Giftfarm = Value
while _G.Giftfarm do
for i,v in pairs(game.Workspace:GetChildren()) do
                    if v.Name == "Gift" and game.Players.LocalPlayer.Character:FindFirstChild("Head") then
v.CFrame = game.Players.LocalPlayer.Character.Head.CFrame
                    end
                end
task.wait()
end
    end
})

TabBadge:AddDropdown({
    Name = "Farm Brick",
    Default = "",
    Options = {"Slow", "Fast"},
    Callback = function(Value)
_G.AutoBrick = Value
    end
})

TabBadge:AddToggle({
    Name = "AutoFarm Brick",
    Default = false, 
    Flag = "AutoFarm Brick",
    Callback = function(Value) 
_G.Brickfarm = Value
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Brick" then
while Brickfarm do
if _G.AutoBrick == "Slow" then
game:GetService("VirtualInputManager"):SendKeyEvent(true,"E",false,x)
elseif _G.AutoBrick == "Fast" then
game:GetService("ReplicatedStorage").lbrick:FireServer()
game:GetService("Players").LocalPlayer.PlayerGui.BRICKCOUNT.ImageLabel.TextLabel.Text = game:GetService("Players").LocalPlayer.PlayerGui.BRICKCOUNT.ImageLabel.TextLabel.Text + 1
end
task.wait(1.2)
end
elseif Brickfarm == true then
Notification("You don't have Brick equipped", 5)
wait(0.05)
OrionLib.Flag["AutoFarm Brick"]:Set(false)
end
    end
})

TabBadge:AddToggle({
    Name = "Get Tycoon",
    Default = false, 
    Flag = "Get Tycoon",
    Callback = function(Value) 
_G.AutoTpPlate = Value
if game.Players.LocalPlayer.Character:FindFirstChild("entered") and #game.Players:GetPlayers() >= 7 then
while _G.AutoTpPlate do
if game.Players.LocalPlayer.Character:FindFirstChild("entered") and #game.Players:GetPlayers() >= 7 then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Arena.Plate.CFrame
end
task.wait()
end
elseif _G.AutoTpPlate == true then
Notification("You need enter erane, or 7 people the server", 5)
wait(0.05)
OrionLib.Flag["Get Tycoon"]:Set(false)
end
    end
})

local TabLocalPlayer = Tabs.Tab4
TabLocalPlayer:AddSlider({
    Name = "Speed",
    Default = 20,
    Min = 20,
    Max = 1000,
    Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Speed",
    Callback = function(Value)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
Walkspeed = Value
    end
})

TabLocalPlayer:AddTextbox({
    Name = "Speed",
    Default = "20",
    TextDisappear = true,
    Callback = function(Value)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
Walkspeed = Value
    end
})

TabLocalPlayer:AddToggle({
    Name = "Auto Set Speed",
    Default = false, 
    Flag = "Auto Set Speed",
    Callback = function(Value) 
KeepWalkspeed = Value
            while KeepWalkspeed do
                if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") ~= nil and game.Players.LocalPlayer.Character.Humanoid.WalkSpeed ~= Walkspeed then
                    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Walkspeed
                end
task.wait()
            end
    end
})

TabLocalPlayer:AddSlider({
    Name = "Jump",
    Default = 50,
    Min = 50,
    Max = 1000,
    Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Jump",
    Callback = function(Value)
game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
Jumppower = Value
    end
})

TabLocalPlayer:AddTextbox({
    Name = "Jump",
    Default = "50",
    TextDisappear = true,
    Callback = function(Value)
game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
Jumppower = Value
    end
})

TabLocalPlayer:AddToggle({
    Name = "Auto Set Jump",
    Default = false, 
    Flag = "Auto Set Jump",
    Callback = function(Value) 
KeepJumppower = Value
            while KeepJumppower do
                if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") ~= nil and game.Players.LocalPlayer.Character.Humanoid.JumpPower ~= Jumppower then
                    game.Players.LocalPlayer.Character.Humanoid.JumpPower = Jumppower
                end
task.wait()
            end
    end
})

TabLocalPlayer:AddSlider({
    Name = "Hip Height",
    Default = 0,
    Min = 0,
    Max = 100,
    Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Height",
    Callback = function(Value)
game.Players.LocalPlayer.Character.Humanoid.HipHeight = Value
HipHeight = Value
    end
})

TabLocalPlayer:AddToggle({
    Name = "Auto Set Hip Height",
    Default = false, 
    Callback = function(Value) 
KeepHipHeight = Value
           while KeepHipHeight do
              if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") ~= nil and game.Players.LocalPlayer.Character.Humanoid.HipHeight ~= HipHeight then
                  game.Players.LocalPlayer.Character.Humanoid.HipHeight  = HipHeight
              end
task.wait()
         end
    end
})

TabLocalPlayer:AddSlider({
    Name = "Gravity",
    Default = 185,
    Min = 0,
    Max = 300,
    Rounding = 0,
    Compact = true,
    Callback = function(Value)
game.Workspace.Gravity = Value
    end
})

local TabMisc = Tabs.Tab5
TabMisc:AddDropdown({
    Name = "Godmobe",
    Options = {"Godmode", "Godmode + Invisibility"},
    Default = "",
    Callback = function(Value)
if Value == "Godmode" then
if game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil then
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1, 0)
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1, 1)
end
repeat task.wait() until game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool") or game.Players.LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool")
for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if v:IsA("Tool") and v.Name ~= "Radio" then
                        v.Parent = game.LogService
                    end
                end
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        v.Parent = game.LogService
                end
game:GetService("Players").LocalPlayer.Reset:FireServer()
wait(3.82)
for i,v in pairs(game.LogService:GetChildren()) do
                        v.Parent = game.Players.LocalPlayer.Backpack
                end
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                end 
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Origo.CFrame * CFrame.new(0,-5,0)
elseif Value == "Godmode + Invisibility" then
if game.Players.LocalPlayer.leaderstats.Slaps.Value >= 666 then
if game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil then
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1, 0)
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1, 1)
end
repeat task.wait() until game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool") or game.Players.LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool")
for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if v:IsA("Tool") and v.Name ~= "Radio" then
                        v.Parent = game.LogService
                    end
                end
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        v.Parent = game.LogService
                end
game:GetService("Players").LocalPlayer.Reset:FireServer()
wait(3.82)
OGlove = game.Players.LocalPlayer.leaderstats.Glove.Value
fireclickdetector(workspace.Lobby.Ghost.ClickDetector)
game.ReplicatedStorage.Ghostinvisibilityactivated:FireServer()
fireclickdetector(workspace.Lobby[OGlove].ClickDetector)
for i,v in pairs(game.LogService:GetChildren()) do
                        v.Parent = game.Players.LocalPlayer.Backpack
                end
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                end 
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Origo.CFrame * CFrame.new(0,-5,0)
wait(0.5)
for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
if v.Name ~= "Humanoid" then
v.Transparency = 0
end
end
else
Notification("You need 666+ slaps", 5)
end
end
    end
})

TabMisc:AddDropdown({
    Name = "Teleport",
    Options = {"Arena", "Lobby", "Hunter Room", "Tournament", "Brazil", "Island Slapple", "Plate", "Cannon Island", "Keypad", "Cube Of Death", "Moai Island", "Default Arena", "Island 1", "Island 2", "Island 3"},
    Default = "",
    Callback = function(Value)
if Value == "Arena" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Origo.CFrame * CFrame.new(0,-5,0)
elseif Value == "Lobby" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-800,328,-2.5)
elseif Value == "Hunter Room" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.BountyHunterRoom.Union.CFrame * CFrame.new(0,5,0)
elseif Value == "Brazil" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Lobby.brazil.portal.CFrame
elseif Value == "Island Slapple" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Arena.island5.Union.CFrame * CFrame.new(0,3.25,0)
elseif Value == "Plate" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Arena.Plate.CFrame
elseif Value == "Tournament" then
if workspace:FindFirstChild("TournamentIsland") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.TournamentIsland.Spawns.Part.CFrame * CFrame.new(0,2,0)
else
Notification("Tournament Island don't not spawn.", 5)
end
elseif Value == "Cannon Island" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Arena.CannonIsland.Cannon.Base.CFrame * CFrame.new(0,0,35)
elseif Value == "Keypad" then
if not workspace:FindFirstChild("Keypad") then
Notification("Server in don't have keypad.", 5)
else
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Keypad.Buttons.Enter.CFrame
end
elseif Value == "Cube Of Death" then
if game.Workspace:FindFirstChild("the cube of death(i heard it kills)", 1) then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Arena.CubeOfDeathArea["the cube of death(i heard it kills)"].Part.CFrame * CFrame.new(0,5,0)
end
elseif Value == "Moai Island" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(215, -15.5, 0.5)
elseif Value == "Default Arena" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(120,360,-3)
elseif Value == "Island 1" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-211.210846, -5.27827597, 4.13719559, -0.0225322824, 1.83683113e-08, -0.999746144, -1.83560154e-08, 1, 1.87866842e-08, 0.999746144, 1.87746618e-08, -0.0225322824)
elseif Value == "Island 2" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8.17191315, -5.14452887, -205.249741, -0.98216176, -3.48867246e-09, -0.188037917, -4.19987778e-09, 1, 3.38382322e-09, 0.188037917, 4.11319823e-09, -0.98216176)
elseif Value == "Island 3" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6.66747713, -5.06731462, 213.575378, 0.945777893, 2.52095178e-10, 0.324814111, -3.7823856e-08, 1, 1.09357536e-07, -0.324814111, -1.15713661e-07, 0.945777893)
end
    end
})

TabMisc:AddTextbox({
	Name = "Player",
    Default = "",
    Callback = function(Value)
_G.PlayerTarget = Value
for _, v in pairs(game.Players:GetPlayers()) do
if string.sub(v.Name, 1, #_G.PlayerTarget):lower() == _G.PlayerTarget:lower() then
PlayerTa = v
end
end
if PlayerTa then
_G.PlayerPut = PlayerTa.Name
Notification("Found Player [ "..PlayerTa.Name.." ]", 5)
else
Notification("Can't find player", 5)
end
    end
})

TabMisc:AddButton({
     Name = "Teleport Player", 
     Callback = function()
if game.Players[_G.PlayerPut].Character and game.Players[_G.PlayerPut].Character:FindFirstChild("HumanoidRootPart") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[_G.PlayerPut].Character.HumanoidRootPart.CFrame
end
    end
})

TabMisc:AddToggle({
    Name = "Auto Teleport Player",
    Default = false, 
    Flag = "Auto Tp Player",
    Callback = function(Value) 
_G.PlayerTele = Value
while _G.PlayerTele do
if game.Players[_G.PlayerPut].Character and game.Players[_G.PlayerPut].Character:FindFirstChild("HumanoidRootPart") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[_G.PlayerPut].Character.HumanoidRootPart.CFrame
end
task.wait()
end
    end
})

TabMisc:AddToggle({
    Name = "Auto View Player",
    Default = false,
    Flag = "Auto View Player",
    Callback = function(Value) 
_G.PlayerView = Value
if _G.PlayerView == false then
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
end
end
while _G.PlayerView do
if game.Players[_G.PlayerPut].Character:FindFirstChild("Humanoid") then
game.Workspace.CurrentCamera.CameraSubject = game.Players[_G.PlayerPut].Character:FindFirstChild("Humanoid")
end
task.wait()
end
    end
})

TabMisc:AddTextbox({
	Name = "Fly Speed",
    Default = "50",
    Callback = function(Value)
_G.SetSpeedFly = Value
    end
})

_G.SetSpeedFly = 50
TabMisc:AddToggle({
    Name = "Start Fly",
    Default = false, 
    Callback = function(Value) 
_G.StartFly = Value
if _G.StartFly == false then
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and game.Players.LocalPlayer.Character.Humanoid.RootPart and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityHandler") and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("GyroHandler") then
game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler:Destroy()
game.Players.LocalPlayer.Character.HumanoidRootPart.GyroHandler:Destroy()
game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
end
end
while _G.StartFly do
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and game.Players.LocalPlayer.Character.Humanoid.RootPart and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityHandler") and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("GyroHandler") then
game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.MaxForce = Vector3.new(9e9,9e9,9e9)
game.Players.LocalPlayer.Character.HumanoidRootPart.GyroHandler.MaxTorque = Vector3.new(9e9,9e9,9e9)
game.Players.LocalPlayer.Character.Humanoid.PlatformStand = true
game.Players.LocalPlayer.Character.HumanoidRootPart.GyroHandler.CFrame = Workspace.CurrentCamera.CoordinateFrame
game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = Vector3.new()
if require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule")):GetMoveVector().X > 0 then
game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity + game.Workspace.CurrentCamera.CFrame.RightVector * (require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule")):GetMoveVector().X * _G.SetSpeedFly)
end
if require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule")):GetMoveVector().X < 0 then
game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity + game.Workspace.CurrentCamera.CFrame.RightVector * (require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule")):GetMoveVector().X * _G.SetSpeedFly)
end
if require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule")):GetMoveVector().Z > 0 then
game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity - game.Workspace.CurrentCamera.CFrame.LookVector * (require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule")):GetMoveVector().Z * _G.SetSpeedFly)
end
if require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule")):GetMoveVector().Z < 0 then
game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity - game.Workspace.CurrentCamera.CFrame.LookVector * (require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule")):GetMoveVector().Z * _G.SetSpeedFly)
end
elseif game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and game.Players.LocalPlayer.Character.Humanoid.RootPart and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityHandler") == nil and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("GyroHandler") == nil then
local bv = Instance.new("BodyVelocity")
local bg = Instance.new("BodyGyro")

bv.Name = "VelocityHandler"
bv.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
bv.MaxForce = Vector3.new(0,0,0)
bv.Velocity = Vector3.new(0,0,0)

bg.Name = "GyroHandler"
bg.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
bg.MaxTorque = Vector3.new(0,0,0)
bg.P = 1000
bg.D = 50
end
task.wait()
end
    end
})

TabMisc:AddToggle({
    Name = "Autofarm Slapples",
    Default = false, 
    Flag = "Auto Farm Slapple",
    Callback = function(Value) 
_G.SlappleFarm = Value
while _G.SlappleFarm do
if game.Players.LocalPlayer.Character:FindFirstChild("entered") then
for i, v in pairs(workspace.Arena.island5.Slapples:GetChildren()) do
                if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("entered") and v.Name == "Slapple" or v.Name == "GoldenSlapple" and v:FindFirstChild("Glove") and v.Glove:FindFirstChildWhichIsA("TouchTransmitter") then
                    v.Glove.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                end
            end
        end
task.wait()
end
    end
})

TabMisc:AddToggle({
    Name = "Autofarm Candy",
    Default = false, 
    Flag = "Auto Farm Candy",
    Callback = function(Value) 
_G.CandyCornsFarm = Value
while _G.CandyCornsFarm do
for i, v in pairs(game.Workspace.CandyCorns:GetChildren()) do
                if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                   v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                end
            end
task.wait()
end
    end
})

TabMisc:AddButton({
    Name = "Auto Keypad",
    Callback = function()
if not workspace:FindFirstChild("Keypad") then
Notification("Server in don't have keypad, can have started serverhop", 5)
task.wait(1.5)
for _, v in ipairs(game.HttpService:JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
if v.playing < v.maxPlayers and v.JobId ~= game.JobId then
game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, v.id)
end
end
else
game.Workspace.CurrentCamera.CameraSubject = workspace.Keypad.Buttons.Enter
fireclickdetector(workspace:WaitForChild("Keypad").Buttons:FindFirstChild("Reset").ClickDetector)
local digits = tostring((#game.Players:GetPlayers()) * 25 + 1100 - 7)
for i = 1, #digits do
wait(.5)
local digit = digits:sub(i,i)
fireclickdetector(workspace:WaitForChild("Keypad").Buttons:FindFirstChild(digit).ClickDetector)
end
wait(1)
fireclickdetector(workspace:WaitForChild("Keypad").Buttons:FindFirstChild("Enter").ClickDetector)
end
    end
})

TabMisc:AddToggle({
    Name = "Auto Code Pocket Keypad",
    Default = false, 
    Callback = function(Value) 
_G.WriteCodeKeypad = Value
while _G.WriteCodeKeypad do
if game.Workspace:FindFirstChild("RoomsFolder") then
for i,v in pairs(game.Workspace.RoomsFolder:GetChildren()) do
if string.find(v.Name, "'s Room") and v:FindFirstChild("PocketKeypad") then
fireclickdetector(v.PocketKeypad.Buttons:FindFirstChild("Reset").ClickDetector)
local digits = "4553293"
for i = 1, #digits do
wait(0.26)
_G.CodeOPad = digits:sub(i,i)
fireclickdetector(v.PocketKeypad.Buttons:FindFirstChild(_G.CodeOPad).ClickDetector)
end
task.wait(0.15)
fireclickdetector(v.PocketKeypad.Buttons:FindFirstChild("Enter").ClickDetector)
end
end
end
task.wait(3.23)
end
    end
})

TabMisc:AddTextbox({
	Name = "Write Code Keypad",
    Default = "",
    Callback = function(Value)
_G.writeCode = Value
    end
})

TabMisc:AddDropdown({
    Name = "Enter Keypad",
    Options = {"Not Enter","Enter"},
    Default = "Enter",
    Callback = function(Value)
_G.EnterKeypad = Value
    end
})

TabMisc:AddButton({
     Name = "Write Keypad",
     Callback = function()
if not workspace:FindFirstChild("Keypad") then
Notification("Server in don't have keypad.", 5)
else
game.Workspace.CurrentCamera.CameraSubject = workspace.Keypad.Buttons.Enter
fireclickdetector(workspace:WaitForChild("Keypad").Buttons:FindFirstChild("Reset").ClickDetector)
for i = 1,#_G.writeCode do
wait(.35)
local digit = _G.writeCode:sub(i,i)
fireclickdetector(workspace:WaitForChild("Keypad").Buttons:FindFirstChild(digit).ClickDetector)
end
if _G.EnterKeypad == "Enter" then
fireclickdetector(workspace:WaitForChild("Keypad").Buttons:FindFirstChild("Enter").ClickDetector)
end
end
    end
})

TabMisc:AddDropdown({
    Name = "Easter Egg Code",
    Options = {"911","8008","666","6969","1987"},
    Default = "",
    Callback = function(Value)
_G.EggCodes = Value
    end
})

TabMisc:AddButton({
    Name = "Write Keypad",
    Callback = function()
if not workspace:FindFirstChild("Keypad") then
Notification("Server in don't have keypad.", 5)
else
game.Workspace.CurrentCamera.CameraSubject = workspace.Keypad.Buttons.Enter
fireclickdetector(workspace:WaitForChild("Keypad").Buttons:FindFirstChild("Reset").ClickDetector)
for i = 1,#_G.EggCodes do
wait(.35)
local digit = _G.EggCodes:sub(i,i)
fireclickdetector(workspace:WaitForChild("Keypad").Buttons:FindFirstChild(digit).ClickDetector)
end
wait(1)
fireclickdetector(workspace:WaitForChild("Keypad").Buttons:FindFirstChild("Enter").ClickDetector)
end
    end
})

TabMisc:AddToggle({
    Name = "Auto Farm Slap",
    Default = false,
    Flag = "Autio Farm Slap",
    Callback = function(Value) 
_G.AutoFarmSlap = Value
while _G.AutoFarmSlap do
for i,v in pairs(game.Players:GetChildren()) do
if v ~= game.Players.LocalPlayer and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and v.Character then
if v.Character:FindFirstChild("entered") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("stevebody") == nil and v.Character:FindFirstChild("rock") == nil and v.Character.HumanoidRootPart.BrickColor ~= BrickColor.new("New Yeller") and v.Character.Ragdolled.Value == false and v.Character:FindFirstChild("Mirage") == nil then
if v.Character.Head:FindFirstChild("UnoReverseCard") == nil then
if _G.AutoFarmSlap == true then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0,5,0)
task.wait(0.5)
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Boxer" then
gloveHits["Boxer"]:FireServer(v, true)
elseif game.Players.LocalPlayer.leaderstats.Glove.Value == "Mace" then
gloveHits["Mace"]:FireServer(v.Character.HumanoidRootPart, 100)
else
gloveHits[game.Players.LocalPlayer.leaderstats.Glove.Value]:FireServer(v.Character.HumanoidRootPart)
end
end
end
end
end
end
task.wait(0.45)
end
    end
})

TabMisc:AddToggle({
    Name = "Auto Spam Ability",
    Default = false,
    Flag = "Auto Spam Ability",
    Callback = function(Value) 
_G.OnAbility = Value
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Fort" do
game:GetService("ReplicatedStorage").Fortlol:FireServer()
wait(3.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Home Run" do
game:GetService("ReplicatedStorage").HomeRun:FireServer({["start"] = true})
game:GetService("ReplicatedStorage").HomeRun:FireServer({["finished"] = true})
task.wait(4.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "🗿" do
if game.Players.LocalPlayer.Character:FindFirstChild("Head") then
game:GetService("ReplicatedStorage").GeneralAbility:FireServer(game.Players.LocalPlayer.Character.Head.CFrame * CFrame.new(0, -2, -10))
end
wait(3.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Shukuchi" do
local players = game.Players:GetChildren()
local RandomPlayer = players[math.random(1, #players)]
repeat RandomPlayer = players[math.random(1, #players)] until RandomPlayer ~= game.Players.LocalPlayer and RandomPlayer.Character:FindFirstChild("rock") == nil and RandomPlayer.Character.Head:FindFirstChild("UnoReverseCard") == nil
Target = RandomPlayer
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character.Head:FindFirstChild("RedEye") == nil then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame
end
wait(0.09)
game:GetService("ReplicatedStorage").SM:FireServer(Target)
wait(0.8)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Slicer" do
game:GetService("ReplicatedStorage").Slicer:FireServer("sword")
game:GetService("ReplicatedStorage").Slicer:FireServer("slash", game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame, Vector3.new())
wait(5.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Reverse" do
game:GetService("ReplicatedStorage"):WaitForChild("ReverseAbility"):FireServer()
task.wait(5.7)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "rob" do
game:GetService("ReplicatedStorage").rob:FireServer()
wait(3)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "bob" do
game:GetService("ReplicatedStorage").bob:FireServer()
wait(9)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Kraken" do
game:GetService("ReplicatedStorage").KrakenArm:FireServer()
wait(5)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Sbeve" do
game:GetService("ReplicatedStorage").KrakenArm:FireServer()
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Psycho" do
game:GetService("ReplicatedStorage").Psychokinesis:InvokeServer({["grabEnabled"] = true})
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Killstreak" do
game:GetService("ReplicatedStorage").KSABILI:FireServer()
wait(6.9)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "bus" do
game:GetService("ReplicatedStorage").busmoment:FireServer()
wait(5.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Mitten" do
game:GetService("ReplicatedStorage").MittenA:FireServer()
wait(5.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Defense" do
game:GetService("ReplicatedStorage").Barrier:FireServer()
wait(0.25)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Bomb" do
game:GetService("ReplicatedStorage").BombThrow:FireServer()
wait(2.5)
game:GetService("ReplicatedStorage").BombThrow:FireServer()
wait(4.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Replica" do
game:GetService("ReplicatedStorage").Duplicate:FireServer(true)
wait(6)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Pusher" do
game:GetService("ReplicatedStorage").PusherWall:FireServer()
wait(5.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Jet" do
local players = game.Players:GetChildren()
local RandomPlayer = players[math.random(1, #players)]
repeat RandomPlayer = players[math.random(1, #players)] until RandomPlayer ~= game.Players.LocalPlayer and RandomPlayer.Character:FindFirstChild("entered") and RandomPlayer.Character:FindFirstChild("rock") == nil
Target = RandomPlayer
game:GetService("ReplicatedStorage").AirStrike:FireServer(Target.Character)
wait(5.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Tableflip" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
wait(3.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Shield" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
wait(3.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Rocky" do
game:GetService("ReplicatedStorage").RockyShoot:FireServer()
task.wait(7.5)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "God's Hand" do
game:GetService("ReplicatedStorage").TimestopJump:FireServer()
game:GetService("ReplicatedStorage").Timestopchoir:FireServer()
game:GetService("ReplicatedStorage").Timestop:FireServer()
wait(50.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Za Hando" do
game:GetService("ReplicatedStorage").Erase:FireServer()
wait(5.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Baller" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
wait(4.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Glitch" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
wait(5.34)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Stun" do
game:GetService("ReplicatedStorage").StunR:FireServer(game:GetService("Players").LocalPlayer.Character.Stun)
wait(10.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "STOP" do
game:GetService("ReplicatedStorage").STOP:FireServer(true)
wait(4.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Quake" do
game:GetService("ReplicatedStorage"):WaitForChild("QuakeQuake"):FireServer({["start"] = true})
game:GetService("ReplicatedStorage"):WaitForChild("QuakeQuake"):FireServer({["finished"] = true})
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Track" do
local players = game.Players:GetChildren()
local RandomPlayer = players[math.random(1, #players)]
repeat RandomPlayer = players[math.random(1, #players)] until RandomPlayer ~= game.Players.LocalPlayer and RandomPlayer.Character:FindFirstChild("entered") and RandomPlayer.Character:FindFirstChild("rock") == nil
Target = RandomPlayer
game:GetService("ReplicatedStorage").GeneralAbility:FireServer(Target.Character)
wait(10.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Mail" do
game:GetService("ReplicatedStorage").MailSend:FireServer()
wait(3.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Shard" do
game:GetService("ReplicatedStorage").Shards:FireServer()
wait(4.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "fish" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
wait(3.05)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Null" do
game:GetService("ReplicatedStorage").NullAbility:FireServer()
wait(0.01)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Counter" do
game:GetService("ReplicatedStorage").Counter:FireServer()
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 20
task.wait(6.2)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Voodoo" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
task.wait(6.27)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Swapper" do
game:GetService("ReplicatedStorage").SLOC:FireServer()
wait(5.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Gravity" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Bubble" do
game:GetService("ReplicatedStorage").BubbleThrow:FireServer()
wait(3.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Slapple" do
game:GetService("ReplicatedStorage").funnyTree:FireServer(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
wait(3.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Detonator" do
game:GetService("ReplicatedStorage").Fart:FireServer()
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Berserk" do
game:GetService("ReplicatedStorage").BerserkCharge:FireServer(game:GetService("Players").LocalPlayer.Character.Berserk)
wait(2.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Rojo" do
game:GetService("ReplicatedStorage"):WaitForChild("RojoAbility"):FireServer("Release", {game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame})
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Kinetic" do
OGL = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
for i = 1,100 do
game.ReplicatedStorage.SelfKnockback:FireServer({["Force"] = 0,["Direction"] = Vector3.new(0,0.01,0)})
task.wait(0.05)
end
wait(2)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OGL
if game.Players.LocalPlayer.Backpack:FindFirstChild("Kinetic") then
game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack.Kinetic)
end
game:GetService("ReplicatedStorage").KineticExpl:FireServer(game.Players.LocalPlayer.Character.Kinetic, game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
wait(2.2)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Dominance" do
game:GetService("ReplicatedStorage").DominanceAc:FireServer(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
wait(3.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "[REDACTED]" do
game:GetService("ReplicatedStorage").Well:FireServer()
wait(5.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Duelist" do
game:GetService("ReplicatedStorage").DuelistAbility:FireServer()
wait(5.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Engineer" do
game:GetService("ReplicatedStorage").Sentry:FireServer()
wait(5.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Brick" do
game:GetService("ReplicatedStorage").lbrick:FireServer()
game:GetService("Players").LocalPlayer.PlayerGui.BRICKCOUNT.ImageLabel.TextLabel.Text = game:GetService("Players").LocalPlayer.PlayerGui.BRICKCOUNT.ImageLabel.TextLabel.Text + 1
wait(1.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Trap" do
game:GetService("ReplicatedStorage").funnyhilariousbeartrap:FireServer()
wait(3.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "woah" do
game:GetService("ReplicatedStorage").VineThud:FireServer()
wait(5.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Ping Pong" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Recall" do
game:GetService("ReplicatedStorage").Recall:InvokeServer(game:GetService("Players").LocalPlayer.Character.Recall)
wait(3.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "ZZZZZZZ" do
game:GetService("ReplicatedStorage").ZZZZZZZSleep:FireServer()
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Adios" do
game:GetService("ReplicatedStorage").AdiosActivated:FireServer()
wait(8.3)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Boogie" do
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Backpack:FindFirstChild("Boogie") then
game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack.Boogie)
elseif game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("Boogie") then
game:GetService("ReplicatedStorage").BoogieBall:FireServer(game.Players.LocalPlayer.Character.Boogie, game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
end
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Balloony" do
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Backpack:FindFirstChild("Balloony") then
game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack.Balloony)
elseif game.Players.LocalPlayer.Character:FindFirstChild("Balloony") then
game:GetService("ReplicatedStorage").GeneralAbility:FireServer(game:GetService("Players").LocalPlayer.Character.Balloony)
end
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Phase" do
game:GetService("ReplicatedStorage").PhaseA:FireServer()
wait(5.475)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Hallow Jack" do
game:GetService("ReplicatedStorage"):WaitForChild("Hallow"):FireServer()
wait(3.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Phantom" do
game:GetService("ReplicatedStorage").PhantomDash:InvokeServer(workspace[game.Players.LocalPlayer.Name].Phantom) 
wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Sparky" do
if game.Players.LocalPlayer.Character:FindFirstChild("Sparky") then
game:GetService("ReplicatedStorage").Sparky:FireServer(game:GetService("Players").LocalPlayer.Character.Sparky)
end
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Charge" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer(game:GetService("Players").LocalPlayer.Character.Charge)
wait(3.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Coil" do
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character:FindFirstChild("Coil") then
local SpeedOld = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed
game:GetService("ReplicatedStorage"):WaitForChild("GeneralAbility"):FireServer(game:GetService("Players").LocalPlayer.Character.Coil)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
task.wait(2.4)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = SpeedOld
end
wait(3.1)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Diamond" do
game:GetService("ReplicatedStorage"):WaitForChild("Rockmode"):FireServer()
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "MEGAROCK" do
game:GetService("ReplicatedStorage"):WaitForChild("Rockmode"):FireServer()
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Excavator" do
game:GetService("ReplicatedStorage"):WaitForChild("Excavator"):InvokeServer()
game:GetService("ReplicatedStorage"):WaitForChild("ExcavatorCancel"):FireServer()
wait(7.3)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Thor" do
if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
game:GetService("ReplicatedStorage").ThorAbility:FireServer(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
end
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Meteor" do
game:GetService("ReplicatedStorage"):WaitForChild("GeneralAbility"):FireServer()
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Sun" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer("Cast")
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Whirlwind" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Guardian Angel" do
game.ReplicatedStorage.GeneralAbility:FireServer(game.Players.LocalPlayer)
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Parry" do
game.ReplicatedStorage.GeneralAbility:FireServer()
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "MR" do
game:GetService("ReplicatedStorage").Spherify:FireServer()
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Druid" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
task.wait(3.21)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Oven" do
if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
game:GetService("ReplicatedStorage").GeneralAbility:FireServer(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
end
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Jester" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer("Ability1")
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Ferryman" do
local players = game.Players:GetChildren()
local randomPlayer = players[math.random(1, #players)]
repeat randomPlayer = players[math.random(1, #players)] until randomPlayer ~= game.Players.LocalPlayer and randomPlayer.Character:FindFirstChild("entered") and randomPlayer.Character:FindFirstChild("ded") == nil and randomPlayer.Character:FindFirstChild("InLabyrinth") == nil and randomPlayer.Character:FindFirstChild("rock") == nil
Target = randomPlayer
game.Players.LocalPlayer.Character.FerrymanStaff.StaffConfig.AbilityEvent:FireServer("Leap")
wait(1.85)
game.Players.LocalPlayer.Character.FerrymanStaff.StaffConfig.AbilityEvent:FireServer("FinishLeap",Target.Character.HumanoidRootPart.Position)
task.wait(5.7)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Scythe" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Blackhole" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Jebaited" do
if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
game:GetService("ReplicatedStorage").GeneralAbility:FireServer(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
end
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Blink" do
game:GetService("ReplicatedStorage").Blink:FireServer("OutOfBody", {["dir"] = Vector3.new(0, 0, 0),["ismoving"] = false,["mousebehavior"] = Enum.MouseBehavior.Default})
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Joust" do
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game:GetService("ReplicatedStorage").GeneralAbility:FireServer("Start")
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 40
end
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Slapstick" do
game:GetService("ReplicatedStorage").slapstick:FireServer("charge")
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Firework" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Chicken" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Lamp" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "BONK" do
game:GetService("ReplicatedStorage").BONK:FireServer()
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Frostbite" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer(2)
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Golem" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer("recall")
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Grab" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Spoonful" do
if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
game:GetService("ReplicatedStorage").GeneralAbility:FireServer({["state"] = "vfx",["origin"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(-3.141592502593994, 1.0475832223892212, 3.141592502593994),["vfx"] = "jumptween",["sendplr"] = game:GetService("Players").LocalPlayer})
game:GetService("ReplicatedStorage").GeneralAbility:FireServer({["state"] = "vfx",["cf"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(-2.1319260597229004, 0.651054859161377, 2.3744168281555176),["vfx"] = "crash"})
end
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "el gato" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "UFO" do
if game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'s UFO VFX") == nil and game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'s UFO") == nil then
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
end
task.wait(0.3)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Hive" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Siphon" do
if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
game:GetService("ReplicatedStorage").Events.Siphon:FireServer({["cf"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame})
end
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Demolition" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer("c4")
game:GetService("ReplicatedStorage").Events.c4:FireServer()
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Shotgun" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer("buckshot")
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Beachball" do
if workspace.Balls:FindFirstChild(game.Players.LocalPlayer.Name.."'s Ball") == nil then
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
end
wait(0.2)
if workspace.Balls:FindFirstChild(game.Players.LocalPlayer.Name.."'s Ball") then
game:GetService("ReplicatedStorage").Events.BeachBall:FireServer(workspace.Balls:FindFirstChild(game.Players.LocalPlayer.Name.."'s Ball"), Vector3.new(game:GetService("Workspace").CurrentCamera.CFrame.LookVector.X, 0, game:GetService("Workspace").CurrentCamera.CFrame.LookVector.Z).Unit * 0.2)
end
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Water" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer("default")
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "64" do
if game.Players.LocalPlayer.Character:FindFirstChild("Head") then
game:GetService("ReplicatedStorage").GeneralAbility:FireServer(game.Players.LocalPlayer.Character.Head.CFrame * CFrame.new(0, -2, 0) * CFrame.Angles(3, -1, 3))
end
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Fan" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Shackle" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Bind" do
local players = game.Players:GetChildren()
local randomPlayer = players[math.random(1, #players)]
repeat randomPlayer = players[math.random(1, #players)] until randomPlayer ~= game.Players.LocalPlayer and randomPlayer.Character:FindFirstChild("entered") and randomPlayer.Character:FindFirstChild("ded") == nil and randomPlayer.Character:FindFirstChild("InLabyrinth") == nil and randomPlayer.Character:FindFirstChild("rock") == nil
Target = randomPlayer
game:GetService("ReplicatedStorage").GeneralAbility:FireServer("default", {["goal"] = Target.Character.HumanoidRootPart.CFrame, ["origin"] = Target.Character.Head.CFrame})
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Poltergeist" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer("ability2")
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Lawnmower" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer("lawnmower")
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Untitled Tag Glove" do
game:GetService("ReplicatedStorage").UTGGeneric:FireServer("enableRunMode")
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Virus" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Baby" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
task.wait(8)
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Angler" do
if game.Players.LocalPlayer.Character:FindFirstChild("fishing_rod") then
game:GetService("ReplicatedStorage").Events.Fisherman:FireServer("cast")
end
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Jerry" do
if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
game:GetService("ReplicatedStorage").GeneralAbility:FireServer(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(-3, 0, -3))
end
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Snowroller" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
wait(0.3)
game:GetService("ReplicatedStorage").GeneralAbility:FireServer("release")
task.wait()
end
while _G.OnAbility and game.Players.LocalPlayer.leaderstats.Glove.Value == "Cherry" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
task.wait()
end
    end
})

TabMisc:AddToggle({
    Name = "Spam Stun Untitled Tag",
    Default = false, 
    Flag = "Spam Stun",
    Callback = function(Value) 
_G.SpamStunUntitledTag = Value
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Untitled Tag Glove" then
while _G.SpamStunUntitledTag do
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Untitled Tag Glove" then
game:GetService("ReplicatedStorage").UTGGeneric:FireServer("enableRunMode")
for i,v in pairs(game.Players:GetChildren()) do
if v ~= game.Players.LocalPlayer and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and v.Character then
if v.Character:FindFirstChild("entered") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("stevebody") == nil and v.Character:FindFirstChild("rock") == nil and v.Character.HumanoidRootPart.BrickColor ~= BrickColor.new("New Yeller") and v.Character.Ragdolled.Value == false and v.Character:FindFirstChild("Mirage") == nil then
if 30 >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude then
game:GetService("ReplicatedStorage").UTGGeneric:FireServer("slideStun", v.Character)
end
end
end
end
end
task.wait()
end
elseif _G.SpamStunUntitledTag == true then
Notification("You don't have Untitled Tag Glove equipped", 5)
wait(0.05)
Toggles["Spam Stun Untitled Tag"]:SetValue(false)
end
    end
})

TabMisc:AddToggle({
    Name = "Brick Player",
    Default = false, 
    Flag = "Brick Player",
    Callback = function(Value) 
_G.BrickTeleport = Value
while _G.BrickTeleport do
for i,v in pairs(game.Players:GetChildren()) do
if v ~= game.Players.LocalPlayer and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and v.Character then
if game.Players.LocalPlayer.Character:FindFirstChild("entered") and v.Character:FindFirstChild("entered") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("stevebody") == nil and v.Character:FindFirstChild("rock") == nil and v.Character.HumanoidRootPart.BrickColor ~= BrickColor.new("New Yeller") and v.Character.Ragdolled.Value == false and v.Character:FindFirstChild("Mirage") == nil then
if game.Workspace:FindFirstChild("Union") then
v.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(-10, 0, 0)
for i, a in pairs(game.Workspace:GetChildren()) do
        if a.Name == "Union" then
           a.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(-10, 0, 0)
        end
    end
end
end
end
end
task.wait(0.1)
end
    end
})

TabMisc:AddToggle({
    Name = "Brick Orbit",
    Default = false, 
    Flag = "Brick Orbit",
    Callback = function(Value) 
_G.BrickOrbit = Value
while _G.BrickOrbit do
for i, a in pairs(game.Workspace:GetChildren()) do
        if a.Name == "Union" then
           a.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(math.cos(tick() * 5 + (i - 1) * math.pi / 5) * 8, 0, math.sin(tick() * 5 + (i - 1) * math.pi / 5) * 8)
        end
    end
task.wait()
end
    end
})

TabMisc:AddToggle({
    Name = "Spam Ability 250 Kill",
    Default = false,
    Flag = "Spam Ability 250 kill",
    Callback = function(Value) 
_G.SpamAbliKilll = Value
while _G.SpamAbliKilll do
if game.Players.LocalPlayer.Character:FindFirstChild("KS250Complete") then
game:GetService("ReplicatedStorage").TheForce:FireServer()
for i,v in pairs(game.Workspace:GetChildren()) do
                    if v.Name == "Part" then
                        v:Destroy()
                    end
                end
end
task.wait()
end
    end
})

TabMisc:AddToggle({
    Name = "Infinite Rhythm",
    Default = false,
    Flag = "Inf Rhythm",
    Callback = function(Value) 
_G.RhythmNoteSpam = Value
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Rhythm" then
while _G.RhythmNoteSpam do
game.Players.LocalPlayer.PlayerGui.Rhythm.LocalScript.Disabled = false
game.Players.LocalPlayer.PlayerGui.Rhythm.LocalScript.Disabled = true
game.Players.LocalPlayer.Character.Rhythm:Activate()
task.wait()
end
elseif _G.RhythmNoteSpam == true then
Notification("You don't have Rhythm equipped", 5)
wait(0.05)
OrionLib.Flag["Infinite Rhythm"]:Set(false)
end
    end
})

TabMisc:AddToggle({
    Name = "Slap Cherry Fast",
    Default = false, 
    Flag = "Auto Slap Fast",
    Callback = function(Value) 
_G.AutoSlapCherry = Value
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Cherry" then
while _G.AutoSlapCherry do
if workspace:FindFirstChild("cherry_storage") then
for i, v in pairs(workspace.cherry_storage:GetChildren()) do
if v.Name == ("Cherry "..game.Players.LocalPlayer.Name) and v:FindFirstChild("clone_remote") then
v.clone_remote:FireServer()
end
end
end
task.wait()
end
elseif _G.AutoSlapCherry == true then
Notification("You don't have Cherry equipped", 5)
wait(0.05)
Toggles["Auto Slap Cherry"]:SetValue(false)
end
    end
})

TabMisc:AddButton({
     Name = "Auto Play Rhythm",
     Callback = function()
game.Players.LocalPlayer.PlayerGui.Rhythm.MainFrame.Bars.ChildAdded:Connect(function()
task.delay(1.65, function()
game.Players.LocalPlayer.Character:FindFirstChild("Rhythm"):Activate()
end)
end)
    end
})

TabMisc:AddButton({
     Name = "Free Emotes",
     Callback = function()
if LoadingScr then return end
LoadingScr = true
game.Players.LocalPlayer.Chatted:Connect(function(msg)
Anims = {
    ["L"] = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game:GetService("ReplicatedStorage").AnimationPack["L"]),
    ["Groove"] = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game:GetService("ReplicatedStorage").AnimationPack["Groove"]),
    ["Helicopter"] = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game:GetService("ReplicatedStorage").AnimationPack["Helicopter"]),
    ["Floss"] = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game:GetService("ReplicatedStorage").AnimationPack["Floss"]),
    ["Kick"] = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game:GetService("ReplicatedStorage").AnimationPack["Kick"]),
    ["Headless"] = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game:GetService("ReplicatedStorage").AnimationPack["Headless"]),
    ["Laugh"] = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game:GetService("ReplicatedStorage").AnimationPack["Laugh"]),
    ["Parker"] = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game:GetService("ReplicatedStorage").AnimationPack["Parker"]),
    ["Thriller"] = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game:GetService("ReplicatedStorage").AnimationPack["Thriller"]),
    ["Spasm"] = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game:GetService("ReplicatedStorage").AnimationPack["Spasm"])
}
for i, v in pairs(Anims) do
        if v.IsPlaying then
            v:Stop()
        end
    end
task.wait()
if string.lower(msg) == "/e l" then
   Anims["L"]:Play()
elseif string.lower(msg) == "/e groove" then
   Anims["Groove"]:Play()
elseif string.lower(msg) == "/e helicopter" then
   Anims["Helicopter"]:Play()
elseif string.lower(msg) == "/e floss" then
   Anims["Floss"]:Play()
elseif string.lower(msg) == "/e kick" then
   Anims["Kick"]:Play()
elseif string.lower(msg) == "/e headless" then
   Anims["Headless"]:Play()
elseif string.lower(msg) == "/e laugh" then
   Anims["Laugh"]:Play()
   game:GetService("ReplicatedStorage").AnimationSound:FireServer("LAUGH")
elseif string.lower(msg) == "/e parker" then
   Anims["Parker"]:Play()
elseif string.lower(msg) == "/e thriller" then
   Anims["Thriller"]:Play()
elseif string.lower(msg) == "/e spasm" then
   Anims["Spasm"]:Play()
end
game.Players.LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(function()
    if game.Players.LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 then
        for i, v in pairs(Anims) do
            if v.IsPlaying then
                v:Stop()
            end
        end
    end
end)
end)
    end
})

TabMisc:AddButton({
     Name = "Destroy All Tycoon",
     Callback = function()
for i, v in pairs(game.Workspace:GetChildren()) do
if string.find(v.Name, "ÅTycoon") and v:FindFirstChild("Destruct") then
for a = 1, 200 do
if v:FindFirstChild("Destruct") then
fireclickdetector(v.Destruct.ClickDetector, 0)
fireclickdetector(v.Destruct.ClickDetector, 1)
end
end
end
end
    end
})

TabMisc:AddTextbox({
	Name = "Equip Glove",
    Default = "",
    Callback = function(Value)
_G.EquipGlove = Value
    end
})

TabMisc:AddDropdown({
    Name = "Equip Glove",
    Options = {"Normal","Tournament", "Old Glove + Tournament"},
    Default = "Normal",
    Callback = function(Value)
_G.GloveEquipHehe = Value
    end
})

TabMisc:AddButton({
     Name = "Equip Glove",
     Callback = function()
if _G.GloveEquipHehe == "Normal" then
if game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil then
fireclickdetector(workspace.Lobby[_G.EquipGlove].ClickDetector)
else
Notification("You aren't in the lobby.", 5)
end
elseif _G.GloveEquipHehe == "Tournament" or _G.GloveEquipHehe == "Old Glove + Tournament" then
if game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil then
if _G.GloveEquipHehe == "Tournament" then
fireclickdetector(workspace.Lobby[_G.EquipGlove].ClickDetector)
end
wait(0.5)
repeat task.wait() until game.Players.LocalPlayer.Character
if not game.Players.LocalPlayer.Character:FindFirstChild("entered") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
repeat task.wait()
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1.TouchInterest.Parent, 0)
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1.TouchInterest.Parent, 1)
until game.Players.LocalPlayer.Character:FindFirstChild("entered")
end
wait(0.3)
if workspace:FindFirstChild("TournamentIsland") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.TournamentIsland.Spawns.Part.CFrame * CFrame.new(0,2,0)
else
Notification("Tournament Island don't not spawn.", 5)
end
else
Notification("you are in Tournament not equip, 1 you use it.", 5)
end
end
    end
})

TabMisc:AddDropdown({
    Name = "Enter",
    Options = {"Arena", "Arena Default"},
    Default = "",
    Callback = function(Value)
_G.AutoEnter = Value
    end
})

TabMisc:AddToggle({
    Name = "Auto Enter",
    Default = false,
    Flag = "Auto Enter",
    Callback = function(Value) 
_G.AutoEnterJoin = Value
while _G.AutoEnterJoin do
if _G.AutoEnter == "Arena" then
if game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
repeat task.wait()
if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Lobby.Teleport1, 0)
firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Lobby.Teleport1, 1)
end
until game.Players.LocalPlayer.Character:FindFirstChild("entered")
end
elseif _G.AutoEnter == "Arena Default" then
if game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
repeat task.wait()
if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Lobby.Teleport2, 0)
firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Lobby.Teleport2, 1)
end
until game.Players.LocalPlayer.Character:FindFirstChild("entered")
end
end
task.wait()
end
    end
})

TabMisc:AddSlider({
    Name = "Reach Slap Aura",
    Default = 25,
    Min = 10,
    Max = 50,
    Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Reach",
    Callback = function(Value)
_G.ReachSlapArua = Value
    end
})

TabMisc:AddDropdown({
    Name = "Slap Aura Friend",
    Options = {"Fight", "Not Fight"},
    Default = "Fight",
    Callback = function(Value)
_G.SlapAuraFriend = Value
    end
})

 TabMisc:AddDropdown({
    Name = "Slap Aura Character",
    Options = {"HumanoidRootPart", "Head", "Left Arm", "Left Leg", "Right Arm", "Right Leg"},
    Default = "HumanoidRootPart",
    Callback = function(Value)
_G.SlapAuraCharacter = Value
    end
})

TabMisc:AddDropdown({
    Name = "Slap Aura Choose",
    Options = {"Normal", "Reverse"},
    Default = "Normal",
    Callback = function(Value)
_G.SlapAuraChoose = Value
    end
})

TabMisc:AddToggle({
    Name = "Slap Aura",
    Default = false, 
    Flag = "Slap Aura",
    Callback = function(Value) 
_G.SlapAura = Value
while _G.SlapAura do
if _G.SlapAuraChoose == "Normal" then
for i,v in pairs(game.Players:GetChildren()) do
if v ~= game.Players.LocalPlayer and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and v.Character then
if v.Character:FindFirstChild("entered") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("stevebody") == nil and v.Character:FindFirstChild("rock") == nil and v.Character.HumanoidRootPart.BrickColor ~= BrickColor.new("New Yeller") and v.Character.Ragdolled.Value == false and v.Character:FindFirstChild("Mirage") == nil then
if v.Character.Head:FindFirstChild("UnoReverseCard") == nil or game.Players.LocalPlayer.leaderstats.Glove.Value == "Error" then
if _G.ReachSlapArua >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude then
if _G.SlapAuraFriend == "Fight" then
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Boxer" then
gloveHits["Boxer"]:FireServer(v, true)
elseif game.Players.LocalPlayer.leaderstats.Glove.Value == "Mace" then
gloveHits["Mace"]:FireServer(v.Character:WaitForChild(_G.SlapAuraCharacter), 100)
else
gloveHits[game.Players.LocalPlayer.leaderstats.Glove.Value]:FireServer(v.Character:WaitForChild(_G.SlapAuraCharacter))
end
elseif _G.SlapAuraFriend == "Not Fight" then
if not game.Players.LocalPlayer:IsFriendsWith(v.UserId) then
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Boxer" then
gloveHits["Boxer"]:FireServer(v, true)
elseif game.Players.LocalPlayer.leaderstats.Glove.Value == "Mace" then
gloveHits["Mace"]:FireServer(v.Character:WaitForChild(_G.SlapAuraCharacter), 200)
else
gloveHits[game.Players.LocalPlayer.leaderstats.Glove.Value]:FireServer(v.Character:WaitForChild(_G.SlapAuraCharacter))
end
end
end
end
end
end
end
end
for i, c in pairs(workspace:GetChildren()) do
if string.find(c.Name, "Å") and c:FindFirstChild("HumanoidRootPart") then
if _G.ReachSlapArua >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - c.HumanoidRootPart.Position).Magnitude then
gloveHits[game.Players.LocalPlayer.leaderstats.Glove.Value]:FireServer(c:WaitForChild(_G.SlapAuraCharacter))
end
end
end
if workspace:FindFirstChild("cherry_storage") then
for i, v in pairs(workspace.cherry_storage:GetChildren()) do
if string.find(v.Name, "Cherry") and v:FindFirstChild("HumanoidRootPart") then
if _G.ReachSlapArua >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude then
gloveHits[game.Players.LocalPlayer.leaderstats.Glove.Value]:FireServer(c:WaitForChild(_G.SlapAuraCharacter))
end
end
end
end
if game.Workspace:FindFirstChild("Balls") then
for i, g in pairs(workspace:GetChildren()) do
if g.Name == "Balls" then
for i, z in pairs(g:GetChildren()) do
if string.find(z.Name, "'s Ball") then
if _G.ReachSlapArua >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - z.Position).Magnitude then
game:GetService("ReplicatedStorage").Events.BeachBall:FireServer(z, Vector3.new(game:GetService("Workspace").CurrentCamera.CFrame.LookVector.X, 0, game:GetService("Workspace").CurrentCamera.CFrame.LookVector.Z).Unit * 0.2)
end
end
end
end
end
end
elseif _G.SlapAuraChoose == "Reverse" then
for i,v in pairs(game.Players:GetChildren()) do
if v ~= game.Players.LocalPlayer and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and v.Character then
if v.Character:FindFirstChild("entered") and game.Players.LocalPlayer.Character:FindFirstChild("entered") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("stevebody") == nil and v.Character:FindFirstChild("rock") == nil and v.Character.HumanoidRootPart.BrickColor ~= BrickColor.new("New Yeller") then
if v.Character.Head:FindFirstChild("UnoReverseCard") and game.Players.LocalPlayer.Character.Head:FindFirstChild("UnoReverseCard") then
if _G.ReachSlapArua >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude then
game.ReplicatedStorage.ReverseHit:FireServer(v.Character:WaitForChild(_G.SlapAuraCharacter))
end
end
end
end
end
end
task.wait(.08)
end
    end
})

TabMisc:AddSlider({
    Name = "Reach Shukuchi",
    Default = 50,
    Min = 1,
    Max = 130,
    Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Reach",
    Callback = function(Value)
_G.ReachShukuchi = Value
    end
})

 TabMisc:AddDropdown({
    Name = "Shukuchi Friend",
    Options = {"Fight", "Not Fight"},
    Default = "Fight",
    Callback = function(Value)
_G.ShukuchiFriend = Value
    end
})

TabMisc:AddToggle({
    Name = "Auto Shukuchi Player",
    Default = false,
    Flag = "Auto Shukuchi",
    Callback = function(Value) 
_G.AutoShukuchi = Value
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Shukuchi" then
                while _G.AutoShukuchi do
for i,v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and v.Character then
if v.Character:FindFirstChild("entered") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("stevebody") == nil and v.Character:FindFirstChild("rock") == nil and v.Character.HumanoidRootPart.BrickColor ~= BrickColor.new("New Yeller") and v.Character.Head:FindFirstChild("RedEye") == nil and v.Character:FindFirstChild("Mirage") == nil then
if v.Character.Head:FindFirstChild("UnoReverseCard") == nil then
                        if _G.ReachShukuchi >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude then
if _G.ShukuchiFriend == "Fight" then
game:GetService("ReplicatedStorage").SM:FireServer(v)
elseif _G.ShukuchiFriend == "Not Fight" then
if not game.Players.LocalPlayer:IsFriendsWith(v.UserId) then
game:GetService("ReplicatedStorage").SM:FireServer(v)
end
end
                     end
end
end
end
                 end
task.wait()
end
elseif _G.AutoShukuchi == true then
Notification("You don't have Shukuchi equipped.", 5)
wait(0.05)
OrionLib.Flag["Auto Shukuchi"]:Set(false)
end
    end
})

TabMisc:AddSlider({
    Name = "Reach Hitbox",
    Default = 10,
    Min = 10,
    Max = 30,
    Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Hitbox",
    Callback = function(Value)
_G.ReachHitbox = Value
    end
})

TabMisc:AddToggle({
    Name = "Hitbox Player & Mod",
    Default = false,
    Flag = "Hitbox Player Mob",
    Callback = function(Value) 
_G.HitboxPlayer = Value
while _G.HitboxPlayer do
for i,v in pairs(game.Players:GetChildren()) do
                    if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        v.Character.HumanoidRootPart.Size = Vector3.new(_G.ReachHitbox,_G.ReachHitbox,_G.ReachHitbox)
                        v.Character.HumanoidRootPart.Transparency = 0.75
                    end
                end
for i, c in pairs(workspace:GetChildren()) do
if string.find(c.Name, "Å") and c:FindFirstChild("HumanoidRootPart") then
c.HumanoidRootPart.Size = Vector3.new(_G.ReachHitbox,_G.ReachHitbox,_G.ReachHitbox)
c.HumanoidRootPart.Transparency = 0.75
end
end
if workspace:FindFirstChild("cherry_storage") then
for i, v in pairs(workspace.cherry_storage:GetChildren()) do
if string.find(v.Name, "Cherry") and v:FindFirstChild("HumanoidRootPart") then
v.HumanoidRootPart.Size = Vector3.new(_G.ReachHitbox,_G.ReachHitbox,_G.ReachHitbox)
v.HumanoidRootPart.Transparency = 0.75
end
end
end
task.wait()
end
if _G.HitboxPlayer == false then
for i,v in pairs(game.Players:GetChildren()) do
                    if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        v.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
                        v.Character.HumanoidRootPart.Transparency = 1
                    end
                end
for i, c in pairs(workspace:GetChildren()) do
if string.find(c.Name, "Å") and c:FindFirstChild("HumanoidRootPart") then
c.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
c.HumanoidRootPart.Transparency = 1
end
end
if workspace:FindFirstChild("cherry_storage") then
for i, v in pairs(workspace.cherry_storage:GetChildren()) do
if string.find(v.Name, "Cherry") and v:FindFirstChild("HumanoidRootPart") then
v.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
v.HumanoidRootPart.Transparency = 1
end
end
end
end
    end
})

TabMisc:AddSlider({
    Name = "Extend Glove",
    Default = 5,
    Min = 2,
    Max = 20,
    Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Extend",
    Callback = function(Value)
_G.GloveExtendReach = Value
    end
})

TabMisc:AddDropdown({
    Name = "Extend Option",
    Options = {"Meat Stick","Pancake","Growth","North Korea Wall","Slight Extend"},
    Default = "",
    Callback = function(Value)
GloveExtendOption = Value
    end
})

TabMisc:AddToggle({
    Name = "Extend Glove",
    Default = false, 
    Flag = "Extend Glove",
    Callback = function(Value) 
_G.GloveExtendGet = Value
while _G.GloveExtendGet do
if game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool") ~= nil then
for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v:IsA("Tool") and v.Name ~= "Radio" then
                        if v:FindFirstChild("Glove") ~= nil then
                          if GloveExtendOption == "Meat Stick" then
                            v:FindFirstChild("Glove").Size = Vector3.new(0, _G.GloveExtendReach, 2)
                            elseif GloveExtendOption == "Pancake" then
                            v:FindFirstChild("Glove").Size = Vector3.new(0, _G.GloveExtendReach, _G.GloveExtendReach)
                            elseif GloveExtendOption == "Growth" then
                            v:FindFirstChild("Glove").Size = Vector3.new(_G.GloveExtendReach,_G.GloveExtendReach,_G.GloveExtendReach)
                            elseif GloveExtendOption == "North Korea Wall" then
                            v:FindFirstChild("Glove").Size = Vector3.new(_G.GloveExtendReach,0,_G.GloveExtendReach)
                            elseif GloveExtendOption == "Slight Extend" then
                            v:FindFirstChild("Glove").Size = Vector3.new(3, 3, 3.7)
                            end
                            v:FindFirstChild("Glove").Transparency = 0.5
                        end
                    end
                end
else
for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if v:IsA("Tool") and v.Name ~= "Radio" then
                        if v:FindFirstChild("Glove") ~= nil then
                            if GloveExtendOption == "Meat Stick" then
                            v:FindFirstChild("Glove").Size = Vector3.new(0, _G.GloveExtendReach, 2)
                            elseif GloveExtendOption == "Pancake" then
                            v:FindFirstChild("Glove").Size = Vector3.new(0, _G.GloveExtendReach, _G.GloveExtendReach)
                            elseif GloveExtendOption == "Growth" then
                            v:FindFirstChild("Glove").Size = Vector3.new(_G.GloveExtendReach,_G.GloveExtendReach,_G.GloveExtendReach)
                            elseif GloveExtendOption == "North Korea Wall" then
                            v:FindFirstChild("Glove").Size = Vector3.new(_G.GloveExtendReach,0,_G.GloveExtendReach)
                            elseif GloveExtendOption == "Slight Extend" then
                            v:FindFirstChild("Glove").Size = Vector3.new(3, 3, 3.7)
                            end
                            v:FindFirstChild("Glove").Transparency = 0.5
                        end
                    end
                end
end
task.wait()
end
if _G.GloveExtendGet == false then
if game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool") ~= nil then
for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v:IsA("Tool") and v.Name ~= "Radio" then
                        if v:FindFirstChild("Glove") ~= nil then
                            v:FindFirstChild("Glove").Size = Vector3.new(2.5, 2.5, 1.7)
                            v:FindFirstChild("Glove").Transparency = 0
                        end
                    end
                end
else
for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if v:IsA("Tool") and v.Name ~= "Radio" then
                        if v:FindFirstChild("Glove") ~= nil then
                            v:FindFirstChild("Glove").Size = Vector3.new(2.5, 2.5, 1.7)
                            v:FindFirstChild("Glove").Transparency = 0
                        end
                    end
                end
end
end
    end
})

TabMisc:AddTextbox({
	Name = "Auto Change Nametag",
    Default = "",
    Callback = function(Value)
game.Workspace.NametagChanged.Value = Value
    end
})

TabMisc:AddToggle({
    Name = "Auto Set NameTag",
    Default = false, 
    Flag = "Auto Set Nametag",
    Callback = function(Value) 
_G.AutoSetNameTag = Value
while _G.AutoSetNameTag do
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Head") and game.Players.LocalPlayer.Character.Head:FindFirstChild("Nametag") then
if game.Players.LocalPlayer.Character.Head.Nametag:FindFirstChild("TextLabel") and game.Players.LocalPlayer.Character.Head.Nametag.TextLabel.Text ~= game.Workspace.NametagChanged.Value then
game.Players.LocalPlayer.Character.Head.Nametag.TextLabel.Text = game.Workspace.NametagChanged.Value
end
end
task.wait()
end
    end
})

TabMisc:AddTextbox({
	Name = "Auto Change Slap",
    Default = "",
    Callback = function(Value)
game.Workspace.NametagChanged.SlapChanged.Value = Value
    end
})

TabMisc:AddToggle({
    Name = "Auto Set Slap",
    Default = false, 
    Flag = "Auto Set Slap",
    Callback = function(Value) 
_G.AutoChangeSlapFake = Value
while _G.AutoChangeSlapFake do
if game.Players.LocalPlayer.leaderstats.Slaps.Value ~= game.Workspace.NametagChanged.SlapChanged.Value then
game.Players.LocalPlayer.leaderstats.Slaps.Value = game.Workspace.NametagChanged.SlapChanged.Value
end
task.wait()
end
    end
})

TabMisc:AddDropdown({
    Name = "Tycoon",
    Options = {"All","Your"},
    Default = "All",
    Callback = function(Value)
_G.TycoonAuto = Value
    end
})

TabMisc:AddToggle({
    Name = "Auto Click Tycoon",
    Default = false,
    Flag = "Auto Click",
    Callback = function(Value) 
_G.AutoClickTycoon = Value
if _G.TycoonAuto == "All" then
while _G.AutoClickTycoon and _G.TycoonAuto == "All" do
for _,v in pairs(game.Workspace:GetChildren()) do
if string.find(v.Name, "ÅTycoon") and v:FindFirstChild("Click") then
fireclickdetector(v.Click.ClickDetector, 0)
fireclickdetector(v.Click.ClickDetector, 1)
end
end
task.wait()
end
elseif _G.TycoonAuto == "Your" then
while _G.AutoClickTycoon and _G.TycoonAuto == "Your" do
for _,v in pairs(game.Workspace:GetChildren()) do
if v.Name:match(game.Players.LocalPlayer.Name) then
for i,x in pairs(v:GetChildren()) do
if x.Name == "TycoonDrop" then
x.CFrame = v.End.CFrame
end
end
if v:FindFirstChild("Click") then
fireclickdetector(v.Click.ClickDetector, 0)
fireclickdetector(v.Click.ClickDetector, 1)
end
end
end
task.wait()
end
end
    end
})

TabMisc:AddToggle({
    Name = "Auto Destroy Tycoon",
    Default = false, 
    Flag = "Auto Destroy",
    Callback = function(Value) 
_G.AutoDestroyTycoon = Value
if _G.TycoonAuto == "All" then
while _G.AutoDestroyTycoon do
for _,v in pairs(game.Workspace:GetChildren()) do
if string.find(v.Name, "ÅTycoon") and v:FindFirstChild("Destruct") then
fireclickdetector(v.Destruct.ClickDetector, 0)
fireclickdetector(v.Destruct.ClickDetector, 1)
end
end
task.wait()
end
elseif _G.TycoonAuto == "Your" then
while _G.AutoDestroyTycoon do
for _,v in pairs(game.Workspace:GetChildren()) do
if v.Name:match(game.Players.LocalPlayer.Name) and v:FindFirstChild("Destruct") then
fireclickdetector(v.Destruct.ClickDetector, 0)
fireclickdetector(v.Destruct.ClickDetector, 1)
end
end
task.wait()
end
end
    end
})

TabMisc:AddSection({Name = "Esp"})

TabMisc:AddToggle({
    Name = "Esp Glove",
    Default = false, 
    Callback = function(Value) 
_G.GloveESP = Value
if _G.GloveESP == false then
for i, v in ipairs(game.Players:GetChildren()) do
if v.Character:FindFirstChild("Head") and v.Character.Head:FindFirstChild("GloveEsp") then
v.Character.Head.GloveEsp:Destroy()
end
if v.Character:FindFirstChild("HumanoidRootPart") and v.Character.HumanoidRootPart:FindFirstChild(v.Name) then
v.Character.HumanoidRootPart[v.Name]:Destroy()
end
for i,f in pairs(game.Workspace:GetChildren()) do
if f.Name == (v.Name.."_Body") then
if f:FindFirstChild("HumanoidRootPart") and f.HumanoidRootPart:FindFirstChild("BodyGloveEsp") then
f.HumanoidRootPart.BodyGloveEsp:Destroy()
if f:FindFirstChild("HumanoidRootPart") and f.HumanoidRootPart:FindFirstChild("EspBoxBody") then
f.HumanoidRootPart.EspBoxBody:Destroy()
end
end
end
end
for i,t in pairs(game.Workspace:GetChildren()) do
if t.Name == (v.Name.."_Ghost") then
if t:FindFirstChild("RootPart") and t.RootPart:FindFirstChild("GhostGloveEsp") then
t.RootPart.GhostGloveEsp:Destroy()
if t:FindFirstChild("RootPart") and t.RootPart:FindFirstChild("EspBoxGhost") then
t.RootPart.EspBoxGhost:Destroy()
end
end
end
end
end
end
while _G.GloveESP do
for i,v in ipairs(game.Players:GetChildren()) do
if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
if v.Character.Head:FindFirstChild("GloveEsp") and v.Character.Head.GloveEsp:FindFirstChild("TextLabel") and v.Character.Head.GloveEsp.TextLabel.TextColor3 ~= _G.ColorESP then
v.Character.Head.GloveEsp.TextLabel.TextColor3 = _G.ColorESP
end
if v.Character.Head:FindFirstChild("GloveEsp") and v.Character.Head.GloveEsp:FindFirstChild("TextLabel") then
if _G.DistanceEsp == false and _G.SlapEsp == false then
if v.Character.Head.GloveEsp.TextLabel.Text ~= "Glove [ "..v.leaderstats.Glove.Value.." ]" then
v.Character.Head.GloveEsp.TextLabel.Text = "Glove [ "..v.leaderstats.Glove.Value.." ]"
end
elseif _G.DistanceEsp == true and _G.SlapEsp == true then
if v.Character.Head.GloveEsp.TextLabel.Text ~= "Glove [ "..v.leaderstats.Glove.Value.." ]\nDistance [ "..string.format("%.1f", (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude).." ]\nSlap [ "..v.leaderstats.Slaps.Value.." ]" then
v.Character.Head.GloveEsp.TextLabel.Text = "Glove [ "..v.leaderstats.Glove.Value.." ]\nDistance [ "..string.format("%.1f", (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude).." ]\nSlap [ "..v.leaderstats.Slaps.Value.." ]"
end
elseif _G.DistanceEsp == true and _G.SlapEsp == false then
if v.Character.Head.GloveEsp.TextLabel.Text ~= "Glove [ "..v.leaderstats.Glove.Value.." ]\nDistance [ "..string.format("%.1f", (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude).." ]" then
v.Character.Head.GloveEsp.TextLabel.Text = "Glove [ "..v.leaderstats.Glove.Value.." ]\nDistance [ "..string.format("%.1f", (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude).." ]"
end
elseif _G.DistanceEsp == false and _G.SlapEsp == true then
if v.Character.Head.GloveEsp.TextLabel.Text ~= "Glove [ "..v.leaderstats.Glove.Value.." ]\nSlap [ "..v.leaderstats.Slaps.Value.." ]" then
v.Character.Head.GloveEsp.TextLabel.Text = "Glove [ "..v.leaderstats.Glove.Value.." ]\nSlap [ "..v.leaderstats.Slaps.Value.." ]"
end
end
end
if game.Workspace:FindFirstChild(v.Name.."_Body") and v.Character.Head:FindFirstChild("GloveEsp") then
v.Character.Head.GloveEsp:Destroy()
end
if game.Workspace:FindFirstChild(v.Name.."_Body") == nil and v.Character.Head:FindFirstChild("GloveEsp") == nil then
GloveEsp = Instance.new("BillboardGui", v.Character.Head)
GloveEsp.Adornee = v.Character.Head
GloveEsp.Name = "GloveEsp"
GloveEsp.Size = UDim2.new(0, 100, 0, 150)
GloveEsp.AlwaysOnTop = true
GloveEsp.StudsOffset = Vector3.new(0, 3, 0)
GloveEspText = Instance.new("TextLabel", GloveEsp)
GloveEspText.BackgroundTransparency = 1
GloveEspText.Font = Enum.Font.SourceSansBold
GloveEspText.Size = UDim2.new(0, 100, 0, 100)
GloveEspText.TextSize = _G.TextSize
GloveEspText.TextColor3 = _G.ColorESP
GloveEspText.TextStrokeTransparency = 0.5
GloveEspText.Text = "Glove [ "..v.leaderstats.Glove.Value.." ]"
end
if _G.HighlightEsp == true then
if v.Character:FindFirstChild("HumanoidRootPart") and v.Character.HumanoidRootPart:FindFirstChild(v.Name) == nil then
local HighlightEsp = Instance.new("Highlight", v.Character.HumanoidRootPart)
HighlightEsp.Adornee = v.Character
HighlightEsp.Name = v.Name
HighlightEsp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
end
elseif _G.HighlightEsp == false then
if v.Character:FindFirstChild("HumanoidRootPart") and v.Character.HumanoidRootPart:FindFirstChild(v.Name) then
v.Character.HumanoidRootPart[v.Name]:Destroy()
end
end
if _G.GhostEsp == true then
for i,f in pairs(game.Workspace:GetChildren()) do
if f.Name == (v.Name.."_Body") then
if f:FindFirstChild("HumanoidRootPart") and f.HumanoidRootPart:FindFirstChild("BodyGloveEsp") and f.HumanoidRootPart.BodyGloveEsp:FindFirstChild("TextLabel") and f.HumanoidRootPart.BodyGloveEsp.TextLabel.TextColor3 ~= _G.ColorESP then
f.HumanoidRootPart.BodyGloveEsp.TextLabel.TextColor3 = _G.ColorESP
if f:FindFirstChild("HumanoidRootPart") and f.HumanoidRootPart:FindFirstChild("EspBoxBody") and f.HumanoidRootPart.EspBoxBody.Color3 ~= _G.ColorESP then
f.HumanoidRootPart.EspBoxBody.Color3 = _G.ColorESP
if _G.DistanceEsp == true and f:FindFirstChild("HumanoidRootPart") and f.HumanoidRootPart:FindFirstChild("BodyGloveEsp") and f.HumanoidRootPart.BodyGloveEsp:FindFirstChild("TextLabel") then
f.HumanoidRootPart.BodyGloveEsp.TextLabel.Text = "Body [ "..v.Name.." ]\nDistance [ "..string.format("%.1f", (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - f.HumanoidRootPart.Position).Magnitude).." ]"
elseif _G.DistanceEsp == false and f:FindFirstChild("HumanoidRootPart") and f.HumanoidRootPart:FindFirstChild("BodyGloveEsp") and f.HumanoidRootPart.BodyGloveEsp:FindFirstChild("TextLabel") and f.HumanoidRootPart.BodyGloveEsp.TextLabel.Text ~= "Body [ "..v.Name.." ]" then
f.HumanoidRootPart.BodyGloveEsp.TextLabel.Text = "Body [ "..v.Name.." ]"
end
end
end
end
end
for i,t in pairs(game.Workspace:GetChildren()) do
if t.Name == (v.Name.."_Ghost") then
if t:FindFirstChild("RootPart") and t.RootPart:FindFirstChild("GhostGloveEsp") and t.RootPart.GhostGloveEsp:FindFirstChild("TextLabel") and t.RootPart.GhostGloveEsp.TextLabel.TextColor3 ~= _G.ColorESP then
t.RootPart.GhostGloveEsp.TextLabel.TextColor3 = _G.ColorESP
if t:FindFirstChild("RootPart") and t.RootPart:FindFirstChild("EspBoxGhost") and t.RootPart.EspBoxGhost.Color3 ~= _G.ColorESP then
t.RootPart.EspBoxGhost.Color3 = _G.ColorESP
if _G.DistanceEsp == true and t:FindFirstChild("RootPart") and t.RootPart:FindFirstChild("GhostGloveEsp") and t.RootPart.GhostGloveEsp:FindFirstChild("TextLabel") then
t.RootPart.GhostGloveEsp.TextLabel = "Ghost [ "..v.Name.." ]\nDistance [ "..string.format("%.1f", (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - t.RootPart.Position).Magnitude).." ]"
elseif _G.DistanceEsp == false and t:FindFirstChild("RootPart") and t.RootPart:FindFirstChild("GhostGloveEsp") and t.RootPart.GhostGloveEsp:FindFirstChild("TextLabel") and t.RootPart.GhostGloveEsp.TextLabel.Text ~= "Ghost [ "..v.Name.." ]" then
t.RootPart.GhostGloveEsp.TextLabel.Text = "Ghost [ "..v.Name.." ]"
end
end
end
end
end
if game.Workspace:FindFirstChild(v.Name.."_Body") and game.Workspace[v.Name.."_Body"]:FindFirstChild("HumanoidRootPart") and game.Workspace[v.Name.."_Body"].HumanoidRootPart:FindFirstChild("BodyGloveEsp") == nil then
BodyGloveEsp = Instance.new("BillboardGui", game.Workspace[v.Name.."_Body"].HumanoidRootPart)
BodyGloveEsp.Adornee = game.Workspace[v.Name.."_Body"].HumanoidRootPart
BodyGloveEsp.Name = "BodyGloveEsp"
BodyGloveEsp.Size = UDim2.new(0, 100, 0, 150)
BodyGloveEsp.AlwaysOnTop = true
BodyGloveEsp.StudsOffset = Vector3.new(0, 3, 0)
BodyGloveEspText = Instance.new("TextLabel", BodyGloveEsp)
BodyGloveEspText.BackgroundTransparency = 1
BodyGloveEspText.Size = UDim2.new(0, 100, 0, 100)
BodyGloveEspText.TextSize = _G.TextSize
BodyGloveEspText.Font = Enum.Font.SourceSansBold
BodyGloveEspText.TextColor3 = _G.ColorESP
BodyGloveEspText.TextStrokeTransparency = 0.5
BodyGloveEspText.Text = "Body [ "..v.Name.." ]"
if game.Workspace:FindFirstChild(v.Name.."_Body") and game.Workspace[v.Name.."_Body"]:FindFirstChild("HumanoidRootPart") and game.Workspace[v.Name.."_Body"].HumanoidRootPart:FindFirstChild("EspBoxBody") == nil then
local EspBoxBody = Instance.new("BoxHandleAdornment", game.Workspace[v.Name.."_Body"].HumanoidRootPart)
EspBoxBody.Name = "EspBoxBody"
EspBoxBody.Size = game.Workspace[v.Name.."_Body"].HumanoidRootPart.Size
EspBoxBody.Adornee = game.Workspace[v.Name.."_Body"].HumanoidRootPart
EspBoxBody.Color3 = _G.ColorESP
EspBoxBody.AlwaysOnTop = true
EspBoxBody.ZIndex = 5
EspBoxBody.Transparency = 0.5
            end
         end
if game.Workspace:FindFirstChild(v.Name.."_Ghost") and game.Workspace[v.Name.."_Ghost"]:FindFirstChild("RootPart") and game.Workspace[v.Name.."_Ghost"].RootPart:FindFirstChild("GhostGloveEsp") == nil then
GhostGloveEsp = Instance.new("BillboardGui", game.Workspace[v.Name.."_Ghost"].RootPart)
GhostGloveEsp.Adornee = game.Workspace[v.Name.."_Ghost"].RootPart
GhostGloveEsp.Name = "GhostGloveEsp"
GhostGloveEsp.Size = UDim2.new(0, 100, 0, 150)
GhostGloveEsp.AlwaysOnTop = true
GhostGloveEsp.StudsOffset = Vector3.new(0, 3, 0)
GhostGloveEspText = Instance.new("TextLabel", GhostGloveEsp)
GhostGloveEspText.BackgroundTransparency = 1
GhostGloveEspText.Size = UDim2.new(0, 100, 0, 100)
GhostGloveEspText.TextSize = _G.TextSize
GhostGloveEspText.Font = Enum.Font.SourceSansBold
GhostGloveEspText.TextColor3 = _G.ColorESP
GhostGloveEspText.TextStrokeTransparency = 0.5
GhostGloveEspText.Text = "Ghost [ "..v.Name.." ]"
if game.Workspace:FindFirstChild(v.Name.."_Ghost") and game.Workspace[v.Name.."_Ghost"]:FindFirstChild("RootPart") and game.Workspace[v.Name.."_Ghost"].RootPart:FindFirstChild("EspBoxGhost") == nil then
local EspBoxGhost = Instance.new("BoxHandleAdornment", game.Workspace[v.Name.."_Ghost"].RootPart)
EspBoxGhost.Name = "EspBoxGhost"
EspBoxGhost.Size = game.Workspace[v.Name.."_Ghost"].RootPart.Size
EspBoxGhost.Adornee = game.Workspace[v.Name.."_Ghost"].RootPart
EspBoxGhost.Color3 = _G.ColorESP
EspBoxGhost.AlwaysOnTop = true
EspBoxGhost.ZIndex = 5
EspBoxGhost.Transparency = 0.5
                   end
                end
elseif _G.GhostEsp == false then
for i,f in pairs(game.Workspace:GetChildren()) do
if f.Name == (v.Name.."_Body") then
if f:FindFirstChild("HumanoidRootPart") and f.HumanoidRootPart:FindFirstChild("BodyGloveEsp") then
f.HumanoidRootPart.BodyGloveEsp:Destroy()
if f:FindFirstChild("HumanoidRootPart") and f.HumanoidRootPart:FindFirstChild("EspBoxBody") then
f.HumanoidRootPart.EspBoxBody:Destroy()
end
end
end
end
for i,t in pairs(game.Workspace:GetChildren()) do
if t.Name == (v.Name.."_Ghost") then
if t:FindFirstChild("RootPart") and t.RootPart:FindFirstChild("GhostGloveEsp") then
t.RootPart.GhostGloveEsp:Destroy()
if t:FindFirstChild("RootPart") and t.RootPart:FindFirstChild("EspBoxGhost") then
t.RootPart.EspBoxGhost:Destroy()
end
end
end
end
end
end
end
task.wait()
end
    end
})

TabMisc:AddToggle({
    Name = "Distance Esp",
    Default = false,
    Flag = "Distance",
    Callback = function(Value) 
_G.DistanceEsp = Value
    end
})

TabMisc:AddToggle({
    Name = "Slap Esp",
    Default = false, 
    Flag = "Slap",
    Callback = function(Value) 
_G.SlapEsp = Value
    end
})

TabMisc:AddToggle({
    Name = "Ghost Esp",
    Default = false, 
    Flag = "Ghost",
    Callback = function(Value) 
_G.GhostEsp = Value
    end
})

TabMisc:AddToggle({
    Name = "Highlight Esp",
    Default = false, 
    Flag = "Highlight",
    Callback = function(Value) 
_G.HighlightEsp = Value
    end
})

TabMisc:AddSlider({
    Name = "Size Text Esp",
    Default = 10,
    Min = 10,
    Max = 40,
    Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Size",
    Callback = function(Value)
_G.TextSize = Value
for i, v in ipairs(game.Players:GetChildren()) do
if v.Character:FindFirstChild("Head") and v.Character.Head:FindFirstChild("GloveEsp") and v.Character.Head.GloveEsp:FindFirstChild("TextLabel") and v.Character.Head.GloveEsp.TextLabel.TextSize ~= Value then
v.Character.Head.GloveEsp.TextLabel.TextSize = Value
end
for i,f in pairs(game.Workspace:GetChildren()) do
if f.Name == (v.Name.."_Body") then
if f:FindFirstChild("HumanoidRootPart") and f.HumanoidRootPart:FindFirstChild("BodyGloveEsp") and f.HumanoidRootPart.BodyGloveEsp:FindFirstChild("TextLabel") and f.HumanoidRootPart.BodyGloveEsp.TextLabel.TextSize ~= Value then
f.HumanoidRootPart.BodyGloveEsp.TextLabel.TextSize = Value
end
end
end
for i,t in pairs(game.Workspace:GetChildren()) do
if t.Name == (v.Name.."_Ghost") then
if t:FindFirstChild("RootPart") and t.RootPart:FindFirstChild("GhostGloveEsp") and t.RootPart.GhostGloveEsp:FindFirstChild("TextLabel") and t.RootPart.GhostGloveEsp.TextLabel.TextSize ~= Value then
t.RootPart.GhostGloveEsp.TextLabel.TextSize = Value
end
end
end
end
    end
})

TabMisc:AddSection({Name = "Help Player"})

TabMisc:AddTextbox({
	Name = "Player",
    Default = "",
    Callback = function(Value)
_G.PlayerTarget = Value
for _, v in pairs(game.Players:GetPlayers()) do
if string.sub(v.Name, 1, #_G.PlayerTarget):lower() == _G.PlayerTarget:lower() then
PlayerTa = v
end
end
if PlayerTa then
_G.PlayerPut1 = PlayerTa.Name
Notification("Found Player [ "..PlayerTa.Name.." ]", 5)
else
Notification("Can't find player", 5)
end
    end
})

TabMisc:AddDropdown({
    Name = "Retro",
    Options = {"Get Retro","Teleport Button","Enter Retro"},
    Default = "",
    Callback = function(Value)
_G.HelpPlayerGetHehe = Value
    end
})

TabMisc:AddButton({
     Name = "Help Player Retro",
     Callback = function()
if _G.HelpPlayerGetHehe == "Get Retro" then
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Recall" then
if game.Workspace:FindFirstChild("Retro") == nil then
game.ReplicatedStorage.Assets.Retro.Parent = game.Workspace
end
wait(0.5)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.FinishDoor_Retro.Part.CFrame
wait(1)
game:GetService("ReplicatedStorage").Recall:InvokeServer(game:GetService("Players").LocalPlayer.Character.Recall)
task.wait(2.4)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[_G.PlayerPut1].Character.HumanoidRootPart.CFrame
wait(1)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.FinishDoor_Retro.Part.CFrame
else
Notification("You don't have Recall equipped", 5)
end
elseif _G.HelpPlayerGetHehe == "Teleport Button" then
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Recall" then
if game.Workspace:FindFirstChild("Retro") == nil then
game.ReplicatedStorage.Assets.Retro.Parent = game.Workspace
end
wait(0.5)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-16976, 801, 4907)
wait(1)
game:GetService("ReplicatedStorage").Recall:InvokeServer(game:GetService("Players").LocalPlayer.Character.Recall)
task.wait(2.4)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[_G.PlayerPut1].Character.HumanoidRootPart.CFrame
wait(1)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-16976, 801, 4907)
else
Notification("You don't have Recall equipped", 5)
end
elseif _G.HelpPlayerGetHehe == "Enter Retro" then
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Glitch" and game.Players.LocalPlayer.leaderstats.Slaps.Value >= 50000 and game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil and game.Players[_G.PlayerPut1].Character:FindFirstChild("entered") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[_G.PlayerPut1].Character.HumanoidRootPart.CFrame
wait(0.35)
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
fireclickdetector(workspace.Lobby["Error"].ClickDetector)
task.wait(8.5)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[_G.PlayerPut1].Character.HumanoidRootPart.CFrame
wait(0.07)
game.ReplicatedStorage.Errorhit:FireServer(game.Players[_G.PlayerPut1].Character:WaitForChild("Head"))
else
Notification("You have in Lobby | Player [ ".._G.PlayerPut1.." ] in arena, or You don't have Glitch equipped, or you have don't have 50K Slap", 5)
end
end
    end
})

TabMisc:AddButton({
     Name = "Help Player Quake",
     Callback = function()
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Home Run" and game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil and game.Players[_G.PlayerPut1].leaderstats.Glove.Value == "Berserk" then
game:GetService("ReplicatedStorage").HomeRun:FireServer({["start"] = true})
fireclickdetector(workspace.Lobby.woah.ClickDetector)
wait(4.2)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[_G.PlayerPut1].Character.HumanoidRootPart.CFrame
task.wait(.2)
game:GetService("ReplicatedStorage").VineThud:FireServer()
task.wait(1)
fireclickdetector(workspace.Lobby["Home Run"].ClickDetector)
wait(0.4)
game:GetService("ReplicatedStorage").HomeRun:FireServer({["finished"] = true})
task.wait(0.12)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[_G.PlayerPut1].Character.HumanoidRootPart.CFrame
else
Notification("You don't have Home Run equipped, or you have to go lobby, or player don't have Berserk equipped.", 5)
end
    end
})

TabMisc:AddButton({
     Name = "Help Player Goofy",
    Callback = function()
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Confusion" and game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil and game:GetService("BadgeService"):UserHasBadgeAsync(game.Players.LocalPlayer.UserId, 2133016756) then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[_G.PlayerPut1].Character.HumanoidRootPart.CFrame
wait(0.2)
game:GetService("ReplicatedStorage"):WaitForChild("GeneralHit"):FireServer(game.Players[_G.PlayerPut1].Character:WaitForChild("HumanoidRootPart"))
fireclickdetector(workspace.Lobby.Goofy.ClickDetector)
wait(2)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[_G.PlayerPut1].Character.HumanoidRootPart.CFrame
wait(0.2)
game:GetService("ReplicatedStorage").GeneralHit:FireServer(game.Players[_G.PlayerPut1].Character:WaitForChild("HumanoidRootPart"))
else
Notification("You don't have Confusion equipped, or you have to go lobby.", 5)
end
    end
})

TabMisc:AddSlider({
    Name = "Time Help Berserk",
    Default = 3,
    Min = 1,
    Max = 3,
    Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Time",
    Callback = function(Value)
_G.TimeHelpGotIm = Value
    end
})

TabMisc:AddDropdown({
    Name = "Will Teleport Help",
    Options = {"Up To You","SafeSpotBox 1.0","SafeSpotBox 2.0"},
    Default = "",
    Callback = function(Value)
_G.GetTeleportHelp = Value
    end
})

TabMisc:AddButton({
     Name = "Help Player Berserk",
     Callback = function()
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Kinetic" and game.Players.LocalPlayer.Character:FindFirstChild("entered") and game.Players[_G.PlayerPut1].Character:FindFirstChild("entered") then
for o = 1,_G.TimeHelpGotIm do
if _G.GetTeleportHelp == "Up To You" then
OGL = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
elseif _G.GetTeleportHelp == "SafeSpotBox 1.0" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["SafeBox"].CFrame * CFrame.new(0,5,0)
elseif _G.GetTeleportHelp == "SafeSpotBox 2.0" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["Safespot"].CFrame * CFrame.new(0,10,0)
end
game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
for i = 1,200 do
game.ReplicatedStorage.SelfKnockback:FireServer({["Force"] = 0,["Direction"] = Vector3.new(0,0.01,0)})
task.wait()
end
wait(2.8)
if _G.GetTeleportHelp == "Up To You" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OGL
elseif _G.GetTeleportHelp == "SafeSpotBox 1.0" or _G.GetTeleportHelp == "SafeSpotBox 2.0" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[_G.PlayerPut1].Character.Head.CFrame * CFrame.new(0,5.80,0)
end
wait(0.28)
if game.Players.LocalPlayer.Backpack:FindFirstChild("Kinetic") then
game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack.Kinetic)
end
wait(0.19)
game:GetService("ReplicatedStorage").KineticExpl:FireServer(game.Players.LocalPlayer.Character.Kinetic, game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
wait(0.7)
if _G.GetTeleportHelp == "Up To You" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OGL
elseif _G.GetTeleportHelp == "SafeSpotBox 1.0" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["SafeBox"].CFrame * CFrame.new(0,5,0)
elseif _G.GetTeleportHelp == "SafeSpotBox 2.0" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["Safespot"].CFrame * CFrame.new(0,10,0)
end
wait(3.8)
end
else
Notification("You don't have Kinetic equipped, or you have to go Arena, or player have go to arena.", 5)
end
    end
})

local TabGlove = Tabs.Tab6
TabGlove:AddDropdown({
    Name = "Prop Ability",
    Options = {"Barrel", "Bench", "Brick", "Bush 1", "Bush 2", "Cauldron", "Diamond", "Frenzy Bot", "Gift", "GoldenSlapple", "Imp", "Jet Orb", "Larry", "MEGAROCK", "Moai Head", "Obby 1", "Obby 2", "Obby 3", "Obby 4", "Obby 5", "Orange", "Oven", "Phase Heart", "Phase Orb", "Rock 1", "Rock 2", "Rock 3", "Sentry", "Slapple", "Snow Peep", "Snow Turret", "bob", "rob","Sbeve"},
    Default = "",
    Callback = function(Value)
PropAbility = Value
    end
})

TabGlove:AddToggle({
    Name = "Auto Ability Prop",
    Default = false, 
    Flag = "Auto Ability Prop",
    Callback = function(Value) 
_G.PropSpam = Value
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Prop" then
while _G.PropSpam do
if game.Workspace:FindFirstChild("PropModel_"..game.Players.LocalPlayer.Name) == nil then
game:GetService("ReplicatedStorage").GeneralAbility:FireServer(PropAbility)
end
task.wait()
end
elseif _G.PropSpam == true then
Notification("You don't have Prop equipped", 5)
wait(0.05)
OrionLib.Flag["Auto Ability Prop"]:Set(false)
end
    end
})

TabGlove:AddDropdown({
    Name = "Santa Ability",
    Options = {"Bob Plush", "Snow Peep", "Milk"},
    Default = "",
    Callback = function(Value)
SantaAbility = Value
    end
})

TabGlove:AddToggle({
    Name = "Auto Ability Santa",
    Default = false, 
    Flag = "Auto Ability Santa",
    Callback = function(Value) 
SantaSpam = Value
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Santa" then
while SantaSpam do
if SantaAbility == "Bob Plush" then
game:GetService("ReplicatedStorage").GeneralAbility:FireServer("bobplush")
elseif SantaAbility == "Snow Peep" then
game:GetService("ReplicatedStorage").GeneralAbility:FireServer("snowpeep")
elseif SantaAbility == "Milk" then
game:GetService("ReplicatedStorage").GeneralAbility:FireServer("milk")
end
task.wait()
end
elseif SantaSpam == true then
Notification("You don't have Santa equipped", 5)
wait(0.05)
OrionLib.Flag["Auto Ability Santa"]:Set(false)
end
    end
})

TabGlove:AddDropdown({
    Name = "Admin Ability",
    Options = {"Fling", "Anvil", "Invisibility"},
    Default = "",
    Callback = function(Value)
AbilityAdmin = Value
    end
})

TabGlove:AddToggle({
    Name = "Auto Ability Admin",
    Default = false, 
    Flag = "Auto Ability Admin",
    Callback = function(Value) 
AdminSpam = Value
while AdminSpam do
game:GetService("ReplicatedStorage").AdminAbility:FireServer(AbilityAdmin)
task.wait()
end
    end
})

TabGlove:AddDropdown({
    Name = "Retro Ability",
    Options = {"Rocket Launcher", "Ban Hammer", "Bomb"},
    Default = "",
    Callback = function(Value)
RetroAbility = Value
    end
})

TabGlove:AddToggle({
    Name = "Auto Ability Retro",
    Default = false, 
    Flag = "Auto Ability Retro",
    Callback = function(Value) 
RetroSpam = Value
while RetroSpam do
game:GetService("ReplicatedStorage").RetroAbility:FireServer(RetroAbility)
task.wait()
end
    end
})

TabGlove:AddDropdown({
    Name = "SlapStick Ability",
    Options = {"runeffect", "fullcharged", "dash", "addarm","charge","cancelrun","discharge"},
    Default = "",
    Callback = function(Value)
SlapstickAbility = Value
    end
})

TabGlove:AddButton({
    Name = "Spam Ability Slapstick",
    Callback = function()
if SlapstickAbility == "runeffect" then
OldSpeed = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
game:GetService("ReplicatedStorage").slapstick:FireServer("runeffect")
wait(5)
game:GetService("ReplicatedStorage").slapstick:FireServer("fullcharged")
wait(1)
Notification("Started RUN Now.", 5)
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 70
wait(25)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = OldSpeed
game:GetService("ReplicatedStorage").slapstick:FireServer("cancelrun")
elseif SlapstickAbility == "dash" then
game:GetService("ReplicatedStorage").slapstick:FireServer("addarm")
game:GetService("ReplicatedStorage").slapstick:FireServer("dash")
end
    end
})

TabGlove:AddToggle({
    Name = "Auto Ability Slapstick",
    Default = false, 
    Flag = "Auto Ability SlapStick",
    Callback = function(Value) 
SlapstickSpam = Value
if SlapstickSpam == true then
game:GetService("ReplicatedStorage").slapstick:FireServer("addarm")
end
while SlapstickSpam do
game:GetService("ReplicatedStorage").slapstick:FireServer(SlapstickAbility)
task.wait()
end
    end
})

TabGlove:AddTextbox({
	Name = "Player",
    Default = "",
    Callback = function(Value)
if Value == "Me" or Value == "me" or Value == "Username" or Value == "" then
SaveThePlayer = game.Players.LocalPlayer.Name
else
_G.PlayerTarget = Value
for _, v in pairs(game.Players:GetPlayers()) do
if string.sub(v.Name, 1, #_G.PlayerTarget):lower() == _G.PlayerTarget:lower() then
PlayerTa = v
end
end
if PlayerTa then
SaveThePlayer = PlayerTa.Name
Notification("Found Player [ "..PlayerTa.Name.." ]", 5)
else
Notification("Can't find player", 5)
end
end
    end
})

TabGlove:AddToggle({
    Name = "Auto Godmobe Player",
    Default = false, 
    Flag = "Auto Godmobe Player",
    Callback = function(Value) 
if SaveThePlayer == nil then
SaveThePlayer = game.Players.LocalPlayer.Name
end
GuardianAngelSpam = Value
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Guardian Angel" then
while GuardianAngelSpam and game.Players.LocalPlayer.leaderstats.Glove.Value == "Guardian Angel" do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer(game.Players[SaveThePlayer])
task.wait()
end
elseif GuardianAngelSpam == true then
Notification("You don't have Guardian Angel equipped.", 5)
wait(0.05)
OrionLib.Flag["Auto Godmobe Player"]:Set(false)
end
    end
})

TabGlove:AddTextbox({
	Name = "Player",
    Default = "",
    Callback = function(Value)
if Value == "Me" or Value == "me" or Value == "Username" or Value == "" then
Person = game.Players.LocalPlayer.Name
else
_G.PlayerTarget = Value
for _, v in pairs(game.Players:GetPlayers()) do
if string.sub(v.Name, 1, #_G.PlayerTarget):lower() == _G.PlayerTarget:lower() then
PlayerTa = v
end
end
if PlayerTa then
Person = PlayerTa.Name
Notification("Found Player [ "..PlayerTa.Name.." ]", 5)
else
Notification("Can't find player", 5)
end
end
    end
})

TabGlove:AddDropdown({
    Name = "Rojo Ability",
    Options = {"Normal", "Down"},
    Default = "",
    Callback = function(Value)
RojoAbility = Value
    end
})

TabGlove:AddToggle({
    Name = "Auto Ability Rojo",
    Default = false, 
    Flag = "Auto Ability Rojo",
    Callback = function(Value) 
if Person == nil then
Person = game.Players.LocalPlayer.Name
end
_G.RojoSpam = Value
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Rojo" then
while _G.RojoSpam do
if RojoAbility == "Normal" then
game:GetService("ReplicatedStorage"):WaitForChild("RojoAbility"):FireServer("Release", {game.Players[Person].Character.HumanoidRootPart.CFrame})
elseif RojoAbility == "Down" then
game:GetService("ReplicatedStorage"):WaitForChild("RojoAbility"):FireServer("Release", {game.Players[Person].Character.HumanoidRootPart.CFrame * CFrame.Angles(-1.5, -9.99999993922529e-09, -0.5663706660270691)})
end
task.wait()
end
elseif _G.RojoSpam == true then
Notification("You don't have Rojo equipped.", 5)
wait(0.05)
OrionLib.Flag["Auto Ability Rojo"]:Set(false)
end
    end
})

TabGlove:AddTextbox({
	Name = "Player",
    Default = "",
    Callback = function(Value)
if Value == "Me" or Value == "me" or Value == "Username" or Value == "" then
DivebombExplosion = game.Players.LocalPlayer.Name
else
_G.PlayerTarget = Value
for _, v in pairs(game.Players:GetPlayers()) do
if string.sub(v.Name, 1, #_G.PlayerTarget):lower() == _G.PlayerTarget:lower() then
PlayerTa = v
end
end
if PlayerTa then
DivebombExplosion = PlayerTa.Name
Notification("Found Player [ "..PlayerTa.Name.." ]", 5)
else
Notification("Can't find player", 5)
end
end
    end
})

TabGlove:AddSlider({
    Name = "Charge Explosion",
    Default = 20,
    Min = 20,
    Max = 100,
    Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Charge",
    Callback = function(Value)
_G.ChargeExplosion = Value
    end
})

TabGlove:AddToggle({
    Name = "Auto Ability Divebomb",
    Default = false, 
    Flag = "Auto Ability Divebomb",
    Callback = function(Value) 
if DivebombExplosion == nil then
DivebombExplosion = game.Players.LocalPlayer.Name
end
_G.DivebombSpam = Value
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Divebomb" then
while _G.DivebombSpam do
game:GetService("ReplicatedStorage").RocketJump:InvokeServer({["chargeAlpha"] = 100,["rocketJump"] = true})
game:GetService("ReplicatedStorage").RocketJump:InvokeServer({["position"] = game.Players[DivebombExplosion].Character.HumanoidRootPart.Position,["explosion"] = true,["explosionAlpha"] = _G.ChargeExplosion})
task.wait()
end
elseif _G.DivebombSpam == true then
Notification("You don't have Divebomb equipped.", 5)
wait(0.05)
OrionLib.Flag["Auto Ability Divebomb"]:Set(false)
end
    end
})

TabGlove:AddTextbox({
	Name = "Player",
    Default = "",
    Callback = function(Value)
_G.PlayerTarget = Value
for _, v in pairs(game.Players:GetPlayers()) do
if string.sub(v.Name, 1, #_G.PlayerTarget):lower() == _G.PlayerTarget:lower() then
PlayerTa = v
end
end
if PlayerTa then
_G.BarrelPlayer = PlayerTa.Name
Notification("Found Player [ "..PlayerTa.Name.." ]", 5)
else
Notification("Can't find player", 5)
end
    end
})

TabGlove:AddToggle({
    Name = "Auto Barrel Player",
    Default = false, 
    Flag = "Auto Barrel",
    Callback = function(Value) 
_G.BarrelSpamPlayer = Value
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Barrel" then
while _G.BarrelSpamPlayer do
game:GetService("ReplicatedStorage").GeneralAbility:FireServer({["cf"] = game.Players[_G.BarrelPlayer].Character.HumanoidRootPart.CFrame})
task.wait()
end
elseif _G.BarrelSpamPlayer == true then
Notification("You don't have Barrel equipped.", 5)
wait(0.05)
OrionLib.Flag["Auto Barrel"]:Set(false)
end
    end
})

TabGlove:AddTextbox({
	Name = "Player",
    Default = "",
    Callback = function(Value)
_G.PlayerTarget = Value
for _, v in pairs(game.Players:GetPlayers()) do
if string.sub(v.Name, 1, #_G.PlayerTarget):lower() == _G.PlayerTarget:lower() then
PlayerTa = v
end
end
if PlayerTa then
_G.BarrelPlayer = PlayerTa.Name
Notification("Found Player [ "..PlayerTa.Name.." ]", 5)
else
Notification("Can't find player", 5)
end
    end
})

TabGlove:AddDropdown({
    Name = "Bind Ability",
    Options = {"Default", "Ultimate"},
    Default = "",
    Callback = function(Value)
_G.BindAbility = Value
    end
})

TabGlove:AddToggle({
    Text = "Auto Bind Player",
    Default = false, 
    Flag = "Auto Bind",
    Callback = function(Value) 
_G.BindSpamPlayer = Value
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Bind" then
while _G.BindSpamPlayer do
if _G.BindAbility == "Default" then
game:GetService("ReplicatedStorage").GeneralAbility:FireServer("default", {["goal"] = game.Players[_G.BindPlayer].Character.HumanoidRootPart.CFrame, ["origin"] = game.Players[_G.BindPlayer].Character.Head.CFrame})
elseif _G.BindAbility == "Ultimate" then
game:GetService("ReplicatedStorage").GeneralAbility:FireServer("ultimate", {["goal"] = game.Players[_G.BindPlayer].Character.HumanoidRootPart.CFrame * CFrame.Angles(3.141592502593994, 1.0641214847564697, -3.141592502593994), ["origin"] = game.Players[_G.BindPlayer].Character.HumanoidRootPart.CFrame * CFrame.Angles(3.141592502593994, 1.0641214847564697, -3.141592502593994)})
end
task.wait()
end
elseif _G.BindSpamPlayer == true then
Notification("You don't have Bind equipped.", 5)
wait(0.05)
OrionLib.Flag["Auto Bind"]:Set(false)
end
    end
})

TabGlove:AddTextbox({
	Name = "Player",
    Default = "",
    Callback = function(Value)
_G.PlayerTarget = Value
for _, v in pairs(game.Players:GetPlayers()) do
if string.sub(v.Name, 1, #_G.PlayerTarget):lower() == _G.PlayerTarget:lower() then
PlayerTa = v
end
end
if PlayerTa then
_G.PunishPlayer = PlayerTa.Name
Notification("Found Player [ "..PlayerTa.Name.." ]", 5)
else
Notification("Can't find player", 5)
end
    end
})

Cancel = false
TabGlove:AddButton({
     Name = "Punish Player",
     Callback = function()
if game.Players.LocalPlayer.Character:FindFirstChild("Swapper") or game.Players.LocalPlayer.Backpack:FindFirstChild("Swapper") then
OGL = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
game.Workspace.VoidPart.VoidPart1.CanCollide = true
Timer = 0
repeat
if Cancel == true then
break
end
if game.Players[_G.PunishPlayer].Character:FindFirstChild("HumanoidRootPart") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(workspace[_G.PunishPlayer].HumanoidRootPart.Position.X,-49999,workspace[_G.PunishPlayer].HumanoidRootPart.Position.Z)
end
task.wait(0.01)
if Timer < 1 then
Timer = Timer + 0.01
end
until game.Players[_G.PunishPlayer].Character and workspace[_G.PunishPlayer]:FindFirstChild("HumanoidRootPart") and workspace[_G.PunishPlayer]:FindFirstChild("entered") and workspace[_G.PunishPlayer].Ragdolled.Value == false and Timer >= 1
if Cancel == false then
game:GetService("ReplicatedStorage").SLOC:FireServer()
end
wait(.25)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OGL
game.Workspace.VoidPart.VoidPart1.CanCollide = false
if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Part",true) == nil then
game:GetService("Players").LocalPlayer.Reset:FireServer()
end
else
Notification("You don't have Swapper equipped, or you aren't in the arena.", 5)
end
    end
})

TabGlove:AddButton({
    Name = "Cancel",
    Callback = function()
Cancel = true
wait(0.1)
Cancel = false
    end
})

TabGlove:AddDropdown({
    Name = "Player Choose",
    Options = {"Username","Random"},
    Default = "",
    Callback = function(Value)
_G.PlayerChoose = Value
    end
})

TabGlove:AddTextbox({
	Name = "Player",
    Default = "",
    Callback = function(Value)
_G.PlayerTarget = Value
for _, v in pairs(game.Players:GetPlayers()) do
if string.sub(v.Name, 1, #_G.PlayerTarget):lower() == _G.PlayerTarget:lower() then
PlayerTa = v
end
end
if PlayerTa then
_G.PlayerButton = PlayerTa.Name
Notification("Found Player [ "..PlayerTa.Name.." ]", 5)
else
Notification("Can't find player", 5)
end
    end
})

TabGlove:AddButton({
      Name = "Player Void",
      Callback = function()
if _G.PlayerChoose == "Username" then
if game.Players.LocalPlayer.Character:FindFirstChild("Swapper") or game.Players.LocalPlayer.Backpack:FindFirstChild("Swapper") then
OGL = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
task.wait(0.25)
repeat task.wait()
if workspace[_G.PlayerButton]:FindFirstChild("HumanoidRootPart") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(workspace[_G.PlayerButton].HumanoidRootPart.Position.X,-70,workspace[_G.PlayerButton].HumanoidRootPart.Position.Z)
task.wait(0.37)
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
end
until game.Players[_G.PlayerButton].Character and workspace[_G.PlayerButton]:FindFirstChild("HumanoidRootPart") and workspace[_G.PlayerButton]:FindFirstChild("entered") and workspace[_G.PlayerButton].Ragdolled.Value == false
task.wait(0.6)
game:GetService("ReplicatedStorage").SLOC:FireServer()
wait(.25)
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
task.wait(0.05)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OGL
else
Notification("You don't have Swapper equipped, or you aren't in the arena.", 5)
end
elseif _G.PlayerChoose == "Random" then
if game.Players.LocalPlayer.Character:FindFirstChild("Swapper") or game.Players.LocalPlayer.Backpack:FindFirstChild("Swapper") then
OGL = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
local players = game.Players:GetChildren()
local RandomPlayer = players[math.random(1, #players)]
repeat RandomPlayer = players[math.random(1, #players)] until RandomPlayer ~= game.Players.LocalPlayer and RandomPlayer.Character:FindFirstChild("entered") and RandomPlayer.Character:FindFirstChild("Ragdolled").Value == false
Target = RandomPlayer
repeat task.wait()
if Target.Character:FindFirstChild("HumanoidRootPart") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Target.Character.HumanoidRootPart.Position.X,-70,Target.Character.HumanoidRootPart.Position.Z)
task.wait(0.37)
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
end
until Target.Character and Target.Character:FindFirstChild("HumanoidRootPart") and Target.Character:FindFirstChild("entered") and Target.Character:FindFirstChild("Ragdolled").Value == false
task.wait(0.6)
game:GetService("ReplicatedStorage").SLOC:FireServer()
wait(.25)
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
task.wait(0.05)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OGL
else
Notification("You don't have Swapper equipped, or you aren't in the arena.", 5)
end
end
    end
})

TabGlove:AddButton({
      Name = "Home Run Player",
      Callback = function()
if _G.PlayerChoose == "Username" then
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Home Run" and game.Players[_G.PlayerButton].Character:FindFirstChild("entered") then
OGL = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
OGLZ = game.Players[_G.PlayerButton].Character.HumanoidRootPart.Size
game.Players[_G.PlayerButton].Character.HumanoidRootPart.Size = Vector3.new(50,50,50)
game:GetService("ReplicatedStorage").HomeRun:FireServer({["start"] = true})
wait(4.2)
game:GetService("ReplicatedStorage").HomeRun:FireServer({["finished"] = true})
task.wait(0.12)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[_G.PlayerButton].Character.HumanoidRootPart.CFrame
task.wait(0.25)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OGL
game.Players[_G.PlayerButton].Character.HumanoidRootPart.Size = OGLZ
else
Notification("You don't have Home Run equipped", 5)
end
elseif _G.PlayerChoose == "Random" then
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Home Run" then
OGL = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("ReplicatedStorage").HomeRun:FireServer({["start"] = true})
wait(4.2)
local players = game.Players:GetChildren()
local RandomPlayer = players[math.random(1, #players)]
repeat RandomPlayer = players[math.random(1, #players)] until RandomPlayer ~= game.Players.LocalPlayer and RandomPlayer.Character:FindFirstChild("rock") == nil and RandomPlayer.Character.Head:FindFirstChild("UnoReverseCard") == nil
Target = RandomPlayer
OGLZ = Target.Character.HumanoidRootPart.Size
Target.Character.HumanoidRootPart.Size = Vector3.new(50,50,50)
wait(0.25)
game:GetService("ReplicatedStorage").HomeRun:FireServer({["finished"] = true})
task.wait(0.12)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame
task.wait(0.25)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OGL
Target.Character.HumanoidRootPart.Size = OGLZ
else
Notification("You don't have Home Run equipped", 5)
end
end
    end
})

TabGlove:AddButton({
      Name = "Hive Player",
      Callback = function()
if _G.PlayerChoose == "Username" then
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Hive" and game.Players[_G.PlayerButton].Character:FindFirstChild("entered") then
OGL = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
OGLZ = game.Players[_G.PlayerButton].Character.HumanoidRootPart.Size
game.Players[_G.PlayerButton].Character.HumanoidRootPart.Size = Vector3.new(20,20,20)
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
task.wait(4.2)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[_G.PlayerButton].Character.HumanoidRootPart.CFrame
wait(0.25)
game:GetService("ReplicatedStorage"):WaitForChild("GeneralHit"):FireServer(game.Players[_G.PlayerButton].Character:WaitForChild("HumanoidRootPart"))
wait(0.25)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OGL
game.Players[_G.PlayerButton].Character.HumanoidRootPart.Size = OGLZ
else
Notification("You don't have Hive equipped", 5)
end
elseif _G.PlayerChoose == "Random" then
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Hive" then
OGL = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
task.wait(4.32)
local players = game.Players:GetChildren()
local RandomPlayer = players[math.random(1, #players)]
repeat RandomPlayer = players[math.random(1, #players)] until RandomPlayer ~= game.Players.LocalPlayer and RandomPlayer.Character:FindFirstChild("entered") and RandomPlayer.Character:FindFirstChild("rock") == nil and RandomPlayer.Character.Head:FindFirstChild("UnoReverseCard") == nil
Target = RandomPlayer
OGLZ = Target.Character.HumanoidRootPart.Size
Target.Character.HumanoidRootPart.Size = Vector3.new(20,20,20)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame
wait(0.25)
game:GetService("ReplicatedStorage"):WaitForChild("GeneralHit"):FireServer(Target.Character:WaitForChild("HumanoidRootPart"))
wait(0.22)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OGL
Target.Character.HumanoidRootPart.Size = OGLZ
else
Notification("You don't have Hive equipped", 5)
end
end
    end
})

TabGlove:AddButton({
      Name = "Quake Player",
      Callback = function()
if _G.PlayerChoose == "Username" then
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Quake" and game.Players.LocalPlayer.Character:FindFirstChild("entered") and game.Players[_G.PlayerButton].Character:FindFirstChild("entered") then
game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack.Quake)
OGL = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("ReplicatedStorage"):WaitForChild("QuakeQuake"):FireServer({["start"] = true})
wait(3.45)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[_G.PlayerButton].Character:FindFirstChild("Head").CFrame * CFrame.new(0,4,0)
task.wait(0.18)
game:GetService("ReplicatedStorage"):WaitForChild("QuakeQuake"):FireServer({["finished"] = true})
task.wait(0.17)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OGL
game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
else
Notification("You don't have Quake equipped.", 5)
end
elseif _G.PlayerChoose == "Random" then
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Quake" and game.Players.LocalPlayer.Character:FindFirstChild("entered") then
game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack.Quake)
OGL = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
game:GetService("ReplicatedStorage"):WaitForChild("QuakeQuake"):FireServer({["start"] = true})
wait(4)
local players = game.Players:GetChildren()
local RandomPlayer = players[math.random(1, #players)]
repeat RandomPlayer = players[math.random(1, #players)] until RandomPlayer ~= game.Players.LocalPlayer and RandomPlayer.Character:FindFirstChild("rock") == nil and RandomPlayer.Character.Head:FindFirstChild("UnoReverseCard") == nil and RandomPlayer.Character:FindFirstChild("entered")
Target = RandomPlayer
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character:FindFirstChild("Head").CFrame * CFrame.new(0,4,0)
task.wait(0.13)
game:GetService("ReplicatedStorage"):WaitForChild("QuakeQuake"):FireServer({["finished"] = true})
task.wait(0.17)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OGL
game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
else
Notification("You don't have Quake equipped.", 5)
end
end
    end
})

TabGlove:AddButton({
      Name = "Cards Player",
      Callback = function()
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Jester" then
if _G.PlayerChoose == "Username" then
game:GetService("ReplicatedStorage").GeneralAbility:FireServer("Ability3",game.Players[_G.PlayerButton])
elseif _G.PlayerChoose == "Random" then
local players = game.Players:GetChildren()
local RandomPlayer = players[math.random(1, #players)]
repeat RandomPlayer = players[math.random(1, #players)] until RandomPlayer ~= game.Players.LocalPlayer and RandomPlayer.Character:FindFirstChild("rock") == nil and RandomPlayer.Character.Head:FindFirstChild("UnoReverseCard") == nil and RandomPlayer.Character:FindFirstChild("entered")
Target = RandomPlayer
game:GetService("ReplicatedStorage").GeneralAbility:FireServer("Ability3",Target)
end
else
Notification("You don't have Jester glove equipped", 5)
end
    end
})

TabGlove:AddDropdown({
    Name = "Teleport Old Place",
    Options = {"Yes", "No","Player"},
    Default = "Yes",
    Callback = function(Value)
_G.TeleportOldPlace = Value
    end
})

TabGlove:AddButton({
      Name = "Player Teleport Recall",
      Callback = function()
if game.Players.LocalPlayer.Character:FindFirstChild("entered") and game.Players.LocalPlayer.leaderstats.Glove.Value == "Recall" and game.Players.LocalPlayer.Backpack:FindFirstChild("Recall") == nil then
if _G.TeleportOldPlace == "Yes" then
OLG = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
end
game:GetService("ReplicatedStorage").Recall:InvokeServer(game:GetService("Players").LocalPlayer.Character.Recall)
wait(2.2)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[_G.PlayerButton].Character.Head.CFrame
task.wait(0.5)
if _G.TeleportOldPlace == "Yes" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OLG
elseif _G.TeleportOldPlace == "Player" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[_G.PlayerButton].Character.HumanoidRootPart.CFrame
end
else
Notification("You don't have Recall equipped or you haven't in arena or you have equip Backpack Recall.", 5)
end
    end
})

TabGlove:AddButton({
      Name = "Grab Player Teleport",
      Callback = function()
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Grab" and game.Players.LocalPlayer.Character:FindFirstChild("entered") and game.Players[_G.PlayerButton].Character:FindFirstChild("entered") then
if _G.TeleportOldPlace == "Yes" then
OLG = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[_G.PlayerButton].Character.HumanoidRootPart.CFrame
wait(0.15)
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
wait(0.15)
if _G.TeleportOldPlace == "Yes" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OLG
end
else
Notification("You don't have Grab equipped, or you have to go Arena, or player go to Arena", 5)
end
    end
})

TabGlove:AddToggle({
    Text = "Auto Oven Player",
    Default = false, 
    Flag = "Auto Oven",
    Callback = function(Value) 
_G.OvenPlayerAuto = Value
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Oven" then
while _G.OvenPlayerAuto do
if _G.PlayerChoose == "Username" then
if not game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'s Oven") then
game:GetService("ReplicatedStorage").GeneralAbility:FireServer(game.Players[_G.PlayerButton].Character.HumanoidRootPart.CFrame)
end
elseif _G.PlayerChoose == "Random" then
local players = game.Players:GetChildren()
local RandomPlayer = players[math.random(1, #players)]
repeat RandomPlayer = players[math.random(1, #players)] until RandomPlayer ~= game.Players.LocalPlayer and RandomPlayer.Character:FindFirstChild("rock") == nil and RandomPlayer.Character.Head:FindFirstChild("UnoReverseCard") == nil and RandomPlayer.Character:FindFirstChild("entered")
Target = RandomPlayer
if not game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'s Oven") then
game:GetService("ReplicatedStorage").GeneralAbility:FireServer(Target.Character.HumanoidRootPart.CFrame)
end
end
task.wait()
end
elseif _G.OvenPlayerAuto == true then
Notification("You don't have Oven equipped.", 5)
wait(0.05)
OrionLib.Flag["Auto Oven"]:Set(false)
end
    end
})

TabGlove:AddToggle({
    Name = "Auto Siphon Player",
    Default = false, 
    Flag = "Auto Siphon",
    Callback = function(Value) 
_G.AutoSiphonPlayer = Value
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Siphon" then
while _G.AutoSiphonPlayer  do
if _G.PlayerChoose == "Username" then
if game.Players.LocalPlayer.Character:FindFirstChild("entered") and game.Players[_G.PlayerButton].Character:FindFirstChild("entered") then
game:GetService("ReplicatedStorage").Events.Siphon:FireServer({["cf"] = game.Players[_G.PlayerButton].Character.HumanoidRootPart.CFrame})
end
elseif _G.PlayerChoose == "Random" then
local players = game.Players:GetChildren()
local RandomPlayer = players[math.random(1, #players)]
if RandomPlayer ~= game.Players.LocalPlayer and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and RandomPlayer.Character then
if RandomPlayer.Character:FindFirstChild("entered") and RandomPlayer.Character:FindFirstChild("HumanoidRootPart") and RandomPlayer.Character:FindFirstChild("stevebody") == nil and RandomPlayer.Character:FindFirstChild("rock") == nil then
game:GetService("ReplicatedStorage").Events.Siphon:FireServer({["cf"] = RandomPlayer.Character.HumanoidRootPart.CFrame})
end
end
end 
task.wait()
end
elseif _G.AutoSiphonPlayer == true then
Notification("You don't have Siphon equipped.", 5)
wait(0.05)
OrionLib.Flag["Auto Siphon Player"]:Set(false)
end
    end
})

TabGlove:AddButton({
      Name = "Kick Player Recall",
      Callback = function()
if _G.PlayerChoose == "Username" then
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Recall" and game.Players.LocalPlayer.Character:FindFirstChild("Recall") and game.Players.LocalPlayer.Character:FindFirstChild("entered") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players[PlayerKickRecall].Character:FindFirstChild("entered") and game.Players[PlayerKickRecall].Character:FindFirstChild("HumanoidRootPart") then
OGL = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
for i,v in pairs(game.Workspace.Lobby.brazil:GetChildren()) do
v.CanTouch = false
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-725,310,-2)
task.wait(0.25)
game:GetService("ReplicatedStorage").Recall:InvokeServer(game:GetService("Players").LocalPlayer.Character.Recall)
wait(2.2)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[PlayerKickRecall].Character.HumanoidRootPart.CFrame
task.wait(1)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OGL
for i,v in pairs(game.Workspace.Lobby.brazil:GetChildren()) do
v.CanTouch = true
end
else
Notification("You don't have Recall equipped, or you have Backpack Recall equipped, or player not enter arena", 5)
end
elseif _G.PlayerChoose == "Random" then
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Recall" and game.Players.LocalPlayer.Character:FindFirstChild("Recall") and game.Players.LocalPlayer.Character:FindFirstChild("entered") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
OGL = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
for i,v in pairs(game.Workspace.Lobby.brazil:GetChildren()) do
v.CanTouch = false
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-725,310,-2)
task.wait(0.25)
game:GetService("ReplicatedStorage").Recall:InvokeServer(game:GetService("Players").LocalPlayer.Character.Recall)
wait(2.2)
local players = game.Players:GetChildren()
local randomPlayer = players[math.random(1, #players)]
repeat randomPlayer = players[math.random(1, #players)] until randomPlayer ~= game.Players.LocalPlayer and randomPlayer.Character:FindFirstChild("entered") and randomPlayer.Character:FindFirstChild("ded") == nil and randomPlayer.Character:FindFirstChild("InLabyrinth") == nil and randomPlayer.Character:FindFirstChild("rock") == nil
Target = randomPlayer
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame
task.wait(1)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OGL
for i,v in pairs(game.Workspace.Lobby.brazil:GetChildren()) do
v.CanTouch = true
end
else
Notification("You don't have Recall equipped, or you have Backpack Recall equipped, or player not enter arena", 5)
end
end
    end
})

TabGlove:AddButton({
      Name = "Kick Player Za Hando",
      Callback = function()
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Za Hando" then
OGWS = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed
OGJP = game.Players.LocalPlayer.Character.Humanoid.JumpPower
OGL = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
for i,v in pairs(game.Workspace.Lobby.brazil:GetChildren()) do
v.CanTouch = false
end
game:GetService("ReplicatedStorage").Erase:FireServer()
wait(0.47)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 0
game.Players.LocalPlayer.Character.Humanoid.JumpPower = 0
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-725,310,-2)
wait(3.75)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OGL
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = OGWS
game.Players.LocalPlayer.Character.Humanoid.JumpPower = OGJP
for i,v in pairs(game.Workspace.Lobby.brazil:GetChildren()) do
v.CanTouch = true
end
else
Notification("You don't have Za Hando equipped.", 5)
end
    end
})

TabGlove:AddToggle({
    Name = "Auto Sbeve All Player",
    Default = false, 
    Flag = "Auto Sbeve All",
    Callback = function(Value) 
_G.AutoSbeveAllPlayer = Value
while _G.AutoSbeveAllPlayer do
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Sbeve" or game.Players.LocalPlayer.Character:FindFirstChild("stevebody") then
for i,v in pairs(game.Players:GetChildren()) do
         if v ~= game.Players.LocalPlayer and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and v.Character then
              if v.Character:FindFirstChild("entered") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("stevebody") == nil and v.Character:FindFirstChild("rock") == nil and v.Character.Ragdolled.Value == false then
                 v.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.stevebody.CFrame * CFrame.new(0,3.75,0)
              end
          end
     end
 end
task.wait()
end
    end
})

TabGlove:AddButton({
      Name = "Sbeve All Player",
      Callback = function()
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Sbeve" or game.Players.LocalPlayer.Character:FindFirstChild("stevebody") then
for i,v in pairs(game.Players:GetChildren()) do
         if v ~= game.Players.LocalPlayer and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and v.Character then
              if v.Character:FindFirstChild("entered") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("stevebody") == nil and v.Character:FindFirstChild("rock") == nil and v.Character.Ragdolled.Value == false then
                 v.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.stevebody.CFrame
              end
          end
     end
elseif game.Players.LocalPlayer.Character:FindFirstChild("stevebody") == nil then
for i,v in pairs(game.Players:GetChildren()) do
         if v ~= game.Players.LocalPlayer and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and v.Character then
              if v.Character:FindFirstChild("entered") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("stevebody") then
                 v.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
              end
          end
     end
 end
    end
})

TabGlove:AddButton({
      Name = "Bring All Player",
      Callback = function()
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Lawnmower" then
game:GetService("ReplicatedStorage").GeneralAbility:FireServer("lawnmower")
for i,v in pairs(game.Players:GetChildren()) do
         if v ~= game.Players.LocalPlayer and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and v.Character then
              if v.Character:FindFirstChild("entered") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("stevebody") == nil and v.Character:FindFirstChild("rock") == nil and v.Character.Ragdolled.Value == false then
                 game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
                 wait(0.2)
              end
          end
     end
else
Notification("You don't have Lawnmower equipped.", 5)
end
    end
})

TabGlove:AddDropdown({
    Name = "Black Hole",
    Options = {"Normal", "Teleport Cannon Island"},
    Default = "",
    Callback = function(Value)
_G.BlackHoleCre = Value
    end
})

TabGlove:AddButton({
      Name = "Auto Create Black Hole",
      Callback = function()
if game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil and game:GetService("BadgeService"):UserHasBadgeAsync(game.Players.LocalPlayer.UserId, 2125950512) and game:GetService("BadgeService"):UserHasBadgeAsync(game.Players.LocalPlayer.UserId, 2147429609) then
if _G.BlackHoleCre == "Normal" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Origo.CFrame * CFrame.new(0,30,0)
wait(0.1)
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
wait(0.05)
fireclickdetector(workspace.Lobby["rob"].ClickDetector)
wait(0.3)
game:GetService("ReplicatedStorage").rob:FireServer()
wait(4.8)
fireclickdetector(workspace.Lobby["bob"].ClickDetector)
task.wait(0.08)
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
wait(0.3)
game:GetService("ReplicatedStorage").bob:FireServer()
wait(0.5)
for i = 1,26 do
for _, v in pairs(workspace:GetChildren()) do
if v.Name:match(game.Players.LocalPlayer.Name) and v:FindFirstChild("HumanoidRootPart") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
end
end
end
elseif _G.BlackHoleCre == "Teleport Cannon Island" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Origo.CFrame * CFrame.new(0,30,0)
wait(0.1)
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
wait(0.05)
fireclickdetector(workspace.Lobby["rob"].ClickDetector)
wait(0.3)
game:GetService("ReplicatedStorage").rob:FireServer()
wait(4.8)
fireclickdetector(workspace.Lobby["bob"].ClickDetector)
task.wait(0.08)
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
wait(0.3)
game:GetService("ReplicatedStorage").bob:FireServer()
wait(0.5)
for i = 1,26 do
for _, v in pairs(workspace:GetChildren()) do
if v.Name:match(game.Players.LocalPlayer.Name) and v:FindFirstChild("HumanoidRootPart") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
end
end
end
wait(0.5)
repeat task.wait() until game.Players.LocalPlayer.Character
if not game.Players.LocalPlayer.Character:FindFirstChild("entered") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
repeat task.wait()
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1.TouchInterest.Parent, 0)
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1.TouchInterest.Parent, 1)
until game.Players.LocalPlayer.Character:FindFirstChild("entered")
end
wait(0.27)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(227, 48, 169)
wait(0.25)
for i,v in ipairs(game.Workspace.Arena.CannonIsland:GetDescendants()) do
            if v.ClassName == "ProximityPrompt" then
                fireproximityprompt(v)
            end
        end
end
else
Notification("You have in lobby, or You don't have badge bob, or badge rob.", 5)
end
    end
})

TabGlove:AddButton({
      Name = "Auto Enter Map Null",
      Callback = function()
if game.Workspace:FindFirstChild("Blackhole_Particles") == nil then
Notification("When will someone create a black hole [ BOB + ROB ].", 5)
elseif game.Players.LocalPlayer.Character:FindFirstChild("entered") ~= nil and game.Players.LocalPlayer.leaderstats.Glove.Value ~= "Default" then
game:GetService("Players").LocalPlayer.Reset:FireServer()
wait(3.75)
fireclickdetector(workspace.Lobby.Default.ClickDetector)
wait(0.5)
repeat task.wait() until game.Players.LocalPlayer.Character
if not game.Players.LocalPlayer.Character:FindFirstChild("entered") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
repeat task.wait()
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1.TouchInterest.Parent, 0)
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1.TouchInterest.Parent, 1)
until game.Players.LocalPlayer.Character:FindFirstChild("entered")
end
wait(0.5)
repeat task.wait()
if game.Workspace:FindFirstChild("Blackhole_Particles") and game.Workspace.Blackhole_Particles:FindFirstChild("BlackHole") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Blackhole_Particles.BlackHole.CFrame
end
until game.Players.LocalPlayer.Character.Humanoid.Health == 0
elseif game.Players.LocalPlayer.Character:FindFirstChild("entered") ~= nil and game.Players.LocalPlayer.leaderstats.Glove.Value == "Default" then
repeat task.wait()
if game.Workspace:FindFirstChild("Blackhole_Particles") and game.Workspace.Blackhole_Particles:FindFirstChild("BlackHole") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Blackhole_Particles.BlackHole.CFrame
end
until game.Players.LocalPlayer.Character.Humanoid.Health == 0
elseif game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil and game.Players.LocalPlayer.leaderstats.Glove.Value == "Default" then
repeat task.wait() until game.Players.LocalPlayer.Character
if not game.Players.LocalPlayer.Character:FindFirstChild("entered") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
repeat task.wait()
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1.TouchInterest.Parent, 0)
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1.TouchInterest.Parent, 1)
until game.Players.LocalPlayer.Character:FindFirstChild("entered")
end
wait(0.5)
repeat task.wait()
if game.Workspace:FindFirstChild("Blackhole_Particles") and game.Workspace.Blackhole_Particles:FindFirstChild("BlackHole") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Blackhole_Particles.BlackHole.CFrame
end
until game.Players.LocalPlayer.Character.Humanoid.Health == 0
elseif game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil and game.Players.LocalPlayer.leaderstats.Glove.Value ~= "Default" then
fireclickdetector(workspace.Lobby.Default.ClickDetector)
wait(0.07)
repeat task.wait() until game.Players.LocalPlayer.Character
if not game.Players.LocalPlayer.Character:FindFirstChild("entered") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
repeat task.wait()
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1.TouchInterest.Parent, 0)
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1.TouchInterest.Parent, 1)
until game.Players.LocalPlayer.Character:FindFirstChild("entered")
end
wait(0.05)
repeat task.wait()
if game.Workspace:FindFirstChild("Blackhole_Particles") and game.Workspace.Blackhole_Particles:FindFirstChild("BlackHole") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Blackhole_Particles.BlackHole.CFrame
end
until game.Players.LocalPlayer.Character.Humanoid.Health == 0
end
    end
})

TabGlove:AddButton({
      Name = "Auto Enter Cannon",
      Callback = function()
if game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil then
repeat task.wait() until game.Players.LocalPlayer.Character
if not game.Players.LocalPlayer.Character:FindFirstChild("entered") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
repeat task.wait()
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1.TouchInterest.Parent, 0)
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1.TouchInterest.Parent, 1)
until game.Players.LocalPlayer.Character:FindFirstChild("entered")
end
wait(0.2)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(227, 48, 169)
wait(0.25)
for i,v in ipairs(game.Workspace.Arena.CannonIsland:GetDescendants()) do
            if v.ClassName == "ProximityPrompt" then
                fireproximityprompt(v)
            end
        end
elseif game.Players.LocalPlayer.Character:FindFirstChild("entered") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(227, 48, 169)
wait(0.25)
for i,v in ipairs(game.Workspace.Arena.CannonIsland:GetDescendants()) do
            if v.ClassName == "ProximityPrompt" then
                fireproximityprompt(v)
            end
        end
end
    end
})

TabGlove:AddSection({Name = "Misc Glove"})

TabGlove:AddButton({
    Name = "Spawn Orb Siphon",
    Callback = function()
if game.Players.LocalPlayer.Character:FindFirstChild("entered") and game.Players.LocalPlayer.leaderstats.Glove.Value == "Siphon" then
repeat task.wait()
game:GetService("ReplicatedStorage").Events.Siphon:FireServer({["cf"] = game.Workspace.Arena.CubeOfDeathArea["the cube of death(i heard it kills)"].Part.CFrame})
until game.Players.LocalPlayer.leaderstats.Glove.Value ~= "Siphon" or game.Workspace.Arena.CubeOfDeathArea["the cube of death(i heard it kills)"]:FindFirstChild("siphon_charge")
repeat task.wait()
if game.Workspace.Arena.CubeOfDeathArea["the cube of death(i heard it kills)"]:FindFirstChild("siphon_charge") then
game.Workspace.Arena.CubeOfDeathArea["the cube of death(i heard it kills)"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
end
until game.Workspace.Arena.CubeOfDeathArea["the cube of death(i heard it kills)"]:FindFirstChild("siphon_charge") == nil
else
Notification("You don't have Siphon equipped or you haven't in arena.", 5)
end
    end
})

TabGlove:AddButton({
    Name = "Ability Lure Safe",
    Callback = function()
if game.Players.LocalPlayer.Character:FindFirstChild("entered") and game.Players.LocalPlayer.leaderstats.Glove.Value == "Lure" then
OldTP = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Arena.CannonIsland.Cannon.Base.CFrame * CFrame.new(0,0,35)
task.wait(0.2)
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
task.wait(0.15)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OldTP
else
Notification("You don't have Lure equipped or you haven't in arena.", 5)
end
    end
})

TabGlove:AddToggle({
    Name = "Auto Collect Ingredients",
    Default = false, 
    Flag = "Auto Ingredients",
    Callback = function(Value) 
_G.AutoPickupIngredients = Value
while _G.AutoPickupIngredients do
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Alchemist" and game.Workspace:FindFirstChild("Alchemist_Ingredients_") then
for i,v in pairs(game.Workspace:FindFirstChild("Alchemist_Ingredients_"):GetChildren()) do
if v:IsA("Model") and v:FindFirstChild("Clickbox") and v.Clickbox:FindFirstChild("ClickDetector") then
v.Clickbox.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
end
end
end
task.wait()
end
    end
})

TabGlove:AddToggle({
    Name = "Auto Collect Pillow",
    Default = false, 
    Flag = "Auto Pillow",
    Callback = function(Value) 
_G.AutoCollectPillow = Value
while _G.AutoCollectPillow do
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Pillow" and game.Workspace:FindFirstChild("pillows_") then
for i,v in pairs(game.Workspace:FindFirstChild("pillows_"):GetChildren()) do
if v.Name == "pillow_model" and v:FindFirstChild("Clickbox") and v.Clickbox:FindFirstChild("ClickDetector") then
v.Clickbox.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
end
end
end
task.wait()
end
    end
})

TabGlove:AddToggle({
    Name = "Infinity Pillow",
    Default = false, 
    Flag = "Inf Pillow",
    Callback = function(Value) 
_G.InfinityPillow = Value
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Pillow" then
while _G.InfinityPillow do
game:GetService("ReplicatedStorage").Events.PillowEvent:FireServer("AddPillow")
task.wait()
end
elseif _G.InfinityPillow == true then
Notification("You don't have Pillow equipped", 5)
wait(0.05)
OrionLib.Flag["Inf Pillow"]:Set(false)
end
    end
})

TabGlove:AddToggle({
    Name = "Infinite Ingredients",
    Default = false, 
    Flag = "Inf Ingredients",
    Callback = function(Value) 
_G.InfiniteIngredients = Value
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Alchemist" then
while _G.InfiniteIngredients do
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Alchemist" then
game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Mushroom")
game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Glowing Mushroom")
game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Fire Flower")
game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Winter Rose")
game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Dark Root")
game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Dire Flower")
game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Autumn Sprout")
game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Elder Wood")
game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Hazel Lily")
game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Wild Vine")
game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Jade Stone")
game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Lamp Grass")
game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Plane Flower")
game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Blood Rose")
game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Red Crystal")
game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Blue Crystal")
game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Cake Mix")
end
task.wait()
end
elseif _G.InfiniteIngredients == true then
OrionLib.Flag["Infinite Ingredients"]:Set(false)
wait(0.05)
Notification("You don't have Alchemist equipped", 5)
end
    end
})

TabGlove:AddDropdown({
	Name = "Potion",
	Default = "",
	Options = {"Grug","Nightmare","Confusion","Power","Paralyzing","Haste","Invisibility","Explosion","Invincible","Toxic","Freeze","Feather","Speed","Lethal","Slow","Antitoxin","Corrupted Vine","Field","Lost"},
	Flag = "Potion Choose",
	Callback = function(Value)
		_G.MakePotion = Value
	end    
})

TabGlove:AddSlider({
	Name = "Potion",
	Min = 1,
	Max = 100,
	Default = 5,
	Flag = "Potion Get",
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Get",
	Callback = function(Value)
_G.PotionNumber = Value
	end    
})

TabGlove:AddDropdown({
	Name = "Potion",
	Default = "",
	Options = {"Number","Normal"},
	Flag = "Potion Make",
	Callback = function(Value)
		_G.Potion2 = Value
	end    
})

TabGlove:AddButton({
	Name = "Get Potion",
	Callback = function()
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Alchemist" then
if not game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'s Cauldron") then
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
end
if _G.Potion2 == "Normal" then
for i = 1, #_G.GetPotion[_G.MakePotion] do
game:GetService("ReplicatedStorage").AlchemistEvent:FireServer("AddItem", _G.GetPotion[_G.MakePotion][i])
game:GetService("ReplicatedStorage").AlchemistEvent:FireServer("MixItem", _G.GetPotion[_G.MakePotion][i])
task.wait()
end
game:GetService("ReplicatedStorage").AlchemistEvent:FireServer("BrewPotion")
elseif _G.Potion2 == "Number" then
for a = 1, _G.PotionNumber do
for i = 1, #_G.GetPotion[_G.MakePotion] do
game:GetService("ReplicatedStorage").AlchemistEvent:FireServer("AddItem", _G.GetPotion[_G.MakePotion][i])
game:GetService("ReplicatedStorage").AlchemistEvent:FireServer("MixItem", _G.GetPotion[_G.MakePotion][i])
end
game:GetService("ReplicatedStorage").AlchemistEvent:FireServer("BrewPotion")
end
end
else
Notification("You don't have Alchemist equipped", 5)
end
  	end    
})

TabGlove:AddToggle({
	Name = "Auto Get Potion",
	Default = false,
	Flag = "Auto Get Potion",
	Callback = function(Value)
_G.AutoMakePotion = Value
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Alchemist" then
while _G.AutoMakePotion do
if game.Players.LocalPlayer.leaderstats.Glove.Value == "Alchemist" then
if not game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'s Cauldron") then
game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
end
for i = 1, #_G.GetPotion[_G.MakePotion] do
game:GetService("ReplicatedStorage").AlchemistEvent:FireServer("AddItem", _G.GetPotion[_G.MakePotion][i])
game:GetService("ReplicatedStorage").AlchemistEvent:FireServer("MixItem", _G.GetPotion[_G.MakePotion][i])
end
game:GetService("ReplicatedStorage").AlchemistEvent:FireServer("BrewPotion")
end
task.wait(0.01)
end
elseif _G.AutoMakePotion == true then
OrionLib.Flag["Auto Get Potion"]:Set(false)
wait(0.05)
Notification("You don't have Alchemist equipped", 5)
end
	end    
})

TabGlove:AddTextbox({
	Name = "Speed Orbit Ping Pong",
	Default = "UserSpeed",
	TextDisappear = true,
	Callback = function(Value)
if Value == "inf" or Value == "Inf" or Value == "infinity" or Value == "Infinity" then
OrbitSpeed = 9e9
else
OrbitSpeed = Value
end
	end	  
})

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Void"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Portal"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Admin"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Kick"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Afk"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Obby"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Megarock | Custom"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Join Guide"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Snowball"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Ball Baller"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Bus"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Ghost Player"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Lure"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Mail"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Water"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Jail Admin"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Mitten Blind"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Knockoff"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Hallow - Jack"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Booster"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Squid"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Conveyor"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Ice"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Time Stop"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Null"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Run"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Brick"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Record"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti [REDACTED]"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Brazil"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Za Hando"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Bob"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Fort"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Reaper"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Pusher"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Defend"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Bubble"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Stun"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti COD"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Death Barriers"]:Set(game.Workspace.NoChanged.Value)
end)

game.Workspace.NoChanged.Changed:Connect(function()
OrionLib.Flags["Anti Ragdoll"]:Set(game.Workspace.NoChanged.Value)
end)

end

Tabs["Settings Ui"]:AddSlider({
	Name = "Notification Volume",
	Min = 2,
	Max = 10,
	Default = 5,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Volume",
	Callback = function(Value)
		_G.VolumeTime = Value
	end    
})

Tabs["Settings Ui"]:AddToggle({
    Name = "Notification Sound",
    Default = false,
    Callback = function(Value)
_G.NotificationSound = Value
    end
})

_G.ChooseNotify = "Orion"
Tabs["Settings Ui"]:AddDropdown({
	Name = "Notification Choose",
	Default = "Orion",
	Options = {"Roblox", "Orion"},
	Callback = function(Value)
		_G.ChooseNotify = Value
	end    
})

Tabs["Settings Ui"]:AddSection({Name = "Join Server"})

local ButtonJoin = {
	Zalo = Tabs["Settings Ui"]:AddButton({Name = "Copy Zalo", Callback = function()
    if setclipboard then
        setclipboard("https://zalo.me/g/qlukiy407")
        Notification("Copied Zalo link to clipboard!", 5)
    else
        Notification("Zalo link: https://zalo.me/g/qlukiy407", 10)
    end
end}),
    Discord = Tabs["Settings Ui"]:AddButton({Name = "Copy Discord", Callback = function()
    if setclipboard then
        setclipboard("https://discord.gg/56BDhEaz32")
        Notification("Copied discord link to clipboard!")
    else
        Notification("Discord link: https://discord.gg/56BDhEaz32", 10)
    end
end})}

Tabs["Settings Ui"]:AddSection({Name = "Create"})

local Create = {
	AmongUs = Tabs["Settings Ui"]:AddParagraph("AmongUs", "Dex / Script / Python"),
	GiangHub = Tabs["Settings Ui"]:AddParagraph("Giang Hub", "Dex / Script"),
	DeleteGui = Tabs["Settings Ui"]:AddButton({Name = "Delete Gui", Callback = function()
      	OrionLib:Destroy()
    end    
})}