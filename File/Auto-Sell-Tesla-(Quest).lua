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
UICorner.Thickness = 2.5
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

spawn(function()
if game.CoreGui:FindFirstChild("GiangHub") == nil then
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "GiangHub"

local Frame1 = Instance.new("Frame")
Frame1.Name = "Frame2"
Frame1.Size = UDim2.new(0, 200, 0, 30)
Frame1.Position = UDim2.new(0.5, -368, 0.5, -141)
Frame1.BorderSizePixel = 1
Frame1.Active = true
Frame1.BackgroundTransparency = 1
Frame1.Draggable = true
Frame1.Parent = gui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Frame1

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(1, 0, 1, 0)
TextLabel.Position = UDim2.new(0, 0, 0, 0)
TextLabel.BorderSizePixel = 1
TextLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TextLabel.Text = "Giang Hub"
TextLabel.TextSize = 15.000
TextLabel.BackgroundTransparency = 0
TextLabel.TextColor3 = Color3.new(1, 1, 1)
TextLabel.Font = Enum.Font.Code
TextLabel.Parent = Frame1

_G.ToggleFrame = false
local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.2, 0, 1, 0)
TextButton.Position = UDim2.new(0.8, 0, 0, 0)
TextButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TextButton.BorderColor3 = Color3.new(0, 0, 0)
TextButton.BorderSizePixel = 1
TextButton.Text = "-"
TextButton.TextSize = 20
TextButton.BackgroundTransparency = 1
TextButton.TextColor3 = Color3.new(1, 1, 1)
TextButton.Font = Enum.Font.Code
TextButton.Parent = TextLabel
TextButton.MouseButton1Click:Connect(function()
if _G.ToggleFrame == true then
TextButton.Text = "-"
_G.ToggleFrame = false
game.CoreGui.GiangHub.Frame2.Frame.Visible = true
else
TextButton.Text = "+"
_G.ToggleFrame = true
game.CoreGui.GiangHub.Frame2.Frame.Visible = false
end
end)

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = TextLabel

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 170)
Frame.Position = UDim2.new(0, 0, 1.1, 0)
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.BorderColor3 = Color3.new(0, 0, 0)
Frame.BorderSizePixel = 1
Frame.Active = true
Frame.BackgroundTransparency = 0
Frame.Parent = Frame1

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Frame

local Frame1 = Instance.new("ScrollingFrame")
Frame1.Name = "Frame1"
Frame1.Size = UDim2.new(1, 0, 1, 0)
Frame1.Position = UDim2.new(0, 0, 0, 0)
Frame1.BackgroundColor3 = Color3.new(1, 1, 1)
Frame1.BorderColor3 = Color3.new(0, 0, 0)
Frame1.ScrollBarThickness = 0
Frame1.BackgroundTransparency = 1
Frame1.Parent = Frame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Parent = Frame1

local Padding = Instance.new("UIPadding")
Padding.PaddingTop = UDim.new(0, 10)
Padding.Parent = Frame1

function ButtonCr(Name, Name2, Call)
local TextButton = Instance.new("TextButton")
TextButton.Name = Name2
TextButton.Size = UDim2.new(0.9, 0, 0.14, 0)
TextButton.Position = UDim2.new(0, 0, 0, 0)
TextButton.BackgroundColor3 = Color3.new(0, 0, 0)
TextButton.BorderColor3 = Color3.new(0, 0, 0)
TextButton.BorderSizePixel = 1
TextButton.Text = Name
TextButton.TextSize = 15.000
TextButton.BackgroundTransparency = 0
TextButton.TextColor3 = Color3.new(255, 255, 255)
TextButton.Font = Enum.Font.Code
TextButton.Parent = Frame1
TextButton.MouseButton1Click:Connect(function()
pcall(Call)
end)

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = TextButton

local UICorner = Instance.new("UIStroke")
UICorner.Color = Color3.new(0, 0, 0)
UICorner.Thickness = 3
UICorner.Parent = TextButton
end

function SetText(Name, Text1)
if game.CoreGui:FindFirstChild("GiangHub") then
game.CoreGui.GiangHub.Frame2.Frame.Frame1:FindFirstChild(Name).Text = Text1
end
end

_G.GunAura = false
_G.DelayShot = 0.01
_G.ReachShot = 150
ButtonCr("Gun Aura: OFF", "Gun Aura", function()
_G.GunAura = not _G.GunAura
SetText("Gun Aura", "Gun Aura: "..(_G.GunAura and "ON" or "OFF"))

while _G.GunAura do
local DistanceGunAura, ModsTargetShotHead, ModsTargetShotHumanoid = math.huge, nil, nil
for i, v in pairs(workspace:GetDescendants()) do
if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Head") and not game.Players:GetPlayerFromCharacter(v) then
if not v.Name:find("Soldier") then
local DistanceGun = (game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position - v.HumanoidRootPart.Position).Magnitude
if DistanceGun < DistanceGunAura and DistanceGun < _G.ReachShot then
if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then 
ModsTargetShotHead, ModsTargetShotHumanoid, CharacterMods, DistanceGunAura = v.Head, v.Humanoid, v, DistanceGun
if game.CoreGui:FindFirstChild("Gun Health Track").Enabled == false then
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
if ModsTargetShotHead and ModsTargetShotHumanoid then
_G.ModsShotgun = {}
ShotNow = {14, 8, 2, 5, 11, 17}
for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:FindFirstChild("ClientWeaponState") and v.ClientWeaponState:FindFirstChild("CurrentAmmo") then
			if v.ClientWeaponState.CurrentAmmo.Value ~= 0 then
				if v.Name == "Shotgun" or v.Name == "Sawed-Off Shotgun" then
					for i, v in pairs(ShotNow) do
					    _G.ModsShotgun[v] = ModsTargetShotHumanoid
					end
				else
					_G.ModsShotgun["2"] = ModsTargetShotHumanoid
				end
				if _G.ModsShotgun ~= nil then
					game.ReplicatedStorage.Remotes.Weapon.Shoot:FireServer(game.Workspace:GetServerTimeNow(), v, ModsTargetShotHead.CFrame, _G.ModsShotgun)
					game.ReplicatedStorage.Remotes.Weapon.Reload:FireServer(game.Workspace:GetServerTimeNow(), v)
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
end)

_G.AutoHeal = false
ButtonCr("Auto Heal: OFF", "Auto Heal", function()
_G.AutoHeal = not _G.AutoHeal
SetText("Auto Heal", "Auto Heal: "..(_G.AutoHeal and "ON" or "OFF"))

while _G.AutoHeal do
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health < 50 then
	if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Bandage") and game:GetService("Players").LocalPlayer.Backpack["Bandage"]:FindFirstChild("Use") then
	    game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Bandage").Use:FireServer()
	end
end
task.wait()
end
end)

_G.Noclip = false
ButtonCr("Noclip: OFF", "Noclip", function()
_G.Noclip = not _G.Noclip
SetText("Noclip", "Noclip: "..(_G.Noclip and "ON" or "OFF"))

while _G.Noclip do
Noclip(true)
task.wait()
end
Noclip(false)
end)

_G.CollectItem = false
ButtonCr("Collect Item: OFF", "CollectItem", function()
_G.CollectItem = not _G.CollectItem
SetText("CollectItem", "Collect Item: "..(_G.CollectItem and "ON" or "OFF"))

while _G.CollectItem do
for i, v in pairs(workspace:FindFirstChild("RuntimeItems"):GetChildren()) do
if v.Name == "Moneybag" and v:FindFirstChild("MoneyBag") and v.MoneyBag:FindFirstChild("CollectPrompt") then
if 50 >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v:FindFirstChild("MoneyBag").Position).Magnitude then
v.MoneyBag:FindFirstChild("CollectPrompt").HoldDuration = 0
if fireproximityprompt then
fireproximityprompt(v.MoneyBag:FindFirstChild("CollectPrompt"))
end
end
end
if v.Name == "Snake Oil" then
for c, a in pairs(v:GetChildren()) do
if a:IsA("BasePart") and 30 >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - a.Position).Magnitude then
game:GetService("ReplicatedStorage").Remotes.Tool.PickUpTool:FireServer(v)
end
end
end
if v.Name == "Bandage" then
for c, a in pairs(v:GetChildren()) do
if a:IsA("BasePart") and 30 >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - a.Position).Magnitude then
game:GetService("ReplicatedStorage").Remotes.Tool.PickUpTool:FireServer(v)
end
end
end
if v.Name == "Bond" then
for c, a in pairs(v:GetChildren()) do
if a:IsA("BasePart") and 30 >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - a.Position).Magnitude then
game:GetService("ReplicatedStorage").Shared.Network.RemotePromise.Remotes.C_ActivateObject:FireServer(v)
end
end
end
if v.Name:find("Ammo") or v.Name:find("Shells") then
for c, a in pairs(v:GetChildren()) do
if a:IsA("BasePart") and 30 >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - a.Position).Magnitude then
game:GetService("ReplicatedStorage").Shared.Network.RemotePromise.Remotes.C_ActivateObject:FireServer(v)
end
end
end
if v.Name == "Holy Water" then
for c, a in pairs(v:GetChildren()) do
if a:IsA("BasePart") and 30 >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - a.Position).Magnitude then
game:GetService("ReplicatedStorage").Remotes.Tool.PickUpTool:FireServer(v)
end
end
end
if v.Name == "Molotov" then
for c, a in pairs(v:GetChildren()) do
if a:IsA("BasePart") and 30 >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - a.Position).Magnitude then
game:GetService("ReplicatedStorage").Remotes.Tool.PickUpTool:FireServer(v)
end
end
end
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
task.wait()
end
end)

_G.FullBright = false
_G.GetOldBright = {
	Brightness = game.Lighting.Brightness,
	ClockTime = game.Lighting.ClockTime,
	FogEnd = game.Lighting.FogEnd,
	GlobalShadows = game.Lighting.GlobalShadows,
	OutdoorAmbient = game.Lighting.OutdoorAmbient
}
ButtonCr("FullBright: OFF", "FullBright", function()
_G.FullBright = not _G.FullBright
SetText("FullBright", "FullBright: "..(_G.FullBright and "ON" or "OFF"))

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
end)

_G.NahSpeed = false
ButtonCr("Walkspeed: OFF", "Speed", function()
_G.NahSpeed = not _G.NahSpeed
SetText("Speed", "Walkspeed: "..(_G.NahSpeed and "ON" or "OFF"))

while _G.NahSpeed do
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16.5
wait(5)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 18.5
end
task.wait(6.7)
end
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
end
end)

local Button = 0
if game.CoreGui:FindFirstChild("GiangHub") then
for i, v in ipairs(game.CoreGui.GiangHub.Frame2.Frame.Frame1:GetChildren()) do
    if v:IsA("TextButton") then
        Button += 1
    end
end
game.CoreGui.GiangHub.Frame2.Frame.Frame1.CanvasSize = UDim2.new(0, 0, 0, Button * ((0.2 * game.CoreGui.GiangHub.Frame2.Frame.Frame1.AbsoluteSize.Y) + 5) - 5 + 10)
end

--- Time Win ---

local Frame = Instance.new("Frame")
Frame.Name = "TimeWin"
Frame.Size = UDim2.new(0.13, 0, 0.1, 0)
Frame.Position = UDim2.new(0.03, 0, 0.05, 0)
Frame.BackgroundColor3 = Color3.new(1, 1, 1)
Frame.BorderColor3 = Color3.new(0, 0, 0)
Frame.BorderSizePixel = 1
Frame.Active = true
Frame.BackgroundTransparency = 0.3
Frame.Draggable = true
Frame.Parent = gui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = Frame

local UICorner = Instance.new("UIStroke")
UICorner.Color = Color3.new(0, 0, 0)
UICorner.Thickness = 2.3
UICorner.Parent = Frame

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(1, 0, 1, 0)
TextLabel.Position = UDim2.new(0, 0, 0, 0)
TextLabel.BackgroundColor3 = Color3.new(255, 255, 255)
TextLabel.BorderColor3 = Color3.new(0, 0, 0)
TextLabel.BorderSizePixel = 1
TextLabel.Text = "10:00"
TextLabel.TextSize = 30
TextLabel.FontFace = Font.new("rbxassetid://12187372175", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
TextLabel.BackgroundTransparency = 1
TextLabel.TextColor3 = Color3.new(0, 0, 0)
TextLabel.Parent = Frame

local Time = 10 * 60
function CheckTime(Sec)
local Minutes = math.floor(Sec / 60)
local Sec2 = Sec % 60
return string.format("%02d:%02d", Minutes, Sec2)
end

while Time >= 0 do
TextLabel.Text = CheckTime(Time)
wait(1)
Time = Time - 1
end
TextLabel.Text = "00:00"
end
end)

function Noclip(Value)
if game.Players.LocalPlayer.Character ~= nil then
		for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
			if v:IsA("BasePart") then
				v.CanCollide = not Value
			end
		end
	end
end

if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
end
game.Players.LocalPlayer.CameraMode = "Classic"
game.Players.LocalPlayer.CameraMaxZoomDistance = math.huge
game.Players.LocalPlayer.CameraMinZoomDistance = 0

_G.Noclip = true
spawn(function()
while _G.Noclip do
Noclip(true)
task.wait()
end
end)
repeat task.wait()
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = workspace.RuntimeItems:FindFirstChild("GoldBar").Prop_GoldBar.Position
end
until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - workspace.RuntimeItems:FindFirstChild("GoldBar").Prop_GoldBar.Position).Magnitude < 6.5
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
end
wait(0.5)
if workspace:FindFirstChild("StartingZone") and workspace.StartingZone:FindFirstChild("Buildings") then
for z, j in pairs(workspace.StartingZone.Buildings:GetChildren()) do
if j.Name:find("Trading") and j:FindFirstChild("BountySquare") then
for k, w in pairs(j.BountySquare:GetChildren()) do
if w.Name == "Part" and w:FindFirstChild("SurfaceGui") and w.SurfaceGui:FindFirstChild("TextLabel") then
game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent.RequestStartDrag:FireServer(workspace.RuntimeItems:FindFirstChild("GoldBar"))
wait(0.3)
workspace.RuntimeItems:FindFirstChild("GoldBar"):SetPrimaryPartCFrame(w.CFrame)
task.wait(0.3)
game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent.RequestStopDrag:FireServer()
end
end
end
end
end
wait(1)
for i, v in pairs(workspace:FindFirstChild("RuntimeItems"):GetChildren()) do
if v.Name == "Moneybag" and v:FindFirstChild("MoneyBag") and v.MoneyBag:FindFirstChild("CollectPrompt") then
v.MoneyBag:FindFirstChild("CollectPrompt").HoldDuration = 0
if fireproximityprompt then
fireproximityprompt(v.MoneyBag:FindFirstChild("CollectPrompt"))
end
end
end
wait(0.8)
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
wait(0.5)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.TeslaLab.Generator.Generator.CFrame
repeat task.wait() until workspace.RuntimeItems:FindFirstChild("Chair")
wait(0.3)
for i, v in pairs(workspace.RuntimeItems:GetChildren()) do
if v.Name == "Chair" and v:FindFirstChild("Seat") then
v.Seat.Disabled = false
end
end
wait(0.5)
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
repeat task.wait()
for i, v in pairs(workspace.RuntimeItems:GetChildren()) do
if v.Name == "Chair" and v:FindFirstChild("Seat") and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Seat.Position).Magnitude < 250 then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Seat.CFrame
end
end
until game.Players.LocalPlayer.Character.Humanoid.Sit == true
wait(0.5)
game.Players.LocalPlayer.Character.Humanoid.Sit = false
wait(0.6)
for i, v in pairs(workspace:FindFirstChild("RuntimeItems"):GetChildren()) do
if (v.Name == "GoldBar" or v.Name == "SilverBar") and v.PrimaryPart ~= nil and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.PrimaryPart.Position).Magnitude < 200 then
repeat task.wait()
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = v.PrimaryPart.Position
end
until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.PrimaryPart.Position).Magnitude < 6.5
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
end
wait(0.5)
if game.Players.LocalPlayer.Backpack:FindFirstChild("Sack") then
game.Players.LocalPlayer.Backpack:FindFirstChild("Sack").Parent = game.Players.LocalPlayer.Character
wait(0.2)
end
if game.Players.LocalPlayer.Character:FindFirstChild("Sack") and game.Players.LocalPlayer.Character.Sack:FindFirstChild("BillboardGui") and game.Players.LocalPlayer.Character.Sack.BillboardGui:FindFirstChild("TextLabel") then
if game.Players.LocalPlayer.Character.Sack.BillboardGui.TextLabel.Text ~= (game.Players.LocalPlayer.Character.Sack.SackSettings:FindFirstChild("Limit").Value.."/"..game.Players.LocalPlayer.Character.Sack.SackSettings:FindFirstChild("Limit").Value) then
game:GetService("ReplicatedStorage").Remotes.StoreItem:FireServer(v)
end
end
end
end
wait(0.5)
for i, v in pairs(workspace:GetChildren()) do
if v:IsA("Model") and v:FindFirstChild("RequiredComponents") then
if v.RequiredComponents:FindFirstChild("Controls") and v.RequiredComponents.Controls:FindFirstChild("ConductorSeat") and v.RequiredComponents.Controls.ConductorSeat:FindFirstChild("VehicleSeat") then
game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(v.RequiredComponents.Controls.ConductorSeat:FindFirstChild("VehicleSeat").CFrame)
end
end
end
wait(0.5)
game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
wait(0.8)
if workspace:FindFirstChild("StartingZone") and workspace.StartingZone:FindFirstChild("Buildings") then
for z, j in pairs(workspace.StartingZone.Buildings:GetChildren()) do
if j.Name:find("Trading") and j:FindFirstChild("BountySquare") then
for k, w in pairs(j.BountySquare:GetChildren()) do
if w.Name == "Part" and w:FindFirstChild("SurfaceGui") and w.SurfaceGui:FindFirstChild("TextLabel") then
repeat task.wait()
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = w.Position
end
until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - w.Position).Magnitude < 6.5
end
end
end
end
end
if game.Players.LocalPlayer.Backpack:FindFirstChild("Sack") then
game.Players.LocalPlayer.Backpack:FindFirstChild("Sack").Parent = game.Players.LocalPlayer.Character
wait(0.2)
end
wait(0.2)
if game.Players.LocalPlayer.Character:FindFirstChild("Sack")  then
for i = 1, game.Players.LocalPlayer.Character.Sack.SackSettings:FindFirstChild("Limit").Value do
game:GetService("ReplicatedStorage").Remotes.DropItem:FireServer()
end
task.wait()
end
wait(0.5)
for i, v in pairs(workspace:FindFirstChild("RuntimeItems"):GetChildren()) do
if v.Name == "Moneybag" and v:FindFirstChild("MoneyBag") and v.MoneyBag:FindFirstChild("CollectPrompt") then
v.MoneyBag:FindFirstChild("CollectPrompt").HoldDuration = 0
if fireproximityprompt then
fireproximityprompt(v.MoneyBag:FindFirstChild("CollectPrompt"))
end
end
end
wait(0.5)
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
if workspace:FindFirstChild("StartingZone") and workspace.StartingZone:FindFirstChild("Buildings") then
for i, v in pairs(workspace.StartingZone.Buildings:GetChildren()) do
if v.Name:find("Doctor") then
if v:FindFirstChild("BandageTable") and v.BandageTable:FindFirstChild("ShopItems") and v.BandageTable.ShopItems:FindFirstChild("Bandage") then
repeat task.wait()
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = v.BandageTable.ShopItems:FindFirstChild("Bandage").PrimaryPart.Position + Vector3.new(-5, 0, 5)
until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.BandageTable.ShopItems:FindFirstChild("Bandage").PrimaryPart.Position).Magnitude < 7
task.wait(0.5)
for o = 1, 2 do
for k = 1, 5 do
game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent.RequestStartDrag:FireServer(v.BandageTable.ShopItems:FindFirstChild("Bandage"))
wait(0.3)
spawn(function()
for h = 1, 70 do
if v:FindFirstChild("Counter") and v.Counter:FindFirstChild("ShopItemDetect") then
v.BandageTable.ShopItems:FindFirstChild("Bandage"):SetPrimaryPartCFrame(v.Counter:FindFirstChild("ShopItemDetect").CFrame)
end
task.wait()
end
end)
wait(0.4)
if v:FindFirstChild("Counter") and v.Counter:FindFirstChild("Register") and v.Counter.Register:FindFirstChild("Box") then
fireclickdetector(v.Counter.Register.Box:FindFirstChild("ClickDetector"))
end
wait(0.3)
game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent.RequestStopDrag:FireServer()
task.wait(0.7)
end
end
end
end
end
end
end
wait(0.5)
for i, v in pairs(workspace:FindFirstChild("RuntimeItems"):GetChildren()) do
if v.Name == "Bandage" then
for c, a in pairs(v:GetChildren()) do
if a:IsA("BasePart") then
repeat task.wait()
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = a.Position
until 10.5 >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - a.Position).Magnitude
game:GetService("ReplicatedStorage").Remotes.Tool.PickUpTool:FireServer(v)
end
end
end
end
wait(0.5)
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
if workspace:FindFirstChild("StartingZone") and workspace.StartingZone:FindFirstChild("Buildings") then
for z, j in pairs(workspace.StartingZone.Buildings:GetChildren()) do
if j.Name:find("Gunsmith") then
repeat task.wait()
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = j.AmmoTable.ShopItems:FindFirstChild("ShotgunShells").PrimaryPart.Position
until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - j.AmmoTable.ShopItems:FindFirstChild("ShotgunShells").PrimaryPart.Position).Magnitude < 5.5
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
end
task.wait(0.5)
if j:FindFirstChild("AmmoTable") and j.AmmoTable:FindFirstChild("ShopItems") and j.AmmoTable.ShopItems:FindFirstChild("ShotgunShells") then
for i = 1, 4 do
game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent.RequestStartDrag:FireServer(j.AmmoTable.ShopItems:FindFirstChild("ShotgunShells"))
wait(0.3)
spawn(function()
for h = 1, 80 do
if j:FindFirstChild("Counter") and j.Counter:FindFirstChild("ShopItemDetect") then
j.AmmoTable.ShopItems:FindFirstChild("ShotgunShells"):SetPrimaryPartCFrame(j.Counter:FindFirstChild("ShopItemDetect").CFrame)
end
task.wait()
end
end)
wait(0.5)
if j:FindFirstChild("Counter") and j.Counter:FindFirstChild("Register") and j.Counter.Register:FindFirstChild("Box") then
fireclickdetector(j.Counter.Register.Box:FindFirstChild("ClickDetector"))
end
wait(0.3)
game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent.RequestStopDrag:FireServer()
task.wait(1)
end
end
wait(0.5)
if j:FindFirstChild("GunTable") and j.GunTable:FindFirstChild("ShopItems") then
repeat task.wait()
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = j.GunTable.ShopItems:FindFirstChild("Shotgun").PrimaryPart.Position
until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - j.GunTable.ShopItems:FindFirstChild("Shotgun").PrimaryPart.Position).Magnitude < 5.5
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
end
wait(0.8)
game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent.RequestStartDrag:FireServer(j.GunTable.ShopItems:FindFirstChild("Shotgun"))
wait(0.3)
spawn(function()
for h = 1, 80 do
if j:FindFirstChild("Counter") and j.Counter:FindFirstChild("ShopItemDetect") then
j.GunTable.ShopItems:FindFirstChild("Shotgun"):SetPrimaryPartCFrame(j.Counter:FindFirstChild("ShopItemDetect").CFrame)
end
task.wait()
end
end)
wait(0.5)
if j:FindFirstChild("Counter") and j.Counter:FindFirstChild("Register") and j.Counter.Register:FindFirstChild("Box") then
fireclickdetector(j.Counter.Register.Box:FindFirstChild("ClickDetector"))
end
wait(0.7)
game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent.RequestStopDrag:FireServer()
end
wait(0.5)
for i, v in pairs(workspace:FindFirstChild("RuntimeItems"):GetChildren()) do
if v.Name:find("Ammo") or v.Name:find("Shells") then
for c, a in pairs(v:GetChildren()) do
if a:IsA("BasePart") then
repeat task.wait()
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = a.Position
until 10.5 >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - a.Position).Magnitude
game:GetService("ReplicatedStorage").Shared.Network.RemotePromise.Remotes.C_ActivateObject:FireServer(v)
end
end
end
if v:FindFirstChild("ServerWeaponState") then
for c, a in pairs(v:GetChildren()) do
if a:IsA("BasePart") then
repeat task.wait()
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = a.Position
until 10.5 >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - a.Position).Magnitude
game:GetService("ReplicatedStorage").Remotes.Tool.PickUpTool:FireServer(v)
end
end
elseif v:FindFirstChild("ObjectInfo") then
for h, m in pairs(v.ObjectInfo:GetChildren()) do
if m.Name == "TextLabel" and m.Text == "Gun" then
for c, a in pairs(v:GetChildren()) do
if a:IsA("BasePart") then
repeat task.wait()
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = a.Position
until 10.5 >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - a.Position).Magnitude
game:GetService("ReplicatedStorage").Remotes.Tool.PickUpTool:FireServer(v)
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
wait(0.5)
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
wait(0.5)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-424, 30, -49041)
repeat task.wait() until workspace.Baseplates:FindFirstChild("FinalBasePlate")
BasePart = workspace.Baseplates:FindFirstChild("FinalBasePlate")
OurLaw = BasePart:FindFirstChild("OutlawBase") 
Sen = OurLaw:FindFirstChild("Sentries")
if Sen.EnemyTurret:FindFirstChild("TurretOutlaw") and Sen.EnemyTurret.TurretOutlaw:FindFirstChild("Humanoid") and Sen.EnemyTurret.TurretOutlaw:FindFirstChild("HumanoidRootPart") then
while Sen.EnemyTurret:FindFirstChild("TurretOutlaw").Humanoid.Health > 0 do
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Sen.EnemyTurret:FindFirstChild("TurretOutlaw").HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
task.wait()
end
end
for i, v in pairs(Sen:FindFirstChild("EnemyTurret"):GetChildren()) do
if v.Name == "MaximGun" and v:FindFirstChild("VehicleSeat") then
v.VehicleSeat.Disabled = false
end
end
wait(0.5)
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
repeat task.wait()
for i, v in pairs(Sen:FindFirstChild("EnemyTurret"):GetChildren()) do
if v.Name == "MaximGun" and v:FindFirstChild("VehicleSeat") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.VehicleSeat.CFrame
end
end
until game.Players.LocalPlayer.Character.Humanoid.Sit == true
wait(0.5)
game.Players.LocalPlayer.Character.Humanoid.Sit = false
wait(0.5)
for i, v in pairs(OurLaw:FindFirstChild("Buildings"):GetChildren()) do
if v.Name:find("House") and v:FindFirstChild("Lantern") and v.Lantern:FindFirstChild("Bulb") then
repeat task.wait()
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = v.Lantern:FindFirstChild("Bulb").Position + Vector3.new(0, 0, 5)
end
until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Lantern:FindFirstChild("Bulb").Position).Magnitude < 5.8
wait(0.5)
for i, v in pairs(workspace:FindFirstChild("RuntimeItems"):GetChildren()) do
if v.Name == "Bond" then
for c, a in pairs(v:GetChildren()) do
if a:IsA("BasePart") and 30 >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - a.Position).Magnitude then
game:GetService("ReplicatedStorage").Shared.Network.RemotePromise.Remotes.C_ActivateObject:FireServer(v)
end
end
end
if v.Name:find("Ammo") or v.Name:find("Shells") then
for c, a in pairs(v:GetChildren()) do
if a:IsA("BasePart") and 30 >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - a.Position).Magnitude then
game:GetService("ReplicatedStorage").Shared.Network.RemotePromise.Remotes.C_ActivateObject:FireServer(v)
end
end
end
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
end
end
wait(0.5)
for i, v in pairs(workspace:FindFirstChild("RuntimeItems"):GetChildren()) do
if v.Name:find("Outlaw") and v:FindFirstChild("HumanoidRootPart") then
repeat task.wait()
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = v:FindFirstChild("HumanoidRootPart").Position
end
until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v:FindFirstChild("HumanoidRootPart").Position).Magnitude < 6.5
wait(0.5)
if game.Players.LocalPlayer.Backpack:FindFirstChild("Sack") then
game.Players.LocalPlayer.Backpack:FindFirstChild("Sack").Parent = game.Players.LocalPlayer.Character
end
wait(0.2)
if game.Players.LocalPlayer.Character:FindFirstChild("Sack") and game.Players.LocalPlayer.Character.Sack:FindFirstChild("BillboardGui") and game.Players.LocalPlayer.Character.Sack.BillboardGui:FindFirstChild("TextLabel") then
if game.Players.LocalPlayer.Character.Sack.BillboardGui.TextLabel.Text ~= (game.Players.LocalPlayer.Character.Sack.SackSettings:FindFirstChild("Limit").Value.."/"..game.Players.LocalPlayer.Character.Sack.SackSettings:FindFirstChild("Limit").Value) then
game:GetService("ReplicatedStorage").Remotes.StoreItem:FireServer(v)
end
end
end
end
wait(0.5)
for i, v in pairs(workspace:GetChildren()) do
if v:IsA("Model") and v:FindFirstChild("RequiredComponents") then
if v.RequiredComponents:FindFirstChild("Controls") and v.RequiredComponents.Controls:FindFirstChild("ConductorSeat") and v.RequiredComponents.Controls.ConductorSeat:FindFirstChild("VehicleSeat") then
game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(v.RequiredComponents.Controls.ConductorSeat:FindFirstChild("VehicleSeat").CFrame)
end
end
end
wait(0.5)
game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
wait(0.8)
if workspace:FindFirstChild("StartingZone") and workspace.StartingZone:FindFirstChild("Buildings") then
for z, j in pairs(workspace.StartingZone.Buildings:GetChildren()) do
if j.Name:find("Sheriffs") and j:FindFirstChild("BountySquare") then
for k, w in pairs(j.BountySquare:GetChildren()) do
if w.Name == "Part" and w:FindFirstChild("SurfaceGui") and w.SurfaceGui:FindFirstChild("TextLabel") then
repeat task.wait()
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = w.Position
end
until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - w.Position).Magnitude < 7
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
end
end
end
end
end
end
wait(0.5)
if game.Players.LocalPlayer.Backpack:FindFirstChild("Sack") then
game.Players.LocalPlayer.Backpack:FindFirstChild("Sack").Parent = game.Players.LocalPlayer.Character
end
wait(0.2)
if game.Players.LocalPlayer.Character:FindFirstChild("Sack")  then
for i = 1, game.Players.LocalPlayer.Character.Sack.SackSettings:FindFirstChild("Limit").Value do
game:GetService("ReplicatedStorage").Remotes.DropItem:FireServer()
end
task.wait()
end
wait(0.5)
for i, v in pairs(workspace:FindFirstChild("RuntimeItems"):GetChildren()) do
if v.Name == "Moneybag" and v:FindFirstChild("MoneyBag") and v.MoneyBag:FindFirstChild("CollectPrompt") then
v.MoneyBag:FindFirstChild("CollectPrompt").HoldDuration = 0
if fireproximityprompt then
fireproximityprompt(v.MoneyBag:FindFirstChild("CollectPrompt"))
end
end
end
wait(0.5)
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
if workspace:FindFirstChild("StartingZone") and workspace.StartingZone:FindFirstChild("Buildings") then
for i, v in pairs(workspace.StartingZone.Buildings:GetChildren()) do
if v.Name:find("Doctor") then
if v:FindFirstChild("BandageTable") and v.BandageTable:FindFirstChild("ShopItems") and v.BandageTable.ShopItems:FindFirstChild("Bandage") then
repeat task.wait()
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = v.BandageTable.ShopItems:FindFirstChild("Bandage").PrimaryPart.Position + Vector3.new(-5, 0, 5)
until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.BandageTable.ShopItems:FindFirstChild("Bandage").PrimaryPart.Position).Magnitude < 8.5
task.wait(0.5)
for o = 1, 4 do
for k = 1, 5 do
game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent.RequestStartDrag:FireServer(v.BandageTable.ShopItems:FindFirstChild("Bandage"))
wait(0.3)
spawn(function()
for h = 1, 70 do
if v:FindFirstChild("Counter") and v.Counter:FindFirstChild("ShopItemDetect") then
v.BandageTable.ShopItems:FindFirstChild("Bandage"):SetPrimaryPartCFrame(v.Counter:FindFirstChild("ShopItemDetect").CFrame)
end
task.wait()
end
end)
wait(0.4)
if v:FindFirstChild("Counter") and v.Counter:FindFirstChild("Register") and v.Counter.Register:FindFirstChild("Box") then
fireclickdetector(v.Counter.Register.Box:FindFirstChild("ClickDetector"))
end
wait(0.3)
game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent.RequestStopDrag:FireServer()
task.wait(0.7)
end
end
end
end
end
end
end
wait(0.5)
for i, v in pairs(workspace:FindFirstChild("RuntimeItems"):GetChildren()) do
if v.Name == "Bandage" then
for c, a in pairs(v:GetChildren()) do
if a:IsA("BasePart") then
repeat task.wait()
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = a.Position
until 10.5 >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - a.Position).Magnitude
game:GetService("ReplicatedStorage").Remotes.Tool.PickUpTool:FireServer(v)
end
end
end
end
wait(0.5)
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
if workspace:FindFirstChild("StartingZone") and workspace.StartingZone:FindFirstChild("Buildings") then
for z, j in pairs(workspace.StartingZone.Buildings:GetChildren()) do
if j.Name:find("Gunsmith") then
repeat task.wait()
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = j.AmmoTable.ShopItems:FindFirstChild("ShotgunShells").PrimaryPart.Position
until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - j.AmmoTable.ShopItems:FindFirstChild("ShotgunShells").PrimaryPart.Position).Magnitude < 5.5
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
end
task.wait(0.5)
if j:FindFirstChild("AmmoTable") and j.AmmoTable:FindFirstChild("ShopItems") and j.AmmoTable.ShopItems:FindFirstChild("ShotgunShells") then
for i = 1, 4 do
game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent.RequestStartDrag:FireServer(j.AmmoTable.ShopItems:FindFirstChild("ShotgunShells"))
wait(0.3)
spawn(function()
for h = 1, 80 do
if j:FindFirstChild("Counter") and j.Counter:FindFirstChild("ShopItemDetect") then
j.AmmoTable.ShopItems:FindFirstChild("ShotgunShells"):SetPrimaryPartCFrame(j.Counter:FindFirstChild("ShopItemDetect").CFrame)
end
task.wait()
end
end)
wait(0.5)
if j:FindFirstChild("Counter") and j.Counter:FindFirstChild("Register") and j.Counter.Register:FindFirstChild("Box") then
fireclickdetector(j.Counter.Register.Box:FindFirstChild("ClickDetector"))
end
wait(0.3)
game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent.RequestStopDrag:FireServer()
task.wait(1)
end
end
wait(0.5)
for i, v in pairs(workspace:FindFirstChild("RuntimeItems"):GetChildren()) do
if v.Name:find("Ammo") or v.Name:find("Shells") then
for c, a in pairs(v:GetChildren()) do
if a:IsA("BasePart") then
repeat task.wait()
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = a.Position
until 10.5 >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - a.Position).Magnitude
game:GetService("ReplicatedStorage").Shared.Network.RemotePromise.Remotes.C_ActivateObject:FireServer(v)
end
end
end
if v:FindFirstChild("ServerWeaponState") then
for c, a in pairs(v:GetChildren()) do
if a:IsA("BasePart") then
repeat task.wait()
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = a.Position
until 10.5 >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - a.Position).Magnitude
game:GetService("ReplicatedStorage").Remotes.Tool.PickUpTool:FireServer(v)
end
end
elseif v:FindFirstChild("ObjectInfo") then
for h, m in pairs(v.ObjectInfo:GetChildren()) do
if m.Name == "TextLabel" and m.Text == "Gun" then
for c, a in pairs(v:GetChildren()) do
if a:IsA("BasePart") then
repeat task.wait()
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = a.Position
until 10.5 >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - a.Position).Magnitude
game:GetService("ReplicatedStorage").Remotes.Tool.PickUpTool:FireServer(v)
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
wait(0.8)
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
wait(0.5)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.TeslaLab.Generator.Generator.CFrame
repeat task.wait() until workspace.RuntimeItems:FindFirstChild("Chair")
wait(0.3)
for i, v in pairs(workspace.RuntimeItems:GetChildren()) do
if v.Name == "Chair" and v:FindFirstChild("Seat") then
v.Seat.Disabled = false
end
end
wait(0.5)
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
repeat task.wait()
for i, v in pairs(workspace.RuntimeItems:GetChildren()) do
if v.Name == "Chair" and v:FindFirstChild("Seat") and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Seat.Position).Magnitude < 250 then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Seat.CFrame
end
end
until game.Players.LocalPlayer.Character.Humanoid.Sit == true
wait(0.5)
game.Players.LocalPlayer.Character.Humanoid.Sit = false
wait(0.5)
if workspace:FindFirstChild("TeslaLab") and workspace.TeslaLab:FindFirstChild("ExperimentTable") then
for n, m in pairs(workspace.RuntimeItems:GetChildren()) do
if (m.Name:find("Werewolf") or m.Name == "BrainJar") and m:FindFirstChild("HumanoidRootPart") == nil and m.PrimaryPart then
repeat task.wait()
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = m.PrimaryPart.Position
end
until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - m.PrimaryPart.Position).Magnitude < 10
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
end
wait(0.3)
if game.Players.LocalPlayer.Backpack:FindFirstChild("Sack") then
game.Players.LocalPlayer.Backpack:FindFirstChild("Sack").Parent = game.Players.LocalPlayer.Character
end
wait(0.2)
if game.Players.LocalPlayer.Character:FindFirstChild("Sack") and game.Players.LocalPlayer.Character.Sack:FindFirstChild("BillboardGui") and game.Players.LocalPlayer.Character.Sack.BillboardGui:FindFirstChild("TextLabel") then
if game.Players.LocalPlayer.Character.Sack.BillboardGui.TextLabel.Text ~= (game.Players.LocalPlayer.Character.Sack.SackSettings:FindFirstChild("Limit").Value.."/"..game.Players.LocalPlayer.Character.Sack.SackSettings:FindFirstChild("Limit").Value) then
game:GetService("ReplicatedStorage").Remotes.StoreItem:FireServer(m)
end
end
end
end
wait(0.5)
repeat task.wait()
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = workspace.TeslaLab.ExperimentTable:FindFirstChild("Hitbox").Position
end
until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - workspace.TeslaLab.ExperimentTable:FindFirstChild("Hitbox").Position).Magnitude < 5.6
wait(0.5)
if game.Players.LocalPlayer.Backpack:FindFirstChild("Sack") then
game.Players.LocalPlayer.Backpack:FindFirstChild("Sack").Parent = game.Players.LocalPlayer.Character
end
wait(0.2)
if game.Players.LocalPlayer.Character:FindFirstChild("Sack")  then
for i = 1, game.Players.LocalPlayer.Character.Sack.SackSettings:FindFirstChild("Limit").Value do
game:GetService("ReplicatedStorage").Remotes.DropItem:FireServer()
end
task.wait()
end
end
wait(0.7)
if workspace.TeslaLab:FindFirstChild("Generator") then
for i, v in pairs(workspace.TeslaLab.Generator:GetChildren()) do
if v.Name:find("BasePart") then
repeat task.wait()
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = v.Position
end
until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude < 6.5
wait(0.3)
if fireproximityprompt then
fireproximityprompt(v:FindFirstChild("PowerPrompt"))
end
end
end
end
wait(0.5)
repeat task.wait()
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = workspace.TeslaLab.ExperimentTable:FindFirstChild("Hitbox").Position + Vector3.new(-5, 0, 5)
until workspace.RuntimeItems:FindFirstChild("Electrocutioner")
wait(0.5)
repeat task.wait()
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = workspace.RuntimeItems:FindFirstChild("Electrocutioner").PrimaryPart.Position
until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - workspace.RuntimeItems:FindFirstChild("Electrocutioner").PrimaryPart.Position).Magnitude < 6.5
game:GetService("ReplicatedStorage").Remotes.Tool.PickUpTool:FireServer(workspace.RuntimeItems:FindFirstChild("Electrocutioner"))
wait(0.5)
for i, v in pairs(workspace:FindFirstChild("RuntimeItems"):GetChildren()) do
if v.Name == "Bond" then
game:GetService("ReplicatedStorage").Shared.Network.RemotePromise.Remotes.C_ActivateObject:FireServer(v)
end
end
wait(0.5)
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
wait(0.5)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-424, 30, -49041)
repeat task.wait() until workspace.Baseplates:FindFirstChild("FinalBasePlate")
BasePart = workspace.Baseplates:FindFirstChild("FinalBasePlate")
OurLaw = BasePart:FindFirstChild("OutlawBase") 
Sen = OurLaw:FindFirstChild("Sentries")
if Sen.EnemyTurret:FindFirstChild("TurretOutlaw") and Sen.EnemyTurret.TurretOutlaw:FindFirstChild("Humanoid") and Sen.EnemyTurret.TurretOutlaw:FindFirstChild("HumanoidRootPart") then
while Sen.EnemyTurret:FindFirstChild("TurretOutlaw").Humanoid.Health > 0 do
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Sen.EnemyTurret:FindFirstChild("TurretOutlaw").HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
task.wait()
end
end
for i, v in pairs(Sen:FindFirstChild("EnemyTurret"):GetChildren()) do
if v.Name == "MaximGun" and v:FindFirstChild("VehicleSeat") then
v.VehicleSeat.Disabled = false
end
end
wait(0.5)
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
repeat task.wait()
for i, v in pairs(Sen:FindFirstChild("EnemyTurret"):GetChildren()) do
if v.Name == "MaximGun" and v:FindFirstChild("VehicleSeat") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.VehicleSeat.CFrame
end
end
until game.Players.LocalPlayer.Character.Humanoid.Sit == true
wait(0.5)
game.Players.LocalPlayer.Character.Humanoid.Sit = false
wait(0.5)
BridgeTop = OurLaw:FindFirstChild("Bridge")
BridgeControlTop = BridgeTop:FindFirstChild("BridgeControl")
wait(0.5)
repeat task.wait()
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = BridgeControlTop.Crank.Model.Mid.Position
until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - BridgeControlTop.Crank.Model.Mid.Position).Magnitude < 6.5
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
end
wait(0.3)
repeat task.wait(1)
if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - BridgeControlTop.Crank.Model.Mid.Position).Magnitude < 10 then
fireproximityprompt(BridgeControlTop.Crank.Model.Mid:FindFirstChild("EndGame"))
end
until BridgeControlTop:FindFirstChild("Part") and BridgeControlTop.Part:FindFirstChild("BillboardGui").Enabled == true
wait(0.3)
repeat task.wait()
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = Vector3.new(238, 3, -48902)
until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(238, 3, -48902)).Magnitude < 6.5
wait(0.5)
repeat task.wait()
local DistanceMathMods = math.huge
local ModsTargetHead
for i, v in pairs(workspace:GetDescendants()) do
if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Head") and not game.Players:GetPlayerFromCharacter(v) then
local Distance2 = (game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position - v.HumanoidRootPart.Position).Magnitude
if Distance2 < DistanceMathMods then
if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then 
if game.Players.LocalPlayer.Character:FindFirstChild("Esp_LocalPlayer") == nil then
	local Highlight = Instance.new("Highlight")
	Highlight.Name = "Esp_LocalPlayer"
	Highlight.FillColor = Color3.fromRGB(0, 255, 0) 
	Highlight.OutlineColor = Color3.fromRGB(255, 255, 255) 
	Highlight.FillTransparency = 0.5
	Highlight.OutlineTransparency = 0
	Highlight.Adornee = game.Players.LocalPlayer.Character
	Highlight.Parent = game.Players.LocalPlayer.Character
end
ModsTargetHead, DistanceMathMods, ModsTargetShotHumanoid = v:FindFirstChild("Head"), Distance2, v:FindFirstChild("Humanoid")
if game.CoreGui:FindFirstChild("Gun Health Track").Enabled == false then
game.CoreGui["Gun Health Track"].Enabled = true
elseif game.CoreGui:FindFirstChild("Gun Health Track").Enabled == true then
game.CoreGui["Gun Health Track"].Frame:FindFirstChild("TextLabel").Text = (v.Name:gsub("Model_", "").." Health: "..string.format("%.0f", (v.Humanoid.Health)).." / "..v.Humanoid.MaxHealth)
game.CoreGui["Gun Health Track"].Frame:FindFirstChild("Frame").Size = UDim2.new(v.Humanoid.Health / v.Humanoid.MaxHealth, 0, 1, 0)
end
end
end
end
end
if ModsTargetHead then
if game.Workspace.CurrentCamera.CameraSubject ~= ModsTargetHead then
game.Workspace.CurrentCamera.CameraSubject = ModsTargetHead
end
_G.ModsShotgun = {}
ShotNow = {14, 8, 2, 5, 11, 17}
for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:FindFirstChild("ClientWeaponState") and v.ClientWeaponState:FindFirstChild("CurrentAmmo") then
			if v.ClientWeaponState.CurrentAmmo.Value ~= 0 then
				if v.Name == "Shotgun" or v.Name == "Sawed-Off Shotgun" then
					for i, v in pairs(ShotNow) do
					    _G.ModsShotgun[v] = ModsTargetShotHumanoid
					end
				else
					_G.ModsShotgun["2"] = ModsTargetShotHumanoid
				end
				if _G.ModsShotgun ~= nil then
					game.ReplicatedStorage.Remotes.Weapon.Shoot:FireServer(game.Workspace:GetServerTimeNow(), v, CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, ModsTargetHead.Position), _G.ModsShotgun)
					game.ReplicatedStorage.Remotes.Weapon.Reload:FireServer(game.Workspace:GetServerTimeNow(), v)
				end
			end
        end
    end
else
if game.Players.LocalPlayer.Character:FindFirstChild("Esp_LocalPlayer") then
game.Players.LocalPlayer.Character:FindFirstChild("Esp_LocalPlayer"):Destroy()
end
if game.CoreGui:FindFirstChild("Gun Health Track").Enabled == true then
game.CoreGui["Gun Health Track"].Enabled = false
game.CoreGui["Gun Health Track"].Frame:FindFirstChild("TextLabel").Text = "Nah Health: Nil"
game.CoreGui["Gun Health Track"].Frame:FindFirstChild("Frame").Size = UDim2.new(1, 0, 1, 0)
end
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Workspace.CurrentCamera.CameraSubject ~= game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
end
end
until workspace.RuntimeEntities:FindFirstChild("Model_NikolaTesla") and workspace.RuntimeEntities.NikolaTesla:FindFirstChild("Head")
wait(0.5)
repeat task.wait()
if workspace.RuntimeEntities:FindFirstChild("Model_NikolaTesla") then
if game.Workspace.CurrentCamera.CameraSubject ~= workspace.RuntimeEntities.Model_NikolaTesla:FindFirstChild("Head") then
game.Workspace.CurrentCamera.CameraSubject = workspace.RuntimeEntities.Model_NikolaTesla:FindFirstChild("Head")
end
if game.CoreGui:FindFirstChild("Gun Health Track").Enabled == false then
game.CoreGui["Gun Health Track"].Enabled = true
elseif game.CoreGui:FindFirstChild("Gun Health Track").Enabled == true then
game.CoreGui["Gun Health Track"].Frame:FindFirstChild("TextLabel").Text = "Nikola Tesla Health: "..string.format("%.0f", (workspace.RuntimeEntities.Model_NikolaTesla:FindFirstChild("Humanoid").Health)).." / "..workspace.RuntimeEntities.Model_NikolaTesla:FindFirstChild("Humanoid").MaxHealth
game.CoreGui["Gun Health Track"].Frame:FindFirstChild("Frame").Size = UDim2.new(workspace.RuntimeEntities.Model_NikolaTesla:FindFirstChild("Humanoid").Health / workspace.RuntimeEntities.Model_NikolaTesla:FindFirstChild("Humanoid").MaxHealth, 0, 1, 0)
end
_G.ModsShotgun = {}
ShotTesla = {14, 8, 2, 5, 11, 17}
for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:FindFirstChild("ClientWeaponState") and v.ClientWeaponState:FindFirstChild("CurrentAmmo") then
			if v.ClientWeaponState.CurrentAmmo.Value ~= 0 then
				if v.Name == "Shotgun" or v.Name == "Sawed-Off Shotgun" then
					for i, v in pairs(ShotTesla) do
                       _G.ModsShotgun[v] = workspace.RuntimeEntities.Model_NikolaTesla:FindFirstChild("Humanoid")
                    end
				else
					_G.ModsShotgun["2"] = workspace.RuntimeEntities.Model_NikolaTesla:FindFirstChild("Humanoid")
				end
				if _G.ModsShotgun ~= nil then
					game.ReplicatedStorage.Remotes.Weapon.Shoot:FireServer(game.Workspace:GetServerTimeNow(), v, CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, workspace.RuntimeEntities.Model_NikolaTesla:FindFirstChild("Head").Position), _G.ModsShotgun)
					game.ReplicatedStorage.Remotes.Weapon.Reload:FireServer(game.Workspace:GetServerTimeNow(), v)
				end
			end
        end
    end
end
until workspace.RuntimeItems:FindFirstChild("Model_NikolaTesla")
wait(0.5)
if game.Players.LocalPlayer.Character:FindFirstChild("Esp_LocalPlayer") then
game.Players.LocalPlayer.Character:FindFirstChild("Esp_LocalPlayer"):Destroy()
end
if game.CoreGui:FindFirstChild("Gun Health Track").Enabled == true then
game.CoreGui["Gun Health Track"].Enabled = false
game.CoreGui["Gun Health Track"].Frame:FindFirstChild("TextLabel").Text = "Nah Health: Nil"
game.CoreGui["Gun Health Track"].Frame:FindFirstChild("Frame").Size = UDim2.new(1, 0, 1, 0)
end
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
end
wait(0.3)
repeat task.wait()
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = workspace.RuntimeItems:FindFirstChild("Model_NikolaTesla").Head.Position
until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - workspace.RuntimeItems:FindFirstChild("Model_NikolaTesla").Head.Position).Magnitude < 6.5
wait(0.3)
if game.Players.LocalPlayer.Backpack:FindFirstChild("Sack") then
game.Players.LocalPlayer.Backpack:FindFirstChild("Sack").Parent = game.Players.LocalPlayer.Character
end
wait(0.4)
game:GetService("ReplicatedStorage").Remotes.StoreItem:FireServer(workspace.RuntimeItems:FindFirstChild("Model_NikolaTesla"))
wait(0.5)
_G.Noclip = true
spawn(function()
while _G.Noclip do
Noclip(true)
task.wait()
end
end)
for i, v in pairs(workspace:GetChildren()) do
if v:IsA("Model") and v:FindFirstChild("RequiredComponents") then
if v.RequiredComponents:FindFirstChild("Controls") and v.RequiredComponents.Controls:FindFirstChild("ConductorSeat") and v.RequiredComponents.Controls.ConductorSeat:FindFirstChild("VehicleSeat") then
game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(v.RequiredComponents.Controls.ConductorSeat:FindFirstChild("VehicleSeat").CFrame)
end
end
end
wait(0.5)
game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
wait(0.8)
if workspace:FindFirstChild("StartingZone") and workspace.StartingZone:FindFirstChild("Buildings") then
for z, j in pairs(workspace.StartingZone.Buildings:GetChildren()) do
if j.Name:find("Trading") and j:FindFirstChild("BountySquare") then
for k, w in pairs(j.BountySquare:GetChildren()) do
if w.Name == "Part" and w:FindFirstChild("SurfaceGui") and w.SurfaceGui:FindFirstChild("TextLabel") then
repeat task.wait()
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = w.Position
end
until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - w.Position).Magnitude < 7
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
end
end
end
end
end
end
wait(0.2)
if game.Players.LocalPlayer.Backpack:FindFirstChild("Sack") then
game.Players.LocalPlayer.Backpack:FindFirstChild("Sack").Parent = game.Players.LocalPlayer.Character
end
wait(0.2)
if game.Players.LocalPlayer.Character:FindFirstChild("Sack")  then
for i = 1, game.Players.LocalPlayer.Character.Sack.SackSettings:FindFirstChild("Limit").Value do
game:GetService("ReplicatedStorage").Remotes.DropItem:FireServer()
end
task.wait()
end
wait(0.5)
game:GetService("StarterGui"):SetCore("SendNotification",{Title = "Auto Sell Tesla",Text = "Done 😀",Icon = "rbxassetid://7733658504",Duration = 5})