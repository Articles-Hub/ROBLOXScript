if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.CoreGui:FindFirstChild("Gun Health Track") == nil then
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "Gun Health Track"
gui.Enabled = false

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0.2, 0, 0.1, 0)
Frame.Position = UDim2.new(0.02, 0, 0.87, 0)
Frame.BackgroundColor3 = Color3.new(1, 1, 1)
Frame.BorderColor3 = Color3.new(0, 0, 0)
Frame.BorderSizePixel = 1
Frame.Active = true
Frame.BackgroundTransparency = 0 
Frame.Parent = gui

local UICorner = Instance.new("UIStroke")
UICorner.Color = Color3.new(0, 0, 0)
UICorner.Thickness = 3
UICorner.Parent = Frame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 5)
UICorner.Parent = Frame

local Frame1 = Instance.new("Frame")
Frame1.Size = UDim2.new(1, 0, 1, 0)
Frame1.Position = UDim2.new(0, 0, 0, 0)
Frame1.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
Frame1.BorderColor3 = Color3.new(0, 0, 0)
Frame1.BorderSizePixel = 1
Frame1.Active = true
Frame1.BackgroundTransparency = 0 
Frame1.Parent = Frame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 5)
UICorner.Parent = Frame1

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(1, 0, 1, 0)
TextLabel.Position = UDim2.new(0, 0, 0, 0)
TextLabel.BackgroundColor3 = Color3.new(0, 0, 0)
TextLabel.BorderColor3 = Color3.new(0, 0, 0)
TextLabel.BorderSizePixel = 1
TextLabel.Text = ""
TextLabel.TextSize = 15
TextLabel.BackgroundTransparency = 1
TextLabel.TextColor3 = Color3.new(0, 0, 0)
TextLabel.Font = Enum.Font.Code
TextLabel.TextWrapped = true
TextLabel.Parent = Frame
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

local Window = Library:CreateWindow({
    Title = "Omega X Article Hub - Dead Rails",
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
	Tab1 = Window:AddTab("Misc", "rbxassetid://4370318685"),
	["UI Settings"] = Window:AddTab("UI Settings", "rbxassetid://7733955511")
}

local Main1Group = Tabs.Tab:AddLeftGroupbox("Main")

if workspace:FindFirstChild("Train") then
if workspace.Train:FindFirstChild("Fuel") then
FuelTrain = Main1Group:AddLabel("Fuel Train [ "..workspace.Train:FindFirstChild("Fuel").Value.." ]", true)
else
FuelTrain = Main1Group:AddLabel("Fuel Train [ 0 ]", true)
end
if workspace.Train:FindFirstChild("TrainControls") and workspace.Train.TrainControls:FindFirstChild("DistanceDial") and workspace.Train.TrainControls.DistanceDial:FindFirstChild("SurfaceGui") then
DistanceTrain = Main1Group:AddLabel("Distance [ "..workspace.Train.TrainControls.DistanceDial.SurfaceGui:FindFirstChild("TextLabel").Text.." ]", true)
else
DistanceTrain = Main1Group:AddLabel("Distance [ Nah ]", true)
end
Time = Main1Group:AddLabel("Time [ "..game:GetService("ReplicatedStorage").TimeHour.Value.." ]", true)

Main1Group:AddToggle("Return Check", {
    Text = "Return Check",
    Default = false, 
    Callback = function(Value) 
_G.ReturnCheck = Value
while _G.ReturnCheck do
if workspace.Train:FindFirstChild("Fuel") then
FuelTrain:SetText("Fuel Train [ "..workspace.Train:FindFirstChild("Fuel").Value.." ]")
else
FuelTrain:SetText("Fuel Train [ 0 ]", true)
end
if workspace.Train:FindFirstChild("TrainControls") and workspace.Train.TrainControls:FindFirstChild("DistanceDial") and workspace.Train.TrainControls.DistanceDial:FindFirstChild("SurfaceGui") then
DistanceTrain:SetText("Distance [ "..workspace.Train.TrainControls.DistanceDial.SurfaceGui:FindFirstChild("TextLabel").Text.." ]")
else
DistanceTrain:SetText("Distance [ Nah ]")
end
Time:SetText("Time [ "..game:GetService("ReplicatedStorage").TimeHour.Value.." ]")
task.wait()
end
    end
})
end

Main1Group:AddToggle("No Cooldown Proximity", {
    Text = "No Cooldown Proximity",
    Default = false, 
    Callback = function(Value) 
_G.NoCooldownProximity = Value
if _G.NoCooldownProximity == true then
for i, v in pairs(workspace:GetDescendants()) do
if v.ClassName == "ProximityPrompt" then
v.HoldDuration = 0
end
end
else
if CooldownProximity then
CooldownProximity:Disconnect()
CooldownProximity = nil
end
end
CooldownProximity = workspace.DescendantAdded:Connect(function(Cooldown)
if _G.NoCooldownProximity == true then
if Cooldown:IsA("ProximityPrompt") then
Cooldown.HoldDuration = 0
end
end
end)
    end
})

Main1Group:AddToggle("Unlock Person", {
    Text = "Unlock Person",
    Default = false, 
    Callback = function(Value) 
_G.UnlockPerson = Value
if _G.UnlockPerson then
game.Players.LocalPlayer.CameraMode = "Classic"
game.Players.LocalPlayer.CameraMaxZoomDistance = math.huge
game.Players.LocalPlayer.CameraMinZoomDistance = 0
else
game.Players.LocalPlayer.CameraMode = "LockFirstPerson"
end
    end
})

if workspace:FindFirstChild("Train") then
Main1Group:AddToggle("Auto Fuel", {
    Text = "Auto Fuel Train",
    Default = false, 
    Callback = function(Value) 
_G.FuelTrain = Value
while _G.FuelTrain do
for i, v in pairs(workspace.RuntimeItems:GetChildren()) do
if v.ClassName == "Model" and v:FindFirstChild("ObjectInfo") and v.PrimaryPart ~= nil and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.PrimaryPart.Position).Magnitude < 5 then
for h, m in pairs(v.ObjectInfo:GetChildren()) do
if m.Name == "TextLabel" and m.Text == "Fuel" and m.Text ~= "Valuable" and m.Text ~= "Bounty" then
game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent.RequestStartDrag:FireServer(v)
wait(0.3)
v:SetPrimaryPartCFrame(workspace.Train.TrainControls:FindFirstChild("FuelDetect").CFrame)
wait(0.3)
game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent.RequestStopDrag:FireServer()
end
end
end
end
task.wait()
end
    end
}):AddKeyPicker("AutoFuel", {
   Default = "J",
   Text = "Auto Fuel",
   Mode = "Toggle",
   SyncToggleState = true
})

Main1Group:AddButton("Fuel Train", function()
for i, v in pairs(workspace.RuntimeItems:GetChildren()) do
if v.ClassName == "Model" and v:FindFirstChild("ObjectInfo") and v.PrimaryPart ~= nil and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.PrimaryPart.Position).Magnitude < 10 then
for h, m in pairs(v.ObjectInfo:GetChildren()) do
if m.Name == "TextLabel" and m.Text == "Fuel" and m.Text ~= "Valuable" and m.Text ~= "Bounty" then
game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent.RequestStartDrag:FireServer(v)
wait(0.3)
v:SetPrimaryPartCFrame(workspace.Train.TrainControls:FindFirstChild("FuelDetect").CFrame)
wait(0.3)
game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent.RequestStopDrag:FireServer()
end
end
end
end
end)
end

Main1Group:AddToggle("Auto Sell", {
    Text = "Auto Sell",
    Default = false, 
    Callback = function(Value) 
_G.SellItem = Value
while _G.SellItem do
for i, v in pairs(workspace.RuntimeItems:GetChildren()) do
if v.Name ~= "Rock" and v:FindFirstChild("ObjectInfo") and v.PrimaryPart ~= nil and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.PrimaryPart.Position).Magnitude < 7 then
for h, m in pairs(v.ObjectInfo:GetChildren()) do
if m.Name == "TextLabel" then
if m.Text == "Valuable" or m.Text == "Junk" or m.Text == "Gun" then
if workspace:FindFirstChild("SafeZones") and workspace.SafeZones:FindFirstChild("SafeZone") and workspace.SafeZones.SafeZone:FindFirstChild("Buildings") then
for z, j in pairs(workspace.SafeZones.SafeZone.Buildings:GetChildren()) do
if j.Name:find("Trading") and j:FindFirstChild("BountySquare") then
for k, w in pairs(j.BountySquare:GetChildren()) do
if w.Name == "Part" and w:FindFirstChild("SurfaceGui") and w.SurfaceGui:FindFirstChild("TextLabel") then
game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent.RequestStartDrag:FireServer(v)
wait(0.3)
spawn(function()
for i = 1, 60 do
if v.PrimaryPart ~= nil then
v:SetPrimaryPartCFrame(w.CFrame)
end
task.wait()
end
end)
task.wait(0.3)
game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent.RequestStopDrag:FireServer()
end
end
end
end
end
elseif m.Text == "Bounty" then
if workspace:FindFirstChild("SafeZones") and workspace.SafeZones:FindFirstChild("SafeZone") and workspace.SafeZones.SafeZone:FindFirstChild("Buildings") then
for z, j in pairs(workspace.SafeZones.SafeZone.Buildings:GetChildren()) do
if j.Name:find("Sheriffs") and j:FindFirstChild("BountySquare") then
for z, w in pairs(j.BountySquare:GetChildren()) do
if w.Name == "Part" and w:FindFirstChild("SurfaceGui") and w.SurfaceGui:FindFirstChild("TextLabel") then
game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent.RequestStartDrag:FireServer(v)
wait(0.3)
v:SetPrimaryPartCFrame(w.CFrame)
task.wait(0.3)
game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent.RequestStopDrag:FireServer()
end
end
end
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
}):AddKeyPicker("AutoSell", {
   Default = "L",
   Text = "Auto Sell",
   Mode = "Toggle",
   SyncToggleState = true
})

Main1Group:AddToggle("Auto Store Item", {
    Text = "Auto Store Item",
    Default = false, 
    Callback = function(Value) 
_G.StoreItem = Value
while _G.StoreItem do
for i, v in pairs(workspace.RuntimeItems:GetChildren()) do
if v.Name ~= "Rock" and v:FindFirstChild("HumanoidRootPart") == nil and v.PrimaryPart ~= nil and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.PrimaryPart.Position).Magnitude < 20 then
if game.Players.LocalPlayer.Character:FindFirstChild("Sack") and game.Players.LocalPlayer.Character.Sack:FindFirstChild("BillboardGui") and game.Players.LocalPlayer.Character.Sack.BillboardGui:FindFirstChild("TextLabel") then
if game.Players.LocalPlayer.Character.Sack.BillboardGui.TextLabel.Text ~= (game.Players.LocalPlayer.Character.Sack.SackSettings:FindFirstChild("Limit").Value.."/"..game.Players.LocalPlayer.Character.Sack.SackSettings:FindFirstChild("Limit").Value) then
game:GetService("ReplicatedStorage").Remotes.StoreItem:FireServer(v)
end
end
end
end
task.wait()
end
    end
}):AddKeyPicker("AutoStore Item", {
   Default = "Y",
   Text = "Auto Store Item",
   Mode = "Toggle",
   SyncToggleState = true
})

Main1Group:AddButton("Complete Assembly Tesla", function()
if workspace:FindFirstChild("TeslaLab") and workspace.TeslaLab:FindFirstChild("ExperimentTable") then
local Tesla = workspace.TeslaLab.ExperimentTable:FindFirstChild("PlacedParts")
for i, v in pairs(Testla:GetChildren()) do
if v.Name:find("Werewolf") or v.Name == "BrainJar" then
if v.PrimaryPart ~= nil and v.PrimaryPart.Transparency ~= 1 then
if v:FindFirstChild("PartEsp") then
local Highlight = Instance.new("Highlight")
Highlight.Name = "PartEsp"
Highlight.FillColor = Color3.fromRGB(0, 255, 0) 
Highlight.OutlineColor = Color3.fromRGB(255, 255, 255) 
Highlight.FillTransparency = 0.5
Highlight.OutlineTransparency = 0
Highlight.Adornee = v
Highlight.Parent = v
end
repeat task.wait()
for i, v in pairs(workspace.RuntimeItems:GetChildren()) do
if v.Name:find("Werewolf") or v.Name == "BrainJar" then
if v:FindFirstChild("HumanoidRootPart") == nil and v.PrimaryPart ~= nil and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.PrimaryPart.Position).Magnitude < 10 then
game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent.RequestStartDrag:FireServer(v)
wait(0.3)
v:SetPrimaryPartCFrame(workspace.TeslaLab.ExperimentTable:FindFirstChild("Hitbox").CFrame)
task.wait(0.3)
game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent.RequestStopDrag:FireServer()
end
end
end
until v.PrimaryPart.Transparency <= 0
else
if workspace.TeslaLab:FindFirstChild("Generator") then
for i, v in pairs(workspace.TeslaLab.Generator:GetChildren()) do
if v:IsA("BasePart") and v:FindFirstChild("PowerEsp") == nil and v:FindFirstChild("PowerPrompt") then
Notification("Successful Assembly, you must reap to fight to get the Electricity gun", 5)
local Highlight = Instance.new("Highlight")
Highlight.Name = "PowerEsp"
Highlight.FillColor = Color3.fromRGB(0, 255, 0) 
Highlight.OutlineColor = Color3.fromRGB(255, 255, 255) 
Highlight.FillTransparency = 0.5
Highlight.OutlineTransparency = 0
Highlight.Adornee = v
Highlight.Parent = v
end
end
end
end
end
end
wait(0.2)
if workspace.TeslaLab:FindFirstChild("Generator") then
for i, v in pairs(workspace.TeslaLab.Generator:GetChildren()) do
if v:IsA("BasePart") and v:FindFirstChild("PowerEsp") == nil and v:FindFirstChild("PowerPrompt") then
Notification("Successful Assembly, you must reap to fight to get the Electricity gun", 5)
local Highlight = Instance.new("Highlight")
Highlight.Name = "PowerEsp"
Highlight.FillColor = Color3.fromRGB(0, 255, 0) 
Highlight.OutlineColor = Color3.fromRGB(255, 255, 255) 
Highlight.FillTransparency = 0.5
Highlight.OutlineTransparency = 0
Highlight.Adornee = v
Highlight.Parent = v
end
end
end
else
Notification("Testla don't have spawn", 5)
end
end)

Main1Group:AddSlider("Powerfull Clever", {
    Text = "Powerfull Clever",
    Default = 100,
    Min = 10,
    Max = 280,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
_G.PowerfullClever = Value
    end
})

Main1Group:AddButton("Clever", function()
CFrameCamera = game.Workspace.CurrentCamera.CFrame
local CameraWait = game:GetService("TweenService"):Create(game.Workspace.CurrentCamera, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = game.Workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -_G.PowerfullClever)})
CameraWait:Play()
CameraWait.Completed:Connect(function()
    game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent.RequestStopDrag:FireServer()
end)
task.wait(0.5)
game:GetService("TweenService"):Create(game.Workspace.CurrentCamera, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {CFrame = CFrameCamera}):Play()
end)

local Main2Group = Tabs.Tab:AddRightGroupbox("Esp")

if workspace:FindFirstChild("Train") then
Main2Group:AddToggle("Train", {
    Text = "Esp Train",
    Default = false, 
    Callback = function(Value) 
_G.EspTrain = Value
if _G.EspTrain == false then
if game.Workspace:FindFirstChild("Train") then
	for i, v in pairs(game.Workspace.Train:GetChildren()) do
		if v.Name:find("Esp_") then
			v:Destroy()
			end
		end
	end
end
while _G.EspTrain do
for i, v in pairs(game.Workspace:GetChildren()) do
if v.Name == "Train" then
if v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight").FillColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
	v:FindFirstChild("Esp_Highlight").OutlineColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
end
if _G.EspHighlight == true and v:FindFirstChild("Esp_Highlight") == nil then
	local Highlight = Instance.new("Highlight")
	Highlight.Name = "Esp_Highlight"
	Highlight.FillColor = Color3.fromRGB(255, 255, 255) 
	Highlight.OutlineColor = Color3.fromRGB(255, 255, 255) 
	Highlight.FillTransparency = 0.5
	Highlight.OutlineTransparency = 0
	Highlight.Adornee = v
	Highlight.Parent = v
	elseif _G.EspHighlight == false and v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight"):Destroy()
end
if v:FindFirstChild("Esp_Gui") and v["Esp_Gui"]:FindFirstChild("TextLabel") then
	v["Esp_Gui"]:FindFirstChild("TextLabel").Text = 
	        (_G.EspName == true and "Train" or "")..
            (_G.EspDistance == true and "\nDistance [ "..string.format("%.1f", (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.TrainControls.ConductorSeat:FindFirstChild("VehicleSeat").Position).Magnitude).." ]" or "")..
            (_G.EspDistanceTrain == true and " / [ "..workspace.Train.TrainControls.DistanceDial.SurfaceGui:FindFirstChild("TextLabel").Text.." ]" or "")..
            (_G.EspTime == true and "\nTime [ "..game:GetService("ReplicatedStorage").TimeHour.Value.." ]" or "")..
            (_G.EspFeel == true and " / Fuel [ "..workspace.Train:FindFirstChild("Fuel").Value.." ]" or "")
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = (_G.EspGuiTextSize == nil and 20 or _G.EspGuiTextSize)
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = (_G.EspGuiTextColor == nil and Color3.new(0,0,0) or _G.EspGuiTextColor)
end
if _G.EspGui == true and v:FindFirstChild("Esp_Gui") == nil then
	GuiTrainEsp = Instance.new("BillboardGui", v)
	GuiTrainEsp.Adornee = v
	GuiTrainEsp.Name = "Esp_Gui"
	GuiTrainEsp.Size = UDim2.new(0, 100, 0, 150)
	GuiTrainEsp.AlwaysOnTop = true
	GuiTrainEsp.StudsOffset = Vector3.new(0, 3, 0)
	GuiTrainEspText = Instance.new("TextLabel", GuiTrainEsp)
	GuiTrainEspText.BackgroundTransparency = 1
	GuiTrainEspText.Font = Enum.Font.SourceSansBold
	GuiTrainEspText.Size = UDim2.new(0, 100, 0, 100)
	GuiTrainEspText.TextSize = 20
	GuiTrainEspText.TextColor3 = Color3.new(0,0,0) 
	GuiTrainEspText.TextStrokeTransparency = 0.5
	GuiTrainEspText.Text = ""
	elseif _G.EspGui == false and v:FindFirstChild("Esp_Gui") then
	v:FindFirstChild("Esp_Gui"):Destroy()
end
end
end
task.wait()
end
    end
})

_G.EspFeel = false
Main2Group:AddToggle("Esp Fuel", {
    Text = "Esp Fuel",
    Default = false, 
    Callback = function(Value) 
_G.EspFeel = Value
    end
})

_G.EspTime = false
Main2Group:AddToggle("Esp Time", {
    Text = "Esp Time",
    Default = false, 
    Callback = function(Value) 
_G.EspTime = Value
    end
})

_G.EspDistanceTrain = false
Main2Group:AddToggle("Esp Distance Train", {
    Text = "Esp Distance (m)",
    Default = false, 
    Callback = function(Value) 
_G.EspDistanceTrain = Value
    end
})

Main2Group:AddDivider()
end

Main2Group:AddToggle("Ore", {
    Text = "Esp Ore",
    Default = false, 
    Callback = function(Value) 
_G.EspOrb = Value
if _G.EspOrb == false then
if game.Workspace:FindFirstChild("Ore") then
	for i, v in pairs(game.Workspace.Ore:GetChildren()) do
		if v:IsA("Model") and v.Name:find("Esp_") then
			v:Destroy()
			end
		end
	end
end
while _G.EspOrb do
if game.Workspace:FindFirstChild("Ore") then
for i, v in pairs(game.Workspace.Ore:GetChildren()) do
if v:IsA("Model") and v:FindFirstChild("Health") and v:FindFirstChild("Boulder_a") then
if v["Boulder_a"]:FindFirstChild("Esp_Highlight") then
	v["Boulder_a"]:FindFirstChild("Esp_Highlight").FillColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
	v["Boulder_a"]:FindFirstChild("Esp_Highlight").OutlineColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
end
if _G.EspHighlight == true and v["Boulder_a"]:FindFirstChild("Esp_Highlight") == nil then
	local Highlight = Instance.new("Highlight")
	Highlight.Name = "Esp_Highlight"
	Highlight.FillColor = Color3.fromRGB(255, 255, 255) 
	Highlight.OutlineColor = Color3.fromRGB(255, 255, 255) 
	Highlight.FillTransparency = 0.5
	Highlight.OutlineTransparency = 0
	Highlight.Adornee = v
	Highlight.Parent = v["Boulder_a"]
	elseif _G.EspHighlight == false and v["Boulder_a"]:FindFirstChild("Esp_Highlight") then
	v["Boulder_a"]:FindFirstChild("Esp_Highlight"):Destroy()
end
if v["Boulder_a"]:FindFirstChild("Esp_Gui") and v["Boulder_a"]["Esp_Gui"]:FindFirstChild("TextLabel") then
	v["Boulder_a"]["Esp_Gui"]:FindFirstChild("TextLabel").Text = 
	        (_G.EspName == true and v.Name or "")..
            (_G.EspDistance == true and "\nDistance [ "..string.format("%.1f", (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v["Boulder_a"].Position).Magnitude).." ]" or "")..
            (_G.EspHealth == true and "\nHealth [ "..v.Health.Value.." ]" or "")
    v["Boulder_a"]["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 15
    v["Boulder_a"]["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(0,0,0)
end
if _G.EspGui == true and v["Boulder_a"]:FindFirstChild("Esp_Gui") == nil then
	GuiOreEsp = Instance.new("BillboardGui", v["Boulder_a"])
	GuiOreEsp.Adornee = v
	GuiOreEsp.Name = "Esp_Gui"
	GuiOreEsp.Size = UDim2.new(0, 100, 0, 150)
	GuiOreEsp.AlwaysOnTop = true
	GuiOreEsp.StudsOffset = Vector3.new(0, 3, 0)
	GuiOreEspText = Instance.new("TextLabel", GuiOreEsp)
	GuiOreEspText.BackgroundTransparency = 1
	GuiOreEspText.Font = Enum.Font.SourceSansBold
	GuiOreEspText.Size = UDim2.new(0, 100, 0, 100)
	GuiOreEspText.TextSize = 15
	GuiOreEspText.TextColor3 = Color3.new(0,0,0) 
	GuiOreEspText.TextStrokeTransparency = 0.5
	GuiOreEspText.Text = ""
	elseif _G.EspGui == false and v["Boulder_a"]:FindFirstChild("Esp_Gui") then
	v["Boulder_a"]:FindFirstChild("Esp_Gui"):Destroy()
end
end
end
end
task.wait()
end
    end
})

Main2Group:AddToggle("Player", {
    Text = "Esp Player",
    Default = false, 
    Callback = function(Value) 
_G.EspPlayer = Value
if _G.EspPlayer == false then
for i, v in pairs(game.Players:GetChildren()) do
	if v.Character then
		if v.Character:FindFirstChild("Esp_Highlight") then
			v.Character:FindFirstChild("Esp_Highlight"):Destroy()
		end
		if v.Character.Head:FindFirstChild("Esp_Gui") then
			v.Character.Head:FindFirstChild("Esp_Gui"):Destroy()
		end
	end
end
end
while _G.EspPlayer do
for i, v in pairs(game.Players:GetChildren()) do
if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") then
if v.Character:FindFirstChild("Esp_Highlight") then
	v.Character:FindFirstChild("Esp_Highlight").FillColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
	v.Character:FindFirstChild("Esp_Highlight").OutlineColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
end
if _G.EspHighlight == true and v.Character:FindFirstChild("Esp_Highlight") == nil then
	local Highlight = Instance.new("Highlight")
	Highlight.Name = "Esp_Highlight"
	Highlight.FillColor = Color3.fromRGB(255, 255, 255) 
	Highlight.OutlineColor = Color3.fromRGB(255, 255, 255) 
	Highlight.FillTransparency = 0.5
	Highlight.OutlineTransparency = 0
	Highlight.Adornee = v
	Highlight.Parent = v
	elseif _G.EspHighlight == false and v.Character:FindFirstChild("Esp_Highlight") then
	v.Character:FindFirstChild("Esp_Highlight"):Destroy()
end
if v.Character.Head:FindFirstChild("Esp_Gui") and v.Character.Head["Esp_Gui"]:FindFirstChild("TextLabel") then
	v.Character.Head["Esp_Gui"]:FindFirstChild("TextLabel").Text = 
	        (_G.EspName == true and v.Name or "")..
            (_G.EspDistance == true and "\nDistance [ "..string.format("%.1f", (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude).." ]" or "")..
            (_G.EspHealth == true and "\nHealth [ "..(v.Character.Humanoid.Health <= 0 and "Dead" or string.format("%.1f", (v.Character.Humanoid.Health))).." ]" or "")
    v.Character.Head["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 15
    v.Character.Head["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(0,0,0)
end
if _G.EspGui == true and v.Character.Head:FindFirstChild("Esp_Gui") == nil then
	GuiPlayerEsp = Instance.new("BillboardGui", v.Character.Head)
	GuiPlayerEsp.Adornee = v.Character.Head
	GuiPlayerEsp.Name = "Esp_Gui"
	GuiPlayerEsp.Size = UDim2.new(0, 100, 0, 150)
	GuiPlayerEsp.AlwaysOnTop = true
	GuiPlayerEsp.StudsOffset = Vector3.new(0, 3, 0)
	GuiPlayerEspText = Instance.new("TextLabel", GuiPlayerEsp)
	GuiPlayerEspText.BackgroundTransparency = 1
	GuiPlayerEspText.Font = Enum.Font.SourceSansBold
	GuiPlayerEspText.Size = UDim2.new(0, 100, 0, 100)
	GuiPlayerEspText.TextSize = 15
	GuiPlayerEspText.TextColor3 = Color3.new(0,0,0) 
	GuiPlayerEspText.TextStrokeTransparency = 0.5
	GuiPlayerEspText.Text = ""
	elseif _G.EspGui == false and v.Character.Head:FindFirstChild("Esp_Gui") then
	v.Character.Head:FindFirstChild("Esp_Gui"):Destroy()
end
end
end
task.wait()
end
    end
})

Main2Group:AddDropdown("Item Esp", {
    Text = "Item Esp",
    Values = {"Item", "House"},
    Default = "",
    Multi = false,
    Callback = function(Value)
_G.ItemEspChoose = Value
    end
})

Main2Group:AddToggle("Item", {
    Text = "Esp Item",
    Default = false, 
    Callback = function(Value) 
_G.EspItem = Value
if _G.EspItem == false then
for i, v in pairs(workspace:FindFirstChild("RuntimeItems"):GetChildren()) do
	if v.ClassName == "Model" then
		if v:FindFirstChild("Esp_Highlight") then
			v:FindFirstChild("Esp_Highlight"):Destroy()
		end
		if v:FindFirstChild("Esp_Gui") then
			v:FindFirstChild("Esp_Gui"):Destroy()
		end
	end
end
for i, v in pairs(workspace:FindFirstChild("RandomBuildings"):GetChildren()) do
	if v.ClassName == "Model" then
		if v:FindFirstChild("Esp_Gui") then
			v:FindFirstChild("Esp_Gui"):Destroy()
		end
	end
end
end
while _G.EspItem do
for i, v in pairs(workspace:FindFirstChild("RandomBuildings"):GetChildren()) do
if v.ClassName == "Model" then
if _G.ItemEspChoose == "House" then
if v:FindFirstChild("Esp_Gui") and v["Esp_Gui"]:FindFirstChild("TextLabel") then
	v["Esp_Gui"]:FindFirstChild("TextLabel").Text = 
	        (_G.EspName == true and v.Name or "")..
	        (_G.EspDistance == true and "\nDistance [ "..(v.PrimaryPart == nil and "Nah Distance" or string.format("%.1f", (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.PrimaryPart.Position).Magnitude)).." ]" or "")
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 15
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(0,0,0)
end
if _G.EspGui == true and v:FindFirstChild("Esp_Gui") == nil then
	GuiItemEsp = Instance.new("BillboardGui", v)
	GuiItemEsp.Adornee = v
	GuiItemEsp.Name = "Esp_Gui"
	GuiItemEsp.Size = UDim2.new(0, 100, 0, 150)
	GuiItemEsp.AlwaysOnTop = true
	GuiItemEsp.StudsOffset = Vector3.new(0, 3, 0)
	GuiItemEspText = Instance.new("TextLabel", GuiItemEsp)
	GuiItemEspText.BackgroundTransparency = 1
	GuiItemEspText.Font = Enum.Font.SourceSansBold
	GuiItemEspText.Size = UDim2.new(0, 100, 0, 100)
	GuiItemEspText.TextSize = 15
	GuiItemEspText.TextColor3 = Color3.new(0,0,0) 
	GuiItemEspText.TextStrokeTransparency = 0.5
	GuiItemEspText.Text = ""
	elseif _G.EspGui == false and v:FindFirstChild("Esp_Gui") then
	v:FindFirstChild("Esp_Gui"):Destroy()
end
elseif _G.ItemEspChoose ~= "House" then
if v:FindFirstChild("Esp_Gui") then
v:FindFirstChild("Esp_Gui"):Destroy()
end
end
end
end
for i, v in pairs(workspace:FindFirstChild("RuntimeItems"):GetChildren()) do
if v.ClassName == "Model" and v:FindFirstChild("HumanoidRootPart") == nil then
if _G.ItemEspChoose == "Item" then
if v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight").FillColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
	v:FindFirstChild("Esp_Highlight").OutlineColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
end
if _G.EspHighlight == true and v:FindFirstChild("Esp_Highlight") == nil then
	local Highlight = Instance.new("Highlight")
	Highlight.Name = "Esp_Highlight"
	Highlight.FillColor = Color3.fromRGB(255, 255, 255) 
	Highlight.OutlineColor = Color3.fromRGB(255, 255, 255) 
	Highlight.FillTransparency = 0.5
	Highlight.OutlineTransparency = 0
	Highlight.Adornee = v
	Highlight.Parent = v
	elseif _G.EspHighlight == false and v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight"):Destroy()
end
if v:FindFirstChild("Esp_Gui") and v["Esp_Gui"]:FindFirstChild("TextLabel") then
	v["Esp_Gui"]:FindFirstChild("TextLabel").Text = 
	        (_G.EspName == true and v.Name or "")..
	        (_G.EspDistance == true and "\nDistance [ "..(v.PrimaryPart == nil and "Nah Distance" or string.format("%.1f", (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.PrimaryPart.Position).Magnitude)).." ]" or "")
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 15
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(0,0,0)
end
if _G.EspGui == true and v:FindFirstChild("Esp_Gui") == nil then
	GuiItemEsp = Instance.new("BillboardGui", v)
	GuiItemEsp.Adornee = v
	GuiItemEsp.Name = "Esp_Gui"
	GuiItemEsp.Size = UDim2.new(0, 100, 0, 150)
	GuiItemEsp.AlwaysOnTop = true
	GuiItemEsp.StudsOffset = Vector3.new(0, 3, 0)
	GuiItemEspText = Instance.new("TextLabel", GuiItemEsp)
	GuiItemEspText.BackgroundTransparency = 1
	GuiItemEspText.Font = Enum.Font.SourceSansBold
	GuiItemEspText.Size = UDim2.new(0, 100, 0, 100)
	GuiItemEspText.TextSize = 15
	GuiItemEspText.TextColor3 = Color3.new(0,0,0) 
	GuiItemEspText.TextStrokeTransparency = 0.5
	GuiItemEspText.Text = ""
	elseif _G.EspGui == false and v:FindFirstChild("Esp_Gui") then
	v:FindFirstChild("Esp_Gui"):Destroy()
end
elseif _G.ItemEspChoose ~= "Item" then
if v:FindFirstChild("Esp_Highlight") then
v:FindFirstChild("Esp_Highlight"):Destroy()
end
if v:FindFirstChild("Esp_Gui") then
v:FindFirstChild("Esp_Gui"):Destroy()
end
end
end
end
task.wait()
end
    end
})

_G.EspModsAntilag = {}
workspace.DescendantAdded:Connect(function(v)
	if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and not game.Players:GetPlayerFromCharacter(v) then
	    if v.Humanoid.Health > 0 then
	        table.insert(_G.EspModsAntilag, v)
		end
	end
end)
Main2Group:AddToggle("Mods", {
    Text = "Esp Mods",
    Default = false, 
    Callback = function(Value) 
_G.EspMods = Value
if _G.EspMods == false then
_G.EspModsAntilag = {}
for i, v in pairs(workspace:GetDescendants()) do
    if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and not game.Players:GetPlayerFromCharacter(v) then
        if v:FindFirstChild("Esp_Highlight") then
              v:FindFirstChild("Esp_Highlight"):Destroy()
           end
			if v:FindFirstChild("HumanoidRootPart") and v.HumanoidRootPart:FindFirstChild("Esp_Gui") then
				v.HumanoidRootPart:FindFirstChild("Esp_Gui"):Destroy()
			end
        end
    end
else
_G.EspModsAntilag = {}
for i, v in pairs(workspace:GetDescendants()) do
    if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and not game.Players:GetPlayerFromCharacter(v) then
	    if v.Humanoid.Health > 0 then
	        table.insert(_G.EspModsAntilag, v)
		end
	end
end
end
while _G.EspMods do
for i, y in pairs(_G.EspModsAntilag) do
if y:FindFirstChild("HumanoidRootPart") and y:FindFirstChild("Humanoid") then
if y.Humanoid.Health > 0 then
if y:FindFirstChild("Esp_Highlight") then
	y:FindFirstChild("Esp_Highlight").FillColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
	y:FindFirstChild("Esp_Highlight").OutlineColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
end
if _G.EspHighlight == true and y:FindFirstChild("Esp_Highlight") == nil then
	local Highlight = Instance.new("Highlight")
	Highlight.Name = "Esp_Highlight"
	Highlight.FillColor = Color3.fromRGB(255, 255, 255) 
	Highlight.OutlineColor = Color3.fromRGB(255, 255, 255) 
	Highlight.FillTransparency = 0.5
	Highlight.OutlineTransparency = 0
	Highlight.Adornee = y
	Highlight.Parent = y
	elseif _G.EspHighlight == false and y:FindFirstChild("Esp_Highlight") then
	y:FindFirstChild("Esp_Highlight"):Destroy()
end
if y.HumanoidRootPart:FindFirstChild("Esp_Gui") and y.HumanoidRootPart["Esp_Gui"]:FindFirstChild("TextLabel") then
	y.HumanoidRootPart["Esp_Gui"]:FindFirstChild("TextLabel").Text = 
	        (_G.EspName == true and y.Name or "")..
            (_G.EspDistance == true and "\nDistance [ "..string.format("%.1f", (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - y.HumanoidRootPart.Position).Magnitude).." ]" or "")..
            (_G.EspHealth == true and "\nHealth [ "..string.format("%.1f", (y.Humanoid.Health)).." ]" or "")
    y.HumanoidRootPart["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 15
    y.HumanoidRootPart["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(0,0,0)
end
if _G.EspGui == true and y.HumanoidRootPart:FindFirstChild("Esp_Gui") == nil then
	GuiModsEsp = Instance.new("BillboardGui", y.HumanoidRootPart)
	GuiModsEsp.Adornee = y.HumanoidRootPart
	GuiModsEsp.Name = "Esp_Gui"
	GuiModsEsp.Size = UDim2.new(0, 100, 0, 150)
	GuiModsEsp.AlwaysOnTop = true
	GuiModsEsp.StudsOffset = Vector3.new(0, 3, 0)
	GuiModsEspText = Instance.new("TextLabel", GuiModsEsp)
	GuiModsEspText.BackgroundTransparency = 1
	GuiModsEspText.Font = Enum.Font.SourceSansBold
	GuiModsEspText.Size = UDim2.new(0, 100, 0, 100)
	GuiModsEspText.TextSize = 15
	GuiModsEspText.TextColor3 = Color3.new(0,0,0) 
	GuiModsEspText.TextStrokeTransparency = 0.5
	GuiModsEspText.Text = ""
	elseif _G.EspGui == false and y.HumanoidRootPart:FindFirstChild("Esp_Gui") then
	y.HumanoidRootPart:FindFirstChild("Esp_Gui"):Destroy()
end
end
end
if y:FindFirstChild("HumanoidRootPart") == nil or y:FindFirstChild("Humanoid") and y.Humanoid.Health <= 0 then
for i, v in pairs(workspace:GetDescendants()) do
    if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and not game.Players:GetPlayerFromCharacter(v) then
        if v:FindFirstChild("Esp_Highlight") then
              v:FindFirstChild("Esp_Highlight"):Destroy()
           end
			if v:FindFirstChild("HumanoidRootPart") and v.HumanoidRootPart:FindFirstChild("Esp_Gui") then
				v.HumanoidRootPart:FindFirstChild("Esp_Gui"):Destroy()
			end
        end
    end
for i = #_G.EspModsAntilag, 1, -1 do
	if _G.EspModsAntilag[i] == y then
		table.remove(_G.EspModsAntilag, i)
	end
end
end
end
task.wait()
end
    end
})

Main2Group:AddToggle("Bank", {
    Text = "Esp Bank / Code",
    Default = false, 
    Callback = function(Value) 
_G.EspBank = Value
if _G.EspBank == false then
if game.Workspace:FindFirstChild("Towns") then
	for i, v in pairs(game.Workspace.Towns:GetChildren()) do
		if v:IsA("Model") and v:FindFirstChild("Buildings") then
			for e, a in pairs(v.Buildings:GetChildren()) do
				if a.Name:find("Bank") and a:FindFirstChild("Vault") and a.Vault:FindFirstChild("Union") then
					for x, j in pairs(v.Vault:FindFirstChild("Union"):GetChildren()) do
						if j.Name:find("Esp_") then
							j:Destroy()
						end
					end
				end
			end
		end
	end
end
end
while _G.EspBank do
if game.Workspace:FindFirstChild("Towns") then
for i, v in pairs(game.Workspace.Towns:GetChildren()) do
if v:IsA("Model") and v:FindFirstChild("Buildings") then
for e, a in pairs(v.Buildings:GetChildren()) do
if a.Name:find("Bank") and a:FindFirstChild("Vault") and a.Vault:FindFirstChild("Union") then
if a.Vault.Union:FindFirstChild("Esp_Highlight") then
	a.Vault.Union:FindFirstChild("Esp_Highlight").FillColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
	a.Vault.Union:FindFirstChild("Esp_Highlight").OutlineColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
end
if _G.EspHighlight == true and a.Vault.Union:FindFirstChild("Esp_Highlight") == nil then
	local Highlight = Instance.new("Highlight")
	Highlight.Name = "Esp_Highlight"
	Highlight.FillColor = Color3.fromRGB(255, 255, 255) 
	Highlight.OutlineColor = Color3.fromRGB(255, 255, 255) 
	Highlight.FillTransparency = 0.5
	Highlight.OutlineTransparency = 0
	Highlight.Adornee = a.Vault.Union
	Highlight.Parent = a.Vault.Union
	elseif _G.EspHighlight == false and a.Vault.Union:FindFirstChild("Esp_Highlight") then
	a.Vault.Union:FindFirstChild("Esp_Highlight"):Destroy()
end
if a.Vault.Union:FindFirstChild("Esp_Gui") and a.Vault.Union["Esp_Gui"]:FindFirstChild("TextLabel") then
	a.Vault.Union["Esp_Gui"]:FindFirstChild("TextLabel").Text = "Bank | "..a.Vault:FindFirstChild("Combination").Value..
            (_G.EspDistance == true and "\nDistance [ "..string.format("%.1f", (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - a.Vault.Union.Position).Magnitude).." ]" or "")
    a.Vault.Union["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 15
    a.Vault.Union["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(0,0,0)
end
if _G.EspGui == true and a.Vault.Union:FindFirstChild("Esp_Gui") == nil then
	GuiBankEsp = Instance.new("BillboardGui", a.Vault.Union)
	GuiBankEsp.Adornee = a.Vault.Union
	GuiBankEsp.Name = "Esp_Gui"
	GuiBankEsp.Size = UDim2.new(0, 100, 0, 150)
	GuiBankEsp.AlwaysOnTop = true
	GuiBankEsp.StudsOffset = Vector3.new(0, 3, 0)
	GuiBankEspText = Instance.new("TextLabel", GuiBankEsp)
	GuiBankEspText.BackgroundTransparency = 1
	GuiBankEspText.Font = Enum.Font.SourceSansBold
	GuiBankEspText.Size = UDim2.new(0, 100, 0, 100)
	GuiBankEspText.TextSize = 15
	GuiBankEspText.TextColor3 = Color3.new(0,0,0) 
	GuiBankEspText.TextStrokeTransparency = 0.5
	GuiBankEspText.Text = ""
	elseif _G.EspGui == false and a.Vault.Union:FindFirstChild("Esp_Gui") then
	a.Vault.Union:FindFirstChild("Esp_Gui"):Destroy()
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

Main2Group:AddDivider()

_G.EspHighlight = false
Main2Group:AddToggle("Esp Hight Light", {
    Text = "Esp Hight Light",
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
    Text = "Esp Gui",
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
    Text = "Text Size [ Gui ]",
    Default = 15,
    Min = 15,
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
    Text = "Esp Name",
    Default = false, 
    Callback = function(Value) 
_G.EspName = Value
    end
})

_G.EspDistance = false
Main2Group:AddToggle("Esp Distance", {
    Text = "Esp Distance",
    Default = false, 
    Callback = function(Value) 
_G.EspDistance = Value
    end
})

_G.EspHealth = false
Main2Group:AddToggle("Esp Health", {
    Text = "Esp Health",
    Default = false, 
    Callback = function(Value) 
_G.EspHealth = Value
    end
})

local Misc1Group = Tabs.Tab1:AddLeftGroupbox("Misc")

_G.GetOldBright = {
	Brightness = game.Lighting.Brightness,
	ClockTime = game.Lighting.ClockTime,
	FogEnd = game.Lighting.FogEnd,
	GlobalShadows = game.Lighting.GlobalShadows,
	OutdoorAmbient = game.Lighting.OutdoorAmbient
}
Misc1Group:AddToggle("Full Bright", {
    Text = "Full Bright",
    Default = false, 
    Callback = function(Value) 
_G.FullBright = Value
while _G.FullBright do
game.Lighting.Brightness = 2
game.Lighting.ClockTime = 14
game.Lighting.FogEnd = 100000
game.Lighting.GlobalShadows = false
game.Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
task.wait()
end
for i, v in pairs(_G.GetOldBright) do
game.Lighting[i] = v
end
    end
})

Misc1Group:AddToggle("Noclip", {
    Text = "Noclip",
    Default = false, 
    Callback = function(Value) 
_G.NoclipCharacter = Value
if _G.NoclipCharacter == false then
	if game.Players.LocalPlayer.Character ~= nil then
		for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
			if v:IsA("BasePart") and v.CanCollide == false then
				v.CanCollide = true
			end
		end
	end
end
while _G.NoclipCharacter do
if game.Players.LocalPlayer.Character ~= nil then
		for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
			if v:IsA("BasePart") and v.CanCollide == true then
				v.CanCollide = false
			end
		end
	end
task.wait()
end
    end
}):AddKeyPicker("NoclipCharacter", {
   Default = "G",
   Text = "Noclip",
   Mode = "Toggle",
   SyncToggleState = true
})

Misc1Group:AddDropdown("ChooseCollect", {
    Text = "Choose Collect",
    Values = {"Money", "Snake Oil", "Bandage", "Bond", "Bullet", "Holy Water", "Gun", "Molotov", "Melee"},
    Default = "",
    Multi = true
})

Misc1Group:AddToggle("Auto Collect", {
    Text = "Auto Collect",
    Default = false, 
    Callback = function(Value) 
_G.CollectAuto = Value
while _G.CollectAuto do
for i, v in pairs(workspace:FindFirstChild("RuntimeItems"):GetChildren()) do
if Options.ChooseCollect.Value["Money"] then
if v.Name == "Moneybag" and v:FindFirstChild("MoneyBag") and v.MoneyBag:FindFirstChild("CollectPrompt") then
if 50 >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v:FindFirstChild("MoneyBag").Position).Magnitude then
v.MoneyBag:FindFirstChild("CollectPrompt").HoldDuration = 0
if fireproximityprompt then
fireproximityprompt(v.MoneyBag:FindFirstChild("CollectPrompt"))
end
end
end
end
if Options.ChooseCollect.Value["Snake Oil"] then
if v.Name == "Snake Oil" then
for c, a in pairs(v:GetChildren()) do
if a:IsA("BasePart") and 30 >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - a.Position).Magnitude then
game:GetService("ReplicatedStorage").Remotes.Tool.PickUpTool:FireServer(v)
end
end
end
if Options.ChooseCollect.Value["Bandage"] then
if v.Name == "Bandage" then
for c, a in pairs(v:GetChildren()) do
if a:IsA("BasePart") and 30 >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - a.Position).Magnitude then
game:GetService("ReplicatedStorage").Remotes.Tool.PickUpTool:FireServer(v)
end
end
end
end
if Options.ChooseCollect.Value["Bond"] then
if v.Name == "Bond" then
for c, a in pairs(v:GetChildren()) do
if a:IsA("BasePart") and 30 >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - a.Position).Magnitude then
game:GetService("ReplicatedStorage").Packages.RemotePromise.Remotes.C_ActivateObject:FireServer(v)
end
end
end
end
if Options.ChooseCollect.Value["Bullet"] then
if v.Name:find("Ammo") or v.Name:find("Shells") then
for c, a in pairs(v:GetChildren()) do
if a:IsA("BasePart") and 30 >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - a.Position).Magnitude then
game:GetService("ReplicatedStorage").Packages.RemotePromise.Remotes.C_ActivateObject:FireServer(v)
end
end
end
end
if Options.ChooseCollect.Value["Holy Water"] then
if v.Name == "Holy Water" then
for c, a in pairs(v:GetChildren()) do
if a:IsA("BasePart") and 30 >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - a.Position).Magnitude then
game:GetService("ReplicatedStorage").Remotes.Tool.PickUpTool:FireServer(v)
end
end
end
end
if Options.ChooseCollect.Value["Molotov"] then
if v.Name == "Molotov" then
for c, a in pairs(v:GetChildren()) do
if a:IsA("BasePart") and 30 >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - a.Position).Magnitude then
game:GetService("ReplicatedStorage").Remotes.Tool.PickUpTool:FireServer(v)
end
end
end
end
if Options.ChooseCollect.Value["Gun"] then
if v:FindFirstChild("ServerWeaponState") then
for c, a in pairs(v:GetChildren()) do
if a:IsA("BasePart") and 30 >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - a.Position).Magnitude then
game:GetService("ReplicatedStorage").Remotes.Tool.PickUpTool:FireServer(v)
end
end
elseif v:FindFirstChild("ObjectInfo") then
for h, m in pairs(v.ObjectInfo:GetChildren()) do
if m.Name == "TextLabel" and m.Text == "Gun" then
for c, a in pairs(v:GetChildren()) do
if a:IsA("BasePart") and 30 >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - a.Position).Magnitude then
game:GetService("ReplicatedStorage").Remotes.Tool.PickUpTool:FireServer(v)
end
end
end
end
end
end
if Options.ChooseCollect.Value["Melee"] then
if v:FindFirstChild("ObjectInfo") then
for h, m in pairs(v.ObjectInfo:GetChildren()) do
if m.Name == "TextLabel" and m.Text == "Melee" then
for c, a in pairs(v:GetChildren()) do
if a:IsA("BasePart") and 30 >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - a.Position).Magnitude then
game:GetService("ReplicatedStorage").Remotes.Tool.PickUpTool:FireServer(v)
end
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

Misc1Group:AddToggle("NotificationUnicorn", {
    Text = "Notification Unicorn",
    Default = false, 
    Callback = function(Value) 
_G.NotificationUnicorn = Value
if _G.NotificationUnicorn == false then
for i, v in pairs(workspace:GetDescendants()) do
if v:IsA("Model") and v.Name == "Unicorn" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Esp_Unicorn") and not game.Players:GetPlayerFromCharacter(v) then
v:FindFirstChild("Esp_Unicorn"):Destroy()
end
end
if NotificationUnicornGet then
NotificationUnicornGet:Disconnect()
NotificationUnicornGet = nil
end
elseif _G.NotificationUnicorn == true then
spawn(function()
for i, v in pairs(workspace:GetDescendants()) do
if v:IsA("Model") and v.Name:find("Unicorn") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Esp_Unicorn") and not game.Players:GetPlayerFromCharacter(v) then
if v:FindFirstChild("Esp_Unicorn") == nil then
if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
Notification("Unicorn Spawn / Health [ "..v.Humanoid.Health.." ]", 7)
else
Notification("Unicorn Spawn [ Dead ]", 7)
end
repeat task.wait() 
if v:FindFirstChild("Esp_Unicorn") == nil then
local Highlight = Instance.new("Highlight")
Highlight.Name = "Esp_Unicorn"
Highlight.FillColor = Color3.fromRGB(0, 255, 0)
Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
Highlight.FillTransparency = 0.5
Highlight.OutlineTransparency = 0
Highlight.Adornee = v
Highlight.Parent = v
end
until _G.NotificationUnicorn == false or v:FindFirstChild("HumanoidRootPart") == nil or v:FindFirstChild("Humanoid") and v.Humanoid.Health <= 0
for i, v in pairs(workspace:GetDescendants()) do
if v:IsA("Model") and v.Name == "Unicorn" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Esp_Unicorn") and not game.Players:GetPlayerFromCharacter(v) then
v:FindFirstChild("Esp_Unicorn"):Destroy()
end
end
end
end
end
end)
NotificationUnicornGet = workspace.DescendantAdded:Connect(function(v)
if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and not game.Players:GetPlayerFromCharacter(v) then
if v.Name:find("Unicorn") then
if v:FindFirstChild("Esp_Unicorn") == nil then
if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
Notification("Unicorn Spawn / Health [ "..v.Humanoid.Health.." ]", 7)
else
Notification("Unicorn Spawn [ Dead ]", 7)
end
repeat task.wait() 
if v:FindFirstChild("Esp_Unicorn") == nil then
local Highlight = Instance.new("Highlight")
Highlight.Name = "Esp_Unicorn"
Highlight.FillColor = Color3.fromRGB(0, 255, 0)
Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
Highlight.FillTransparency = 0.5
Highlight.OutlineTransparency = 0
Highlight.Adornee = v
Highlight.Parent = v
end
until _G.NotificationUnicorn == false or v:FindFirstChild("HumanoidRootPart") == nil or v:FindFirstChild("Humanoid") and v.Humanoid.Health <= 0
for i, v in pairs(workspace:GetDescendants()) do
if v:IsA("Model") and v.Name == "Unicorn" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Esp_Unicorn") and not game.Players:GetPlayerFromCharacter(v) then
v:FindFirstChild("Esp_Unicorn"):Destroy()
end
end
end
end
end
end)
end
    end
})

local Misc2Group = Tabs.Tab1:AddRightGroupbox("Combat")

Misc2Group:AddToggle("Slow Health Bar Mods", {
    Text = "Slow Health Bar Mods",
    Default = false, 
    Callback = function(Value) 
_G.HealthBarMods = Value
    end
})

Misc2Group:AddDropdown("NoMods", {
    Text = "No Mods",
    Values = {"Horse", "Wolf", "Werewolf"},
    Default = "",
    Multi = true
})

Misc2Group:AddDropdown("Melee", {
    Text = "Attack Melee",
    Values = {"Fast", "Normal"},
    Default = "",
    Multi = false,
    Callback = function(Value)
_G.FastMelee = Value
    end
})

Misc2Group:AddToggle("Auto Attack Melee", {
    Text = "Auto Attack Melee",
    Default = false, 
    Callback = function(Value) 
_G.AutoAttackMelee = Value
for i, v in pairs(workspace:FindFirstChild("RuntimeItems"):GetChildren()) do
if v:IsA("Model") and v:FindFirstChild("ObjectInfo") then
for h, m in pairs(v.ObjectInfo:GetChildren()) do
if m.Name == "TextLabel" and m.Text == "Melee" then
game:GetService("ReplicatedStorage").Remotes.Tool.PickUpTool:FireServer(v)
end
end
end
end
while _G.AutoAttackMelee do
if _G.FastMelee == "Fast" then
for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
if v:IsA("Tool") and v:FindFirstChild("SwingEvent") then
repeat task.wait()
v.Parent = game.Players.LocalPlayer.Character
until v.Parent == game.Players.LocalPlayer.Character
end
end
for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
if v:IsA("Tool") and v:FindFirstChild("SwingEvent") then
v.SwingEvent:FireServer(game.Players.LocalPlayer:GetMouse().Hit.LookVector)
game:GetService("ReplicatedStorage").Remotes.Tool.DropTool:FireServer(v)
end
end
for i, v in pairs(workspace:FindFirstChild("RuntimeItems"):GetChildren()) do
if v:IsA("Model") and v:FindFirstChild("ObjectInfo") then
for h, m in pairs(v.ObjectInfo:GetChildren()) do
if m.Name == "TextLabel" and m.Text == "Melee" then
game:GetService("ReplicatedStorage").Remotes.Tool.PickUpTool:FireServer(v)
end
end
end
end
elseif _G.FastMelee == "Normal" then
for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
if v:IsA("Tool") and v:FindFirstChild("SwingEvent") then
v.Parent = game.Players.LocalPlayer.Character
end
end
for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
if v:IsA("Tool") and v:FindFirstChild("SwingEvent") then
v.SwingEvent:FireServer(game.Players.LocalPlayer:GetMouse().Hit.LookVector)
end
end
end
task.wait()
end
    end
}):AddKeyPicker("AttackMelee", {
   Default = "U",
   Text = "Auto Attack Melee",
   Mode = "Toggle",
   SyncToggleState = true
})

Misc2Group:AddDropdown("GunFastAura", {
    Text = "Gun Aura",
    Values = {"Fast", "Normal"},
    Default = "",
    Multi = false,
    Callback = function(Value)
_G.GunAuraKillSkib = Value
    end
})

Misc2Group:AddSlider("Delay Shot", {
    Text = "Delay Shot",
    Default = 0.25,
    Min = 0.01,
    Max = 1,
    Rounding = 2,
    Compact = false,
    Callback = function(Value)
_G.DelayShot = Value
    end
})

_G.DelayShot = 0.25
Misc2Group:AddToggle("Gun Aura", {
    Text = "Gun Aura",
    Default = false, 
    Callback = function(Value) 
_G.KillAuraGun = Value
while _G.KillAuraGun do
local DistanceGunAura, ModsTargetShotHead, ModsTargetShotHumanoid = math.huge, nil, nil
for i, v in pairs(workspace:GetDescendants()) do
if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Head") and not game.Players:GetPlayerFromCharacter(v) then
local DistanceGun = (game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position - v.HumanoidRootPart.Position).Magnitude
if DistanceGun < DistanceGunAura then
if not Options.NoMods.Value["Horse"] or (not v.Name:find("Horse") and not v.Name:find("Unicorn")) then
if not Options.NoMods.Value["Wolf"] or not v.Name:find("Wolf") then
if not Options.NoMods.Value["Werewolf"] or not v.Name:find("Werewolf") then
if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then 
ModsTargetShotHead, ModsTargetShotHumanoid, DistanceGunAura = v.Head, v.Humanoid, DistanceGun
if _G.HealthBarMods == true and game.CoreGui:FindFirstChild("Gun Health Track").Enabled == false then
game.CoreGui["Gun Health Track"].Enabled = true
elseif game.CoreGui:FindFirstChild("Gun Health Track").Enabled == true then
game.CoreGui["Gun Health Track"].Frame:FindFirstChild("TextLabel").Text = (v.Name:gsub("Model_", "").." Health: "..string.format("%.0f", (v.Humanoid.Health)).." / "..v.Humanoid.MaxHealth)
game.CoreGui["Gun Health Track"].Frame:FindFirstChild("Frame").Size = UDim2.new(v.Humanoid.Health / v.Humanoid.MaxHealth, 0, 1, 0)
end
end
end
end
end
end
end
end
if ModsTargetShotHead and ModsTargetShotHumanoid then
_G.ModsShotgun = {}
if _G.GunAuraKillSkib == "Fast" then
for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:FindFirstChild("ClientWeaponState") and v.ClientWeaponState:FindFirstChild("CurrentAmmo") then
			if v.ClientWeaponState.CurrentAmmo.Value ~= 0 then
				if v.Name == "Shotgun" or v.Name == "Sawed-Off Shotgun" then
					for i = 1, 6 do
                       _G.ModsShotgun[tostring(i)] = ModsTargetShotHumanoid
                    end
				else
					_G.ModsShotgun["1"] = ModsTargetShotHumanoid
				end
				if _G.ModsShotgun ~= nil then
					game.ReplicatedStorage.Remotes.Weapon.Shoot:FireServer(game.Workspace:GetServerTimeNow(), v, CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, ModsTargetShotHead.Position), _G.ModsShotgun)
					game.ReplicatedStorage.Remotes.Weapon.Reload:FireServer(game.Workspace:GetServerTimeNow(), v)
				end
			end
        end
    end
elseif _G.GunAuraKillSkib == "Normal" then
for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:FindFirstChild("ClientWeaponState") and v.ClientWeaponState:FindFirstChild("CurrentAmmo") then
			if v.ClientWeaponState.CurrentAmmo.Value ~= 0 then
				if v.Name == "Shotgun" or v.Name == "Sawed-Off Shotgun" then
					for i = 1, 6 do
                       _G.ModsShotgun[tostring(i)] = ModsTargetShotHumanoid
                    end
				else
					_G.ModsShotgun["1"] = ModsTargetShotHumanoid
				end
				if _G.ModsShotgun ~= nil then
					game.ReplicatedStorage.Remotes.Weapon.Shoot:FireServer(game.Workspace:GetServerTimeNow(), v, CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, ModsTargetShotHead.Position), _G.ModsShotgun)
				end
			elseif v.ClientWeaponState.CurrentAmmo.Value == 0 then
				game.ReplicatedStorage.Remotes.Weapon.Reload:FireServer(game.Workspace:GetServerTimeNow(), v)
				repeat task.wait() until v.ClientWeaponState.CurrentAmmo.Value ~= 0
			end
        end
    end
end
else
if game.CoreGui:FindFirstChild("Gun Health Track").Enabled == true then
game.CoreGui["Gun Health Track"].Enabled = false
game.CoreGui["Gun Health Track"].Frame:FindFirstChild("TextLabel").Text = "Nah Health: Nil"
game.CoreGui["Gun Health Track"].Frame:FindFirstChild("Frame").Size = UDim2.new(1, 0, 1, 0)
end
end
task.wait(_G.DelayShot)
end
if game.CoreGui:FindFirstChild("Gun Health Track").Enabled == true then
game.CoreGui["Gun Health Track"].Enabled = false
game.CoreGui["Gun Health Track"].Frame:FindFirstChild("TextLabel").Text = "Nah Health: Nil"
game.CoreGui["Gun Health Track"].Frame:FindFirstChild("Frame").Size = UDim2.new(1, 0, 1, 0)
end
    end
}):AddKeyPicker("GunAuraKill", {
   Default = "M",
   Text = "Gun Aura",
   Mode = "Toggle",
   SyncToggleState = true
})

Misc2Group:AddToggle("Aimbot Mods", {
    Text = "Aimbot Mods",
    Default = false, 
    Callback = function(Value) 
_G.AimbotMods = Value
while _G.AimbotMods do
local DistanceMath, ModsTarget = math.huge, nil
for i, v in pairs(workspace:GetDescendants()) do
if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Head") and not game.Players:GetPlayerFromCharacter(v) then
local Distance = (game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position - v.HumanoidRootPart.Position).Magnitude
if Distance < DistanceMath then
if not Options.NoMods.Value["Horse"] or (not v.Name:find("Horse") and not v.Name:find("Unicorn")) then
if not Options.NoMods.Value["Wolf"] or not v.Name:find("Wolf") then
if not Options.NoMods.Value["Werewolf"] or not v.Name:find("Werewolf") then
if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then 
ModsTarget, DistanceMath = v:FindFirstChild("Head"), Distance
if game.CoreGui:FindFirstChild("Gun Health Track").Enabled == false then
game.CoreGui["Gun Health Track"].Enabled = true
else
game.CoreGui["Gun Health Track"].Frame:FindFirstChild("TextLabel").Text = (v.Name:gsub("Model_", "").." Health: "..string.format("%.0f", (v.Humanoid.Health)).." / "..v.Humanoid.MaxHealth)
game.CoreGui["Gun Health Track"].Frame:FindFirstChild("Frame").Size = UDim2.new(v.Humanoid.Health / v.Humanoid.MaxHealth, 0, 1, 0)
end
end
end
end
end
end
end
end
if ModsTarget then
game.Workspace.CurrentCamera.CFrame = CFrame.lookAt(game.Workspace.CurrentCamera.CFrame.Position, game.Workspace.CurrentCamera.CFrame.Position + (ModsTarget.Position + Vector3.new(0, ModsTarget.Size.Y / 2, 0) - game.Workspace.CurrentCamera.CFrame.Position).unit)
else
if game.CoreGui:FindFirstChild("Gun Health Track").Enabled == true then
game.CoreGui["Gun Health Track"].Enabled = false
game.CoreGui["Gun Health Track"].Frame:FindFirstChild("TextLabel").Text = "Nah Health: Nil"
game.CoreGui["Gun Health Track"].Frame:FindFirstChild("Frame").Size = UDim2.new(1, 0, 1, 0)
end
end
task.wait()
end
if game.CoreGui:FindFirstChild("Gun Health Track").Enabled == true then
game.CoreGui["Gun Health Track"].Enabled = false
game.CoreGui["Gun Health Track"].Frame:FindFirstChild("TextLabel").Text = "Nah Health: Nil"
game.CoreGui["Gun Health Track"].Frame:FindFirstChild("Frame").Size = UDim2.new(1, 0, 1, 0)
end
    end
}):AddKeyPicker("AimbotMods", {
   Default = "R",
   Text = "Aimbot Mods",
   Mode = "Toggle",
   SyncToggleState = true
})

Misc2Group:AddToggle("Camlock Mods", {
    Text = "Camlock Mods",
    Default = false, 
    Callback = function(Value) 
_G.CamlockMods = Value
while _G.CamlockMods do
local DistanceMathMods = math.huge
local ModsTargetHead
for i, v in pairs(workspace:GetDescendants()) do
if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Head") and not game.Players:GetPlayerFromCharacter(v) then
local Distance2 = (game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position - v.HumanoidRootPart.Position).Magnitude
if Distance2 < DistanceMathMods then
if not Options.NoMods.Value["Horse"] or (not v.Name:find("Horse") and not v.Name:find("Unicorn")) then
if not Options.NoMods.Value["Wolf"] or not v.Name:find("Wolf") then
if not Options.NoMods.Value["Werewolf"] or not v.Name:find("Werewolf") then
if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then 
ModsTargetHead, DistanceMathMods = v:FindFirstChild("Head"), Distance2
if _G.HealthBarMods == true and game.CoreGui:FindFirstChild("Gun Health Track").Enabled == false then
game.CoreGui["Gun Health Track"].Enabled = true
elseif game.CoreGui:FindFirstChild("Gun Health Track").Enabled == true then
game.CoreGui["Gun Health Track"].Frame:FindFirstChild("TextLabel").Text = (v.Name:gsub("Model_", "").." Health: "..string.format("%.0f", (v.Humanoid.Health)).." / "..v.Humanoid.MaxHealth)
game.CoreGui["Gun Health Track"].Frame:FindFirstChild("Frame").Size = UDim2.new(v.Humanoid.Health / v.Humanoid.MaxHealth, 0, 1, 0)
end
end
end
end
end
end
end
end
if ModsTargetHead then
if game.Workspace.CurrentCamera.CameraSubject ~= ModsTargetHead then
game.Workspace.CurrentCamera.CameraSubject = ModsTargetHead
end
else
if game.CoreGui:FindFirstChild("Gun Health Track").Enabled == true then
game.CoreGui["Gun Health Track"].Enabled = false
game.CoreGui["Gun Health Track"].Frame:FindFirstChild("TextLabel").Text = "Nah Health: Nil"
game.CoreGui["Gun Health Track"].Frame:FindFirstChild("Frame").Size = UDim2.new(1, 0, 1, 0)
end
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Workspace.CurrentCamera.CameraSubject ~= game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
end
end
task.wait()
end
if game.CoreGui:FindFirstChild("Gun Health Track").Enabled == true then
game.CoreGui["Gun Health Track"].Enabled = false
game.CoreGui["Gun Health Track"].Frame:FindFirstChild("TextLabel").Text = "Nah Health: Nil"
game.CoreGui["Gun Health Track"].Frame:FindFirstChild("Frame").Size = UDim2.new(1, 0, 1, 0)
end
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
end
    end
}):AddKeyPicker("CamlockMods", {
   Default = "K",
   Text = "Camlock Mods",
   Mode = "Toggle",
   SyncToggleState = true
})

Misc2Group:AddSlider("Health Heal", {
    Text = "Health Heal",
    Default = 68,
    Min = 1,
    Max = 100,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
_G.HealthyHeal = Value
    end
})

Misc2Group:AddToggle("Auto Heal", {
    Text = "Auto Heal",
    Default = false, 
    Callback = function(Value) 
_G.AutoHeal = Value
while _G.AutoHeal do
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health < (_G.HealthyHeal or 68)then
	if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Bandage") and game:GetService("Players").LocalPlayer.Backpack["Bandage"]:FindFirstChild("Use") then
	    game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Bandage").Use:FireServer()
	end
end
task.wait()
end
    end
}):AddKeyPicker("AutoHeal", {
   Default = "L",
   Text = "Auto Heal",
   Mode = "Toggle",
   SyncToggleState = true
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
        setclipboard("https://discord.gg/ZC63JwSg8T")
        Library:Notify("Copied discord link to clipboard!")
    else
        Library:Notify("Discord link: https://discord.gg/ZC63JwSg8T", 10)
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