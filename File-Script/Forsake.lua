local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local PFS = game:GetService("PathfindingService")
local Storage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local playerout = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local Modules = Storage:WaitForChild("Modules")
local Network = Modules and Modules:WaitForChild("Network")
local Remote = Network and Network:WaitForChild("RemoteEvent")

local player = playerout.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")
local playergui = player:WaitForChild("PlayerGui")
local maingui = playergui:WaitForChild("MainUI")

spawn(function()
	while task.wait() do
		char = player.Character or player.CharacterAdded:Wait()
		root = char:WaitForChild("HumanoidRootPart")
		hum = char:WaitForChild("Humanoid")
	end
end)

function Distance(pos)
	if root then
		return (root.Position - pos).Magnitude
	end
end
function Distance2(pos)
	if root then
		return (pos - root.Position).Magnitude
	end
end

_G.GetOldBright = {
	["Old"] = {
		Brightness = Lighting.Brightness,
		ClockTime = Lighting.ClockTime,
		FogEnd = Lighting.FogEnd,
		FogStart = Lighting.FogStart,
		GlobalShadows = Lighting.GlobalShadows,
		OutdoorAmbient = Lighting.OutdoorAmbient
	},
	["New"] = {
		Brightness = 2,
		ClockTime = 14,
		FogEnd = 200000,
		FogStart = 100000,
		GlobalShadows = false,
		OutdoorAmbient = Color3.fromRGB(128, 128, 128)
	}
}

getgenv()._VoidRushBypass = false
getgenv()._oldFireServer = nil
if not getgenv()._oldFireServer then
    local old
    old = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        if self == Remote and method == "FireServer" then
            if args[1] == player.Name.."VoidRushCollision" then
                if getgenv()._VoidRushBypass then
                    return 
                end
            end
        end
        return old(self, ...)
    end)
    getgenv()._oldFireServer = old
end

Animations = {
	["KillerAnima"] = {
	    "126830014841198", "126355327951215", "121086746534252", "18885909645",
	    "98456918873918", "105458270463374", "83829782357897", "125403313786645",
	    "118298475669935", "82113744478546", "70371667919898", "99135633258223",
	    "97167027849946", "109230267448394", "139835501033932", "126896426760253",
	    "109667959938617", "126681776859538", "129976080405072", "121293883585738",
	    "81639435858902", "137314737492715", "92173139187970"
	},
	["Shot - Punch"] = {
		["103601716322988"] = true, ["133491532453922"] = true, ["86371356500204"] = true, ["76649505662612"] = true, 
		["81698196845041"] = true,["87259391926321"] = true, ["140703210927645"] = true, ["136007065400978"] = true, 
		["136007065400978"] = true, ["129843313690921"] = true, ["129843313690921"] = true, ["86096387000557"] = true,
		["86709774283672"] = true, ["87259391926321"] = true, ["129843313690921"] = true, ["129843313690921"] = true,
		["108807732150251"] = true, ["138040001965654"] = true, ["86096387000557"] = true
	}
}

local function isFacing(targetRoot)
    local dot = targetRoot.CFrame.LookVector:Dot((root.Position - targetRoot.Position).Unit)
    return dot > -0.3
end

function KillerTarget()
    local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
    if killersFolder then
        for _, v in ipairs(killersFolder:GetChildren()) do
            if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then
                return v.HumanoidRootPart
            end
        end
    end
    return nil
end

function PlayingAnimationId()
    local ids = {}
    if hum then
        for _, v in ipairs(hum:GetPlayingAnimationTracks()) do
            if v.Animation and v.Animation.AnimationId then
                local id = v.Animation.AnimationId:match("%d+")
                if id then
                    ids[id] = true
                end
            end
        end
    end
    return ids
end

function CheckWall(Target)
    local Direction = (Target.Position - game.Workspace.CurrentCamera.CFrame.Position).unit * (Target.Position - game.Workspace.CurrentCamera.CFrame.Position).Magnitude
    local RaycastParams = RaycastParams.new()
    RaycastParams.FilterDescendantsInstances = {game.Players.LocalPlayer.Character, game.Workspace.CurrentCamera}
    RaycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    local Result = game.Workspace:Raycast(game.Workspace.CurrentCamera.CFrame.Position, Direction, RaycastParams)
    return Result == nil or Result.Instance:IsDescendantOf(Target)
end

local ESPLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/bocaj111004/ESPLibrary/refs/heads/main/Library.lua"))()
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
Library:SetWatermarkVisibility(true)

local FrameTimer = tick()
local CurrentRooms = 0
local FrameCounter = 0
local FPS = 60
_G.PunchFlingPower = 10000
RunService.RenderStepped:Connect(function()
FrameCounter += 1
if (tick() - FrameTimer) >= 1 then
    FPS = FrameCounter
    FrameTimer = tick()
    FrameCounter = 0
end
local Killer
local ClosestDistance
for i, v in pairs(game.Workspace.Players.Killers:GetChildren()) do
	if v:IsA("Model") and v:GetAttribute("Username") ~= player.Name then
		Killer = v.Name
		ClosestDistance = Distance2(v:GetPivot().Position)
	end
end
if hum then SpeedUp = hum.WalkSpeed else SpeedUp = 0 end
Library:SetWatermark(("Killer: %s (%s m) | %s Speed | %s FPS | %s MS"):format(
	Killer or "N/A",
	math.floor(ClosestDistance or 0),
	math.floor(SpeedUp or 0),
    math.floor(FPS),
    math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
))
for i, v in pairs(_G.GetOldBright.New) do
	if _G.FullBright then
		Lighting[i] = v
	end
end
if _G.VoidRushControl and char and char:GetAttribute("VoidRushState") == "Dashing" then
	hum.WalkSpeed = 60
	hum.AutoRotate = false
	
	local horizontal = Vector3.new(root.CFrame.LookVector.X, 0, root.CFrame.LookVector.Z)
	if horizontal.Magnitude > 0 then
	    hum:Move(horizontal.Unit)
	end
end
if _G.AutoBlock or _G.Punch then
	local Punch = maingui and maingui:FindFirstChild("AbilityContainer") and maingui.AbilityContainer:FindFirstChild("Punch")
    local charges = Punch and Punch:FindFirstChild("Charges")
    local Block = maingui and maingui:FindFirstChild("AbilityContainer") and maingui.AbilityContainer:FindFirstChild("Block")
    local cooldown = Block and Block:FindFirstChild("CooldownTime")
    
	for _, v in ipairs(playerout:GetPlayers()) do
	    if v ~= player and v.Character then
	        local hrp = v.Character:FindFirstChild("HumanoidRootPart")
	        local humplr = v.Character:FindFirstChildOfClass("Humanoid")
	        local animTracks = humplr and humplr:FindFirstChildOfClass("Animator") and humplr:FindFirstChildOfClass("Animator"):GetPlayingAnimationTracks()
	        if hrp and Distance2(hrp.Position) <= (_G.DetectionRange or 18) then
	            for _, track in ipairs(animTracks or {}) do
	                if table.find(Animations["KillerAnima"], tostring(track.Animation.AnimationId):match("%d+")) then
                        if _G.AutoBlock and Distance2(hrp.Position) <= (_G.DetectionRange or 18) then
                            if isFacing(hrp) then
	                            if cooldown and cooldown.Text == "" then
                                    Remote:FireServer("UseActorAbility", {buffer.fromstring("\"Block\"")})
                                end
                                if _G.Punch and charges and charges.Text == "1" then
                                    Remote:FireServer("UseActorAbility", {buffer.fromstring("\"Punch\"")})
                                end
                            end
                        end
                    end
	            end
	        end
	    end
	end
end
if _G.Aimbot or _G.AimbotPunch then
	local playing = PlayingAnimationId()
    local triggered = false
    for v in pairs(Animations["Shot - Punch"]) do
        if playing[v] then
            triggered = true
            break
        end
    end
    if triggered then
        Time = tick()
        aiming = true
    end
    if aiming and tick() - Time <= 1.7 then
        if not WS then
            WS = hum.WalkSpeed
            JP = hum.JumpPower
            AutoRotate = hum.AutoRotate
        end
        hum.AutoRotate = false
        root.AssemblyAngularVelocity = Vector3.zero
        local targetHRP = KillerTarget()
        local prediction = _G.Prediction or 1
        if targetHRP then
            local predictedPos = targetHRP.Position + (targetHRP.CFrame.LookVector * prediction)
            local direction = (predictedPos - root.Position).Unit
            local yRot = math.atan2(-direction.X, -direction.Z)
            root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, yRot, 0)
        end
    elseif aiming then
        aiming = false
        if WS and JP and AutoRotate then
            hum.WalkSpeed = WS
            hum.JumpPower = JP
            hum.AutoRotate = AutoRotate
            WS, JP, AutoRotate = nil, nil, nil
        end
    end
end
end)

local Window = Library:CreateWindow({
    Title = "Forsake",
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
	Tab2 = Window:AddTab("Auto", "rbxassetid://7734056608"),
	["UI Settings"] = Window:AddTab("UI Settings", "rbxassetid://7733955511")
}

local Main1Group = Tabs.Tab:AddLeftGroupbox("Main")

Main1Group:AddToggle("AutoGeneral", {
    Text = "Auto Generator",
    Default = false, 
    Callback = function(Value) 
_G.AutoGeneral = Value
while _G.AutoGeneral do
if workspace.Map.Ingame:FindFirstChild("Map") then
for i, v in ipairs(workspace.Map.Ingame:FindFirstChild("Map"):GetChildren()) do
if v.Name == "Generator" and v:FindFirstChild("Remotes") and v.Remotes:FindFirstChild("RE") and v:FindFirstChild("Progress").Value ~= 100 then
v.Remotes:FindFirstChild("RE"):FireServer()
end
end
end
task.wait(2)
end
    end
})

Main1Group:AddButton("Teleport To Generator", function()
if workspace.Map.Ingame:FindFirstChild("Map") then
	for i, v in ipairs(workspace.Map.Ingame:FindFirstChild("Map"):GetChildren()) do
		if v.Name == "Generator" and v:FindFirstChild("Positions") and v.Positions:FindFirstChild("Center") and v:FindFirstChild("Progress").Value ~= 100 then
			root.CFrame = v.Positions:FindFirstChild("Center").CFrame
			break
		end
	end
end
end)

Main1Group:AddToggle("Inf Stamina", {
    Text = "Inf Stamina",
    Default = false, 
    Callback = function(Value) 
_G.InfStamina = Value
while _G.InfStamina do
local staminaModule = require(game.ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Character"):WaitForChild("Game"):WaitForChild("Sprinting"))
if staminaModule then
    staminaModule.MaxStamina = 999999
    staminaModule.Stamina = 999999
    staminaModule.__staminaChangedEvent:Fire(staminaModule.Stamina)
end
task.wait()
end
    end
})

Main1Group:AddSlider("Speed", {
    Text = "WalkSpeed",
    Default = 20,
    Min = 7,
    Max = 50,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
_G.SpeedWalk = Value
    end
})

Main1Group:AddToggle("SetSpeed", {
    Text = "Set Speed",
    Default = false, 
    Callback = function(Value) 
_G.NahSpeed = Value
while _G.NahSpeed do
if hum then
hum:SetAttribute("BaseSpeed", _G.SpeedWalk)
end
task.wait()
end
    end
})

local Main3Group = Tabs.Tab:AddLeftGroupbox("Misc")

Main3Group:AddSlider("Health", {
    Text = "Health",
    Default = 20,
    Min = 7,
    Max = 50,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
_G.HealthPizza = Value
    end
})

Main3Group:AddToggle("Auto Eat Pizza", {
    Text = "Auto Eat Pizza",
    Default = false, 
    Callback = function(Value) 
_G.AutoEatPizza = Value
while _G.AutoEatPizza do
if hum and hum.Health <= _G.HealthPizza then
	local OldCFrame = root.CFrame
	local pizza = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame") and workspace.Map.Ingame:FindFirstChild("Pizza")
	if pizza and pizza:IsA("BasePart") then
		root.CFrame = pizza.CFrame
		task.wait(0.5)
		root.CFrame = OldCFrame
		wait(0.3)
	end
end
task.wait()
end
    end
})

Main3Group:AddToggle("VoidRushBypass", {
    Text = "Void Rush Bypass",
    Default = false, 
    Callback = function(Value) 
getgenv()._VoidRushBypass = Value
    end
})

Main3Group:AddToggle("VoidRushControl", {
    Text = "Void Rush Control",
    Default = false, 
    Callback = function(Value) 
_G.VoidRushControl = Value
if Value == false then
	if hum then
        hum.WalkSpeed = 16 
        hum.AutoRotate = true
        hum:Move(Vector3.new(0, 0, 0))
    end
end
    end
})

local Main2Group = Tabs.Tab:AddRightGroupbox("Esp")

Main2Group:AddToggle("Generator", {
    Text = "Esp Generator",
    Default = false, 
    Callback = function(Value) 
_G.EspGeneral = Value
if _G.EspGeneral == false then
	if workspace.Map.Ingame:FindFirstChild("Map") then
		for i, v in pairs(workspace.Map.Ingame:FindFirstChild("Map"):GetChildren()) do
			if v.Name == "Generator" then
				ESPLibrary:RemoveESP(v)
			end
		end
	end
end
while _G.EspGeneral do
if workspace.Map.Ingame:FindFirstChild("Map") then
	for i, v in pairs(workspace.Map.Ingame:FindFirstChild("Map"):GetChildren()) do
		if v.Name == "Generator" and v:FindFirstChild("Progress") then
			if v.Progress.Value == 100 then
				GeneratorColor = Color3.fromRGB(0, 255, 0)
			else
				GeneratorColor = _G.ColorEspGen or Color3.fromRGB(9, 123, 237)
			end
			local TextGen = "Generator ("..v.Progress.Value..")"
			ESPLibrary:AddESP({
				Object = v,
				Text = TextGen,
				Color = GeneratorColor
			})
			ESPLibrary:UpdateObjectText(v, TextGen)
			ESPLibrary:UpdateObjectColor(v, GeneratorColor)
			ESPLibrary:SetOutlineColor(GeneratorColor)
		end
	end
end
task.wait()
end
    end
}):AddColorPicker("Color Esp Gen", {
     Default = Color3.fromRGB(9, 123, 237),
     Callback = function(Value)
_G.ColorEspGen = Value
     end
})

Main2Group:AddToggle("Killer", {
    Text = "Esp Killer",
    Default = false, 
    Callback = function(Value) 
_G.EspKiller = Value
if _G.EspKiller == false then
	for i, v in pairs(game.Workspace.Players:GetChildren()) do
		if v.Name == "Killers" then
			for y, z in pairs(v:GetChildren()) do
				ESPLibrary:RemoveESP(z)
			end
		end
	end
end
while _G.EspKiller do
for i, v in pairs(game.Workspace.Players:GetChildren()) do
	if v.Name == "Killers" then
		for y, z in pairs(v:GetChildren()) do
			if z:GetAttribute("Username") ~= player.Name then
				local KillerColor = _G.ColorLightKill or Color3.new(255, 0, 0)
				local TextKiller = z.Name
				ESPLibrary:AddESP({
					Object = z,
					Text = TextKiller,
					Color = KillerColor
				})
				ESPLibrary:UpdateObjectText(z, TextKiller)
				ESPLibrary:UpdateObjectColor(z, KillerColor)
				ESPLibrary:SetOutlineColor(KillerColor)
			end
		end
	end
end
task.wait()
end
    end
}):AddColorPicker("Color Esp1", {
     Default = Color3.new(255, 0, 0),
     Callback = function(Value)
_G.ColorLightKill = Value
     end
})

Main2Group:AddToggle("Survivors", {
    Text = "Esp Survivors",
    Default = false, 
    Callback = function(Value) 
_G.EspSurvivors = Value
if _G.EspSurvivors == false then
	for i, v in pairs(game.Workspace.Players:GetChildren()) do
		if v.Name == "Survivors" then
			for y, z in pairs(v:GetChildren()) do
				ESPLibrary:RemoveESP(z)
			end
		end
	end
end
while _G.EspSurvivors do
for i, v in pairs(game.Workspace.Players:GetChildren()) do
	if v.Name == "Survivors" then
		for y, z in pairs(v:GetChildren()) do
			if z:GetAttribute("Username") ~= player.Name then
				local SurvivorsColor = _G.ColorLightSurvivors or Color3.new(0, 255, 0)
				local TextSurvivors = z.Name
				ESPLibrary:AddESP({
					Object = z,
					Text = TextSurvivors,
					Color = SurvivorsColor
				})
				ESPLibrary:UpdateObjectText(z, TextSurvivors)
				ESPLibrary:UpdateObjectColor(z, SurvivorsColor)
				ESPLibrary:SetOutlineColor(SurvivorsColor)
			end
		end
	end
end
task.wait()
end
    end
}):AddColorPicker("Color Esp2", {
     Default = Color3.new(0, 255, 0),
     Callback = function(Value)
_G.ColorLightSurvivors = Value
     end
})

Main2Group:AddToggle("Item", {
    Text = "Esp Item",
    Default = false, 
    Callback = function(Value) 
_G.EspItem = Value
if _G.EspItem == false then
	if workspace.Map.Ingame:FindFirstChild("Map") then
		for i, v in ipairs(workspace.Map.Ingame:FindFirstChild("Map"):GetChildren()) do
			if v:IsA("Tool") then
				ESPLibrary:RemoveESP(v)
			end
		end
	end
	if workspace.Map:FindFirstChild("Ingame") then
		for i, v in ipairs(workspace.Map.Ingame:GetChildren()) do
			if v:IsA("Tool") then
				ESPLibrary:RemoveESP(v)
			end
		end
	end
else
	function EspItem(v)
		if v:IsA("Tool") then
			local ItemColor = _G.ColorItem or Color3.new(0, 255, 0)
			local TextItem = v.Name
			ESPLibrary:AddESP({
				Object = v,
				Text = TextItem,
				Color = ItemColor
			})
			ESPLibrary:UpdateObjectText(v, TextItem)
			ESPLibrary:UpdateObjectColor(v, ItemColor)
			ESPLibrary:SetOutlineColor(ItemColor)
		end
	end
end
while _G.EspItem do
if workspace.Map.Ingame:FindFirstChild("Map") then
	for i, v in ipairs(workspace.Map.Ingame:FindFirstChild("Map"):GetChildren()) do
		EspItem(v)
	end
end
if workspace.Map:FindFirstChild("Ingame") then
	for i, v in ipairs(workspace.Map.Ingame:GetChildren()) do
		EspItem(v)
	end
end
task.wait()
end
    end
}):AddColorPicker("Color Esp2 Item", {
     Default = Color3.new(0, 255, 0),
     Callback = function(Value)
_G.ColorItem = Value
     end
})

local Esp1 = Tabs.Tab:AddRightGroupbox("Settings Esp")

local Font = {}
for _, v in ipairs(Enum.Font:GetEnumItems()) do
    table.insert(Font, v.Name)
end
Esp1:AddDropdown("Font", {
    Text = "Set Font",
    Values = Font,
    Default = "Code",
    Multi = false,
    Callback = function(Value)
if ESPLibrary then
	ESPLibrary:SetFont(Value)
end
    end
})

Esp1:AddToggle("Show Distance", {
    Text = "Show Distance",
    Default = false,
    Callback = function(Value)
if ESPLibrary then
	ESPLibrary:SetShowDistance(Value)
end
    end
})

Esp1:AddToggle("Show Rainbow", {
    Text = "Show Rainbow",
    Default = false,
    Callback = function(Value)
if ESPLibrary then
	ESPLibrary:SetRainbow(Value)
end
    end
})

Esp1:AddToggle("Show Tracers", {
    Text = "Show Tracers",
    Default = false,
    Callback = function(Value)
if ESPLibrary then
	ESPLibrary:SetTracers(Value)
end
    end
})

Esp1:AddDropdown("TracersOrigin", {
    Text = "Tracers Origin",
    Multi = false,
    Values = {"Bottom", "Top", "Center", "Mouse"},
    Callback = function(Value)
if ESPLibrary then
	ESPLibrary:SetTracerOrigin(Value)
end
    end
})

Esp1:AddToggle("Show Arrows", {
    Text = "Show Arrows",
    Default = false,
    Callback = function(Value)
if ESPLibrary then
	ESPLibrary:SetArrows(Value)
end
    end
})

Esp1:AddSlider("ArrowsSize", {
    Text = "Set Arrows Radius",
    Default = 300,
    Min = 0,
    Max = 500,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
if ESPLibrary then
	ESPLibrary:SetArrowRadius(Value)
end
    end
})

Esp1:AddSlider("SetTextSize", {
    Text = "Set TextSize",
    Default = 15,
    Min = 1,
    Max = 50,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
if ESPLibrary then
	ESPLibrary:SetTextSize(Value)
end
    end
})

Esp1:AddSlider("SetFillTransparency", {
    Text = "Set Fill Transparency",
    Default = 0.6,
    Min = 0,
    Max = 1,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
if ESPLibrary then
	ESPLibrary:SetFillTransparency(Value)
end
    end
})

Esp1:AddSlider("SetOutlineTransparency", {
    Text = "Set OutLine Transparency",
    Default = 0.6,
    Min = 0,
    Max = 1,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
if ESPLibrary then
	ESPLibrary:SetOutlineTransparency(Value)
end
    end
})

local Anti1Group = Tabs.Tab2:AddLeftGroupbox("Auto Block")

Anti1Group:AddToggle("Auto Block", {
    Text = "Auto Block",
    Default = false, 
    Callback = function(Value) 
_G.AutoBlock = Value
    end
})

Anti1Group:AddToggle("Auto Punch", {
    Text = "Auto Punch",
    Default = false, 
    Callback = function(Value) 
_G.Punch = Value
    end
})

Anti1Group:AddToggle("Aimbot Punch", {
    Text = "Aimbot Punch",
    Default = false, 
    Callback = function(Value) 
_G.AimbotPunch = Value
    end
})

Anti1Group:AddSlider("PunchFlingPower", {
    Text = "Punch Fling Power",
    Default = 10000,
    Min = 1000,
    Max = 1000000,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
_G.PunchFlingPower = Value
    end
})

Anti1Group:AddSlider("Detection Range", {
    Text = "Detection Range (Animation)",
    Default = detectionRange,
    Min = 1,
    Max = 50,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
_G.DetectionRange = Value
    end
})

local Anti2Group = Tabs.Tab2:AddRightGroupbox("Auto Stun")

Anti2Group:AddToggle("Aimbot", {
    Text = "Chance Aimbot Shot",
    Default = false, 
    Callback = function(Value) 
_G.Aimbot = Value
    end
})

Anti2Group:AddSlider("Sharpness", {
    Text = "Sharpness",
    Default = 4,
    Min = 1,
    Max = 10,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
_G.Prediction = Value
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