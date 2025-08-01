getgenv().TranslationCounter = nil
Translations = loadstring(game:HttpGet("https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/Translation/Translation.lua"))()
loadstring(game:HttpGet("https://pastefy.app/yavAjgX3/raw"))()
repeat task.wait() until TranslationCounter
if game.CoreGui:FindFirstChild("Country") then
game.CoreGui:FindFirstChild("Country"):Destroy()
end
wait(0.3)
local Name = "Rainbow Friends"
function Translation(Section, Text)
	if TranslationCounter == "English" then
		return Text
	end
	local lang = Translations[TranslationCounter]
	if lang and lang[Name] and lang[Name][Section] and lang[Name][Section][Text] then
		return lang[Name][Section][Text]
	else
		return Text
	end
end

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
    Title = "Rainbow Friend",
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
	Tab = Window:AddTab(Translation("Tab", "Main"), "rbxassetid://7734053426"),
	["UI Settings"] = Window:AddTab(Translation("Tab", "UI Settings"), "rbxassetid://7733955511")
}

local Tab1 = "Main 1"
local Main1Group = Tabs.Tab:AddLeftGroupbox(Translation("Tab", "Main"))

Main1Group:AddToggle("PickUp Item", {
    Text = Translation(Tab1, "Auto PickUp item"),
    Default = false, 
    Callback = function(Value) 
_G.ItemPick = Value
while _G.ItemPick do
if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
for i, v in pairs(game.Workspace:GetChildren()) do
if v:IsA("Model") and v:FindFirstChild("TouchTrigger") and v.TouchTrigger:FindFirstChild("TouchInterest") then
v.TouchTrigger.CFrame = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame
end
end
for i, v in pairs(workspace.ignore:GetChildren()) do
if v:IsA("Model") and v:FindFirstChild("collision") and v.collision:FindFirstChild("TouchInterest") then
v.collision.CFrame = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame
end
end
end
task.wait()
end
    end
})

Main1Group:AddButton(Translation(Tab1, "Teleport Build Structures"), function()
if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
if workspace:FindFirstChild("GroupBuildStructures") then
for i, v in pairs(workspace:FindFirstChild("GroupBuildStructures"):GetChildren()) do
if v:IsA("Model") and v:FindFirstChild("Trigger") and v.Trigger:FindFirstChild("TouchInterest") then
game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v.Trigger.CFrame * CFrame.new(0, 5, 0)
end
end
end
end
end)

local Tab2 = "Main 2"
local Main2Group = Tabs.Tab:AddRightGroupbox(Translation(Tab2, "Esp"))

Main2Group:AddToggle("Item", {
    Text = Translation(Tab2, "Esp Item"),
    Default = false, 
    Callback = function(Value) 
_G.EspItem = Value
if _G.EspItem == false then
for i, v in pairs(game.Workspace:GetChildren()) do
if v:IsA("Model") and v:FindFirstChild("TouchTrigger") then
for i, x in pairs(v:FindFirstChild("TouchTrigger"):GetChildren()) do
if x.Name:find("Esp_") then
x:Destroy()
end
end
end
end
end
while _G.EspItem do
for i, v in pairs(game.Workspace:GetChildren()) do
if v:IsA("Model") and v:FindFirstChild("TouchTrigger") then
if v.TouchTrigger:FindFirstChild("Esp_Highlight") then
	v.TouchTrigger:FindFirstChild("Esp_Highlight").FillColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
	v.TouchTrigger:FindFirstChild("Esp_Highlight").OutlineColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
end
if _G.EspHighlight == true and v.TouchTrigger:FindFirstChild("Esp_Highlight") == nil then
	local Highlight = Instance.new("Highlight")
	Highlight.Name = "Esp_Highlight"
	Highlight.FillColor = Color3.fromRGB(255, 255, 255) 
	Highlight.OutlineColor = Color3.fromRGB(255, 255, 255) 
	Highlight.FillTransparency = 0.5
	Highlight.OutlineTransparency = 0
	Highlight.Adornee = v.TouchTrigger
	Highlight.Parent = v.TouchTrigger
	elseif _G.EspHighlight == false and v.TouchTrigger:FindFirstChild("Esp_Highlight") then
	v.TouchTrigger:FindFirstChild("Esp_Highlight"):Destroy()
end
if v.TouchTrigger:FindFirstChild("Esp_Gui") and v.TouchTrigger["Esp_Gui"]:FindFirstChild("TextLabel") then
	v.TouchTrigger["Esp_Gui"]:FindFirstChild("TextLabel").Text = 
	        (_G.EspName == true and v.Name or "")..
            (_G.EspDistance == true and "\nDistance ("..string.format("%.0f", (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.TouchTrigger.Position).Magnitude).."m)" or "")
    v.TouchTrigger["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 15
    v.TouchTrigger["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(255, 255, 255)
end
if _G.EspGui == true and v.TouchTrigger:FindFirstChild("Esp_Gui") == nil then
	GuiItemEsp = Instance.new("BillboardGui", v.TouchTrigger)
	GuiItemEsp.Adornee = v.TouchTrigger
	GuiItemEsp.Name = "Esp_Gui"
	GuiItemEsp.Size = UDim2.new(0, 100, 0, 150)
	GuiItemEsp.AlwaysOnTop = true
	GuiItemEsp.StudsOffset = Vector3.new(0, 3, 0)
	GuiItemEspText = Instance.new("TextLabel", GuiItemEsp)
	GuiItemEspText.BackgroundTransparency = 1
	GuiItemEspText.Font = Enum.Font.Code
	GuiItemEspText.Size = UDim2.new(0, 100, 0, 100)
	GuiItemEspText.TextSize = 15
	GuiItemEspText.TextColor3 = Color3.new(0,0,0) 
	GuiItemEspText.TextStrokeTransparency = 0.5
	GuiItemEspText.Text = ""
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Color = Color3.new(0, 0, 0)
	UIStroke.Thickness = 1.5
	UIStroke.Parent = GuiItemEspText
	elseif _G.EspGui == false and v.TouchTrigger:FindFirstChild("Esp_Gui") then
	v.TouchTrigger:FindFirstChild("Esp_Gui"):Destroy()
end
end
end
task.wait()
end
    end
})

Main2Group:AddToggle("Monsters", {
    Text = Translation(Tab2, "Esp Monsters"),
    Default = false, 
    Callback = function(Value) 
_G.EspMonsters = Value
if _G.EspMonsters == false then
for i, v in pairs(game.Workspace.Monsters:GetChildren()) do
if v:IsA("Model") then
for i, x in pairs(v:FindFirstChild("HumanoidRootPart"):GetChildren()) do
if x.Name:find("Esp_") then
x:Destroy()
end
end
end
end
end
while _G.EspMonsters do
for i, v in pairs(game.Workspace.Monsters:GetChildren()) do
if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then
if v.HumanoidRootPart:FindFirstChild("Esp_Highlight") then
	v.HumanoidRootPart:FindFirstChild("Esp_Highlight").FillColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
	v.HumanoidRootPart:FindFirstChild("Esp_Highlight").OutlineColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
end
if _G.EspHighlight == true and v.HumanoidRootPart:FindFirstChild("Esp_Highlight") == nil then
	local Highlight = Instance.new("Highlight")
	Highlight.Name = "Esp_Highlight"
	Highlight.FillColor = Color3.fromRGB(255, 255, 255) 
	Highlight.OutlineColor = Color3.fromRGB(255, 255, 255) 
	Highlight.FillTransparency = 0.5
	Highlight.OutlineTransparency = 0
	Highlight.Adornee = v
	Highlight.Parent = v.HumanoidRootPart
	elseif _G.EspHighlight == false and v.HumanoidRootPart:FindFirstChild("Esp_Highlight") then
	v.HumanoidRootPart:FindFirstChild("Esp_Highlight"):Destroy()
end
if v.HumanoidRootPart:FindFirstChild("Esp_Gui") and v.HumanoidRootPart["Esp_Gui"]:FindFirstChild("TextLabel") then
	v.HumanoidRootPart["Esp_Gui"]:FindFirstChild("TextLabel").Text = 
	        (_G.EspName == true and v.Name or "")..
            (_G.EspDistance == true and "\nDistance ("..string.format("%.0f", (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude).."m)" or "")
    v.HumanoidRootPart["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 15
    v.HumanoidRootPart["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(255, 255, 255)
end
if _G.EspGui == true and v.HumanoidRootPart:FindFirstChild("Esp_Gui") == nil then
	GuiItemEsp = Instance.new("BillboardGui", v.HumanoidRootPart)
	GuiItemEsp.Adornee = v.HumanoidRootPart
	GuiItemEsp.Name = "Esp_Gui"
	GuiItemEsp.Size = UDim2.new(0, 100, 0, 150)
	GuiItemEsp.AlwaysOnTop = true
	GuiItemEsp.StudsOffset = Vector3.new(0, 3, 0)
	GuiItemEspText = Instance.new("TextLabel", GuiItemEsp)
	GuiItemEspText.BackgroundTransparency = 1
	GuiItemEspText.Font = Enum.Font.Code
	GuiItemEspText.Size = UDim2.new(0, 100, 0, 100)
	GuiItemEspText.TextSize = 15
	GuiItemEspText.TextColor3 = Color3.new(0,0,0) 
	GuiItemEspText.TextStrokeTransparency = 0.5
	GuiItemEspText.Text = ""
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Color = Color3.new(0, 0, 0)
	UIStroke.Thickness = 1.5
	UIStroke.Parent = GuiItemEspText
	elseif _G.EspGui == false and v.HumanoidRootPart:FindFirstChild("Esp_Gui") then
	v.HumanoidRootPart:FindFirstChild("Esp_Gui"):Destroy()
end
end
end
task.wait()
end
    end
})

Main2Group:AddDivider()

_G.EspHighlight = false
Main2Group:AddToggle("Esp Hight Light", {
    Text = Translation(Tab2, "Esp Hight Light"),
    Default = false, 
    Callback = function(Value) 
_G.EspHighlight = Value
    end
}):AddColorPicker("Color Esp", {
     Default = Color3.new(255,255,255),
     Callback = function(Value)
_G.ColorLight = Value
     end
})

_G.EspGui = false
Main2Group:AddToggle("Esp Gui", {
    Text = Translation(Tab2, "Esp Gui"),
    Default = false, 
    Callback = function(Value) 
_G.EspGui = Value
    end
}):AddColorPicker("Color Esp Text", {
     Default = Color3.new(255,255,255),
     Callback = function(Value)
_G.EspGuiTextColor = Value
     end
})

Main2Group:AddSlider("Text Size", {
    Text = Translation(Tab2, "Text Size [ Gui ]"),
    Default = 7,
    Min = 7,
    Max = 50,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
_G.EspGuiTextSize = Value
    end
})

Main2Group:AddDivider()

_G.EspName = false
Main2Group:AddToggle("Esp Name", {
    Text = Translation(Tab2, "Esp Name"),
    Default = false, 
    Callback = function(Value) 
_G.EspName = Value
    end
})

_G.EspDistance = false
Main2Group:AddToggle("Esp Distance", {
    Text = Translation(Tab2, "Esp Distance"),
    Default = false, 
    Callback = function(Value) 
_G.EspDistance = Value
    end
})

_G.EspHealth = false
Main2Group:AddToggle("Esp Health", {
    Text = Translation(Tab2, "Esp Health"),
    Default = false, 
    Callback = function(Value) 
_G.EspHealth = Value
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
CreditsGroup:AddLabel("Vu - Script / Dex", true)

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