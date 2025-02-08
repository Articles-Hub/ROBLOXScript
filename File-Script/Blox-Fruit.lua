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
Tween.Completed:Wait()
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

function EquipTool(Name)
    if game.Players.LocalPlayer.Backpack:FindFirstChild(Name) then
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild(Name))
    end
end

function EspGui(Esp)
Esp.Name = Esp.Name or "EspGui"
Esp.Adornee = Esp.Adornee
Esp.Parnt = Esp.Parnt
Esp.IfPart = Esp.IfPart
Esp.Color = Esp.Color or Color3.new(0, 0, 0)
Esp.TextSize = Esp.TextSize or 10
Esp.Text = Esp.Text or "Chả có gì"
Esp.Remove = Esp.Remove or false
Esp.CheckUpdate = Esp.CheckUpdate or false
Esp.UpdateGui = {
	ColorText = ColorText or Esp.Color,
	Text = Text or Esp.Text,
	TextSize = TextSize or Esp.TextSize
}

if Esp.Remove == false then
if (Esp.IfPart) and Esp.Parnt:FindFirstChild(Esp.Name) == nil then
EspGui = Instance.new("BillboardGui", Esp.Parnt)
EspGui.Adornee = Esp.Adornee
EspGui.Name = Esp.Name
EspGui.Size = UDim2.new(1, 200, 1, 30)
EspGui.AlwaysOnTop = true
EspGui.StudsOffset = Vector3.new(0, 3, 0)
EspGuiText = Instance.new("TextLabel", EspGui)
EspGuiText.BackgroundTransparency = 1
EspGuiText.Font = Enum.Font.SourceSansBold
EspGuiText.Size = UDim2.new(1, 0, 1, 0)
EspGuiText.TextSize = Esp.TextSize
EspGuiText.TextWrapped = true
EspGuiText.TextYAlignment = "Top"
EspGuiText.TextColor3 = Esp.Color
EspGuiText.TextStrokeTransparency = 0.5
EspGuiText.Text = Esp.Text
end
end
if Esp.Remove == true then
if (Esp.IfPart) and Esp.Parnt:FindFirstChild(Esp.Name)then
Esp.Parnt[Esp.Name]:Destroy()
end
end
if Esp.CheckUpdate == true then
if (Esp.IfPart) and Esp.Parnt:FindFirstChild(Esp.Name) and Esp.Parnt[Esp.Name]:FindFirstChild("TextLabel") then
Esp.Parnt[Esp.Name].TextLabel.Text = Esp.UpdateGui.Text
end
if (Esp.IfPart) and Esp.Parnt:FindFirstChild(Esp.Name) and Esp.Parnt[Esp.Name]:FindFirstChild("TextLabel") then
Esp.Parnt[Esp.Name].TextLabel.TextColor3 = Esp.UpdateGui.ColorText
end
if (Esp.IfPart) and Esp.Parnt:FindFirstChild(Esp.Name) and Esp.Parnt[Esp.Name]:FindFirstChild("TextLabel") then
Esp.Parnt[Esp.Name].TextLabel.TextSize = Esp.UpdateGui.TextSize
end
end
end

function EspFlower()
for i, v in pairs(game.Workspace:GetChildren()) do
if v.Name == "Flower1" or v.Name == "Flower2" then
if _G.SettingToggle["Esp Flower"] == true then
EspGui({
	Parnt = v,
	Adornee = v,
	IfPart = v,
	Text = "Flower "..(v.Name == "Flower2" and "2" or v.Name == "Flower1" and "1"),
	Name = "Esp"..v.Name,
	CheckUpdate = true,
	UpdateGui = {Text = "Flower "..(v.Name == "Flower2" and "2" or v.Name == "Flower1" and "1").."\n"..math.floor(tonumber((game:GetService("Players").LocalPlayer.Character.Head.Position - v.Position).Magnitude / 3) + 0.5).." Distance"},
    Color = (v.Name == "Flower2" and Color3.fromRGB(0, 0, 255) or v.Name == "Flower1" and Color3.fromRGB(255, 0, 0))
})
elseif _G.SettingToggle["Esp Flower"] == false then
EspGui({
	Parnt = v,
	Adornee = v,
	IfPart = v,
	Name = "Esp"..v.Name,
    Remove = true
})
end
end
end
end

function EspIsland()
for i, v in pairs(workspace["_WorldOrigin"].Locations:GetChildren()) do
if _G.SettingToggle["Esp Island"] == true then
EspGui({
	Parnt = v,
	Adornee = v,
	IfPart = v,
	Text = v.Name,
	Name = "Esp"..v.Name,
	CheckUpdate = true,
	UpdateGui = {Text = v.Name.."\n"..math.floor(tonumber((game:GetService("Players").LocalPlayer.Character.Head.Position - v.Position).Magnitude / 3) + 0.5).." Distance"},
    Color = Color3.fromRGB(0, 0, 255)
})
elseif _G.SettingToggle["Esp Island"] == false then
EspGui({
    Parnt = v,
	Adornee = v,
	IfPart = v,
	Name = "Esp"..v.Name,
    Remove = true
})
end
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

function AutoHaki()
    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") == nil then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
    end
end

function Noclip(Toggle)
for i, v in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
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
	["Chờ Mods Spawn"] = CFrame.new(1038, 41, 1576)
}
else
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Trainee",
	["Tên nhiệm vụ"] = "MarineQuest",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Trainee",
	["Nhiệm vụ cần đến"] = CFrame.new(-2708, 25, 2103),
	["Chờ Mods Spawn"] = CFrame.new(-2754, 50, 2063)
}
end
elseif Level <= 14 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Monkey",
	["Tên nhiệm vụ"] = "JungleQuest",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Monkey",
	["Nhiệm vụ cần đến"] = CFrame.new(-1601, 36, 153),
	["Chờ Mods Spawn"] = CFrame.new(-1448, 50, 63)
}
elseif Level <= 29 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Gorilla",
	["Tên nhiệm vụ"] = "JungleQuest",
	["Nhiệm vụ cấp"] = 2,
	["Tên thật mobs"] = "Gorilla",
	["Nhiệm vụ cần đến"] = CFrame.new(-1601, 36, 153),
	["Chờ Mods Spawn"] = CFrame.new(-1142, 40, -515)
}
elseif Level <= 39 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Pirate",
	["Tên nhiệm vụ"] = "BuggyQuest1",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Pirate",
	["Nhiệm vụ cần đến"] = CFrame.new(-1140, 4, 3827),
	["Chờ Mods Spawn"] = CFrame.new(-1201, 40, 3857)
}
elseif Level <= 59 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Brute",
	["Tên nhiệm vụ"] = "BuggyQuest1",
	["Nhiệm vụ cấp"] = 2,
	["Tên thật mobs"] = "Brute",
	["Nhiệm vụ cần đến"] = CFrame.new(-1140, 4, 3827),
	["Chờ Mods Spawn"] = CFrame.new(-1387, 24, 4100)
}
elseif Level <= 74 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Desert Bandit",
	["Tên nhiệm vụ"] = "DesertQuest",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Desert Bandit",
	["Nhiệm vụ cần đến"] = CFrame.new(896, 6, 4390),
	["Chờ Mods Spawn"] = CFrame.new(984, 16, 4417)
}
elseif Level <= 89 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Desert Officer",
	["Tên nhiệm vụ"] = "DesertQuest",
	["Nhiệm vụ cấp"] = 2,
	["Tên thật mobs"] = "Desert Officer",
	["Nhiệm vụ cần đến"] = CFrame.new(896, 6, 4390),
	["Chờ Mods Spawn"] = CFrame.new(1547, 14, 4381)
}
elseif Level <= 99 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Snow Bandit",
	["Tên nhiệm vụ"] = "SnowQuest",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Snow Bandit",
	["Nhiệm vụ cần đến"] = CFrame.new(1384, 87, -1295),
	["Chờ Mods Spawn"] = CFrame.new(1356, 105, -1328)
}
elseif Level <= 119 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Snowman",
	["Tên nhiệm vụ"] = "SnowQuest",
	["Nhiệm vụ cấp"] = 2,
	["Tên thật mobs"] = "Snowman",
	["Nhiệm vụ cần đến"] = CFrame.new(1384, 87, -1295),
	["Chờ Mods Spawn"] = CFrame.new(1356, 105, - 1328)
}
elseif Level <= 149 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Chief Petty Officer",
	["Tên nhiệm vụ"] = "MarineQuest2",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Chief Petty Officer",
	["Nhiệm vụ cần đến"] = CFrame.new(-5035, 28, 4324),
	["Chờ Mods Spawn"] = CFrame.new(-4931, 65, 4121)
}
elseif Level <= 174 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Sky Bandit",
	["Tên nhiệm vụ"] = "SkyQuest",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Sky Bandit",
	["Nhiệm vụ cần đến"] = CFrame.new(-4842, 717, -2623),
	["Chờ Mods Spawn"] = CFrame.new(-4955, 365, -2908)
}
elseif Level <= 189 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Dark Master",
	["Tên nhiệm vụ"] = "SkyQuest",
	["Nhiệm vụ cấp"] = 2,
	["Tên thật mobs"] = "Dark Master",
	["Nhiệm vụ cần đến"] = CFrame.new(-4842, 717, -2623),
	["Chờ Mods Spawn"] = CFrame.new(-5148, 439, -2332);
}
elseif Level <= 209 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Prisoner",
	["Tên nhiệm vụ"] = "PrisonerQuest",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Prisoner",
	["Nhiệm vụ cần đến"] = CFrame.new(5310, 0, 474, 0, 0, 0, 0, 1, 0, -0, 0, 0),
	["Chờ Mods Spawn"] = CFrame.new(4937, 0, 649, 0, 0, -0, 0, 1, 0, 0, 0, 0)
}
elseif Level <= 249 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Dangerous Prisoner",
	["Tên nhiệm vụ"] = "PrisonerQuest",
	["Nhiệm vụ cấp"] = 2,
	["Tên thật mobs"] = "Dangerous Prisoner",
	["Nhiệm vụ cần đến"] = CFrame.new(5310, 0, 474, 0, 0, 0, 0, 1, 0, -0, 0, 0),
	["Chờ Mods Spawn"] = CFrame.new(5099, 0, 1055, 0, 0, -0, 0, 1, 0, 0, 0, 0)
}
end
elseif BloxFruitSea2 == true then

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
	["Esp Flower"] = false,
	["Esp Chest"] = false,
	["Esp Island"] = false,
	["Attack Aura"] = false,
	["Tween Fruit"] = false,
	["Auto Random Fruit"] = false,
	["Auto Tween Fruit"] = false,
	["Auto Store Fruit"] = false,
	----------------------------------------------
	["Tool Attack"] = "Melee",
	-----------------------------------------------
	["Walk Water"] = true,
	["Auto Haki"] = true,
	-----------------------------------------------
	["Speed Tween"] = 300,
	-----------------------------------------------
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
    Title = "Article Hub - Blox Fruit",
    Center = true,
    AutoShow = true,
    Resizable = true,
    AutoLock = true,
    ShowCustomCursor = true,
    NotifySide = "Right",
    TabPadding = 2,
    MenuFadeTime = 0
})
    
Tabs = {
	Tab = Window:AddTab("Main", "rbxassetid://7734053426"),
	Tab1 = Window:AddTab("Sea", "rbxassetid://10747376931"),
	Tab2 = Window:AddTab("Fruit", "rbxassetid://10709790875"),
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
if game:GetService("Workspace").Enemies:FindFirstChild(_G.Quest["Nhiệm vụ con mobs"]) == nil then
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, _G.Quest["Chờ Mods Spawn"], true, (_G.Quest["Chờ Mods Spawn"].Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
end
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
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, (v.HumanoidRootPart.CFrame * CFrame.new(0, 40, 0)), true, (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
v.HumanoidRootPart.Transparency = 1
v.HumanoidRootPart.CanCollide = false
v.Humanoid.JumpPower = 0
v.Humanoid.WalkSpeed = 0
FarmPos = v.HumanoidRootPart.CFrame
ModsFarm = v.Name
until _G.SettingToggle["AutoFarm Level"] == false or v.Parent == nil or v.Humanoid.Health == 0 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name) or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
BringMobs = false
FarmPos = nil
ModsFarm = nil
end
end
end
for i, v in pairs(game:GetService("Workspace")["_WorldOrigin"].EnemySpawns:GetChildren()) do
if string.find(v.Name, _G.Quest["Tên thật mobs"]) and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude >= 10 then
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, (v.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0)), true, (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
end
end
end
end
end
task.wait()
end
    end
})

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
v.HumanoidRootPart.Transparency = 1
v.HumanoidRootPart.CanCollide = false
v.Humanoid.JumpPower = 0
v.Humanoid.WalkSpeed = 0
sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
until _G.SettingToggle["AutoFarm Boss"]["Auto"] == false or v.Parent == nil or v.Humanoid.Health == 0
end
end
end
task.wait()
end
    end
})

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
for i, v in pairs(game.Workspace:GetChildren()) do
                if string.find(v.Name, "Fruit") then
                    TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Handle.CFrame, true, (v.Handle.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
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
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", (v.Name:gsub(" Fruit", "").. "-" ..v.Name:gsub(" Fruit", "")), game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(v.Name))
    end
end
for i, v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
    if string.find(v.Name, "Fruit") then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", (v.Name:gsub(" Fruit", "").. "-" ..v.Name:gsub(" Fruit", "")), game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(v.Name))
    end
end
task.wait()
end
    end
})

Fruit2Group = Tabs.Tab2:AddLeftGroupbox("Rain Fruit")
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
while _G.SettingToggle["Chip Fruit"]["Started"] do
if game:GetService("Players").LocalPlayer.PlayerGui.Main.Timer.Visible == false then
if not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Special Microchip") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Special Microchip") then
if BloxFruitSea2 then
local New = CFrame.new(-6438, 250, -4501)
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, New, true, (New.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector);
elseif BloxFruitSea3 then
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-5075, 314, - 3150))
local New = CFrame.new(- 5017.40869, 314.844055, - 2823.0127, - 0.925743818, 4.482175e-8, - 0.378151238, 4.5550315e-9, 1, 1.0737756e-7, 0.378151238, 9.768162e-8, - 0.925743818)
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, New, true, (New.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
fireclickdetector(game:GetService("Workspace").Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector);
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

local Misc1Group = Tabs.Tab8:AddLeftGroupbox("Misc")

Misc1Group:AddSlider("DistanceMods", {
    Text = "Bring Mods Distance",
    Default = 250,
    Min = 200,
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
v.HumanoidRootPart.CFrame = FarmPos
sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
end
elseif v.Name == ModsFarm then
if (v.HumanoidRootPart.Position - FarmPos.Position).Magnitude <= _G.SettingToggle["BringMods"]["Distance"] then
v.Head.CanCollide = false
v.HumanoidRootPart.CFrame = FarmPos
v.Humanoid:ChangeState(11)
v.Humanoid:ChangeState(14)
sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
end
end
end
end
end
task.wait()
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