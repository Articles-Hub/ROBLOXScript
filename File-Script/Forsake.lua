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

local cam = workspace.CurrentCamera
local player = playerout.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")
local playergui = player:WaitForChild("PlayerGui")
local maingui = playergui:WaitForChild("MainUI")

spawn(function()
	while task.wait() do
		char = player.Character or player.CharacterAdded:Wait()
		root = char:FindFirstChild("HumanoidRootPart") or nil
		hum = char:FindFirstChild("Humanoid") or nil
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

function CheckWall(Target, Target1)
    local Direction = (Target.Position - game.Workspace.CurrentCamera.CFrame.Position).unit * (Target.Position - game.Workspace.CurrentCamera.CFrame.Position).Magnitude
    local RaycastParams = RaycastParams.new()
    RaycastParams.FilterDescendantsInstances = {game.Players.LocalPlayer.Character, game.Workspace.CurrentCamera}
    RaycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    local Result = game.Workspace:Raycast(game.Workspace.CurrentCamera.CFrame.Position, Direction, RaycastParams)
    return Result == nil or Result.Instance:IsDescendantOf(Target1)
end

getgenv()._VoidRushBypass = false
if not getgenv()._oldFireServer and hookmetamethod and getnamecallmethod then
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
	    "126830014841198", "126355327951215", "121086746534252", "18885909645", "87989533095285",
	    "98456918873918", "105458270463374", "83829782357897", "125403313786645", "79980897195554",
	    "118298475669935", "82113744478546", "70371667919898", "99135633258223", "119583605486352",
	    "97167027849946", "109230267448394", "139835501033932", "126896426760253", "119583605486352",
	    "109667959938617", "126681776859538", "129976080405072", "121293883585738", "90819435118493",
	    "81639435858902", "137314737492715", "92173139187970", "122709416391891", "71834552297085",
		"110877859670130", "118681146051975", "106538427162796", "105458270463374", "127172483138092",
		"83829782357897"
	},
	["Aimbot Killer"] = {
		["121808371053483"] = true,
		["119181003138006"] = true,
		["131430497821198"] = true,
	},
	["Aimbot Push"] = {
		"87259391926321",
		"140703210927645",
		"136007065400978",
		"136007065400978",
		"129843313690921",
		"129843313690921",
		"86709774283672",
		"87259391926321",
		"129843313690921",
		"129843313690921",
		"108807732150251",
		"138040001965654",
		"86096387000557",
		"86096387000557"
	},
	["Auto Change"] = {
		["103601716322988"] = true,
	    ["133491532453922"] = true,
	    ["86371356500204"] = true,
	    ["76649505662612"] = true,
	    ["81698196845041"] = true,
		["87259391926321"] = true,
		["140703210927645"] = true,
		["136007065400978"] = true,
		["136007065400978"] = true,
		["129843313690921"] = true,
		["129843313690921"] = true,
		["86709774283672"] = true,
		["87259391926321"] = true,
		["129843313690921"] = true,
		["129843313690921"] = true,
		["108807732150251"] = true,
		["138040001965654"] = true,
		["86096387000557"] = true,
		["86096387000557"] = true
	}
}

local function isFacing(target)
    return target.CFrame.LookVector:Dot((root.Position - target.Position).Unit) > -0.3
end

function Aimbot(target, prediction)
	local direction = ((target.Position + (target.CFrame.LookVector * prediction)) - root.Position).Unit
	root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, math.atan2(-direction.X, -direction.Z), 0)
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

function SurviveTarget(ValueDis)
    local SurvivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
    if SurvivorsFolder then
        for _, v in ipairs(SurvivorsFolder:GetChildren()) do
            if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and Distance(v.HumanoidRootPart.Position) <= ValueDis then
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

function Triggered(animation)
	local playing = PlayingAnimationId()
	for v in pairs(animation) do
        if playing[v] then
            return true
        end
    end
    return false
end

_G.Connect = {}

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
if _G.VoidRushControl then
	local VoidRush = char and char:GetAttribute("VoidRushState")
	if VoidRush and VoidRush == "Dashing" then
		hum.WalkSpeed = 60
		hum.AutoRotate = false
		
		local Look = root.CFrame.LookVector
		local Horizontal = Vector3.new(Look.X, 0, Look.Z)
		if Horizontal.Magnitude > 0 then
		    hum:Move(Horizontal.Unit)
		end
	else
		if hum then
			hum.AutoRotate = true
		end
	end
end
if Toggles["Change Aimbot"] and Toggles["Change Aimbot"].Value then
	local playing = PlayingAnimationId()
    local Triggered = false
    Triggered = Triggered(Animations["Auto Change"])
    if Triggered then
        Time = tick()
        AimbotStart = true
    end
    if AimbotStart and tick() - Time <= 1.7 then
        if not AutoRotate then
            AutoRotate = hum.AutoRotate
        end
        hum.AutoRotate = false
        root.AssemblyAngularVelocity = Vector3.zero
        local targetKill = KillerTarget()
        if targetKill then
	        Sharpness = (Options["Sharpness"].Value or 1)
            Aimbot(targetKill, Sharpness)
        end
    elseif AimbotStart then
        AimbotStart = false
        if AutoRotate then
            hum.AutoRotate = AutoRotate
            AutoRotate = nil
        end
    end
end
end)

table.insert(_G.Connect, RunService.RenderStepped:Connect(function()
if Toggles["Infernal Cry Aimbot"] and Toggles["Infernal Cry Aimbot"].Value then
	local playing = PlayingAnimationId()
    local TriggeredKiller = false
    TriggeredKiller = Triggered(Animations["Aimbot Killer"])
    if TriggeredKiller then
        Time = tick()
        AimbotStartKiller = true
    end
    if AimbotStartKiller and tick() - Time <= 1.7 then
        if not AutoRotate then
            AutoRotate = hum.AutoRotate
        end
        hum.AutoRotate = false
        root.AssemblyAngularVelocity = Vector3.zero
        local Distan = (Options["Distance Aimbot"].Value or 50)
        local targetSur = SurviveTarget(Distan)
        if targetSur then
	        local Sharpness = (Options["Sharpness Killer"].Value or 1)
            local direction = ((targetSur.Position + (targetSur.CFrame.LookVector * Sharpness)) - root.Position).Unit
			cam.CFrame = CFrame.new(cam.CFrame.Position) * CFrame.Angles(0, math.atan2(-direction.X, -direction.Z), 0)
        end
    elseif AimbotStartKiller then
        AimbotStartKiller = false
        if AutoRotate then
            hum.AutoRotate = AutoRotate
            AutoRotate = nil
        end
    end
end
end))

local LastPathTime = 0
local Nopath = false
table.insert(_G.Connect, RunService.RenderStepped:Connect(function()
	if Toggles["Auto Move"] and Toggles["Auto Move"].Value then
		if tick() - LastPathTime < 1 and not Nopath then return end
		local Destination, ClosestDist = nil, math.huge
		local survivors = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild(Options.Move.Value)
		if not survivors then return end		
		for _, v in ipairs(survivors:GetChildren()) do
			if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:GetAttribute("Username") ~= player.Name then
				local dist = (root.Position - v.HumanoidRootPart.Position).Magnitude
				if dist < ClosestDist then
					Destination = v.HumanoidRootPart
					ClosestDist = dist
				end
			end
		end
		if Distance(Destination.Position) <= 20 then
			Nopath = true
		else
			Nopath = false
		end
		if Nopath and Destination and hum then
			hum:MoveTo(Destination.Position + Vector3.new(0, 0, 4))
		end
		if Destination and hum and root and not Nopath then
			LastPathTime = tick()
			CurrentTarget = Destination
			local ok, err = pcall(function()
				local path = PFS:CreatePath({
					AgentRadius = 2,
					WaypointSpacing = 12,
					AgentHeight = 5,
					AgentCanJump = false,
					AgentJumpHeight = 10,
					AgentCanClimb = false,
					AgentMaxSlope = 45
				})
				path:ComputeAsync(root.Position + Vector3.new(0, 5, 0), Destination.Position)
				if path and path.Status == Enum.PathStatus.Success then
					local Waypoints = path:GetWaypoints()
					local pathFolder = workspace:FindFirstChild("PathFindPartsFolder")
					if not pathFolder then
						pathFolder = Instance.new("Folder")
						pathFolder.Name = "PathFindPartsFolder"
						pathFolder.Parent = workspace
					end
					pathFolder:ClearAllChildren()
					for _, Waypoint in pairs(Waypoints) do
						local part = Instance.new("Part")
						part.Size = Vector3.new(0.5, 0.5, 0.5)
						part.Position = Waypoint.Position
						part.Shape = Enum.PartType.Ball
						part.Material = Enum.Material.SmoothPlastic
						part.Anchored = true
						part.CanCollide = false
						part.Parent = pathFolder
					end
					for i, Waypoint in pairs(Waypoints) do
						if i == 1 then continue end
						if not (hum and root) then break end
						hum:MoveTo(Waypoint.Position)
						local reached = false
						local conn
						conn = hum.MoveToFinished:Connect(function(s)
							reached = s
							if conn then conn:Disconnect() end
						end)
						local start = tick()
						repeat task.wait() until reached or tick() - start > 3
						if not reached then
							break
						end
					end
				end
			end)
			if not ok then warn("Path error:", err) end
		end
	end
end))

table.insert(_G.Connect, RunService.RenderStepped:Connect(function()
if Toggles["Aimbot Punch"] and Toggles["Aimbot Punch"].Value then
	if hum then
		if AutoRotate then
	        hum.AutoRotate = AutoRotate
	        AutoRotate = nil
	    end
		local AnimationTrack = hum:FindFirstChildOfClass("Animator")
		if AnimationTrack then
		    for _, v in ipairs(AnimationTrack:GetPlayingAnimationTracks()) do
		        if table.find(Animations["Aimbot Push"], tostring(v.Animation.AnimationId):match("%d+")) then
					if not AutoRotate then
			            AutoRotate = hum.AutoRotate
			        end
			        hum.AutoRotate = false
			        root.AssemblyAngularVelocity = Vector3.zero
			        local targetKill = KillerTarget()
			        if targetKill then
			            Aimbot(targetKill, 0.1)
			        end
				end
		    end
		end
	end
end
end))

table.insert(_G.Connect, RunService.RenderStepped:Connect(function()
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
end))

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
	["UI Settings"] = Window:AddTab("UI Settings", "rbxassetid://7733955511")
}

local Main1Group = Tabs.Tab:AddLeftGroupbox("Main")

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
}):AddKeyPicker("SetSpeed", {
   Default = "R",
   Text = "Set Speed",
   Mode = "Toggle",
   SyncToggleState = true
})

Main1Group:AddToggle("Inf Stamina", {
    Text = "Inf Stamina",
    Default = false, 
    Callback = function(Value) 
_G.InfStamina = Value
while _G.InfStamina do
local staminaModule = require(Storage:WaitForChild("Systems"):WaitForChild("Character"):WaitForChild("Game"):WaitForChild("Sprinting"))
if staminaModule then
    staminaModule.Stamina = staminaModule.MaxStamina
    staminaModule.__staminaChangedEvent:Fire(staminaModule.Stamina)
end
task.wait()
end
    end
})

AntiSlowConfigs = {"SlowedStatus", "StunningKiller", "EatFriedChicken", "GuestBlocking", "PunchAbility", "SubspaceTripmine", "TaphTripwire", "PlasmaBeam", "SpawnProtection", "c00lgui", "ShootingGun",  "TwoTimeStab", "TwoTimeCrouching", "DrinkingCola", "DrinkingSlateskin", "SlateskinStatus", "EatingGhostburger", "BloxyColaItem", "Medkit", "Emoting", "DispenserConstruction", "SentryConstruction"}
Main1Group:AddToggle("Anti Slow", {
    Text = "Anti Slow",
    Default = false, 
    Callback = function(Value) 
_G.AntiSlow = Value
while _G.AntiSlow do
local Status = maingui and maingui:FindFirstChild("StatusContainer")
local Slow = Status and Status:FindFirstChild("Slowness")
if Slow then
    Slow.Visible = false
end
if char:FindFirstChild("SpeedMultipliers") then
	for c, n in pairs(AntiSlowConfigs) do
		local SlowNumber = char.SpeedMultipliers:FindFirstChild(n)
        if SlowNumber and SlowNumber:IsA("NumberValue") and SlowNumber.Value < 1 then
            SlowNumber.Value = 1.1
        end
	end
end
task.wait()
end
    end
})

Main1Group:AddDivider()
Main1Group:AddToggle("Full Bright", {
    Text = "Full Bright",
    Default = false, 
    Callback = function(Value) 
_G.FullBright = Value
if _G.FullBright then
for i, v in pairs(_G.GetOldBright.New) do
Lighting[i] = v
end
else
for i, v in pairs(_G.GetOldBright.Old) do
Lighting[i] = v
end
end
    end
})

Main1Group:AddToggle("No Fog", {
    Text = "No Fog",
    Default = false, 
    Callback = function(Value) 
_G.Nofog = Value
while _G.Nofog do
for i, v in pairs(Lighting:GetChildren()) do
	if v:IsA("Atmosphere") or v:IsA("BloomEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("DepthOfFieldEffect") then
		v:Destroy()
	end
end
task.wait()
end
    end
})

Main1Group:AddDivider()
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
task.wait(3.3)
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

Main1Group:AddDropdown("Move", {
    Text = "Auto Move",
    Values = {"Killers", "Survivors"},
    Default = ""
})

Main1Group:AddToggle("Auto Move", {
    Text = "Start Move",
    Default = false
})

function getItem(itemName)
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name == "ItemRoot" and v.Parent and v.Parent.Name == itemName then
            return v
        end
    end
end
Main1Group:AddButton("Teleport To Medkit", function()
local Medkit = getItem("Medkit")
if Medkit then
	root.CFrame = Medkit.CFrame * CFrame.new(0, 3, 0)
end
end)

Main1Group:AddButton("Teleport To BloxyCola", function()
local BloxyCola = getItem("BloxyCola")
if BloxyCola then
	root.CFrame = BloxyCola.CFrame * CFrame.new(0, 3, 0)
end
end)

Main1Group:AddSlider("Health", {
    Text = "Health",
    Default = 20,
    Min = 7,
    Max = 99,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
_G.HealthPizza = Value
    end
})

Main1Group:AddToggle("Auto Eat Pizza", {
    Text = "Auto Eat Pizza",
    Default = false, 
    Callback = function(Value) 
_G.AutoEatPizza = Value
while _G.AutoEatPizza do
if hum and hum.Health <= (_G.HealthPizza or 60) then
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

Main1Group:AddDivider()
Main1Group:AddToggle("Anti Spike John Doe", {
    Text = "Noclip Spike (John Doe)",
    Default = false, 
    Callback = function(Value) 
_G.AntiSpike = Value
while _G.AntiSpike do
for i, v in pairs(workspace.Map.Ingame:GetChildren()) do
	if v.Name == "Spike" then
		for _, j in pairs(v:GetChildren()) do
			if j:IsA("BasePart") then
				j.CanCollide = false
				j.CanTouch = false
			end
		end
	end
end
task.wait()
end
    end
})

Main1Group:AddToggle("Anti Shadow John Doe", {
    Text = "Anti Shadow (John Doe)",
    Default = false, 
    Callback = function(Value) 
_G.AntiShadow = Value
while _G.AntiShadow do
for i, v in pairs(workspace.Map.Ingame:GetChildren()) do
	if v:IsA("Folder") and v.Name:find("Shadows") then
		for _, j in pairs(v:GetChildren()) do
			if j:IsA("BasePart") then
				j.CanTouch = false
			end
		end
	end
end
task.wait()
end
    end
})

Main1Group:AddToggle("Anti John Doe Trail", {
    Text = "Anti John Doe Trail",
    Default = false, 
    Callback = function(Value) 
_G.AntiJohnDoeTrail = Value
while _G.AntiJohnDoeTrail do
for i, v in pairs(game.Workspace.Players:GetChildren()) do
	if v.Name == "Killers" then
		for y, z in pairs(v:GetChildren()) do
			if z:FindFirstChild("JohnDoeTrail") then
				for _, j in pairs(z.JohnDoeTrail:GetChildren()) do
					if j:IsA("BasePart") then
						j.CanTouch = false
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

TabBoxSurvive = Tabs.Tab:AddLeftTabbox()
local Main6Group = TabBoxSurvive:AddTab("Survive")

Main6Group:AddLabel("Eliot", true)
Main6Group:AddDivider()

Main6Group:AddSlider("Health", {
    Text = "Health",
    Default = 20,
    Min = 7,
    Max = 99,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
_G.HealthPizzaPlayer = Value
    end
})

Main6Group:AddToggle("Auto Throw Pizza", {
    Text = "Auto Throw Pizza",
    Default = false, 
    Callback = function(Value) 
_G.AutoThrowPizza = Value
while _G.AutoThrowPizza do
local ThrowPizza = maingui and maingui:FindFirstChild("AbilityContainer") and maingui.AbilityContainer:FindFirstChild("ThrowPizza")
local cooldown = ThrowPizza and ThrowPizza:FindFirstChild("CooldownTime")
local ThrowSuccess = false

for i, v in pairs(game.Workspace.Players:GetChildren()) do
	if v.Name == "Survivors" then
		for y, z in pairs(v:GetChildren()) do
			if z:GetAttribute("Username") ~= player.Name and z:FindFirstChildOfClass("Humanoid") and z:FindFirstChildOfClass("Humanoid").Health < z:FindFirstChildOfClass("Humanoid").MaxHealth and z:FindFirstChildOfClass("Humanoid").Health < (_G.HealthPizzaPlayer or 50) then
				if cooldown and cooldown.Text == "" then
					local OldCFrame = root and root.CFrame
					if OldCFrame then
						if z:FindFirstChild("HumanoidRootPart") then
							task.spawn(function()
								repeat task.wait()
									root.CFrame = z.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
								until ThrowSuccess
							end)
							wait(0.2)
							repeat task.wait()
								Remote:FireServer("UseActorAbility", {buffer.fromstring("\"ThrowPizza\"")})
							until not cooldown or cooldown.Text ~= ""
							wait(1.2)
							ThrowSuccess = true
							wait(0.3)
							root.CFrame = OldCFrame
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

Main6Group:AddDivider()
Main6Group:AddLabel("Guest 1773", true)
Main6Group:AddDivider()

Main6Group:AddToggle("Auto Block", {
    Text = "Auto Block",
    Default = false, 
    Callback = function(Value) 
_G.AutoBlock = Value
    end
})

Main6Group:AddToggle("Auto Punch", {
    Text = "Auto Punch",
    Default = false, 
    Callback = function(Value) 
_G.Punch = Value
    end
})

Main6Group:AddToggle("Aimbot Punch", {
    Text = "Aimbot Punch",
    Default = false
})

Main6Group:AddSlider("Detection Range", {
    Text = "Detection Range (Animation)",
    Default = 15,
    Min = 1,
    Max = 50,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
_G.DetectionRange = Value
    end
})

Main6Group:AddDivider()
Main6Group:AddLabel("Change", true)
Main6Group:AddDivider()

Main6Group:AddToggle("Change Aimbot", {
    Text = "Chance Aimbot Shot",
    Default = false
})

Main6Group:AddSlider("Sharpness", {
    Text = "Sharpness",
    Default = 4,
    Min = 1,
    Max = 10,
    Rounding = 1,
    Compact = false
})

local Main7Group = TabBoxSurvive:AddTab("Killer")

Main7Group:AddLabel("Guest 666", true)
Main7Group:AddDivider()

Main7Group:AddSlider("Distance Aimbot", {
    Text = "Distance Aimbot",
    Default = 4,
    Min = 1,
    Max = 100,
    Rounding = 1,
    Compact = false
})

Main7Group:AddSlider("Sharpness Killer", {
    Text = "Sharpness",
    Default = 4,
    Min = 1,
    Max = 10,
    Rounding = 1,
    Compact = false
})

Main7Group:AddToggle("Infernal Cry Aimbot", {
    Text = "Infernal Cry Aimbot",
    Default = false
})

Main7Group:AddDivider()
Main7Group:AddLabel("Noli", true)
Main7Group:AddDivider()

if hookmetamethod then
Main7Group:AddToggle("VoidRushBypass", {
    Text = "Void Rush Bypass",
    Default = false, 
    Callback = function(Value) 
getgenv()._VoidRushBypass = Value
    end
})
end

Main7Group:AddToggle("VoidRushControl", {
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
			local TextGen = "Generator ("..v.Progress.Value.."%)"
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
				local TextKiller = z.Name.." ("..z:GetAttribute("Username")..")"
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

Main2Group:AddToggle("Killer", {
    Text = "Esp C00lkid Pizza",
    Default = false, 
    Callback = function(Value) 
_G.EspKillerPizza = Value
if _G.EspKillerPizza == false then
	for i, v in pairs(workspace.Map.Ingame:GetChildren()) do
		if v.Name == "PizzaDeliveryRig" then
			ESPLibrary:RemoveESP(v)
		end
	end
end
while _G.EspKillerPizza do
for i, v in pairs(workspace.Map.Ingame:GetChildren()) do
	if v.Name == "PizzaDeliveryRig" then
		local KillerColor = _G.ColorLightKillPizza or Color3.new(255, 0, 0)
		local TextKiller = "C00LKID Pizza"
		ESPLibrary:AddESP({
			Object = v,
			Text = TextKiller,
			Color = KillerColor
		})
		ESPLibrary:UpdateObjectText(v, TextKiller)
		ESPLibrary:UpdateObjectColor(v, KillerColor)
		ESPLibrary:SetOutlineColor(KillerColor)
	end
end
task.wait()
end
    end
}):AddColorPicker("Color Esp4", {
     Default = Color3.new(255, 0, 0),
     Callback = function(Value)
_G.ColorLightKillPizza = Value
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
				local TextSurvivors = z.Name.." ("..z:GetAttribute("Username")..")"
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
				local PartItem = v:FindFirstChildWhichIsA("BasePart")
				if PartItem then
					ESPLibrary:RemoveESP(PartItem)
				end
			end
		end
	end
	if workspace.Map:FindFirstChild("Ingame") then
		for i, v in ipairs(workspace.Map.Ingame:GetChildren()) do
			if v:IsA("Tool") then
				local PartItem = v:FindFirstChildWhichIsA("BasePart")
				if PartItem then
					ESPLibrary:RemoveESP(PartItem)
				end
			end
		end
	end
else
	function EspItem(v)
		if v:IsA("Tool") then
			local PartItem = v:FindFirstChildWhichIsA("BasePart")
			if PartItem then
				local ItemColor = _G.ColorItem or Color3.new(0, 255, 0)
				local TextItem = v.Name
				ESPLibrary:AddESP({
					Object = PartItem,
					Text = TextItem,
					Color = ItemColor
				})
				ESPLibrary:UpdateObjectText(PartItem, TextItem)
				ESPLibrary:UpdateObjectColor(PartItem, ItemColor)
				ESPLibrary:SetOutlineColor(ItemColor)
			end
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

------------------------------------------------------------------------
local Credit = Window:AddTab("Credit / Join", "rbxassetid://7733955511")
local CreditTab = Credit:AddLeftGroupbox("Credit")
local CreditScript = {
	["Giang Hub"] = {
		Text = '[<font color="rgb(73, 230, 133)">Giang Hub</font>] Co-Owner Of Article Hub and Nihahaha Hub',
		Image = "rbxassetid://138779531145636"
	},
	["Nova Hoang"] = {
		Text = '[<font color="rgb(73, 230, 133)">Nova Hoang (Nguyễn Tn Hoàng)</font>] Owner Of Article Hub and Nihahaha Hub',
		Image = "rbxassetid://77933782593847",
	}
}

if CreditScript then
	for i, v in pairs(CreditScript) do
		CreditTab:AddLabel(CreditScript[i].Text, true)
		CreditTab:AddImage("Image "..i, {Image = CreditScript[i].Image, Height = 200})
	end
else
	CreditTab:AddLabel("[N/A]", true)
end

local CreditTab2 = Credit:AddRightGroupbox("Join Server")

local quest = request or http_request or (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request)
local HttpService = game:GetService("HttpService")
local InviteCode = "aD7gjtvPmv"
local DiscordAPI = "https://discord.com/api/v10/invites/" .. InviteCode .. "?with_counts=true&with_expiration=true"
local success, result = pcall(function()
    return HttpService:JSONDecode(quest({
        Url = DiscordAPI,
        Method = "GET",
        Headers = {
            ["User-Agent"] = "RobloxBot/1.0",
            ["Accept"] = "application/json"
        }
    }).Body)
end)

if success and result and result.guild then
	CreditTab2:AddLabel(result.guild.name, true)
	local InfoDiscord = CreditTab2:AddLabel('<font color="#52525b">•</font> Member Count : '..tostring(result.approximate_member_count)..'\n<font color="#16a34a">•</font> Online Count : ' .. tostring(result.approximate_presence_count), true)
	CreditTab2:AddImage("Image Discord", {Image = "rbxassetid://138779531145636", Height = 200})

	CreditTab2:AddButton("Update Info", function()
	    local updated, updatedResult = pcall(function()
            return HttpService:JSONDecode(quest({
                Url = DiscordAPI,
                Method = "GET",
            }).Body)
        end)            
        if updated and updatedResult and updatedResult.guild then
            InfoDiscord:SetText(
                '<font color="#52525b">•</font> Member Count : ' .. tostring(updatedResult.approximate_member_count) ..
                '\n<font color="#16a34a">•</font> Online Count : ' .. tostring(updatedResult.approximate_presence_count)
            )
        end
	end)

    CreditTab2:AddButton("Copy Discord Invite", function()
        setclipboard("https://discord.gg/"..InviteCode)
    end)
else
    CreditTab2:AddLabel("Error fetching Discord Info", true)
    CreditTab2:AddButton("Copy Discord Invite", function()
        setclipboard("https://discord.gg/"..InviteCode)
    end)
end

CreditTab2:AddButton("Copy Zalo", function()
    setclipboard("https://zalo.me/g/qlukiy407")
end)

local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("Menu")
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
MenuGroup:AddButton("Unload", function() Library:Unload(); ESPLibrary:Unload() end)

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