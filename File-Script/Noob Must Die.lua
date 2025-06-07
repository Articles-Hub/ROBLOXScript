local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/Library/LinoriaLib/Test.lua"))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/Library/LinoriaLib/addons/ThemeManagerCopy.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/Library/LinoriaLib/addons/SaveManagerCopy.lua"))()
local Options = Library.Options
local Toggles = Library.Toggles

function Notification(Message, Time)
if _G.ChooseNotify == "Obsidian" then
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

Library:SetDPIScale(85)

local Window = Library:CreateWindow({
    Title = "Kill Noob",
    Center = true,
    AutoShow = true,
    Resizable = true,
    Footer = "Omega X Article Hub Version: 1.0.5",
	Icon = 125448486325517,
	AutoLock = true,
    ShowCustomCursor = true,
    NotifySide = "Right",
    TabPadding = 2,
    MenuFadeTime = 0
})

Tabs = {
	Tab = Window:AddTab("Main", "rbxassetid://7734053426"),
	Tab1 = Window:AddTab("Local", "rbxassetid://4335489011"),
	["UI Settings"] = Window:AddTab("UI Settings", "rbxassetid://7733955511")
}

local Main1Group = Tabs.Tab:AddLeftGroupbox("Kill")

Main1Group:AddToggle("KillAll", {
    Text = "Kill Aura",
    Default = false, 
    Callback = function(Value) 
_G.KillAura = Value
while _G.KillAura do
for i, v in pairs(workspace:WaitForChild("Enemies"):GetChildren()) do
if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
game:GetService("ReplicatedStorage"):WaitForChild("HurtEnemy"):FireServer(v, 30)
end
end
task.wait()
end
    end
})

Main1Group:AddToggle("BringNoob", {
    Text = "Auto Bring Noob",
    Default = false, 
    Callback = function(Value) 
_G.AutoBringNoob = Value
while _G.AutoBringNoob do
for i, v in pairs(workspace:WaitForChild("Enemies"):GetChildren()) do
if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
local ModsTarget = nil
for x, z in pairs(workspace:FindFirstChild("Bullets"):GetChildren()) do
if z.Name == "Windforce" and z:FindFirstChild("AttackerObj") and z.AttackerObj.Value == game.Players.LocalPlayer.Name then
ModsTarget = z.CFrame
end
end
if ModsTarget then
v.HumanoidRootPart.CFrame = ModsTarget
else
v.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
end
end
end
task.wait()
end
    end
})

local Main2Group = Tabs.Tab:AddRightGroupbox("Collect")

Main2Group:AddToggle("Collect Lego", {
    Text = "Auto Collect Lego",
    Default = false, 
    Callback = function(Value) 
_G.AutoCollectLego = Value
while _G.AutoCollectLego do
for i, v in pairs(workspace.Items:FindFirstChild("Studs"):GetChildren()) do
if v.Name == "Pickup" and v:FindFirstChild("Item") then
v:FindFirstChild("Item").CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
end
end
task.wait()
end
    end
})

Main2Group:AddToggle("Collect Item", {
    Text = "Auto Collect Item",
    Default = false, 
    Callback = function(Value) 
_G.AutoCollectItem = Value
while _G.AutoCollectItem do
for i, v in pairs(workspace.Items:GetChildren()) do
if v:IsA("Model") then
for f, c in pairs(v:GetChildren()) do
if c:IsA("Model") and c:FindFirstChild("Item") and c.Item:FindFirstChild("PickupPrompt") == nil then
c:FindFirstChild("Item").CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
end
end
end
end
task.wait()
end
    end
})

local Main3Group = Tabs.Tab:AddLeftGroupbox("Anti")

Main3Group:AddToggle("Anti Spikes", {
    Text = "Anti Spikes",
    Default = false, 
    Callback = function(Value) 
_G.AntiSpikes = Value
while _G.AntiSpikes do
for i, v in pairs(workspace:FindFirstChild("Bullets"):GetChildren()) do
if v.Name == "Spikes" then
v:Destroy()
end
end
task.wait()
end
    end
})

Main3Group:AddToggle("Anti Ball", {
    Text = "Anti Ball",
    Default = false, 
    Callback = function(Value) 
_G.AntiBall = Value
while _G.AntiBall do
for i, v in pairs(workspace:FindFirstChild("Bullets"):GetChildren()) do
if v:IsA("BasePart") and v.Name ~= "Windforce" and v:FindFirstChild("AttackerObj") and v.AttackerObj.Value ~= game.Players.LocalPlayer.Name then
v:Destroy()
end
end
task.wait()
end
    end
})

local Local1Group = Tabs.Tab1:AddLeftGroupbox("Speed")

Local1Group:AddSlider("WalkSpeed", {
    Text = "Speed",
    Default = 20,
    Min = 20,
    Max = 1000,
    Rounding = 0,
    Compact = true,
    Callback = function(Value)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
Walkspeed = Value
    end
})

Local1Group:AddInput("WalkSpeed1", {
    Default = "20",
    Numeric = false,
    Text = "Speed",
    Placeholder = "UserSpeed",
    Callback = function(Value)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
Walkspeed = Value
    end
})

Local1Group:AddToggle("SetSpeed", {
    Text = "Auto Set Speed",
    Default = false, 
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

------------------------------------------------------------------------
local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("Menu")
local CreditsGroup = Tabs["UI Settings"]:AddRightGroupbox("Credits")
local Info = Tabs["UI Settings"]:AddRightGroupbox("Info")

MenuGroup:AddDropdown("NotifySide", {
    Text = "Notification Side",
    Values = {"Left", "Right"},
    Default = "Right",
    Multi = false,
    Callback = function(Value)
Library:SetNotifySide(Value)
    end
})

_G.ChooseNotify = "Obsidian"
MenuGroup:AddDropdown("NotifyChoose", {
    Text = "Notification Choose",
    Values = {"Obsidian", "Roblox"},
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
_G.LinkJoin = loadstring(game:HttpGet("https://pastefy.app/2LKQlhQM/raw"))()
MenuGroup:AddButton("Copy Link Discord", function()
    if setclipboard then
        setclipboard(_G.LinkJoin["Discord"])
        Library:Notify("Copied discord link to clipboard!")
    else
        Library:Notify("Discord link: ".._G.LinkJoin["Discord"], 10)
    end
end):AddButton("Copy Link Zalo", function()
    if setclipboard then
        setclipboard(_G.LinkJoin["Zalo"])
        Library:Notify("Copied Zalo link to clipboard!")
    else
        Library:Notify("Zalo link: ".._G.LinkJoin["Zalo"], 10)
    end
end)
MenuGroup:AddButton("Unload", function() Library:Unload() end)
CreditsGroup:AddLabel("AmongUs - Python / Dex / Script", true)
CreditsGroup:AddLabel("Giang Hub - Script / Dex", true)
CreditsGroup:AddLabel("Cao Mod - Script / Dex", true)

Info:AddLabel("Counter [ "..game:GetService("LocalizationService"):GetCountryRegionForPlayerAsync(game.Players.LocalPlayer).." ]", true)
Info:AddLabel("Executor [ "..identifyexecutor().." ]", true)
Info:AddLabel("Job Id [ "..game.JobId.." ]", true)
Info:AddDivider()
Info:AddButton("Copy JobId", function()
    if setclipboard then
        setclipboard(tostring(game.JobId))
        Library:Notify("Copied Success")
    else
        Library:Notify(tostring(game.JobId), 10)
    end
end)

Info:AddInput("Join Job", {
    Default = "Nah",
    Numeric = false,
    Text = "Join Job",
    Placeholder = "UserJobId",
    Callback = function(Value)
_G.JobIdJoin = Value
    end
})

Info:AddButton("Join JobId", function()
game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, _G.JobIdJoin, game.Players.LocalPlayer)
end)

Info:AddButton("Copy Join JobId", function()
    if setclipboard then
        setclipboard('game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, '..game.JobId..", game.Players.LocalPlayer)")
        Library:Notify("Copied Success") 
    else
        Library:Notify(tostring(game.JobId), 10)
    end
end)

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])
SaveManager:LoadAutoloadConfig() 