if not game:IsLoaded() then
    game.Loaded:Wait()
end

function TweenTp(Part, CFnew, Body, Speed)
BodyEnter = Body
if BodyEnter == true then
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and game.Players.LocalPlayer.Character.Humanoid.RootPart and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityHandler") == nil then
local bv = Instance.new("BodyVelocity")
bv.Name = "VelocityHandler"
bv.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
bv.MaxForce = Vector3.new(100000, 100000, 100000)
bv.Velocity = Vector3.new(0, 0, 0)
end
end
local Tween = game:GetService("TweenService"):Create(Part, TweenInfo.new(Speed, Enum.EasingStyle.Linear), {CFrame = CFnew})
Tween:Play()
if _G.Tween == false then
Tween:Cancel()
if BodyEnter == true then
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and game.Players.LocalPlayer.Character.Humanoid.RootPart and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityHandler") then
game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler:Destroy()
end
end
end
end

function CancelTween()
_G.Tween = false
TweenTp(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame, true, 0)
_G.Tween = true
end

if game.PlaceId == 2753915549 then
    BloxFruitSea1 = true
elseif game.PlaceId== 4442272183 then
    BloxFruitSea2 = true
elseif game.PlaceId == 7449423635 then
    BloxFruitSea3 = true
end

TweenGet = 1
spawn(function()
while true do
TweenGet = TweenGet + 1
    if TweenGet >= 5 then
        TweenGet = 1
    end
wait(0.2)
end
end)
spawn(function()
    while task.wait() do
        if TweenGet == 1 then
            PositionOrbit = CFrame.new(0, 40, 0)
        elseif TweenGet == 2 then
            PositionOrbit = CFrame.new(-40, 40, 0)
        elseif TweenGet == 3 then
            PositionOrbit = CFrame.new(40, 40, 0)
        elseif TweenGet == 4 then
            PositionOrbit = CFrame.new(0, 40, 40)
        elseif TweenGet == 5 then
            PositionOrbit = CFrame.new(0, 40, -40)
        end
    end
end)
spawn(function()
while task.wait() do
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Stun") then
game.Players.LocalPlayer.Character.Stun.Value = 0
end
end
end)

function EquipTool(Name)
    if game.Players.LocalPlayer.Backpack:FindFirstChild(Name) then
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild(Name))
    end
end

function FindEnemiesInRange(GetTab, Mods, Distance)
    local HeadMods = nil
    for i, v in ipairs(Mods) do
        if not v:GetAttribute("IsBoat") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            if v:FindFirstChild("Head") and ((game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()):GetPivot().Position - v["Head"].Position).Magnitude <= Distance or 60 then
                if v ~= game.Players.LocalPlayer.Character then
                    table.insert(GetTab, {v, v:FindFirstChild("Head")})
                    HeadMods = v:FindFirstChild("Head")
                end
            end
        end
    end
    for i, v in ipairs(game.Players:GetPlayers()) do
        if v.Character and v ~= game.Players.LocalPlayer then
            if v.Character:FindFirstChild("Head") and ((game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()):GetPivot().Position - v.Character["Head"].Position).Magnitude <= Distance or 60 then
                table.insert(GetTab, {v.Character, v.Character:FindFirstChild("Head")})
                HeadMods = v.Character:FindFirstChild("Head")
            end
        end
    end
    return HeadMods
end

local bypass;
    bypass = hookmetamethod(game, "__index", newcclosure(function(method, Key) 
        if tostring(method) == "Humanoid" and tostring(Key) == "WalkSpeed" and tostring(Key) == "JumpPower" then
            return Key
        end
        return bypass(method, Key)
   end))

function GetEquippedTool()
    if not game.Players.LocalPlayer.Character then
        return nil
    end
    for i, v in ipairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:IsA("Tool") then
            return v
        end
    end
    return nil
end

function EquipTool(Name)
    if game.Players.LocalPlayer.Backpack:FindFirstChild(Name) then
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild(Name))
    end
end

function AttackNoCoolDown()
    local Tablet = {}
    local FindEnemies = FindEnemiesInRange(Tablet, game:GetService("Workspace").Enemies:GetChildren(), 60, "Head", true)
    if not FindEnemies then
        return
    end
    local Tool = GetEquippedTool()
    if not Tool then
        return
    end
   if #Tablet > 0 then
   game:GetService("ReplicatedStorage").Modules.Net:WaitForChild("RE/RegisterAttack"):FireServer(1e-9)
   game:GetService("ReplicatedStorage").Modules.Net:WaitForChild("RE/RegisterHit"):FireServer(FindEnemies, Tablet)
   else
   task.wait()
   end
end

function AttackNoCoolDown()
    local Tablet = {}
    local FindEnemies = FindEnemiesInRange(Tablet, game:GetService("Workspace").Enemies:GetChildren(), 60, "Head", true)
    if not FindEnemies then
        return
    end
    local Tool = GetEquippedTool()
    if not Tool then
        return
    end
   if #Tablet > 0 then
   game:GetService("ReplicatedStorage").Modules.Net:WaitForChild("RE/RegisterAttack"):FireServer(1e-9)
   game:GetService("ReplicatedStorage").Modules.Net:WaitForChild("RE/RegisterHit"):FireServer(FindEnemies, Tablet)
   else
   task.wait()
   end
end

function AutoHaki()
    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") == nil then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
    end
end

function Noclip(Toggle)
for i, v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
             if v:IsA("BasePart") then
               v.CanCollide = Toggle
            end
        end
end

if BloxFruitSea1 == true then
   _G.Boss = {
        "The Gorilla King",
        "Bobby",
        "Yeti",
        "Mob Leader",
        "Vice Admiral",
        "Warden",
        "Chief Warden",
        "Swan",
        "The Saw",
        "Magma Admiral",
        "Fishman Lord",
        "Wysper",
        "Thunder God",
        "Cyborg",
        "Saber Expert"
    }
elseif BloxFruitSea2 == true then
    _G.Boss = {
        "Diamond",
        "Jeremy",
        "Fajita",
        "Don Swan",
        "Smoke Admiral",
        "Cursed Captain",
        "Darkbeard",
        "Order",
        "Awakened Ice Admiral",
        "Tide Keeper"
    };
elseif BloxFruitSea3 == true then
    _G.Boss = {
        "Stone",
        "Hydra Leader",
        "Kilo Admiral",
        "Captain Elephant",
        "Beautiful Pirate",
        "rip_indra True Form",
        "Longma",
        "Soul Reaper",
        "Cake Queen"
    }
end
function CheckLevel()
local Level = game:GetService("Players").LocalPlayer.Data.Level.Value
if BloxFruitSea1 == true then
if Level <= 9 then
if tostring(game.Players.Team) == "Pirates" then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Bandit",
	["Tên nhiệm vụ"] = "BanditQuest1",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Bandit",
	["Nhiệm vụ cần đến"] = CFrame.new(1060, 16, 1547),
	["Chờ Mods Spawn"] = {CFrame.new(1038, 41, 1576)}
}
else
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Trainee",
	["Tên nhiệm vụ"] = "MarineQuest",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Trainee",
	["Nhiệm vụ cần đến"] = CFrame.new(-2708, 25, 2103),
	["Chờ Mods Spawn"] = {CFrame.new(-2754, 50, 2063)}
}
end
elseif Level <= 14 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Monkey",
	["Tên nhiệm vụ"] = "JungleQuest",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Monkey",
	["Nhiệm vụ cần đến"] = CFrame.new(-1601, 36, 153),
	["Chờ Mods Spawn"] = {CFrame.new(-1448, 50, 63)}
}
elseif Level <= 29 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Gorilla",
	["Tên nhiệm vụ"] = "JungleQuest",
	["Nhiệm vụ cấp"] = 2,
	["Tên thật mobs"] = "Gorilla",
	["Nhiệm vụ cần đến"] = CFrame.new(-1601, 36, 153),
	["Chờ Mods Spawn"] = {CFrame.new(-1142, 40, -515)}
}
elseif Level <= 39 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Pirate",
	["Tên nhiệm vụ"] = "BuggyQuest1",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Pirate",
	["Nhiệm vụ cần đến"] = CFrame.new(-1140, 4, 3827),
	["Chờ Mods Spawn"] = {CFrame.new(-1201, 40, 3857)}
}
elseif Level <= 59 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Brute",
	["Tên nhiệm vụ"] = "BuggyQuest1",
	["Nhiệm vụ cấp"] = 2,
	["Tên thật mobs"] = "Brute",
	["Nhiệm vụ cần đến"] = CFrame.new(-1140, 4, 3827),
	["Chờ Mods Spawn"] = {CFrame.new(-1387, 24, 4100)}
}
elseif Level <= 74 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Desert Bandit",
	["Tên nhiệm vụ"] = "DesertQuest",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Desert Bandit",
	["Nhiệm vụ cần đến"] = CFrame.new(896, 6, 4390),
	["Chờ Mods Spawn"] = {CFrame.new(984, 16, 4417)}
}
elseif Level <= 89 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Desert Officer",
	["Tên nhiệm vụ"] = "DesertQuest",
	["Nhiệm vụ cấp"] = 2,
	["Tên thật mobs"] = "Desert Officer",
	["Nhiệm vụ cần đến"] = CFrame.new(896, 6, 4390),
	["Chờ Mods Spawn"] = {CFrame.new(1547, 14, 4381)}
}
elseif Level <= 99 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Snow Bandit",
	["Tên nhiệm vụ"] = "SnowQuest",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Snow Bandit",
	["Nhiệm vụ cần đến"] = CFrame.new(1384, 87, -1295),
	["Chờ Mods Spawn"] = {CFrame.new(1356, 105, -1328)}
}
elseif Level <= 119 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Snowman",
	["Tên nhiệm vụ"] = "SnowQuest",
	["Nhiệm vụ cấp"] = 2,
	["Tên thật mobs"] = "Snowman",
	["Nhiệm vụ cần đến"] = CFrame.new(1384, 87, -1295),
	["Chờ Mods Spawn"] = {CFrame.new(1356, 105, - 1328)}
}
elseif Level <= 149 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Chief Petty Officer",
	["Tên nhiệm vụ"] = "MarineQuest2",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Chief Petty Officer",
	["Nhiệm vụ cần đến"] = CFrame.new(-5035, 28, 4324),
	["Chờ Mods Spawn"] = {CFrame.new(-4931, 65, 4121)}
}
elseif Level <= 174 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Sky Bandit",
	["Tên nhiệm vụ"] = "SkyQuest",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Sky Bandit",
	["Nhiệm vụ cần đến"] = CFrame.new(-4842, 717, -2623),
	["Chờ Mods Spawn"] = {CFrame.new(-4955, 365, -2908)}
}
elseif Level <= 189 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Dark Master",
	["Tên nhiệm vụ"] = "SkyQuest",
	["Nhiệm vụ cấp"] = 2,
	["Tên thật mobs"] = "Dark Master",
	["Nhiệm vụ cần đến"] = CFrame.new(-4842, 717, -2623),
	["Chờ Mods Spawn"] = {CFrame.new(-5148, 439, -2332)}
}
elseif Level <= 209 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Prisoner",
	["Tên nhiệm vụ"] = "PrisonerQuest",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Prisoner",
	["Nhiệm vụ cần đến"] = CFrame.new(5310, 0, 474, 0, 0, 0, 0, 1, 0, -0, 0, 0),
	["Chờ Mods Spawn"] = {CFrame.new(4937, 0, 649, 0, 0, -0, 0, 1, 0, 0, 0, 0)}
}
elseif Level <= 249 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Dangerous Prisoner",
	["Tên nhiệm vụ"] = "PrisonerQuest",
	["Nhiệm vụ cấp"] = 2,
	["Tên thật mobs"] = "Dangerous Prisoner",
	["Nhiệm vụ cần đến"] = CFrame.new(5310, 0, 474, 0, 0, 0, 0, 1, 0, -0, 0, 0),
	["Chờ Mods Spawn"] = {CFrame.new(-1537, 30, -3178), CFrame.new(-1366, 30, -3468), CFrame.new(-1126, 30, -3296)}
}
elseif Level <= 274 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Toga Warrior",
	["Tên nhiệm vụ"] = "ColosseumQuest",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Toga Warrior",
	["Nhiệm vụ cần đến"] = CFrame.new(-1577, 7, -2984),
	["Chờ Mods Spawn"] = {CFrame.new(-1872, 49, -2913)}
}
elseif Level <= 299 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Gladiator",
	["Tên nhiệm vụ"] = "ColosseumQuest",
	["Nhiệm vụ cấp"] = 2,
	["Tên thật mobs"] = "Gladiator",
	["Nhiệm vụ cần đến"] = CFrame.new(-1577, 7, -2984),
	["Chờ Mods Spawn"] = {CFrame.new(-1537, 30, -3178), CFrame.new(-1366, 30, -3468), CFrame.new(-1126, 30, -3296)}
}
elseif Level <= 324 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Military Soldier",
	["Tên nhiệm vụ"] = "MagmaQuest",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Military Soldier",
	["Nhiệm vụ cần đến"] = CFrame.new(-5316, 12, 8517),
	["Chờ Mods Spawn"] = {CFrame.new(-5369, 61, 8556)}
}
elseif Level <= 374 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Military Spy",
	["Tên nhiệm vụ"] = "MagmaQuest",
	["Nhiệm vụ cấp"] = 2,
	["Tên thật mobs"] = "Military Spy",
	["Nhiệm vụ cần đến"] = CFrame.new(-5316, 12, 8517),
	["Chờ Mods Spawn"] = {CFrame.new(-5787, 75, 8651, 0, 0, -0, 0, 1, 0, 0, 0, 0)}
}
elseif Level <= 399 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Fishman Warrior",
	["Tên nhiệm vụ"] = "FishmanQuest",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Military Spy",
	["Nhiệm vụ cần đến"] = CFrame.new(61122, 18, 1569),
	["Chờ Mods Spawn"] = {CFrame.new(60844, 98, 1298)}
}
elseif Level <= 449 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Fishman Command",
	["Tên nhiệm vụ"] = "FishmanQuest",
	["Nhiệm vụ cấp"] = 2,
	["Tên thật mobs"] = "Fishman Command",
	["Nhiệm vụ cần đến"] = CFrame.new(61122, 18, 1569),
	["Chờ Mods Spawn"] = {CFrame.new(61738, 64, 1433)}
}
if _G.SettingToggle["AutoFarm Level"] == true and (_G.Quest["Chờ Mods Spawn"].Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163, 11, 1819))
end
elseif Level <= 474 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "God's Guard",
	["Tên nhiệm vụ"] = "SkyExp1Quest",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "God's Guard",
	["Nhiệm vụ cần đến"] = CFrame.new(-4721, 845, -1953),
	["Chờ Mods Spawn"] = {CFrame.new(-4628, 866, -1931)}
}
if _G.SettingToggle["AutoFarm Level"] == true and (_G.Quest["Chờ Mods Spawn"].Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-4607, 872, -1667))
end
elseif Level <= 524 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Shanda",
	["Tên nhiệm vụ"] = "SkyExp1Quest",
	["Nhiệm vụ cấp"] = 2,
	["Tên thật mobs"] = "Shanda",
	["Nhiệm vụ cần đến"] = CFrame.new(-7863, 5545, -378),
	["Chờ Mods Spawn"] = {CFrame.new(-7685, 5601, -441)}
}
if _G.SettingToggle["AutoFarm Level"] == true and (_G.Quest["Chờ Mods Spawn"].Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-7894, 5547, -380))
end
elseif Level <= 549 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Royal Squad",
	["Tên nhiệm vụ"] = "SkyExp2Quest",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Royal Squad",
	["Nhiệm vụ cần đến"] = CFrame.new(-7903, 5635, -1410),
	["Chờ Mods Spawn"] = {CFrame.new(-7654, 5637, -1407)}
}
elseif Level <= 624 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Royal Soldier",
	["Tên nhiệm vụ"] = "SkyExp2Quest",
	["Nhiệm vụ cấp"] = 2,
	["Tên thật mobs"] = "Royal Soldier",
	["Nhiệm vụ cần đến"] = CFrame.new(-7903, 5635, -1410),
	["Chờ Mods Spawn"] = {CFrame.new(-7760, 5679, -1884)}
}
elseif Level <= 649 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Galley Pirate",
	["Tên nhiệm vụ"] = "FountainQuest",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Galley Pirate",
	["Nhiệm vụ cần đến"] = CFrame.new(5258, 38, 4050),
	["Chờ Mods Spawn"] = {CFrame.new(5557, 152, 3998)}
}
elseif Level <= 649 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Galley Pirate",
	["Tên nhiệm vụ"] = "FountainQuest",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Galley Pirate",
	["Nhiệm vụ cần đến"] = CFrame.new(5258, 38, 4050),
	["Chờ Mods Spawn"] = {CFrame.new(5557, 152, 3998)}
}
elseif Level <= 650 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Galley Captain",
	["Tên nhiệm vụ"] = "FountainQuest",
	["Nhiệm vụ cấp"] = 2,
	["Tên thật mobs"] = "Galley Captain",
	["Nhiệm vụ cần đến"] = CFrame.new(5258, 38, 4050),
	["Chờ Mods Spawn"] = {CFrame.new(5677, 92, 4966)}
}
elseif Level >= 700 then
Toggles["AutoFarm Level"]:SetValue(false)
wait(3)
Toggles["Auto Sea 2"]:SetValue(false)
end
elseif BloxFruitSea2 == true then
if Level <= 725 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Raider",
	["Tên nhiệm vụ"] = "Area1Quest",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Raider",
	["Nhiệm vụ cần đến"] = CFrame.new(-427, 72, 1835),
	["Chờ Mods Spawn"] = {CFrame.new(68, 93, 2429)}
}
elseif Level <= 774 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Mercenary",
	["Tên nhiệm vụ"] = "Area1Quest",
	["Nhiệm vụ cấp"] = 2,
	["Tên thật mobs"] = "Mercenary",
	["Nhiệm vụ cần đến"] = CFrame.new(-427, 72, 1835),
	["Chờ Mods Spawn"] = {CFrame.new(-864, 122, 1453)}
}
elseif Level <= 799 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Swan Pirate",
	["Tên nhiệm vụ"] = "Area2Quest",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Swan Pirate",
	["Nhiệm vụ cần đến"] = CFrame.new(635, 73, 917),
	["Chờ Mods Spawn"] = {CFrame.new(1065, 137, 1324)}
}
elseif Level <= 874 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Factory Staff",
	["Tên nhiệm vụ"] = "Area2Quest",
	["Nhiệm vụ cấp"] = 2,
	["Tên thật mobs"] = "Factory Staff",
	["Nhiệm vụ cần đến"] = CFrame.new(635, 73, 917),
	["Chờ Mods Spawn"] = {CFrame.new(533, 128, 355)}
}
elseif Level <= 899 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Marine Lieutenant",
	["Tên nhiệm vụ"] = "MarineQuest3",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Marine Lieutenant",
	["Nhiệm vụ cần đến"] = CFrame.new(-2440, 73, -3217),
	["Chờ Mods Spawn"] = {CFrame.new(-2489, 84, -3151)}
}
elseif Level <= 949 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Marine Captain",
	["Tên nhiệm vụ"] = "MarineQuest3",
	["Nhiệm vụ cấp"] = 2,
	["Tên thật mobs"] = "Marine Captain",
	["Nhiệm vụ cần đến"] = CFrame.new(-2440, 73, -3217),
	["Chờ Mods Spawn"] = {CFrame.new(-2335, 79, -3245)}
}
elseif Level <= 974 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Zombie",
	["Tên nhiệm vụ"] = "ZombieQuest",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Zombie",
	["Nhiệm vụ cần đến"] = CFrame.new(-5494, 48, -794),
	["Chờ Mods Spawn"] = {CFrame.new(-5536, 101, -835)}
}
elseif Level <= 999 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Zombie",
	["Tên nhiệm vụ"] = "ZombieQuest",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Zombie",
	["Nhiệm vụ cần đến"] = CFrame.new(-5494, 48, -794),
	["Chờ Mods Spawn"] = {CFrame.new(-5536, 101, -835)}
}
elseif Level <= 1049 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Snow Trooper",
	["Tên nhiệm vụ"] = "SnowMountainQuest",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Snow Trooper",
	["Nhiệm vụ cần đến"] = CFrame.new(607, 401, -5370),
	["Chờ Mods Spawn"] = {CFrame.new(535, 432, -5484)}
}
elseif Level <= 1099 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Winter Warrior",
	["Tên nhiệm vụ"] = "SnowMountainQuest",
	["Nhiệm vụ cấp"] = 2,
	["Tên thật mobs"] = "Winter Warrior",
	["Nhiệm vụ cần đến"] = CFrame.new(607, 401, -5370),
	["Chờ Mods Spawn"] = {CFrame.new(1234, 456, -5174)}
}
elseif Level <= 1124 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Lab Subordinate",
	["Tên nhiệm vụ"] = "IceSideQuest",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Lab Subordinate",
	["Nhiệm vụ cần đến"] = CFrame.new(-6061, 15, -4902),
	["Chờ Mods Spawn"] = {CFrame.new(-5720, 63, -4784)}
}
elseif Level <= 1174 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Horned Warrior",
	["Tên nhiệm vụ"] = "IceSideQuest",
	["Nhiệm vụ cấp"] = 2,
	["Tên thật mobs"] = "Horned Warrior",
	["Nhiệm vụ cần đến"] = CFrame.new(-6061, 15, -4902),
	["Chờ Mods Spawn"] = {CFrame.new(-6292, 91, -5502)}
}
elseif Level <= 1199 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Magma Ninja",
	["Tên nhiệm vụ"] = "FireSideQuest",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Magma Ninja",
	["Nhiệm vụ cần đến"] = CFrame.new(-5429, 15, -5297),
	["Chờ Mods Spawn"] = {CFrame.new(-5461, 130, -5836)}
}
elseif Level <= 1249 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Lava Pirate",
	["Tên nhiệm vụ"] = "FireSideQuest",
	["Nhiệm vụ cấp"] = 2,
	["Tên thật mobs"] = "Lava Pirate",
	["Nhiệm vụ cần đến"] = CFrame.new(-5429, 15, -5297),
	["Chờ Mods Spawn"] = {CFrame.new(-5251, 55, -4774)}
}
end
elseif BloxFruitSea3 == true then

end
end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/Library/LinoriaLib/Source.lua"))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/Library/LinoriaLib/addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/Library/LinoriaLib/addons/SaveManager.lua"))()
local Options = getgenv().Linoria.Options
local Toggles = getgenv().Linoria.Toggles

function Notification(Message, Time)
if _G.ChooseNotify == "LinoriaLib" then
Library:Notify(Message, Time or 5)
elseif _G.ChooseNotify == "Roblox" then
game:GetService("StarterGui"):SetCore("SendNotification",{Title = "Error",Text = Message,Icon = "rbxassetid://7733658504",Duration = Time or 5})
end
if _G.NotificationSound then
        local sound = Instance.new("Sound", workspace)
            sound.SoundId = "rbxassetid://4590662766"
            sound.Volume = _G.VolumeTime or 2
            sound.PlayOnRemove = true
            sound:Destroy()
        end
    end

_G.SettingToggle = {
	["AutoFarm Level"] = false,
	["AutoFarm Bone"] = false,
	["Auto Farm Chest"] = false,
	["Attack Aura"] = false,
	["Tween Fruit"] = false,
	["Auto View Player"] = false,
	["Auto Tween Player"] = false,
	["Auto Pvp"] = false,
	["Auto Random Fruit"] = false,
	["Auto Tween Fruit"] = false,
	["Auto Store Fruit"] = false,
	["Auto Sea 2"] = false,
	["Random Bone"] = false,
	["Kill Core"] = false,
	----------------------------------------------
	["Tool Attack"] = "Melee",
	["Tween Choose"] = "Normal",
	-----------------------------------------------
	["Walk Water"] = true,
	["Auto Haki"] = true,
	-----------------------------------------------
	["Speed Tween"] = 300,
	-----------------------------------------------
	["Event"] = {
		["Saber"] = false,
		["PoleV1"] = false,
		["Yama"] = false,
		["HakiColor"] = false
	},
	["Sea"] = {
		["SpeedBoat"] = false,
		["Speed"] = 200,
		["Auto Farm Sea"] = false,
		["BoatNoclip"] = false,
		["SeaLevel"] = false,
		["Level"] = 2,
		---------------------------
		["Terrorshark"] = false,
		["Shark"] = false,
	},
	["Esp"] = {
		["Player"] = false,
		["Boat"] = false,
		["Mods"] = false,
		["Fruit"] = false,
		["Island"] = false,
		["Flower"] = false,
	},
	["Auto Stats"] = {
		["Start State"] = {
			["Melee"] = false,
	    	["Sword"] = false,
	    	["Gun"] = false,
	    	["Blox Fruit"] = false,
    		["Defense"] = false
        },
		["Melee"] = 1,
		["Sword"] = 1,
		["Gun"] = 1,
		["Blox Fruit"] = 1,
		["Defense"] = 1,
	},
	["AutoFarm Boss"] = {
		["Boss"] = "Nah",
		["Auto"] = false
	},
	["Chip Fruit"] = {
		["ChipBuy"] = "Light",
		["Auto Buy Chip"] = false,
		["Started"] = false,
		["Auto Raid"] = false
	},
	["Remove"] = {
		["Notify"] = false,
		["Dame"] = false
	},
	["BringMods"] = {
		["BringGet"] = true,
        ["Distance"] = 250
    }
}

local Window = Library:CreateWindow({
    Title = "Omega X Article Hub - Blox Fruit",
    Center = true,
    AutoShow = true,
    Resizable = true,
    AutoLock = true,
    ShowCustomCursor = true,
    NotifySide = "Right",
    TabPadding = 2,
    MenuFadeTime = 0
})
    
function Notification(Message, Time)
if _G.ChooseNotify == "LinoriaLib" then
Library:Notify(Message, Time or 5)
elseif _G.ChooseNotify == "Roblox" then
game:GetService("StarterGui"):SetCore("SendNotification",{Title = "Error",Text = Message,Icon = "rbxassetid://7733658504",Duration = Time or 5})
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
	Tab = Window:AddTab("Main", "rbxassetid://7734053426"),
	Tab1 = Window:AddTab("Sea", "rbxassetid://10747376931"),
	Tab2 = Window:AddTab("Fruit", "rbxassetid://10709790875"),
	Tab3 = Window:AddTab("State", "rbxassetid://10709790875"),
	Tab4 = Window:AddTab("Shop", "rbxassetid://7734056747"),
	Tab5 = Window:AddTab("Event", "rbxassetid://7734056747"),
	Tab8 = Window:AddTab("Misc", "rbxassetid://4370318685"),
	["UI Settings"] = Window:AddTab("UI Settings", "rbxassetid://7733955511")
}

local Main1Group = Tabs.Tab:AddLeftGroupbox("Auto Farm")

Main1Group:AddDropdown("ToolChoose", {
    Title = "Weapons",
    Values = {"Melee", "Sword", "Blox Fruit"},
    Default = 1,
    Multi = false,
    Callback = function(Value)
_G.SettingToggle["Tool Attack"] = Value
    end
})
spawn(function()
while task.wait() do
if _G.SettingToggle["Tool Attack"] == "Melee" then
   for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
      if v.ToolTip == "Melee" then
          if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
             _G.ToolAttack = v.Name
          end
      end
  end
elseif _G.SettingToggle["Tool Attack"] == "Sword" then
for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
   if v.ToolTip == "Sword" then
       if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
          _G.ToolAttack = v.Name
        end
    end
end
elseif _G.SettingToggle["Tool Attack"] == "Blox Fruit" then
for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
   if v.ToolTip == "Blox Fruit" then
       if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
          _G.ToolAttack = v.Name
       end
   end
end
end
end
end)

Main1Group:AddToggle("AutoFarmLevel", {
    Text = "AutoFarm Level",
    Default = false,
    Tooltip = "Tự Động Farm Cấp",
    Callback = function(Value)
        _G.SettingToggle["AutoFarm Level"] = Value
        if Value == false then
            CancelTween()
            Noclip(true)
        end
while _G.SettingToggle["AutoFarm Level"] do
CheckLevel()
Noclip(false)
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
if not string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, _G.Quest["Nhiệm vụ con mobs"]) or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false then
   game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
   TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, _G.Quest["Nhiệm vụ cần đến"], true, (_G.Quest["Nhiệm vụ cần đến"].Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
if (_G.Quest["Nhiệm vụ cần đến"].Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", _G.Quest["Tên nhiệm vụ"], _G.Quest["Nhiệm vụ cấp"])
end
elseif string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, _G.Quest["Nhiệm vụ con mobs"]) or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
task.spawn(function()
if game:GetService("Workspace").Enemies:FindFirstChild(_G.Quest["Nhiệm vụ con mobs"]) == nil then
for i, v in pairs(_G.Quest["Chờ Mods Spawn"]) do
TweenTp(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, v, true, (v.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
end
end
end)
for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
if _G.SettingToggle["AutoFarm Level"] == true and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
if v.Name == (_G.Quest["Nhiệm vụ con mobs"]) then
repeat task.wait()
AutoHaki()
EquipTool(_G.ToolAttack)
BringMobs = true
if _G.SettingToggle["Attack Aura"] == false then
AttackNoCoolDown()
end
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
if _G.SettingToggle["Tween Choose"] == "Normal" then
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, (v.HumanoidRootPart.CFrame * CFrame.new(0, 40, 0)), true, (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
elseif _G.SettingToggle["Tween Choose"] == "Orbit" then
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, (v.HumanoidRootPart.CFrame * PositionOrbit), true, (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
end
end
v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
v.HumanoidRootPart.CanCollide = false
v.Humanoid.JumpPower = 0
v.Humanoid.WalkSpeed = 0
FarmPos = v.HumanoidRootPart.CFrame
ModsFarm = v.Name
until _G.SettingToggle["AutoFarm Level"] == false or v.Parent == nil or v.Humanoid.Health <= 0 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name) or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
BringMobs = false
FarmPos = nil
ModsFarm = nil
end
end
end
end
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
for i, v in pairs(game:GetService("Workspace")["_WorldOrigin"].EnemySpawns:GetChildren()) do
if string.find(v.Name, _G.Quest["Tên thật mobs"]) and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude >= 10 then
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, (v.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0)), true, (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
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
if BloxFruitSea3 == true then
Main1Group:AddToggle("AutoFarmBone", {
    Text = "AutoFarm Bone",
    Default = false,
    Tooltip = "Tự Động Farm Xương",
    Callback = function(Value)
        _G.SettingToggle["AutoFarm Bone"] = Value
        if Value == false then
            CancelTween()
            Noclip(true)
        end
while _G.SettingToggle["AutoFarm Bone"] do
Noclip(false)
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, CFrame.new(-9515, 174, 6079), true, (Vector3.new(-9515, 174, 6079) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
if (Vector3.new(-9515, 174, 6079) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 then
end
for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
if _G.SettingToggle["AutoFarm Bone"] == true and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
if v.Name == "Reborn Skeleton" or v.Name == "Living Zombie" or v.Name == "Demonic Soul" or v.Name == "Posessed Mummy" then
repeat task.wait()
AutoHaki()
EquipTool(_G.ToolAttack)
BringMobs = true
if _G.SettingToggle["Attack Aura"] == false then
AttackNoCoolDown()
end
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, (v.HumanoidRootPart.CFrame * CFrame.new(0, 40, 0)), true, (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
v.HumanoidRootPart.CanCollide = false
v.Humanoid.JumpPower = 0
v.Humanoid.WalkSpeed = 0
FarmPos = v.HumanoidRootPart.CFrame
ModsFarm = v.Name
until _G.SettingToggle["AutoFarm Bone"] == false or v.Parent == nil or v.Humanoid.Health <= 0
BringMobs = false
FarmPos = nil
ModsFarm = nil
end
end
end
task.wait()
end
    end
})

Main1Group:AddButton({
    Text = "Pray",
    Tooltip = "Cầu Nguyện",
    Func = function()
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent", 1)
    end
}):AddButton({
    Text = "Try Your Luck",
    Tooltip = "Thử Vận May",
    Func = function()
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent", 2)
    end
})

Main1Group:AddToggle("Auto Random Bone", {
    Text = "Auto Random Bone",
    Default = false,
    Tooltip = "Tự Động Mua Ngẫu Nhiên Xương",
    Callback = function(Value)
        _G.SettingToggle["Random Bone"] = Value
while _G.SettingToggle["Random Bone"] do
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)
task.wait()
end
    end
})
end

Main1Group:AddDropdown("Boss", {
    Title = "Boss",
    Values = _G.Boss,
    Default = 1,
    Multi = false,
    Callback = function(Value)
_G.SettingToggle["AutoFarm Boss"]["Boss"] = Value
    end
})

Main1Group:AddToggle("AutoFarmBoss", {
    Text = "AutoFarm Boss",
    Default = false,
    Tooltip = "Tự Động Farm Trùm",
    Callback = function(Value)
        _G.SettingToggle["AutoFarm Boss"]["Auto"] = Value
        if Value == false then
            CancelTween()
            Noclip(true)
        end
while _G.SettingToggle["AutoFarm Boss"]["Auto"] do
Noclip(false)
for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
if _G.SettingToggle["AutoFarm Boss"]["Auto"] == true and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
if v.Name == (_G.SettingToggle["AutoFarm Boss"]["Boss"]) then
repeat task.wait()
AutoHaki()
EquipTool(_G.ToolAttack)
if _G.SettingToggle["Attack Aura"] == false then
AttackNoCoolDown()
end
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, (v.HumanoidRootPart.CFrame * CFrame.new(0, 40, 0)), true, (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
v.HumanoidRootPart.CanCollide = false
v.Humanoid.JumpPower = 0
v.Humanoid.WalkSpeed = 0
sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
until _G.SettingToggle["AutoFarm Boss"]["Auto"] == false or v.Parent == nil or v.Humanoid.Health <= 0
end
end
end
task.wait()
end
    end
})

local Main3Group = Tabs.Tab:AddLeftGroupbox("Auto Farm 2")

Main3Group:AddToggle("Auto Farm Chest", {
    Text = "Auto Farm Chest",
    Default = false,
    Tooltip = "Tự Động Lụm Rương",
    Callback = function(Value)
_G.SettingToggle["Auto Farm Chest"] = Value
if Value == false then
            CancelTween()
            Noclip(true)
     end
while _G.SettingToggle["Auto Farm Chest"] do
Noclip(false)
local Nah, Win = math.huge
for i = 1, #game:GetService("CollectionService"):GetTagged("_ChestTagged") do
local ChestTp = game:GetService("CollectionService"):GetTagged("_ChestTagged")[i]
local ChestReal = (ChestTp:GetPivot().Position - game:GetService("Players").LocalPlayer.Character:GetPivot().Position).Magnitude
if ChestTp:GetAttribute("IsDisabled") == nil and (ChestReal < Nah) then
Nah, Win = ChestReal, ChestTp
end
end
if Win then
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, CFrame.new(Win:GetPivot().Position), true, (Win:GetPivot().Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
end
end
task.wait()
end
    end
})

local Main2Group = Tabs.Tab:AddRightGroupbox("Auto Sea / Join")

Main2Group:AddToggle("Auto Sea 2", {
    Text = "Auto Sea 2",
    Default = false,
    Tooltip = "Tự Động Làm Biển 2",
    Callback = function(Value)
_G.SettingToggle["Auto Sea 2"] = Value
if Value == false then
            CancelTween()
            Noclip(true)
        end
while _G.SettingToggle["Auto Sea 2"] do
Noclip(false)
if game:GetService("Players").LocalPlayer.Data.Level.Value >= 700 then
if game:GetService("Workspace").Map.Ice.Door.CanCollide == false and game:GetService("Workspace").Map.Ice.Door.Transparency == 1 then
repeat wait()
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, CFrame.new(4849, 5, 719), true, (Vector3.new(4849, 5, 719) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
until (Vector3.new(4849, 5, 719) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or _G.SettingToggle["Auto Sea 2"] == false
wait(1.1)
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Detective")
wait(0.5)
EquipTool("Key")
repeat wait()
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, CFrame.new(1347, 37, -1325), true, (Vector3.new(1347, 37, -1325) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
until (Vector3.new(1347, 37, -1325) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or (_G.Auto_Sea2 == false)
wait(0.5)
elseif game:GetService("Workspace").Map.Ice.Door.CanCollide == false and game:GetService("Workspace").Map.Ice.Door.Transparency == 1 then
if game:GetService("Workspace").Enemies:FindFirstChild("Ice Admiral") then
for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
if v.Name == "Ice Admiral" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
local OldCFrameBoss = v.HumanoidRootPart.CFrame
repeat task.wait()
AutoHaki()
EquipTool(_G.ToolAttack)
if _G.SettingToggle["Attack Aura"] == false then
AttackNoCoolDown()
end
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, (v.HumanoidRootPart.CFrame * CFrame.new(0, 40, 0)), true, (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
v.HumanoidRootPart.CanCollide = false
v.HumanoidRootPart.CFrame = OldCFrameBoss
v.Humanoid.JumpPower = 0
v.Humanoid.WalkSpeed = 0
sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
until _G.SettingToggle["Auto Sea 2"] == false or v.Parent == nil or v.Humanoid.Health <= 0
end
end
end
end
end
task.wait()
end
    end
})

Sea1Group = Tabs.Tab1:AddLeftGroupbox("Sea")

Sea1Group:AddSlider("Speed Boat", {
    Text = "Speed Boat",
    Default = 350,
    Min = 100,
    Max = 400,
    Rounding = 0,
    Compact = true,
    Callback = function(Value)
_G.SettingToggle["Sea"]["Speed"] = Value
    end
})

Sea1Group:AddToggle("Speed", {
    Text = "Speed Boat",
    Default = false,
    Tooltip = "Tốc độ Thuyền",
    Callback = function(Value)
_G.SettingToggle["Sea"]["SpeedBoat"] = Value
while _G.SettingToggle["Sea"]["SpeedBoat"] do
for i, v in pairs(game:GetService("Workspace").Boats:GetChildren()) do
if v:FindFirstChild("VehicleSeat") and v:FindFirstChild("VehicleSeat").Occupant == game.Players.LocalPlayer.Character.Humanoid then
Boat = v:FindFirstChild("VehicleSeat")
Boat.MaxSpeed = _G.SettingToggle["Sea"]["Speed"]
Boat.CFrame = CFrame.new(Vector3.new(Boat.Position.X, Boat.Position.Y, Boat.Position.Z)) * Boat.CFrame.Rotation
end
end
task.wait()
end
    end
})

Sea1Group:AddToggle("NoclipBoat", {
    Text = "Boat Noclip",
    Default = false,
    Tooltip = "Thuyền đi xuyên tường",
    Callback = function(Value)
_G.SettingToggle["Sea"]["BoatNoclip"] = Value
if Value == false then
            Noclip(true)
            for i, v in pairs(game:GetService("Workspace").Boats:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = true
            end
        end
        end
while _G.SettingToggle["Sea"]["BoatNoclip"] do
Noclip(false)
for i, v in pairs(game:GetService("Workspace").Boats:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
task.wait()
end
    end
})
if BloxFruitSea3 == true then
Sea1Group:AddDropdown("Level", {
    Title = "Level Sea",
    Values = {"1", "2", "3", "4", "5", "6", "inf"},
    Default = "inf",
    Callback = function(Value)
         _G.SettingToggle["Sea"]["Level"] = Value
if _G.SettingToggle["Sea"]["Level"] == "1" then
_G.Level = -22000
elseif _G.SettingToggle["Sea"]["Level"] == "2" then
_G.Level = -26000
elseif _G.SettingToggle["Sea"]["Level"] == "3" then
_G.Level = -30000
elseif _G.SettingToggle["Sea"]["Level"] == "4" then
_G.Level = -34000
elseif _G.SettingToggle["Sea"]["Level"] == "5" then
_G.Level = -38000
elseif _G.SettingToggle["Sea"]["Level"] == "6" then
_G.Level = -42700
elseif _G.SettingToggle["Sea"]["Level"] == "inf" then
_G.Level = -100000000
end
if _G.SettingToggle["Sea"]["SeaLevel"] == true then
Toggles["Tween Boat"]:SetValue(false)
wait(1)
Toggles["Tween Boat"]:SetValue(true)
end
    end
})

Sea1Group:AddToggle("TerrorsharkKill", {
    Text = "Auto Kill Terrorshark",
    Default = false,
    Tooltip = "Giết Cá Mập",
    Callback = function(Value)
_G.SettingToggle["Sea"]["Terrorshark"] = Value
if Value == false then
Noclip(true)
CancelTween()
end
while _G.SettingToggle["Sea"]["Terrorshark"] do
Noclip(false)
if game:GetService("Workspace").Enemies:FindFirstChild("Terrorshark") then
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
for i, v in pairs(game:GetService("Workspace").Boats:GetChildren()) do
if v:FindFirstChild("VehicleSeat") and v:FindFirstChild("VehicleSeat").Occupant == game.Players.LocalPlayer.Character.Humanoid then
game.Players.LocalPlayer.Character.Humanoid.Sit = false
end
end
end
for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
if v.Name == "Terrorshark" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
repeat task.wait()
AutoHaki()
EquipTool(_G.ToolAttack)
if _G.SettingToggle["Attack Aura"] == false then
AttackNoCoolDown()
end
if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character.Humanoid.Health > 6000 then
if _G.SettingToggle["Tween Choose"] == "Normal" then
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, (v.HumanoidRootPart.CFrame * CFrame.new(0, 40, 0)), true, (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
elseif _G.SettingToggle["Tween Choose"] == "Orbit" then
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, (v.HumanoidRootPart.CFrame * PositionOrbit), true, (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
end
elseif game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character.Humanoid.Health < 6000 then
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, (v.HumanoidRootPart.CFrame * CFrame.new(0, 100, 0)), false, (v.HumanoidRootPart.CFrame - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
end
v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
v.HumanoidRootPart.WalkSpeed = 0
v.HumanoidRootPart.CanCollide = false
until _G.SettingToggle["Sea"]["Terrorshark"] == false or v.Humanoid.Health <= 0 or v.Parent == nil
end
end
elseif game:GetService("ReplicatedStorage"):FindFirstChild("Terrorshark") then
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, (game:GetService("ReplicatedStorage"):FindFirstChild("Terrorshark").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2)), true, (game:GetService("ReplicatedStorage"):FindFirstChild("Terrorshark").HumanoidRootPart.CFrame - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
end
task.wait()
end
    end
})

Sea1Group:AddToggle("SharkKill", {
    Text = "Auto Kill Shark",
    Default = false,
    Tooltip = "Giết Cá Con",
    Callback = function(Value)
_G.SettingToggle["Sea"]["Shark"] = Value
if Value == false then
Noclip(true)
CancelTween()
end
while _G.SettingToggle["Sea"]["Shark"] do
Noclip(false)
if _G.SettingToggle["Sea"]["Terrorshark"] == true and game:GetService("Workspace").Enemies:FindFirstChild("Terrorshark") then
return
end
if game:GetService("Workspace").Enemies:FindFirstChild("Terrorshark") then
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
for i, v in pairs(game:GetService("Workspace").Boats:GetChildren()) do
if v:FindFirstChild("VehicleSeat") and v:FindFirstChild("VehicleSeat").Occupant == game.Players.LocalPlayer.Character.Humanoid then
game.Players.LocalPlayer.Character.Humanoid.Sit = false
end
end
end
for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
if v.Name == "Shark" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
repeat task.wait()
AutoHaki()
EquipTool(_G.ToolAttack)
if _G.SettingToggle["Attack Aura"] == false then
AttackNoCoolDown()
end
if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character.Humanoid.Health > 6000 then
if _G.SettingToggle["Tween Choose"] == "Normal" then
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, (v.HumanoidRootPart.CFrame * CFrame.new(0, 40, 0)), true, (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
elseif _G.SettingToggle["Tween Choose"] == "Orbit" then
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, (v.HumanoidRootPart.CFrame * PositionOrbit), true, (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
end
elseif game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character.Humanoid.Health < 6000 then
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, (v.HumanoidRootPart.CFrame * CFrame.new(0, 100, 0)), false, (v.HumanoidRootPart.CFrame - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
end
v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
v.HumanoidRootPart.WalkSpeed = 0
v.HumanoidRootPart.CanCollide = false
until _G.SettingToggle["Sea"]["Shark"] == false or v.Humanoid.Health <= 0 or v.Parent == nil
end
end
end
task.wait()
end
    end
})

Sea1Group:AddToggle("Tween Boat", {
    Text = "Tween Sea Level",
    Default = false,
    Tooltip = "Đi Đến Biển Cấp Độ",
    Callback = function(Value)
_G.SettingToggle["Sea"]["SeaLevel"] = Value
if Value == false then
Noclip(true)
for i, v in pairs(game:GetService("Workspace").Boats:GetChildren()) do
if v:FindFirstChild("VehicleSeat") then
TweenTp(v:FindFirstChild("VehicleSeat"), v:FindFirstChild("VehicleSeat").CFrame, false, 0)
end
end
            for i, v in pairs(game:GetService("Workspace").Boats:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = true
            end
        end
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
for i, v in pairs(game:GetService("Workspace").Boats:GetChildren()) do
if v:FindFirstChild("VehicleSeat") and v:FindFirstChild("VehicleSeat").Occupant == game.Players.LocalPlayer.Character.Humanoid then
game.Players.LocalPlayer.Character.Humanoid.Sit = false
end
end
end
task.wait(0.1)
CancelTween()
end
while _G.SettingToggle["Sea"]["SeaLevel"] do
Noclip(false)
if _G.SettingToggle["Sea"]["Terrorshark"] == true and game:GetService("Workspace").Enemies:FindFirstChild("Terrorshark") then
return
end
if _G.SettingToggle["Sea"]["Shark"] == true and game:GetService("Workspace").Enemies:FindFirstChild("Shark") then
return
end
for i, v in pairs(game:GetService("Workspace").Boats:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
for i, v in pairs(game:GetService("Workspace").Boats:GetChildren()) do
if v:FindFirstChild("VehicleSeat") then
if v:FindFirstChild("Owner") and v.Owner.Value.Name == game.Players.LocalPlayer.Name or v:FindFirstChild("VehicleSeat").Occupant == game.Players.LocalPlayer.Character.Humanoid then
repeat task.wait() 
if _G.SettingToggle["Sea"]["SeaLevel"] == true and v:FindFirstChild("VehicleSeat").Occupant == game.Players.LocalPlayer.Character.Humanoid then
TweenTp(v:FindFirstChild("VehicleSeat"), CFrame.new(_G.Level, 21, 500), false, (Vector3.new(_G.Level, 21, 500) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
end
wait(0.2)
if _G.SettingToggle["Sea"]["SeaLevel"] == true and v:FindFirstChild("VehicleSeat").Occupant == game.Players.LocalPlayer.Character.Humanoid then
TweenTp(v:FindFirstChild("VehicleSeat"), CFrame.new(_G.Level - 3000, 21, 500), false, (Vector3.new(_G.Level - 3000, 21, 500) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
end
wait(0.2)
if _G.SettingToggle["Sea"]["SeaLevel"] == true and v:FindFirstChild("VehicleSeat").Occupant == game.Players.LocalPlayer.Character.Humanoid then
TweenTp(v:FindFirstChild("VehicleSeat"), CFrame.new(_G.Level - 3000, 21, 2000), false, (Vector3.new(_G.Level - 3000, 21, 2000) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
end
wait(0.2)
if _G.SettingToggle["Sea"]["SeaLevel"] == true and v:FindFirstChild("VehicleSeat").Occupant == game.Players.LocalPlayer.Character.Humanoid then
TweenTp(v:FindFirstChild("VehicleSeat"), CFrame.new(_G.Level, 21, -1000), false, (Vector3.new(_G.Level, 21, -1000) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
end
until _G.SettingToggle["Sea"]["SeaLevel"] == false or v:FindFirstChild("VehicleSeat").Occupant ~= game.Players.LocalPlayer.Character.Humanoid
TweenTp(v:FindFirstChild("VehicleSeat"), v:FindFirstChild("VehicleSeat").CFrame, false, 0)
repeat task.wait()
if v:FindFirstChild("Humanoid") and v.Humanoid.Value > 0 then
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, v:FindFirstChild("VehicleSeat").CFrame, true, (v:FindFirstChild("VehicleSeat").Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
end
until _G.SettingToggle["Sea"]["SeaLevel"] == false or v:FindFirstChild("VehicleSeat").Occupant == game.Players.LocalPlayer.Character.Humanoid or v:FindFirstChild("Humanoid") and v.Humanoid.Value <= 0
end
end
end
task.wait()
end
    end
})
end

local Fruit1Group = Tabs.Tab2:AddLeftGroupbox("Fruit")

Fruit1Group:AddToggle("Auto Random Fruit", {
    Text = "Auto Random Fruit",
    Default = false,
    Tooltip = "Tự Động Ngẫu Nhiên Trái",
    Callback = function(Value)
_G.SettingToggle["Auto Random Fruit"] = Value
while _G.SettingToggle["Auto Random Fruit"] do
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin", "Buy")
task.wait()
end
    end
})

Fruit1Group:AddToggle("Auto Tween Fruit", {
    Text = "Auto Tween Fruit",
    Default = false,
    Tooltip = "Tự Động Bay Dến Trái",
    Callback = function(Value)
_G.SettingToggle["Auto Tween Fruit"] = Value
 if Value == false then
            CancelTween()
            Noclip(true)
        end
while _G.SettingToggle["Auto Tween Fruit"] do
Noclip(false)
for i, v in pairs(game.Workspace:GetChildren()) do
                if string.find(v.Name, "Fruit") then
                    _G.Tween = false
                    TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Handle.CFrame, true, (v.Handle.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
                    _G.Tween = true
                end
            end
task.wait()
end
    end
})

Fruit1Group:AddToggle("Auto Stone Fruit", {
    Text = "Auto Store Fruit",
    Default = false,
    Tooltip = "Tự Động Lưu Trái",
    Callback = function(Value)
_G.SettingToggle["Auto Store Fruit"] = Value
while _G.SettingToggle["Auto Store Fruit"] do
for i, v in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
    if string.find(v.Name, "Fruit") then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", (v.Name:gsub(" Fruit", "").."-"..v.Name:gsub(" Fruit", "")), game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(v.Name))
    end
end
for i, v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
    if string.find(v.Name, "Fruit") then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", (v.Name:gsub(" Fruit", "").."-"..v.Name:gsub(" Fruit", "")), game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(v.Name))
    end
end
task.wait()
end
    end
})

Fruit2Group = Tabs.Tab2:AddRightGroupbox("Rain Fruit")
if BloxFruitSea2 == true or BloxFruitSea3 == true then
Fruit2Group:AddDropdown("Chip", {
    Title = "Choose Chip",
    Values = {"Flame", "Ice", "Quake", "Light", "Dark", "Spider", "Rumble", "Magma", "Buddha", "Sand", "Phoenix", "Dough"},
    Default = 1,
    Callback = function(Value)
         _G.SettingToggle["Chip Fruit"]["ChipBuy"] = Value
    end
})

Fruit2Group:AddToggle("Auto Buy Chip", {
    Text = "Auto Buy Chip",
    Default = false,
    Tooltip = "Tự Động Mua Chip",
    Callback = function(Value)
_G.SettingToggle["Chip Fruit"]["Auto Buy Chip"]  = Value
while _G.SettingToggle["Chip Fruit"]["Auto Buy Chip"] do
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.SettingToggle["Chip Fruit"]["ChipBuy"])
task.wait()
end
    end
})

Fruit2Group:AddToggle("Auto Started Chip", {
    Text = "Auto Started Chip",
    Default = false,
    Tooltip = "Tự Động Bắt Đầu Chip",
    Callback = function(Value)
_G.SettingToggle["Chip Fruit"]["Started"]  = Value
if Value == false then
            CancelTween()
            Noclip(true)
        end
while _G.SettingToggle["Chip Fruit"]["Started"] do
Noclip(false)
if game:GetService("Players").LocalPlayer.PlayerGui.Main.Timer.Visible == false then
if not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Special Microchip") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Special Microchip") then
if BloxFruitSea2 then
local New = CFrame.new(-6438, 250, -4501)
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, New, true, (New.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
elseif BloxFruitSea3 then
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-5075, 314, - 3150))
local New = CFrame.new(-5017.40869, 314.844055, -2823.0127, -0.925743818, 4.482175e-8, -0.378151238, 4.5550315e-9, 1, 1.0737756e-7, 0.378151238, 9.768162e-8, -0.925743818)
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, New, true, (New.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
fireclickdetector(game:GetService("Workspace").Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector)
end
end
end
task.wait()
end
    end
})

Fruit2Group:AddToggle("Auto Kill Aura", {
    Text = "Auto Kill Aura + Auto Next",
    Default = false,
    Tooltip = "Tự Động Giết Hết Quáy / Đổi Đảo",
    Callback = function(Value)
_G.SettingToggle["Chip Fruit"]["Auto Raid"]  = Value
if Value == false then
            CancelTween()
            Noclip(true)
        end
while _G.SettingToggle["Chip Fruit"]["Auto Raid"] do
Noclip(false)
spawn(function()
for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
repeat task.wait()
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character.Humanoid.Health < 7000 then
repeat task.wait()
BringMobs = false
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, (_G.IslandGetHealth * CFrame.new(0, 80, 0)), true, (_G.IslandGetHealth.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
until game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character.Humanoid.Health < 7000
end
AutoHaki()
BringMobs = true
EquipTool(_G.ToolAttack)
if _G.SettingToggle["Attack Aura"] == false then
AttackNoCoolDown()
end
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, (v.HumanoidRootPart.CFrame * CFrame.new(0, 40, 0)), true, (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
v.HumanoidRootPart.Transparency = 1
v.HumanoidRootPart.CanCollide = false
v.Humanoid.JumpPower = 0
v.Humanoid.Health = 0
v.Humanoid.WalkSpeed = 0
if v:FindFirstChild("Head") then
v.Head:Destroy()
end
FarmPos = v.HumanoidRootPart.CFrame
ModsFarm = v.Name
sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
until _G.SettingToggle["Chip Fruit"]["Auto Raid"] == false or v.Parent == nil or v.Humanoid.Health <= 0
BringMobs = false
FarmPos = nil
ModsFarm = nil
end
end
end)
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
local IslandRaid1 = {"Island 1", "Island 2", "Island 3", "Island 4", "Island 5"}
_G.IslandRaid = {}
for i, v in pairs(IslandRaid1) do
_G.IslandRaid[v] = false
end
for i, v in ipairs(IslandRaid1) do
while not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild(v) do
IslandLocation = game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild(v)
task.wait()
end
if not _G.IslandRaid[v] then
_G.IslandGetHealth = (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild(v).CFrame * CFrame.new(0, 50, 0))
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild(v).CFrame * CFrame.new(0, 70, 0)), true, (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild(v).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
_G.IslandRaid[v] = true
if i < #IslandRaid1 then
local NextIsland = IslandRaid1[i + 1]
while not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild(NextIsland) do
task.wait()
end
end
end
end
end
task.wait()
end
    end
})
else
Fruit2Group:AddLabel("You must go through sea 2 - 3 to raid fruit", true)
end

Fruit3Group = Tabs.Tab2:AddLeftGroupbox("Esp")

Fruit3Group:AddToggle("Esp Player", {
    Text = "Esp Player",
    Value = false,
    Tooltip = "Định Vị Người Chơi",
    Callback = function(Value)
_G.SettingToggle["Esp"]["Player"] = Value
while _G.SettingToggle["Esp"]["Player"] do
for i,v in ipairs(game.Players:GetChildren()) do
if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
if v.Character.Head:FindFirstChild("PlayerEsp") and v.Character.Head.PlayerEsp:FindFirstChild("TextLabel") then
v.Character.Head.PlayerEsp.TextLabel.Text = 
          (_G.NameEsp == true and "\nName [ "..v.Name.." ]" or "")..
          (_G.DistanceEsp == true and "\nDistance [ "..string.format("%.1f", (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude).." ]" or "")..
          (_G.LevelEsp == true and "\nLevel [ "..v.Data.Level.Value.." ]" or "")..
          (_G.BeliEsp == true and "\nBeli [ "..v.Data.Beli.Value.." ]" or "")..
          (_G.FruitEsp == true and "\nFruit [ "..(v.Data.DevilFruit.Value == "" and "Fruit [ Nah ]" or v.Data.DevilFruit.Value).." ]" or "")..
          (_G.FragmentsEsp == true and "\nFragments [ "..v.Data.Fragments.Value.." ]" or "")..
          (_G.HealthEsp == true and "\nHealth [ "..v.Character.Humanoid.Health.." / "..v.Character.Humanoid.MaxHealth.." ]" or "")
end
if v.Character.Head:FindFirstChild("PlayerEsp") and v.Character.Head.PlayerEsp:FindFirstChild("TextLabel") and v.Character.Head.PlayerEsp.TextLabel.TextColor3 ~= _G.ColorESP then
v.Character.Head.PlayerEsp.TextLabel.TextColor3 = _G.ColorESP
end
if v.Character.Head:FindFirstChild("PlayerEsp") and v.Character.Head.PlayerEsp:FindFirstChild("TextLabel") and v.Character.Head.PlayerEsp.TextLabel.TextSize ~= _G.TextSize then
v.Character.Head.PlayerEsp.TextLabel.TextSize = _G.TextSize
end
if v.Character.Head:FindFirstChild("PlayerEsp") == nil then
PlayerEsp = Instance.new("BillboardGui", v.Character.Head)
PlayerEsp.Adornee = v.Character.Head
PlayerEsp.Name = "PlayerEsp"
PlayerEsp.Size = UDim2.new(0, 100, 0, 150)
PlayerEsp.AlwaysOnTop = true
PlayerEsp.StudsOffset = Vector3.new(0, 3, 0)
PlayerEspText = Instance.new("TextLabel", PlayerEsp)
PlayerEspText.BackgroundTransparency = 1
PlayerEspText.Font = Enum.Font.SourceSansBold
PlayerEspText.Size = UDim2.new(0, 100, 0, 100)
PlayerEspText.TextSize = 15
PlayerEspText.TextColor3 = Color3.new(0, 0, 0)
PlayerEspText.TextStrokeTransparency = 0.5
PlayerEspText.Text = ""
end
end
end
task.wait()
end
for i,v in ipairs(game.Players:GetChildren()) do
if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
if v.Character.Head:FindFirstChild("PlayerEsp") then
v.Character.Head:FindFirstChild("PlayerEsp"):Destroy()
end
end
end
    end
})

Fruit3Group:AddToggle("Esp Fruit", {
    Text = "Esp Fruit",
    Value = false,
    Tooltip = "Định Vị Trái Cây",
    Callback = function(Value)
_G.SettingToggle["Esp"]["Fruit"] = Value
while _G.SettingToggle["Esp"]["Fruit"] do
for i, v in pairs(game.Workspace:GetChildren()) do
if string.find(v.Name, "Fruit") and v:FindFirstChild("Handle") then
if v.Handle:FindFirstChild("FruitEsp") and v.Handle.FruitEsp:FindFirstChild("TextLabel") then
if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
v.Handle.FruitEsp.TextLabel.Text = 
          (_G.NameEsp == true and "\nName [ "..v.Name.." ]" or "")..
          (_G.DistanceEsp == true and "\nDistance [ "..string.format("%.1f", (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Handle.Position).Magnitude).." ]" or "")
end
end
if v.Handle:FindFirstChild("FruitEsp") and v.Handle.FruitEsp:FindFirstChild("TextLabel") and v.Handle.FruitEsp.TextLabel.TextColor3 ~= _G.ColorESP then
v.Handle.FruitEsp.TextLabel.TextColor3 = _G.ColorESP
end
if v.Handle:FindFirstChild("FruitEsp") and v.Handle.FruitEsp:FindFirstChild("TextLabel") and v.Handle.FruitEsp.TextLabel.TextSize ~= _G.TextSize then
v.Handle.FruitEsp.TextLabel.TextSize = _G.TextSize
end
if v.Handle:FindFirstChild("FruitEsp") == nil then
FruitEsp = Instance.new("BillboardGui", v.Handle)
FruitEsp.Adornee = v.Handle
FruitEsp.Name = "FruitEsp"
FruitEsp.Size = UDim2.new(0, 100, 0, 150)
FruitEsp.AlwaysOnTop = true
FruitEsp.StudsOffset = Vector3.new(0, 3, 0)
FruitEspText = Instance.new("TextLabel", FruitEsp)
FruitEspText.BackgroundTransparency = 1
FruitEspText.Font = Enum.Font.SourceSansBold
FruitEspText.Size = UDim2.new(0, 100, 0, 100)
FruitEspText.TextSize = 15
FruitEspText.TextColor3 = Color3.new(0, 0, 0)
FruitEspText.TextStrokeTransparency = 0.5
FruitEspText.Text = ""
end
end
end
for i, v in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
    if string.find(v.Name, "Fruit") and v:FindFirstChild("Handle") and v.Handle:FindFirstChild("FruitEsp") then
        v.Handle.FruitEsp:Destroy()
    end
end
for i, v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
    if string.find(v.Name, "Fruit") and v:FindFirstChild("Handle") and v.Handle:FindFirstChild("FruitEsp") then
        v.Handle.FruitEsp:Destroy()
    end
end
task.wait()
end
for i, v in pairs(game.Workspace:GetChildren()) do
if string.find(v.Name, "Fruit") and v:FindFirstChild("Handle") then
if v.Handle:FindFirstChild("FruitEsp") then
v.Handle:FindFirstChild("FruitEsp"):Destroy()
end
end
end
for i, v in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
    if string.find(v.Name, "Fruit") and v:FindFirstChild("Handle") and v.Handle:FindFirstChild("FruitEsp") then
        v.Handle.FruitEsp:Destroy()
    end
end
for i, v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
    if string.find(v.Name, "Fruit") and v:FindFirstChild("Handle") and v.Handle:FindFirstChild("FruitEsp") then
        v.Handle.FruitEsp:Destroy()
    end
end
    end
})

Fruit3Group:AddToggle("Esp Island", {
    Text = "Esp Island",
    Value = false,
    Tooltip = "Định Vị Đảo",
    Callback = function(Value)
_G.SettingToggle["Esp"]["Island"] = Value
while _G.SettingToggle["Esp"]["Island"] do
for i, v in pairs(game:GetService("Workspace")["_WorldOrigin"].Locations:GetChildren()) do
if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
if v:FindFirstChild("IslandEsp") and v.IslandEsp:FindFirstChild("TextLabel") then
v.IslandEsp.TextLabel.Text = 
          (_G.NameEsp == true and "\nName [ "..v.Name.." ]" or "")..
          (_G.DistanceEsp == true and "\nDistance [ "..string.format("%.1f", (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude).." ]" or "")
end
end
if v:FindFirstChild("IslandEsp") and v.IslandEsp:FindFirstChild("TextLabel") and v.IslandEsp.TextLabel.TextColor3 ~= _G.ColorESP then
v.IslandEsp.TextLabel.TextColor3 = _G.ColorESP
end
if v:FindFirstChild("IslandEsp") and v.IslandEsp:FindFirstChild("TextLabel") and v.IslandEsp.TextLabel.TextSize ~= _G.TextSize then
v.IslandEsp.TextLabel.TextSize = _G.TextSize
end
if v:FindFirstChild("IslandEsp") == nil then
IslandEsp = Instance.new("BillboardGui", v)
IslandEsp.Adornee = v
IslandEsp.Name = "IslandEsp"
IslandEsp.Size = UDim2.new(0, 100, 0, 150)
IslandEsp.AlwaysOnTop = true
IslandEsp.StudsOffset = Vector3.new(0, 3, 0)
IslandEspText = Instance.new("TextLabel", IslandEsp)
IslandEspText.BackgroundTransparency = 1
IslandEspText.Font = Enum.Font.SourceSansBold
IslandEspText.Size = UDim2.new(0, 100, 0, 100)
IslandEspText.TextSize = 15
IslandEspText.TextColor3 = Color3.new(0, 0, 0)
IslandEspText.TextStrokeTransparency = 0.5
IslandEspText.Text = ""
end
end
task.wait()
end
for i, v in pairs(game:GetService("Workspace")["_WorldOrigin"].Locations:GetChildren()) do
if v:FindFirstChild("IslandEsp") then
v.IslandEsp:Destroy()
end
end
    end
})

Fruit3Group:AddToggle("Esp Boat", {
    Text = "Esp Boat",
    Value = false,
    Tooltip = "Định Vị Thuyền",
    Callback = function(Value)
_G.SettingToggle["Esp"]["Boat"] = Value
while _G.SettingToggle["Esp"]["Boat"] do
for i, v in pairs(game:GetService("Workspace").Boats:GetChildren()) do
if v:IsA("Model") then
if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
if v:FindFirstChild("BoatEsp") and v.BoatEsp:FindFirstChild("TextLabel") then
v.BoatEsp.TextLabel.Text = 
          (_G.NameEsp == true and "\nName [ "..v.Name.." ]" or "")..
          (_G.DistanceEsp == true and "\nDistance [ "..string.format("%.1f", (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.VehicleSeat.Position).Magnitude).." ]" or "")..
          (_G.HealthEsp == true and "\nHealth [ "..v.Humanoid.Value.." ]" or "")..
          (_G.OwnerEsp == true and "\nOwner [ "..v.Owner.Value.Name.." ]" or "")
end
end
if v:FindFirstChild("BoatEsp") and v.BoatEsp:FindFirstChild("TextLabel") and v.BoatEsp.TextLabel.TextColor3 ~= _G.ColorESP then
v.BoatEsp.TextLabel.TextColor3 = _G.ColorESP
end
if v:FindFirstChild("BoatEsp") and v.BoatEsp:FindFirstChild("TextLabel") and v.BoatEsp.TextLabel.TextSize ~= _G.TextSize then
v.BoatEsp.TextLabel.TextSize = _G.TextSize
end
if v:FindFirstChild("BoatEsp") == nil then
BoatEsp = Instance.new("BillboardGui", v)
BoatEsp.Adornee = v
BoatEsp.Name = "BoatEsp"
BoatEsp.Size = UDim2.new(0, 100, 0, 150)
BoatEsp.AlwaysOnTop = true
BoatEsp.StudsOffset = Vector3.new(0, 3, 0)
BoatEspText = Instance.new("TextLabel", BoatEsp)
BoatEspText.BackgroundTransparency = 1
BoatEspText.Font = Enum.Font.SourceSansBold
BoatEspText.Size = UDim2.new(0, 100, 0, 100)
BoatEspText.TextSize = 15
BoatEspText.TextColor3 = Color3.new(0, 0, 0)
BoatEspText.TextStrokeTransparency = 0.5
BoatEspText.Text = ""
end
end
end
task.wait()
end
for i, v in pairs(game:GetService("Workspace").Boats:GetChildren()) do
if v:IsA("Model") and v:FindFirstChild("BoatEsp") then
v.BoatEsp:Destroy()
end
end
    end
})

Fruit3Group:AddToggle("Esp Mods", {
    Text = "Esp Mods",
    Value = false,
    Tooltip = "Định Vị Quáy Vật",
    Callback = function(Value)
_G.SettingToggle["Esp"]["Mods"] = Value
while _G.SettingToggle["Esp"]["Mods"] do
for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Head") then
if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
if v.Head:FindFirstChild("ModsEsp") and v.Head.ModsEsp:FindFirstChild("TextLabel") then
v.Head.ModsEsp.TextLabel.Text = 
          (_G.NameEsp == true and "\nName [ "..v.Name.." ]" or "")..
          (_G.DistanceEsp == true and "\nDistance [ "..string.format("%.1f", (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Head.Position).Magnitude).." ]" or "")..
          (_G.HealthEsp == true and "\nHealth [ "..v.Humanoid.Health.." / "..v.Humanoid.MaxHealth.." ]" or "")
end
end
if v.Head:FindFirstChild("ModsEsp") and v.Head.ModsEsp:FindFirstChild("TextLabel") and v.Head.ModsEsp.TextLabel.TextColor3 ~= _G.ColorESP then
v.Head.ModsEsp.TextLabel.TextColor3 = _G.ColorESP
end
if v.Head:FindFirstChild("ModsEsp") and v.Head.ModsEsp:FindFirstChild("TextLabel") and v.Head.ModsEsp.TextLabel.TextSize ~= _G.TextSize then
v.Head.ModsEsp.TextLabel.TextSize = _G.TextSize
end
if v:FindFirstChild("Head") and v.Head:FindFirstChild("ModsEsp") == nil then
ModsEsp = Instance.new("BillboardGui", v.Head)
ModsEsp.Adornee = v.Head
ModsEsp.Name = "ModsEsp"
ModsEsp.Size = UDim2.new(0, 100, 0, 150)
ModsEsp.AlwaysOnTop = true
ModsEsp.StudsOffset = Vector3.new(0, 3, 0)
ModsEspText = Instance.new("TextLabel", ModsEsp)
ModsEspText.BackgroundTransparency = 1
ModsEspText.Font = Enum.Font.SourceSansBold
ModsEspText.Size = UDim2.new(0, 100, 0, 100)
ModsEspText.TextSize = 15
ModsEspText.TextColor3 = Color3.new(0, 0, 0)
ModsEspText.TextStrokeTransparency = 0.5
ModsEspText.Text = ""
end
end
end
task.wait()
end
for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
if v:FindFirstChild("Head") and v.Head:FindFirstChild("ModsEsp") then
v.Head.ModsEsp:Destroy()
end
end
    end
})

if BloxFruitSea2 == true then
Fruit3Group:AddToggle("Esp Flower", {
    Text = "Esp Flower",
    Value = false,
    Tooltip = "Định Vị Hoa",
    Callback = function(Value)
_G.SettingToggle["Esp"]["Flower"] = Value
while _G.SettingToggle["Esp"]["Flower"] do
for i, v in pairs(game.Workspace:GetChildren()) do
if v.Name == "Flower1" or v.Name == "Flower2" and v:FindFirstChild("FlowerEsp") then
if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
v.FlowerEsp.TextLabel.Text = 
          (_G.NameEsp == true and "\nName [ "..v.Name.." ]" or "")..
          (_G.DistanceEsp == true and "\nDistance [ "..string.format("%.1f", (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Handle.Position).Magnitude).." ]" or "")
end
if v:FindFirstChild("FlowerEsp") and v.FlowerEsp:FindFirstChild("TextLabel") then
if v.Name == "Flower1" then
v.FlowerEsp.TextLabel.TextColor3 = Color3.fromRGB(0, 0, 255)
elseif v.Name == "Flower2" then
v.FlowerEsp.TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
end
end
if v:FindFirstChild("FlowerEsp") and v.FlowerEsp:FindFirstChild("TextLabel") and v.FlowerEsp.TextLabel.TextSize ~= _G.TextSize then
v.FlowerEsp.TextLabel.TextSize = _G.TextSize
end
if v:FindFirstChild("FlowerEsp") == nil then
FlowerEsp = Instance.new("BillboardGui", v)
FlowerEsp.Adornee = v
FlowerEsp.Name = "FlowerEsp"
FlowerEsp.Size = UDim2.new(0, 100, 0, 150)
FlowerEsp.AlwaysOnTop = true
FlowerEsp.StudsOffset = Vector3.new(0, 3, 0)
FlowerEspText = Instance.new("TextLabel", FlowerEsp)
FlowerEspText.BackgroundTransparency = 1
FlowerEspText.Font = Enum.Font.SourceSansBold
FlowerEspText.Size = UDim2.new(0, 100, 0, 100)
FlowerEspText.TextSize = 15
FlowerEspText.TextColor3 = Color3.new(0, 0, 0)
FlowerEspText.TextStrokeTransparency = 0.5
FlowerEspText.Text = ""
end
end
end
task.wait()
end
for i, v in pairs(game.Workspace:GetChildren()) do
if v.Name == "Flower1" or v.Name == "Flower2" and v:FindFirstChild("FlowerEsp") then
v.FlowerEsp:Destroy()
end
end
    end
})
end

Fruit3Group:AddDivider()

_G.LevelEsp = false
Fruit3Group:AddToggle("Level Esp", {
    Text = "Level Esp",
    Tooltip = "Định vị có Cấp",
    Default = false, 
    Callback = function(Value) 
_G.LevelEsp = Value
    end
})

_G.FruitEsp = false
Fruit3Group:AddToggle("Fruit Esp", {
    Text = "Fruit Esp",
    Tooltip = "Định vị có đang dùng Trái",
    Default = false, 
    Callback = function(Value) 
_G.FruitEsp = Value
    end
})

_G.HealthEsp = false
Fruit3Group:AddToggle("Health Esp", {
    Text = "Health Esp",
    Tooltip = "Định vị có Máu",
    Default = false, 
    Callback = function(Value) 
_G.HealthEsp = Value
    end
})

if BloxFruitSea3 == true then
_G.FragmentsEsp = false
Fruit3Group:AddToggle("Fragments Esp", {
    Text = "Fragments Esp",
    Tooltip = "Định vị có Điểm F",
    Default = false, 
    Callback = function(Value) 
_G.FragmentsEsp = Value
    end
})
end

_G.BeliEsp = false
Fruit3Group:AddToggle("Beli Esp", {
    Text = "Beli Esp",
    Tooltip = "Định vị có Beli",
    Default = false, 
    Callback = function(Value) 
_G.BeliEsp = Value
    end
})

_G.OwnerEsp = false
Fruit3Group:AddToggle("Owner Esp", {
    Text = "Owner Esp",
    Tooltip = "Định vị có Chủ",
    Default = false, 
    Callback = function(Value) 
_G.OwnerEsp = Value
    end
})

_G.DistanceEsp = false
Fruit3Group:AddToggle("Distance Esp", {
    Text = "Distance Esp",
    Tooltip = "Định vị có khoảng cách",
    Default = false, 
    Callback = function(Value) 
_G.DistanceEsp = Value
    end
})

_G.NameEsp = false
Fruit3Group:AddToggle("Name Esp", {
    Text = "Name Esp",
    Tooltip = "Định vị có Tên",
    Default = false, 
    Callback = function(Value) 
_G.NameEsp = Value
    end
})

Fruit3Group:AddLabel("Color"):AddColorPicker("ColorPickerEsp", {
    Default = Color3.new(0, 1, 0),
    Title = "Esp Color",
    Transparency = 0,
    Callback = function(Value)
        _G.ColorESP = Value
    end
})

_G.TextSize = 10
Fruit3Group:AddSlider("Size Text Esp", {
    Text = "Size Text Esp",
    Default = 10,
    Min = 10,
    Max = 40,
    Rounding = 0,
    Compact = true,
    Callback = function(Value)
_G.TextSize = Value
    end
})

local State1Group = Tabs.Tab3:AddLeftGroupbox("State")

State1Group:AddSlider("Stats", {
    Text = "Get Stats",
    Default = 3,
    Min = 1,
    Max = 500,
    Rounding = 0,
    Compact = true,
    Callback = function(Value)
_G.SettingToggle["Auto Stats"]["Melee"] = Value
_G.SettingToggle["Auto Stats"]["Sword"] = Value
_G.SettingToggle["Auto Stats"]["Gun"] = Value
_G.SettingToggle["Auto Stats"]["Defense"] = Value
_G.SettingToggle["Auto Stats"]["Blox Fruit"] = Value
    end
})

State1Group:AddToggle("Stats Melee", {
    Text = "Stats Melee",
    Value = false,
    Tooltip = "Năng Cú Đấm",
    Callback = function(Value)
_G.SettingToggle["Auto Stats"]["Start State"]["Melee"] = Value
while _G.SettingToggle["Auto Stats"]["Start State"]["Melee"] do
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Melee", _G.SettingToggle["Auto Stats"]["Melee"])
task.wait()
end
    end
})

State1Group:AddToggle("State Defense", {
    Text = "Stats Defense",
    Value = false,
    Tooltip = "Năng Máu (Phòng Thủ)",
    Callback = function(Value)
_G.SettingToggle["Auto Stats"]["Start State"]["Defense"] = Value
while _G.SettingToggle["Auto Stats"]["Start State"]["Defense"] do
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Defense", _G.SettingToggle["Auto Stats"]["Defense"])
task.wait()
end
    end
})

State1Group:AddToggle("State Sword", {
    Text = "Stats Sword",
    Value = false,
    Tooltip = "Năng Kiếm",
    Callback = function(Value)
_G.SettingToggle["Auto Stats"]["Start State"]["Sword"] = Value
while _G.SettingToggle["Auto Stats"]["Start State"]["Sword"] do
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Sword", _G.SettingToggle["Auto Stats"]["Sword"])
task.wait()
end
    end
})

State1Group:AddToggle("State Gun", {
    Text = "Stats Gun",
    Value = false,
    Tooltip = "Năng Súng",
    Callback = function(Value)
_G.SettingToggle["Auto Stats"]["Start State"]["Gun"] = Value
while _G.SettingToggle["Auto Stats"]["Start State"]["Gun"] do
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Gun", _G.SettingToggle["Auto Stats"]["Gun"])
task.wait()
end
    end
})

State1Group:AddToggle("State Blox fruit", {
    Text = "Stats Blox Fruit",
    Value = false,
    Tooltip = "Năng Trái Cây",
    Callback = function(Value)
_G.SettingToggle["Auto Stats"]["Start State"]["Blox Fruit"] = Value
while _G.SettingToggle["Auto Stats"]["Start State"]["Blox Fruit"] do
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", _G.SettingToggle["Auto Stats"]["Blox Fruit"])
task.wait()
end
    end
})

local Shop1Group = Tabs.Tab4:AddLeftGroupbox("Ability")

Shop1Group:AddButton({
    Text = "Jump",
    Tooltip = "Nhảy trên ko",
    Func = function()
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Geppo")
    end
})

Shop1Group:AddButton({
    Text = "Haki",
    Tooltip = "Haki Đấm",
    Func = function()
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Buso")
    end
})

Shop1Group:AddButton({
    Text = "Teleport",
    Tooltip = "Dịch Chuyển",
    Func = function()
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Soru")
    end
})

Shop1Group:AddButton({
    Text = "Observation Haki",
    Tooltip = "Haki Quan Sát",
    Func = function()
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk", "Buy")
    end
})

local Shop2Group = Tabs.Tab4:AddRightGroupbox("Sword")

local Sword = {
    ["Cutlass"] = {Name = "Cutlass", Tooltip = "Một thanh kiếm cắt nhanh"},
    ["Katana"] = {Name = "Katana", Tooltip = "Thanh kiếm Nhật sắc bén"},
    ["Iron Mace"] = {Name = "Iron Mace", Tooltip = "Chùy sắt mạnh mẽ"},
    ["Duel Katana"] = {Name = "Duel Katana", Tooltip = "Hai thanh kiếm Katana"},
    ["Triple Katana"] = {Name = "Triple Katana", Tooltip = "Ba thanh kiếm Katana"},
    ["Dual-Headed Blade"] = {Name = "Dual-Headed Blade", Tooltip = "Kiếm hai đầu mạnh mẽ"},
    ["Bisento"] = {Name = "Bisento", Tooltip = "Vũ khí của Râu Trắng"},
    ["Soul Cane"] = {Name = "Soul Cane", Tooltip = "Cây gậy linh hồn"},
    ["Pipe"] = {Name = "Soul Cane", Tooltip = "Đường ống"},
}

for i, v in pairs(Sword) do
Shop2Group:AddButton({
   Text = i,
   Tooltip = v.Tooltip,
   Func = function()
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", v)
   end
})
end

Shop2Group:AddButton({
   Text = "Pole V2",
   Tooltip = "Cực V2",
   Func = function()
game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ThunderGodTalk")
   end
})

local Shop3Group = Tabs.Tab4:AddLeftGroupbox("Combat")

local Combat = {
	["Black Leg"] = {Name = "Black Leg", Tooltip = "Chân Đen", BuyScript = "BuyBlackLeg"},
	["Electro"] = {Name = "Electro", Tooltip = "Bàn Tay Điện", BuyScript = "BuyElectro"},
	["Fishman Karate"] = {Name = "Fishman Karate", Tooltip = "Bàn Tay Nước", BuyScript = "BuyFishmanKarate"},
	["Superhuman"] = {Name = "Superhuman", Tooltip = "Bàn Tay Siêu Nhân", BuyScript = "BuySuperhuman"},
	["Death Step"] = {Name = "Death Step", Tooltip = "Chân Đen V2", BuyScript = "BuyDeathStep"},
	["Electric Claw"] = {Name = "Electric Claw", Tooltip = "Bàn Tay Điện V2", BuyScript = "BuyElectricClaw"},
	["Dragon Talon"] = {Name = "Dragon Talon", Tooltip = "Móng Vuốt Rồng", BuyScript = "BuyDragonTalon"},
	["Godhuman"] = {Name = "Godhuman", Tooltip = "Bàn Tay Thần Nhân", BuyScript = "BuyGodhuman"},
	["Sanguine Art"] = {Name = "Sanguine Art", Tooltip = "Bàn Tay Máu Đỏ", BuyScript = "BuySanguineArt"},
}

for i, v in pairs(Combat) do
Shop3Group:AddButton({
   Text = i,
   Tooltip = v.Tooltip,
   Func = function()
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(v.BuyScript)
   end
})
end

Shop3Group:AddButton({
   Text = "Sharkman Karate",
   Tooltip = "Bàn Tay Cá Mập",
   Func = function()
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate", true)
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
   end
})

Shop3Group:AddButton({
   Text = "Dragon Claw",
   Tooltip = "Bàn Tay Rồng",
   Func = function()
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "1")
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
   end
})

local Event1Group = Tabs.Tab5:AddLeftGroupbox("Sea 1")
local Event2Group = Tabs.Tab5:AddRightGroupbox("Sea 2")
local Event3Group = Tabs.Tab5:AddLeftGroupbox("Sea 3")

if BloxFruitSea1 == true then
Event1Group:AddToggle("PoleV1", {
    Text = "Auto Get Pole V1",
    Value = false,
    Tooltip = "Tự Động Lấy Gậy Thần V1",
    Callback = function(Value)
_G.SettingToggle["Event"]["PoleV1"] = Value
while _G.SettingToggle["Event"]["PoleV1"] do
if game:GetService("Workspace").Enemies:FindFirstChild("Thunder God") then
for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
if v.Name == "Thunder God" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
repeat task.wait()
AutoHaki()
EquipTool(_G.ToolAttack)
if _G.SettingToggle["Attack Aura"] == false then
AttackNoCoolDown()
end
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
if _G.SettingToggle["Tween Choose"] == "Normal" then
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, (v.HumanoidRootPart.CFrame * CFrame.new(0, 40, 0)), true, (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
elseif _G.SettingToggle["Tween Choose"] == "Orbit" then
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, (v.HumanoidRootPart.CFrame * PositionOrbit), true, (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
end
end
v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
v.HumanoidRootPart.CanCollide = false
v.Humanoid.JumpPower = 0
v.Humanoid.WalkSpeed = 0
until _G.SettingToggle["Event"]["PoleV1"] == false or v.Parent == nil or v.Humanoid.Health <= 0
end
end
elseif (Vector3.new(-7748, 5606, -2305) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 1500 then
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, CFrame.new(-7748, 5606, -2305), true, (Vector3.new(-7748, 5606, -2305) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
end
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, CFrame.new(-7748, 5606, -2305), true, (Vector3.new(-7748, 5606, -2305) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
if game:GetService("ReplicatedStorage"):FindFirstChild("Thunder God") then
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, (game:GetService("ReplicatedStorage"):FindFirstChild("Thunder God").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2)), true, (game:GetService("ReplicatedStorage"):FindFirstChild("Thunder God").HumanoidRootPart.CFrame - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
end
task.wait()
end
    end
})

Event1Group:AddToggle("Saw", {
    Text = "Auto Get Saw",
    Value = false,
    Tooltip = "Tự Động Lấy Cưa",
    Callback = function(Value)
_G.SettingToggle["Event"]["Saw"] = Value
while _G.SettingToggle["Event"]["Saw"] do
if game:GetService("Workspace").Enemies:FindFirstChild("The Saw") then
for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
if v.Name == "The Saw" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
repeat task.wait()
AutoHaki()
EquipTool(_G.ToolAttack)
if _G.SettingToggle["Attack Aura"] == false then
AttackNoCoolDown()
end
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
if _G.SettingToggle["Tween Choose"] == "Normal" then
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, (v.HumanoidRootPart.CFrame * CFrame.new(0, 40, 0)), true, (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
elseif _G.SettingToggle["Tween Choose"] == "Orbit" then
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, (v.HumanoidRootPart.CFrame * PositionOrbit), true, (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
end
end
v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
v.HumanoidRootPart.CanCollide = false
v.Humanoid.JumpPower = 0
v.Humanoid.WalkSpeed = 0
until _G.SettingToggle["Event"]["Saw"] == false or v.Parent == nil or v.Humanoid.Health <= 0
end
end
elseif (Vector3.new(-690, 15, 1582) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 1500 then
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, CFrame.new(-690, 15, 1582), true, (Vector3.new(-690, 15, 1582) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
end
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, CFrame.new(-690, 15, 1582), true, (Vector3.new(-690, 15, 1582) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
if game:GetService("ReplicatedStorage"):FindFirstChild("The Saw") then
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, (game:GetService("ReplicatedStorage"):FindFirstChild("The Saw").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2)), true, (game:GetService("ReplicatedStorage"):FindFirstChild("The Saw").HumanoidRootPart.CFrame - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
end
task.wait()
end
    end
})
elseif BloxFruitSea2 == true then

elseif BloxFruitSea3 == true then
Event3Group:AddToggle("Yama", {
    Text = "Auto Click Yama",
    Value = false,
    Tooltip = "Tự Động Ấn Kiếm Yama",
    Callback = function(Value)
_G.SettingToggle["Event"]["Yama"] = Value
if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter", "Progress") >= 30 then
while _G.SettingToggle["Event"]["Yama"] do
if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter", "Progress") >= 30 then
repeat task.wait()
fireclickdetector(game:GetService("Workspace").Map.Waterfall.SealedKatana.Handle.ClickDetector);
until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Yama") or _G.SettingToggle["Event"]["Yama"] == false
end
task.wait()
end
elseif Value == true then
Notification("You must be an Elite hunter +30 / Bạn phải săn Elite +30", 5)
wait(0.5)
Toggles["Yama"]:SetValue(false)
end
    end
})
end

if BloxFruitSea2 == true or BloxFruitSea3 == true then
(BloxFruitSea3 == true and Event3Group or BloxFruitSea2 == true and Event2Group):AddToggle("Yama", {
    Text = "Auto Learn Haki Color",
    Value = false,
    Tooltip = "Tự Động Học Màu Haki",
    Callback = function(Value)
_G.SettingToggle["Event"]["HakiColor"] = Value
while _G.SettingToggle["Event"]["HakiColor"] do
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ColorsDealer", "2")
task.wait()
end
    end
})
end

local Misc1Group = Tabs.Tab8:AddLeftGroupbox("Misc")

Misc1Group:AddSlider("DistanceMods", {
    Text = "Bring Mods Distance",
    Default = 250,
    Min = 100,
    Max = 500,
    Rounding = 0,
    Compact = true,
    Callback = function(Value)
_G.SettingToggle["BringMods"]["Distance"] = Value
    end
})

Misc1Group:AddSlider("Speed Tween", {
    Text = "Tween Speed",
    Default = 300,
    Min = 100,
    Max = 300,
    Rounding = 0,
    Compact = true,
    Callback = function(Value)
_G.SettingToggle["BringMods"]["Distance"] = Value
    end
})

Misc1Group:AddToggle("Fast Attack", {
    Text = "Fast Attack",
    Value = false,
    Tooltip = "Tấn công nhanh",
    Callback = function(Value)
_G.SettingToggle["Attack Aura"] = Value
while _G.SettingToggle["Attack Aura"] do
AttackNoCoolDown()
task.wait()
end
    end
})

Misc1Group:AddToggle("WalkWater", {
    Text = "Walk On Water",
    Value = false,
    Tooltip = "Đi trên nước",
    Callback = function(Value)
_G.SettingToggle["Walk Water"] = Value
if _G.SettingToggle["Walk Water"] then
   game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 112, 1000)
else
   game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 80, 1000)
end
    end
})

Misc1Group:AddToggle("Bring Mod", {
    Text = "Bring Mods",
    Value = false,
    Tooltip = "Gom mods lại 1 chỗ",
    Callback = function(Value)
_G.SettingToggle["BringMods"]["BringGet"] = Value
while _G.SettingToggle["BringMods"]["BringGet"] do
for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
if _G.SettingToggle["BringMods"]["BringGet"] == true and BringMobs == true then
if v.Name == ModsFarm and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
if v.Name == "Factory Staff" then
if (v.HumanoidRootPart.Position - FarmPos.Position).Magnitude <= _G.SettingToggle["BringMods"]["Distance"] then
v.Head.CanCollide = false
v.HumanoidRootPart.CanCollide = false
v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
v.HumanoidRootPart.CFrame = FarmPos
if v.Humanoid:FindFirstChild("Animator") then
v.Humanoid.Animator:Destroy()
end
sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge);
end
elseif v.Name == ModsFarm then
if (v.HumanoidRootPart.Position - FarmPos.Position).Magnitude <= _G.SettingToggle["BringMods"]["Distance"] then
v.Head.CanCollide = false
v.HumanoidRootPart.CFrame = FarmPos
v.Humanoid:ChangeState(11)
v.Humanoid:ChangeState(14)
if v.Humanoid:FindFirstChild("Animator") then
v.Humanoid.Animator:Destroy()
end
sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
end
end
end
end
end
wait()
end
    end
})

Misc1Group:AddToggle("Auto Haki", {
    Text = "Auto Haki",
    Value = false,
    Tooltip = "Tự Động Bặt Haki",
    Callback = function(Value)
_G.SettingToggle["Auto Haki"] = Value
while _G.SettingToggle["Auto Haki"] do
AutoHaki()
task.wait()
end
    end
})

Misc1Group:AddDropdown("TweenChoose", {
    Title = "Tween Choose",
    Values = {"Normal", "Orbit"},
    Default = 1,
    Multi = false,
    Callback = function(Value)
_G.SettingToggle["Tween Choose"] = Value
    end
})

Misc1Group:AddSlider("Fly Speed", {
    Text = "Speed Fly",
    Default = 100,
    Min = 10,
    Max = 100,
    Rounding = 0,
    Compact = true,
    Callback = function(Value)
_G.SetSpeedFly = Value
    end
})

_G.SetSpeedFly = 100
Misc1Group:AddToggle("Start Fly", {
    Text = "Start Fly",
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
}):AddKeyPicker("Fly", {
   Default = "R",
   Text = "Fly",
   Mode = "Toggle",
   SyncToggleState = true
})

_G.SetWalkSpeed = 100
Misc1Group:AddSlider("Speed", {
    Text = "Speed",
    Default = 100,
    Min = 10,
    Max = 300,
    Rounding = 0,
    Compact = true,
    Callback = function(Value)
_G.SetWalkSpeed = Value
    end
})

Misc1Group:AddToggle("Set Speed", {
    Text = "Set Speed",
    Default = false, 
    Callback = function(Value) 
_G.SetWalk = Value
if _G.SetWalk == false then
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 59
end
end
while _G.SetWalk do
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = _G.SetWalkSpeed
end
wait()
end
    end
})

_G.SetJump= 100
Misc1Group:AddSlider("Jump", {
    Text = "Jump",
    Default = 100,
    Min = 10,
    Max = 500,
    Rounding = 0,
    Compact = true,
    Callback = function(Value)
_G.SetJump = Value
    end
})

Misc1Group:AddToggle("Set Jump Power", {
    Text = "Set Jump Power",
    Default = false, 
    Callback = function(Value) 
_G.SetJumpPo = Value
if _G.SetJumpPo == false then
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Players.LocalPlayer.Character.Humanoid.JumpPower = 70
end
end
while _G.SetJumpPo do
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Players.LocalPlayer.Character.Humanoid.JumpPower = _G.SetJump
end
wait()
end
    end
})

local Misc2Group = Tabs.Tab8:AddRightGroupbox("Misc 2")

Misc2Group:AddToggle("RemoveNotify", {
    Text = "Remove Notification",
    Default = false,
    Tooltip = "Tắt thông báo",
    Callback = function(Value)
_G.SettingToggle["Remove"]["Notify"] = Value
if _G.SettingToggle["Remove"]["Notify"] then
   game.Players.LocalPlayer.PlayerGui.Notifications.Enabled = false
else
   game.Players.LocalPlayer.PlayerGui.Notifications.Enabled = true
end
    end
})

Misc2Group:AddToggle("RemoveDamage", {
    Text = "Remove Damage",
    Default = false,
    Tooltip = "Tắt gây sát thương",
    Callback = function(Value)
_G.SettingToggle["Remove"]["Dame"] = Value
if _G.SettingToggle["Remove"]["Dame"] then
   game:GetService("ReplicatedStorage").Assets.GUI.DamageCounter.Enabled = false
else
   game:GetService("ReplicatedStorage").Assets.GUI.DamageCounter.Enabled = true
end
    end
})

Misc2Group:AddButton({
    Text = "Pirates",
    Tooltip = "Hải tặc",
    Func = function()
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
    end
}):AddButton({
    Text = "Marines",
    Tooltip = "Hải Quân",
    Func = function()
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Marines")
    end
})
local Experience = {
    "KITT_RESET",
    "Sub2UncleKizaru",
    "SUB2GAMERROBOT_RESET1",
    "Sub2Fer999",
    "Enyu_is_Pro",
    "JCWK",
    "StarcodeHEO",
    "MagicBus",
    "KittGaming",
    "Sub2CaptainMaui",
    "Sub2OfficalNoobie",
    "TheGreatAce",
    "Sub2NoobMaster123",
    "Sub2Daigrock",
    "Axiore",
    "StrawHatMaine",
    "TantaiGaming",
    "Bluxxy",
    "SUB2GAMERROBOT_EXP1",
    "Chandler",
    "NOMOREHACK",
    "BANEXPLOIT",
    "WildDares",
    "BossBuild",
    "GetPranked",
    "EARN_FRUITS",
    "FIGHT4FRUIT",
    "NOEXPLOITER",
    "NOOB2ADMIN",
    "CODESLIDE",
    "ADMINHACKED",
    "ADMINDARES",
    "fruitconcepts",
    "krazydares",
    "TRIPLEABUSE",
    "SEATROLLING",
    "24NOADMIN",
    "REWARDFUN",
    "NEWTROLL",
    "fudd10_v2",
    "Fudd10",
    "Bignews",
    "SECRET_ADMIN"
}
Misc2Group:AddButton({
    Text = "Get All Code",
    Tooltip = "Nhận Hết",
    Func = function()
for i, v in pairs(Experience) do
game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(v)
task.wait()
end
    end
})

Misc2Group:AddToggle("Auto On PVP", {
    Text = "Auto On PVP",
    Default = false,
    Tooltip = "Tự Động Bặt Chiến Đấu",
    Callback = function(Value)
_G.SettingToggle["Auto Pvp"] = Value
while _G.SettingToggle["Auto Pvp"] do
if game:GetService("Players").LocalPlayer.PlayerGui.Main.PvpDisabled.Visible == true then
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EnablePvp")
end
task.wait()
end
    end
})

Misc2Group:AddInput("Players", {
    Default = "",
    Numeric = false,
    Text = "Player Tween",
    Finished = true,
    Placeholder = "Username",
    Callback = function(Value)
if Value ~= "" or Value ~= " " then
local PlayerTarget = Value
local PlayerTa
for _, v in pairs(game.Players:GetPlayers()) do
if string.sub(v.Name, 1, #PlayerTarget):lower() == PlayerTarget:lower() then
PlayerTa = v
break
end
end
if PlayerTa then
_G.TweenPlayer = PlayerTa.Name
Notification("Player Found / Tìm Thấy Rồi [ ".._G.TweenPlayer.." ]", 5)
else
Notification("Player Not Found / Ko Thấy", 5)
end
end
    end
})

Misc2Group:AddToggle("Auto Tween Player", {
    Text = "Auto Tween Player",
    Default = false,
    Tooltip = "Tự Động Bặt Chiến Đấu",
    Callback = function(Value)
_G.SettingToggle["Auto Tween Player"] = Value
if Value == false then
            CancelTween()
            Noclip(true)
        end
while _G.SettingToggle["Auto Tween Player"] do
Noclip(false)
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
if game.Players[_G.TweenPlayer].Character and game.Players[_G.TweenPlayer].Character:FindFirstChild("HumanoidRootPart") then
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, (game.Players[_G.TweenPlayer].Character.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)), true, (game.Players[_G.TweenPlayer].Character.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
end
end
task.wait()
end
    end
})

Misc2Group:AddToggle("Auto View Player", {
    Text = "Auto View Player",
    Default = false, 
    Callback = function(Value) 
_G.SettingToggle["Auto View Player"] = Value
while _G.SettingToggle["Auto View Player"] do
if game.Players[_G.TweenPlayer].Character:FindFirstChild("Humanoid") then
game.Workspace.CurrentCamera.CameraSubject = game.Players[_G.TweenPlayer].Character:FindFirstChild("Humanoid")
end
task.wait()
end
repeat task.wait()
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
end
until game.Workspace.CurrentCamera.CameraSubject == game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
    end
})

local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("Menu")
local CreditsGroup = Tabs["UI Settings"]:AddRightGroupbox("Credits")

MenuGroup:AddDropdown("NotifySide", {
    Text = "Notification Side",
    Values = {"Left", "Right"},
    Default = "Right",
    Multi = false,
    Callback = function(Value)
Library.NotifySide = Value
    end
})

_G.ChooseNotify = "LinoriaLib"
MenuGroup:AddDropdown("NotifyChoose", {
    Text = "Notification Choose",
    Values = {"LinoriaLib", "Roblox"},
    Default = "",
    Multi = false,
    Callback = function(Value)
_G.ChooseNotify = Value
    end
})

_G.NotificationSound = true
MenuGroup:AddToggle("NotifySound", {
    Text = "Notification Sound",
    Default = true, 
    Callback = function(Value) 
_G.NotificationSound = Value 
    end
})

MenuGroup:AddSlider("Volume Notification", {
    Text = "Volume Notification",
    Default = 2,
    Min = 2,
    Max = 10,
    Rounding = 1,
    Compact = true,
    Callback = function(Value)
_G.VolumeTime = Value
    end
})

MenuGroup:AddToggle("KeybindMenuOpen", {Default = false, Text = "Open Keybind Menu", Callback = function(Value) Library.KeybindFrame.Visible = Value end})
MenuGroup:AddToggle("ShowCustomCursor", {Text = "Custom Cursor", Default = true, Callback = function(Value) Library.ShowCustomCursor = Value end})
MenuGroup:AddDivider()
MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", {Default = "RightShift", NoUI = true, Text = "Menu keybind"})
MenuGroup:AddButton("Copy Link discord", function()
    if setclipboard then
        setclipboard("https://discord.gg/56BDhEaz32")
        Library:Notify("Copied discord link to clipboard!")
    else
        Library:Notify("Discord link: https://discord.gg/56BDhEaz32", 10)
    end
end):AddButton("Copy Link Zalo", function()
    if setclipboard then
        setclipboard("https://zalo.me/g/qlukiy407")
        Library:Notify("Copied Zalo link to clipboard!")
    else
        Library:Notify("Zalo link: https://zalo.me/g/qlukiy407", 10)
    end
end)
MenuGroup:AddButton("Unload", function() Library:Unload() end)
CreditsGroup:AddLabel("AmongUs - Python / Dex / Script / Python", true)
CreditsGroup:AddLabel("Giang Hub - Script / Dex", true)

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])
SaveManager:LoadAutoloadConfig()  