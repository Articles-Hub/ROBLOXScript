for i, v in pairs({"xeno", "solara", "celery", "nezur", "luna"}) do
    if string.find(identifyexecutor():lower(), v) then
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Executor Waning", Text = "Unfortunately, " .. identifyexecutor() .. " won't be able to run many of the features in the script due to its power, goodluck", Duration = 60})
    end
end

pcall(function()
Fixed = loadstring(game:HttpGet("https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/SCRIPT/Fix.lua"))()
fireclickdetector = fireclickdetector or Fixed.fireclickdetector
fireproximityprompt = fireproximityprompt or Fixed.fireproximityprompt
end)

if makefolder then makefolder("Translate") end
if writefile and isfile and not isfile("Translate/Forsaken") then
	writefile("Translate/Forsaken", "en")
end

pcall(function()
	if readfile then
		local TranslateFile = readfile("Translate/Forsaken")
		Translate = loadstring(game:HttpGet("https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/Translate/Forsaken/"..TranslateFile..".luau"))()
	end
end)

local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local PathfindingService = game:GetService("PathfindingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local VirtualUser = game:GetService("VirtualUser")

local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local MainUI = PlayerGui:WaitForChild("MainUI")

function stringChar(s)
	return string.char(3, (#s), 0, 0, 0)..s
end

_G.ListAsset = {
	["Slash"] = {
		["Animation"] = {
			["109230267448394"] = true, ["79980897195554"] = true, ["99824350842479"] = true, ["122709416391891"] = true, ["70371667919898"] = true,
			["134020762419760"] = true, ["108907358619313"] = true, ["83829782357897"] = true, ["118250546180773"] = true, ["126830014841198"] = true,
			["82113036350227"] = true, ["131406927389838"] = true, ["121293883585738"] = true, ["119583605486352"] = true, ["92567970681901"] = true,
			["89004992452376"] = true, ["18885909645"] = true, ["81299297965542"] = true, ["90620531468240"] = true, ["77375846492436"] = true,
			["88451353906104"] = true, ["109667959938617"] = true, ["105458270463374"] = true, ["112366541922769"] = true, ["123172382755876"] = true,
		},
		["Sound"] = {
			["71834552297085"] = true, ["75330693422988"] = true, ["80516583309685"] = true, ["81702359653578"] = true, ["82221759983649"] = true,
			["84116622032112"] = true, ["84307400688050"] = true, ["85853080745515"] = true, ["86174610237192"] = true, ["94317217837143"] = true,
			["95079963655241"] = true, ["98733709078792"] = true, ["101199185291628"] = true, ["102228729296384"] = true, ["104910828105172"] = true,
			["105200830849301"] = true, ["105415540898010"] = true, ["105840448036441"] = true, ["106300477136129"] = true, ["107444859834748"] = true,
			["108610718831698"] = true, ["109348678063422"] = true, ["109431876587852"] = true, ["112395455254818"] = true, ["112809109188560"] = true,
			["113037804008732"] = true, ["114742322778642"] = true, ["115026634746636"] = true, ["116527305931161"] = true, ["116581754553533"] = true,
			["117173212095661"] = true, ["119942598489800"] = true, ["121954639447247"] = true, ["127793641088496"] = true, ["128856426573270"] = true,
			["131123355704017"] = true, ["133709029886490"] = true, ["136323728355613"] = true, ["140242176732868"] = true,
		}
	},
	["Punch"] = {
		["Animation"] = {
			["87259391926321"] = true, ["140703210927645"] = true, ["136007065400978"] = true, ["129843313690921"] = true, ["86709774283672"] = true,
			["108807732150251"] = true, ["86096387000557"] = true, ["81227838714974"] = true, ["79331370895011"] = true, ["127821549546951"] = true,
			["119850211147676"] = true,
		}
	},
	["Gun"] = {
		["Animation"] = {
			["103601716322988"] = true, ["133491532453922"] = true, ["86371356500204"] = true, ["76649505662612"] = true, ["81698196845041"] = true,
			["138040001965654"] = true,
		}
	},
	["Parry"] = {
		["Animation"] = {
			["87259391926321"] = true, ["140703210927645"] = true, ["136007065400978"] = true, ["129843313690921"] = true, ["86709774283672"] = true,
			["108807732150251"] = true, ["138040001965654"] = true, ["86096387000557"] = true, ["111918351126361"] = true, ["81227838714974"] = true,
			["79331370895011"] = true, ["127821549546951"] = true, ["103601716322988"] = true, ["133491532453922"] = true, ["86371356500204"] = true,
			["81698196845041"] = true, ["115194624791339"] = true, ["86545133269813"] = true, ["76649505662612"] = true, ["89448354637442"] = true,
			["77119710693654"] = true, ["107640065977686"] = true, ["112902284724598"] = true, ["119850211147676"] = true,
		},
		["Sound"] = {
			["86710781315432"] = true, ["99820161736138"] = true, ["609342351"] = true, ["81976396729343"] = true, ["12222225"] = true,
		    ["12222208"] = true, ["99100240941590"] = true, ["80521472651047"] = true, ["139012439429121"] = true, ["91194698358028"] = true,
		    ["111910850942168"] = true, ["83851356262523"] = true
	    }
	},
	["Stab"] = {
		["Animation"] = {
			["115194624791339"] = true, ["86545133269813"] = true, ["89448354637442"] = true, ["77119710693654"] = true, ["107640065977686"] = true,
			["112902284724598"] = true, ["100725497418533"] = true,
		}
	},
	["Corrupt Energy"] = {
		["Animation"] = {
			["127172483138092"] = true, ["93432652624003"] = true, ["117623646053053"] = true, ["86758834842420"] = true, ["98054702192257"] = true,
			["96811405806507"] = true, ["93432652624003"] = true, ["93432652624003"] = true
		}
	},
	["Axe"] = {
		["Animation"] = {
			["111918351126361"] = true,
		}
	},
	["Skateboard"] = {
		["Animation"] = {
			["117058860640843"] = true,
		}
	},
}


_G.Connect = {}
_G.Hookmetamethods = {}
_G.UpdateBasePart = {}
_G.UpdateParticle = {}
_G.UpdateDecal = {}
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
		FogEnd = 9e9,
		FogStart = 9e9,
		GlobalShadows = false,
		OutdoorAmbient = Color3.fromRGB(128, 128, 128)
	}
}

getgenv().Toggle = {}

--- Check UNC ---

local function IsCallable(Value)
	return typeof(Value) == "function"
end

local function ResolveExecutorName()
	local ok, result = false, nil

	if IsCallable(identifyexecutor) then
		ok, result = pcall(identifyexecutor)
		if ok and result then
			return tostring(result)
		end
	end

	if IsCallable(getexecutorname) then
		ok, result = pcall(getexecutorname)
		if ok and result then
			return tostring(result)
		end
	end

	return "Unknown"
end

local Features = {
	namecall_hook = IsCallable(hookmetamethod) and IsCallable(getnamecallmethod),
	newcclosure = IsCallable(newcclosure),
	queue_on_teleport = IsCallable(queueonteleport) or IsCallable(queue_on_teleport),
	fireclickdetector = IsCallable(fireclickdetector),
	firetouchinterest = IsCallable(firetouchinterest),
	fireproximityprompt = IsCallable(fireproximityprompt),
	clipboard = IsCallable(setclipboard) or IsCallable(toclipboard),
	custom_asset = IsCallable(getcustomasset) and IsCallable(writefile) and IsCallable(isfile),
}

local FeatureLabels = {
	namecall_hook = "namecall hook",
	newcclosure = "newcclosure",
	queue_on_teleport = "queue on teleport",
	fireclickdetector = "click detector fire",
	firetouchinterest = "touch interest fire",
	fireproximityprompt = "proximity prompt fire",
	clipboard = "clipboard",
	custom_asset = "custom asset images",
}

local SupportedCore = 0
for _, Supported in pairs({
	Features.namecall_hook,
	Features.queue_on_teleport,
	Features.fireclickdetector,
	Features.firetouchinterest,
	Features.fireproximityprompt,
	Features.custom_asset,
}) do
	if Supported then
		SupportedCore += 1
	end
end

ExecutorSupport = Features
ExecutorSupport.Name = ResolveExecutorName()
ExecutorSupport.Summary = string.format("%d/6 core APIs", SupportedCore)
ExecutorSupport.Labels = FeatureLabels

local UnsupportedNotified = {}
function CheckExecutorSupport(FeatureName)
	if ExecutorSupport and ExecutorSupport[FeatureName] == true then
		return true
	end

	if not Silent and not UnsupportedNotified[FeatureName] then
		UnsupportedNotified[FeatureName] = true
		local Label = (ExecutorSupport and ExecutorSupport.Labels and ExecutorSupport.Labels[FeatureName])
			or tostring(FeatureName)
		local Message = "Executor does not support " .. Label .. ". Disabled unsupported function."
		game:GetService("StarterGui"):SetCore("SendNotification",{Title = "Check Unc",Text = Message,Icon = "rbxassetid://7733658504",Duration = 5})
	end

	return false
end

local function InstallUnsupportedStub(FeatureName, GlobalName)
	if ExecutorSupport[FeatureName] == true then
		return
	end

	local Environment = (getgenv and getgenv()) or _G
	if IsCallable(Environment[GlobalName]) then
		return
	end

	Environment[GlobalName] = function()
		CheckExecutorSupport(FeatureName)
	end
end

InstallUnsupportedStub("fireclickdetector", "fireclickdetector")
InstallUnsupportedStub("firetouchinterest", "firetouchinterest")
InstallUnsupportedStub("fireproximityprompt", "fireproximityprompt")

--- Script Start ---

function Create(className: string?, props: table?, children: table?)
	local obj = Instance.new(className)
	if props then
		for k, v in pairs(props) do
			pcall(function()
				obj[k] = v
			end)
		end
	end
	if children then
		for _, child in ipairs(children) do
			if typeof(child) == "Instance" then
				child.Parent = obj
			end
		end
	end
	return obj
end

function Connect(Signal, Function)
	local SignalConnect = Signal:Connect(Function)
    table.insert(_G.Connect, SignalConnect)
    return SignalConnect
end

local function t(text)
	return (Translate and Translate[text]) or text
end

local function foundObject(object, name)
	local targetObject
	local targetName = name:lower():gsub("%s+", "")
	local function check(item)
		if item and item.Name and item.Name:lower():gsub("%s+", ""):find(targetName) then
			targetObject = item
			return true
		end
	end
	if type(object) == "table" then
		for _, parentInstance in pairs(object) do
			if typeof(parentInstance) == "Instance" then
				for _, child in ipairs(parentInstance:GetChildren()) do
					if check(child) then break end
				end
			end
			if targetObject then break end
		end
	elseif typeof(object) == "Instance" then
		for _, child in ipairs(object:GetChildren()) do
			if check(child) then break end
		end
	end
	return targetObject
end


function CooldownReady(ability)
	ability = ability or {}
	ability.Name = ability.Name or "Block"
	ability.NoChange = ability.NoChange or true
	ability.Cooldown = ability.Cooldown or true

	local abilityGui = foundObject(MainUI:FindFirstChild("AbilityContainer"), ability.Name)
	local nochanges = not ability.NoChange or (abilityGui and abilityGui:FindFirstChild("NoChanges"))
	local cooldown = not ability.Cooldown or (abilityGui and abilityGui:FindFirstChild("CooldownTime"))
	if not nochanges then
		return cooldown and cooldown.Text == ""
	end
	return false
end

function GetButtonAbility(ability)
	ability = ability or {}
	ability.Name = ability.Name or "Block"

	local abilityGui = foundObject(MainUI:FindFirstChild("AbilityContainer"), ability.Name)
	if abilityGui then
		return abilityGui
	end
	return nil
end

spawn(function()
	while true do
		Character = LocalPlayer.Character or nil
		RootPart = (Character and Character:FindFirstChild("HumanoidRootPart")) or nil
		Humanoid = (Character and Character:FindFirstChild("Humanoid")) or nil
		AnimationTrack = (Humanoid and Humanoid:FindFirstChildOfClass("Animator")) or nil
		if not Remote then
			Remote = (ReplicatedStorage and ReplicatedStorage:FindFirstChild("RemoteEvent", true)) or nil
		end
		if not Unreliable then
			Unreliable = (ReplicatedStorage and ReplicatedStorage:FindFirstChild("UnreliableRemoteEvent", true)) or nil
		end
		if require then
			local function safeRequire(parent, path)
				local current = parent
				for _, name in ipairs(path) do
					current = current and current:FindFirstChild(name)
				end
				if current then
					local success, module = pcall(require, current)
					return success and module or nil
				end
			end
			staminaModule = staminaModule or safeRequire(ReplicatedStorage, {"Systems", "Character", "Game", "Sprinting"})
			networkModule = networkModule or safeRequire(ReplicatedStorage, {"Modules", "Network", "Network"})
		end
	task.wait()
	end
end)

function Distance(pos)
	if RootPart then
		return (RootPart.Position - pos).Magnitude
	end
end

local function CanHit(myRoot, targetRoot)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {Character, targetRoot.Parent}
    local direction = targetRoot.Position - myRoot.Position
    local result = workspace:Raycast(myRoot.Position, direction, params)
    if not result then
        return true
    end
    return result.Instance:IsDescendantOf(targetRoot.Parent)
end

function RootPartLock(lock)
	if lock then
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
        if RootPart then
            local objectCF = Camera.CFrame
            RootPart.CFrame = CFrame.new(RootPart.Position, Vector3.new(
                objectCF.LookVector.X + RootPart.Position.X,
                RootPart.Position.Y,
                objectCF.LookVector.Z + RootPart.Position.Z
            ))
        end
    else
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    end
end

function AutoRotates()
	if not AutoRotate then
        AutoRotate = Humanoid.AutoRotate
    end
    Humanoid.AutoRotate = false
    RootPart.AssemblyAngularVelocity = Vector3.zero
end

function HasSound(character, folder, listTrue)
    listTrue = listTrue or false
    for _, sound in ipairs(character:GetDescendants()) do
        if sound:IsA("Sound") and sound.IsPlaying then
            local soundId = tostring(sound.SoundId):match("%d+")
            if soundId then
                if listTrue then
                    if _G.ListAsset[folder].Sound[soundId] then
                        return true
                    end
                else
                    if table.find(_G.ListAsset[folder].Sound, soundId) then
                        return true
                    end
                end
            end
        end
    end
    return false
end

function HasAnimation(humanoid, folder, listTrue)
    listTrue = listTrue or false
    local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
    if not animator then
        return false
    end
    for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
        local animId = tostring(track.Animation.AnimationId):match("%d+")
        if animId then
            if listTrue then
                if _G.ListAsset[folder].Animation[animId] then
                    return true, track
                end
            else
                if table.find(_G.ListAsset[folder].Animation, animId) then
                    return true, track
                end
            end
        end
    end
    return false
end

function AddedSound(character, folder, listTrue, func)
    listTrue = listTrue or false
    func = func or function() end
    if not character or not character.Parent then return end
    local function checkSound(sound)
        if not sound:IsA("Sound") then return end
        local soundId = tostring(sound.SoundId):match("%d+")
        if not soundId then return end
        local soundList = _G.ListAsset[folder] and _G.ListAsset[folder].Sound
        if not soundList then return end
        local found
        if listTrue then
            found = soundList[soundId]
        else
            found = table.find(soundList, soundId)
        end
        if found then
            task.spawn(func)
        end
    end
    for _, descendant in ipairs(character:GetDescendants()) do
        if descendant:IsA("Sound") and descendant.IsPlaying then
            checkSound(descendant)
        end
    end
    character.DescendantAdded:Connect(function(descendant)
        if descendant:IsA("Sound") then
            checkSound(descendant)
        end
    end)
end

function AddedAnimation(humanoid, folder, listTrue, func)
    listTrue = listTrue or false
    func = func or function() end
    if not humanoid or not humanoid:IsA("Humanoid") or not humanoid.Parent then return end
    humanoid.AnimationPlayed:Connect(function(track)
        if not track or not track.Animation then return end
        local animId = tostring(track.Animation.AnimationId):match("%d+")
        if not animId then return end
        local animationList = _G.ListAsset[folder] and _G.ListAsset[folder].Animation
        if not animationList then return end
        local found
        if listTrue then
            found = animationList[animId]
        else
            found = table.find(animationList, animId)
        end
        if found then
            task.spawn(func)
        end
    end)
end

local function IsOverlapping(a, b)
	local aPos, aSize = a.AbsolutePosition, a.AbsoluteSize
	local bPos, bSize = b.AbsolutePosition, b.AbsoluteSize
	return not (aPos.X + aSize.X < bPos.X or aPos.X > bPos.X + bSize.X or aPos.Y + aSize.Y < bPos.Y or aPos.Y > bPos.Y + bSize.Y)
end

local function getAttributes(object, name)
	if not (object and object.Parent) then
		return
	end
	name = name:lower()
	for i, v in pairs(object:GetAttributes()) do
		if i:lower():find(name) then
			return v
		end
	end
end

function RemoveLagTo(obj)
	if _G.AntiLag == true then
		local Terrain = workspace:FindFirstChildOfClass("Terrain")
		if Terrain then
			Terrain.WaterWaveSize = 0
			Terrain.WaterWaveSpeed = 0
			Terrain.WaterReflectance = 0
			Terrain.WaterTransparency = 1
		end
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

Connect(game.DescendantAdded, function(v)
	RemoveLagTo(v)
end)

spawn(function()
	local function parentUntil(object, name)
		local objects = object
		while true and task.wait() do
			if objects.Parent == game or objects.Name:lower():find(name:lower()) then
				break
			end
			objects = objects.Parent
		end
		if objects.Parent ~= game then
			return objects
		else
			return nil
		end
	end

	local function InsertAnim(tbl, anim)
		if not anim or type(anim) ~= "string" then return end
		local id = anim:match("%d+")
		if not id then return end
		if not table.find(tbl, id) then
			table.insert(tbl, id)
		end
	end
	
	local function InsertAnimTrue(tbl, anim)
		if not anim or type(anim) ~= "string" then return end
		local id = anim:match("%d+")
		if not id then return end
		if not tbl[id] then
			tbl[id] = true
		end
	end
	
	local function ScanForAssetIds(target, data, listtrue)
	    listtrue = listtrue or {}
	    listtrue.ListTrue = listtrue.ListTrue or false
	    if type(data) ~= "table" then return end
	    for _, value in pairs(data) do
	        if type(value) == "table" then
	            ScanForAssetIds(target, value, listtrue)
	        elseif type(value) == "string" then
	            local id = value:match("%d+")
	            if id then
	                if listtrue.ListTrue then
	                    InsertAnimTrue(target, id)
	                else
	                    InsertAnim(target, id)
	                end
	            end
	        end
	    end
	end
	
	local function requireConfig(v, tries)
		tries = tries or 0
		local success, result = pcall(require, v)
		if success then
			return true, result
		end
		if tries >= 5 then
			return false
		end
		return requireConfig(v, tries + 1)
	end

	local function ScanAssets(list, source, keywords)
		if not source then
			return
		end
		for name, value in pairs(source or {}) do
			if type(name) == "string" then
				for _, keyword in ipairs(keywords) do
					if name:find(keyword) then
						ScanForAssetIds(list, value, {ListTrue = true})
					end
				end
			end
		end
	end
	
	for _, module in ipairs(ReplicatedStorage.Assets:GetDescendants()) do
		if not (module:IsA("ModuleScript") and module.Name == "Config") then
			continue
		end
		local success, config = requireConfig(module, 0)
		if not success or type(config) ~= "table" then
			continue
		end
		if parentUntil(module, "Killers") then
			ScanAssets(_G.ListAsset.Slash.Animation, (config.Animations or {}), {"Attack", "Slash"})
			ScanAssets(_G.ListAsset.Slash.Sound, (config.Sounds or {}), {"Hit", "Swing"})
		end
		if parentUntil(module, "Survivors") then
			ScanAssets(_G.ListAsset.Punch.Animation, (config.Animations or {}), {"Punch", "ParryPunch"})
			ScanAssets(_G.ListAsset.Parry.Animation, (config.Animations or {}), {"Punch", "ParryPunch", "Slash", "Stab", "LungeLoop", "Axe"})
			ScanAssets(_G.ListAsset.Stab.Animation, (config.Animations or {}), {"Stab", "LungeLoop"})
			ScanAssets(_G.ListAsset.Axe.Animation, (config.Animations or {}), "Axe")
			ScanAssets(_G.ListAsset.Parry.Sound, (config.Sounds or {}), {"Hit", "Punch", "Parry", "Slash", "Draw", "DefaultHit"})
		end
	end
end)

--- Function Auto ---

local activeMonitors = {}
local descendantAddedConn = nil
local function safeConnectPropertyChanged(instance, prop, fn)
    local ok, signal = pcall(function() return instance:GetPropertyChangedSignal(prop) end)
    if ok and signal then
        return signal:Connect(fn)
    end
end

local function monitorHighlight(h)
    if not h or activeMonitors[h] then return end
    local connections = {}
    local prevState = false
    local function cleanup()
        for _, conn in ipairs(connections) do
            if conn and conn.Connected then conn:Disconnect() end
        end
        activeMonitors[h] = nil
    end
    local function adorneeIsPlayerCharacter()
        local adornee = h.Adornee
        if not adornee or not Character then return false end
        return adornee == Character or adornee:IsDescendantOf(Character)
    end
    local function triggerSprint()
        local sprintBtn = MainUI and MainUI:FindFirstChild("SprintingButton", true)
        if sprintBtn and typeof(getconnections) == "function" then
            for _, conn in pairs(getconnections(sprintBtn.MouseButton1Down)) do
                pcall(function() conn.Function() end)
            end
        else
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
            task.delay(0.03, function()
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
            end)
        end
    end
    local function onChanged()
        if not _G.AutoSkateboard then return end
        if not h or not h.Parent then 
            cleanup() 
            return 
        end
        local currState = adorneeIsPlayerCharacter()
        if not prevState and currState then
            triggerSprint()
        end
        prevState = currState
    end
    local propConn = safeConnectPropertyChanged(h, "Adornee", onChanged)
    if propConn then table.insert(connections, propConn) end
    table.insert(connections, h.AncestryChanged:Connect(function(_, parent)
        if not parent then 
            cleanup() 
        else 
            onChanged() 
        end
    end))
    activeMonitors[h] = cleanup
    task.spawn(onChanged)
end

function autoVeeronica(toggle)
    if toggle then
        if descendantAddedConn then return end
        local assets = ReplicatedStorage:WaitForChild("Assets", 5)
        local survivors = assets and assets:WaitForChild("Survivors", 5)
        local veeronica = survivors and survivors:WaitForChild("Veeronica", 5)
        local behaviorFolder = veeronica and veeronica:WaitForChild("Behavior", 5)
        if not behaviorFolder then return end
        for _, obj in ipairs(behaviorFolder:GetDescendants()) do
            if obj:IsA("Highlight") then 
                monitorHighlight(obj) 
            end
        end
        descendantAddedConn = behaviorFolder.DescendantAdded:Connect(function(child)
            if child:IsA("Highlight") then 
                monitorHighlight(child) 
            end
        end)
    else
        if descendantAddedConn and descendantAddedConn.Connected then
            descendantAddedConn:Disconnect()
        end
        descendantAddedConn = nil
        for h, cleanup in pairs(activeMonitors) do
            if type(cleanup) == "function" then 
                pcall(cleanup) 
            end
        end
        table.clear(activeMonitors)
    end
end

--- Function Real ---

local function AddHookObject(object, method, newcclosure_func)
    if typeof(hookmetamethod) == "function" then
        local oldHook; oldHook = hookmetamethod(object, method, newcclosure(function(...)
            return newcclosure_func(oldHook, ...)
        end))
        table.insert(_G.Hookmetamethods, oldHook)
        return oldHook
    end
    return nil
end

local function AddFunctionHook(targetFunc, newFunc)
    if typeof(hookfunction) == "function" then
        local oldFunc
        oldFunc = hookfunction(targetFunc, newcclosure(function(...)
            return newFunc(oldFunc, ...)
        end))
        _G.Hookmetamethods = _G.Hookmetamethods or {}
        table.insert(_G.Hookmetamethods, oldFunc)
        return oldFunc
    end
    return nil
end

local function GetTargetPosition(Rootpart, Prediction, SideOffset)
    Prediction = Prediction or 0
    SideOffset = SideOffset or 1
    local velocity = Rootpart.AssemblyLinearVelocity
    local pos = Rootpart.Position + velocity * Prediction
    local localVel = Rootpart.CFrame:VectorToObjectSpace(velocity)
    local side = math.clamp(localVel.X / 16, -1, 1)
    if math.abs(side) > 0.15 then
        pos += Rootpart.CFrame.RightVector * (side * SideOffset)
    end
    return pos
end

function Aimbot(target, prediction, mode)
    if not RootPart or not target then return end
    local Mode = mode or _G.AimbotCharacter or "Character"
    local predictedPosition = GetTargetPosition(target, prediction)
    local direction = (predictedPosition - RootPart.Position).Unit
    local angleY = math.atan2(-direction.X, -direction.Z)
    local camera, rootPart = (CFrame.new(Camera.CFrame.Position) * CFrame.Angles(0, angleY, 0)), (CFrame.new(RootPart.Position) * CFrame.Angles(0, angleY, 0))
    if Mode and Mode == "Camera" then
	    Camera.CFrame = camera
    elseif Mode == "Camera + Character" then
	    Camera.CFrame = camera
		RootPart.CFrame = rootPart
	else
		RootPart.CFrame = rootPart
    end
end

function DotPlr(hrp, targetHRP, mode)
	if not hrp or not targetHRP then return false end
	local diff = hrp.Position - targetHRP.Position
	if diff.Magnitude == 0 then return false end
	local toPlayer = diff.Unit
	local look = targetHRP.CFrame.LookVector
	local dot = look:Dot(toPlayer)
	if mode == "Front" then
		return dot > 0.3
	elseif mode == "Behind" then
		return dot < -0.5
	end
	return false 
end

function ClosestSurvivor()
    local closest = nil
    local shortestDist = math.huge
    for _, v in ipairs(workspace.Players.Survivors:GetChildren()) do
	    if v:GetAttribute("Username") ~= LocalPlayer.Name and Players:GetPlayerFromCharacter(v) then
	        local sRoot = v:FindFirstChild("HumanoidRootPart")
	        if sRoot and RootPart then
	            local dist = (RootPart.Position - sRoot.Position).Magnitude
	            if dist < shortestDist then
	                closest = v
	                shortestDist = dist
	            end
	        end
		end
    end
    if not closest then
	    for _, v in ipairs(workspace.Map.Lobby:GetChildren()) do
			if v:IsA("Folder") and v.Name:lower():find("npc") then
				for _, i in pairs(v:GetChildren()) do
					if i:IsA("Model") and i.Name:lower():find("pizza") then
						closest = i
					end
				end
			end
		end
    end
    return closest
end

function ClosestKiller()
    local closest = nil
    local shortestDist = math.huge
    for _, v in ipairs(workspace.Players.Killers:GetChildren()) do
	    if v:GetAttribute("Username") ~= LocalPlayer.Name then
	        local sRoot = v:FindFirstChild("HumanoidRootPart")
	        if sRoot and RootPart then
	            local dist = (RootPart.Position - sRoot.Position).Magnitude
	            if dist < shortestDist then
	                closest = v
	                shortestDist = dist
	            end
	        end
		end
    end
    if not closest then
	    for _, v in ipairs(workspace.Map.Lobby:GetChildren()) do
			if v:IsA("Folder") and v.Name:lower():find("npc") then
				for _, i in pairs(v:GetChildren()) do
					if i:IsA("Model") and i.Name:lower():find("pizza") then
						closest = i
					end
				end
			end
		end
    end
    return closest
end

local function getPing()
	local success, val = pcall(function()
		return game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
	end)
	if success and val then return val end
	local success2, val2 = pcall(function()
		return LocalPlayer:GetNetworkPing() * 1000
	end)
	if success2 and val2 then return val2 end
	return 20
end

local moduleHooked = false
local activeHighlights = {}
local lastActivePuzzle = nil

local FALLBACK_COLORS = {
	Color3.fromRGB(255, 50, 50), 
	Color3.fromRGB(50, 255, 50), 
	Color3.fromRGB(50, 120, 255), 
	Color3.fromRGB(255, 255, 50)
}

local PathUtils = {}

function PathUtils.coordKey(node)
	return `{node.row}-{node.col}`
end

function PathUtils.getDirection(currentRow, currentCol, otherRow, otherCol)
	if otherRow < currentRow then return "up" end 
	if otherRow > currentRow then return "down" end 
	if otherCol < currentCol then return "left" end 
	if otherCol > currentCol then return "right" end 
end

function PathUtils.getConnections(prev, curr, nextnode)
	local connections = {} 
	if prev and curr then 
		local dir = PathUtils.getDirection(curr.row, curr.col, prev.row, prev.col) 
		if dir == "up" then dir = "down" 
		elseif dir == "down" then dir = "up" 
		elseif dir == "left" then dir = "right" 
		elseif dir == "right" then dir = "left" end 
		if dir ~= "" and dir then connections[dir] = true end 
	end 
	if nextnode and curr then 
		local dir = PathUtils.getDirection(curr.row, curr.col, nextnode.row, nextnode.col) 
		if dir ~= "" and dir then connections[dir] = true end 
	end 
	return connections 
end

function PathUtils.isNeighbourLocal(r1, c1, r2, c2)
	if r2 == r1 - 1 and c2 == c1 then return "up" end 
	if r2 == r1 + 1 and c2 == c1 then return "down" end 
	if r2 == r1 and c2 == c1 - 1 then return "left" end 
	if r2 == r1 and c2 == c1 + 1 then return "right" end 
	return false 
end

function PathUtils.orderPathFromEndpoints(path, endpoints)
	if not path or #path == 0 then return path end 
	local startEndpoint 
	for _, ep in endpoints or {} do 
		for _1, n in path do 
			if n.row == ep.row and n.col == ep.col then 
				startEndpoint = { row = ep.row, col = ep.col } 
				break 
			end 
		end 
		if startEndpoint then break end 
	end 
	if not startEndpoint then 
		local inPath = {} 
		for _, n in path do inPath[PathUtils.coordKey(n)] = n end 
		for _, n in path do 
			local neighbours = 0 
			local dirs = { { n.row - 1, n.col }, { n.row + 1, n.col }, { n.row, n.col - 1 }, { n.row, n.col + 1 } } 
			for _1, _binding in dirs do 
				local r, c = _binding[1], _binding[2] 
				if inPath[`{r}-{c}`] ~= nil then neighbours += 1 end 
			end 
			if neighbours == 1 then 
				startEndpoint = { row = n.row, col = n.col } 
				break 
			end 
		end 
	end 
	if not startEndpoint then 
		startEndpoint = { row = path[1].row, col = path[1].col } 
	end 
	local remaining = {} 
	for _, n in path do 
		remaining[PathUtils.coordKey(n)] = { row = n.row, col = n.col } 
	end 
	local ordered = {} 
	local current = { row = startEndpoint.row, col = startEndpoint.col } 
	local _object = table.clone(current) 
	setmetatable(_object, nil) 
	table.insert(ordered, _object) 
	remaining[PathUtils.coordKey(current)] = nil 
	while true do 
		local _size = 0 
		for _ in remaining do _size += 1 end 
		if not (_size > 0) then break end 
		local foundNext = false 
		for key, node in remaining do 
			local _value = PathUtils.isNeighbourLocal(current.row, current.col, node.row, node.col) 
			if _value ~= "" and _value then 
				local _object_1 = table.clone(node) 
				setmetatable(_object_1, nil) 
				table.insert(ordered, _object_1) 
				remaining[key] = nil 
				current = node 
				foundNext = true 
				break 
			end 
		end 
		if not foundNext then return path end 
	end 
	return ordered 
end

local HighlightManager = {}

function HighlightManager.clearExternalHighlights()
	for _, obj in ipairs(activeHighlights) do
		if obj and obj.Parent then
			obj:Destroy()
		end
	end
	table.clear(activeHighlights)
	
	if lastActivePuzzle then
		lastActivePuzzle._highlightsDrawn = false
	end
end

function HighlightManager.getExactPuzzleColor(puzzle, colorIndex, cellLookup)
	if puzzle.colors and puzzle.colors[colorIndex] then return puzzle.colors[colorIndex] end
	if puzzle.Colors and puzzle.Colors[colorIndex] then return puzzle.Colors[colorIndex] end
	
	local endpoints = puzzle.targetPairs and puzzle.targetPairs[colorIndex]
	if endpoints and endpoints[1] then
		local ep = endpoints[1]
		local n1, n2 = `{ep.row}-{ep.col}`, `{ep.row}_{ep.col}`
		local n3, n4 = `Cell-{ep.row}-{ep.col}`, `Cell_{ep.row}_{ep.col}`
		local cellUi = cellLookup[n1] or cellLookup[n2] or cellLookup[n3] or cellLookup[n4]
		
		if cellUi then
			for _, child in ipairs(cellUi:GetChildren()) do
				if child:IsA("GuiObject") and child.BackgroundTransparency < 1 and child.BackgroundColor3.R > 0.05 then
					return child.BackgroundColor3
				elseif child:IsA("ImageLabel") and child.ImageColor3 then
					return child.ImageColor3
				end
			end
			return cellUi.BackgroundColor3
		end
	end
	return FALLBACK_COLORS[((colorIndex - 1) % #FALLBACK_COLORS) + 1]
end

function HighlightManager.HighlightSolutionExternally(puzzle)
	if not _G.AutoGen or not puzzle or not puzzle.Solution then return end

	if puzzle._highlightsDrawn then
		local firstHighlight = activeHighlights[1]
		if firstHighlight and firstHighlight:IsDescendantOf(game) then
			return
		else
			puzzle._highlightsDrawn = false
		end
	end

	HighlightManager.clearExternalHighlights()

	local base = puzzle.gui or puzzle.frame or puzzle.mainGui
	if base and not base:IsDescendantOf(game) then
		base = nil
	end

	if not base then
		local sampleNode = puzzle.Solution[1] and puzzle.Solution[1][1]
		if sampleNode then
			local r, c = sampleNode.row, sampleNode.col
			local formats = { `{r}-{c}`, `{r}_{c}`, `Cell-{r}-{c}`, `Cell_{r}_{c}` }
			for _, gui in ipairs(Players.LocalPlayer:WaitForChild("PlayerGui"):GetChildren()) do
				if gui:IsA("ScreenGui") and gui.Name ~= "FlowSolverGui" then
					for _, f in ipairs(formats) do
						if gui:FindFirstChild(f, true) then
							base = gui
							break
						end
					end
				end
				if base then break end
			end
		end
	end

	if not base then return end

	local cacheValid = false
	if puzzle._cellLookup then
		local _, sampleCell = next(puzzle._cellLookup)
		if sampleCell and sampleCell:IsDescendantOf(game) then
			cacheValid = true
		end
	end

	if not cacheValid then
		puzzle._cellLookup = {}
		for _, desc in ipairs(base:GetDescendants()) do
			if desc:IsA("GuiObject") then
				puzzle._cellLookup[desc.Name] = desc
			end
		end
	end
	
	local cellLookup = puzzle._cellLookup
	for colorIndex, path in ipairs(puzzle.Solution) do
		if not _G.AutoGen then break end
		local assignedColor = HighlightManager.getExactPuzzleColor(puzzle, colorIndex, cellLookup)
		local endpoints = puzzle.targetPairs and puzzle.targetPairs[colorIndex]
		local orderedPath = PathUtils.orderPathFromEndpoints(path, endpoints) or path
		for _, node in ipairs(orderedPath) do
			if not _G.AutoGen then break end
			local n1, n2 = `{node.row}-{node.col}`, `{node.row}_{node.col}`
			local n3, n4 = `Cell-{node.row}-{node.col}`, `Cell_{node.row}_{node.col}`
			local cellUi = cellLookup[n1] or cellLookup[n2] or cellLookup[n3] or cellLookup[n4]
			if cellUi then
				local overlay = Create("Frame", {
					Name = "FlowExternalHighlight",
					Size = UDim2.new(1, 0, 1, 0),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = assignedColor,
					BackgroundTransparency = 0.55,
					BorderSizePixel = 0,
					Active = false,
					Parent = cellUi,
					ZIndex = cellUi.ZIndex + 1,
				}, {
					Create("UIStroke", {
						Color = assignedColor,
						Thickness = 2,
						Transparency = 0.2,
					}),
					Create("UICorner", {
						CornerRadius = UDim.new(0, 4),
					})
				})
				table.insert(activeHighlights, overlay)
			end
		end
	end
	puzzle._highlightsDrawn = true
end

function HighlightManager.DrawSolutionOneByOne(puzzle, delayTime) 
	delayTime = delayTime or 0.05
	if not puzzle or not puzzle.Solution then return end 
	
	local totalPaths = #puzzle.Solution 
	local indices = {} 
	for i = 1, totalPaths do
		table.insert(indices, i)
	end
	for i = #indices - 1, 2, -1 do 
		local j = math.random(1, i) 
		indices[i + 1], indices[j + 1] = indices[j + 1], indices[i + 1]
	end 
	for _, colorIndex in ipairs(indices) do 
		if not _G.AutoGen then break end
		local path = puzzle.Solution[colorIndex] 
		local endpoints = puzzle.targetPairs[colorIndex] 
		local orderedPath = PathUtils.orderPathFromEndpoints(path, endpoints) 
		puzzle.paths[colorIndex] = {} 
		for i = 0, #orderedPath - 1 do 
			if not _G.AutoGen then break end
			local node = orderedPath[i + 1] 
			table.insert(puzzle.paths[colorIndex], { row = node.row, col = node.col }) 
			local prev = orderedPath[i] 
			local nextNode = orderedPath[i + 2] 
			local conn = PathUtils.getConnections(prev, node, nextNode) 
			puzzle.gridConnections = puzzle.gridConnections or {} 
			puzzle.gridConnections[`{node.row}-{node.col}`] = conn 
			puzzle:updateGui() 
			task.wait(delayTime) 
		end 
		if not _G.AutoGen then break end
		puzzle:checkForWin() 
	end 
	if _G.AutoGen then puzzle:checkForWin() end
end

local function injectGameHook()
	if moduleHooked then return end
	moduleHooked = true
	local gameModule = ReplicatedStorage:FindFirstChild("FlowGame", true)
	if gameModule then 
		local FlowGameModule = require(gameModule) 
		local old = FlowGameModule.new 
		FlowGameModule.new = function(...) 
			local args = { ... } 
			local output = { old(unpack(args)) } 
			local puzzle = output[1] 
			if puzzle then
				lastActivePuzzle = puzzle
				local oldUpdateGui = puzzle.updateGui
				if oldUpdateGui then
					puzzle.updateGui = function(self, ...)
						local res = oldUpdateGui(self, ...)
						if _G.AutoGen and _G.AutoGenMode == "Show Path" then
							HighlightManager.HighlightSolutionExternally(puzzle)
						end
						return res
					end
				end
				task.spawn(function() 
					if not _G.AutoGen then return end
					if _G.AutoGenMode == "Auto-Solve" then
						HighlightManager.DrawSolutionOneByOne(puzzle, _G.SpeedAutoGen or 0.04) 
					else
						HighlightManager.HighlightSolutionExternally(puzzle)
					end
				end) 
			end
			return unpack(output) 
		end 
	end
end

local function executePuzzleAction(puzzle)
	if not puzzle then return end
	task.spawn(function()
		if _G.AutoGenMode == "Auto-Solve" then
			HighlightManager.DrawSolutionOneByOne(puzzle, _G.SpeedAutoGen or 0.04)
		else
			HighlightManager.HighlightSolutionExternally(puzzle)
		end
	end)
end

if staminaModule and staminaModule.DefaultConfig then
	defaultSprint = {
	    MaxStamina = staminaModule.DefaultConfig.MaxStamina or 100,
	    MinStamina = staminaModule.DefaultConfig.MinStamina or 0,
	    FOVMultiplier = 1.125
	}
end

function SetSprintDefault()
	if staminaModule and staminaModule.DefaultConfig and defaultSprint then
		staminaModule.MaxStamina = defaultSprint.MaxStamina
	    staminaModule.MinStamina = defaultSprint.MinStamina
	    staminaModule.DefaultConfig.MaxStamina = defaultSprint.MaxStamina
	    staminaModule.DefaultConfig.MinStamina = defaultSprint.MinStamina
	    if staminaModule.__FOVMultiplier then
	        staminaModule.__FOVMultiplier.Value = defaultSprint.FOVMultiplier
	    end
    end
end

local ESPLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/bocaj111004/ESPLibrary/refs/heads/main/Library.lua"))()
local tanhoangviet = "https://raw.githubusercontent.com/tanhoangviet/ToolForLua/refs/heads/main/"
local tpx = loadstring(game:HttpGet(tanhoangviet.."TopbarPlus_Extended.lua"))()
local Ex = tpx.Ex
local Pre = tpx.Presets
local wminfo = Ex.watermark({
    realtime = true,
    interval = 1,
    color = Color3.fromRGB(180, 220, 255),
})

local repo = "https://raw.githubusercontent.com/tanhoangviet/Obsidian-UI-Modded/main/"
local repoCacheKey = tostring(os.time())
local function RepoAsset(Path)
    return repo .. Path .. "?v=" .. repoCacheKey
end

local OrionSource = game:HttpGet("https://raw.githubusercontent.com/tanhoangviet/OrionLib-Modded/main/scr/Orion.lua?cache=" .. tostring(os.time()))
local OrionLib = loadstring(OrionSource, "OrionLib")()
local Flag = OrionLib.Flags

local Window = OrionLib:CreateWindow({
    Title = "Azusa Article Hub",
    Author = "Open Here",
    Theme = "Midnight",
    Icon = "sparkles",
    Size = UDim2.fromOffset(690, 430),
    SidebarCompact = true,
    SidebarCompactWidth = 54,
})

local lastJump = 0
local start
local FrameTimer = tick()
local FrameCounter = 0
local FPS = 60
local playerChances = {}
local lastKillerModel = nil
local lastKillerPos = nil
local smoothedSpeed = 0
local CorruptEnergyLoading = false
Connect(RunService.Heartbeat, function()
FrameCounter = FrameCounter + 1
if (tick() - FrameTimer) >= 1 then
    FPS = FrameCounter
    FrameTimer = tick()
    FrameCounter = 0
end
local Killer
local ClosestDistance
local chanceKiller
local targetKiller
local targetSurvivor
local playerChances = {}
for i, v in pairs(game.Workspace.Players.Killers:GetChildren()) do
	if v:IsA("Model") and v:GetAttribute("Username") ~= LocalPlayer.Name then
		Killer = v.Name
		ClosestDistance = Distance(v:GetPivot().Position)
	end
end
if Humanoid then SpeedUp = Humanoid.WalkSpeed else SpeedUp = 0 end
for _, v in pairs(Players:GetPlayers()) do
	if v and v:IsDescendantOf(Players) then 
		local dataplr = v:FindFirstChild("PlayerData")
		local stats = dataplr and dataplr:FindFirstChild("Stats")
		local general = stats and stats:FindFirstChild("General")
		local chancekiller = general and general:FindFirstChild("KillerChance")
		if chancekiller then
			local chanceValue = tonumber(chancekiller.Value) or 0
			table.insert(playerChances, {
				player = v,
				name = v.Name,
				displayName = v.DisplayName,
				chance = chanceValue
			})
		end
	end
end
table.sort(playerChances, function(a, b)
	return a.chance > b.chance
end)
if #playerChances > 0 then
	local highest = playerChances[1]
	if highest.player == LocalPlayer then
		chanceKiller = "Yourself"
	else
		chanceKiller = highest.displayName
	end
end
wminfo.setText(("Killer: %s (%s m) | %s Speed | %s FPS | %s MS | [%s]"):format(
	Killer or chanceKiller or "N/A",
	math.floor(ClosestDistance or 0),
	math.floor(SpeedUp or 0),
    math.floor(FPS),
    math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()),
    os.date("%X")
))
for i, v in pairs(_G.GetOldBright.New) do
	if _G.FullBright then
		Lighting[i] = v
	end
end
if _G.Nofog then
	for i, v in pairs(Lighting:GetChildren()) do
		if v:IsA("Atmosphere") or v:IsA("BloomEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("DepthOfFieldEffect") then
			v:Destroy()
		end
	end
end
if staminaModule then
	if _G.InfStamina then
		if not _G.CustomSpeedRecoveryStaminap then
		    staminaModule.Stamina = staminaModule.MaxStamina
		    staminaModule.__staminaChangedEvent:Fire(staminaModule.Stamina)
		end
	end
	if _G.CustomSpeedRecoveryStamina and not _G.InfStamina then
		if (not staminaModule.IsSprinting or staminaModule.Stamina <= 0) and tonumber(_G.CustomSpeedStamina) then
			staminaModule.Stamina += tonumber(_G.CustomSpeedStamina) or 0.5
			staminaModule.__staminaChangedEvent:Fire(staminaModule.Stamina)
		end
	end
	if _G.AlwaysWalk then
		if not staminaModule.IsSprinting then
	        staminaModule.IsSprinting = true
	        staminaModule.__sprintedEvent:Fire(true)
	    end
	end
	if _G.FastSprintSpeed then
	    staminaModule.SprintSpeed = _G.FastSprint or 26
	else
		staminaModule.SprintSpeed = 26
	end
	if _G.CustomStamina then
		if staminaModule.DefaultConfig then
			if staminaModule.MaxStamina and _G.CustomMaxStamina then
				staminaModule.DefaultConfig.MaxStamina = _G.MaxStamina or 100
				staminaModule.MaxStamina = _G.MaxStamina or 100
			end
			if staminaModule.MinStamina and _G.CustomMinStamina then
				local Minsprint = tonumber(_G.MinStamina or 100)
				staminaModule.MinStamina = Minsprint
		        staminaModule.DefaultConfig.MinStamina = Minsprint
		        if staminaModule.Stamina < Minsprint then
		            staminaModule.Stamina = Minsprint
		        end
			end
		end
		if _G.CustomFOVStamina then
			staminaModule.__FOVMultiplier.Value = _G.FovStamina or 1.125
		end
	end
end
if _G.VoidRushControl or _G.VoidRushAimbot then
	local VoidRush = Character and Character:GetAttribute("VoidRushState")
	if VoidRush and VoidRush == "Dashing" then
		Humanoid.AutoRotate = false
		local Look 
		if _G.VoidRushAimbot then
			local targetSur = ClosestSurvivor()
			if targetSur and targetSur:FindFirstChild("HumanoidRootPart") then
		        Look = targetSur.HumanoidRootPart.CFrame.LookVector
			end
		else
			Look = RootPart.CFrame.LookVector
		end
		local Horizontal = Vector3.new(Look.X, 0, Look.Z)
		if Horizontal.Magnitude > 0 then
		    Humanoid:Move(Horizontal.Unit)
		end
	else
		if Humanoid and not AutoRotate then
			Humanoid.AutoRotate = true
		end
	end
end
if _G.AntiHealthGlitch then
	local TemporaryUI = MainUI:FindFirstChild("TemporaryUI")
	if TemporaryUI then
	    for i, v in pairs(TemporaryUI:GetChildren()) do
	        if v.Name == "Frame" and v:FindFirstChild("Glitched") then
	            v:Destroy()
	        end
	    end
	end
end
if _G.AntiShadow then
	for i, v in pairs(workspace.Map.Ingame:GetChildren()) do
		if v:IsA("Folder") and v.Name:find("Shadows") then
			for _, j in pairs(v:GetChildren()) do
				if j:IsA("BasePart") then
					j.CanTouch = false
				end
			end
		end
	end
end
if _G.AutoPlayMinigame then
	local QTE = PlayerGui.TemporaryUI:FindFirstChild("QTE", true)
	if QTE then
		local ButtonTap = QTE:FindFirstChildOfClass("ImageButton") 
		local ButtonTapReal = ButtonTap and ButtonTap:FindFirstChildOfClass("TextLabel")
		local Line, Zone = QTE:FindFirstChild("Line"), QTE:FindFirstChild("Zone")
		if ButtonTap and ButtonTap.Visible and ButtonTapReal and ButtonTapReal.Text:lower():find("tap") then
			ButtonTap.Size = UDim2.new(1, 0, 1, 0)
		end
		if Line and Zone then
			for _, v in ipairs(Zone:GetChildren()) do
				if v:IsA("ImageLabel") then
					v.Position = Line.Position
				end
			end
		end
	end
end
if AutoRotate and Humanoid then
	Humanoid.AutoRotate = true
	AutoRotate = nil
end
if Character and Character.Name:lower():find("johndoe") then
	targetSurvivor = ClosestSurvivor()
	if targetSurvivor and targetSurvivor:FindFirstChild("HumanoidRootPart") then
		if _G.AimbotCorruptEnergy then
			local AnimationEnergy, TrackAnimationEnergy = HasAnimation(Humanoid, "Corrupt Energy", true)
			if AnimationEnergy and TrackAnimationEnergy then
				if TrackAnimationEnergy.TimePosition > (_G.DelayAimbotJohnDoe or 0.65) then
					if not CorruptEnergyLoading then
						CorruptEnergyLoading = true
						while Humanoid and Humanoid.WalkSpeed < 0.05 and task.wait() do
							pcall(function()
								AutoRotates()
					            Aimbot(targetSurvivor.HumanoidRootPart, _G.SharpnessCorruptEnergy or 1)
							end)
						end
						CorruptEnergyLoading = false
					end
				end
				if TrackAnimationEnergy.TimePosition <= (_G.DelayAimbotJohnDoe or 0.65) then
					if _G.SpinCorruptEnergy and not CorruptEnergyLoading then
						RootPart.CFrame = RootPart.CFrame * CFrame.Angles(0, math.rad(_G.SpeedSpinCorruptEnergy or 20), 0)
					end
				end
			end
		end
	end
end
if Character and Character.Name:lower():find("janedoe") then
	targetKiller = ClosestKiller()
	if targetKiller and targetKiller:FindFirstChild("HumanoidRootPart") then
		if _G.AimbotAxe then
			if Humanoid then
				local AnimationAxe, TrackAnimationAxe = HasAnimation(Humanoid, "Axe", true)
				if AnimationAxe and TrackAnimationAxe and TrackAnimationAxe.TimePosition >= (_G.DelayAimbot or 0.27) and TrackAnimationAxe.TimePosition <= 0.86 then
					if _G.PowerAxeAimbot then
						if not start or tick() - start >= 8 then
							start = tick()
						end
						local elapsed = tick() - start
						local dir = (targetKiller.HumanoidRootPart.Position - RootPart.Position).Unit
			            local alpha = math.sin((elapsed / 0.5) * math.pi)
			            RootPart.AssemblyLinearVelocity = dir * _G.AxePowerAimbot * alpha
					end
					AutoRotates()
		            Aimbot(targetKiller.HumanoidRootPart, _G.SharpnessAxe or 1)
				end
			end
		end
		if Distance(targetKiller.HumanoidRootPart.Position) <= (_G.DetectionRangeAxe or 15) then
			if _G.AutoAxe then
				local ButtonAxe = GetButtonAbility({Name = "Axe"})
				local foundLabel
				if ButtonAxe then
					for i, v in pairs(ButtonAxe:GetChildren()) do
						if v:IsA("TextLabel") and v.Text:lower():find("lv.") then
							foundLabel = v
						end
					end
				end
				if CooldownReady({Name = "Axe"}) then
					if not _G.ChangeingAxe or foundLabel then
						Remote:FireServer("UseActorAbility", {buffer.fromstring(stringChar("Axe"))})
					end
				end
			end
		end
	end
end
if Character and Character.Name:lower():find("chance") then
	targetKiller = ClosestKiller()
	local AnimationGun, TrackAnimationGun
	if Humanoid then
		AnimationGun, TrackAnimationGun = HasAnimation(Humanoid, "Gun", true)
	end
	if _G.AimbotShot then
		if Humanoid then
			if AnimationGun and TrackAnimationGun then
		        if targetKiller and targetKiller:FindFirstChild("HumanoidRootPart") then
					AutoRotates()
			        local ChanceMode = _G.ModeChance or "Normal"
					if ChanceMode == "Spin" and TrackAnimationGun.TimePosition <= 0.6 then
						RootPart.CFrame = RootPart.CFrame * CFrame.Angles(0, math.rad(_G.SpeedSpin or 20), 0)
					end
					if (ChanceMode ~= "Delay" and ChanceMode ~= "Spin") or TrackAnimationGun.TimePosition > (_G.DelayAim or 0.62) then
						Aimbot(targetKiller.HumanoidRootPart, _G.SharpnessChance or 1)
					end
		        end
			end
		end
	end
	if _G.ShowHBShot and targetKiller and targetKiller:FindFirstChild("HumanoidRootPart") then
		local hb = workspace:FindFirstChild("HBShot") or Create("Part", {
			Name = "HBShot",
			Size = Vector3.new(2.5, 2.5, 90),
			Anchored = true,
			CanCollide = false,
			CanQuery = false,
			CanTouch = false,
			Material = Enum.Material.Neon,
			Transparency = 1,
			Color = Color3.fromRGB(255,0,0),
			Parent = workspace
		})
		if workspace:FindFirstChild("HBShot") then
			if AnimationGun and TrackAnimationGun and TrackAnimationGun.TimePosition > 0.5 then
				workspace["HBShot"].Transparency = 0.8
			else
				workspace["HBShot"].Transparency = 1
			end
		end
		if hb and (not AnimationGun or not TrackAnimationGun or TrackAnimationGun.TimePosition < 0.57) then
			local dir = (targetKiller.HumanoidRootPart.Position - RootPart.Position).Unit
			hb.CFrame = CFrame.new(RootPart.Position, RootPart.Position + dir) * CFrame.new(0, 0, -hb.Size.Z / 2) * CFrame.Angles(0, 0, math.rad(90))
			local ignore = {}
			for _, v in ipairs(workspace.Players:GetChildren()) do
				if not v.Name:lower():find("killers") then
					for i, k in pairs(v:GetChildren()) do
					    if k:IsA("Model") and k:FindFirstChild("HumanoidRootPart") and Players:GetPlayerFromCharacter(k) then
					        table.insert(ignore, k)
					    end
					end
				end
			end
			local overlap = OverlapParams.new()
			overlap.FilterType = Enum.RaycastFilterType.Exclude
			overlap.FilterDescendantsInstances = ignore
			local FoundSuccess
			for _, part in ipairs(workspace:GetPartBoundsInBox(hb.CFrame, hb.Size, overlap)) do
			    local model = part:FindFirstAncestorOfClass("Model")
			    if model and Players:GetPlayerFromCharacter(model) then
			        if CanHit(RootPart, targetKiller.HumanoidRootPart) then
						FoundSuccess = true
						break
					end
			    end
			end
			hb.Color = FoundSuccess and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0)
		end
	else
		if workspace:FindFirstChild("HBShot") then
			workspace["HBShot"].Transparency = 1
		end
	end
else
	if workspace:FindFirstChild("HBShot") then
		workspace["HBShot"].Transparency = 1
	end
end
if Character and Character.Name:lower():find("guest") then
	targetKiller = ClosestKiller()
	if _G.AimbotPunch then
		if Humanoid then
			local AnimationPunch = HasAnimation(Humanoid, "Punch", true)
			if AnimationPunch then
		        if targetKiller and targetKiller:FindFirstChild("HumanoidRootPart") then
					if Distance(targetKiller.HumanoidRootPart.Position) <= (_G.DetectionRangePunch or 15) + 10 then
						AutoRotates()
			            Aimbot(targetKiller.HumanoidRootPart, _G.SharpnessPunch or 1)
					end
		        end
			end
		end
	end
	if _G.AutoPunch then
		if CooldownReady({Name = "Punch"}) and MainUI and MainUI:FindFirstChild("AbilityContainer"):FindFirstChild("Punch"):FindFirstChild("AbilityName") then
			if not _G.PunchChange or MainUI.AbilityContainer.Punch.AbilityName.TextColor3 ~= Color3.fromRGB(255,255,255) then
				if targetKiller:FindFirstChild("HumanoidRootPart") and Distance(targetKiller.HumanoidRootPart.Position) <= (_G.DetectionRangePunch or 15) then
					Remote:FireServer("UseActorAbility", {buffer.fromstring(stringChar("Punch"))})
				end
			end
		end
	end
	if _G.ShowHBRange then
		local rangeHB = tonumber(_G.DetectionRangeGuest or 18)
		if not workspace:FindFirstChild("RangeHB (Block)") then
			Create("Part", {
				Name = "RangeHB (Block)",
				Shape = Enum.PartType.Cylinder,
				Size = Vector3.new(0.2, rangeHB * 2, rangeHB * 2),
				Anchored = true,
				CanCollide = false,
				CanQuery = false,
				CanTouch = false,
				Material = Enum.Material.Neon,
				Transparency = _G.ShowHBRange and 0.7 or 1,
				Color = Color3.fromRGB(255,0,0),
				Parent = workspace
			})
		end
		if targetKiller and workspace:FindFirstChild("RangeHB (Block)") then
			local position
			local currentRange = rangeHB
			if _G.FacingDirection then
			    local hrp = targetKiller.HumanoidRootPart
			    local hrpSize = hrp.Size.Z / 2
			    local offset = rangeHB * 0.5 + hrpSize
			    currentRange = math.max(rangeHB - offset, 0)
			    position = hrp.Position + hrp.CFrame.LookVector * offset
			else
			    position = targetKiller.HumanoidRootPart.Position
			end
			local ignore = {}
			for _, v in ipairs(workspace.Players:GetChildren()) do
				for i, k in pairs(v:GetChildren()) do
				    if k:IsA("Model") and k:FindFirstChild("HumanoidRootPart") and Players:GetPlayerFromCharacter(k) then
				        table.insert(ignore, k)
				    end
				end
			end
		    local paramsPlayers = RaycastParams.new()
		    paramsPlayers.FilterType = Enum.RaycastFilterType.Exclude
		    paramsPlayers.FilterDescendantsInstances = ignore
		    local result = workspace:Raycast(position + Vector3.new(0, 5, 0), Vector3.new(0, -50, 0), paramsPlayers)
		    if result then
		        workspace["RangeHB (Block)"].CFrame = CFrame.new(result.Position + Vector3.new(0, 0.03, 0)) * CFrame.Angles(0, 0, math.rad(90))
		    else
		        workspace["RangeHB (Block)"].CFrame = CFrame.new(position - Vector3.new(0, 3, 0)) * CFrame.Angles(0, 0, math.rad(90))
		    end
			workspace["RangeHB (Block)"].Size = Vector3.new(0.2, rangeHB * 2, rangeHB * 2)
			workspace["RangeHB (Block)"].Transparency = 0.7
			local distance = (workspace["RangeHB (Block)"].Position - RootPart.Position).Magnitude
	        local wall = CanHit(RootPart, targetKiller.HumanoidRootPart)
	        if distance <= rangeHB and wall then
	            workspace["RangeHB (Block)"].Color = Color3.fromRGB(0,255,0)
	        else
	            workspace["RangeHB (Block)"].Color = Color3.fromRGB(255,0,0)
	        end
		end
	else
		if workspace:FindFirstChild("RangeHB (Block)") then
			workspace["RangeHB (Block)"].Transparency = 1
		end
	end
else
	if workspace:FindFirstChild("RangeHB (Block)") then
		workspace["RangeHB (Block)"].Transparency = 1
	end
end
end)

Connect(RunService.RenderStepped, function()
	if not Character or not RootPart then return end
	local name = Character.Name:lower()
	local isTwoTime = name:find("twotime")
	local isJaneDoe = name:find("janedoe")
	if not (isTwoTime or isJaneDoe) then return end
	if not (_G.AutoBackstab or _G.AutoAxe) then return end
	local killer = ClosestKiller()
	local killerHrp = killer and killer:FindFirstChild("HumanoidRootPart")
	if not killerHrp then return end
	local behind = (isTwoTime and _G.StudsBackStab or 3)
	local hasAnim, track
	local startTime, endTime
	if isTwoTime then
		hasAnim, track = HasAnimation(Humanoid, "Stab", true)
		startTime, endTime = 0, 0.7
	else
		hasAnim, track = HasAnimation(Humanoid, "Axe", true)
		startTime, endTime = 0.27, 0.86
	end
	local active = hasAnim and track and track.TimePosition >= startTime and track.TimePosition <= endTime
	if active then
		if (isTwoTime and _G.ModeTwoTime == "Logic") or (isJaneDoe and _G.ModeJaneDoe == "Logic") then
			local clone = Character:FindFirstChild("RootPart_Clone") or Create("Part", {
				Name = "RootPart_Clone",
				Size = Vector3.new(2,2,2),
				Anchored = true,
				CanCollide = false,
				Transparency = 0,
				Parent = Character
			})
			clone.CFrame = killerHrp.CFrame * CFrame.new(0,0,behind)
			Character.PrimaryPart = clone
		else
			if not isJaneDoe or _G.ModeJaneDoe == "Teleport" then
				Aimbot(killerHrp, 0.1)
				RootPart.CFrame = killerHrp.CFrame * CFrame.new(0,0,behind)
			end
		end
		RootPart.AssemblyLinearVelocity = Vector3.zero
		RootPart.AssemblyAngularVelocity = Vector3.zero
		RootPart.RotVelocity = Vector3.zero
		RootPart.Velocity = Vector3.zero
	elseif Character:FindFirstChild("RootPart_Clone") then
		Character.RootPart_Clone:Destroy()
		Character.PrimaryPart = RootPart
	end
end)

Connect(RunService.RenderStepped, function(dt)
	if _G.AutoStubStab then
		local killerModel = ClosestKiller()
		if killerModel then
			local killerHrp = killerModel:FindFirstChild("HumanoidRootPart")
			if killerHrp then
				local currentPos = killerHrp.Position
				local rawSpeed = 0
				if lastKillerModel == killerModel and lastKillerPos then
					local horizontalDelta = Vector3.new(currentPos.X, 0, currentPos.Z) - Vector3.new(lastKillerPos.X, 0, lastKillerPos.Z)
					rawSpeed = horizontalDelta.Magnitude / dt
				end
				lastKillerModel = killerModel
				lastKillerPos = currentPos
				smoothedSpeed = smoothedSpeed + (rawSpeed - smoothedSpeed) * math.min(dt * 15, 1)
				local studsAtRun = _G.RunStubs or 3.5
				local stubsAtStands = _G.StandStuds or 5.5
				local finalSpeed = math.clamp(smoothedSpeed, 0, 30)
				if _G.CheckPing then
					local ping = getPing()
					local clampedPing = math.max(ping, 20)
					studsAtRun = studsAtRun - ((clampedPing - 20) / 100) * 1.5
					studsAtRun = math.max(studsAtRun, 1.0)
				end
				local slope = (stubsAtStands - studsAtRun) / 26.0
				local calculatedStuds = stubsAtStands - (finalSpeed * slope)
				if Flag and Flag["Studs Backstab"] then
					Flag["Studs Backstab"]:SetText(string.format("%.1f", calculatedStuds))
				end
			else
				lastKillerModel = nil
			end
		else
			lastKillerModel = nil
			smoothedSpeed = 0
		end
	else
		lastKillerModel = nil
		smoothedSpeed = 0
	end
end)

Connect(RunService.RenderStepped, function()
	pcall(function()
		if Humanoid and RootPart then
			if _G.NoFindPath then return end
			if not _G.AutoMove then return end
			if Nopath then return end
			local Players = (_G.AutoMoveChoose == "Survivors" and ClosestSurvivor() or ClosestKiller())
			local Destination = Players and Players:FindFirstChild("HumanoidRootPart")
			if Destination then
				local Path = PathfindingService:CreatePath({
					AgentRadius = 3,
					WaypointSpacing = 10,
					AgentHeight = 5,
					AgentCanJump = false,
					AgentJumpHeight = 10,
					AgentCanClimb = false,
					AgentMaxSlope = 45
				})
				Path:ComputeAsync(RootPart.Position + Vector3.new(0, 5, 0), Destination.Position)
				if Path.Status == Enum.PathStatus.Success then
					local Waypoints = Path:GetWaypoints()
					local WaypointIndex = 2
					local Waypoint = Waypoints[WaypointIndex] or Waypoints[#Waypoints]
					local Waypoint2D = Waypoint.Position * Vector3.new(1, 0, 1)
					local Current2D = RootPart.Position * Vector3.new(1, 0, 1)
					if (Waypoint2D - Current2D).Magnitude <= 1 then
						WaypointIndex += 1
					else
						Humanoid:MoveTo(Waypoint.Position)
					end
				end
			end
		end
	end)
end)

local function TryAutoBlock(player, detectType)
    if not Character or not Character.Parent or not Character.Name then return end
    if player == LocalPlayer then return end
    local enemyCharacter = player.Character
    if not enemyCharacter then return end
    local rootPartPlayers = enemyCharacter:FindFirstChild("HumanoidRootPart")
    if not rootPartPlayers then return end
    local charName = Character.Name:lower()
    if detectType == "Parry" then
        if Distance(rootPartPlayers.Position) <= (_G.DetectionRangeSlasher or 18) then
            if charName:find("slash") then
                if CooldownReady({Name = "RagingPace"}) then
                    Remote:FireServer("UseActorAbility", {buffer.fromstring(stringChar("RagingPace"))})
                end
            elseif charName:find("johndoe") then
                if CooldownReady({Name = "404Error"}) then
                    Remote:FireServer("UseActorAbility", {buffer.fromstring(stringChar("404Error"))})
                end
            end
        end
    elseif charName:find("guest") and detectType == "Slash" then
        if Distance(rootPartPlayers.Position) > (_G.DetectionRangeGuest or 18) then return end
        if _G.FacingDirection and not DotPlr(RootPart, rootPartPlayers, "Front") then return end
        if CooldownReady({Name = "Block"}) then
            Remote:FireServer("UseActorAbility", {buffer.fromstring(stringChar("Block"))})
        end
    end
end

local function SetupPlayer(player)
    local function SetupCharacter(character)
        if player == LocalPlayer then return end
        local humanoid = character:WaitForChild("Humanoid", 10)
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 10)
        if not humanoid or not humanoidRootPart then return end        
        
        local function RunLoop(detectType, isEnabled)
            if isEnabled then
                local startTimer = tick()
                while tick() - startTimer < 0.1 and task.wait() do
                    TryAutoBlock(player, detectType)
                end
            end
        end

        AddedSound(humanoidRootPart, "Slash", true, function()
            if character.Parent and character.Parent.Name:lower():find("killers") then
                RunLoop("Slash", _G.AutoBlockSound)
            end
        end)

        AddedAnimation(humanoid, "Slash", true, function()
            if character.Parent and character.Parent.Name:lower():find("killers") then
                RunLoop("Slash", _G.AutoBlockAnimation)
            end
        end)
        
        AddedSound(humanoidRootPart, "Parry", true, function()
            if character.Parent and character.Parent.Name:lower():find("survivors") then
                local charName = Character and Character.Name:lower() or ""
                if charName:find("johndoe") then
                    RunLoop("Parry", _G.AutoParryJohnSound)
                else
                    RunLoop("Parry", _G.AutoParrySound)
                end
            end
        end)
        
        AddedAnimation(humanoid, "Parry", true, function()
            if character.Parent and character.Parent.Name:lower():find("survivors") then
                local charName = Character and Character.Name:lower() or ""
                if charName:find("johndoe") then
                    RunLoop("Parry", _G.AutoParryJohnAnimation)
                else
                    RunLoop("Parry", _G.AutoParryAnimation)
                end
            end
        end)
    end
    Connect(player.CharacterAdded, SetupCharacter)
    if player.Character then
        task.spawn(SetupCharacter, player.Character)
    end
end

Connect(Players.PlayerAdded, SetupPlayer)
for _, p in ipairs(Players:GetPlayers()) do
    SetupPlayer(p)
end

AddHookObject(game, "__namecall", function(oldHook, self, ...)
    local method = getnamecallmethod()
    local args = {...}
    if self == Remote and method:lower():find("fireserver") then
        local toggle = getgenv().Toggle or {}
        if toggle["Block SkateRebound"] and tostring(args[1]) == LocalPlayer.Name .. "SkateRebound" then
            return nil
        end
        if toggle["Block SkateRebound"] and tostring(args[1]) == LocalPlayer.Name .. "StopSkate" and typeof(args[2]) == "table" then
            for _, v in ipairs(args[2]) do
                if typeof(v) == "Instance" then
                    if Remote then
                        oldHook(Remote, LocalPlayer.Name .. "StopSkate", { buffer.fromstring("Manual") })
                    end
                    return nil
                end
            end
        end
    end
    return oldHook(self, ...)
end)

local Tabs = {}
local function AddTab(name, config)
	local tabObj, groupObj = Window:Tab(config)
	Tabs[name] = tabObj
	if groupObj then
		Tabs[name .. "Group"] = groupObj
	end
end

AddTab("Main", {Title = t"Main", Mode = "Group", Icon = "rbxassetid://7734053426"})
AddTab("Esp", {Title = t"Esp", Icon = "rbxassetid://10723346959"})
AddTab("Misc", {Title = t"Misc", Mode = "Group", Icon = "rbxassetid://4370318685"})
AddTab("Killers", {Title = t"Killers", Mode = "Group", Icon = "rbxassetid://10734975486"})
AddTab("Survivors", {Title = t"Survivors", Mode = "Group", Icon = "rbxassetid://7743871480"})
AddTab("UI Settings", {Title = t"UI Settings", Icon = "rbxassetid://7733955511"})

local Main, MainTab = Tabs.Main, Tabs.MainGroup
local MainLeft = MainTab:Left()
local MainRight = MainTab:Right()

local StaminaGroup = MainLeft:GroupBox({
    Title = t"Stamina / Sprint",
})

StaminaGroup:Slider({
    Title = t"Custom Min Stamina",
    Min = 100,
    Max = 1000,
    Value = 0,
    Increment = 1,
    Flag = "MinStamina",
    Callback = function(Value)
        _G.MinStamina = Value
    end
})

StaminaGroup:Toggle({
    Title = t"Custom Min Stamina",
    Value = false,
    Flag = "Custom Min Stamina",
    Callback = function(Value)
        _G.CustomMinStamina = Value
    end
})

StaminaGroup:Slider({
    Title = t"Custom Max Stamina",
    Min = 100,
    Max = 1000,
    Value = 0,
    Increment = 1,
    Flag = "MaxStamina",
    Callback = function(Value)
        _G.MaxStamina = Value
    end
})

StaminaGroup:Toggle({
    Title = t"Custom Max Stamina",
    Value = false,
    Flag = "Custom Max Stamina",
    Callback = function(Value)
        _G.CustomMaxStamina = Value
        if not _G.CustomMaxStamina then
	        SetSprintDefault()
        end
    end
})

StaminaGroup:Slider({
    Title = t"Custom FOV Stamina",
    Min = 0.5,
    Max = 2,
    Value = 1.127,
    Increment = 0.001,
    Flag = "FovStamina",
    Callback = function(Value)
        _G.FovStamina = Value
    end
})

StaminaGroup:Toggle({
    Title = t"Custom FOV Stamina",
    Value = false,
    Flag = "Custom FOV Stamina",
    Callback = function(Value)
        _G.CustomFOVStamina = Value
    end
})

StaminaGroup:Slider({
    Title = t"Custom Stamina Speed Recovery",
    Min = 0,
    Max = 2,
    Value = 0.5,
    Increment = 0.1,
    Flag = "Custom Speed Recovery",
    Callback = function(Value)
        _G.CustomSpeedStamina = Value
    end
})

StaminaGroup:Toggle({
    Title = t"Custom Speed Recovery",
    Value = false,
    Flag = "Custom Stamina Speed Recovery",
    Callback = function(Value)
        _G.CustomSpeedRecoveryStamina = Value
    end
})

StaminaGroup:Toggle({
    Title = t"Custom Stamina",
    Value = false,
    Flag = "Custom Stamina",
    Callback = function(Value)
        _G.CustomStamina = Value
    end
})

StaminaGroup:Toggle({
    Title = t"Inf Stamina",
    Value = false,
    Flag = "Inf Stamina",
    Callback = function(Value)
        _G.InfStamina = Value
    end
}):AddBind({
    Default = Enum.KeyCode.F,
    Hold = true,
    Flag = "InfStamina",
})

StaminaGroup:Toggle({
    Title = t"Always Stamina",
    Value = false,
    Flag = "Always Stamina",
    Callback = function(Value)
        _G.AlwaysWalk = Value
    end
}):AddBind({
    Default = Enum.KeyCode.Q,
    Hold = true,
    Flag = "AlwaysStamina",
})

StaminaGroup:Slider({
    Title = t"Fast Sprint",
    Min = 26,
    Max = 100,
    Value = 28,
    Increment = 1,
    Flag = "Fast Sprint",
    Callback = function(Value)
        _G.FastSprint = Value
    end
})

StaminaGroup:Toggle({
    Title = t"Fast Sprint",
    Value = false,
    Flag = "Fast Sprint",
    Callback = function(Value)
        _G.FastSprintSpeed = Value
    end
})

local GeneratorGroup = MainRight:GroupBox({
    Title = t"Generator",
})

GeneratorGroup:Button({
    Title = t"Teleport Generator",
    Callback = function()
if workspace.Map.Ingame:FindFirstChild("Map") then
	for i, v in ipairs(workspace.Map.Ingame:FindFirstChild("Map"):GetChildren()) do
		if v.Name == "Generator" and v:FindFirstChild("Positions") and v.Positions:FindFirstChild("Center") and v:FindFirstChild("Progress").Value < 100 then
			RootPart.CFrame = v.Positions:FindFirstChild("Center").CFrame
			break
		end
	end
end
    end
})

GeneratorGroup:Slider({
    Title = t"Delay Play Generator",
    Min = 0.05,
    Max = 1,
    Value = 0.1,
    Increment = 0.01,
    Flag = "Speed Generator",
    Callback = function(Value)
        _G.SpeedAutoGen = Value
    end
})

GeneratorGroup:Dropdown({
    Title = t"Mode Auto Generator",
    Options = {"Show Path", "Auto-Solve"},
    Default = "",
    Flag = "Mode Auto Generator",
    Callback = function(Value)
		_G.AutoGenMode = Value
		if Value == "Show Path" then
			if _G.AutoGen and lastActivePuzzle then
				HighlightManager.clearExternalHighlights()
				pcall(function() lastActivePuzzle:updateGui() end)
				HighlightManager.HighlightSolutionExternally(lastActivePuzzle)
			end
		else
			HighlightManager.clearExternalHighlights()
			if _G.AutoGen and lastActivePuzzle then
				executePuzzleAction(lastActivePuzzle)
			end
		end
    end
})

GeneratorGroup:Toggle({
    Title = t"Auto Play Generator",
    Value = false,
    Flag = "Auto Play Generator",
    Callback = function(Value)
        _G.AutoGen = Value
        if Value then
	        injectGameHook()
			executePuzzleAction(lastActivePuzzle)
		else
			HighlightManager.clearExternalHighlights()
        end
    end
})

local Esp = Tabs.Esp
local EspGroup = Esp:GroupBox({
    Title = t"Esp",
})

local EspCache = {}
function EspAdd(object, name, color)
    if not object or not object.Parent then
        return
    end
    if not EspCache[object] then
        EspCache[object] = true
        ESPLibrary:AddESP({
            Object = object,
            Text = name,
            Color = color
        })
        object.Destroying:Connect(function()
            EspCache[object] = nil
            ESPLibrary:RemoveESP(object)
        end)
    end
    ESPLibrary:UpdateObjectText(object, name)
    ESPLibrary:UpdateObjectColor(object, color)
end

function ClearEsp(object)
	if EspCache[object] then
		EspCache[object] = nil
        ESPLibrary:RemoveESP(object)
	end
end

Connect(RunService.Heartbeat, function()
	for i, v in pairs(game.Workspace.Players:GetChildren()) do
		if v.Name:lower():find("survivors") or v.Name:lower():find("killers") then
			for y, z in pairs(v:GetChildren()) do
				if z:GetAttribute("Username") ~= LocalPlayer.Name and Players:GetPlayerFromCharacter(z) then
					if _G.EspKiller and z.Parent.Name:lower():find("killers") then
						local KillerColor = _G.EspKillerColor or Color3.new(255, 0, 0)
						EspAdd(z, z.Name.." ("..z:GetAttribute("Username")..")", KillerColor)
					end
					if _G.EspSurvivors and z.Parent.Name:lower():find("survivors") and z:FindFirstChild("Humanoid") then
						local SurvivorsColor = _G.EspSurvivorsColor or Color3.new(0, 255, 0)
						EspAdd(z, z.Name..(_G.ShowHealth and " | Health: "..math.floor((z.Humanoid.Health / z.Humanoid.MaxHealth) * 100).."%" or "").." ("..z:GetAttribute("Username")..")", SurvivorsColor)
					end
				end
			end
		end
	end
	for i, v in pairs(workspace.Map.Ingame:GetChildren()) do
		if _G.EspClone then
			if v.Parent and ((v:GetAttribute("Team") and v:GetAttribute("Team") == "Killers") or v.Name:lower():find("1x1x1x1zombie")) then
				local CloneTeam = _G.EspCloneColor or Color3.fromRGB(255, 0, 0)
				EspAdd(v, "Clone Killer", CloneTeam)
			end
		end
		if _G.EspDispenser then
			if v.Name:lower():find("dispenser") then
				local dispenserColor = _G.ColorDispenser or Color3.fromRGB(0, 162, 255)
				EspAdd(v, "Dispenser", dispenserColor)
			end
		end
		if _G.EspSentry then
			if v.Name:lower():find("sentry") then
				local sentryColor = _G.ColorSentry or Color3.fromRGB(128, 128, 128)
				EspAdd(v, "Sentry", sentryColor)
			end
		end
		if _G.EspTripmine then
			if v.Name:lower():find("subspacetripmine") then
				local tripmineColor = _G.ColorSubspace or Color3.fromRGB(160, 32, 240)
				EspAdd(v, "Tripmine", tripmineColor)
			end
		end
		if _G.EspTripwire then
			if v.Name:lower():find("taphtripwire") then
				local tripwireColor = _G.ColorTripwire or Color3.fromRGB(160, 32, 240)
				EspAdd(v, "Tripwire", tripwireColor)
			end
		end
		if _G.EspPizza then
			if v.Name:lower() == "pizza" then
				local pizzaColor = _G.ColorPizza or Color3.fromRGB(0, 255, 0)
				EspAdd(v, "Pizza", pizzaColor)
			end
		end
		if _G.EspGraffitiCL then
			if v.Name:lower():find("kkim_") then
				for f, s in pairs(v:GetChildren()) do
					if s:FindFirstChild("Hitbox") then
						local graffitiColor = _G.ColorGraffiti or Color3.fromRGB(242, 128, 242)
						local textGraffiti = ("Graffiti [%s]"):format(v:GetAttribute("Completed") and "Complete" or ("%d/100"):format(v:GetAttribute("Progression")))
						EspAdd(s, textGraffiti, graffitiColor)
					end
				end
			end
		end
		if _G.EspDigitalFootprint then
			if v:IsA("Folder") and v.Name:find("Shadows") then
				for _, j in pairs(v:GetChildren()) do
					if j:IsA("BasePart") then
						local digitalfootprintColor = _G.ColorDigitalFootprint or Color3.new(255, 0, 0)
						EspAdd(j, "Digital Footprint", digitalfootprintColor)
					end
				end
			end
		end
		if _G.EspMassInfection then
			if v.Name:lower():find("shockwave") or v.Name:lower():find("swords") then
				local partEsp = v:FindFirstChildWhichIsA("BasePart")
				if partEsp then
					local massinfectionColor = _G.ColorMassInfection or Color3.fromRGB(255, 0, 0)
					EspAdd(partEsp, (v.Name:lower():find("shockwave") and "Shock wave" or "Swords"), massinfectionColor)
				end
			end
		end
		if _G.EspGroundBulb then
			if v.Name:lower():find("groundbulb") then
				local groundbulbColor = _G.ColorGroundBulb or Color3.fromRGB(237, 159, 114)
				EspAdd(v, "Ground Bulb", groundbulbColor)
			end
		end
		if _G.EspGroundBulb then
			if v.Name:lower():find("vine") then
				local vineColor = _G.ColorVine or Color3.fromRGB(196, 255, 196)
				EspAdd(v, "Vine", vineColor)
			end
		end
		if v.Name:lower() == "map" then
			for _, y in pairs(v:GetChildren()) do
				if _G.EspGenerator and y.Name:find("Generator") and y:FindFirstChild("Progress") then
					local GeneratorColor, TextGenerator = nil, nil
					if y.Name ~= "FakeGenerator" then
						if y.Progress.Value == 100 then
							GeneratorColor = Color3.fromRGB(0, 255, 0)
						else
							GeneratorColor = _G.EspGeneratorColor or Color3.fromRGB(9, 123, 237)
						end
					end
					if y.Name == "FakeGenerator" then
						TextGenerator = "Fake Generator"
						GeneratorColor = Color3.new(255, 0, 0)
					else
						TextGenerator = "Generator ("..y.Progress.Value.."%)"
					end
					EspAdd(y, TextGenerator, GeneratorColor)
				end
			end
		end
	end
end)

local ESPConnections = {}
local function HandleItemESP(tool, enable)
    local partItem = tool:FindFirstChildWhichIsA("BasePart")
    if not partItem then
        return
    end    
    if enable then
        if tool:GetAttribute("HasESP") then
            return
       end
        local itemColor = _G.ColorItem or Color3.fromRGB(97, 242, 184)
        EspAdd(partItem, tool.Name, itemColor)
        tool:SetAttribute("HasESP", true)
    else
        ClearEsp(partItem)
        tool:SetAttribute("HasESP", nil)
    end
end

local function IsItemOnGround(tool)
    if not tool or not tool.Parent then
        return false
    end
    if tool.Parent:IsA("Backpack") then
        return false
    end
    local character = tool:FindFirstAncestorOfClass("Model")
    if character and character:FindFirstChildOfClass("Humanoid") then
        return false
    end
    return true
end

local function SetupTool(tool)
    if not tool:IsA("Tool") then
        return
    end
    if IsItemOnGround(tool) then
        HandleItemESP(tool, true)
    end
    if ESPConnections[tool] then
        ESPConnections[tool]:Disconnect()
    end
    ESPConnections[tool] = tool.AncestryChanged:Connect(function()
        if not tool.Parent then
            HandleItemESP(tool, false)
            if ESPConnections[tool] then
                ESPConnections[tool]:Disconnect()
                ESPConnections[tool] = nil
            end
            return
        end
        if IsItemOnGround(tool) then
            HandleItemESP(tool, true)
        else
            HandleItemESP(tool, false)
        end
    end)
end

Connect(workspace.DescendantAdded, function(v)
    if _G.EspItem and v:IsA("Tool") then
        task.wait()
        SetupTool(v)
    end
end)

EspGroup:Toggle({
    Title = t"Esp Generator",
    Value = false,
    Flag = "Esp Generator",
    Callback = function(Value)
        _G.EspGenerator = Value
        if _G.EspGeneral == false then
			if workspace.Map.Ingame:FindFirstChild("Map") then
				for i, v in pairs(workspace.Map.Ingame:FindFirstChild("Map"):GetChildren()) do
					if v.Name == "Generator" or v.Name == "FakeGenerator" then
						ClearEsp(v)
					end
				end
			end
		end
    end
}):AddColor({
    Default = Color3.fromRGB(9, 123, 237),
    Callback = function(color)
		_G.EspGeneratorColor = color
    end
})

EspGroup:Toggle({
    Title = t"Esp Killer",
    Value = false,
    Flag = "Esp Killer",
    Callback = function(Value)
        _G.EspKiller = Value
        if not _G.EspKiller then
	        for i, v in pairs(game.Workspace.Players:GetChildren()) do
				if v.Name == "Killers" then
					for y, z in pairs(v:GetChildren()) do
						if z:GetAttribute("Username") ~= LocalPlayer.Name and Players:GetPlayerFromCharacter(z) then
							ClearEsp(z)
						end
					end
				end
			end
        end
    end
}):AddColor({
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(color)
		_G.EspKillerColor = color
    end
})

EspGroup:Toggle({
    Title = t"Esp Survivors",
    Value = false,
    Flag = "Esp Survivors",
    Callback = function(Value)
        _G.EspSurvivors = Value
        if not _G.EspSurvivors then
	        for i, v in pairs(game.Workspace.Players:GetChildren()) do
				if v.Name == "Survivors" then
					for y, z in pairs(v:GetChildren()) do
						if z:GetAttribute("Username") ~= LocalPlayer.Name and Players:GetPlayerFromCharacter(z) then
							ClearEsp(z)
						end
					end
				end
			end
        end
    end
}):AddColor({
    Default = Color3.fromRGB(0, 255, 0),
    Callback = function(color)
		_G.EspSurvivorsColor = color
    end
})

EspGroup:Toggle({
    Title = t"Esp Clone",
    Value = false,
    Flag = "Esp Clone",
    Callback = function(Value)
        _G.EspClone = Value
        if not _G.EspClone then
	        for i, v in pairs(workspace.Map.Ingame:GetChildren()) do
				if (v:GetAttribute("Team") and v:GetAttribute("Team") == "Killers") or v.Name:lower():find("1x1x1x1zombie") then
					ClearEsp(v)
				end
			end
        end
    end
}):AddColor({
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(color)
		_G.EspCloneColor = color
    end
})

EspGroup:Toggle({
    Title = t"Esp Item",
    Value = false,
    Flag = "Esp Item",
    Callback = function(Value)
        _G.EspItem = Value
		task.spawn(function()
			for _, v in ipairs(workspace:GetDescendants()) do
			    if v:IsA("Tool") then
			        SetupTool(v)
			    end
			end
		    while _G.EspItem do
		        task.wait(1)
		    end
		    for tool, connection in pairs(ESPConnections) do
		        if connection then
		            connection:Disconnect()
		        end
		        HandleItemESP(tool, false)
		    end
		    table.clear(ESPConnections)
		end)
	end
}):AddColor({
    Default = Color3.fromRGB(97, 242, 184),
    Callback = function(color)
		_G.ColorItem = color
    end
})

EspGroup:Toggle({
    Title = t"Esp Dispenser",
    Value = false,
    Flag = "Esp Dispenser",
    Callback = function(Value)
        _G.EspDispenser = Value
        if not _G.EspDispenser then
	        for i, v in pairs(workspace.Map.Ingame:GetChildren()) do
				if v.Name:lower():find("dispenser") then
					ClearEsp(v)
				end
			end
        end
    end
}):AddColor({
    Default = Color3.fromRGB(0, 162, 255),
    Callback = function(color)
		_G.ColorDispenser = color
    end
})

EspGroup:Toggle({
    Title = t"Esp Sentry",
    Value = false,
    Flag = "Esp Sentry",
    Callback = function(Value)
        _G.EspSentry = Value
        if not _G.EspSentry then
	        for i, v in pairs(workspace.Map.Ingame:GetChildren()) do
				if v.Name:lower():find("sentry") then
					ClearEsp(v)
				end
			end
        end
    end
}):AddColor({
    Default = Color3.fromRGB(128, 128, 128),
    Callback = function(color)
		_G.ColorSentry = color
    end
})

EspGroup:Toggle({
    Title = t"Esp Tripmine",
    Value = false,
    Flag = "Esp Tripmine",
    Callback = function(Value)
        _G.EspTripmine = Value
        if not _G.EspTripmine then
	        for i, v in pairs(workspace.Map.Ingame:GetChildren()) do
				if v.Name:lower():find("subspacetripmine") then
					ClearEsp(v)
				end
			end
        end
    end
}):AddColor({
    Default = Color3.fromRGB(160, 32, 240),
    Callback = function(color)
		_G.ColorSubspace = Value
    end
})

EspGroup:Toggle({
    Title = t"Esp Tripwire",
    Value = false,
    Flag = "Esp Tripwire",
    Callback = function(Value)
        _G.EspTripwire = Value
        if not _G.EspTripwire then
	        for i, v in pairs(workspace.Map.Ingame:GetChildren()) do
				if v.Name:lower():find("taphtripwire") then
					ClearEsp(v)
				end
			end
        end
    end
}):AddColor({
    Default = Color3.fromRGB(255, 85, 0),
    Callback = function(color)
		_G.ColorTripwire = Value
    end
})

EspGroup:Toggle({
    Title = t"Esp Digital Footprint",
    Value = false,
    Flag = "Esp Digital Footprint",
    Callback = function(Value)
        _G.EspDigitalFootprint = Value
        if not _G.EspDigitalFootprint then
	        for i, v in pairs(workspace.Map.Ingame:GetChildren()) do
				if v:IsA("Folder") and v.Name:find("Shadows") then
					for _, j in pairs(v:GetChildren()) do
						if j:IsA("BasePart") then
							ClearEsp(j)
						end
					end
				end
			end
        end
    end
}):AddColor({
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(color)
		_G.ColorDigitalFootprint = Value
    end
})

EspGroup:Toggle({
    Title = t"Esp Pizza",
    Value = false,
    Flag = "Esp Pizza",
    Callback = function(Value)
        _G.EspPizza = Value
        if not _G.EspPizza then
	        for i, v in pairs(workspace.Map.Ingame:GetChildren()) do
				if v.Name == "Pizza" then
					ClearEsp(v)
				end
			end
        end
    end
}):AddColor({
    Default = Color3.fromRGB(0, 255, 0),
    Callback = function(color)
		_G.ColorPizza = Value
    end
})

EspGroup:Toggle({
    Title = t"Esp Mass Infection",
    Value = false,
    Flag = "Esp Mass Infection",
    Callback = function(Value)
        _G.EspMassInfection = Value
        if not _G.EspMassInfection then
	        for i, v in pairs(workspace.Map.Ingame:GetChildren()) do
				if v.Name:lower():find("shockwave") or v.Name:lower():find("swords") then
					local partEsp = v:FindFirstChildOfClass("BasePart")
					if partEsp then
						ClearEsp(partEsp)
					end
				end
			end
        end
    end
}):AddColor({
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(color)
		_G.ColorMassInfection = Value
    end
})

EspGroup:Toggle({
    Title = t"Esp Ground Bulb",
    Value = false,
    Flag = "Esp Ground Bulb",
    Callback = function(Value)
        _G.EspGroundBulb = Value
        if not _G.EspGroundBulb then
	        for i, v in pairs(workspace.Map.Ingame:GetChildren()) do
				if v.Name:lower():find("groundbulb") then
					ClearEsp(v)
				end
			end
        end
    end
}):AddColor({
    Default = Color3.fromRGB(237, 159, 114),
    Callback = function(color)
		_G.ColorGroundBulb = Value
    end
})

EspGroup:Toggle({
    Title = t"Esp Vine",
    Value = false,
    Flag = "Esp Vine",
    Callback = function(Value)
        _G.EspVine = Value
        if not _G.EspVine then
	        for i, v in pairs(workspace.Map.Ingame:GetChildren()) do
				if v.Name:lower():find("vine") then
					ClearEsp(v)
				end
			end
        end
    end
}):AddColor({
    Default = Color3.fromRGB(196, 255, 196),
    Callback = function(color)
		_G.ColorVine = Value
    end
})

EspGroup:Toggle({
    Title = t"Esp Graffiti",
    Value = false,
    Flag = "Esp Graffiti",
    Callback = function(Value)
        _G.EspGraffitiCL = Value
        if not _G.EspGraffitiCL then
	        for i, v in pairs(workspace.Map.Ingame:GetChildren()) do
				if v.Name:lower():find("graffiticl") then
					ClearEsp(v)
				end
			end
        end
    end
}):AddColor({
    Default = Color3.fromRGB(242, 128, 242),
    Callback = function(color)
		_G.ColorGraffiti = Value
    end
})

local SettingsEspGroup = Esp:GroupBox({
    Title = t"Settings Esp",
})

local Font = {}
for _, v in ipairs(Enum.Font:GetEnumItems()) do
    table.insert(Font, v.Name)
end
SettingsEspGroup:Dropdown({
    Title = t"Font Esp",
    Options = Font,
    Default = "Code",
    Flag = "Font Esp",
    Callback = function(value)
        if ESPLibrary then
			ESPLibrary:SetFont(Value)
		end
    end
})

SettingsEspGroup:Toggle({
    Title = t"Esp Distance",
    Value = false,
    Flag = "Esp Distance",
    Callback = function(Value)
        if ESPLibrary then
			ESPLibrary:SetShowDistance(Value)
		end
    end
})

SettingsEspGroup:Toggle({
    Title = t"Esp Health",
    Value = false,
    Flag = "Esp Health",
    Callback = function(Value)
        _G.ShowHealth = Value
    end
})

SettingsEspGroup:Toggle({
    Title = t"Esp Rainbow",
    Value = false,
    Flag = "Esp Rainbow",
    Callback = function(Value)
        if ESPLibrary then
			ESPLibrary:SetRainbow(Value)
		end
    end
})

SettingsEspGroup:Toggle({
    Title = t"Esp Tracers",
    Value = false,
    Flag = "Esp Tracers",
    Callback = function(Value)
        if ESPLibrary then
			ESPLibrary:SetTracers(Value)
		end
    end
})

SettingsEspGroup:Dropdown({
    Title = t"Tracers Origin",
    Options = {"Bottom", "Top", "Center", "Mouse"},
    Default = "Bottom",
    Flag = "Tracers Origin",
    Callback = function(Value)
        if ESPLibrary then
			ESPLibrary:SetTracerOrigin(Value)
		end
    end
})

SettingsEspGroup:Toggle({
    Title = t"Esp Arrows",
    Value = false,
    Flag = "Esp Tracers",
    Callback = function(Value)
        if ESPLibrary then
			ESPLibrary:SetArrows(Value)
		end
    end
})

SettingsEspGroup:Slider({
    Title = t"Set Arrows Radius",
    Min = 0,
    Max = 500,
    Value = 300,
    Increment = 1,
    Flag = "Set Arrows Radius",
    Callback = function(Value)
        if ESPLibrary then
			ESPLibrary:SetArrowRadius(Value)
		end
    end
})

SettingsEspGroup:Slider({
    Title = t"Set Text Size",
    Min = 10,
    Max = 50,
    Value = 12,
    Increment = 1,
    Flag = "Set TextSize",
    Callback = function(Value)
        if ESPLibrary then
			ESPLibrary:SetTextSize(Value)
		end
    end
})

SettingsEspGroup:Slider({
    Title = t"Set Fill Transparency (Highlight)",
    Min = 0,
    Max = 1,
    Value = 0.5,
    Increment = 0.1,
    Flag = "Set Fill Transparency (Highlight)",
    Callback = function(Value)
        if ESPLibrary then
			ESPLibrary:SetFillTransparency(Value)
		end
    end
})

SettingsEspGroup:Slider({
    Title = t"Set OutLine Transparency (Highlight)",
    Min = 0,
    Max = 1,
    Value = 0.5,
    Increment = 0.1,
    Flag = "Set OutLine Transparency (Highlight)",
    Callback = function(Value)
        if ESPLibrary then
			ESPLibrary:SetOutlineTransparency(Value)
		end
    end
})

local Misc, MiscTab = Tabs.Misc, Tabs.MiscGroup
local MiscLeft = MiscTab:Left()
local MiscRight = MiscTab:Right()

local SettingsGroup = MiscLeft:GroupBox({
    Title = t"Settings Function",
})

SettingsGroup:Dropdown({
    Title = t"Aimbot",
    Options = {"Camera", "Character", "Camera + Character"},
    Default = "Camera",
    Flag = "Aimbot",
    Callback = function(Value)
		_G.AimbotCharacter = Value
    end
})

SettingsGroup:Dropdown({
    Title = t"Lock Players",
    Options = {"Camera", "Character", "Camera + Character"},
    Default = "",
    Flag = "Lock Players",
    Callback = function(Value)
		_G.LockCharacter = Value
    end
})

SettingsGroup:Dropdown({
    Title = t"Set Device",
    Options = {"Mobile", "PC", "Console", "nil"},
    Default = "",
    Flag = "Set Device",
    Callback = function(Value)
	    if networkModule then
			networkModule:FireServerConnection("SetDevice", "REMOTE_EVENT", Value)
		end
    end
})

local AntiGroup = MiscLeft:GroupBox({
    Title = t"Anti",
})

AntiGroup:Toggle({
    Title = t"Anti Health Glitch",
    Value = false,
    Flag = "Anti Health Glitch",
    Callback = function(Value)
        _G.AntiHealthGlitch = Value
    end
})

AntiGroup:Toggle({
    Title = t"Anti Shadow (John Doe)",
    Value = false,
    Flag = "Anti Shadow (John Doe)",
    Callback = function(Value)
        _G.AntiShadow = Value
    end
})

local MiscGroup = MiscRight:GroupBox({
    Title = t"Function",
})

MiscGroup:Slider({
    Title = t"Custom FOV Camera",
    Min = 30,
    Max = 180,
    Value = 80,
    Increment = 1,
    Flag = "FOVCamera",
    Callback = function(Value)
        if networkModule then
			networkModule:FireServerConnection("UpdateSettings", "REMOTE_EVENT", LocalPlayer:WaitForChild("PlayerData"):WaitForChild("Settings"):WaitForChild("Game"):WaitForChild("FieldOfView"), Value)
		end
    end
})

MiscGroup:Toggle({
    Title = t"Auto Play Minigame",
    Value = false,
    Flag = "Auto Play Minigame",
    Callback = function(Value)
_G.AutoPlayMinigame = Value
    end
})

MiscGroup:Toggle({
    Title = t"Full Bright",
    Value = false,
    Flag = "Full Bright",
    Callback = function(Value)
        _G.FullBright = Value
        if not _G.FullBright then
	        for i, v in pairs(_G.GetOldBright.Old) do
				Lighting[i] = v
			end
        end
    end
})

MiscGroup:Toggle({
    Title = t"No Fog",
    Value = false,
    Flag = "No Fog",
    Callback = function(Value)
        _G.Nofog = Value
    end
})

MiscGroup:Toggle({
    Title = t"Show Chat",
    Value = false,
    Flag = "Show Chat",
    Callback = function(Value)
        _G.ShowChating = Value
		while _G.ShowChating do
			if TextChatService and TextChatService:FindFirstChild("ChatWindowConfiguration") and TextChatService.ChatWindowConfiguration.Enabled == false then
				TextChatService.ChatWindowConfiguration.Enabled = true
			end
			task.wait()
		end
    end
})

MiscGroup:Toggle({
    Title = t"Anti Lag",
    Value = false,
    Flag = "Anti Lag",
    Callback = function(Value)
        _G.AntiLag = Value
		for i,v in pairs(workspace:GetDescendants()) do
			RemoveLagTo(v)
		end
    end
})

MiscGroup:Dropdown({
    Title = t"Choose Auto Move",
    Options = {"Survivors", "Killers"},
    Default = "Survivors",
    Flag = "Choose Auto Move",
    Callback = function(Value)
		_G.AutoMoveChoose = Value
    end
})

MiscGroup:Toggle({
    Title = t"No Findpath Move",
    Value = false,
    Flag = "No Findpath Move",
    Callback = function(Value)
        _G.NoFindPath = Value
    end
})

MiscGroup:Toggle({
    Title = t"Auto Move",
    Value = false,
    Flag = "Auto Move",
    Callback = function(Value)
        _G.AutoMove = Value
		while _G.AutoMove do
			pcall(function()
				local Players = (_G.AutoMoveChoose == "Survivors" and ClosestSurvivor() or ClosestKiller())
				local Destination = Players and Players:FindFirstChild("HumanoidRootPart")
				if Destination and Humanoid then
					if Distance(Destination.Position) <= 20 then
						Nopath = true
					else
						Nopath = false
					end
					if Nopath and Destination and Humanoid then
						Humanoid:MoveTo(Destination.Position)
					end
				end
			end)
			task.wait()
		end
    end
})

MiscGroup:Dropdown({
    Title = t"Choose Lock",
    Options = {"Survivors", "Killers"},
    Default = "Survivors",
    Flag = "Choose Lock",
    Callback = function(Value)
		_G.AutoLockChoose = Value
    end
})

MiscGroup:Toggle({
    Title = t"Auto Lock",
    Value = false,
    Flag = "Auto Lock",
    Callback = function(Value)
        _G.AutoLock = Value
		while _G.AutoLock do
			pcall(function()
				local Players = (_G.AutoLockChoose == "Survivors" and ClosestSurvivor() or ClosestKiller())
				local Destination = Players and Players:FindFirstChild("HumanoidRootPart")
				if Destination and Humanoid then
					Aimbot(Destination, 0.1, _G.LockCharacter)
				end
			end)
			task.wait()
		end
    end
}):AddBind({
    Default = Enum.KeyCode.Q,
    Hold = true,
    Flag = "Lock Players",
})

local Survivors, SurvivorsTab = Tabs.Survivors, Tabs.SurvivorsGroup
local SurvivorsLeft = SurvivorsTab:Left()
local SurvivorsRight = SurvivorsTab:Right()

local ChanceGroup = SurvivorsRight:GroupBox({
    Title = t"Chance",
})

ChanceGroup:Dropdown({
    Title = t"Chance Mode",
    Options = {"Delay", "Normal", "Spin"},
    Default = "Normal",
    Flag = "Chance Mode",
    Callback = function(Value)
        _G.ModeChance = Value
        if Flag then
	        if Flag["Delay Aimbot Chance"] then
		        Flag["Delay Aimbot Chance"]:SetVisible(Value == "Delay" and true or false)
			end
			if Flag["Spin Aimbot"] then
		        Flag["Spin Aimbot"]:SetVisible(Value == "Spin" and true or false)
			end
        end
    end
})

ChanceGroup:Slider({
    Title = t"Delay Aimbot",
    Min = 0,
    Max = 0.62,
    Value = 0.62,
    Increment = 0.01,
    Flag = "Delay Aimbot Chance",
    Visible = false,
    Callback = function(Value)
        _G.DelayAim = Value
    end
})

ChanceGroup:Slider({
    Title = t"Spin Aimbot",
    Min = 1,
    Max = 30,
    Value = 2,
    Increment = 1,
    Flag = "Spin Aimbot",
    Visible = false,
    Callback = function(Value)
        _G.SpeedSpin = Value
    end
})

ChanceGroup:Slider({
    Title = t"Sharpness Shot",
    Min = 0,
    Max = 5,
    Value = 1,
    Increment = 1,
    Flag = "Sharpness Shot",
    Callback = function(Value)
        _G.SharpnessChance = Value
    end
})

ChanceGroup:Toggle({
    Title = t"Aimbot Shot",
    Value = false,
    Flag = "Aimbot Shot",
    Callback = function(Value)
        _G.AimbotShot = Value
    end
})

ChanceGroup:Toggle({
    Title = t"Show Hitbox Shot",
    Value = false,
    Flag = "Show Hitbox Shot",
    Callback = function(Value)
        _G.ShowHBShot = Value
    end
})

local TwoTimeGroup = SurvivorsLeft:GroupBox({
    Title = t"Two Time",
})

TwoTimeGroup:Dropdown({
    Title = t"Two Time Mode",
    Options = {"Logic", "Teleport"},
    Default = "Logic",
    Flag = "Two Time Mode",
    Callback = function(Value)
        _G.ModeTwoTime = Value
    end
})

TwoTimeGroup:Input({
    Title = t"Duration Backstab",
    Default = "0.5",
    Flag = "Duration Backstab",
    Finished = true,
    Numeric = true,
    Callback = function(Value)
		_G.DurationStab = tonumber(Value)
    end
})

TwoTimeGroup:Input({
    Title = t"Studs Backstab",
    Default = "4",
    Flag = "Studs Backstab",
    Finished = true,
    Numeric = true,
    Callback = function(Value)
		_G.StudsBackStab = tonumber(Value)
    end
})

TwoTimeGroup:Toggle({
    Title = t"Auto Stubs",
    Value = false,
    Flag = "Auto Stubs",
    Callback = function(Value)
        _G.AutoStubStab = Value
        if Flag then
	        if Flag["Studs Run"] then
		        Flag["Studs Run"]:SetVisible(Value)
	        end
	        if Flag["Studs Stand"] then
		        Flag["Studs Stand"]:SetVisible(Value)
	        end
	        if Flag["Check Ping Stubs"] then
		        Flag["Check Ping Stubs"]:SetVisible(Value)
	        end
		end
    end
})

TwoTimeGroup:Input({
    Title = t"Studs Run",
    Default = "3.5",
    Flag = "Studs Run",
    Finished = true,
    Numeric = true,
    Visible = false,
    Callback = function(Value)
		_G.RunStubs = tonumber(Value)
    end
})

TwoTimeGroup:Input({
    Title = t"Studs Stand",
    Default = "5.5",
    Flag = "Studs Stand",
    Finished = true,
    Numeric = true,
    Visible = false,
    Callback = function(Value)
		_G.StandStuds = tonumber(Value)
    end
})

TwoTimeGroup:Toggle({
    Title = t"Check Ping Stubs",
    Value = false,
    Flag = "Check Ping Stubs",
    Visible = false,
    Callback = function(Value)
        _G.CheckPing = Value
    end
})

TwoTimeGroup:Toggle({
    Title = t"Auto Backstab",
    Value = false,
    Flag = "Auto Backstab",
    Callback = function(Value)
        _G.AutoBackstab = Value
    end
})

local Guest1337Group = SurvivorsRight:GroupBox({
    Title = t"Guest 1337",
})

Guest1337Group:Slider({
    Title = t"Detection Range Block",
    Min = 0,
    Max = 50,
    Value = 18,
    Increment = 1,
    Flag = "Detection Range Block",
    Callback = function(Value)
        _G.DetectionRangeGuest = Value
    end
})

Guest1337Group:Toggle({
    Title = t"Auto Block (Sound)",
    Value = false,
    Flag = "Auto Block (Sound)",
    Callback = function(Value)
        _G.AutoBlockSound = Value
    end
})

Guest1337Group:Toggle({
    Title = t"Auto Block (Animation)",
    Value = false,
    Flag = "Auto Block (Animation)",
    Callback = function(Value)
        _G.AutoBlockAnimation = Value
    end
})

Guest1337Group:Toggle({
    Title = t"Facing Direction",
    Value = false,
    Flag = "Facing Direction",
    Callback = function(Value)
        _G.FacingDirection = Value
    end
})

Guest1337Group:Toggle({
    Title = t"Show Hitbox Range",
    Value = false,
    Flag = "Show Hitbox Range",
    Callback = function(Value)
        _G.ShowHBRange = Value
    end
})

Guest1337Group:Slider({
    Title = t"Detection Range Punch",
    Min = 0,
    Max = 50,
    Value = 15,
    Increment = 1,
    Flag = "Detection Punch",
    Callback = function(Value)
        _G.DetectionRangePunch = Value
    end
})

Guest1337Group:Slider({
    Title = t"Sharpness Punch",
    Min = 0,
    Max = 5,
    Value = 1,
    Increment = 1,
    Flag = "Sharpness Punch",
    Callback = function(Value)
        _G.SharpnessPunch = Value
    end
})

Guest1337Group:Toggle({
    Title = t"Auto Punch",
    Value = false,
    Flag = "Auto Punch",
    Callback = function(Value)
        _G.AutoPunch = Value
        if Flag and Flag["Punch in block success"] then
	        Flag["Punch in block success"]:SetVisible(_G.AutoPunch)
        end
    end
})

Guest1337Group:Toggle({
    Title = t"Aimbot Punch",
    Value = false,
    Flag = "Aimbot Punch",
    Callback = function(Value)
        _G.AimbotPunch = Value
    end
})

Guest1337Group:Toggle({
    Title = t"Punch in block success",
    Value = false,
    Visible = false,
    Flag = "Punch in block success",
    Callback = function(Value)
        _G.PunchChange = Value
    end
})

local JaneDoeGroup = SurvivorsLeft:GroupBox({
    Title = t"Jane Doe",
})

JaneDoeGroup:Dropdown({
    Title = t"Mode Jane Doe",
    Options = {"Logic", "Teleport", "Normal"},
    Default = "Logic",
    Flag = "Mode Jane Doe",
    Callback = function(Value)
        _G.ModeJaneDoe = Value
    end
})

JaneDoeGroup:Toggle({
    Title = t"Auto Axe",
    Value = false,
    Flag = "Auto Axe",
    Callback = function(Value)
        _G.AutoAxe = Value
        if Flag and Flag["Axe in change"] then
	        Flag["Axe in change"]:SetVisible(Value)
        end
    end
})

JaneDoeGroup:Toggle({
    Title = t"Axe in change",
    Value = false,
    Visible = false,
    Flag = "Axe in change",
    Callback = function(Value)
        _G.ChangeingAxe = Value
    end
})

JaneDoeGroup:Slider({
    Title = t"Detection Range Axe",
    Min = 5,
    Max = 20,
    Value = 18,
    Increment = 1,
    Flag = "Detection Range Axe",
    Callback = function(Value)
        _G.DetectionRangeAxe = Value
    end
})

JaneDoeGroup:Slider({
    Title = t"Sharpness Axe",
    Min = 0,
    Max = 5,
    Value = 1,
    Increment = 1,
    Flag = "Sharpness Axe",
    Callback = function(Value)
        _G.SharpnessAxe = Value
    end
})

JaneDoeGroup:Slider({
    Title = t"Delay Aimbot",
    Min = 0,
    Max = 0.30,
    Value = 0.27,
    Increment = 0.01,
    Visible = false,
    Flag = "Delay Aimbot Jane Doe",
    Callback = function(Value)
        _G.DelayAimbot = Value
    end
})

JaneDoeGroup:Toggle({
    Title = t"Aimbot Axe",
    Value = false,
    Flag = "Aimbot Axe",
    Callback = function(Value)
        _G.AimbotAxe = Value
        if Flag then
			if Flag["Delay Aimbot Jane Doe"] then
		        Flag["Delay Aimbot Jane Doe"]:SetVisible(Value)
			end
			if Flag["Power Axe Aimbot"] then
		        Flag["Power Axe Aimbot"]:SetVisible(Value)
			end
			if Flag["Power Aimbot"] then
		        Flag["Power Aimbot"]:SetVisible(Value)
			end
        end 
    end
})

JaneDoeGroup:Slider({
    Title = t"Power Axe Aimbot",
    Min = 20,
    Max = 200,
    Value = 30,
    Increment = 1,
    Visible = false,
    Flag = "Power Axe Aimbot",
    Callback = function(Value)
        _G.AxePowerAimbot = Value
    end
})

JaneDoeGroup:Toggle({
    Title = t"Power Axe Aimbot",
    Value = false,
    Visible = false,
    Flag = "Power Aimbot",
    Callback = function(Value)
        _G.PowerAxeAimbot = Value
    end
})

local VeeronicaGroup = SurvivorsRight:GroupBox({
    Title = t"Veeronica",
})

VeeronicaGroup:Toggle({
    Title = t"Auto Skateboard",
    Value = false,
    Flag = "Auto Skateboard",
    Callback = function(Value)
        _G.AutoSkateboard = Value
        autoVeeronica(Value)
    end
})

VeeronicaGroup:Toggle({
    Title = t"Anti Objects",
    Value = false,
    Flag = "Anti Objects",
    Callback = function(Value)
        getgenv().Toggle["Block SkateRebound"] = Value
    end
})

local Killers, KillersTabs = Tabs.Killers, Tabs.KillersGroup
local KillersLeft = KillersTabs:Left()
local KillersRight = KillersTabs:Right()

local SlasherGroup = KillersRight:GroupBox({
    Title = t"Slasher",
})

SlasherGroup:Slider({
    Title = t"Detection Range Parry",
    Min = 10,
    Max = 30,
    Value = 18,
    Increment = 1,
    Flag = "Detection Range Parry",
    Callback = function(Value)
        _G.DetectionRangeSlasher = Value
    end
})

SlasherGroup:Toggle({
    Title = t"Auto Parry (Animation)",
    Value = false,
    Flag = "Auto Parry (Animation)",
    Callback = function(Value)
        _G.AutoParryAnimation = Value
    end
})

SlasherGroup:Toggle({
    Title = t"Auto Parry (Sound)",
    Value = false,
    Flag = "Auto Parry (Sound)",
    Callback = function(Value)
        _G.AutoParrySound = Value
    end
})

local JohnDoeGroup = KillersLeft:GroupBox({
    Title = t"John Doe",
})

JohnDoeGroup:Toggle({
    Title = t"Auto 404Error (Animation)",
    Value = false,
    Flag = "Auto 404Error (Animation)",
    Callback = function(Value)
        _G.AutoParryJohnAnimation = Value
    end
})

JohnDoeGroup:Toggle({
    Title = t"Auto 404Error (Sound)",
    Value = false,
    Flag = "Auto 404Error (Sound)",
    Callback = function(Value)
        _G.AutoParryJohnSound = Value
    end
})

JohnDoeGroup:Toggle({
    Title = t"Aimbot Corrupt Energy",
    Value = false,
    Flag = "Aimbot Corrupt Energy",
    Callback = function(Value)
        _G.AimbotCorruptEnergy = Value
        if Flag["Spin Corrupt Energy"] then
	        Flag["Spin Corrupt Energy"]:SetVisible(Value)
        end
    end
})

JohnDoeGroup:Slider({
    Title = t"Delay Aimbot",
    Min = 0,
    Max = 0.7,
    Value = 0.65,
    Increment = 0.01,
    Flag = "Delay Aimbot Corrupt Energy",
    Callback = function(Value)
        _G.DelayAimbotJohnDoe = Value
    end
})

JohnDoeGroup:Slider({
    Title = t"Sharpness Corrupt Energy",
    Min = 0,
    Max = 5,
    Value = 1,
    Increment = 1,
    Flag = "Sharpness Corrupt Energy",
    Callback = function(Value)
        _G.SharpnessCorruptEnergy = Value
    end
})

JohnDoeGroup:Toggle({
    Title = t"Spin Corrupt Energy",
    Value = false,
    Visible = false,
    Flag = "Spin Corrupt Energy",
    Callback = function(Value)
        _G.SpinCorruptEnergy = Value
        if Flag["Speed Spin Corrupt Energy"] then
	        Flag["Speed Spin Corrupt Energy"]:SetVisible(Value)
        end
    end
})

JohnDoeGroup:Slider({
    Title = t"Speed Spin Corrupt Energy",
    Min = 5,
    Max = 45,
    Value = 30,
    Increment = 0.1,
    Visible = false,
    Flag = "Speed Spin Corrupt Energy",
    Callback = function(Value)
        _G.SpeedSpinCorruptEnergy = Value
    end
})

local UISettings = Tabs["UI Settings"]
local UISettingsGroup = UISettings:GroupBox({
    Title = "Translate",
})

UISettingsGroup:Dropdown({
    Title = "Translate",
    Options = {"vn", "en", "sp"},
    Default = "vn",
    Callback = function(Value)
		_G.TranslateScript = Value
    end
})

UISettingsGroup:Button({
    Title = "Set config translate",
    Callback = function()
if makefolder then makefolder("Translate") end
if writefile then 
	writefile("Translate/Forsaken", _G.TranslateScript)
	if readfile then
		local TranslateFile = readfile("Translate/Forsaken")
		if TranslateFile and TranslateFile:lower() == _G.TranslateScript:lower() then
			OrionLib:MakeNotification({Name = "[Set config translate]", Content = "Set config success", Time = 5})
		end
	end
else
	OrionLib:MakeNotification({Name = "[Set config translate]", Content = "Executor not supported writefile", Time = 5})
end
    end
}) 

OrionLib:BuildSettings(UISettings)
local success, err = pcall(function()
	getgenv().WindowNah = Window
	getgenv().CreditToUi = "Orion"
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/File-Script/CreditJoin.Lua"))()
end)

OrionLib:OnDestroy(function()
	_G.AntiLag = nil
	_G.GetOldBright = nil
	for i,v in pairs(workspace:GetDescendants()) do
		RemoveLagTo(v)
	end
	if _G.Connect then
		for i, v in pairs(_G.Connect) do
			if v.Connected then
				v:Disconnect()
			end
		end
	_G.Connect = nil
	end
	if _G.Hookmetamethods then
		for i, v in pairs(_G.Hookmetamethods) do
			if typeof(v) == "function" then
				hookmetamethod(game, "__namecall", v)
			end
		end
	_G.Hookmetamethods = nil
	end
	if Animations then
		Animations = nil
	end
	SetSprintDefault()
end)