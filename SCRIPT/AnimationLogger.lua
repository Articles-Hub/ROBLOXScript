local LMG2L = {}
local PARENT = (gethui and gethui()) or cloneref(game:GetService("CoreGui"))

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

-- State
local animations = {}
local selectedAnimations = {}
local autoScanConnection = nil
local isAutoScanning = false

_G.Connect = {}

local function AddConnection(Signal, Function)
    local SignalConnect = Signal:Connect(Function)
    table.insert(_G.Connect, SignalConnect)
    return SignalConnect
end

local settingsValues = {}
local settingsItems = {}
local settingsDirty = false

local function AddToggle(key, label, default)
    settingsValues[key] = (default == true)
    table.insert(settingsItems, { type = "toggle", key = key, label = label, default = default })
end

local function AddTextbox(key, label, default, placeholder)
    settingsValues[key] = default or ""
    table.insert(settingsItems, { type = "textbox", key = key, label = label, default = default or "", placeholder = placeholder or "" })
end

local function GetSetting(key)
    return settingsValues[key]
end

AddToggle("Animation Looped", "Animation Looped", false)
AddToggle("NameReal", "Show Real Name", true)
AddToggle("r6/r15", "R6 or R15", true)
AddToggle("PlayReal", "Play Outside", false)
AddToggle("Pathfind", "Pathfind Animation (Lagging, Auto Scan)", true)
AddTextbox("Speed", "Animation Speed", "", "set speed")

-- =====================
-- UTILITY & FILTERS
-- =====================

local nameCache = {}
local fetching = {}
local currentViewingAnim = nil
local searchBox = nil

local activeButtons = {} 

local function getNameFromIdAsync(id, callback, animData)
    id = tostring(id):match("%d+") or ""
    if not id or id == "" then 
        if callback then callback("Unknown Asset") end
        return 
    end

    if nameCache[id] then
        if callback then callback(nameCache[id]) end
        if animData then animData.name = nameCache[id] end
        return
    end

    if fetching[id] then
        table.insert(fetching[id], {callback = callback, animData = animData})
        return
    end

    fetching[id] = {{callback = callback, animData = animData}}

    task.spawn(function()
        local success, info = pcall(function()
            return MarketplaceService:GetProductInfo(tonumber(id), Enum.InfoType.Asset)
        end)

        local realName = (success and info and info.Name) and info.Name or "Unknown Asset"
        nameCache[id] = realName

        for _, entry in ipairs(fetching[id]) do
            if entry.callback then task.defer(entry.callback, realName) end
            if entry.animData then entry.animData.name = realName end
        end

        fetching[id] = nil
        
        if activeButtons[id] then
            for _, btn in ipairs(activeButtons[id]) do
                if btn and btn.Parent then
                    btn.Text = string.format("   %s", realName)
                end
            end
        end

        if currentViewingAnim and currentViewingAnim.id == id then
            local infoFrame = LMG2L["ScreenGui_1"].Main.Info
            if infoFrame and infoFrame.Visible then
                local infoA = infoFrame.InfoA
                infoA.InfoID.Text = string.format('ID: %s', id)
            end
        end
    end)
end

local function getNameFromId(id)
    id = tostring(id):match("%d+") or ""
    return nameCache[id] or "Loading..."
end

local function getAnimator(instance)
    if not instance then
        return nil
    end
    local animator = instance:FindFirstChildOfClass("Animator")
    if animator then
        return animator
    end
    local humanoid = instance:FindFirstChildOfClass("Humanoid")
    if humanoid then
        return humanoid:FindFirstChildOfClass("Animator")
    end
    return nil
end

local function getAnimatorFromModel(model)
    return getAnimator(model)
end

local function findAnimationInstance(animId)
    animId = tostring(animId):match("%d+")
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("Animation") then
            local id = tostring(obj.AnimationId):match("%d+")
            if id == animId then
                return obj
            end
        end
    end
    return nil
end

local function formatName(name)
    if name:match("^[%a_][%w_]*$") then
        return "." .. name
    else
        return string.format('["%s"]', name)
    end
end

local function getInstancePath(inst)
    local parts = {}
    while inst and inst ~= game do
        table.insert(parts, 1, formatName(inst.Name))
        inst = inst.Parent
    end
    return "game" .. table.concat(parts)
end

local function isCharacterModel(model)
    if not model or not model:IsA("Model") then return false end
    if model:FindFirstChildOfClass("Humanoid") then return true end
    if Players:GetPlayerFromCharacter(model) then return true end
    return false
end

local function shouldIgnore(animId, animName)
    if not animId or animId == "" then return true end
    local ID = tostring(animId:match("%d+"))
    local blacklistedNames = {
		"180426354", "125750702", "180435792", "180435571", "180436148", "182393478", "178130996", "180436334", "507766666", "507766951",
	    "507766388", "507777826", "507767714", "507784897", "507785072", "507765000", "507767968", "507765644", "2506281703", "507768375",
		"522635514", "522638767", "507770239", "507770453", "507771019", "507771955", "507772104", "507776043", "507776720", "507776879",
		"507777268", "507777451", "507777623", "507770818", "507770677", "129967390", "129967478", "128777973", "128853357", "182435998",
		"182491037", "182491065", "182436842", "182491248", "182491277", "182436935", "182491368", "182491423", "129423131", "129423030",
	}
    for _, word in ipairs(blacklistedNames) do
        if ID:find(word) then
            return true
        end
    end
    return false
end

local function isValidAnimation(animId, animName)
    if shouldIgnore(animId, animName) then return false end
    
    local animObj = Instance.new("Animation")
    animObj.AnimationId = animId
    
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local animator = getAnimator(char)
    if animator then
        local success, track = pcall(function()
            return animator:LoadAnimation(animObj)
        end)
        if success and track then
            if track.Length == 0 then
                task.wait(0.02)
            end
            local duration = track.Length
            track:Destroy()
            animObj:Destroy()
            return duration > 0
        end
    end
    if animObj then animObj:Destroy() end
    return false
end

-- =====================
-- SCAN ANIMATIONS
-- =====================

local function scanAnimations(root)
    local found = {}
    local function recurse(inst)
        if inst:IsA("BasePart") or inst:IsA("UnionOperation") or inst:IsA("MeshPart") then return end
        if inst:IsA("Animation") then
            if isValidAnimation(inst.AnimationId, inst.Name) then
                table.insert(found, inst)
            end
        end
        for _, child in ipairs(inst:GetChildren()) do recurse(child) end
    end
    recurse(root)
    return found
end

local function scanPlayingTracks(root)
    local found = {}
    local function recurse(inst)
        if inst:IsA("BasePart") then return end
        if inst:IsA("Model") then
            local animator = getAnimatorFromModel(inst)
            if animator then
                local realPath = getInstancePath(animator)
                local ok, tracks = pcall(function()
                    return animator:GetPlayingAnimationTracks()
                end)
                if ok then
                    for _, track in ipairs(tracks) do
                        local id = track.Animation and track.Animation.AnimationId or ""
                        if not shouldIgnore(id, track.Name) then
                            table.insert(found, {
                                track = track,
                                animId = id,
                                name = GetSetting("NameReal") == true and "Loading..." or track.Name,
                                animator = animator,
                                animatorPath = realPath,
                            })
                            if GetSetting("NameReal") == true then
					            getNameFromIdAsync(found.animId, nil, found)
							end
                        end
                    end
                end
            end
        end
        for _, child in ipairs(inst:GetChildren()) do
            recurse(child)
        end
    end
    recurse(root)
    return found
end

-- =====================
-- BUILD ANIMATION LIST
-- =====================

local function buildAnimList(scope)
    animations = {}
    selectedAnimations = {}

    local roots = {}
    if scope == "Game" or scope == "All" then
        table.insert(roots, Workspace)
        table.insert(roots, ReplicatedStorage)
    elseif scope == "Workspace" then
        table.insert(roots, Workspace)
    elseif scope == "ReplicatedStorage" then
        table.insert(roots, ReplicatedStorage)
    end
    
    for _, root in ipairs(roots) do
        local tracks = scanPlayingTracks(root)
        for _, data in ipairs(tracks) do
            local animData = {
                id = data.animId,
                name = GetSetting("NameReal") == true and "Loading..." or tracks.Name,
                path = data.animatorPath,
                track = data.track,
                isPlaying = true,
                source = "Playing",
            }
            table.insert(animations, animData)
            if GetSetting("NameReal") == true then
	            getNameFromIdAsync(data.animId, nil, animData)
			end
        end
    end

    for _, root in ipairs(roots) do
        local animInsts = scanAnimations(root)
        for _, anim in ipairs(animInsts) do
            local duplicate = false
            for _, existing in ipairs(animations) do
                if existing.id == anim.AnimationId then
                    duplicate = true
                    break
                end
            end
            if not duplicate then
                local animData = {
                    id = anim.AnimationId,
                    name = GetSetting("NameReal") == true and "Loading..." or anim.Name,
                    path = getInstancePath(anim),
                    track = nil,
                    isPlaying = false,
                    source = "Object",
                }
                table.insert(animations, animData)
                if GetSetting("NameReal") == true then
	                getNameFromIdAsync(anim.AnimationId, nil, animData)
				end
            end
        end
    end
end


local function formatTime(seconds)
    seconds = tonumber(seconds) or 0
    local wholeSeconds = math.floor(seconds)
    local ticks = math.floor((seconds - wholeSeconds) * 100)
    return string.format("%02d:%02d", wholeSeconds, ticks)
end

local function Create(className: string?, props: table?, children: table?)
	local obj = Instance.new(className)
	if props then
		for k, v in pairs(props) do pcall(function() obj[k] = v end) end
	end
	if children then
		for _, child in ipairs(children) do if typeof(child) == "Instance" then child.Parent = obj end end
	end
	return obj
end

function MakeDraggable(gui: GuiObject, DragFrame: GuiObject, Callback: () -> ()?)
    local dragging = false
    local dragStart, startPos, activeInput

    local function update(input)
        if not dragging or not dragStart or not startPos then
            return
        end
        local delta = input.Position - dragStart
        gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        if Callback then
            OrionLib:SafeScript(Callback)
        end
    end

    AddConnection(DragFrame.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            activeInput = input
            dragStart = input.Position
            startPos = gui.Position
            AddConnection(input.Changed, function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    activeInput = nil
                end
            end)
        end
    end)

    AddConnection(DragFrame.InputChanged, function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            activeInput = input
        end
    end)

    AddConnection(UserInputService.InputChanged, function(input)
        if
            dragging and (input == activeInput or input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch)
        then
            update(input)
        end
    end)

    AddConnection(UserInputService.InputEnded, function(input)
        if input == activeInput or input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            activeInput = nil
        end
    end)
end

LMG2L["ScreenGui_1"] = Create("ScreenGui", {
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	Name = "Animation Logger",
	Parent = PARENT
}, {
	Create("Frame", {
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        AnchorPoint = Vector2.new(1, 1),
        Size = UDim2.new(0, 300, 1, -25),
        Position = UDim2.new(1, -24, 1, -24),
        BackgroundTransparency = 1,
        Name = "ListNotify"
    }, {
	    Create("UIListLayout", {
	        HorizontalAlignment = Enum.HorizontalAlignment.Right,
	        Padding = UDim.new(0, 5),
	        VerticalAlignment = Enum.VerticalAlignment.Bottom,
	        SortOrder = Enum.SortOrder.LayoutOrder
	    })
	}),
	Create("ImageButton", {
		Name = "ToggleHere", Draggable = true, BackgroundColor3 = Color3.fromRGB(255, 186, 117),
		Image = "rbxassetid://7734091286", Visible = false,
		Size = UDim2.new(0,45,0,45), Position = UDim2.new(0,0,0,0)
	}, { 
		Create("UICorner", { CornerRadius = UDim.new(0, 4) }) 
	}),
	Create("Frame", {
		Name = "Main", Active = true, BorderSizePixel = 0, BackgroundColor3 = Color3.fromRGB(244, 244, 244),
		Size = UDim2.new(0, 370, 0, 286), Position = UDim2.new(0, 252, 0, 22), BackgroundTransparency = 0.2
	}, {
		Create("UICorner", { CornerRadius = UDim.new(0, 4) }),
		Create("UIStroke", {}),

		Create("TextLabel", {
			Name = "Title", TextWrapped = true, BorderSizePixel = 0, TextScaled = true,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255), ZIndex = 99,
			FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
			TextColor3 = Color3.fromRGB(0, 0, 0), Size = UDim2.new(0, 268, 0, 32), Position = UDim2.new(0, 10, 0, 10), Text = "Animation Logger"
		}, {
			Create("UICorner", { CornerRadius = UDim.new(0, 4) }),
			Create("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
		}),

		Create("TextButton", {
			Name = "Close", TextWrapped = true, BorderSizePixel = 0, TextScaled = true, BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
			Size = UDim2.new(0, 38, 0, 32), Position = UDim2.new(0, 284, 0, 10), Text = "X"
		}, {
			Create("UICorner", { CornerRadius = UDim.new(0, 4) }),
			Create("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
		}),

		Create("TextButton", {
			Name = "Hide", TextWrapped = true, BorderSizePixel = 0, TextScaled = true, BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
			Size = UDim2.new(0, 38, 0, 32), Position = UDim2.new(0, 326, 0, 10), Text = "–"
		}, {
			Create("UICorner", { CornerRadius = UDim.new(0, 4) }),
			Create("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
		}),

		Create("Frame", {
			Name = "Main", Visible = true, ZIndex = 3, BorderSizePixel = 0, Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1
		}, {
			Create("Frame", {
				Name = "Search", BorderSizePixel = 0, BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(0, 182, 0, 18), Position = UDim2.new(0, 10, 0, 48)
			}, {
				Create("UICorner", { CornerRadius = UDim.new(0, 2) }),
				Create("UIStroke", { Transparency = 0.3, Thickness = 1.2 }),
				Create("TextBox", {
					BorderSizePixel = 0, TextWrapped = true, TextScaled = true, BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					PlaceholderText = "Search Animation", Size = UDim2.new(1, 0, 1, 0), Text = "", BackgroundTransparency = 1
				})
			}),

			Create("TextButton", {
				Name = "Settings", TextWrapped = true, BorderSizePixel = 0, TextScaled = true, BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Size = UDim2.new(0, 40, 0, 18), Position = UDim2.new(0, 196, 0, 48), Text = "Settings"
			}, {
				Create("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(88, 88, 88) }),
				Create("UICorner", { CornerRadius = UDim.new(0, 2) })
			}),

			Create("ScrollingFrame", {
				BorderSizePixel = 0, BackgroundColor3 = Color3.fromRGB(215, 215, 215), AutomaticCanvasSize = Enum.AutomaticSize.Y,
				Size = UDim2.new(0, 224, 0, 206), Position = UDim2.new(0, 12, 0, 72), ScrollBarThickness = 0, BackgroundTransparency = 0.7
			}, {
				Create("UICorner", { CornerRadius = UDim.new(0, 4) }),
				Create("UIStroke", {}),
				Create("UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 5) }),
				Create("UIPadding", { PaddingTop = UDim.new(0, 6) })
			}),

			Create("Frame", {
				Name = "Progress", BorderSizePixel = 0, BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(0, 124, 0, 232), Position = UDim2.new(0, 242, 0, 48), BackgroundTransparency = 0.5
			}, {
				Create("UIStroke", {}),
				Create("UICorner", { CornerRadius = UDim.new(0, 4) }),
				Create("TextLabel", {
					Name = "Settings", TextWrapped = true, BorderSizePixel = 0, TextSize = 17, BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
					BackgroundTransparency = 1, Size = UDim2.new(0, 124, 0, 24), Text = "Settings:"
				}),
				Create("Frame", {
					Name = "Settings", BorderSizePixel = 0, BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(0, 124, 0, 6), Position = UDim2.new(0, 0, 0, 26), BackgroundTransparency = 1
				}, {
					Create("UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 3) }),
					Create("TextButton", {
						Name = "SaveA", TextWrapped = true, BorderSizePixel = 0, TextSize = 18, BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.new(0, 108, 0, 20), LayoutOrder = 5, Text = "Save Selected"
					}, { Create("UICorner", { CornerRadius = UDim.new(0, 4) }), Create("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 1.2 }) }),
					Create("TextButton", {
						Name = "SaveB", TextWrapped = true, BorderSizePixel = 0, TextSize = 18, BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.new(0, 108, 0, 20), LayoutOrder = 5, Text = "Save All"
					}, { Create("UICorner", { CornerRadius = UDim.new(0, 4) }), Create("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 1.2 }) }),
					Create("TextButton", {
						Name = "ClrA", TextWrapped = true, BorderSizePixel = 0, TextSize = 18, BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.new(0, 108, 0, 20), LayoutOrder = 5, Text = "Clr Selected"
					}, { Create("UICorner", { CornerRadius = UDim.new(0, 4) }), Create("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 1.2 }) }),
					Create("TextButton", {
						Name = "ClrB", TextWrapped = true, BorderSizePixel = 0, TextSize = 17, BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.new(0, 108, 0, 20), LayoutOrder = 5, Text = "Clr UnSelected "
					}, { Create("UICorner", { CornerRadius = UDim.new(0, 4) }), Create("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 1.2 }) })
				}),
				Create("TextLabel", {
					Name = "Scan", TextWrapped = true, BorderSizePixel = 0, TextSize = 17, BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
					BackgroundTransparency = 1, Size = UDim2.new(0, 124, 0, 18), Position = UDim2.new(0, 0, 0, 118), Text = "Scan:"
				}),
				Create("Frame", {
					Name = "Scan", BorderSizePixel = 0, BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(0, 124, 0, 6), Position = UDim2.new(0, 0, 0, 138), BackgroundTransparency = 1
				}, {
					Create("UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 3) }),
					Create("TextButton", {
						Name = "Game", TextWrapped = true, BorderSizePixel = 0, TextSize = 18, BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.new(0, 110, 0, 20), LayoutOrder = 5, Text = "Game"
					}, { Create("UICorner", { CornerRadius = UDim.new(0, 4) }), Create("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 1.2 }) }),
					Create("TextButton", {
						Name = "ReplicatedStorage", TextWrapped = true, BorderSizePixel = 0, TextSize = 18, TextScaled = true, BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.new(0, 108, 0, 20), LayoutOrder = 5, Text = "ReplicatedStorage"
					}, { Create("UICorner", { CornerRadius = UDim.new(0, 4) }), Create("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 1.2 }) }),
					Create("TextButton", {
						Name = "Workspace", TextWrapped = true, BorderSizePixel = 0, TextSize = 18, BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.new(0, 108, 0, 20), LayoutOrder = 5, Text = "Workspace"
					}, { Create("UICorner", { CornerRadius = UDim.new(0, 4) }), Create("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 1.2 }) })
				}),
				Create("TextButton", {
					Name = "Auto Scan", TextWrapped = true, BorderSizePixel = 0, TextSize = 18, BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.new(0, 108, 0, 20), LayoutOrder = 5, Position = UDim2.new(0, 8, 0, 208), Text = "Auto Scan"
				}, { Create("UICorner", { CornerRadius = UDim.new(0, 4) }), Create("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 1.2 }) })
			})
		}),

		Create("Frame", {
			Name = "Info", Visible = false, Active = true, BorderSizePixel = 0, Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1
		}, {
			Create("ViewportFrame", {
				Name = "InfoB", BorderSizePixel = 0, BackgroundColor3 = Color3.fromRGB(25, 25, 30), Size = UDim2.new(0, 154, 0, 230), Position = UDim2.new(0, 208, 0, 48), BackgroundTransparency = 1
			}, {
				Create("WorldModel", {}),
				Create("UICorner", { CornerRadius = UDim.new(0, 4) }),
				Create("UIStroke", {})
			}),

			Create("Frame", {
				Name = "InfoA", BorderSizePixel = 0, BackgroundColor3 = Color3.fromRGB(233, 233, 233), Size = UDim2.new(0, 190, 0, 230), Position = UDim2.new(0, 12, 0, 48), BackgroundTransparency = 0.2
			}, {
				Create("UICorner", { CornerRadius = UDim.new(0, 4) }), Create("UIStroke", {}),
				Create("TextLabel", {
					Name = "PathAnimator", TextWrapped = true, BorderSizePixel = 0, TextSize = 10, BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(0, 178, 0, 30), Position = UDim2.new(0, 6, 0, 166), Text = ""
				}, { Create("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border }), Create("UICorner", { CornerRadius = UDim.new(0, 4) }) }),
				Create("TextLabel", {
					Name = "InfoID", TextWrapped = true, BorderSizePixel = 0, TextSize = 10, BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(0, 178, 0, 30), Position = UDim2.new(0, 6, 0, 132), Text = ""
				}, { Create("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border }), Create("UICorner", { CornerRadius = UDim.new(0, 4) }) }),
				Create("TextButton", {
					Name = "CopyID", TextWrapped = true, BorderSizePixel = 0, TextSize = 10, BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(0, 86, 0, 26), Position = UDim2.new(0, 6, 0, 200), Text = "Copy ID"
				}, { Create("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border }), Create("UICorner", { CornerRadius = UDim.new(0, 4) }) }),
				Create("TextButton", {
					Name = "CopyPath", TextWrapped = true, BorderSizePixel = 0, TextSize = 10, BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(0, 86, 0, 26), Position = UDim2.new(0, 98, 0, 200), Text = "Copy Path"
				}, { Create("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border }), Create("UICorner", { CornerRadius = UDim.new(0, 4) }) }),
				Create("TextButton", {
					Name = "Activate", TextWrapped = true, BorderSizePixel = 0, TextSize = 10, BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(0, 42, 0, 30), Position = UDim2.new(0, 74, 0, 90), Text = "Play"
				}, { Create("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border }), Create("UICorner", { CornerRadius = UDim.new(1, 0) }) }),
				Create("Frame", { BorderSizePixel = 0, BackgroundColor3 = Color3.fromRGB(0, 0, 0), Size = UDim2.new(0, 178, 0, 2), Position = UDim2.new(0, 6, 0, 124) }),
				Create("Frame", {
					Name = "PlayA", BorderSizePixel = 0, BackgroundColor3 = Color3.fromRGB(180, 180, 180), Size = UDim2.new(0, 178, 0, 4), Position = UDim2.new(0, 6, 0, 78)
				}, {
					Create("UIStroke", {}),
					Create("Frame", {
						Name = "SliderKnob", BorderSizePixel = 0, BackgroundColor3 = Color3.fromRGB(255, 50, 50), Size = UDim2.new(0, 8, 0, 12), Position = UDim2.new(0, 0, 0, -4)
					}, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }), Create("UIStroke", {}), Create("TextButton", { Name = "Btn", BorderSizePixel = 0, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Text = "" }) }),
					Create("TextLabel", { Name = "Start", BorderSizePixel = 0, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.new(0, 30, 0, 14), Position = UDim2.new(0, -4, 0, -20), TextSize = 10, Text = "00:00" }),
					Create("TextLabel", { Name = "End", BorderSizePixel = 0, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.new(0, 30, 0, 14), Position = UDim2.new(0, 152, 0, -20), TextSize = 10, Text = "00:00" })
				}),
				Create("TextLabel", {
					Name = "Check Playing", TextWrapped = true, BorderSizePixel = 0, TextSize = 9, BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(0, 126, 0, 38), Position = UDim2.new(0, 6, 0, 6), Text = "Animation IsPlaying: Off"
				}, { Create("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border }), Create("UICorner", { CornerRadius = UDim.new(0, 4) }) }),
				Create("TextButton", {
					Name = "Up", TextWrapped = true, BorderSizePixel = 0, TextSize = 15, BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(0, 40, 0, 30), Position = UDim2.new(0, 124, 0, 90), Text = ">"
				}, { Create("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border }), Create("UICorner", { CornerRadius = UDim.new(0, 4) }) }),
				Create("TextButton", {
					Name = "Down", TextWrapped = true, BorderSizePixel = 0, TextSize = 15, BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(0, 40, 0, 30), Position = UDim2.new(0, 26, 0, 90), Text = "<"
				}, { Create("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border }), Create("UICorner", { CornerRadius = UDim.new(0, 4) }) }),
				Create("TextButton", {
					Name = "Next", TextWrapped = true, BorderSizePixel = 0, TextSize = 10, BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(0, 46, 0, 38), Position = UDim2.new(0, 138, 0, 6), Text = "Leave"
				}, { Create("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border }), Create("UICorner", { CornerRadius = UDim.new(0, 4) }) })
			})
		}),
		
		Create("Frame", {
            Active = true,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Size = UDim2.new(0, 370, 0, 286),
            Name = "Settings",
            Visible = false,
            BackgroundTransparency = 1
        }, {
            Create("ScrollingFrame", {
                BorderSizePixel = 0,
                BackgroundColor3 = Color3.fromRGB(92, 92, 92),
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                Size = UDim2.new(0, 354, 0, 196),
                Position = UDim2.new(0, 10, 0, 48),
                ScrollBarThickness = 0,
                BackgroundTransparency = 0.5
            }, {
                Create("UIStroke", {}),
                Create("UICorner", { CornerRadius = UDim.new(0, 4) }),
                Create("UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 5) }),
                Create("UIPadding", { PaddingTop = UDim.new(0, 5) }),
            }),
            
            Create("TextButton", {
                BorderSizePixel = 0,
                TextSize = 15,
                BackgroundColor3 = Color3.fromRGB(255, 0, 0),
                FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
                Size = UDim2.new(0, 166, 0, 28),
                Text = "Close",
                Name = "Close",
                Position = UDim2.new(0, 10, 0, 250)
            }, {
                Create("UICorner", { CornerRadius = UDim.new(0, 4) }),
                Create("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
            }),
            
            Create("TextButton", {
                BorderSizePixel = 0,
                TextSize = 15,
                BackgroundColor3 = Color3.fromRGB(0, 255, 0),
                FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
                Size = UDim2.new(0, 182, 0, 28),
                Text = "Done",
                Name = "Done",
                Position = UDim2.new(0, 182, 0, 250)
            }, {
                Create("UICorner", { CornerRadius = UDim.new(0, 4) }),
                Create("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
            })
        })
	})
})

MakeDraggable(LMG2L["ScreenGui_1"].Main, LMG2L["ScreenGui_1"].Main.Title)

local function setupConnections(gui)
    local Main = gui.Main
    local Notify = gui.ListNotify
    local MainFrame = Main.Main
    local InfoFrame = Main.Info
    local SettingFrame = Main.Settings

    local listScroll = MainFrame:FindFirstChildOfClass("ScrollingFrame")
    local progressPanel = MainFrame.Progress
    local settingsButtons, scanFrame

    for _, v in ipairs(progressPanel:GetChildren()) do
        if v.Name == "Settings" and v:IsA("Frame") then settingsButtons = v
        elseif v.Name == "Scan" and v:IsA("Frame") then scanFrame = v end
    end

    local SaveA = settingsButtons.SaveA
    local SaveB = settingsButtons.SaveB
    local ClrA  = settingsButtons.ClrA
    local ClrB  = settingsButtons.ClrB

    local BtnGame = scanFrame.Game
    local BtnRS   = scanFrame.ReplicatedStorage
    local BtnWS   = scanFrame.Workspace
    local BtnAuto = progressPanel["Auto Scan"]

    searchBox = MainFrame.Search:FindFirstChildOfClass("TextBox")

    local viewport = InfoFrame.InfoB
    local world = viewport.WorldModel
    local vpCamera = Instance.new("Camera")
    viewport.CurrentCamera = vpCamera
    vpCamera.Parent = viewport

    local currentClonedModel = nil
    local currentTrack = nil
    local renderConnection = nil
    local characterRotationY = 0
    local isDraggingCharacter = false
    local lastMousePosition = nil
    local isSliderDragging = false
    
    function Notification(notify)
	    notify = notify or {}
		notify.Text = notify.Text or "test"
		notify.Description = notify.Description or "test"
		notify.Time = notify.Time or 5
		notify.Accept = notify.Accept or function() end
		notify.Close = notify.Close or function() end
		
		if Notify then
			local NotifyHere = Create("Frame", {
	            BorderSizePixel = 0,
	            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	            Size = UDim2.new(0, 262, 0, 112),
	            Position = UDim2.new(0, 2, 0, 2),
	            Name = "notification",
	            BackgroundTransparency = 1,
				Parent = Notify
	        }, {
	            Create("Frame", {
	                BorderSizePixel = 0,
	                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	                Size = UDim2.new(1, 0, 1, 0),
					Position = UDim2.new(1, 30, 0, 0),
	                Name = "Notification",
	                BackgroundTransparency = 0.5
	            }, {
	                Create("UIStroke", {}),
	                Create("UICorner", { CornerRadius = UDim.new(0, 3) }),
	                Create("TextLabel", {
	                    TextWrapped = true,
	                    BorderSizePixel = 0,
	                    TextSize = 15,
	                    TextXAlignment = Enum.TextXAlignment.Left,
	                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	                    FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
	                    BackgroundTransparency = 1,
	                    Size = UDim2.new(0, 224, 0, 20),
	                    Text = notify.Text,
	                    Name = "Title",
	                    Position = UDim2.new(0, 6, 0, 4)
	                }),
	                Create("TextLabel", {
	                    TextWrapped = true,
	                    BorderSizePixel = 0,
	                    TextScaled = true,
	                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	                    FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
	                    TextColor3 = Color3.fromRGB(0, 0, 0),
	                    BackgroundTransparency = 1,
	                    Size = UDim2.new(0, 22, 0, 20),
	                    Text = "99:99",
	                    Name = "Time",
	                    Position = UDim2.new(0, 236, 0, 4)
	                }),
	                Create("Frame", {
	                    BorderSizePixel = 0,
	                    BackgroundColor3 = Color3.fromRGB(151, 151, 151),
	                    Size = UDim2.new(0, 250, 0, 2),
	                    Position = UDim2.new(0, 6, 0, 28)
	                }, {
	                    Create("UIStroke", {}),
	                    Create("UICorner", { CornerRadius = UDim.new(1, 0) })
	                }),
	                Create("TextLabel", {
	                    BorderSizePixel = 0,
	                    TextSize = 15,
	                    TextXAlignment = Enum.TextXAlignment.Left,
	                    TextYAlignment = Enum.TextYAlignment.Top,
	                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	                    FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
	                    BackgroundTransparency = 1,
	                    Size = UDim2.new(0, 250, 0, 52),
	                    Text = notify.Description,
	                    Name = "Description",
	                    Position = UDim2.new(0, 6, 0, 36)
	                }),
	                Create("TextButton", {
	                    BorderSizePixel = 0,
	                    TextColor3 = Color3.fromRGB(0, 0, 0),
	                    BackgroundColor3 = Color3.fromRGB(0, 255, 61),
	                    Size = UDim2.new(0, 56, 0, 16),
	                    Text = "Accept",
	                    Name = "Accept",
	                    Position = UDim2.new(0, 6, 0, 92)
	                }, {
	                    Create("UICorner", { CornerRadius = UDim.new(0, 2) }),
	                    Create("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
	                }),
	                Create("TextButton", {
	                    BorderSizePixel = 0,
	                    TextColor3 = Color3.fromRGB(0, 0, 0),
	                    BackgroundColor3 = Color3.fromRGB(255, 0, 0),
	                    Size = UDim2.new(0, 58, 0, 16),
	                    Text = "Close",
	                    Name = "Close",
	                    Position = UDim2.new(0, 68, 0, 92)
	                }, {
	                    Create("UICorner", { CornerRadius = UDim.new(0, 2) }),
	                    Create("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
	                })
	            })
	        })
	
			local Notification = NotifyHere.Notification
			local Time = Notification.Time
			local Accept = Notification.Accept
			local Close = Notification.Close
			local hasNotifyTime = false
			
			Accept.MouseButton1Click:Connect(function()
				hasNotifyTime = true
				pcall(notify.Accept)
			end)
			
			Close.MouseButton1Click:Connect(function()
				hasNotifyTime = true
				pcall(notify.Close)
			end)
			
			local function tweenTime(textLabel, duration, startValue, endValue, easingStyle, easingDirection)
			    easingStyle = easingStyle or Enum.EasingStyle.Linear
			    easingDirection = easingDirection or Enum.EasingDirection.Out
			    
			    local startTime = os.clock()
			    while not hasNotifyTime do
		            local elapsedTime = os.clock() - startTime
		            local alpha = math.clamp(elapsedTime / duration, 0, 1)
		            local tweenAlpha = TweenService:GetValue(alpha, easingStyle, easingDirection)
		            local currentSeconds = startValue + (endValue - startValue) * tweenAlpha
		            local roundedSeconds = math.round(currentSeconds)
		            local minutes = math.floor(roundedSeconds / 60)
		            local seconds = roundedSeconds % 60
		            textLabel.Text = string.format("%d:%02d", minutes, seconds)
		            if alpha >= 1 then 
		                break 
		            end
		            task.wait()
		        end
			end

			TweenService:Create(Notification, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Position = UDim2.new(0, 0, 0, 0) }):Play()
	        tweenTime(Time, notify.Time, notify.Time, 0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	        local Out = TweenService:Create(Notification, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), { Position = UDim2.new(1, 90, 0, 0) })
	        Out:Play()
	        Out.Completed:Wait()
	        NotifyHere:Destroy()
		end
    end
    
    local function updateVpCamera()
        if not currentClonedModel then return end
        local root = currentClonedModel:FindFirstChild("HumanoidRootPart") or currentClonedModel:FindFirstChild("Torso") or currentClonedModel:FindFirstChild("UpperTorso")
        local origin = root and root.Position or Vector3.new(0, 3, 0)
        local target = origin + Vector3.new(0, 0.5, 0)
        local offset = Vector3.new(math.sin(camAngleX) * math.cos(camAngleY), math.sin(camAngleY), math.cos(camAngleX) * math.cos(camAngleY)) * camDist
        vpCamera.CFrame = CFrame.lookAt(target + offset, target)
    end
    
    local itemList = SettingFrame.ScrollingFrame
    local BtnSettingsDone = SettingFrame.Done
    local BtnSettingsClose = SettingFrame.Close

    local tempValues = {}

    local function setDoneActive(active)
        if active then
            BtnSettingsDone.BackgroundColor3 = Color3.fromRGB(60, 180, 90)
            BtnSettingsDone.TextColor3 = Color3.fromRGB(255, 255, 255)
            BtnSettingsDone.AutoButtonColor = true
            BtnSettingsDone.BackgroundTransparency = 0
        else
            BtnSettingsDone.BackgroundColor3 = Color3.fromRGB(60, 180, 90)
            BtnSettingsDone.TextColor3 = Color3.fromRGB(255, 255, 255)
            BtnSettingsDone.AutoButtonColor = false
            BtnSettingsDone.BackgroundTransparency = 0.55
        end
    end

    local function checkDirty()
        for k, v in pairs(tempValues) do
            if settingsValues[k] ~= v then
                setDoneActive(true)
                return
            end
        end
        setDoneActive(false)
    end

    local function buildSettingsItems()
        for _, c in ipairs(itemList:GetChildren()) do
            if c:IsA("Frame") then c:Destroy() end
        end

        for k, v in pairs(settingsValues) do tempValues[k] = v end
        setDoneActive(false)

        for _, item in ipairs(settingsItems) do
            if item.type == "toggle" then
                local row = Create("Frame", {
                    Name = item.key, BorderSizePixel = 0, ZIndex = 12,
                    BackgroundColor3 = Color3.fromRGB(50, 50, 58),
                    Size = UDim2.new(0, 340, 0, 38),
                    BackgroundTransparency = 0.1
                }, {
                    Create("UICorner", { CornerRadius = UDim.new(0, 6) }),
                    Create("UIStroke", { Color = Color3.fromRGB(70, 70, 85), Thickness = 1 }),
                })
                row.Parent = itemList

                Create("TextLabel", {
                    BorderSizePixel = 0, ZIndex = 13,
                    BackgroundTransparency = 1,
                    TextColor3 = Color3.fromRGB(220, 220, 225),
                    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextSize = 14,
                    Size = UDim2.new(0, 240, 1, 0),
                    Position = UDim2.new(0, 12, 0, 0),
                    Text = item.label,
                    Parent = row
                })

                local togBg = Create("Frame", {
                    BorderSizePixel = 0, ZIndex = 13,
                    Size = UDim2.new(0, 44, 0, 24),
                    Position = UDim2.new(1, -54, 0.5, -12),
                    BackgroundColor3 = tempValues[item.key] and Color3.fromRGB(60, 180, 90) or Color3.fromRGB(100, 100, 110),
                    Parent = row
                }, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })

                local togKnob = Create("Frame", {
                    BorderSizePixel = 0, ZIndex = 14,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Size = UDim2.new(0, 20, 0, 20),
                    Position = tempValues[item.key] and UDim2.new(0, 22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
                    Parent = togBg
                }, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })

                local togBtn = Create("TextButton", {
                    BorderSizePixel = 0, ZIndex = 15,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    Text = "", Parent = togBg
                })

                togBtn.MouseButton1Click:Connect(function()
                    tempValues[item.key] = not tempValues[item.key]
                    local on = tempValues[item.key]
                    TweenService:Create(togBg, TweenInfo.new(0.15), {
                        BackgroundColor3 = on and Color3.fromRGB(60, 180, 90) or Color3.fromRGB(100, 100, 110)
                    }):Play()
                    TweenService:Create(togKnob, TweenInfo.new(0.15), {
                        Position = on and UDim2.new(0, 22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
                    }):Play()
                    checkDirty()
                end)
            elseif item.type == "textbox" then
                local row = Create("Frame", {
                    Name = item.key, BorderSizePixel = 0, ZIndex = 12,
                    BackgroundColor3 = Color3.fromRGB(50, 50, 58),
                    Size = UDim2.new(0, 340, 0, 52),
                    BackgroundTransparency = 0.1
                }, {
                    Create("UICorner", { CornerRadius = UDim.new(0, 6) }),
                    Create("UIStroke", { Color = Color3.fromRGB(70, 70, 85), Thickness = 1 }),
                })
                row.Parent = itemList

                Create("TextLabel", {
                    BorderSizePixel = 0, ZIndex = 13,
                    BackgroundTransparency = 1,
                    TextColor3 = Color3.fromRGB(200, 200, 210),
                    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextSize = 13,
                    Size = UDim2.new(1, -16, 0, 20),
                    Position = UDim2.new(0, 12, 0, 4),
                    Text = item.label,
                    Parent = row
                })

                local tbBg = Create("Frame", {
                    BorderSizePixel = 0, ZIndex = 13,
                    BackgroundColor3 = Color3.fromRGB(30, 30, 36),
                    Size = UDim2.new(1, -16, 0, 22),
                    Position = UDim2.new(0, 8, 0, 26),
                    Parent = row
                }, {
                    Create("UICorner", { CornerRadius = UDim.new(0, 4) }),
                    Create("UIStroke", { Color = Color3.fromRGB(80, 80, 100), Thickness = 1 })
                })

                local tb = Create("TextBox", {
                    BorderSizePixel = 0, ZIndex = 14,
                    BackgroundTransparency = 1,
                    TextColor3 = Color3.fromRGB(220, 220, 220),
                    PlaceholderColor3 = Color3.fromRGB(110, 110, 120),
                    PlaceholderText = item.placeholder or "",
                    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextSize = 12,
                    Size = UDim2.new(1, -8, 1, 0),
                    Position = UDim2.new(0, 6, 0, 0),
                    Text = tempValues[item.key] or "",
                    ClearTextOnFocus = false,
                    Parent = tbBg
                })

                tb:GetPropertyChangedSignal("Text"):Connect(function()
                    tempValues[item.key] = tb.Text
                    checkDirty()
                end)
            end
        end
    end

    BtnSettingsDone.MouseButton1Click:Connect(function()
        local dirty = false
        for k, v in pairs(tempValues) do
            if settingsValues[k] ~= v then dirty = true break end
        end
        if not dirty then return end

        for k, v in pairs(tempValues) do
            settingsValues[k] = v
        end

        SettingFrame.Visible = false
        MainFrame.Visible = true
        setDoneActive(false)
    end)

    BtnSettingsClose.MouseButton1Click:Connect(function()
        for k, v in pairs(settingsValues) do tempValues[k] = v end
        SettingFrame.Visible = false
        MainFrame.Visible = true
    end)

    MainFrame.Settings.MouseButton1Click:Connect(function()
        buildSettingsItems()
        MainFrame.Visible = false
        SettingFrame.Visible = true
    end)

    local function renderList(filter)
        activeButtons = {}
        for _, child in ipairs(listScroll:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end

        filter = (filter or ""):lower()

        for i, anim in ipairs(animations) do
            local cleanId = tostring(anim.id):match("%d+") or ""
            local displayName = (anim.name ~= "" and anim.name ~= "Loading...") and anim.name or getNameFromId(anim.id)
            local displayId = (anim.id ~= "" and anim.id) or "No ID"

            if filter ~= ""
                and not displayName:lower():find(filter, 1, true)
                and not displayId:lower():find(filter, 1, true) then
                continue
            end

            local isSelected = selectedAnimations[i] == true
            local bgColor = isSelected and Color3.fromRGB(150, 200, 255) or Color3.fromRGB(233, 233, 233)

            local btn = Create("TextButton", {
                BorderSizePixel = 0,
                TextColor3 = Color3.fromRGB(0, 0, 0),
                BackgroundColor3 = bgColor,
                Size = UDim2.new(0, 212, 0, 26),
                TextXAlignment = Enum.TextXAlignment.Left,
                TextSize = 11,
                Text = string.format("   %s", displayName),
                Parent = listScroll
            }, {
                Create("UICorner", { CornerRadius = UDim.new(0, 4) }),
                Create("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(99, 100, 108) })
            })

            if cleanId ~= "" then
                if not activeButtons[cleanId] then activeButtons[cleanId] = {} end
                table.insert(activeButtons[cleanId], btn)
            end

            btn.MouseButton1Click:Connect(function()
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
                    selectedAnimations[i] = not selectedAnimations[i]
                    btn.BackgroundColor3 = selectedAnimations[i] and Color3.fromRGB(150, 200, 255) or Color3.fromRGB(233, 233, 233)
                    return
                end
                
                selectedAnimations[i] = true
                btn.BackgroundColor3 = Color3.fromRGB(150, 200, 255)

                currentViewingAnim = anim
                InfoFrame.Visible = true
                MainFrame.Visible = false

                local infoA = InfoFrame.InfoA
                infoA.InfoID.Text = string.format('ID: %s', displayId)
                infoA.PathAnimator.Text = anim.path
                
                if currentClonedModel then currentClonedModel:Destroy() end
                
                if GetSetting("PlayReal") == false then
	                local RModel = GetSetting("r6/r15") == true and Enum.HumanoidRigType.R6 or Enum.HumanoidRigType.R15
					local sourceChar = Players:CreateHumanoidModelFromDescription(Instance.new("HumanoidDescription"), RModel)
					sourceChar.Name = LocalPlayer.Name
	                if sourceChar then
	                    currentClonedModel = sourceChar
	                    currentClonedModel.Parent = world
	                    pcall(function()
						    currentClonedModel.Humanoid:ApplyDescription(Players:GetHumanoidDescriptionFromUserId(LocalPlayer.UserId))
						end)
	                    viewport.CurrentCamera.CameraSubject = nil
	                    local animate = currentClonedModel:FindFirstChild("Animate")
						if animate then
						    animate:Destroy()
						end					
	                    if currentClonedModel then currentClonedModel:SetPrimaryPartCFrame(CFrame.new(0, 0, 0)) end
	                    camAngleX = math.pi
		                camAngleY = math.rad(12)
		                camDist = 7
	                    updateVpCamera()
	                end
				else
					local ttl = Create("TextLabel", {
		                BorderSizePixel = 0,
						Name = "PlayOutside",
		                TextColor3 = Color3.fromRGB(255, 255, 255),
		                BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		                Size = UDim2.new(1, 0, 1, 0),
		                TextSize = 11,
		                Text = "Play Outside Bro",
		                Parent = viewport
		            }, {
		                Create("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(99, 100, 108) })
		            })
				end
                
                local animator
                if GetSetting("PlayReal") == false then 
	                animator = getAnimator(currentClonedModel)
				else
					animator = getAnimator(LocalPlayer.Character)
				end
		        if animator then
		            local animationObj = Instance.new("Animation")
		            animationObj.AnimationId = displayId
		            animationObj.Name = displayName
		            
		            local success, track = pcall(function()
		                return animator:LoadAnimation(animationObj)
		            end)
		
		            if success and track then
		                currentTrack = track
						currentTrack.Looped = GetSetting("Animation Looped") == true
		                currentTrack.Priority = Enum.AnimationPriority.Action
					else
						Notification({ Text = "Animation", Description = "Load Animation Failed", Time = 8 })
		            end
		        end

                local playBtn = infoA.Activate
                playBtn.Text = "Play"
                local isPaused = false 
                characterRotationY = 0
                local subConnections = {}

                table.insert(subConnections, infoA.CopyID.MouseButton1Click:Connect(function()
                    if setclipboard then setclipboard(displayId) end
                end))

                table.insert(subConnections, infoA.CopyPath.MouseButton1Click:Connect(function()
                    if setclipboard then setclipboard(anim.path) end
                end))

                table.insert(subConnections, playBtn.MouseButton1Click:Connect(function()
                    if not currentTrack then return end
                    if playBtn.Text == "Pause" and currentTrack.IsPlaying then
                        playBtn.Text = "Play"
                        currentTrack:AdjustSpeed(0)
                    else
                        playBtn.Text = "Pause"
                        if currentTrack.WeightCurrent == 0 then currentTrack:Play() end
                        currentTrack:AdjustSpeed(tonumber(GetSetting("Speed")) or 1)
                    end
                end))

                table.insert(subConnections, infoA.Up.MouseButton1Click:Connect(function()
                    if currentTrack then currentTrack.TimePosition = math.min(currentTrack.Length, currentTrack.TimePosition + 0.5) end
                end))

                table.insert(subConnections, infoA.Down.MouseButton1Click:Connect(function()
                    if currentTrack then currentTrack.TimePosition = math.max(0, currentTrack.TimePosition - 0.5) end
                end))

                local playAFrame = infoA.PlayA
                local sliderKnob = playAFrame.SliderKnob
                
                local activeTouches = {}
				local lastDistance = nil
				local zoomStart = false
				local isZoomViewport = false
				
				table.insert(subConnections, viewport.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        isZoomViewport = true
                    end
                end))
				
				table.insert(subConnections, UserInputService.TouchStarted:Connect(function(input)
				    activeTouches[input] = input.Position
				end))
				
				table.insert(subConnections, UserInputService.TouchMoved:Connect(function(input)
					if isZoomViewport then
					    activeTouches[input] = input.Position
					    local touches = {}
					    for _, pos in pairs(activeTouches) do
					        table.insert(touches, pos)
					    end
					
					    if #touches >= 2 then
							zoomStart = true
					        local distance = (touches[1] - touches[2]).Magnitude
					        if lastDistance then
					            local delta = distance - lastDistance
					            camDist = math.clamp(camDist - delta * 0.1, 2, 150)
					            updateVpCamera()
					        end
					
					        lastDistance = distance
					    end
					end
				end))
				
				table.insert(subConnections, UserInputService.TouchEnded:Connect(function(input)
				    activeTouches[input] = nil
					zoomStart = false
					isZoomViewport = false

				    local count = 0
				    for _ in pairs(activeTouches) do
				        count += 1
				    end
				    if count < 2 then
				        lastDistance = nil
				    end
				end))

                table.insert(subConnections, sliderKnob.Btn.MouseButton1Down:Connect(function() isSliderDragging = true end))
                table.insert(subConnections, UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then isSliderDragging = false end
                end))

                table.insert(subConnections, viewport.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        isDraggingCharacter = true
                        lastMousePosition = input.Position
                    end
                end))

                table.insert(subConnections, UserInputService.InputChanged:Connect(function(input)
                    if not zoomStart and isDraggingCharacter and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and lastMousePosition then
                        local delta = input.Position - lastMousePosition
                        camAngleX = camAngleX + delta.X * 0.012
                        camAngleY = math.clamp(camAngleY - delta.Y * 0.008, math.rad(-25), math.rad(70))
                        lastMousePosition = input.Position
                        updateVpCamera()
                    end
                    if isSliderDragging and currentTrack and currentTrack.Length > 0 then
                        local mousePos = input.Position
                        local relativeX = math.clamp((mousePos.X - playAFrame.AbsolutePosition.X) / playAFrame.AbsoluteSize.X, 0, 1)
                        currentTrack.TimePosition = relativeX * currentTrack.Length
                    end
                end))
                
                table.insert(subConnections, playAFrame.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        isSliderDragging = true
                        if currentTrack and currentTrack.Length > 0 then
                            local relativeX = math.clamp((input.Position.X - playAFrame.AbsolutePosition.X) / playAFrame.AbsoluteSize.X, 0, 1)
                            currentTrack.TimePosition = relativeX * currentTrack.Length
                        end
                    end
                end))

                table.insert(subConnections, UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then isDraggingCharacter = false end
                end))

                renderConnection = RunService.RenderStepped:Connect(function()
				    if currentClonedModel then
				        currentClonedModel:PivotTo(CFrame.new(0, 0, 0))
						updateVpCamera()
				    end
				
				    if currentTrack then
				        local length = currentTrack.Length
				        local currentTime = currentTrack.TimePosition
				                
				        if length > 0 then
				            local progress = math.clamp(currentTime / length, 0, 1)
				            sliderKnob.Position = UDim2.new(progress, -sliderKnob.AbsoluteSize.X/2, 0, -4)
				            playAFrame.Start.Text = formatTime(currentTime)
				            playAFrame.End.Text = formatTime(length)
				        end
				
				        local state = currentTrack.IsPlaying and (currentTrack.Speed == 0 and "Paused" or "On") or "Off"
				        infoA["Check Playing"].Text = "Animation IsPlaying: " .. state
						if not currentTrack.IsPlaying and currentTime >= length - 0.05 and length > 0 then
		                    playBtn.Text = "Play"
	                    end
				    end
				end)
				
				local leaveConnect
				leaveConnect = infoA.Next.MouseButton1Click:Connect(function()
	                if renderConnection then renderConnection:Disconnect() renderConnection = nil end
	                for _, c in ipairs(subConnections) do c:Disconnect() end
	                if leaveConnect then leaveConnect:Disconnect() leaveConnect = nil end
	                
	                if currentTrack then currentTrack:Stop() currentTrack = nil end
	                if currentClonedModel then currentClonedModel:Destroy() currentClonedModel = nil end
					if viewport and viewport:FindFirstChild("PlayOutside") then viewport.PlayOutside:Destroy() end
	
	                currentViewingAnim = nil
	                InfoFrame.Visible = false
	                MainFrame.Visible = true
	                renderList(searchBox.Text)
	            end)
			end)
        end
    end

    searchBox:GetPropertyChangedSignal("Text"):Connect(function() renderList(searchBox.Text) end)

    local function doScan(scope)
        buildAnimList(scope)
        renderList(searchBox.Text)
    end

    BtnGame.MouseButton1Click:Connect(function() spawn(function() doScan("Game") end); Notification({ Text = "Scan Animation", Description = "Wait for load scan", Time = 5 }) end)
    BtnWS.MouseButton1Click:Connect(function() spawn(function() doScan("Workspace") end); Notification({ Text = "Scan Animation", Description = "Wait for load scan", Time = 5 }) end)
    BtnRS.MouseButton1Click:Connect(function() spawn(function() doScan("ReplicatedStorage") end); Notification({ Text = "Scan Animation", Description = "Wait for load scan", Time = 5 }) end)
	
	local scannedTracks = {}
	local animatorConnections = {}
	
	local function isAlreadyAdded(animId, animName)
	    for _, anim in ipairs(animations) do
	        if anim.id == animId and (animName == "" or anim.name == animName) then return true end
	    end
	    return false
	end
	
	local function addTrack(track, animator)
        if not track then return end
        local animId = track.Animation and track.Animation.AnimationId or ""
        local animName = track.Name or "Unnamed"
        if animId == "" then return end
        if shouldIgnore(animId, animName) then return end
        local parentModel = animator.Parent
        while parentModel and not parentModel:IsA("Model") do
            parentModel = parentModel.Parent
        end
        if parentModel then
            local ac = parentModel:FindFirstChildOfClass("AnimationController")
            local hum = parentModel:FindFirstChildOfClass("Humanoid")
            if ac and not hum then return end
        end
        local realPath
		if GetSetting("Pathfind") == true then
	        local animObj = findAnimationInstance(animId)
			if animObj then
			    realPath = getInstancePath(animObj)
			else
			    realPath = getInstancePath(animator)
			end
		else
			realPath = getInstancePath(animator)
		end
        if realPath:find("viewport", 1, true) or realPath:find("WorldModel", 1, true) then return end

        local key = animId
        if scannedTracks[key] or isAlreadyAdded(animId) then return end
        scannedTracks[key] = true

        local animData = {
            id = animId,
            name = GetSetting("NameReal") == true and "Loading..." or track.Name,
            path = realPath,
            track = track,
            isPlaying = true,
            source = "Playing",
            sourceModel = parentModel,
        }
        table.insert(animations, 1, animData)
        if GetSetting("NameReal") == true then
            getNameFromIdAsync(animId, nil, animData)
		end
        renderList(searchBox.Text)
    end
	
	local function hookAnimator(animator)
	    if animatorConnections[animator] then return end
	
	    for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
	        addTrack(track, animator)
	    end
	
	    animatorConnections[animator] = animator.AnimationPlayed:Connect(function(track)
	        task.defer(addTrack, track, animator)
	    end)
	end
	
	BtnAuto.MouseButton1Click:Connect(function()
	    isAutoScanning = not isAutoScanning
	    if isAutoScanning then
	        BtnAuto.BackgroundColor3 = Color3.fromRGB(180, 255, 180)
	        BtnAuto.Text = "Auto Scan ON"
	        for _, desc in ipairs(workspace:GetDescendants()) do
	            if desc:IsA("Animator") then hookAnimator(desc) end
	        end
	        autoScanConnection = workspace.DescendantAdded:Connect(function(desc)
	            if desc:IsA("Animator") then hookAnimator(desc) end
	        end)
	    else
	        BtnAuto.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	        BtnAuto.Text = "Auto Scan"
	        if autoScanConnection then autoScanConnection:Disconnect() autoScanConnection = nil end
	        for _, conn in pairs(animatorConnections) do if conn then conn:Disconnect() end end
	        animatorConnections = {}
	        scannedTracks = {}
	    end
	end)
	
    SaveA.MouseButton1Click:Connect(function()
        local lines = {}
        for i, anim in ipairs(animations) do
            if selectedAnimations[i] == true then
                table.insert(lines, string.format('["%s"] = "%s", -- %s', anim.name, anim.id, anim.path))
            end
        end
        if #lines == 0 then return end
        if writefile then writefile("SavedAnimations_Selected.txt", table.concat(lines, "\n")) end
    end)

    SaveB.MouseButton1Click:Connect(function()
        local lines = {}
        for _, anim in ipairs(animations) do
            table.insert(lines, string.format('["%s"] = "%s", -- %s', anim.name, anim.id, anim.path))
        end
        if #lines == 0 then return end
        if writefile then writefile("SavedAnimations_All.txt", table.concat(lines, "\n")) end
    end)

    ClrA.MouseButton1Click:Connect(function()
        local newAnims = {}
        for i, anim in ipairs(animations) do if not selectedAnimations[i] then table.insert(newAnims, anim) end end
        animations = newAnims
        selectedAnimations = {}
        scannedTracks = {}
        renderList(searchBox.Text)
    end)

    ClrB.MouseButton1Click:Connect(function()
        local newAnims, newSel = {}, {}
        for i, anim in ipairs(animations) do
            if selectedAnimations[i] then
                table.insert(newAnims, anim)
                newSel[#newAnims] = true
            end
        end
        animations = newAnims
        selectedAnimations = newSel
        scannedTracks = {}
        renderList(searchBox.Text)
    end)

    Main.Close.MouseButton1Click:Connect(function()
	    Notification({ Text = "Remove Gui", Description = "Are you really for remove gui?", Time = 130, Accept = function()
				if autoScanConnection then autoScanConnection:Disconnect() end
		        if renderConnection then renderConnection:Disconnect() end
		        for i, v in pairs(_G.Connect) do
			        v:Disconnect()
		        end
		        gui:Destroy()
			end
		})
    end)

    Main.Hide.MouseButton1Click:Connect(function()
        Main.Visible = false
        gui.ToggleHere.Visible = true
    end)
    
    gui.ToggleHere.MouseButton1Click:Connect(function()
        Main.Visible = true
        gui.ToggleHere.Visible = false
    end)
    
    task.spawn(function()
		while true do
		    for i = 0, 255, 4 do
		        gui.ToggleHere.BorderColor3 = Color3.fromHSV(i/256, 1, 1)
		        gui.ToggleHere.BackgroundColor3 = Color3.fromHSV(i/256, .5, .8)
		        task.wait()
		    end
		end
	end)
end

setupConnections(LMG2L["ScreenGui_1"])