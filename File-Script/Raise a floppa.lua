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
    Title = "Raise a floppa 2",
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
	["UI Settings"] = Window:AddTab("UI Settings", "rbxassetid://7733955511")
}

local Main1Group = Tabs.Tab:AddLeftGroupbox("AutoFarm")

Main1Group:AddToggle("AutoClick", {
    Text = "Auto Click Foppa",
    Default = false, 
    Callback = function(Value) 
_G.AutoClickFoppa = Value
while _G.AutoClickFoppa do
if game.Workspace:FindFirstChild("Floppa") then
fireclickdetector(game.Workspace.Floppa:FindFirstChild("ClickDetector"))
end
task.wait()
end
    end
})

Main1Group:AddToggle("AutoClick2", {
    Text = "Auto Click Baby Foppa",
    Default = false, 
    Callback = function(Value) 
_G.AutoClickFoppaBaby = Value
while _G.AutoClickFoppaBaby do
for i,v in pairs(game.Workspace.Unlocks:GetChildren()) do
if v.Name == "Baby Floppa" and v:FindFirstChild("ClickDetector") then
fireclickdetector(v.ClickDetector)
end
end
task.wait()
end
    end
})

Main1Group:AddToggle("AutoCollect", {
    Text = "Auto Collect Money",
    Default = false, 
    Callback = function(Value) 
_G.AutoCollectMoney = Value
while _G.AutoCollectMoney do
for i,v in pairs(workspace:GetChildren()) do
if v.Name:find("Money") or v.Name == "Money Bag" or v.Name == "Gold" and v:FindFirstChildWhichIsA("TouchTransmitter") then
firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 1)
end
end
task.wait()
end
    end
})

Main1Group:AddToggle("AutoCollect2", {
    Text = "Auto Collect Gem",
    Default = false, 
    Callback = function(Value) 
_G.AutoCollectGem = Value
while _G.AutoCollectGem do
for i,v in pairs(game.Workspace:GetChildren()) do
if v.Name == "Ruby" or v.Name == "Diamond" or v.Name == "Emerald" or v.Name == "Sapphire" then
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart"), v, 0)
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart"), v, 1)
end
end
task.wait()
end
    end
})

Main1Group:AddToggle("AutoCollect3", {
    Text = "Auto Collect Milk",
    Default = false, 
    Callback = function(Value) 
_G.AutoPickUpMike = Value
while _G.AutoPickUpMike do
if game.Workspace:FindFirstChild("Milk Delivery") and game.Workspace["Milk Delivery"]:FindFirstChild("Crate") then
for i,v in ipairs(game.Workspace:FindFirstChild("Milk Delivery"):GetChildren()) do
if v.Name == "Crate" and v:FindFirstChild("ProximityPrompt") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
fireproximityprompt(v:FindFirstChild("ProximityPrompt"))
end
end
end
task.wait()
end
    end
})

Main1Group:AddButton("Buy Item", function()
for i, v in ipairs(game.Players.LocalPlayer.PlayerGui.PlayerUI["the_interwebs"].Unlocks:GetChildren()) do
if v:IsA("Frame") and not v.Name:match("Food") and not v.Name:match("food") then
if v:FindFirstChild("Purchase Button").Text ~= "Owned" then
game:GetService("ReplicatedStorage").Events.Unlock:FireServer(v.Name, "the_interwebs")
end
end
end
end)

Main1Group:AddToggle("Buy", {
    Text = "Auto Buy",
    Default = false, 
    Callback = function(Value) 
_G.AutoBuy = Value
while _G.AutoBuy do
for i, v in ipairs(game.Players.LocalPlayer.PlayerGui.PlayerUI["the_interwebs"].Unlocks:GetChildren()) do
if v:IsA("Frame") and not v.Name:match("Food") and not v.Name:match("food") then
if v:FindFirstChild("Purchase Button").Text ~= "Owned" then
if _G.AutoBuy == true then
game:GetService("ReplicatedStorage").Events.Unlock:FireServer(v.Name, "the_interwebs")
task.wait(0.1)
end
end
end
end
task.wait()
end
    end
})

local Main2Group = Tabs.Tab:AddRightGroupbox("Misc")

Main1Group:AddButton("Trash Item", function()
if game.Workspace:FindFirstChild("Key Parts") and game.Workspace["Key Parts"]:FindFirstChild("Trashcan") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace["Key Parts"]:FindFirstChild("Trashcan").CFrame
wait(0.35)
fireproximityprompt(workspace["Key Parts"].Trashcan:FindFirstChild("ProximityPrompt"))
end
end)

Main2Group:AddToggle("CleanPoop", {
    Text = "Auto Clean Poop",
    Default = false, 
    Callback = function(Value) 
_G.AutoClearPoop = Value
while _G.AutoClearPoop do
if game.Workspace:FindFirstChild("Key Parts") and game.Workspace["Key Parts"]:FindFirstChild("Litter Box") then
for i,v in pairs(workspace["Key Parts"]["Litter Box"]:GetChildren()) do
if v.Name:find("Poop") and v:FindFirstChild("PoopPart") and v:FindFirstChild("ProximityPrompt") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v:FindFirstChild("PoopPart").CFrame
fireproximityprompt(v:FindFirstChild("ProximityPrompt"))
end
end
end
for i,v in pairs(workspace:GetChildren()) do
if v.Name:find("Poop") and v:FindFirstChild("PoopPart") and v:FindFirstChild("ProximityPrompt") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v:FindFirstChild("PoopPart").CFrame
fireproximityprompt(v:FindFirstChild("ProximityPrompt"))
end
end
task.wait()
end
    end
})

Main2Group:AddToggle("CookPloppa", {
    Text = "Auto Cook Floppa",
    Default = false, 
    Callback = function(Value) 
_G.AutoCookFloppa = Value
while _G.AutoCookFloppa do
if game.Workspace:FindFirstChild("Key Parts") and game.Workspace["Key Parts"]:FindFirstChild("Bowl") and game.Workspace["Key Parts"].Bowl:FindFirstChild("Part").Transparency ~= 0 then
if game.Players.LocalPlayer.Character:FindFirstChild("Floppa Food") == nil and game.Players.LocalPlayer.Backpack:FindFirstChild("Floppa Food") == nil then
game:GetService("ReplicatedStorage").Events.Unlock:FireServer("Floppa Food", "the_interwebs")
end
wait(0.3)
repeat task.wait()
if game.Workspace:FindFirstChild("Key Parts") and game.Workspace["Key Parts"]:FindFirstChild("Bowl") then
for i,v in ipairs(game.Workspace["Key Parts"].Bowl:GetChildren()) do
if v.Name == "Part" and v:FindFirstChild("ProximityPrompt") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
fireproximityprompt(v:FindFirstChild("ProximityPrompt"))
end
end
end
until game.Workspace:FindFirstChild("Key Parts") and game.Workspace["Key Parts"]:FindFirstChild("Bowl") and game.Workspace["Key Parts"].Bowl:FindFirstChild("Part").Transparency == 0
end
task.wait(0.2)
end
    end
})

Main2Group:AddSlider("WillPet", {
    Text = "Will Pet Poppa",
    Default = 40,
    Min = 1,
    Max = 75,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
_G.HappyPet = Value
    end
})

Main2Group:AddToggle("PetPoppa", {
    Text = "Auto Pet Poppa",
    Default = false, 
    Callback = function(Value) 
_G.AutoPetPoppa = Value
while _G.AutoPetPoppa do
local Happy = game.Players.LocalPlayer.PlayerGui.FloppaUI.Frame.Floppa.Happiness.Percentage.Text:gsub("%%", "")
local Happy1 = tonumber(Happy)
if Happy1 <= _G.HappyPet then
for i,v in ipairs(game.Workspace:GetChildren()) do
if v.Name == "Floppa" and v:FindFirstChild("HumanoidRootPart") and v.HumanoidRootPart:FindFirstChild("ProximityPrompt") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
fireproximityprompt(v.HumanoidRootPart:FindFirstChild("ProximityPrompt"))
end
end
end
task.wait()
end
    end
})

Main2Group:AddToggle("FeedCatnip", {
    Text = "Auto Feed Catnip",
    Default = false, 
    Callback = function(Value) 
_G.AutoFeelCatnip = Value
while _G.AutoFeelCatnip do
local Catnip
for i, v in ipairs(game.Players.LocalPlayer.Character:GetChildren()) do
if v.Name:match("Catnip") then
Catnip = v
end
end
for i, v in ipairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
if v.Name:match("Catnip") then
Catnip = v
end
end
if Catnip ~= nil then
Catnip.Parent = game.Players.LocalPlayer.Character
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Floppa.HumanoidRootPart.CFrame
fireproximityprompt(workspace.Floppa.HumanoidRootPart.ProximityPrompt)
end
task.wait()
end
    end
})

Main2Group:AddToggle("GiveRent", {
    Text = "Auto Give Rent",
    Default = false, 
    Callback = function(Value) 
_G.AutoClaimRent = Value
while _G.AutoClaimRent do
if workspace:FindFirstChild("Rent") == nil then
game:GetService("ReplicatedStorage").Events["Collect Rent"]:FireServer()
end
task.wait(2)
if workspace:FindFirstChild("Rent") then
firetouchinterest(workspace:FindFirstChild("Rent"), game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart"), 0)
firetouchinterest(workspace:FindFirstChild("Rent"), game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart"), 1)
end
task.wait()
end
    end
})

Main2Group:AddToggle("Almond Water", {
    Text = "Auto Collect Almond Water",
    Default = false, 
    Callback = function(Value) 
_G.AutoCollectAlmondWater = Value
while _G.AutoCollectAlmondWater do
if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
repeat task.wait()
for i, v in pairs(game.Workspace.Backrooms.Rooms:FindFirstChild("Backrooms 5"):GetChildren()) do
if v.Name == "Exit" and v:FindFirstChild("Frame") and v.Frame:FindFirstChild("ProximityPrompt") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Frame.CFrame
fireproximityprompt(v.Frame:FindFirstChild("ProximityPrompt"))
end
end
until game:GetService("Players").LocalPlayer:FindFirstChild("BackroomsLevel").Value == 4
repeat task.wait()
for i,v in ipairs(game.Workspace.Backrooms:GetChildren()) do
if v.Name == "Almond Water" and v:FindFirstChild("ProximityPrompt") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
fireproximityprompt(v:FindFirstChild("ProximityPrompt"))
end
end
until game:GetService("Players").LocalPlayer:FindFirstChild("BackroomsLevel").Value == 0
end
task.wait()
end
Almost = {}
for i, v in ipairs(game.Players.LocalPlayer.Character:GetChildren()) do
    if v.Name == "Almond Water" then
        table.insert(Almost, v)
   end
end
for i, v in ipairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
     if v.Name == "Almond Water" then
         table.insert(Almost, v)
	end
end
for i, v in ipairs(Almost) do
v.Parent = game.Players.LocalPlayer.Character
end
wait(0.5)
for i = 1, #Almost do
Item = Almost[i]
repeat task.wait()
for i,v in ipairs(game.Workspace:GetChildren()) do
if v.Name == "Floppa" and v:FindFirstChild("HumanoidRootPart") and v.HumanoidRootPart:FindFirstChild("ProximityPrompt") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
fireproximityprompt(v.HumanoidRootPart:FindFirstChild("ProximityPrompt"))
end
end
until not Item:IsDescendantOf(game)
end
    end
})

Main2Group:AddToggle("Hot / Cold", {
    Text = "Auto Floppa Hot / Cold",
    Default = false, 
    Callback = function(Value) 
_G.AntiFloppaHotCold = Value
while _G.AntiFloppaHotCold do
if game.Workspace.Floppa:FindFirstChild("Moodlets") then
if game.Workspace.Floppa.Moodlets:FindFirstChild("Hot").Value == true then
if game.Workspace.World.Foliage:FindFirstChild("Lemonade Stand") then
if game.Players.LocalPlayer.Character:FindFirstChild("Lemonade") == nil and game.Players.LocalPlayer.Backpack:FindFirstChild("Lemonade") == nil then
for i,v in pairs(game.Workspace.World.Foliage:FindFirstChild("Lemonade Stand"):GetChildren()) do
if v.Name == "Handle" and v:FindFirstChild("ProximityPrompt") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
wait(0.3)
fireproximityprompt(v:FindFirstChild("ProximityPrompt"))
repeat task.wait() until game.Players.LocalPlayer.Character:FindFirstChild("Lemonade") or game.Players.LocalPlayer.Backpack:FindFirstChild("Lemonade")
end
end
end
for i,v in ipairs(game.Workspace:GetChildren()) do
if v.Name == "Floppa" and v:FindFirstChild("HumanoidRootPart") and v.HumanoidRootPart:FindFirstChild("ProximityPrompt") then
repeat task.wait()
if game.Players.LocalPlayer.Character:FindFirstChild("Lemonade") == nil then
game.Players.LocalPlayer.Backpack:FindFirstChild("Lemonade").Parent = game.Players.LocalPlayer.Character
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
fireproximityprompt(v.HumanoidRootPart:FindFirstChild("ProximityPrompt"))
until game.Workspace.Floppa:FindFirstChild("Moodlets") and game.Workspace.Floppa.Moodlets:FindFirstChild("Hot").Value == false
end
end
end
elseif game.Workspace.Floppa.Moodlets:FindFirstChild("Cold").Value == true then
if game.Workspace.World.Foliage:FindFirstChild("Hot Chocolate Stand") then
if game.Players.LocalPlayer.Character:FindFirstChild("Hot Chocolate") == nil and game.Players.LocalPlayer.Backpack:FindFirstChild("Hot Chocolate") == nil then
for i,v in pairs(game.Workspace.World.Foliage:FindFirstChild("Hot Chocolate Stand"):GetChildren()) do
if v.Name == "HotChocolate" and v:FindFirstChild("ProximityPrompt") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
wait(0.3)
fireproximityprompt(v:FindFirstChild("ProximityPrompt"))
repeat task.wait() until game.Players.LocalPlayer.Character:FindFirstChild("Hot Chocolate") or game.Players.LocalPlayer.Backpack:FindFirstChild("Hot Chocolate")
end
end
end
for i,v in ipairs(game.Workspace:GetChildren()) do
if v.Name == "Floppa" and v:FindFirstChild("HumanoidRootPart") and v.HumanoidRootPart:FindFirstChild("ProximityPrompt") then
repeat task.wait()
if game.Players.LocalPlayer.Character:FindFirstChild("Hot Chocolate") == nil then
game.Players.LocalPlayer.Backpack:FindFirstChild("Hot Chocolate").Parent = game.Players.LocalPlayer.Character
end
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
fireproximityprompt(v.HumanoidRootPart:FindFirstChild("ProximityPrompt"))
until game.Workspace.Floppa:FindFirstChild("Moodlets") and game.Workspace.Floppa.Moodlets:FindFirstChild("Cold").Value == false
end
end
end
end
end
task.wait()
end
    end
})

Main2Group:AddToggle("DJ El Gato", {
    Text = "Auto Click DJ El Gato",
    Default = false, 
    Callback = function(Value) 
_G.AutoDJElGato = Value
if workspace.Unlocks:FindFirstChild("DJ El Gato") then
while _G.AutoDJElGato do
for i, v in pairs(workspace.Unlocks:GetChildren()) do
if v.Name == "DJ El Gato" and v:FindFirstChild("Primary") and v:FindFirstChild("Cooldown").Value == 0 then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v:FindFirstChild("Primary").CFrame
fireproximityprompt(v.Primary:FindFirstChild("ProximityPrompt"))
end
end
task.wait()
end
elseif _G.AutoDJElGato == true then
Notification("You don't have buy DJ El Gato", _G.TimeNotify)
wait(0.05)
Toggles["DJ El Gato"]:SetValue(false)
end
    end
})

Main2Group:AddToggle("CubePoppa", {
    Text = "Auto Cube Foppa",
    Default = false, 
    Callback = function(Value) 
_G.AutoCubePoppa = Value
if game.Workspace.Unlocks:FindFirstChild("Altar") then
while _G.AutoCubePoppa do
if game.Workspace.Unlocks:FindFirstChild("Altar") and game.Workspace.Unlocks.Altar:FindFirstChild("Floppa Cube") then
for i,v in ipairs(game.Workspace.Unlocks.Altar["Floppa Cube"]:GetChildren()) do
if v.Name == "Floppa cube" and v:FindFirstChild("ProximityPrompt") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
fireproximityprompt(v:FindFirstChild("ProximityPrompt"))
end
end
end
task.wait()
end
elseif _G.AutoCubePoppa == true then
Notification("You don't have buy Poppa Cube", _G.TimeNotify)
wait(0.05)
Toggles["CubePoppa"]:SetValue(false)
end
    end
})

local Main3Group = Tabs.Tab:AddLeftGroupbox("Farm")

Main3Group:AddToggle("SeedPick", {
    Text = "Auto Pickup Seed",
    Default = false, 
    Callback = function(Value) 
_G.AutoPickUpSeeds = Value
while _G.AutoPickUpSeeds do
for i, v in ipairs(game.Workspace.Seeds:GetChildren()) do
if v:FindFirstChild("ProximityPrompt") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame * CFrame.new(0,2.5,0)
fireproximityprompt(v:FindFirstChild("ProximityPrompt"))
end
end
task.wait()
end
    end
})

Main3Group:AddToggle("SeedPlant", {
    Text = "Auto Plants Seed",
    Default = false, 
    Callback = function(Value) 
_G.AutoPlantSeeds = Value
while _G.AutoPlantSeeds do
Seeds = {}
for i, v in ipairs(game.Players.LocalPlayer.Character:GetChildren()) do
    if v.Name:match("Seed") or v.Name:match("Spore") then
        table.insert(Seeds, v)
   end
end
for i, v in ipairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
     if v.Name:match("Seed") or v.Name:match("Spore") then
         table.insert(Seeds, v)
	end
end
for i, v in ipairs(Seeds) do
v.Parent = game.Players.LocalPlayer.Character
end
for i, v in ipairs(workspace.Unlocks:GetChildren()) do
	if v.Name:match("Planter") and #Seeds ~= 0 then
		if v.Plant.Value == nil or v.Plant.Value == "" then
		    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v:FindFirstChild("Soil").CFrame * CFrame.new(-1,-5,0)
			fireproximityprompt(v.Soil:FindFirstChild("ProximityPrompt"))
		end
	end
end
task.wait()
end
    end
})

Main3Group:AddToggle("SeedHarvest", {
    Text = "Auto Harvest Seed",
    Default = false, 
    Callback = function(Value) 
_G.AutoHarvestPlants = Value
while _G.AutoHarvestPlants do
for i, v in ipairs(workspace.Unlocks:GetChildren()) do
	if v.Name:match("Planter") and v:FindFirstChild("Plant") and v:FindFirstChild("Growth") then
		if v.Plant.Value ~= nil and v.Growth.Value == 100 then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v:FindFirstChild("Soil").CFrame * CFrame.new(-1,-5,0)
			fireproximityprompt(v.Soil:FindFirstChild("ProximityPrompt"))
		end
	end
end
task.wait()
end
    end
})

local Main4Group = Tabs.Tab:AddRightGroupbox("Combat")

Main4Group:AddSlider("Hitbox", {
    Text = "Hitbox Enemies",
    Default = 50,
    Min = 3,
    Max = 200,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
_G.HitboxEnemies = Value
    end
})

Main4Group:AddToggle("AutoHitbox", {
    Text = "Enemies Hitbox",
    Default = false, 
    Callback = function(Value) 
_G.EnemiesHitbox = Value
if _G.EnemiesHitbox == false then
for i,v in next, game.Workspace.Enemies:GetChildren() do
if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health ~= 0 then
v.HumanoidRootPart.Size = Vector3.new(1,2,2)
v.HumanoidRootPart.CanCollide = false
v.HumanoidRootPart.Transparency = 0.75
end
end
end
while _G.EnemiesHitbox do
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health ~= 0 then
v.HumanoidRootPart.Size = Vector3.new(_G.HitboxEnemies,_G.HitboxEnemies,_G.HitboxEnemies)
v.HumanoidRootPart.CanCollide = false
v.HumanoidRootPart.Transparency = 0.75
end
end
task.wait()
end
    end
})

Main4Group:AddToggle("KillEnemies", {
    Text = "Auto Kill Enemies",
    Default = false, 
    Callback = function(Value) 
_G.AutoKillMod = Value
while _G.AutoKillMod do
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character.Humanoid.Health ~= 0 then
if game.Players.LocalPlayer.Backpack:FindFirstChild("Excalibur") == nil and game.Players.LocalPlayer.Character:FindFirstChild("Excalibur") == nil and game.Players.LocalPlayer.Backpack:FindFirstChild("Sword") == nil and game.Players.LocalPlayer.Character:FindFirstChild("Sword") == nil then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Village.SwordStore.Villager.HumanoidRootPart.CFrame
wait(0.45)
if game.Players.LocalPlayer.Backpack:FindFirstChild("Excalibur") == nil and game.Players.LocalPlayer.Character:FindFirstChild("Excalibur") == nil and game.Players.LocalPlayer.Backpack:FindFirstChild("Sword") == nil and game.Players.LocalPlayer.Character:FindFirstChild("Sword") == nil then
for i,v in pairs(workspace.Village.SwordStore.Villager.HumanoidRootPart:GetChildren()) do
if v.ClassName == "ProximityPrompt" then
fireproximityprompt(v)
end
end
end
wait(0.15)
end
end
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health ~= 0 then
if game.Players.LocalPlayer.Character.Humanoid.Health ~= 0 then
v.HumanoidRootPart.CanCollide = false
v.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-4.5)
for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
if v.Name == "Sword" or v.Name == "Excalibur" then
v.Parent = game.Players.LocalPlayer.Character
end
end
for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
if v.Name == "Sword" or v.Name == "Excalibur" then
v:Activate()
end
end
end
end
end
task.wait()
end
    end
})
----------------------------------------------------------------------------------------------------
local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("Menu")
local CreditsGroup = Tabs["UI Settings"]:AddRightGroupbox("Credits")
local Info = Tabs["UI Settings"]:AddRightGroupbox("Info")

MenuGroup:AddDropdown("NotifySide", {
    Text = "Notification Side",
    Values = {"Left", "Right"},
    Default = "Right",
    Multi = false,
    Callback = function(Value)
Library.NotifySide = Value
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

MenuGroup:AddSlider("Time Notification", {
    Text = "Time Notification",
    Default = 5,
    Min = 1,
    Max = 25,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
_G.TimeNotify = Value
    end
})

MenuGroup:AddToggle("KeybindMenuOpen", {Default = false, Text = "Open Keybind Menu", Callback = function(Value) Library.KeybindFrame.Visible = Value end})
MenuGroup:AddToggle("ShowCustomCursor", {Text = "Custom Cursor", Default = true, Callback = function(Value) Library.ShowCustomCursor = Value end})
MenuGroup:AddDivider()
MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", {Default = "RightShift", NoUI = true, Text = "Menu keybind"})
MenuGroup:AddButton("Copy Link discord", function()
    if setclipboard then
        setclipboard("https://discord.gg/ycv8aZfChd")
        Library:Notify("Copied discord link to clipboard!")
    else
        Library:Notify("Discord link: https://discord.gg/ycv8aZfChd", 10)
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
        setclipboard('game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, "'..game.JobId..'", game.Players.LocalPlayer)')
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