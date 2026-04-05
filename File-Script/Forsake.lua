for i, v in pairs({"xeno", "solara", "celery", "nezur", "luna"}) do
    if string.find(identifyexecutor():lower(), v) then
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Executor Waning", Text = "Unfortunately, " .. identifyexecutor() .. " won't be able to run many of the features in the script due to its power, goodluck", Duration = 60})
    end
end

_G.Connect = {}
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

local cam = workspace.CurrentCamera
local player = playerout.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")
local AnimationTrack = hum:FindFirstChildOfClass("Animator") or nil
local playergui = player:WaitForChild("PlayerGui")
local maingui = playergui:WaitForChild("MainUI")

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

MobileOn = table.find({Enum.Platform.Android, Enum.Platform.IOS}, UserInputService:GetPlatform())

if game.CoreGui:FindFirstChild("Cooldown Script") == nil then
local gui = Create("ScreenGui", {Name = "Cooldown Script", IgnoreGuiInset = true, Parent = game.CoreGui})
local ImageLabel = Create("ImageLabel", {
    Size = UDim2.new(0.215, 0, 0.059, 0),
    Position = UDim2.new(1.01, 0, 0.305, -50),
    BackgroundTransparency = 1,
    AnchorPoint = Vector2.new(1, 0),
    Image = "rbxassetid://17253889398",
    ImageColor3 = Color3.fromRGB(255,255,255),
    Visible = false,
    ClipsDescendants = true,
    Parent = gui
}, {
    Create("UIAspectRatioConstraint", {
        AspectRatio = 6.438,
        AspectType = Enum.AspectType.FitWithinMaxSize
    })
})

local FrameBar = Create("Frame", {
    Size = UDim2.new(1, 0, 0.98, 0),
    Position = UDim2.new(0, 0, 0.5, 0),
    BackgroundTransparency = 1,
    AnchorPoint = Vector2.new(0, 0.5),
    ClipsDescendants = true,
    Parent = ImageLabel
}, {
    Create("ImageLabel", {
        Size = UDim2.new(0, 161, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Image = "rbxassetid://17253892073",
        ImageColor3 = Color3.fromRGB(255,255,255),
        AutoLocalize = true,
        Interactable = true
    })
})

local TextLabel = Create("TextLabel", {
    Size = UDim2.new(1, 0, 1, 0),
    Position = UDim2.new(0, 0, 0, 0),
    TextScaled = true,
    Text = "",
    Rotation = 15,
    TextColor3 = Color3.fromRGB(255,255,255),
    BackgroundTransparency = 1,
    Font = Enum.Font.FredokaOne,
    ZIndex = 2,
    Parent = ImageLabel
}, {
    Create("UIPadding", {
        PaddingBottom = UDim.new(0.15, 0),
        PaddingLeft = UDim.new(0.05, 0),
        PaddingRight = UDim.new(0.05, 0),
        PaddingTop = UDim.new(0.15, 0),
    }),
    Create("UIStroke", {
        Thickness = 0.84,
        StrokeSizingMode = Enum.StrokeSizingMode.FixedSize,
        Color = Color3.new(0, 0, 0)
    })
})
end

function SpringText(label, startRotation)
	local rotation = startRotation or 10
	local velocity = 0
	local target = 0
	local stiffness = 169
	local damping = 8
	local conn
	conn = game:GetService("RunService").Heartbeat:Connect(function(dt)
		velocity += (target - rotation) * stiffness * dt
		velocity *= math.exp(-damping * dt)
		rotation += velocity * dt
		label.Rotation = rotation
		if math.abs(rotation) < 0.01 and math.abs(velocity) < 0.01 then
			label.Rotation = 0
			conn:Disconnect()
		end
	end)
end

function Cooldown(time, text, call)
	if game.CoreGui:FindFirstChild("Cooldown Script") then
		if game.CoreGui["Cooldown Script"].ImageLabel.Visible then return end
		spawn(function()
			local BarTween = TweenService:Create(game.CoreGui["Cooldown Script"].ImageLabel.Frame, TweenInfo.new(time, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Size = UDim2.new(0.001, 0, 0.98, 0)})
			BarTween:Play()
			BarTween.Completed:Wait()
			pcall(call)
			game.CoreGui["Cooldown Script"].ImageLabel.Visible = false
			game.CoreGui["Cooldown Script"].ImageLabel.Frame.Size = UDim2.new(1, 0, 0.98, 0)
			game.CoreGui["Cooldown Script"].ImageLabel.TextLabel.Rotation = 15
			TweenService:Create(game.CoreGui["Cooldown Script"].ImageLabel, TweenInfo.new(0.06, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Position = UDim2.new(1.01, 0, 0.305, -50)}):Play()
		end)
		spawn(function()
			game.CoreGui["Cooldown Script"].ImageLabel.TextLabel.Text = text
			game.CoreGui["Cooldown Script"].ImageLabel.Visible = true
			TweenService:Create(game.CoreGui["Cooldown Script"].ImageLabel, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.98, 0, 0.3, -50)}):Play()
			SpringText(game.CoreGui["Cooldown Script"].ImageLabel.TextLabel, 10)
		end)
	end
end

if game.CoreGui:FindFirstChild("Gui Gen Script") == nil then
local gui = Create("ScreenGui", {Name = "Gui Gen Script", Enabled = false, Parent = game.CoreGui})
local Frame = Create("Frame", {
    Name = "UAbilityFrame",
    Size = UDim2.new(0.3, 0, 0.5, 0),
    Position = UDim2.new(0.65, 0, 0.5, 0),
    BackgroundTransparency = 1,
    ZIndex = 1,
    Parent = gui
})

local FrameB = Create("ImageButton", {
    Name = "ButtonU",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Size = UDim2.new(0.45, 0, 0.45, 0),
    Position = UDim2.new(0.7, -25, -0.25, -25),
    BackgroundTransparency = 1,
    ZIndex = 1,
    Draggable = true,
    Parent = Frame
}, {
    Create("UIAspectRatioConstraint", {
        AspectType = Enum.AspectType.FitWithinMaxSize,
        AspectRatio = 1,
        DominantAxis = "Width"
    })
})

local UButton = Create("ImageLabel", {
    Name = "UButton",
    Position = UDim2.new(0.175, 0, 0.175, 0),
    Size = UDim2.new(0.65, 0, 0.65, 0),
    BackgroundTransparency = 1,
    Image = "rbxassetid://82648533253503",
    ImageColor3 = Color3.fromRGB(255, 255, 255),
    ZIndex = 1,
    Parent = FrameB
})

local DefaultSize = FrameB.Size
local function PlayHoverSound(id)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://"..id
    sound.Volume = 2
    sound.PlaybackSpeed = 1
    sound.Parent = workspace
    sound:Play()
    game:GetService("Debris"):AddItem(sound, 2)
end

FrameB.MouseEnter:Connect(function()
    PlayHoverSound(10066942189)
    TweenService:Create(UButton, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        ImageColor3 = Color3.fromRGB(115, 115, 115),
    }):Play()
end)

FrameB.MouseLeave:Connect(function()
    TweenService:Create(UButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ImageColor3 = Color3.fromRGB(255, 255, 255)
    }):Play()
end)

FrameB.MouseButton1Click:Connect(function()
	PlayHoverSound(10066936758)
	UButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
	TweenService:Create(FrameB, TweenInfo.new(0.035, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = DefaultSize + UDim2.fromScale(0.1, 0.1),
    }):Play()
    TweenService:Create(FrameB, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = DefaultSize
    }):Play()
	if GenStart then return end
	GenStart = true
	if not _G.AutoGeneralFarmGet and playergui:FindFirstChild("PuzzleUI") then
		if workspace.Map.Ingame:FindFirstChild("Map") then
			for i, v in ipairs(workspace.Map.Ingame:FindFirstChild("Map"):GetChildren()) do
				if v.Name == "Generator" and v:FindFirstChild("Remotes") and v.Remotes:FindFirstChild("RE") and v:FindFirstChild("Progress").Value ~= 100 then
					v.Remotes:FindFirstChild("RE"):FireServer()
				end
			end
		end
	end
	if _G.AutoGeneralFarmGet or not playergui:FindFirstChild("PuzzleUI") then
		Cooldown(0.1, "Skip Gen Script", function()
	        GenStart = false
	    end)
	else
		Cooldown(3.4, "Skip Gen Script", function()
			GenStart = false
		end)
	end
end)
end

if not game.CoreGui:FindFirstChild("Keybind Script") then
local gui = Create("ScreenGui", {Name = "Keybind Script", Enabled = false, IgnoreGuiInset = true, Parent = game.CoreGui})
local Frame = Create("Frame", {
    Size = UDim2.new(0.198, 0, 0.094, 0),
    Position = UDim2.new(0.98, 0, 0.6, -50),
    BackgroundTransparency = 1,
    AnchorPoint = Vector2.new(1, 0),
    Visible = true,
    Parent = gui
}, {
    Create("UIAspectRatioConstraint", {
        AspectRatio = 6.07,
        AspectType = Enum.AspectType.FitWithinMaxSize
    }),
	Create("UIListLayout", {
        Padding = Vector2.new(0.25, 0),
		SortOrder = "LayoutOrder",
		VerticalAlignment = "Bottom",
    })
})

local Button = Create("Frame", {
    Size = UDim2.new(1, 0, 1, 0),
    Position = UDim2.new(0, 0, 0, 0),
    BackgroundTransparency = 1,
    AnchorPoint = Vector2.new(1, 0),
    Visible = true,
    Parent = Frame
})

local Folder = Create("Folder", {Parent = Button}, {
	Create("TextLabel", {
	    Size = UDim2.new(0.167, 0, 0.759, 0),
	    Position = UDim2.new(0.051, 0, 0.001, 0),
	    BackgroundTransparency = 1,
		TextColor3 = Color3.new(255,255,255),
		Font = "FredokaOne",
		Text = "U",
		TextScaled = true,
		ZIndex = 2,
	    Visible = true
	}, {
		Create("UIStroke", {
		    Thickness = 1.296
		})
	})
})

local ButtonTop = Create("ImageLabel", {
	Size = UDim2.new(0.17, 0, 1, 0),
    Position = UDim2.new(0.049, 0, -0.054, 0),
    BackgroundTransparency = 1,
    Image = "rbxassetid://132237752209803",
    ImageColor3 = Color3.fromRGB(47,47,47),
	Parent = Button
}, {
	Create("ImageLabel", {
		Size = UDim2.new(0.9, 0, 0.9, 0),
	    Position = UDim2.new(0.5, 0, 0, 0),
	    BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0),
	    Image = "rbxassetid://94740529495833",
	    ImageColor3 = Color3.fromRGB(84,84,84),
	})
})

local ButtonName = Create("TextLabel", {
	Size = UDim2.new(0.703, 0, 0.619, 0),
    Position = UDim2.new(0.288, 0, 0.055, 0),
    BackgroundTransparency = 1,
	TextColor3 = Color3.new(255,255,255),
	Font = "FredokaOne",
	Text = "Skip Generator",
	TextScaled = true,
    Visible = true,
	Parent = Button
}, {
	Create("UIStroke", {
	    Thickness = 1.232
	})
})

local textLabel = Folder:FindFirstChildOfClass("TextLabel")
local innerImage = ButtonTop:FindFirstChildOfClass("ImageLabel")
local TweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
table.insert(_G.ConnectFun, UserInputService.InputEnded:Connect(function(input, gameProcessed)
	if input.KeyCode == Enum.KeyCode.U then
		TweenService:Create(textLabel, TweenInfo, {Position = UDim2.new(0.051,0,0.001,0)}):Play()
		TweenService:Create(innerImage, TweenInfo, {Position = UDim2.new(0.5,0,0,0), ImageColor3 = Color3.fromRGB(84,84,84)}):Play()
	end
end))

table.insert(_G.ConnectFun, UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if (game.CoreGui:FindFirstChild("Keybind Script") and not game.CoreGui:FindFirstChild("Keybind Script").Enabled) or (game.CoreGui:FindFirstChild("Gui Gen Script") and not game.CoreGui:FindFirstChild("Gui Gen Script").Enabled) then return end
	if input.KeyCode == Enum.KeyCode.U then
		TweenService:Create(textLabel, TweenInfo, {Position = UDim2.new(0.05,0,0.001,3)}):Play()
		TweenService:Create(innerImage, TweenInfo, {Position = UDim2.new(0.5,0,0,4), ImageColor3 = Color3.fromRGB(122,122,122)}):Play()
		if GenStart then return end
		GenStart = true
		if not _G.AutoGeneralFarmGet and playergui:FindFirstChild("PuzzleUI") then
			if workspace.Map.Ingame:FindFirstChild("Map") then
				for i, v in ipairs(workspace.Map.Ingame:FindFirstChild("Map"):GetChildren()) do
					if v.Name == "Generator" and v:FindFirstChild("Remotes") and v.Remotes:FindFirstChild("RE") and v:FindFirstChild("Progress").Value ~= 100 then
						v.Remotes:FindFirstChild("RE"):FireServer()
					end
				end
			end
		end
		if _G.AutoGeneralFarmGet or not playergui:FindFirstChild("PuzzleUI") then
			Cooldown(0.1, "Skip Gen Script", function()
		        GenStart = false
		    end)
		else
			Cooldown(3.4, "Skip Gen Script", function()
				GenStart = false
			end)
		end
	end
end))
end
function ShowButtonU(show)
	if MobileOn then
		if game.CoreGui:FindFirstChild("Gui Gen Script") then
			game.CoreGui:FindFirstChild("Gui Gen Script").Enabled = show
		end
	else
		if game.CoreGui:FindFirstChild("Keybind Script") then
			game.CoreGui:FindFirstChild("Keybind Script").Enabled = show
		end
	end
end

spawn(function()
	while true do
		char = player.Character or nil
		root = (char and char:FindFirstChild("HumanoidRootPart")) or nil
		hum = (char and char:FindFirstChild("Humanoid")) or nil
		AnimationTrack = (hum and hum:FindFirstChildOfClass("Animator")) or nil
		if not Remote then
			Remote = (Storage and Storage:FindFirstChild("RemoteEvent", true)) or nil
		end
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
table.insert(_G.ConnectFun, game.DescendantAdded:Connect(function(v)
	RemoveLagTo(v)
end))

function charAb(s)
	return string.char(3, (#s), 0, 0, 0)..s
end

getgenv()._VoidRushBypass = false
getgenv()._WalkspeedOverrideBypass = false
getgenv()._AntiFootsteps = false
getgenv()._ChangeGuest = false

if not getgenv()._oldFireServer and hookmetamethod and getnamecallmethod then
    local old
    old = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        if self == Remote and method == "FireServer" then
            if getgenv()._BlockSkateRebound and tostring(args[1]) == player.Name.."SkateRebound" then
	            return nil
	        end
			if getgenv()._ChangeGuest and tostring(args[1]) == player.Name.."Guest1337Collision" then
				return nil
			end
			if getgenv()._WalkspeedOverrideBypass and tostring(args[1]) == player.Name.."C00lkiddCollision" then
				return nil
			end
			if getgenv()._VoidRushBypass and tostring(args[1]) == player.Name.."VoidRushCollision" then
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
	    ["126830014841198"] = true, ["126355327951215"] = true, ["121086746534252"] = true, ["18885909645"] = true, ["87989533095285"] = true,
	    ["98456918873918"] = true, ["105458270463374"] = true, ["83829782357897"] = true, ["125403313786645"] = true, ["79980897195554"] = true,
	    ["118298475669935"] = true, ["82113744478546"] = true, ["70371667919898"] = true, ["99135633258223"] = true, ["119583605486352"] = true,
	    ["97167027849946"] = true, ["109230267448394"] = true, ["139835501033932"] = true, ["126896426760253"] = true, ["109667959938617"] = true,
	    ["126681776859538"] = true, ["129976080405072"] = true, ["121293883585738"] = true, ["90819435118493"] = true, ["81639435858902"] = true,
	    ["137314737492715"] = true, ["92173139187970"] = true, ["122709416391891"] = true, ["139309647473555"] = true, ["128414736976503"] = true,
	    ["118681146051975"] = true, ["106538427162796"] = true, ["127172483138092"] = true, ["89004992452376"] = true, ["118250546180773"] = true,
	    ["131406927389838"] = true, ["136406635725343"] = true, ["89315669689903"] = true, ["140659146085461"] = true, ["99863365142863"] = true,
	    ["90620531468240"] = true, ["108907358619313"] = true, ["88582935528044"] = true, ["94958041603347"] = true, ["131642454238375"] = true,
	    ["110702884830060"] = true, ["91509234639766"] = true, ["94634594529334"] = true, ["91758760621955"] = true, ["77375846492436"] = true,
	    ["119462383658044"] = true, ["110153465553223"] = true, ["126171487400618"] = true, ["18885919947"] = true, ["70447634862911"] = true,
	    ["71685573690338"] = true, ["134020762419760"] = true, ["85960461320564"] = true, ["82113036350227"] = true, ["88451353906104"] = true,
	    ["123345437821399"] = true, ["123019923277556"] = true, ["137679730950847"] = true, ["81299297965542"] = true, ["99824350842479"] = true,
		["109486609489179"] = true, ["132243194360714"] = true, ["114506382930939"] = true, ["93841120533318"] = true, ["76312020299624"] = true,
		["91509234639766"] = true, ["92567970681901"] = true, ["88970503168421"] = true,
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
		"123019923277556", "137679730950847", "81299297965542", "114506382930939", "88970503168421",
	},
	["Aimbot Pizza"] = {
		"114155003741146", "104033348426533"
	},
	["Aimbot Push"] = {
		"87259391926321", "140703210927645", "136007065400978", "136007065400978",
		"129843313690921", "129843313690921", "86709774283672", "129843313690921",
		"129843313690921", "108807732150251", "138040001965654", "86096387000557",
		"86096387000557", "111918351126361", "81227838714974", "79331370895011",
		"127821549546951"
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
	["Aura Hit"] = {},
	["Aimbot Shedletsky"] = {}
}

AutoSoundBlock = {
	["102228729296384"] = true,
    ["140242176732868"] = true,
    ["112809109188560"] = true,
    ["136323728355613"] = true,
    ["115026634746636"] = true,
    ["84116622032112"] = true,
    ["108907358619313"] = true,
    ["127793641088496"] = true,
    ["86174610237192"] = true,
    ["95079963655241"] = true,
    ["101199185291628"] = true,
    ["119942598489800"] = true,
    ["84307400688050"] = true,
    ["113037804008732"] = true,
    ["105200830849301"] = true,
    ["75330693422988"] = true,
    ["82221759983649"] = true,
    ["81702359653578"] = true,
    ["108610718831698"] = true,
    ["112395455254818"] = true,
    ["109431876587852"] = true,
    ["109348678063422"] = true,
    ["85853080745515"] = true,
    ["12222216"] = true,
    ["131406927389838"] = true,
    ["136406635725343"] = true,
    ["89315669689903"] = true,
    ["71090513459907"] = true,
    ["105840448036441"] = true,
    ["114742322778642"] = true,
    ["119583605486352"] = true,
    ["79980897195554"] = true,
    ["71805956520207"] = true,
    ["79391273191671"] = true,
    ["89004992452376"] = true,
    ["101553872555606"] = true,
    ["101698569375359"] = true,
    ["106300477136129"] = true,
    ["116581754553533"] = true,
    ["117231507259853"] = true,
    ["119089145505438"] = true,
    ["121954639447247"] = true,
    ["125213046326879"] = true,
    ["131406927389838"] = true,
    ["90819435118493"] = true,
    ["119583605486352"] = true,
    ["79980897195554"] = true,
    ["119583605486352"] = true,
    ["78298577002481"] = true,
    ["71834552297085"] = true,
}
AutoErrorTriggerSounds = {
    ["86710781315432"] = true,
    ["99820161736138"] = true,
    ["609342351"] = true,
    ["81976396729343"] = true,
    ["12222225"] = true,
    ["80521472651047"] = true,
    ["139012439429121"] = true,
    ["91194698358028"] = true,
    ["111910850942168"] = true,
    ["83851356262523"] = true
}

spawn(function()
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

	for _, v in ipairs(Storage.Assets:GetDescendants()) do
		if v:IsA("ModuleScript") and v.Name == "Config" then
			local success, RequireGet = requireConfig(v, 0)
			if not success then continue end
			if type(RequireGet) ~= "table" then continue end
			if not RequireGet.Animations then continue end
			local AnimationTo = RequireGet.Animations
			if v.Parent and v.Parent.Parent and v.Parent.Parent.Parent and v.Parent.Parent.Parent.Name:lower():find("killer") then
				for name, anim in pairs(AnimationTo) do
					if type(name) == "string" then
						if name:find("Cry") or name:find("Stab") or name:find("Attack") or name:find("Slash") or name:find("WalkspeedOverrideStart") or name:find("WalkspeedOverrideLoop") then
							ScanForAssetIds(Animations.KillerAnima, anim, {ListTrue = true})
							ScanForAssetIds(Animations["Hitbox Reach"], anim)
						end
					end
				end
				if AnimationTo.VoidRush then
					local vr = AnimationTo.VoidRush
					for name, anim in pairs(vr) do
						if type(name) == "string" then
							if name:find("LoopCharge") then
								ScanForAssetIds(Animations.KillerAnima, anim, {ListTrue = true})
								ScanForAssetIds(Animations["Hitbox Reach"], anim)
							end
						end
					end
				end
				if RequireGet.Sounds then
					local SoundKillerTo = RequireGet.Sounds
					for name, sound in pairs(SoundKillerTo) do
						if type(name) == "string" then
							if name:find("Hit") or name:find("Swing") or name:find("VoidRushLoop") or name:find("WalkspeedOverrideLoop") or name:find("AscentTransform") then
								ScanForAssetIds(AutoSoundBlock, sound, {ListTrue = true})
							end
						end
					end
				end
			end
			if v.Parent and v.Parent.Parent and v.Parent.Parent.Parent and v.Parent.Parent.Parent.Name:lower():find("survivors") then
				for name, anim in pairs(AnimationTo) do
					if type(name) == "string" then
						if name:find("Block") then
							ScanForAssetIds(Animations["Aura Hit"], anim)
							ScanForAssetIds(Animations["Hitbox Reach"], anim)
						end
						if name:find("Punch") or name:find("ParryPunch") or name:find("Axe") then
							ScanForAssetIds(Animations["Aimbot Push"], anim)
							ScanForAssetIds(Animations["Hitbox Reach"], anim)
						end
						if name:find("ThrowPizza") then
							ScanForAssetIds(Animations["Aimbot Pizza"], anim)
						end
						if name:find("Slash") then
							ScanForAssetIds(Animations["Aimbot Shedletsky"], anim)
						end
					end
				end
				if RequireGet and RequireGet.Sounds then
					local SoundTo = RequireGet.Sounds
					for name, sound in pairs(SoundTo) do
						if type(name) == "string" then
							if name:find("Hit") or name:find("Punch") or name:find("Parry") or name:find("Slash") or name:find("Draw") or name:find("DefaultHit") then
								ScanForAssetIds(AutoErrorTriggerSounds, sound, {ListTrue = true})
							end
						end
					end
				end
			end
		end
	end
end)

function Aimbot(target, prediction)
	local direction = ((target.Position + (target.CFrame.LookVector * prediction)) - root.Position).Unit
	root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, math.atan2(-direction.X, -direction.Z), 0)
end
function AimbotCam(target, prediction)
	local direction = ((target.Position + (target.CFrame.LookVector * prediction)) - root.Position).Unit
    cam.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, math.atan2(-direction.X, -direction.Z), 0)
end
function BehindTarget(hrp, targetHRP)
    local distance = Distance(targetHRP.Position)
    if distance > (_G.DetectionRangeTwoTime or 9) then return false end
    if mode == "Around" then
        return true
    else
        local direction = -targetHRP.CFrame.LookVector
        local toPlayer = (root.Position - targetHRP.Position)
        return toPlayer:Dot(direction) > 0.3
    end
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
	local container = maingui and maingui:FindFirstChild("AbilityContainer")
	if not container then return end
	local function canUse(name)
		local ab = container:FindFirstChild(name)
		return ab and ab:FindFirstChild("CooldownTime") and ab.CooldownTime.Text == ""
	end
	local abilities = {"Slash", "Punch", "Stab", "Carving Slash"}
	for _, v in ipairs(abilities) do
		if canUse(v) then
			Remote:FireServer("UseActorAbility", {buffer.fromstring(charAb(name))})
			break
		end
	end
end

local function GetBasePartFromSound(sound)
	local obj = sound
	while obj and not obj:IsA("BasePart") do
		obj = obj.Parent
	end
	return obj
end

local runningSounds = {}
function FoundSound(sound)
	if not sound or not sound:IsA("Sound") then return end
	local charName = char and char.Name:lower()
	if not charName or not (charName:find("johndoe") or charName:find("slasher")) then return end
	if not (_G.AutoParryError or _G.AutoParrySlash) then return end
	local BasePartSound = GetBasePartFromSound(sound)
	if not BasePartSound then return end
	local soundIdNumber = tostring(sound.SoundId):match("%d+")
	if not (soundIdNumber and AutoErrorTriggerSounds[soundIdNumber]) then return end
	if runningSounds[sound] then return end
	runningSounds[sound] = true
	task.spawn(function()
		while sound and sound.Parent and sound.Playing do
			if root and Distance2(BasePartSound.Position) <= (_G.DistanceCheck or 20) then
				if _G.AutoParryError and charName:find("johndoe") then
					Remote:FireServer("UseActorAbility", {buffer.fromstring(charAb("404Error"))})
				end
				if _G.AutoParrySlash and charName:find("slasher") then
					Remote:FireServer("UseActorAbility", {buffer.fromstring(charAb("RagingPace"))})
				end
				break
			end
			task.wait()
		end
		runningSounds[sound] = nil
	end)
end

function PlayingSound(sound)
	if not sound or not sound:IsA("Sound") then return end
	sound.Played:Connect(function()
		FoundSound(sound)
	end)
	if sound.Playing then
		FoundSound(sound)
	end
end

local function isNeighbour(r1, c1, r2, c2)
    return (r2 == r1 - 1 and c2 == c1) or (r2 == r1 + 1 and c2 == c1) or (r2 == r1 and c2 == c1 - 1) or (r2 == r1 and c2 == c1 + 1)
end
local function key(n) return n.row .. "-" .. n.col end
local function orderPath(path, endpoints)
    if not path or #path == 0 then return path end
    local start = endpoints and endpoints[1] or path[1]
    local pool = {}
    for _, n in ipairs(path) do pool[key(n)] = {row = n.row, col = n.col} end
    local ordered = {}
    local cur = {row = start.row, col = start.col}
    table.insert(ordered, cur)
    pool[key(cur)] = nil
    while next(pool) do
        local found = false
        for k, n in pairs(pool) do
            if isNeighbour(cur.row, cur.col, n.row, n.col) then
                table.insert(ordered, n)
                pool[k] = nil
                cur = n
                found = true
                break
            end
        end
        if not found then break end
    end
    return ordered
end

local HintSystem = {}
function HintSystem:Draw(puzzle)
    if not puzzle or not puzzle.Solution then return end
    for i = 1, #puzzle.Solution do
        local path = puzzle.Solution[i]
        local ends = puzzle.targetPairs[i]
        local ordered = orderPath(path, ends)
        puzzle.paths[i] = {}
        for _, node in ipairs(ordered) do
            if not _G.AutoGen then return end
            table.insert(puzzle.paths[i], {row = node.row, col = node.col})
            puzzle:updateGui()
            task.wait(_G.SpeedAutoGen or 0.08)
        end
        puzzle:checkForWin()
    end
end

local function hookAutoGen()
    if hookedGen then return end
    local mod = Storage:FindFirstChild("FlowGame", true)
    FlowGameModule = require(mod)
    oldNew = oldNew or FlowGameModule.new
    FlowGameModule.new = function(...)
        local puzzle = oldNew(...)
        task.spawn(function()
            if _G.AutoGen then 
				HintSystem:Draw(puzzle)
			end
        end)
        return puzzle
    end
    hookedGen = true
end
hookAutoGen()

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
table.insert(_G.Connect, RunService.Heartbeat:Connect(function()
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
if _G.AutoParryError or _G.AutoParrySlash then
	local charName = char.Name:lower()
	if charName:find("johndoe") or charName:find("slasher") then
		local maxDistance = _G.DistanceParry or 18
		for _, v in ipairs(playerout:GetPlayers()) do
			if v ~= player and v.Character then
				local hrp = v.Character:FindFirstChild("HumanoidRootPart")
				if hrp then
					local distance = Distance2(hrp.Position)
					if distance <= maxDistance then
						local sound = hrp:FindFirstChildOfClass("Sound")
						if sound and sound.IsPlaying then
							local soundIdNumber = tostring(sound.SoundId):match("%d+")
							if soundIdNumber and table.find(AutoErrorTriggerSounds, soundIdNumber) then
								if _G.AutoParryError then
									if charName:find("johndoe") then
										Remote:FireServer("UseActorAbility", {buffer.fromstring(charAb("404Error"))})
									end
								end
								if _G.AutoParrySlash then
									if charName:find("slasher") then
										Remote:FireServer("UseActorAbility", {buffer.fromstring(charAb("RagingPace"))})
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
if char and char.Name:lower():find("slash") then
	if root and root:FindFirstChildOfClass("LinearVelocity") then
		root:FindFirstChildOfClass("LinearVelocity").Enabled = false
		if Toggles["Aimbot Behead"] and Toggles["Aimbot Behead"].Value then
			local targetSur = ClosestSurvivor()
			if targetSur then
		        local dir = targetSur.HumanoidRootPart.Position - root.Position
		        local horizontal = Vector3.new(dir.X, 0, dir.Z)
		        if horizontal.Magnitude > 0.1 then
		            root.CFrame = CFrame.new(root.Position, Vector3.new(targetSur.HumanoidRootPart.Position.X, root.Position.Y, targetSur.HumanoidRootPart.Position.Z))
		            root.AssemblyLinearVelocity = horizontal.Unit * 50
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
		local HitNow = false
		local Aura = SurviveTarget(_G.DetectionRangeAura or 7)
		if Aura then
			if Aura.Parent and Aura.Parent.Name:lower():find("guest") then
				local humplr = Aura.Parent:FindFirstChildOfClass("Humanoid")
				local animTracksPlr = humplr and humplr:FindFirstChildOfClass("Animator") and humplr:FindFirstChildOfClass("Animator"):GetPlayingAnimationTracks()
				for _, v in ipairs(animTracksPlr or {}) do
			        if tostring(v.Animation.AnimationId):match("%d+"):find(Animations["Aura Hit"]) then
						if not v.Playing then
							HitNow = true
						end
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
if Toggles["Auto Shedletsky"] and Toggles["Auto Shedletsky"].Value then
	if char and char.Name:lower():find("shedletsky") then
		local SlashShedletsky = maingui and maingui:FindFirstChild("AbilityContainer") and maingui.AbilityContainer:FindFirstChild("Slash")
	    local cooldown = SlashShedletsky and SlashShedletsky:FindFirstChild("CooldownTime")
		local NoChanges = SlashShedletsky and SlashShedletsky:FindFirstChild("NoChanges")
		
		if not NoChanges and cooldown.Text == "" then
			local targetKill = KillerTarget()
			if targetKill and Distance(targetKill.Position) <= (Options["Detection Range Shedletsky"].Value or 7) then
				Remote:FireServer("UseActorAbility", {buffer.fromstring(charAb("Slash"))})
				delay(0.45, function()
					if Toggles["Auto Slash TP"] and Toggles["Auto Slash TP"].Value then
						root.CFrame = targetKill.CFrame * CFrame.new(0, 0, 5)
					end
				end)
			end
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
			if Toggles["Aimbot Shedletsky"] and Toggles["Aimbot Shedletsky"].Value then
				if table.find(Animations["Aimbot Shedletsky"], tostring(v.Animation.AnimationId):match("%d+")) then
					RootWhat()
			        if targetKill then
			            Aimbot(targetKill, 0.1)
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
	    end
	end
end
end))

table.insert(_G.Connect, RunService.Heartbeat:Connect(function()
	if Toggles["Two Time Teleport"] and Toggles["Two Time Teleport"].Value then
		if AutoRotate and hum then
	        hum.AutoRotate = AutoRotate
	        AutoRotate = nil
	    end
		if root then
			local Dagger = maingui and maingui:FindFirstChild("AbilityContainer") and maingui.AbilityContainer:FindFirstChild("Dagger")
		    local cooldown = Dagger and Dagger:FindFirstChild("CooldownTime")
			local NoChanges = Dagger and Dagger:FindFirstChild("NoChanges")
			if cooldown and cooldown.Text == "" and not NoChanges then
				local targetKill = KillerTarget()
				if targetKill and Distance2(targetKill.Position) <= (_G.DetectionRangeTwoTime or 9) then
					local ModeTime = Options["Mode Two Time"].Value
					if BehindTarget(root, targetKill) then
						RootWhat()
		                cooldown = true
		                local start = tick()
		                local didDagger = false
		                local runingconnection
						runingconnection = RunService.Heartbeat:Connect(function()
		                    if not (char and char.Parent and targetKill) then
		                        if runingconnection then runingconnection:Disconnect() end
		                        return
		                    end
							if cooldown and tonumber(cooldown.Text) and NoChanges then
								if runingconnection then runingconnection:Disconnect() end
		                        return
		                    end
		                    local timetick = tick() - start
		                    if timetick >= 0.5 then
		                        if runingconnection then runingconnection:Disconnect() end
		                        return
		                    end
		                    local ping = tonumber(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString():match("%d+")) or 50
		                    local moveDir = targetKill.Velocity.Magnitude > 0.1 and targetKill.Velocity.Unit or Vector3.new()
		                    local pingOffset = moveDir * (ping / 1000 * targetKill.Velocity.Magnitude)
		                    local predictedPos = targetKill.Position + pingOffset
		                    local targetPos
		                    if ModeTime == "Behind" then
		                        targetPos = predictedPos - (targetKill.CFrame.LookVector * 0.3)
		                    elseif ModeTime == "Around" then
		                        local lookVec = targetKill.CFrame.LookVector
		                        local rightVec = targetKill.CFrame.RightVector
		                        local lateralSpeed = killerVelocity:Dot(rightVec)
		                        local baseOffset = (Distance(targetKill.Position) > 0.1) and (root.Position - targetKill.Position).Unit * 0.3 or Vector3.new()
		                        local lateralOffset = rightVec * lateralSpeed * 0.3
		
		                        targetPos = predictedPos + baseOffset + lateralOffset
		                    end
		                    root.CFrame = CFrame.new(targetPos, targetPos + targetKill.CFrame.LookVector)
		                    if not didDagger then
		                        didDagger = true
		                        local faceStart = tick()
		                        local faceConn
		                        faceConn = RunService.Heartbeat:Connect(function()
		                            if tick() - faceStart >= 0.7 or not targetKill or not targetKill.Parent then
		                                if faceConn then faceConn:Disconnect() end
		                                return
		                            end
									if cooldown and tonumber(cooldown.Text) and NoChanges then
										if faceConn then faceConn:Disconnect() end
				                        return
				                    end
		                            local livePing = tonumber(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString():match("%d+")) or 50
		                            local liveMoveDir = targetKill.Velocity.Magnitude > 0.1 and targetKill.Velocity.Unit or Vector3.new()
		                            local livePingOffset = liveMoveDir * (livePing / 1000 * targetKill.Velocity.Magnitude)
		                            local livePredictedPos = targetKill.Position + livePingOffset
		                            local liveTargetPos
		                            if ModeTime == "Behind" then
		                                liveTargetPos = livePredictedPos - (targetKill.CFrame.LookVector * 0.3)
		                            elseif ModeTime == "Around" then
		                                local lookVec = targetKill.CFrame.LookVector
				                        local rightVec = targetKill.CFrame.RightVector
				                        local lateralSpeed = killerVelocity:Dot(rightVec)
				                        local baseOffset = (Distance(targetKill.Position) > 0.1) and (root.Position - targetKill.Position).Unit * 0.3 or Vector3.new()
				                        local lateralOffset = rightVec * lateralSpeed * 0.3
		                                liveTargetPos = livePredictedPos + baseOffset + lateralOffset
		                            end
		                            root.CFrame = CFrame.new(liveTargetPos, liveTargetPos + targetKill.CFrame.LookVector)
		                        end)
								Remote:FireServer("UseActorAbility", {buffer.fromstring(charAb("Dagger"))})
		                    end
		                end)
		                task.delay(2, function()
		                    RunService.Heartbeat:Wait()
		                    while BehindTarget(root, targetKill) do
		                        RunService.Heartbeat:Wait()
		                    end
		                    cooldown = false
							if runingconnection then runingconnection:Disconnect() end
							if faceConn then faceConn:Disconnect() end
		                end)
					end
				end
			end
		end
	end
end))

table.insert(_G.Connect, RunService.RenderStepped:Connect(function()
	if Toggles["Auto Skate Trick"] and Toggles["Auto Skate Trick"].Value then
		for _, v in ipairs(Storage.Assets.Survivors.Veeronica.Behavior:GetDescendants()) do
	        if v:IsA("Highlight") and isHighlightTargetMe(v) then
	            Jumpnow()
	        end
	    end
	end
end))

table.insert(_G.Connect, workspace.DescendantAdded:Connect(function(v)
	if v:IsA("Sound") then
		PlayingSound(v)
	end
end))

local LastPathTime = 0
local Nopath = false
table.insert(_G.Connect, RunService.RenderStepped:Connect(function()
	if _G.AutoMove and not Toggles["No FindPath"].Value then
		if tick() - LastPathTime < 1 then return end
		local Survivor = (Options["Move"] and Options["Move"].Value == "Survivors" and ClosestSurvivor() or (KillerTarget() and KillerTarget().Parent))
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

table.insert(_G.Connect, RunService.RenderStepped:Connect(function()
if char.Name:lower():find("guest") or char.Name:lower():find("jane") then
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
		local Ability = maingui and maingui:FindFirstChild("AbilityContainer")
		
		local Punch = Ability and Ability:FindFirstChild("Punch")
	    local charges = Punch and Punch:FindFirstChild("Charges")
	
		local Axe = Ability and Ability:FindFirstChild("Axe")
		local cooldown = Axe and Axe:FindFirstChild("CooldownTime")
		
		local targetKill = KillerTarget()
        if (Punch and charges and tonumber(charges.Text) >= 1) or (Axe and cooldown and cooldown.Text == "") and targetKill and Distance(targetKill.Position) <= (_G.DetectionRangeFallPush or 15) then
			if _G.FallPunch then
	            root.CFrame = targetKill.CFrame + Vector3.new(0, 8, 0)
			end
			if _G.Punch then
				if char.Name:lower():find("guest") then
					Remote:FireServer("UseActorAbility", {buffer.fromstring(charAb("Punch"))})
				end
				if char.Name:lower():find("jane") then
                    Remote:FireServer("UseActorAbility", {buffer.fromstring(charAb("Axe"))})
				end
			end
        end
	end
end
end))

table.insert(_G.Connect, RunService.Heartbeat:Connect(function()
if char and char.Name:lower():find("guest") then
	if _G.NoAnimationBlock then
	    if hum and hum:FindFirstChildOfClass("Animator") then
		    for _, v in ipairs(hum:FindFirstChildOfClass("Animator"):GetPlayingAnimationTracks() or {}) do
		        if table.find(Animations["Aura Hit"], tostring(v.Animation.AnimationId):match("%d+")) then
					v:Stop()
				end
			end
	    end
	end
end
if char and char.Name:lower():find("guest") then
    local Block = maingui and maingui:FindFirstChild("AbilityContainer") and maingui.AbilityContainer:FindFirstChild("Block")
    local cooldown = Block and Block:FindFirstChild("CooldownTime")
    
	for _, v in ipairs(playerout:GetPlayers()) do
	    if v ~= player and v.Character then
	        local hrp = v.Character:FindFirstChild("HumanoidRootPart")
	        local humplr = v.Character:FindFirstChildOfClass("Humanoid")
	        local animTracks = humplr and humplr:FindFirstChildOfClass("Animator") and humplr:FindFirstChildOfClass("Animator"):GetPlayingAnimationTracks()
	        if hrp and Distance2(hrp.Position) <= (_G.DetectionRange or 18) then
				if _G.AutoBlockSound then
					if hrp and hrp:FindFirstChildOfClass("Sound") and hrp:FindFirstChildOfClass("Sound").IsPlaying then
						if AutoSoundBlock[tostring(hrp:FindFirstChildOfClass("Sound").SoundId):match("%d+")] then
							if _G.AutoBlockSound and Distance2(hrp.Position) <= (_G.DetectionRange or 18) then
	                            if hrp.CFrame.LookVector:Dot((root.Position - hrp.Position).Unit) > 0 then
		                            if cooldown and cooldown.Text == "" then
										if char.Name:lower():find("guest") then
		                                    Remote:FireServer("UseActorAbility", {buffer.fromstring(charAb("Block"))})
										end
	                                    if Toggles["Block Teleport"].Value then
											if root and char.Name:lower():find("guest") then
					                            root.CFrame = hrp.CFrame * CFrame.new(0, 0, -5)
					                        end
										end
	                                end
	                            end
	                        end
						end
					end
				end
				if _G.AutoBlock then
		            for _, track in ipairs(animTracks or {}) do
		                if Animations["KillerAnima"][tostring(track.Animation.AnimationId):match("%d+")] then
	                        if _G.AutoBlock and Distance2(hrp.Position) <= (_G.DetectionRange or 18) then
	                            if hrp.CFrame.LookVector:Dot((root.Position - hrp.Position).Unit) > 0 then
		                            if cooldown and cooldown.Text == "" then
	                                    if char.Name:lower():find("guest") then
		                                    Remote:FireServer("UseActorAbility", {buffer.fromstring(charAb("Block"))})
										end
	                                    if Toggles["Block Teleport"].Value then
											if root and char.Name:lower():find("guest") then
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
end
end))

local Window = Library:CreateWindow({
    Title = "Forsaken",
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
            SlowNumber.Value = 1
        end
	end
end
task.wait()
end
    end
})

Main1Group:AddDivider()
Main1Group:AddToggle("ButtonGen", {
    Text = "Show Button Generator",
    Default = false, 
    Callback = function(Value) 
ShowButtonU(Value)
    end
})

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

Main1Group:AddSlider("SpeedAutoGen", {
    Text = "Speed Auto Gen",
    Default = 0.05,
    Min = 0.05,
    Max = 1,
    Rounding = 2,
    Compact = false,
    Callback = function(Value)
_G.SpeedAutoGen = Value
    end
})

Main1Group:AddToggle("AutoGeneralPlay", {
    Text = "Auto Play Generator",
    Default = false, 
    Callback = function(Value) 
_G.AutoGen = Value
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
        if v:IsA("BasePart") and v.Name == "ItemRoot" and v.Parent and v.Parent.Name:lower() == itemName:lower() then
            return v
        end
    end
end
function findItemChar(keyword)
	if not (char and pack) then return end
	keyword = keyword:lower()
	for _, v in ipairs({char, pack}) do
		if v then
			for _, j in ipairs(v:GetChildren()) do
				if j:IsA("Tool") and j.Name:lower():find(keyword) then
					return j
				end
			end
		end
	end
end
Main1Group:AddButton("Collect To Medkit", function()
local Medkit = getItem("Medkit")
local Item = Medkit.Parent and Medkit.Parent.Name
local OldCF = root.CFrame
if Medkit then
	root.CFrame = Medkit.CFrame * CFrame.new(0, 3, 0)
    repeat task.wait() until Distance(Medkit.Position) <= 10
    wait(0.36)
    repeat task.wait()
	    if Distance(Medkit.Position) <= 17 then
		    if Medkit:FindFirstChildOfClass("ProximityPrompt") then
		        fireproximityprompt(Medkit:FindFirstChildOfClass("ProximityPrompt"))
		    end
		end
	until findItemChar("Medkit") or not Medkit
    root.CFrame = OldCF
end
end)

Main1Group:AddButton("Collect To BloxyCola", function()
local BloxyCola = getItem("BloxyCola")
local Item = BloxyCola.Parent and BloxyCola.Parent.Name
local OldCF = root.CFrame
if BloxyCola then
	root.CFrame = BloxyCola.CFrame * CFrame.new(0, 3, 0)
    repeat task.wait() until Distance(BloxyCola.Position) <= 10
    wait(0.36)
    repeat task.wait()
	    if Distance(BloxyCola.Position) <= 17 then
		    if BloxyCola:FindFirstChildOfClass("ProximityPrompt") then
		        fireproximityprompt(BloxyCola:FindFirstChildOfClass("ProximityPrompt"))
		    end
		end
	until findItemChar("BloxyCola") or not BloxyCola
    root.CFrame = OldCF
end
end)

Main1Group:AddButton("Collect to Item (Random)", function()
local ItemRandom = {}
local map = workspace:FindFirstChild("Map")
local ingame = map and map:FindFirstChild("Ingame")
if ingame then
	for _, v in ipairs(ingame:GetDescendants()) do
		if v:IsA("Tool") and v:FindFirstChild("ItemRoot") then
			table.insert(ItemRandom, v.ItemRoot)
		end
	end
end
if #ItemRandom == 0 then return end
local root = char and char:FindFirstChild("HumanoidRootPart")
if not root then return end
local OldCF = root.CFrame
local ItemRan = ItemRandom[math.random(1, #ItemRandom)]
local Item = ItemRan and ItemRan.Parent and ItemRan.Parent.Name
if not Item or not ItemRan or not pack then return end
if pack:FindFirstChild(Item) then return end
root.CFrame = ItemRan.CFrame * CFrame.new(0, 3, 0)
local t = 0
repeat task.wait()
	t += 1
until Distance(ItemRan.Position) <= 10 or t > 50
task.wait(0.3)
t = 0
repeat task.wait()
	t += 1
	if Distance(ItemRan.Position) <= 17 then
		local prompt = ItemRan:FindFirstChildOfClass("ProximityPrompt")
		if prompt then
			fireproximityprompt(prompt)
		end
	end
until findItemChar(Item) or t > 80
root.CFrame = OldCF
end)

Main1Group:AddDivider()
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
        end
    end
end
if ValueTarget then
	root.CFrame = ValueTarget.CFrame
end
end)

Main1Group:AddButton("Collect to Folder / Ring (Quest)", function()
for i, v in ipairs(workspace:GetChildren()) do
	if v:IsA("BasePart") and v.Name == "Model" and v:FindFirstChildOfClass("ProximityPrompt") then
		local OldCF = root.CFrame
		root.CFrame = v.CFrame
		repeat task.wait() until Distance(v.Position) <= 10
		wait(0.3)
		local prompt = v:FindFirstChildOfClass("ProximityPrompt")
		if prompt then
			fireproximityprompt(prompt)
		end
		root.CFrame = OldCF
		break
	end
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
Main6Group:AddLabel("Guest 1773 - Jane Doe", true)
Main6Group:AddDivider()

Main6Group:AddToggle("Auto Block", {
    Text = "Auto Block (Animation)",
    Default = false, 
    Callback = function(Value) 
_G.AutoBlock = Value
    end
})

Main6Group:AddToggle("Auto Block Sound", {
    Text = "Auto Block (Sound)",
    Default = false, 
    Callback = function(Value) 
_G.AutoBlockSound = Value
    end
})

Main6Group:AddToggle("No Animation Block", {
    Text = "No Animation Block",
    Default = false, 
    Callback = function(Value) 
_G.NoAnimationBlock = Value
    end
})

Main6Group:AddToggle("Block Teleport", {
    Text = "Auto Block Teleport",
    Default = false
})

Main6Group:AddToggle("Auto Punch", {
    Text = "Auto Punch / Hatchet",
    Default = false, 
    Callback = function(Value) 
_G.Punch = Value
    end
})

Main6Group:AddToggle("Auto Fall Punch", {
    Text = "Auto Fall Punch / Hatchet",
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
getgenv()._ChangeGuest = Value
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
    Text = "Sharpness (Punch / Hatchet)",
    Default = 4,
    Min = 1,
    Max = 10,
    Rounding = 1,
    Compact = false
})

Main6Group:AddToggle("Aimbot Punch", {
    Text = "Aimbot Punch - Hatchet",
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
Main6Group:AddLabel("Shedletsky", true)
Main6Group:AddDivider()

Main6Group:AddSlider("Detection Range Shedletsky", {
    Text = "Detection Range Slash",
    Default = 7,
    Min = 3,
    Max = 12,
    Rounding = 1,
    Compact = false
})

Main6Group:AddToggle("Aimbot Shedletsky", {
    Text = "Aimbot Slash",
    Default = false
})

Main6Group:AddToggle("Auto Shedletsky", {
    Text = "Auto Slash",
    Default = false
})

Main6Group:AddToggle("Auto Slash TP", {
    Text = "Auto Slash TP",
    Default = false,
    Callback = function(Value)
if Value then
	Toggles["Auto Shedletsky"]:SetValue(true)
end
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

Main6Group:AddDropdown("Mode Two Time", {
    Text = "Mode Two Time",
    Values = {"Behind", "Around"},
    Default = ""
})

Main6Group:AddToggle("Two Time Teleport", {
    Text = "Two Time Stab",
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
getgenv()._WalkspeedOverrideBypass = Value
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

Main7Group:AddSlider("Distance Parry", {
    Text = "Distance Parry",
    Default = 15,
    Min = 1,
    Max = 25,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
_G.DistanceParry = Value
    end
})

Main7Group:AddDivider()
Main7Group:AddLabel("Slasher", true)
Main7Group:AddDivider()

Main7Group:AddToggle("Auto Parry Slash", {
    Text = "Auto Parry Slash",
    Default = false,
    Callback = function(Value) 
_G.AutoParrySlash = Value
    end
})

Main7Group:AddToggle("Aimbot Behead", {
    Text = "Aimbot Behead / Parry",
    Default = false
})

Main7Group:AddDivider()
Main7Group:AddLabel("John Doe", true)
Main7Group:AddDivider()

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
				local TextKiller
				if z:GetAttribute("IsFakeNoli") then
					TextKiller = "Fake Noli"
				else
					TextKiller = z.Name.." ("..z:GetAttribute("Username")..")"
				end
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

Misc1Group:AddDivider()
Misc1Group:AddDropdown("Move", {
    Text = "Auto Move",
    Values = {"Killers", "Survivors"},
    Default = ""
})

Misc1Group:AddToggle("No FindPath", {
    Text = "No Find Path",
    Default = false
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
	if game.CoreGui:FindFirstChild("Gui Gen Script") then
		game.CoreGui:FindFirstChild("Gui Gen Script"):Destroy()
	end
	if game.CoreGui:FindFirstChild("Keybind Script") then
		game.CoreGui:FindFirstChild("Keybind Script"):Destroy()
	end
	if Animations then
		Animations = nil
	end
end) 