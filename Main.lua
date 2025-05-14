_G.ScriptGame = {
	["Dead rails"] = "https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/File-Script/Dead%20rails.lua",
	["Slap Battles"] = "https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/File-Script/Slap_Battles.lua",
	["Seven Day To Live"] = "https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/File-Script/sevendaytolives.lua"
}

_G.ScriptOther = {
	["Auto Sell Tesla"] = "https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/File/Auto-Sell-Tesla-(Quest).lua",
	["AutoFarm Bond"] = "https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/File/AutoFarm-Bonds.lua",
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/Library/LinoriaLib/Test.lua"))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/Library/LinoriaLib/addons/ThemeManagerCopy.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/Library/LinoriaLib/addons/SaveManagerCopy.lua"))()
local Options = Library.Options
local Toggles = Library.Toggles
Library:SetDPIScale(85)

local Window = Library:CreateWindow({
    Title = "Choose Game Script",
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
	Tab = Window:AddTab("Main", "rbxassetid://7734053426")
}

local File1Group = Tabs.Tab:AddLeftGroupbox("File Script")

for i, v in pairs(_G.ScriptGame) do
File1Group:AddButton(i, function()
loadstring(game:HttpGet(v))()
Library:Unload()
end)
end

local File2Group = Tabs.Tab:AddRightGroupbox("File Script Other")

for i, v in pairs(_G.ScriptOther) do
File2Group:AddButton(i, function()
loadstring(game:HttpGet(v))()
Library:Unload()
end)
end