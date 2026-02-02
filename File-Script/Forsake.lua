for i, v in pairs({"xeno", "solara", "celery", "nezur", "luna"}) do
    if string.find(identifyexecutor():lower(), v) then
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Executor Waning", Text = "Unfortunately, " .. identifyexecutor() .. " won't be able to run many of the features in the script due to its power, goodluck", Duration = 60})
    end
end

local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local PFS = game:GetService("PathfindingService")
local Storage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local VIM = game:GetService("VirtualInputManager")
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
local AnimationTrack = hum:FindFirstChildOfClass("Animator") or nil
local playergui = player:WaitForChild("PlayerGui")
local maingui = playergui:WaitForChild("MainUI")

_G.Connect = {}
spawn(function()
	while true do
		char = player.Character or nil
		root = (char and char:FindFirstChild("HumanoidRootPart")) or nil
		hum = (char and char:FindFirstChild("Humanoid")) or nil
		AnimationTrack = (hum and hum:FindFirstChildOfClass("Animator")) or nil
		if require then
			if not staminaModule then
				local ok, err = pcall(function()
					if Storage:FindFirstChild("Systems") and Storage.Systems:FindFirstChild("Character") and Storage.Systems.Character:FindFirstChild("Game") and Storage.Systems.Character.Game:FindFirstChild("Sprinting") then
						staminaModule = require(Storage.Systems.Character.Game.Sprinting) or nil
					end
				end)
			end
		end
	task.wait()
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

_G.UpdateBasePart = {}
_G.UpdateParticle = {}
_G.UpdateDecal = {}
function RemoveLagTo(obj)
	if _G.AntiLag == true then
		local Terrain = workspace:FindFirstChildOfClass("Terrain")
		if Terrain then
			Terrain.WaterWaveSize = 0
			Terrain.WaterWaveSpeed = 0
			Terrain.WaterReflectance = 0
			Terrain.WaterTransparency = 1
		end
		local Lighting = game:GetService("Lighting")
		Lighting.GlobalShadows = false
		Lighting.FogEnd = 999999999
		Lighting.FogStart = 999999999
		if obj:IsA("ForceField") or obj:IsA("Sparkles") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Beam") then
			obj:Destroy()
		end
		if obj:IsA("PostEffect") then
			obj.Enabled = false
		end
		if obj:IsA("BasePart") then
			_G.UpdateBasePart[obj] = {
				Material = obj.Material,
				Reflectance = obj.Reflectance,
				BackSurface = obj.BackSurface,
				BottomSurface = obj.BottomSurface,
				FrontSurface = obj.FrontSurface,
				LeftSurface = obj.LeftSurface,
				RightSurface = obj.RightSurface,
				TopSurface = obj.TopSurface
			}
			obj.Material = Enum.Material.Plastic
			obj.Reflectance = 0
			obj.BackSurface = Enum.SurfaceType.SmoothNoOutlines
			obj.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
			obj.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
			obj.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
			obj.RightSurface = Enum.SurfaceType.SmoothNoOutlines
			obj.TopSurface = Enum.SurfaceType.SmoothNoOutlines
		elseif obj:IsA("Decal") then
			_G.UpdateDecal[obj] = obj.Transparency
			obj.Transparency = 1
		elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
			_G.UpdateParticle[obj] = obj.Lifetime
			obj.Lifetime = NumberRange.new(0)
		end
	else
		if obj:IsA("BasePart") and _G.UpdateBasePart[obj] then
			for prop, oldValue in pairs(_G.UpdateBasePart[obj]) do
				obj[prop] = oldValue
			end
			_G.UpdateBasePart[obj] = nil
		elseif obj:IsA("Decal") and _G.UpdateDecal[obj] then
			obj.Transparency = _G.UpdateDecal[obj]
			_G.UpdateDecal[obj] = nil
		elseif (obj:IsA("ParticleEmitter") or obj:IsA("Trail")) and _G.UpdateParticle[obj] then
			obj.Lifetime = _G.UpdateParticle[obj]
			_G.UpdateParticle[obj] = nil
		end
	end
end
game.DescendantAdded:Connect(function(v)
	RemoveLagTo(v)
end)

function charAb(s)
	return string.char(3, (#s), 0, 0, 0)..s
end

getgenv()._VoidRushBypass = false
getgenv()._WalkspeedOverrideBypass = false
getgenv()._AntiFootsteps = false

function HookCreated(remote, Name)
	if not getgenv()._oldFireServerTable[Name] and hookmetamethod and getnamecallmethod then
		local old
	    old = hookmetamethod(game, "__namecall", function(self, ...)
			local method = getnamecallmethod()
	        local args = {...}
	        if self == Remote and method == "FireServer" then
	            if args[1] == remote then
	                return
	            end
			end
			return old(self, ...)
	    end)
		getgenv()._oldFireServerTable[Name] = old
	end
end
function HookRemove(Name)
	if getgenv()._oldFireServerTable[Name] and hookmetamethod then
		hookmetamethod(game, "__namecall", getgenv()._oldFireServerTable[Name])
	end
end

if not getgenv()._oldFireServer and hookmetamethod and getnamecallmethod then
    local old
    old = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        if self == Remote and method == "FireServer" then
            if getgenv()._BlockSkateRebound and tostring(args[1]) == player.Name.."SkateRebound" then
	            return nil
	        end
	        if getgenv()._BlockSkateRebound and tostring(args[1]) == player.Name.."StopSkate" and typeof(args[2]) == "table" then
	            for i, v in ipairs(args[2]) do
	                if typeof(v) == "Instance" then
						Remote:FireServer(player.Name.."StopSkate", {buffer.fromstring(charAb("Manual"))})
	                    return nil
	                end
	            end
	        end
			if not getgenv()._AntiFootsteps or args[1] ~= "FootstepPlayed" or type(args[2]) ~= "number" then
                return old(self, unpack(args))
            else
                return nil
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
		"83829782357897", "89004992452376", "118250546180773", "131406927389838", "136406635725343",
		"89315669689903", "140659146085461", "99863365142863", "90620531468240", "108907358619313",
		"88582935528044", "94958041603347", "131642454238375", "110702884830060", "91509234639766",
		"94634594529334", "91758760621955", "77375846492436", "119462383658044", "110153465553223",
		"126171487400618", "18885909645", "18885919947", "70371667919898", "70447634862911",
		"71685573690338", "134020762419760", "85960461320564", "82113036350227", "88451353906104",
		"123345437821399", "123019923277556", "137679730950847", "81299297965542"
	},
	["Aimbot Killer"] = {
		["Sixer"] = {
			["Infernal Cry"] = {"121808371053483"},
			["Demonic Pursuit"] = {"139309647473555"}
		}
	},
	["Hitbox Reach"] = {
		"18885909645", "18885919947", "70371667919898", "70447634862911", "71685573690338",
		"73502073176819", "74707328554358", "76312020299624", "77124578197357", "77375846492436",
		"77448521277146", "77448521277146", "81639435858902", "82113744478546", "82113744478546",
		"82113744478546", "82183356141401", "83685305553364", "83829782357897", "84426150435898",
		"86096387000557", "86204001129974", "86545133269813", "86709774283672", "87259391926321",
		"87259391926321", "87989533095285", "89448354637442", "90499469533503", "90620531468240",
		"91509234639766", "91758760621955", "92173139187970", "92445608014276", "93069721274110",
		"94162446513587", "94634594529334", "94958041603347", "96173857867228", "97433060861952",
		"97623143664485", "97623143664485", "97648548303678", "98031287364865", "100358581940485",
		"100592913030351", "100592913030351", "100592913030351", "101101433684051", "101771617803133",
		"103741352379819", "105458270463374", "105458270463374", "106014898528300", "106014898528300",
		"106086955212611", "106538427162796", "106847695270773", "107640065977686", "108807732150251",
		"109230267448394", "109667959938617", "109667959938617", "110400453990786", "110702884830060",
		"111313169447787", "114620047310688", "116618003477002", "118298475669935", "118298475669935",
		"119326397274934", "119462383658044", "119462383658044", "120112897026015", "121086746534252",
		"121255898612475", "121293883585738", "121293883585738", "121293883585738", "121808371053483",
		"122503338277352", "122709416391891", "124243639579224", "125403313786645", "126171487400618",
		"126355327951215", "126654961540956", "126681776859538", "126681776859538", "126830014841198",
		"127172483138092", "128414736976503", "129843313690921", "129843313690921", "129843313690921",
		"129843313690921", "129976080405072", "129976080405072", "131430497821198", "131543461321709",
		"131642454238375", "131696603025265", "133336594357903", "133363345661032", "134958187822107",
		"136007065400978", "136007065400978", "136323728355613", "137314737492715", "138040001965654",
		"139309647473555", "139613699193400", "139835501033932", "140365014326125", "140703210927645",
		"110153465553223", "134020762419760", "85960461320564", "82113036350227", "88451353906104",
		"103995840833619", "72186169160926", "82113036350227", "88451353906104", "123345437821399", 
		"123019923277556", "137679730950847", "81299297965542"
	},
	["Aimbot Pizza"] = {
		"114155003741146", "104033348426533"
	},
	["Aimbot Push"] = {
		"87259391926321", "140703210927645", "136007065400978", "136007065400978",
		"129843313690921", "129843313690921", "86709774283672", "129843313690921",
		"129843313690921", "108807732150251", "138040001965654", "86096387000557",
		"86096387000557"
	},
	["Aimbot Chance"] = {
		"103601716322988", "133491532453922", "86371356500204", "76649505662612",
	    "81698196845041", "87259391926321", "140703210927645", "136007065400978",
		"136007065400978", "129843313690921", "129843313690921","86709774283672",
		"87259391926321", "129843313690921", "129843313690921", "108807732150251",
		"138040001965654", "86096387000557", "86096387000557"
	},
	["Aimbot Two Time"] = {
        "115194624791339", "89448354637442", "77119710693654", "107640065977686", "112902284724598",
        "86545133269813"
	},
	["Aura Hit"] = {}
}

AutoErrorTriggerSounds = {
    "86710781315432",
    "99820161736138",
    "609342351",
    "81976396729343",
    "12222225",
    "80521472651047",
    "139012439429121",
    "91194698358028",
    "111910850942168",
    "83851356262523",
}

local function HasValue(tbl, val)
	for _, v in ipairs(tbl) do
		if v == val then
			return true
		end
	end
	return false
end
local function InsertAnim(tbl, anim)
	if not anim or type(anim) ~= "string" then
		return
	end
	local id = anim:match("%d+")
	if id and not HasValue(tbl, id) then
		table.insert(tbl, id)
	end
end
spawn(function()
	for _, v in ipairs(Storage:GetDescendants()) do
		if v.Name == "Config" and v:IsA("ModuleScript") then
			local success, RequireGet = pcall(require, v)
			if not success then continue end
			if type(RequireGet) ~= "table" or not RequireGet.Animations then continue end
			local AnimationTo = RequireGet.Animations
			InsertAnim(Animations.KillerAnima, AnimationTo.Stab)
			InsertAnim(Animations.KillerAnima, AnimationTo.Attack)
			InsertAnim(Animations.KillerAnima, AnimationTo.Slash)
			InsertAnim(Animations.KillerAnima, AnimationTo.WalkspeedOverrideStart)
			InsertAnim(Animations.KillerAnima, AnimationTo.WalkspeedOverrideLoop)
			if AnimationTo.VoidRush then
				InsertAnim(Animations.KillerAnima, AnimationTo.VoidRush.StartCharge)
				InsertAnim(Animations.KillerAnima, AnimationTo.VoidRush.LoopCharge)
				InsertAnim(Animations["Hitbox Reach"], AnimationTo.VoidRush.StartCharge)
				InsertAnim(Animations["Hitbox Reach"], AnimationTo.VoidRush.LoopCharge)
			end
			InsertAnim(Animations["Aimbot Push"], AnimationTo.Punch)
			InsertAnim(Animations["Aimbot Push"], AnimationTo.ParryPunch)
			for i, v in pairs(AnimationTo) do
				if type(i) == "string" then
					if i:find("Cry") then
						InsertAnim(Animations.KillerAnima, v)
						InsertAnim(Animations["Hitbox Reach"], v)
					end
					if i:find("Block") then
						InsertAnim(Animations["Aura Hit"], v)
					end
					if i:find("Pizza") then
						InsertAnim(Animations["Aimbot Pizza"], v)
					end
				end
			end
			InsertAnim(Animations["Hitbox Reach"], AnimationTo.Stab)
			InsertAnim(Animations["Hitbox Reach"], AnimationTo.Attack)
			InsertAnim(Animations["Hitbox Reach"], AnimationTo.Slash)
			InsertAnim(Animations["Hitbox Reach"], AnimationTo.WalkspeedOverrideStart)
			InsertAnim(Animations["Hitbox Reach"], AnimationTo.WalkspeedOverrideLoop)
			InsertAnim(Animations["Hitbox Reach"], AnimationTo.Punch)
			InsertAnim(Animations["Hitbox Reach"], AnimationTo.ParryPunch)
			
			if type(RequireGet) ~= "table" or not RequireGet.Sounds then continue end
			if v.Parent.Parent.Name:lower():find("survivors") then
				local SoundTo = RequireGet.Sounds
				InsertAnim(AutoErrorTriggerSounds, SoundTo.Hit)
				InsertAnim(AutoErrorTriggerSounds, SoundTo.Slash)
			end
		end
	end
end)

function Aimbot(target, prediction)
	local direction = ((target.Position + (target.CFrame.LookVector * prediction)) - root.Position).Unit
	root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, math.atan2(-direction.X, -direction.Z), 0)
end
function AimbotCam(target, prediction)
	local predictedPosition = target.Position + target.CFrame.LookVector * prediction
    local direction = predictedPosition and (predictedPosition - cam.CFrame.Position).Unit
    local yaw = direction and math.atan2(-direction.X, -direction.Z)
    cam.CFrame = CFrame.new(cam.CFrame.Position) * CFrame.Angles(0, (yaw or 0), 0)
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
	local VDis = (ValueDis or nil)
    local SurvivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
    if SurvivorsFolder then
        for _, v in ipairs(SurvivorsFolder:GetChildren()) do
            if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and Distance(v.HumanoidRootPart.Position) <= (VDis or 50) then
                return v.HumanoidRootPart
            end
        end
    end
    return nil
end

function ClosestSurvivor()
    local closest = nil
    local shortestDist = math.huge
    for _, v in ipairs(workspace.Players.Survivors:GetChildren()) do
        local sRoot = v:FindFirstChild("HumanoidRootPart")
        if sRoot and root then
            local dist = (root.Position - sRoot.Position).Magnitude
            if dist < shortestDist then
                closest = v
                shortestDist = dist
            end
        end
    end
    return closest
end

function isHighlightTargetMe(highlight)
    if not char or not highlight.Adornee then return false end
    if highlight.Adornee == char then
        return true
    end
    if char:FindFirstChild(highlight.Adornee.Name) and highlight.Adornee:IsDescendantOf(char) then
        return true
    end
    return false
end

function Jumpnow()
    if maingui and maingui:FindFirstChild("SprintingButton") then
	    if getconnections then
		    local conns = getconnections(maingui.SprintingButton.MouseButton1Down)
	        for _, v in pairs(conns) do
	            pcall(function()
	                v:Fire()
	                if v.Function then v:Function() end
	            end)
	        end
		end
    else
	    VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
	    task.wait()
	    VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
    end
end

function RootWhat()
	if not AutoRotate then
        AutoRotate = hum.AutoRotate
    end
    hum.AutoRotate = false
    root.AssemblyAngularVelocity = Vector3.zero
end

function KillersAttack()
	local AbilityContainer = maingui and maingui:FindFirstChild("AbilityContainer")
	if not AbilityContainer:FindFirstChild("Slash") then
        if AbilityContainer:FindFirstChild("Punch") and AbilityContainer.Punch:FindFirstChild("CooldownTime") and AbilityContainer.Punch.CooldownTime.Text == "" then
            Remote:FireServer("UseActorAbility", {buffer.fromstring(charAb("Punch"))})
        elseif AbilityContainer:FindFirstChild("Stab") and AbilityContainer.Stab:FindFirstChild("CooldownTime") and AbilityContainer.Stab.CooldownTime.Text == "" then
            Remote:FireServer("UseActorAbility", {buffer.fromstring(charAb("Stab"))})
        elseif AbilityContainer:FindFirstChild("Carving Slash") and AbilityContainer["Carving Slash"]:FindFirstChild("CooldownTime") and AbilityContainer["Carving Slash"].CooldownTime.Text == "" then
            Remote:FireServer("UseActorAbility", {buffer.fromstring(charAb("Carving Slash"))})
        end
    else
        Remote:FireServer("UseActorAbility", {buffer.fromstring(charAb("Slash"))})
    end
end

local PrivacyFlags = {"HideKillerWins", "HidePlaytime", "HideSurvivorWins"}
local OriginalPrivacy = {}
local function SaveOriginalPrivacy(player)
    if not OriginalPrivacy[player.UserId] then
        OriginalPrivacy[player.UserId] = {}
    end
    for i, v in ipairs(PrivacyFlags) do
        local flag = player.PlayerData.Settings.Privacy:FindFirstChild(v)
        if flag then
            OriginalPrivacy[player.UserId][v] = flag.Value
        end
    end
end
local function DisablePrivacy(player)
    for i, v in ipairs(PrivacyFlags) do
        local flag = player.PlayerData.Settings.Privacy:FindFirstChild(v)
        if flag then
            flag.Value = false
        end
    end
end
local function RestorePrivacy(player)
    local saved = OriginalPrivacy[player.UserId]
    if saved then
        for i, v in pairs(saved) do
            local flag = player.PlayerData.Settings.Privacy:FindFirstChild(i)
            if flag then
                flag.Value = v
            end
        end
    end
end
local function ApplyToAllPlayers(state)
    for i, v in ipairs(playerout:GetPlayers()) do
        if v ~= player and state then
            SaveOriginalPrivacy(v)
            DisablePrivacy(v)
        else
            RestorePrivacy(v)
        end
    end
end
playerout.PlayerAdded:Connect(function(player)
    if _G.AntiHiding == true then
        SaveOriginalPrivacy(player)
        DisablePrivacy(player)
    end
end)

local function SoundPosition(sound)
	if sound.Parent and sound.Parent:IsA("BasePart") then
		return sound.Parent.Position
	elseif sound.Parent and sound.Parent:IsA("Attachment") and sound.Parent.Parent:IsA("BasePart") then
		return sound.Parent.Parent.Position
	end
	local part = sound.Parent and sound.Parent:FindFirstChildWhichIsA("BasePart", true)
	if part then
		return part.Position
	end
	return nil
end

local function SoundAutoParry(sound)
	if not _G.AutoParryError then return end
	if not char or not root then return end
	if not string.find(char.Name:lower(), "johndoe") then return end
	if not sound:IsA("Sound") or not sound.IsPlaying then return end
	if not table.find(AutoErrorTriggerSounds, tostring(sound.SoundId):match("%d+")) then return end
	local pos = SoundPosition(sound)
	if pos then
		if (root.Position - pos).Magnitude > (_G.DistanceParry or 15) then
			return
		end
	end
	Remote:FireServer("UseActorAbility", {buffer.fromstring(charAb("404Error"))})
end

function HookSound(sound)
	if not sound:IsA("Sound") then return end
	sound.Played:Connect(function()
		SoundAutoParry(sound)
	end)
	sound:GetPropertyChangedSignal("IsPlaying"):Connect(function()
        SoundAutoParry(sound)
    end)
	if sound.IsPlaying then
		SoundAutoParry(sound)
	end
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

local lastJump = 0
local FrameTimer = tick()
local CurrentRooms = 0
local FrameCounter = 0
local FPS = 60
local VoidRushRandomSurvivors = {}
table.insert(_G.Connect, RunService.RenderStepped:Connect(function()
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
if _G.VoidRushAimbot then
	local VoidRush = char and char:GetAttribute("VoidRushState")
	if VoidRush and VoidRush == "Dashing" then
		local targetSur = ClosestSurvivor()
		if targetSur then
	        local dir = targetSur.HumanoidRootPart.Position - root.Position
	        local horizontal = Vector3.new(dir.X, 0, dir.Z)
	        if horizontal.Magnitude > 0 then
	            root.CFrame = CFrame.new(root.Position, Vector3.new(targetSur.HumanoidRootPart.Position.X, root.Position.Y, targetSur.HumanoidRootPart.Position.Z))
	            root.AssemblyLinearVelocity = horizontal.Unit * 80
	        else
	            root.AssemblyLinearVelocity = Vector3.zero
	        end
		end
	end
end
if _G.VoidRushTeleport then
	local VoidRush = char and char:GetAttribute("VoidRushState")
	if VoidRush and VoidRush == "Dashing" then
		local VoidRushRandomSurvivors = {}
		local SurvivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
	    if SurvivorsFolder then
	        for _, v in ipairs(SurvivorsFolder:GetChildren()) do
	            if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then
	                table.insert(VoidRushRandomSurvivors, v)
	            end
	        end
	    end
		if VoidRushRandomSurvivors then
			local VoidRushRandom = VoidRushRandomSurvivors[math.random(#VoidRushRandomSurvivors)]
			if VoidRushRandom and VoidRushRandom:FindFirstChild("HumanoidRootPart") then
				char:PivotTo(VoidRushRandom.HumanoidRootPart.CFrame)
			end
		end
	end
end
if char and char.Name:lower() == "c00lkidd" then
	if root and root:FindFirstChildOfClass("LinearVelocity") then
		root:FindFirstChildOfClass("LinearVelocity").Enabled = false
		if _G.WalkSpeedc00kiddControl then
			lookVector = root.CFrame.LookVector
			moveDir = Vector3.new(lookVector.X, 0, lookVector.Z)
	        if moveDir.Magnitude > 0 then
	            moveDir = moveDir.Unit
	            root.Velocity = Vector3.new(moveDir.X * 100, root.Velocity.Y, moveDir.Z * 100)
	            root.CFrame = CFrame.new(root.Position, root.Position + moveDir)
	        end
		elseif _G.WalkSpeedc00kiddAimbot then
			local targetSur = ClosestSurvivor()
			if targetSur then
		        local dir = targetSur.HumanoidRootPart.Position - root.Position
		        local horizontal = Vector3.new(dir.X, 0, dir.Z)
		        if horizontal.Magnitude > 0.1 then
		            root.CFrame = CFrame.new(root.Position, Vector3.new(targetSur.HumanoidRootPart.Position.X, root.Position.Y, targetSur.HumanoidRootPart.Position.Z))
		            root.AssemblyLinearVelocity = horizontal.Unit * 80
		        else
		            root.AssemblyLinearVelocity = Vector3.zero
		        end
			end
		end
	end
end
if Toggles["Demonic Pursuit Aimbot"] and Toggles["Demonic Pursuit Aimbot"].Value then
	if AnimationTrack then
	    for _, v in ipairs(AnimationTrack:GetPlayingAnimationTracks()) do
	        if table.find(Animations["Aimbot Killer"].Sixer["Demonic Pursuit"], tostring(v.Animation.AnimationId):match("%d+")) then
				local targetSur = ClosestSurvivor()
				if targetSur and targetSur:FindFirstChild("HumanoidRootPart") then
					local dir = targetSur.HumanoidRootPart.Position - root.Position
			        local horizontal = Vector3.new(dir.X, 0, dir.Z)
			        if horizontal.Magnitude > 0 then
			            root.CFrame = CFrame.new(root.Position, Vector3.new(targetSur.HumanoidRootPart.Position.X, root.Position.Y, targetSur.HumanoidRootPart.Position.Z))
			            root.AssemblyLinearVelocity = horizontal.Unit * 80
			        else
			            root.AssemblyLinearVelocity = Vector3.zero
			        end
				end
			end
		end
	end
end
if Toggles["Demonic Pursuit Random"] and Toggles["Demonic Pursuit Random"].Value then
	if AnimationTrack then
	    for _, v in ipairs(AnimationTrack:GetPlayingAnimationTracks()) do
	        if table.find(Animations["Aimbot Killer"].Sixer["Demonic Pursuit"], tostring(v.Animation.AnimationId):match("%d+")) then
				local SixerRandomSurvivors = {}
				local SurvivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
			    if SurvivorsFolder then
			        for _, v in ipairs(SurvivorsFolder:GetChildren()) do
			            if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then
			                table.insert(SixerRandomSurvivors, v)
			            end
			        end
			    end
				if SixerRandomSurvivors then
					local SixerRandom = SixerRandomSurvivors[math.random(#SixerRandomSurvivors)]
					if SixerRandom and SixerRandom:FindFirstChild("HumanoidRootPart") then
						char:PivotTo(SixerRandom.HumanoidRootPart.CFrame)
					end
				end
			end
		end
	end
end
if Toggles["Slash Aura"] and Toggles["Slash Aura"].Value then
	if hum then
		local Aura = SurviveTarget(_G.DetectionRangeAura or 7)
		if Aura then
			if Aura.Parent and Aura.Parent.Name:lower():find("guest") then
				local humplr = Aura.Parent:FindFirstChildOfClass("Humanoid")
				local animTracks = humplr and humplr:FindFirstChildOfClass("Animator") and humplr:FindFirstChildOfClass("Animator"):GetPlayingAnimationTracks()
				for _, v in ipairs(animTracks or {}) do
			        if not tostring(v.Animation.AnimationId):match("%d+"):find(Animations["Aura Hit"]) then
						HitNow = true
					end
				end
			else
				HitNow = true
			end
		end
	end
	if HitNow then
		KillersAttack()
		if not _G.AutoMove then
			Aimbot(Aura, 0.01)
		end
	end
end
if Toggles["Aimbot Corrupt Energy"] and Toggles["Aimbot Corrupt Energy"].Value then
	if hum then
		if char and string.find(char.Name:lower(), "johndoe") then
			if tonumber(hum.WalkSpeed) < 0.05 then
				local targetSur = ClosestSurvivor()
		        if targetSur then
			        local Sharpness = (Options["Sharpness Corrupt Energy"].Value or 1)
		            Aimbot(targetSur.HumanoidRootPart, Sharpness)
		        end
			end
		end
	end
end
if Toggles["Skate Trick Farm"] and Toggles["Skate Trick Farm"].Value then
	if char and char.Name == "Veeronica" then
		local RemoteArgs = {player.Name.."SkateTrick", {}}
		if RemoteArgs then
			Remote:FireServer(unpack(RemoteArgs))
		end
	end
end
if hum then
	if AutoRotate then
        hum.AutoRotate = AutoRotate
        AutoRotate = nil
    end
	if AnimationTrack then
	    for _, v in ipairs(AnimationTrack:GetPlayingAnimationTracks()) do
	        local targetKill = KillerTarget()
			if Toggles["Change Aimbot"] and Toggles["Change Aimbot"].Value then
				if table.find(Animations["Aimbot Chance"], tostring(v.Animation.AnimationId):match("%d+")) then
					RootWhat()
			        if targetKill then
						local Sharpness = (Options["Sharpness"].Value or 1)
			            Aimbot(targetKill, Sharpness)
			        end
				end
			end
			if Toggles["Pizza Aimbot"] and Toggles["Pizza Aimbot"].Value then
				if table.find(Animations["Aimbot Pizza"], tostring(v.Animation.AnimationId):match("%d+")) then
					RootWhat()
					local targetSur = nil
					local TabletSur = {}
			        local SurvivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
				    if SurvivorsFolder then
				        for _, v in ipairs(SurvivorsFolder:GetChildren()) do
				            if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and Distance(v.HumanoidRootPart.Position) <= (Options["Distance Aimbot Pizza"].Value or 50) then
				                table.insert(TabletSur, {v.HumanoidRootPart, v.Humanoid.Health})
				            end
				        end
				    end
					if TabletSur then
						table.sort(TabletSur, function(a, b)
							return a[2] > b[2]
						end)
					end
					for _, v in ipairs(TabletSur or {}) do
						if v[1] and v[2] <= (_G.HealthPizzaPlayer or 50) then
							local Sharpness = (Options["Sharpness Pizza"].Value or 1)
				            Aimbot(v[1], Sharpness)
						end
					end
				end
			end
			if Toggles["Infernal Cry Aimbot"] and Toggles["Infernal Cry Aimbot"].Value then
				if table.find(Animations["Aimbot Killer"]["Sixer"]["Infernal Cry"], tostring(v.Animation.AnimationId):match("%d+")) then
					RootWhat()
			        local Distan = (Options["Distance Aimbot"].Value or 50)
			        local targetSur = SurviveTarget(Distan)
			        if targetSur then
				        local Sharpness = (Options["Sharpness Killer"].Value or 1)
			            Aimbot(targetSur, Sharpness)
						AimbotCam(targetSur, Sharpness)
			        end
				end
			end
			if Toggles["Two Time Crouch Stab"] and Toggles["Two Time Crouch Stab"].Value then
				if tostring(v.Animation.AnimationId):match("%d+"):find("89448354637442") then
					local targetKill = KillerTarget()
					if targetKill and Distance2(targetKill.Position) <= (_G.DetectionRangeTwoTime or 9) then
						RootWhat()
						if not ConnectWaitAimbot then
							clock = os.clock()
							ConnectWaitAimbot = true
							while os.clock() - clock < 1 do
								if os.clock() - clock < 0.2 then
									Aimbot(targetKill, 5.2)
								end
								if os.clock() - clock < 0.4 then
									local look = targetKill.CFrame.LookVector
							        local KillerPosUhh = targetKill.Position - look * 3
							        root.CFrame = CFrame.new(KillerPosUhh, KillerPosUhh + look)
								end
								task.wait()
							end
						end
					end
				end
			end
	    end
	end
end
if Toggles["Two Time Teleport"] and Toggles["Two Time Teleport"].Value then
	if root then
		local Dagger = maingui and maingui:FindFirstChild("AbilityContainer") and maingui.AbilityContainer:FindFirstChild("Dagger")
	    local cooldown = Dagger and Dagger:FindFirstChild("CooldownTime")
		local NoChanges = Dagger and Dagger:FindFirstChild("NoChanges")
		if cooldown and cooldown.Text == "" and not NoChanges then
			local targetKill = KillerTarget()
			if targetKill and Distance2(targetKill.Position) <= (_G.DetectionRangeTwoTime or 9) then
				if not ConnectWait then
					clock = os.clock()
					ConnectWait = true
					while os.clock() - clock < 1 do
						if os.clock() - clock < 0.5 then
							if AnimationTrack then
							    for _, v in ipairs(AnimationTrack:GetPlayingAnimationTracks()) do
									if not tostring(v.Animation.AnimationId):match("%d+"):find("89448354637442") then
										local look = targetKill.CFrame.LookVector
								        local KillerPosUhh = targetKill.Position - look * 3
								        root.CFrame = CFrame.new(KillerPosUhh, KillerPosUhh + look)
									end
								end
							end
						end
						if os.clock() - clock > 0.25 then
							if cooldown and cooldown.Text == "" and not NoChanges then
								Remote:FireServer("UseActorAbility", {buffer.fromstring(charAb("Dagger"))})
							end
						end
						task.wait()
					end
					ConnectWait = false
				end
			end
		end
	end
end
end)

table.insert(_G.Connect, RunService.RenderStepped:Connect(function()
	if Toggles["Auto Skate Trick"] and Toggles["Auto Skate Trick"].Value then
		for _, v in ipairs(Storage.Assets.Survivors.Veeronica.Behavior:GetDescendants()) do
	        if v:IsA("Highlight") and isHighlightTargetMe(v) then
	            Jumpnow()
	        end
	    end
	end
end))

local LastPathTime = 0
local Nopath = false
table.insert(_G.Connect, RunService.RenderStepped:Connect(function()
	if _G.AutoMove then
		if tick() - LastPathTime < 1 then return end
		local Survivor = (Options["Move"] and Options["Move"].Value == "Survivors" and ClosestSurvivor() or KillerTarget().Parent)
		local Destination = Survivor and Survivor:FindFirstChild("HumanoidRootPart")
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
						part.Size = Vector3.new(1.3, 1.3, 1.3)
						part.Position = Waypoint.Position
						part.Shape = Enum.PartType.Ball
						part.Material = Enum.Material.SmoothPlastic
						part.Anchored = true
						part.CanCollide = false
						part.Parent = pathFolder
					end
					for i, Waypoint in pairs(Waypoints) do
						if i == 1 then continue end
						hum:MoveTo(Waypoint.Position)
			            hum.MoveToFinished:Wait()
					end
				end
			end)
		end
	end
end))

for i, v in ipairs(game.Workspace:GetDescendants()) do
    if v:IsA("Sound") then 
		HookSound(v) 
	end
end
table.insert(_G.Connect, game.Workspace.DescendantAdded:Connect(function(v)
    if v:IsA("Sound") then 
		HookSound(v) 
	end
end))

local LastPathTimeGen = 0
table.insert(_G.Connect, RunService.RenderStepped:Connect(function()
	if _G.AutoGeneral then
		if tick() - LastPathTimeGen < 1 then return end
		local Destination, ClosestDist = nil, math.huge
		local okgen, errgen = pcall(function()
			for i, v in ipairs(workspace.Map.Ingame:FindFirstChild("Map"):GetChildren()) do
				if v.Name == "Generator" and v:FindFirstChild("Positions") and v.Positions:FindFirstChild("Center") and v:FindFirstChild("Remotes") and v.Remotes:FindFirstChild("RE") and v:FindFirstChild("Progress").Value ~= 100 then
					local dist = (root.Position - v.Positions:FindFirstChild("Center").Position).Magnitude
					if dist < ClosestDist then
						Destination = v.Positions:FindFirstChild("Center")
						ClosestDist = dist
					end
				end
			end
		end)
		if _G.GenFarm == "Walk" then
			local ok, err = pcall(function()
				if okgen and Destination and Distance(Destination.Position) > 7 then
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
						LastPathTimeGen = tick()
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
							part.Size = Vector3.new(1.3, 1.3, 1.3)
							part.Position = Waypoint.Position
							part.Shape = Enum.PartType.Ball
							part.Material = Enum.Material.SmoothPlastic
							part.Anchored = true
							part.CanCollide = false
							part.Parent = pathFolder
						end
						for i, Waypoint in pairs(Waypoints) do
							if i == 1 then continue end
							hum:MoveTo(Waypoint.Position)
				            hum.MoveToFinished:Wait()
						end
					end
				end
			end)
		elseif _G.GenFarm == "Teleport" then
			if Destination and Distance(Destination.Position) > 7 then
				root.CFrame = Destination.CFrame
				wait(0.3)
			end
		end
	end
end))

table.insert(_G.Connect, RunService.RenderStepped:Connect(function()
if char.Name:lower():find("guest") then
	if hum then
		if AutoRotate then
	        hum.AutoRotate = AutoRotate
	        AutoRotate = nil
	    end
		if AnimationTrack then
		    for _, v in ipairs(AnimationTrack:GetPlayingAnimationTracks()) do
		        if table.find(Animations["Aimbot Push"], tostring(v.Animation.AnimationId):match("%d+")) then
					if Toggles["Aimbot Punch"] and Toggles["Aimbot Punch"].Value then
						if not AutoRotate then
				            AutoRotate = hum.AutoRotate
				        end
				        hum.AutoRotate = false
				        root.AssemblyAngularVelocity = Vector3.zero
				        local targetKill = KillerTarget()
						local Sharpness = (Options["Sharpness Punch"].Value or 0.1)
				        if targetKill then
				            Aimbot(targetKill, Sharpness)
				        end
					end
				end
		    end
		end
		local Punch = maingui and maingui:FindFirstChild("AbilityContainer") and maingui.AbilityContainer:FindFirstChild("Punch")
	    local charges = Punch and Punch:FindFirstChild("Charges")
		local targetKill = KillerTarget()
        if charges and tonumber(charges.Text) >= 1 and targetKill and Distance(targetKill.Position) <= (_G.DetectionRangeFallPush or 15) then
			if _G.FallPunch then
	            root.CFrame = targetKill.CFrame + Vector3.new(0, 8, 0)
			end
			if _G.Punch then
				Remote:FireServer("UseActorAbility", {buffer.fromstring(charAb("Punch"))})
			end
        end
	end
end
end))

table.insert(_G.Connect, RunService.RenderStepped:Connect(function()
if _G.AutoBlock then
    local Block = maingui and maingui:FindFirstChild("AbilityContainer") and maingui.AbilityContainer:FindFirstChild("Block")
    local cooldown = Block and Block:FindFirstChild("CooldownTime")
    
	for _, v in ipairs(playerout:GetPlayers()) do
	    if v ~= player and v.Character then
	        local hrp = v.Character:FindFirstChild("HumanoidRootPart")
	        local humplr = v.Character:FindFirstChildOfClass("Humanoid")
	        local animTracks = humplr and humplr:FindFirstChildOfClass("Animator") and humplr:FindFirstChildOfClass("Animator"):GetPlayingAnimationTracks()
	        if hrp and Distance2(hrp.Position) <= (_G.DetectionRange or 18) then
				if v.Character.Parent.Name == "Killers" and Distance2(hrp.Position) <= 10 then
					if char and char.Name:lower():find("guest") then
						Remote:FireServer("StopEmote", {buffer.fromstring(charAb("Animations")), buffer.fromstring(charAb("Hello"))})
						if char:FindFirstChildOfClass("Tool") then
							Remote:FireServer("UpdateItemParent", {char:FindFirstChildOfClass("Tool")})
						end
					end
				end
	            for _, track in ipairs(animTracks or {}) do
	                if table.find(Animations["KillerAnima"], tostring(track.Animation.AnimationId):match("%d+")) then
                        if _G.AutoBlock and Distance2(hrp.Position) <= (_G.DetectionRange or 18) then
                            if hrp.CFrame.LookVector:Dot((root.Position - hrp.Position).Unit) > 0 then
	                            if cooldown and cooldown.Text == "" then
                                    Remote:FireServer("UseActorAbility", {buffer.fromstring(charAb("Block"))})
                                    if Toggles["Block Teleport"].Value then
										if root then
				                            root.CFrame = hrp.CFrame * CFrame.new(0, 0, -5)
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
	Tab2 = Window:AddTab("Misc", "rbxassetid://4370318685"),
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

if require then
Main1Group:AddToggle("Inf Stamina", {
    Text = "Inf Stamina",
    Default = false, 
    Callback = function(Value) 
_G.InfStamina = Value
while _G.InfStamina do
if staminaModule then
    staminaModule.Stamina = staminaModule.MaxStamina
    staminaModule.__staminaChangedEvent:Fire(staminaModule.Stamina)
end
task.wait()
end
    end
})

Main1Group:AddToggle("Always Stamina", {
    Text = "Always Stamina",
    Default = false, 
    Callback = function(Value) 
_G.AlwaysWalk = Value
while _G.AlwaysWalk do
if staminaModule then
    if not staminaModule.IsSprinting then
        staminaModule.IsSprinting = true
        staminaModule.__sprintedEvent:Fire(true)
    end
end
task.wait()
end
    end
}):AddKeyPicker("AlwaysStamina", {
   Default = "R",
   Text = "Always Stamina",
   Mode = "Toggle",
   SyncToggleState = true
})

Main1Group:AddSlider("FastSprint", {
    Text = "Fast Sprint",
    Default = 28,
    Min = 2,
    Max = 50,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
_G.FastSprint = Value
if staminaModule then
    if staminaModule.IsSprinting then
        staminaModule.IsSprinting = false
        staminaModule.__sprintedEvent:Fire(false)
        staminaModule.IsSprinting = true
        staminaModule.__sprintedEvent:Fire(true)
    end
end
    end
})

Main1Group:AddToggle("Fast Sprint", {
    Text = "Fast Sprint",
    Default = false, 
    Callback = function(Value) 
_G.FastSprintSpeed = Value
while _G.FastSprintSpeed do
if staminaModule then
    staminaModule.SprintSpeed = _G.FastSprint or 26
end
task.wait()
end
if staminaModule then
	staminaModule.SprintSpeed = 26
end
    end
})
end

AntiSlowConfigs = {"SlowedStatus", "StunningKiller", "EatFriedChicken", "GuestBlocking", "PunchAbility", "SubspaceTripmine", "TaphTripwire", "PlasmaBeam", "SpawnProtection", "c00lgui", "ShootingGun",  "TwoTimeStab", "TwoTimeCrouching", "DrinkingCola", "DrinkingSlateskin", "SlateskinStatus", "EatingGhostburger", "BloxyColaItem", "Medkit", "DispenserConstruction", "SentryConstruction"}
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
Main1Group:AddToggle("AutoGeneral", {
    Text = "Auto Generator",
    Default = false, 
    Callback = function(Value) 
_G.AutoGeneralFarmGet = Value
while _G.AutoGeneralFarmGet do
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

Main1Group:AddDropdown("Farm Gen", {
    Text = "Auto Farm General",
    Values = {"Walk", "Teleport"},
    Default = "",
    Callback = function(Value)
_G.GenFarm = Value
    end
})

Main1Group:AddToggle("Auto Farm General", {
    Text = "Auto Farm Generator",
    Default = false, 
    Callback = function(Value) 
_G.AutoGeneral = Value
while _G.AutoGeneral do
local Destination, ClosestDist = nil, math.huge
local okgen, errgen = pcall(function()
	for i, v in ipairs(workspace.Map.Ingame:FindFirstChild("Map"):GetChildren()) do
		if v.Name == "Generator" and v:FindFirstChild("Positions") and v.Positions:FindFirstChild("Center") and v:FindFirstChild("Remotes") and v.Remotes:FindFirstChild("RE") and v:FindFirstChild("Progress").Value ~= 100 then
			local dist = (root.Position - v.Positions:FindFirstChild("Center").Position).Magnitude
			if dist < ClosestDist then
				Destination = v.Positions:FindFirstChild("Center")
				ClosestDist = dist
			end
		end
	end
end)
if okgen then
	if Destination and Distance(Destination.Position) <= 15 then
		for _, v in pairs(Destination.Parent.Parent:GetDescendants()) do
			if v:IsA("ProximityPrompt") and v.Enabled == true then
				pcall(function()
					v.HoldDuration = 0
					v:InputHoldBegin()
	                v:InputHoldEnd()
				end)
			end
		end
		if not _G.AutoGeneralFarmGet then
			if workspace.Map.Ingame:FindFirstChild("Map") then
				for _, v in ipairs(workspace.Map.Ingame.Map:GetChildren()) do
					if v.Name == "Generator" and v:FindFirstChild("Remotes") and v.Remotes:FindFirstChild("RE") and v.Progress.Value ~= 100 then
						v.Remotes.RE:FireServer()
					end
				end
			end
		end
		wait(2.5)
	end
end
task.wait()
end
    end
})

Main1Group:AddToggle("Auto Farm Kill", {
    Text = "Auto Farm Kill",
    Default = false, 
    Callback = function(Value) 
_G.AutoFarmKill = Value
while _G.AutoFarmKill do
if char and char.Parent and char.Parent.Name == "Killers" then
	local DestinationPlr, ClosestDistKill = nil, math.huge
	local okgotkill, errnah = pcall(function()
		for i, v in ipairs(workspace.Players:WaitForChild("Survivors"):GetChildren()) do
			if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
				local dist = (root.Position - v.HumanoidRootPart.Position).Magnitude
				if dist < ClosestDistKill then
					DestinationPlr = v.HumanoidRootPart
					ClosestDistKill = dist
				end
			end
		end
	end)
	if okgotkill and DestinationPlr then
		KillersAttack()
		char:PivotTo(DestinationPlr.CFrame)
	end
end
task.wait()
end
    end
})

Main1Group:AddToggle("Slash Aura", {
    Text = "Slash Aura",
    Default = false
})

Main1Group:AddSlider("DetectionRangeAura", {
    Text = "Detection Range Aura",
    Default = 7,
    Min = 4,
    Max = 11,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
_G.DetectionRangeAura = Value
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

Main1Group:AddButton("Teleport To Killers", function()
local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
if killersFolder then
    for _, v in ipairs(killersFolder:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then
            root.CFrame = v.HumanoidRootPart.CFrame
        end
    end
end
end)

Main1Group:AddButton("Teleport To Survive", function()
local ValueDis, ValueTarget = math.huge, nil
local SurvivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
if SurvivorsFolder then
    for _, v in ipairs(SurvivorsFolder:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and Distance(v.HumanoidRootPart.Position) <= ValueDis then
            ValueTarget = v.HumanoidRootPart
            ValueDis = Distance(v.HumanoidRootPart.Position)
        end
    end
end
if ValueTarget then
	root.CFrame = ValueTarget.CFrame
end
end)

Main1Group:AddDivider()
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
if char and char.Name ~= "Elliot" then
	if hum and hum.Health <= (_G.HealthPizza or 60) then
		local OldCFrame = root.CFrame
		local pizza = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame") and workspace.Map.Ingame:FindFirstChild("Pizza")
		if pizza and pizza:IsA("BasePart") then
			root.CFrame = pizza.CFrame
			task.delay(0.2, function()
                root.CFrame = OldCFrame
            end)
			wait(0.5)
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

Main6Group:AddDropdown("ThrowNo", {
    Text = "No Throw",
    Values = {"Veeronica", "Shedletsky", "Guest 1773", "007n7"},
    Multi = true,
    Default = ""
})

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

Main6Group:AddSlider("Distance Aimbot Pizza", {
    Text = "Distance Aimbot Pizza",
    Default = 50,
    Min = 5,
    Max = 100,
    Rounding = 1,
    Compact = false
})

Main6Group:AddSlider("Sharpness Pizza", {
    Text = "Sharpness Pizza",
    Default = 1,
    Min = 1,
    Max = 10,
    Rounding = 1,
    Compact = false
})

Main6Group:AddToggle("Pizza Aimbot", {
    Text = "Pizza Aimbot",
    Default = false
})

Main6Group:AddToggle("Auto Throw Pizza", {
    Text = "Auto TP Throw Pizza",
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
			if not Options.ThrowNo.Value[z.Name] and z:GetAttribute("Username") ~= player.Name and z:FindFirstChildOfClass("Humanoid") and z:FindFirstChildOfClass("Humanoid").Health < z:FindFirstChildOfClass("Humanoid").MaxHealth and z:FindFirstChildOfClass("Humanoid").Health < (_G.HealthPizzaPlayer or 50) then
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
								Remote:FireServer("UseActorAbility", {buffer.fromstring(charAb("ThrowPizza"))})
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

Main6Group:AddToggle("Block Teleport", {
    Text = "Auto Block Teleport",
    Default = false
})

Main6Group:AddToggle("Auto Punch", {
    Text = "Auto Punch",
    Default = false, 
    Callback = function(Value) 
_G.Punch = Value
    end
})

Main6Group:AddToggle("Auto Fall Punch", {
    Text = "Auto Fall Punch",
    Default = false, 
    Callback = function(Value) 
_G.FallPunch = Value
    end
})

if hookmetamethod then
Main6Group:AddToggle("Charge Bypass", {
    Text = "Charge Bypass",
    Default = false, 
    Callback = function(Value) 
if Value then
	HookCreated(player.Name.."Guest1337Collision", "Guest1337Bypass")
else
	HookRemove("Guest1337Bypass")
end
    end
})
end

Main6Group:AddSlider("Auto Fall Punch", {
    Text = "Detection Range Punch",
    Default = 15,
    Min = 1,
    Max = 15,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
_G.DetectionRangeFallPush = Value
    end
})

Main6Group:AddSlider("Sharpness Punch", {
    Text = "Sharpness (Punch)",
    Default = 4,
    Min = 1,
    Max = 10,
    Rounding = 1,
    Compact = false
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
Main6Group:AddLabel("Change - Two Time", true)
Main6Group:AddDivider()

Main6Group:AddSlider("Sharpness", {
    Text = "Sharpness (Change)",
    Default = 4,
    Min = 1,
    Max = 10,
    Rounding = 1,
    Compact = false
})

Main6Group:AddToggle("Change Aimbot", {
    Text = "Chance Aimbot Shot",
    Default = false
})
Main6Group:AddDivider()

Main6Group:AddSlider("Detection Range Two Time", {
    Text = "Detection Range Two Time",
    Default = 6,
    Min = 4,
    Max = 9,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
_G.DetectionRangeTwoTime = Value
    end
})

Main6Group:AddToggle("Two Time Teleport", {
    Text = "Two Time Stab",
    Default = false
})

Main6Group:AddToggle("Two Time Crouch Stab", {
    Text = "Two Time Crouch Stab",
    Default = false
})

Main6Group:AddDivider()
Main6Group:AddLabel("Veeronica", true)
Main6Group:AddDivider()

Main6Group:AddToggle("Auto Skate Trick", {
    Text = "Auto Skate Trick",
    Default = false
})

Main6Group:AddToggle("Skate Trick Farm", {
    Text = "Skate Trick Farm",
    Default = false
})

if hookmetamethod then
Main6Group:AddToggle("Bypass Skate Rebound", {
    Text = "Bypass Skate Rebound",
    Default = false, 
    Callback = function(Value) 
getgenv()._BlockSkateRebound = Value
    end
})
end

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

Main7Group:AddToggle("Infernal Cry Aimbot", {
    Text = "Infernal Cry Aimbot",
    Default = false
})

Main7Group:AddToggle("Demonic Pursuit Aimbot", {
    Text = "Demonic Pursuit Aimbot",
    Default = false
})

Main7Group:AddToggle("Demonic Pursuit Random", {
    Text = "Demonic Pursuit Random",
    Default = false
})

Main7Group:AddDivider()
Main7Group:AddLabel("Noli - c00kidd", true)
Main7Group:AddDivider()

if hookmetamethod then
Main7Group:AddToggle("VoidRushBypass", {
    Text = "Void Rush Bypass",
    Default = false, 
    Callback = function(Value) 
if Value then
	HookCreated(player.Name.."VoidRushCollision", "VoidRushBypass")
else
	HookRemove("VoidRushBypass")
end
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

Main7Group:AddToggle("VoidRushTeleport", {
    Text = "Void Rush Teleport",
    Default = false, 
    Callback = function(Value) 
_G.VoidRushTeleport = Value
    end
})

Main7Group:AddToggle("VoidRushAimbot", {
    Text = "Void Rush Aimbot",
    Default = false, 
    Callback = function(Value) 
_G.VoidRushAimbot = Value
    end
})

Main7Group:AddDivider()

if hookmetamethod then
Main7Group:AddToggle("VoidRushBypass", {
    Text = "Walkspeed Override Bypass",
    Default = false, 
    Callback = function(Value) 
if Value then
	HookCreated(player.Name.."C00lkiddCollision", "CoolBypass")
else
	HookRemove("CoolBypass")
end
    end
})
end

Main7Group:AddToggle("Walkspeed Override Controll", {
    Text = "Walkspeed Override Control",
    Default = false, 
    Callback = function(Value) 
_G.WalkSpeedc00kiddControl = Value
    end
})

Main7Group:AddToggle("Walkspeed Override Aimbot", {
    Text = "Walkspeed Override Aimbot",
    Default = false, 
    Callback = function(Value) 
_G.WalkSpeedc00kiddAimbot = Value
    end
})

Main7Group:AddDivider()
Main7Group:AddLabel("John Doe", true)
Main7Group:AddDivider()

Main7Group:AddSlider("Distance Parry Error", {
    Text = "Distance Error404",
    Default = 15,
    Min = 1,
    Max = 25,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
_G.DistanceParry = Value
    end
})

Main7Group:AddToggle("Auto Error 404", {
    Text = "Auto Error404",
    Default = false,
    Callback = function(Value) 
_G.AutoParryError = Value
    end
})

Main7Group:AddSlider("Sharpness Corrupt Energy", {
    Text = "Sharpness Corrupt Energy",
    Default = 1,
    Min = 1,
    Max = 10,
    Rounding = 0,
    Compact = false
})

Main7Group:AddToggle("Aimbot Corrupt Energy", {
    Text = "Aimbot Corrupt Energy",
    Default = false
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
		if v.Name:find("Generator") and v:FindFirstChild("Progress") then
			if v.Name ~= "FakeGenerator" then
				if v.Progress.Value == 100 then
					GeneratorColor = Color3.fromRGB(0, 255, 0)
				else
					GeneratorColor = _G.ColorEspGen or Color3.fromRGB(9, 123, 237)
				end
			end
			TextGen = ""
			if v.Name == "FakeGenerator" then
				TextGen = "Fake Generator"
				GeneratorColor = Color3.new(255, 0, 0)
			else
				TextGen = "Generator ("..v.Progress.Value.."%)"
			end
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
				local TextKiller = z.Name.." ("..(z:GetAttribute("IsFakeNoli") and "Fake" or z:GetAttribute("Username"))..")"
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

Main2Group:AddToggle("KillerClone", {
    Text = "Esp Clone c00lkid",
    Default = false, 
    Callback = function(Value) 
_G.EspKillerPizza = Value
if _G.EspKillerPizza == false then
	for i, v in pairs(workspace.Map.Ingame:GetChildren()) do
		if v:GetAttribute("Team") == "Killers" then
			ESPLibrary:RemoveESP(v)
		end
	end
end
while _G.EspKillerPizza do
for i, v in pairs(workspace.Map.Ingame:GetChildren()) do
	if v:GetAttribute("Team") == "Killers" then
		local KillerColor = _G.ColorLightKillPizza or Color3.new(255, 0, 0)
		local TextKiller = "C00lkidd Clone"
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

Main2Group:AddToggle("Zombie", {
    Text = "Esp 1x1x1x1 Zombie",
    Default = false, 
    Callback = function(Value) 
_G.EspKillerZombie = Value
if _G.EspKillerZombie == false then
	for i, v in pairs(workspace.Map.Ingame:GetChildren()) do
		if v.Name:find("1x1x1x1Zombie") then
			ESPLibrary:RemoveESP(v)
		end
	end
end
while _G.EspKillerZombie do
for i, v in pairs(workspace.Map.Ingame:GetChildren()) do
	if v.Name:find("1x1x1x1Zombie") then
		local KillerColorZombie = _G.ColorLightKillZombie or Color3.new(255, 0, 0)
		local TextKillerZ = "Zombie"
		ESPLibrary:AddESP({
			Object = v,
			Text = TextKillerZ,
			Color = KillerColorZombie
		})
		ESPLibrary:UpdateObjectText(v, TextKillerZ)
		ESPLibrary:UpdateObjectColor(v, KillerColorZombie)
		ESPLibrary:SetOutlineColor(KillerColorZombie)
	end
end
task.wait()
end
    end
}):AddColorPicker("Color Esp9", {
     Default = Color3.new(255, 0, 0),
     Callback = function(Value)
_G.ColorLightKillZombie = Value
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

Main2Group:AddToggle("Pizza", {
    Text = "Esp Pizza",
    Default = false, 
    Callback = function(Value) 
_G.EspPizza = Value
if _G.EspPizza == false then
	for i, v in pairs(workspace.Map.Ingame:GetChildren()) do
		if v.Name == "Pizza" then
			ESPLibrary:RemoveESP(v)
		end
	end
end
while _G.EspKillerPizza do
for i, v in pairs(workspace.Map.Ingame:GetChildren()) do
	if v.Name == "Pizza" then
		local PizzaColor = _G.ColorLightPizza or Color3.new(0, 255, 0)
		local TextPizza = "Pizza"
		ESPLibrary:AddESP({
			Object = v,
			Text = TextPizza,
			Color = PizzaColor
		})
		ESPLibrary:UpdateObjectText(v, TextPizza)
		ESPLibrary:UpdateObjectColor(v, PizzaColor)
		ESPLibrary:SetOutlineColor(PizzaColor)
	end
end
task.wait()
end
    end
}):AddColorPicker("Color Esp6", {
     Default = Color3.new(0, 255, 0),
     Callback = function(Value)
_G.ColorLightPizza = Value
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

local Misc1Group = Tabs.Tab2:AddLeftGroupbox("Misc")
Misc1Group:AddToggle("Full Bright", {
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

Misc1Group:AddToggle("No Fog", {
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

Misc1Group:AddToggle("Show Chat", {
    Text = "Show Chat",
    Default = false, 
    Callback = function(Value) 
_G.ShowChating = Value
while _G.ShowChating do
local Chating = game:GetService("TextChatService")
if Chating and Chating:FindFirstChild("ChatWindowConfiguration") and Chating.ChatWindowConfiguration.Enabled == false then
	Chating.ChatWindowConfiguration.Enabled = true
end
task.wait()
end
    end
})

Misc1Group:AddToggle("Anti Lag", {
    Text = "Anti Lag",
    Default = false, 
    Callback = function(Value) 
_G.AntiLag = Value
for i,v in pairs(workspace:GetDescendants()) do
	RemoveLagTo(v)
end
    end
})

Misc1Group:AddToggle("Anti Hidden Stats", {
    Text = "Anti Hidden Stats",
    Default = false, 
    Callback = function(Value) 
_G.AntiHiding = Value
ApplyToAllPlayers(Value)
    end
})

Misc1Group:AddDivider()
Misc1Group:AddDropdown("Move", {
    Text = "Auto Move",
    Values = {"Killers", "Survivors"},
    Default = ""
})

Misc1Group:AddToggle("Auto Move", {
    Text = "Start Move",
    Default = false,
    Callback = function(Value)
_G.AutoMove = Value
while _G.AutoMove do
local ok, err = pcall(function()
	local Survivor = (Options["Move"].Value == "Survivors" and ClosestSurvivor() or KillerTarget().Parent)
	local Destination = Survivor and Survivor:FindFirstChild("HumanoidRootPart")
	if Destination and hum then
		if Distance(Destination.Position) <= 20 then
			Nopath = true
		else
			Nopath = false
		end
		if Nopath and Destination and hum then
			hum:MoveTo(Destination.Position)
		end
	end
end)
task.wait()
end
    end
}):AddKeyPicker("AutoMove", {
   Default = "G",
   Text = "Start Move",
   Mode = "Toggle",
   SyncToggleState = true
})

Misc1Group:AddSlider("HitboxReach", {
    Text = "Reach Hitbox",
    Default = 50,
    Min = 3,
    Max = 300,
    Rounding = 0,
    Compact = false
})

RNG = Random.new()
function ReachLogic()
	local AnimationTrack = hum and hum:FindFirstChildOfClass("Animator")
	if AnimationTrack then
		local Target, DiscTarget = nil, math.huge
	    for _, v in ipairs(AnimationTrack:GetPlayingAnimationTracks()) do
	        if table.find(Animations["Hitbox Reach"], tostring(v.Animation.AnimationId):match("%d+")) then
				local PlayersGet = workspace:FindFirstChild("Players")
				if char and char.Parent then
					if char.Parent.Name == "Killers" then
						PlayersFolder = PlayersGet and PlayersGet:FindFirstChild("Survivors")
					elseif char.Parent.Name == "Survivors" then
						PlayersFolder = PlayersGet and PlayersGet:FindFirstChild("Killers")
					end
				end
			    if PlayersFolder then
			        for _, v in ipairs(PlayersFolder:GetChildren()) do
			            if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
							local DistanceRoot = Distance2(v.HumanoidRootPart.Position)
							if DistanceRoot < DiscTarget then
								Target = v
								DiscTarget = DistanceRoot
							end
			            end
			        end
			    end
				if Target and DiscTarget and DiscTarget <= Options.HitboxReach.Value then
					local OldVelocity = root.Velocity
					local NeededVelocity = (Target.HumanoidRootPart.Position + Vector3.new(RNG:NextNumber(-1.5, 1.5), 0, RNG:NextNumber(-1.5, 1.5)) + (Target.HumanoidRootPart.Velocity * (player:GetNetworkPing() * 1.25)) - root.Position) / (player:GetNetworkPing() * 2)
					if NeededVelocity then
						root.Velocity = NeededVelocity
						game:GetService("RunService").RenderStepped:Wait()
						root.Velocity = OldVelocity
					end
				end
			end
	    end
	end
end
Misc1Group:AddToggle("Reach Hitbox", {
    Text = "Hitbox Reach",
    Default = false, 
    Callback = function(Value) 
_G.AutoHitboxReach = Value
while _G.AutoHitboxReach do
	task.wait(0.08)
	pcall(ReachLogic)
end
    end
})

local Misc2Group = Tabs.Tab2:AddRightGroupbox("Anti")
Misc2Group:AddToggle("Anti Fling", {
    Text = "Anti Fling",
    Default = false, 
    Callback = function(Value) 
_G.AntiFling = Value
while _G.AntiFling do
for _, v in ipairs(playerout:GetPlayers()) do
	if v ~= player and v.Character then
		for j, n in pairs(v.Character:GetChildren()) do
			if n:IsA("BasePart") and n.CanCollide == true then
				n.CanCollide = false
			end
		end
	end
end
task.wait()
end
for _, v in ipairs(playerout:GetPlayers()) do
	if v ~= player and v.Character then
		for j, n in pairs(v.Character:GetChildren()) do
			if n:IsA("BasePart") and n.CanCollide == false then
				n.CanCollide = true
			end
		end
	end
end
    end
})

Misc2Group:AddToggle("Anti Footsteps", {
    Text = "Anti Footsteps",
    Default = false, 
    Callback = function(Value) 
getgenv()._AntiFootsteps = Value
    end
})

Misc2Group:AddToggle("Anti Health Glitch", {
    Text = "Anti Health Glitch",
    Default = false, 
    Callback = function(Value) 
_G.AntiHealthGlitch = Value
while _G.AntiHealthGlitch do
local TemporaryUI = playergui:FindFirstChild("TemporaryUI")
if TemporaryUI then
    for i, v in pairs(TemporaryUI:GetChildren()) do
        if v.Name == "Frame" and v:FindFirstChild("Glitched") then
            v:Destroy()
        end
    end
end
task.wait()
end
    end
})

Misc2Group:AddToggle("Anti Spike John Doe", {
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

Misc2Group:AddToggle("Anti Shadow John Doe", {
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

------------------------------------------------------------------------
local success, err = pcall(function()
	getgenv().WindowNah = Window
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/File-Script/CreditJoin.Lua"))()
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
MenuGroup:AddDropdown("DPIDropdown", {
    Values = {"50%", "75%", "80%", "85%", "100%", "115%", "125%", "150%", "175%", "200%"},
    Default = "100%",
    Text = "DPI Scale",
    Callback = function(Value)
        Value = Value:gsub("%%", "")
        local He = tonumber(Value)
        Library:SetDPIScale(He)
    end
})
MenuGroup:AddDivider()
MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", {Default = "RightShift", NoUI = true, Text = "Menu keybind"})
MenuGroup:AddToggle("watermark", {Text = "Show Watermark", Default = true, Callback = function(Value) Library:SetWatermarkVisibility(Value) end})
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
        setclipboard('game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, '..'"'..game.JobId..'"'..", game.Players.LocalPlayer)")
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

Library:OnUnload(function()
	_G.AntiLag = nil
	_G.GetOldBright = nil
	for i,v in pairs(workspace:GetDescendants()) do
		RemoveLagTo(v)
	end
	if _G.Connect then
		for i, v in pairs(_G.Connect) do
			v:Disconnect()
		end
	_G.Connect = nil
	end
	if hookmetamethod then
		if getgenv()._oldFireServer then
			hookmetamethod(game, "__namecall", getgenv()._oldFireServer)
			getgenv()._oldFireServer = nil
		end
	end
	if Animations then
		Animations = nil
	end
end) 
