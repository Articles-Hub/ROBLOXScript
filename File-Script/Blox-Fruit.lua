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
TweenTp(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame, true, 1)
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
EspGui({Remove = true})
end
end
end
end

function FindEnemiesInRange(GetTab, Mods)
    local HeadMods = nil
    for i, v in ipairs(Mods) do
        if not v:GetAttribute("IsBoat") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            if v:FindFirstChild("Head") and ((game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()):GetPivot().Position - v.Head.Position).Magnitude <= 60 then
                if v ~= game.Players.LocalPlayer.Character then
                    table.insert(GetTab, {v, v:FindFirstChild("Head")})
                    HeadMods = v:FindFirstChild("Head")
                end
            end
        end
    end
    for i, v in ipairs(game.Players:GetPlayers()) do
        if v.Character and v ~= game.Players.LocalPlayer then
            if v.Character:FindFirstChild("Head") and ((game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()):GetPivot().Position - v.Character.Head.Position).Magnitude <= 60 then
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
    local FindEnemies = FindEnemiesInRange(Tablet, game:GetService("Workspace").Enemies:GetChildren())
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

function CheckLevel()
local Level = game:GetService("Players").LocalPlayer.Data.Level.Value
if BloxFruitSea1 == true then
if Level <= 9 then
_G.Quest = {
	["Nhiệm vụ con mobs"] = "Bandit",
	["Tên nhiệm vụ"] = "BanditQuest1",
	["Nhiệm vụ cấp"] = 1,
	["Tên thật mobs"] = "Bandit",
	["Nhiệm vụ cần đến"] = CFrame.new(1060, 16, 1547),
	["Chờ Mods Spawn"] = CFrame.new(1038, 41, 1576)
}
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
	["Esp Flower"] = false,
	["Esp Chest"] = false,
	["Esp Island"] = false,
	["Walk Water"] = true,
	["Auto Haki"] = true,
	["Attack Aura"] = true,
	["Tween Fruit"] = false,
	["Speed Tween"] = 300,
	["Reach Attack"] = 50,
	["Tool Attack"] = "Cú Đấm",
	["Auto Random Fruit"] = false
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
	Tab8 = Window:AddTab("Misc", "rbxassetid://4370318685"),
	["UI Settings"] = Window:AddTab("UI Settings", "rbxassetid://7733955511")
}

local Main1Group = Tabs.Tab:AddLeftGroupbox("Auto Farm")

Main1Group:AddDropdown("ToolChoose", {
    Title = "Vũ Khí",
    Values = {"Cú Đấm", "Kiếm", "Trái Cây"},
    Default = 1,
    Multi = false,
    Callback = function()
_G.SettingToggle["Tool Attack"] = Value
    end
})
spawn(function()
while task.wait() do
if _G.SettingToggle["Tool Attack"] == "Cú Đấm" then
   for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
      if v.ToolTip == "Melee" then
          if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
             _G.ToolAttack = v.Name
          end
      end
  end
elseif _G.SettingToggle["Tool Attack"] == "Kiếm" then
for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
   if v.ToolTip == "Sword" then
       if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
          _G.ToolAttack = v.Name
        end
    end
end
elseif _G.SettingToggle["Tool Attack"] == "Trái Cây" then
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
    Text = "Tự Động Farm Cấp",
    Default = false,
    Callback = function(Value)
        _G.SettingToggle["AutoFarm Level"] = Value
        if Value == false then
            CancelTween()
            Noclip(true)
        end
    end
})
spawn(function()
while task.wait() do
if _G.SettingToggle["AutoFarm Level"] == true then
CheckLevel()
Noclip(false)
if not string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, _G.Quest["Nhiệm vụ con mobs"]) or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false then
   game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
   TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, _G.Quest["Nhiệm vụ cần đến"], true, (_G.Quest["Nhiệm vụ cần đến"].Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
if (_G.Quest["Nhiệm vụ cần đến"].Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", _G.Quest["Tên nhiệm vụ"], _G.Quest["Nhiệm vụ cấp"])
end
elseif string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, _G.Quest["Nhiệm vụ con mobs"]) or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
if _G.SettingToggle["AutoFarm Level"] == true and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
if v.Name == (_G.Quest["Nhiệm vụ con mobs"]) then
repeat task.wait()
AutoHaki()
EquipTool(_G.ToolAttack)
AttackNoCoolDown()
TweenTp(game.Players.LocalPlayer.Character.HumanoidRootPart, (v.HumanoidRootPart.CFrame * CFrame.new(0, 40, 0)), true, (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / _G.SettingToggle["Speed Tween"])
v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
v.HumanoidRootPart.Transparency = 1
v.HumanoidRootPart.CanCollide = false
v.Humanoid.JumpPower = 0
v.Humanoid.WalkSpeed = 0
until _G.SettingToggle["AutoFarm Level"] == false or v.Parent == nil or v.Humanoid.Health == 0 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name) or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
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
end
end)

local Misc1Group = Tabs.Tab8:AddLeftGroupbox("Misc")

Misc1Group:AddToggle("Fast Attack", {
    Text = "Tấn công nhanh",
    Default = false,
    Callback = function(Value)
_G.SettingToggle["Attack Aura"] = Value
    end
})
spawn(function()
while task.wait() do
if _G.SettingToggle["Attack Aura"] == true then
AttackNoCoolDown()
end
end
end)

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