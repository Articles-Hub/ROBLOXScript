if not game:IsLoaded() then
    game.Loaded:Wait()
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

Main1Group:AddToggle("Auto Fuel", {
    Text = "Auto Fuel Train",
    Default = false, 
    Callback = function(Value) 
_G.FuelTrain = Value
while _G.FuelTrain do
for i, v in pairs(workspace.RuntimeItems:GetChildren()) do
if v.ClassName == "Model" and v:FindFirstChild("ObjectInfo") and v.PrimaryPart ~= nil and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.PrimaryPart.Position).Magnitude < 5 then
for h, m in pairs(v.ObjectInfo:GetChildren()) do
if m.Name == "TextLabel" and m.Text == "Fuel" and m.Text ~= "Valuable" then
game:GetService("ReplicatedStorage").Shared.Remotes.RequestStartDrag:FireServer(v)
wait(0.5)
v:SetPrimaryPartCFrame(workspace.Train.TrainControls:FindFirstChild("FuelDetect").CFrame)
wait(0.8)
game:GetService("ReplicatedStorage").Shared.Remotes.RequestStopDrag:FireServer()
end
end
end
end
task.wait()
end
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

local Main2Group = Tabs.Tab:AddRightGroupbox("Esp")

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
	v:FindFirstChild("Esp_Highlight").FillColor = (_G.ColorLight == nil and Color3.fromRGB(255, 255, 255) or _G.ColorLight)
	v:FindFirstChild("Esp_Highlight").OutlineColor = (_G.ColorLight == nil and Color3.fromRGB(255, 255, 255) or _G.ColorLight)
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
	        (_G.EspName == true and "Name [ "..v.Name.." ]" or "")..
            (_G.EspDistance == true and "\nDistance [ "..string.format("%.1f", (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.TrainControls.ConductorSeat:FindFirstChild("VehicleSeat").Position).Magnitude).." ]" or "")
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
	v.Character:FindFirstChild("Esp_Highlight").FillColor = (_G.ColorLight == nil and Color3.fromRGB(255, 255, 255) or _G.ColorLight)
	v.Character:FindFirstChild("Esp_Highlight").OutlineColor = (_G.ColorLight == nil and Color3.fromRGB(255, 255, 255) or _G.ColorLight)
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
	        (_G.EspName == true and "Name [ "..v.Name.." ]" or "")..
            (_G.EspDistance == true and "\nDistance [ "..string.format("%.1f", (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude).." ]" or "")..
            (_G.EspHealth == true and "\nHealth [ "..v.Character.Humanoid.Health.." ]" or "")
    v.Character.Head["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = (_G.EspGuiTextSize == nil and 15 or _G.EspGuiTextSize)
    v.Character.Head["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = (_G.EspGuiTextColor == nil and Color3.new(0,0,0) or _G.EspGuiTextColor)
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
end
while _G.EspItem do
for i, v in pairs(workspace:FindFirstChild("RuntimeItems"):GetChildren()) do
if v.ClassName == "Model" then
if v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight").FillColor = (_G.ColorLight == nil and Color3.fromRGB(255, 255, 255) or _G.ColorLight)
	v:FindFirstChild("Esp_Highlight").OutlineColor = (_G.ColorLight == nil and Color3.fromRGB(255, 255, 255) or _G.ColorLight)
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
	        (_G.EspName == true and "Name [ "..v.Name.." ]" or "")..
	        (_G.EspDistance == true and "\nDistance [ "..(v.PrimaryPart == nil and "Nah Distance" or string.format("%.1f", (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.PrimaryPart.Position).Magnitude)).." ]" or "")
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = (_G.EspGuiTextSize == nil and 20 or _G.EspGuiTextSize)
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = (_G.EspGuiTextColor == nil and Color3.new(0,0,0) or _G.EspGuiTextColor)
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
	GuiItemEspText.TextSize = 20
	GuiItemEspText.TextColor3 = Color3.new(0,0,0) 
	GuiItemEspText.TextStrokeTransparency = 0.5
	GuiItemEspText.Text = ""
	elseif _G.EspGui == false and v:FindFirstChild("Esp_Gui") then
	v:FindFirstChild("Esp_Gui"):Destroy()
end
end
end
task.wait()
end
    end
})

function EspMods(y)
if y:FindFirstChild("Esp_Highlight") then
	y:FindFirstChild("Esp_Highlight").FillColor = (_G.ColorLight == nil and Color3.fromRGB(255, 255, 255) or _G.ColorLight)
	y:FindFirstChild("Esp_Highlight").OutlineColor = (_G.ColorLight == nil and Color3.fromRGB(255, 255, 255) or _G.ColorLight)
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
	        (_G.EspName == true and "Name [ "..y.Name.." ]" or "")..
            (_G.EspDistance == true and "\nDistance [ "..string.format("%.1f", (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - y.HumanoidRootPart.Position).Magnitude).." ]" or "")..
            (_G.EspHealth == true and "\nHealth [ "..string.format("%.1f", (y.Humanoid.Health)).." ]" or "")
    y.HumanoidRootPart["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = (_G.EspGuiTextSize == nil and 15 or _G.EspGuiTextSize)
    y.HumanoidRootPart["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = (_G.EspGuiTextColor == nil and Color3.new(0,0,0) or _G.EspGuiTextColor)
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
Main2Group:AddToggle("Mods", {
    Text = "Esp Mods",
    Default = false, 
    Callback = function(Value) 
_G.EspMods = Value
if _G.EspMods == false then
for i, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and not game.Players:GetPlayerFromCharacter(v) then
            if v.Parent ~= workspace.RuntimeItems then
               if v:FindFirstChild("Esp_Highlight") then
	              v:FindFirstChild("Esp_Highlight"):Destroy()
               end
				if v:FindFirstChild("HumanoidRootPart") then
					if v.HumanoidRootPart:FindFirstChild("Esp_Gui") then
						v.HumanoidRootPart:FindFirstChild("Esp_Gui"):Destroy()
					end
				end
            end
        end
    end
end
while _G.EspMods do
for i, v in pairs(workspace:GetDescendants()) do
	        if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and not game.Players:GetPlayerFromCharacter(v) then
	            if v.Parent ~= workspace.RuntimeItems then
	               EspMods(v)
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

Misc1Group:AddToggle("Auto Collect Money", {
    Text = "Auto Collect Money",
    Default = false, 
    Callback = function(Value) 
_G.CollectMoney = Value
while _G.CollectMoney do
for i, v in pairs(workspace:FindFirstChild("RuntimeItems"):GetChildren()) do
if v.Name == "Moneybag" and v:FindFirstChild("MoneyBag") and v.MoneyBag:FindFirstChild("CollectPrompt") then
v.MoneyBag:FindFirstChild("CollectPrompt").HoldDuration = 0
if fireproximityprompt then
fireproximityprompt(v.MoneyBag:FindFirstChild("CollectPrompt"))
end
end
end
task.wait()
end
    end
})

Misc1Group:AddToggle("Auto Collect Snake Oil", {
    Text = "Auto Collect Snake Oil",
    Default = false, 
    Callback = function(Value) 
_G.CollectSnakeOil = Value
while _G.CollectSnakeOil do
for i, v in pairs(workspace:FindFirstChild("RuntimeItems"):GetChildren()) do
if v.Name == "Snake Oil" then
game:GetService("ReplicatedStorage").Remotes.Tool.PickUpTool:FireServer(v)
end
end
task.wait()
end
    end
})

Misc1Group:AddToggle("Auto Collect Bandage", {
    Text = "Auto Collect Bandage",
    Default = false, 
    Callback = function(Value) 
_G.CollectBandage = Value
while _G.CollectBandage do
for i, v in pairs(workspace:FindFirstChild("RuntimeItems"):GetChildren()) do
if v.Name == "Bandage" then
game:GetService("ReplicatedStorage").Remotes.Tool.PickUpTool:FireServer(v)
end
end
task.wait()
end
    end
})

Misc1Group:AddToggle("Auto Collect All", {
    Text = "Auto Collect All",
    Default = false, 
    Callback = function(Value) 
_G.CollectAll = Value
while _G.CollectAll do
for i, v in pairs(workspace:FindFirstChild("RuntimeItems"):GetChildren()) do
if v.Name == "Snake Oil" or v.Name == "Bandage" then
game:GetService("ReplicatedStorage").Remotes.Tool.PickUpTool:FireServer(v)
end
if v.Name == "Moneybag" and v:FindFirstChild("MoneyBag") and v.MoneyBag:FindFirstChild("CollectPrompt") then
v.MoneyBag:FindFirstChild("CollectPrompt").HoldDuration = 0
if fireproximityprompt then
fireproximityprompt(v.MoneyBag:FindFirstChild("CollectPrompt"))
end
end
if v.Name:find("Ammo") or v.Name:find("Shells") or v.Name == "Bond" then
game:GetService("ReplicatedStorage").Packages.RemotePromise.Remotes.C_ActivateObject:FireServer(v)
end
end
task.wait()
end
    end
})

local Misc2Group = Tabs.Tab1:AddLeftGroupbox("Combat")

Misc2Group:AddSlider("Hitbox", {
    Text = "Hitbox Mods",
    Default = 50,
    Min = 20,
    Max = 55,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
_G.SizeMods = Value
    end
})

Main2Group:AddToggle("Hitbox", {
    Text = "Hitbox Mods",
    Default = false, 
    Callback = function(Value) 
_G.HitboxStMods = Value
if _G.HitboxStMods == false then
for i, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and not game.Players:GetPlayerFromCharacter(v) then
               v.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
               v.HumanoidRootPart.Transparency = 1
            end
        end
    end
while _G.HitboxStMods do
for i, v in pairs(workspace:GetDescendants()) do
    if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and not game.Players:GetPlayerFromCharacter(v) then
        if v.Parent ~= workspace.RuntimeItems then
           v.HumanoidRootPart.Size = Vector3.new(_G.SizeMods, _G.SizeMods, _G.SizeMods)
           v.HumanoidRootPart.Transparency = 0.5
		end
    end
end
task.wait()
end
    end
})

Misc2Group:AddSlider("Gun Distance", {
    Text = "Gun Distance Aura",
    Default = 50,
    Min = 10,
    Max = 70,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
_G.DistanceGun = Value
    end
})

Misc2Group:AddToggle("Gun Aura", {
    Text = "Gun Aura",
    Default = false, 
    Callback = function(Value) 
_G.KillAuraGun = Value
while _G.KillAuraGun do
for i, v in pairs(workspace:GetDescendants()) do
    if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and not game.Players:GetPlayerFromCharacter(v) then
        if v.Parent ~= workspace.RuntimeItems then
           if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude < _G.DistanceGun then
	           for j, h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
	                if h:IsA("Tool") and h:FindFirstChild("CurrentAmmo") then
						if h.CurrentAmmo.Value ~= 0 then
							game.ReplicatedStorage.Remotes.Weapon.Shoot:FireServer(game.Workspace:GetServerTimeNow(), h, game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame, {["1"] = v})
						elseif h.CurrentAmmo.Value == 0 then
							game.ReplicatedStorage.Remotes.Weapon.Reload:FireServer(game.Workspace:GetServerTimeNow(), h)
							repeat task.wait() until h.CurrentAmmo.Value ~= 0
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

Misc2Group:AddSlider("Distance Aimbot", {
    Text = "Distance Aimbot",
    Default = 50,
    Min = 30,
    Max = 1000,
    Rounding = 1,
    Compact = true,
    Callback = function(Value)
_G.DistanceAim = Value
    end
})

_G.DistanceAim = 50
Misc2Group:AddToggle("Aimbot Mods", {
    Text = "Aimbot Mods",
    Default = false, 
    Callback = function(Value) 
_G.AimbotMods = Value
while _G.AimbotMods do
for i, v in pairs(workspace:GetDescendants()) do
    if v:IsA("Model") and (_G.NoHorse and v.Name ~= "Horse") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Head") and not game.Players:GetPlayerFromCharacter(v) then
        if v.Parent ~= workspace.RuntimeItems then
           if _G.DistanceAim >= (game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position - v.HumanoidRootPart.Position).Magnitude then
	           game.Workspace.CurrentCamera.CFrame = CFrame.lookAt(game.Workspace.CurrentCamera.CFrame.Position, game.Workspace.CurrentCamera.CFrame.Position + (v.Head.Position + Vector3.new(0, v.Head.Size.Y / 1.8, 0) - game.Workspace.CurrentCamera.CFrame.Position).unit)
	        end
	    end
	end
end
task.wait()
end
    end
})

Misc2Group:AddToggle("NoHorse", {
    Text = "No Aimbot Horse",
    Default = false, 
    Callback = function(Value) 
_G.NoHorse = Value
    end
})

Misc2Group:AddToggle("Auto Heal", {
    Text = "Auto Heal",
    Default = false, 
    Callback = function(Value) 
_G.AutoHeal = Value
while _G.AutoHeal do
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health < 68 then
	if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Bandage") then
	    game:GetService("Players").LocalPlayer.Backpack.Bandage.Use:FireServer()
	end
end
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health < 68 then
	if game.Players.LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Bandage") then
	    game:GetService("Players").LocalPlayer.Character.Bandage.Use:FireServer()
	end
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

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])
SaveManager:LoadAutoloadConfig()