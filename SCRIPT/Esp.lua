-- [[ ROBLOX ADVANCED ESP FRAMEWORK - ULTRA CLEAN + BILLBOARD SKELETON ]] --
local Players, RunService, CoreGui, UserInputService = game:GetService("Players"), game:GetService("RunService"), game:GetService("CoreGui"), game:GetService("UserInputService")
local LocalPlayer, Camera = Players.LocalPlayer, workspace.CurrentCamera
local HasDrawing = type(Drawing) == "table" and type(Drawing.new) == "function"
local Connections, Cache, ObjectsCache = {}, {}, {}

local ESP_Folder = CoreGui:FindFirstChild("ESP_Storage") or Instance.new("Folder", CoreGui)
ESP_Folder.Name, ESP_Folder.Parent = "ESP_Storage", CoreGui

local ESP = {
    Enabled = true, Boxes = true, Highlight = false, Tracers = true, TracerOrigin = "Bottom",
    Names = true, ShowDistance = true, Skeletons = false, Healthbar = false,
    BoxThickness = 2, TracerThickness = 2, SkeletonThickness = 1.5, HealthbarThickness = 2,
    TextSize = 16, TextOutline = true, MaxDistance = 2000, DistanceOriginPart = nil,
    TweenTime = 0.3, RenderDelay = 0, Transparency = { Text = 1, Outline = 1, Fill = 0.5 }, Font = 2,
    TextColor = Color3.new(1,1,1), BoxColor = Color3.new(1,0,0), TracerColor = Color3.new(1,0,0),
    HighlightColor = Color3.new(1,0,0), FillColor = Color3.new(1,0,0), SkeletonColor = Color3.new(1,1,1),
    PlayerConfig = { Team = false, TeamColor = false, Name = {["Show Name"]=true, ["Show DisplayName"]=true}, Distance = true },
    Rainbow = false, RainbowSpeed = 1, Cache = Cache, ObjectsCache = ObjectsCache, IsDrawingSupported = HasDrawing
}

local CurrentRainbowColor = Color3.new(1,1,1)
Connections.Rainbow = RunService.RenderStepped:Connect(function()
    if ESP.Rainbow then CurrentRainbowColor = Color3.fromHSV((tick() * ESP.RainbowSpeed) % 5 / 5, 1, 1) end
end)

-- Helpers
local function getOriginPos()
    return (ESP.DistanceOriginPart and ESP.DistanceOriginPart:IsDescendantOf(workspace)) and ESP.DistanceOriginPart.Position or Camera.CFrame.Position
end

local function getTracerPos(mode)
    local size = Camera.ViewportSize
    if mode == "Top" then return Vector2.new(size.X/2, 0)
    elseif mode == "Center" then return size/2
    elseif mode == "Mouse" then local m = UserInputService:GetMouseLocation() return Vector2.new(m.X, m.Y) end
    return Vector2.new(size.X, size.Y) * Vector2.new(0.5, 1)
end

local function resolveColor(opt, target, def)
    if type(opt) == "function" then local s, c = pcall(opt, target); if s and typeof(c) == "Color3" then return c end
    elseif typeof(opt) == "Color3" then return opt end
    return def
end

local function getBounding(t)
    if not t or not t.Parent then return end
    return t:IsA("Model") and t:GetBoundingBox() or (t:IsA("BasePart") and t.CFrame or nil), t.Size
end

local function lerpVal(a, b, t) return a + (b - a) * math.clamp(t, 0, 1) end
local function lerpVec(a, b, t) return Vector2.new(lerpVal(a.X, b.X, t), lerpVal(a.Y, b.Y, t)) end

local SkeletonBones = {
    {"Head","UpperTorso"},{"UpperTorso","LowerTorso"},{"UpperTorso","LeftUpperArm"},{"LeftUpperArm","LeftLowerArm"},{"LeftLowerArm","LeftHand"},
    {"UpperTorso","RightUpperArm"},{"RightUpperArm","RightLowerArm"},{"RightLowerArm","RightHand"},{"LowerTorso","LeftUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},
    {"LeftLowerLeg","LeftFoot"},{"LowerTorso","RightUpperLeg"},{"RightUpperLeg","RightLowerLeg"},{"RightLowerLeg","RightFoot"},
    {"Head","Torso"},{"Torso","Left Arm"},{"Torso","Right Arm"},{"Torso","Left Leg"},{"Torso","Right Leg"}
}

-- API Setters
for _, k in ipairs({"Toggle", "SetTracers", "SetBoxes", "SetHighlight", "SetNames", "SetDistance", "SetSkeletons", "SetHealthbar", "SetRainbow"}) do
    ESP[k] = function(self, state) self[k:gsub("Set", "")] = (state ~= nil) and state or not self[k:gsub("Set", "")] end
end
function ESP:SetRainbowSpeed(s) if type(s)=="number" then self.RainbowSpeed=s end end
function ESP:SetDelayEsp(d) if type(d)=="number" then self.RenderDelay=d end end
function ESP:SetTweenTime(t) if type(t)=="number" then self.TweenTime=t end end
function ESP:SetTracerOrigin(m) if type(m)=="string" then self.TracerOrigin = m:sub(1,1):upper()..m:sub(2):lower() end end

function ESP:SetBoxTransparent(transTable)
    if type(transTable) == "table" then
        if transTable.Outline ~= nil then self.Transparency.Outline = transTable.Outline end
        if transTable.Fill ~= nil then self.Transparency.Fill = transTable.Fill end
        if transTable[1] ~= nil then self.Transparency.Outline = transTable[1] end
        if transTable[2] ~= nil then self.Transparency.Fill = transTable[2] end
    end
end

-- Core Drawing Setup
local function createDrawObject(isPlayer)
    local obj = { Highlight = Instance.new("Highlight", ESP_Folder), Alpha = 0, CurrBoxPos = Vector2.zero, CurrBoxSize = Vector2.zero }
    obj.Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    if HasDrawing then
        obj.Text, obj.DistText, obj.Tracer, obj.Box = Drawing.new("Text"), Drawing.new("Text"), Drawing.new("Line"), Drawing.new("Square")
        obj.Text.Center, obj.DistText.Center = true, true
        if isPlayer then
            obj.HlOutline, obj.HlBar = Drawing.new("Square"), Drawing.new("Square")
            obj.Skeletons = {}
            for i = 1, #SkeletonBones do
                local l = Drawing.new("Line") l.Thickness = ESP.SkeletonThickness; obj.Skeletons[i] = l
            end
        end
    else
        obj.Billboard = Instance.new("BillboardGui", ESP_Folder)
        obj.Billboard.Size, obj.Billboard.AlwaysOnTop = UDim2.new(0, 200, 0, isPlayer and 60 or 50), true
        
        obj.BoxFrame = Instance.new("Frame", obj.Billboard)
        obj.BoxFrame.Size, obj.BoxFrame.Position = UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0)
        obj.BoxFrame.BackgroundTransparency = 1
        obj.BoxFrame.BorderSizePixel = 0

        obj.NameLabel = Instance.new("TextLabel", obj.Billboard)
        obj.NameLabel.Size, obj.NameLabel.BackgroundTransparency, obj.NameLabel.TextSize, obj.NameLabel.TextColor3 = UDim2.new(1,0,0,20), 1, 14, ESP.TextColor
        obj.NameLabel.TextStrokeTransparency = 0
        obj.DistLabel = Instance.new("TextLabel", obj.Billboard)
        obj.DistLabel.Size, obj.DistLabel.Position, obj.DistLabel.BackgroundTransparency, obj.DistLabel.TextSize, obj.DistLabel.TextColor3 = UDim2.new(1,0,0,15), UDim2.new(0,0,0,20), 1, 12, ESP.TextColor
        obj.DistLabel.TextStrokeTransparency = 0
        
        if isPlayer then
            obj.HealthBG = Instance.new("Frame", obj.Billboard)
            obj.HealthBG.Size, obj.HealthBG.Position, obj.HealthBG.BackgroundColor3, obj.HealthBG.BorderSizePixel = UDim2.new(0.6,0,0,4), UDim2.new(0.2,0,0,38), Color3.new(0,0,0), 0
            obj.HealthBar = Instance.new("Frame", obj.HealthBG)
            obj.HealthBar.Size, obj.HealthBar.BackgroundColor3, obj.HealthBar.BorderSizePixel = UDim2.new(1,0,1,0), Color3.new(0,1,0), 0
            
            -- Gui dùng để chứa các đoạn xương ScreenGui/Frame 2D
            obj.SkeletonGui = Instance.new("ScreenGui", ESP_Folder)
            obj.SkeletonGui.ResetOnSpawn = false
            obj.Skeletons = {}
            for i = 1, #SkeletonBones do
                local f = Instance.new("Frame", obj.SkeletonGui)
                f.AnchorPoint = Vector2.new(0.5, 0.5)
                f.BorderSizePixel = 0
                f.Visible = false
                obj.Skeletons[i] = f
            end
        end
    end
    return obj
end

local function cleanObject(obj)
    if not obj then return end
    if obj.Connection then pcall(function() obj.Connection:Disconnect() end) end
    if HasDrawing then
        for _, k in pairs({"Text", "DistText", "Tracer", "Box", "HlOutline", "HlBar"}) do if obj[k] then pcall(function() obj[k]:Remove() end) end end
        if obj.Skeletons then for _, l in pairs(obj.Skeletons) do pcall(function() l:Remove() end) end end
    else
        if obj.SkeletonGui then pcall(function() obj.SkeletonGui:Destroy() end) end
    end
    if obj.Highlight then pcall(function() obj.Highlight:Destroy() end) end
    if obj.Billboard then pcall(function() obj.Billboard:Destroy() end) end
end

function ESP:RemoveEsp(target)
    if not target then return end
    if ObjectsCache[target] then cleanObject(ObjectsCache[target]); ObjectsCache[target] = nil end
    if Cache[target] then cleanObject(Cache[target]); Cache[target] = nil end
end

-- Add Object ESP
function ESP:AddESP(target, config)
    if not target or ObjectsCache[target] then return ObjectsCache[target] end
    config = config or {}
    local obj = createDrawObject(false)
    ObjectsCache[target] = obj
    local lastRender = 0

    obj.Connection = RunService.RenderStepped:Connect(function(dt)
        if ESP.RenderDelay > 0 and (tick() - lastRender) < ESP.RenderDelay then return end
        lastRender = tick()
        if not target or not target.Parent then cleanObject(obj); ObjectsCache[target] = nil; return end
        
        if not ESP.Enabled then
            if HasDrawing then obj.Text.Visible, obj.DistText.Visible, obj.Tracer.Visible, obj.Box.Visible = false, false, false, false end
            obj.Highlight.Enabled = false; if obj.Billboard then obj.Billboard.Enabled = false end
            return
        end

        local cf, size = getBounding(target)
        if not cf then return end
        local pos, onScreen = Camera:WorldToViewportPoint(cf.Position)
        local dist = (getOriginPos() - cf.Position).Magnitude

        obj.Alpha = lerpVal(obj.Alpha, (dist <= ESP.MaxDistance and onScreen and pos.Z > 0) and 1 or 0, dt * (1 / math.max(ESP.TweenTime, 0.05)))
        if obj.Alpha < 0.05 then
            if HasDrawing then obj.Text.Visible, obj.DistText.Visible, obj.Tracer.Visible, obj.Box.Visible = false, false, false, false end
            obj.Highlight.Enabled = false; return
        end

        local baseCol = ESP.Rainbow and CurrentRainbowColor or nil
        local txtCol = resolveColor(config.TextColor or ESP.TextColorFunction, target, baseCol or config.Color or ESP.TextColor)
        local boxCol = resolveColor(config.BoxColor or ESP.BoxColorFunction, target, baseCol or config.Color or ESP.BoxColor)
        local traceCol = resolveColor(config.TracerColor or ESP.TracerColorFunction, target, baseCol or config.Color or ESP.TracerColor)
        local hlCol = resolveColor(config.HighlightColor or ESP.HighlightColorFunction, target, baseCol or config.Color or ESP.BoxColor)

        if HasDrawing then
            if ESP.Names then
                obj.Text.Size, obj.Text.Font, obj.Text.Outline, obj.Text.Text = ESP.TextSize, ESP.Font, ESP.TextOutline, tostring(config.Name or target.Name)
                obj.Text.Position, obj.Text.Color, obj.Text.Transparency, obj.Text.Visible = lerpVec(obj.CurrBoxPos, Vector2.new(pos.X, pos.Y-20), dt*15), txtCol, ESP.Transparency.Text * obj.Alpha, true
                obj.DistText.Visible = ESP.ShowDistance
                if ESP.ShowDistance then
                    obj.DistText.Size, obj.DistText.Font, obj.DistText.Outline, obj.DistText.Text = ESP.TextSize-2, ESP.Font, ESP.TextOutline, string.format("[%dm]", math.floor(dist))
                    obj.DistText.Position, obj.DistText.Color, obj.DistText.Transparency = Vector2.new(pos.X, pos.Y-5), txtCol, ESP.Transparency.Text * obj.Alpha
                end
            else obj.Text.Visible, obj.DistText.Visible = false, false end

            if ESP.Boxes then
                local top, bot = Camera:WorldToViewportPoint((cf * CFrame.new(0, size.Y/2, 0)).Position), Camera:WorldToViewportPoint((cf * CFrame.new(0, -size.Y/2, 0)).Position)
                local h = math.max(math.abs(top.Y - bot.Y), 10)
                local w = math.clamp(h * (size.X / size.Y), 10, 500)
                obj.CurrBoxSize, obj.CurrBoxPos = lerpVec(obj.CurrBoxSize, Vector2.new(w, h), dt*15), lerpVec(obj.CurrBoxPos, Vector2.new(pos.X - w/2, pos.Y - h/2), dt*15)
                obj.Box.Thickness, obj.Box.Size, obj.Box.Position, obj.Box.Color, obj.Box.Transparency, obj.Box.Visible = ESP.BoxThickness, obj.CurrBoxSize, obj.CurrBoxPos, boxCol, ESP.Transparency.Outline * obj.Alpha, true
            else obj.Box.Visible = false end

            if ESP.Tracers then
                obj.Tracer.Thickness, obj.Tracer.From, obj.Tracer.To, obj.Tracer.Color, obj.Tracer.Transparency, obj.Tracer.Visible = ESP.TracerThickness, getTracerPos(ESP.TracerOrigin), Vector2.new(pos.X, pos.Y), traceCol, obj.Alpha, true
            else obj.Tracer.Visible = false end
        else
            obj.Billboard.Adornee = target:IsA("Model") and (target.PrimaryPart or target:FindFirstChildWhichIsA("BasePart")) or target
            obj.NameLabel.Text, obj.NameLabel.TextColor3 = tostring(config.Name or target.Name), txtCol
            obj.DistLabel.Visible = ESP.ShowDistance
            if ESP.ShowDistance then obj.DistLabel.Text, obj.DistLabel.TextColor3 = string.format("[%dm]", math.floor(dist)), txtCol end
            obj.Billboard.Enabled = ESP.Names
            
            if ESP.Boxes and obj.BoxFrame then
                obj.BoxFrame.BackgroundColor3 = boxCol
                obj.BoxFrame.BackgroundTransparency = 1 - (ESP.Transparency.Fill * obj.Alpha)
                obj.BoxFrame.Visible = true
            elseif obj.BoxFrame then
                obj.BoxFrame.Visible = false
            end
        end

        if ESP.Highlight then
            obj.Highlight.Adornee = target
            obj.Highlight.OutlineColor, obj.Highlight.FillColor = hlCol, ESP.FillColor
            obj.Highlight.OutlineTransparency, obj.Highlight.FillTransparency = 1 - (ESP.Transparency.Outline * obj.Alpha), 1 - (ESP.Transparency.Fill * obj.Alpha)
            obj.Highlight.Enabled = true
        else obj.Highlight.Enabled = false end
    end)
    return obj
end

-- Player ESP Setup
function ESP:CheckTeam(p)
    if not p or p == LocalPlayer then return true end
    if type(self.CheckTeamFunction) == "function" then local s, r = pcall(self.CheckTeamFunction, p); if s then return r end end
    if self.PlayerConfig.Team and p.Team and LocalPlayer.Team then return p.Team == LocalPlayer.Team end
    return false
end

local function setupPlayer(player, config)
    if not player or player == LocalPlayer or Cache[player] then return end
    config = config or ESP.PlayerConfig
    local obj = createDrawObject(true)
    Cache[player] = obj
    local lastRender = 0

    obj.Connection = RunService.RenderStepped:Connect(function(dt)
        if ESP.RenderDelay > 0 and (tick() - lastRender) < ESP.RenderDelay then return end
        lastRender = tick()
        if not player.Parent then cleanObject(obj); Cache[player] = nil; return end

        local char, hum, hrp = player.Character, player.Character and player.Character:FindFirstChildOfClass("Humanoid"), player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if not ESP.Enabled or not char or not hrp or not hum or hum.Health <= 0 or ESP:CheckTeam(player) then
            if HasDrawing then
                obj.Text.Visible, obj.DistText.Visible, obj.Tracer.Visible, obj.Box.Visible = false, false, false, false
                for _,l in pairs(obj.Skeletons) do l.Visible=false end
            else
                if obj.Skeletons then for _,f in pairs(obj.Skeletons) do f.Visible=false end end
            end
            obj.Highlight.Enabled = false; if obj.Billboard then obj.Billboard.Enabled = false end
            return
        end

        local head = char:FindFirstChild("Head")
        local pos, onScreen = Camera:WorldToViewportPoint(head and head.Position or hrp.Position)
        local dist = (getOriginPos() - hrp.Position).Magnitude

        obj.Alpha = lerpVal(obj.Alpha, (dist <= ESP.MaxDistance and onScreen and pos.Z > 0) and 1 or 0, dt * (1 / math.max(ESP.TweenTime, 0.05)))
        if obj.Alpha < 0.05 then
            if HasDrawing then
                obj.Text.Visible, obj.DistText.Visible, obj.Tracer.Visible, obj.Box.Visible = false, false, false, false
                for _,l in pairs(obj.Skeletons) do l.Visible=false end
            else
                if obj.Skeletons then for _,f in pairs(obj.Skeletons) do f.Visible=false end end
            end
            obj.Highlight.Enabled = false; return
        end

        local baseCol = ESP.Rainbow and CurrentRainbowColor or nil
        local txtCol = resolveColor(config.TextColor or ESP.TextColorFunction, player, baseCol or ESP.TextColor)
        local boxCol = resolveColor(config.BoxColor or ESP.BoxColorFunction, player, baseCol or ESP.BoxColor)
        local traceCol = resolveColor(config.TracerColor or ESP.TracerColorFunction, player, baseCol or ESP.TracerColor)
        local hlCol = resolveColor(config.HighlightColor or ESP.HighlightColorFunction, player, baseCol or ESP.HighlightColor)
        local skelCol = resolveColor(ESP.SkeletonColorFunction, player, baseCol or ESP.SkeletonColor)

        if config.TeamColor and player.TeamColor then
            txtCol, boxCol, traceCol, hlCol, skelCol = player.TeamColor.Color, player.TeamColor.Color, player.TeamColor.Color, player.TeamColor.Color, player.TeamColor.Color
        end

        if HasDrawing then
            if ESP.Names then
                obj.Text.Size, obj.Text.Font, obj.Text.Outline, obj.Text.Text = ESP.TextSize, ESP.Font, ESP.TextOutline, player.DisplayName
                obj.Text.Position, obj.Text.Color, obj.Text.Transparency, obj.Text.Visible = Vector2.new(pos.X, pos.Y - 32), txtCol, ESP.Transparency.Text * obj.Alpha, true
                obj.DistText.Visible = ESP.ShowDistance
                if ESP.ShowDistance then
                    obj.DistText.Size, obj.DistText.Font, obj.DistText.Outline, obj.DistText.Text = ESP.TextSize-2, ESP.Font, ESP.TextOutline, string.format("[%dm]", math.floor(dist))
                    obj.DistText.Position, obj.DistText.Color, obj.DistText.Transparency = Vector2.new(pos.X, pos.Y - 14), txtCol, ESP.Transparency.Text * obj.Alpha
                end
            else obj.Text.Visible, obj.DistText.Visible = false, false end

            local headV = Camera:WorldToViewportPoint(head and head.Position or pos)
            local legV = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
            local h = math.abs(headV.Y - legV.Y)
            local w = h / 1.5
            obj.CurrBoxSize, obj.CurrBoxPos = lerpVec(obj.CurrBoxSize, Vector2.new(w, h), dt*15), lerpVec(obj.CurrBoxPos, Vector2.new(pos.X - w/2, pos.Y - h/2), dt*15)

            if ESP.Boxes then
                obj.Box.Thickness, obj.Box.Size, obj.Box.Position, obj.Box.Color, obj.Box.Transparency, obj.Box.Visible = ESP.BoxThickness, obj.CurrBoxSize, obj.CurrBoxPos, boxCol, ESP.Transparency.Outline * obj.Alpha, true
            else obj.Box.Visible = false end

            if ESP.Tracers then
                obj.Tracer.Thickness, obj.Tracer.From, obj.Tracer.To, obj.Tracer.Color, obj.Tracer.Transparency, obj.Tracer.Visible = ESP.TracerThickness, getTracerPos(ESP.TracerOrigin), Vector2.new(pos.X, pos.Y), traceCol, obj.Alpha, true
            else obj.Tracer.Visible = false end

            if ESP.Healthbar then
                local hpPct = math.clamp(hum.Health / math.max(hum.MaxHealth, 1), 0, 1)
                obj.HlOutline.Size, obj.HlOutline.Position, obj.HlOutline.Color, obj.HlOutline.Filled, obj.HlOutline.Transparency, obj.HlOutline.Visible = Vector2.new(4, obj.CurrBoxSize.Y+2), Vector2.new(obj.CurrBoxPos.X - 8, obj.CurrBoxPos.Y - 1), Color3.new(0,0,0), true, 0.5 * obj.Alpha, true
                local bH = obj.CurrBoxSize.Y * hpPct
                obj.HlBar.Size, obj.HlBar.Position, obj.HlBar.Color, obj.HlBar.Filled, obj.HlBar.Transparency, obj.HlBar.Visible = Vector2.new(2, bH), Vector2.new(obj.CurrBoxPos.X - 7, obj.CurrBoxPos.Y + (obj.CurrBoxSize.Y - bH)), Color3.new(1,0,0):Lerp(Color3.new(0,1,0), hpPct), true, obj.Alpha, true
            else obj.HlOutline.Visible, obj.HlBar.Visible = false, false end

            if ESP.Skeletons then
                for idx, pair in ipairs(SkeletonBones) do
                    local p1, p2, line = char:FindFirstChild(pair[1]), char:FindFirstChild(pair[2]), obj.Skeletons[idx]
                    if p1 and p2 then
                        local v1, vis1 = Camera:WorldToViewportPoint(p1.Position)
                        local v2, vis2 = Camera:WorldToViewportPoint(p2.Position)
                        if vis1 and vis2 then
                            line.From, line.To, line.Color, line.Thickness, line.Transparency, line.Visible = Vector2.new(v1.X, v1.Y), Vector2.new(v2.X, v2.Y), skelCol, ESP.SkeletonThickness, obj.Alpha, true
                        else line.Visible = false end
                    else line.Visible = false end
                end
            else for _, l in pairs(obj.Skeletons) do l.Visible = false end end
        else
            obj.Billboard.Adornee = head or hrp
            obj.NameLabel.Text, obj.NameLabel.TextColor3 = player.DisplayName, txtCol
            obj.DistLabel.Visible = ESP.ShowDistance
            if ESP.ShowDistance then obj.DistLabel.Text, obj.DistLabel.TextColor3 = string.format("[%dm]", math.floor(dist)), txtCol end
            obj.Billboard.Enabled = ESP.Names
            
            if ESP.Boxes and obj.BoxFrame then
                obj.BoxFrame.BackgroundColor3 = boxCol
                obj.BoxFrame.BackgroundTransparency = 1 - (ESP.Transparency.Fill * obj.Alpha)
                obj.BoxFrame.Visible = true
            elseif obj.BoxFrame then
                obj.BoxFrame.Visible = false
            end

            if ESP.Healthbar then
                obj.HealthBar.Size = UDim2.new(math.clamp(hum.Health / math.max(hum.MaxHealth, 1), 0, 1), 0, 1, 0)
                obj.HealthBG.BackgroundTransparency = 1 - (ESP.Transparency.Outline * obj.Alpha)
                obj.HealthBar.BackgroundTransparency = 1 - (ESP.Transparency.Fill * obj.Alpha)
                obj.HealthBG.Visible = true
            else obj.HealthBG.Visible = false end

            -- Vẽ Skeleton bằng các đoạn Frame 2D xoay theo tọa độ màn hình
            if ESP.Skeletons then
                for idx, pair in ipairs(SkeletonBones) do
                    local p1, p2, frame = char:FindFirstChild(pair[1]), char:FindFirstChild(pair[2]), obj.Skeletons[idx]
                    if p1 and p2 then
                        local v1, vis1 = Camera:WorldToViewportPoint(p1.Position)
                        local v2, vis2 = Camera:WorldToViewportPoint(p2.Position)
                        if vis1 and vis2 then
                            local pos1, pos2 = Vector2.new(v1.X, v1.Y), Vector2.new(v2.X, v2.Y)
                            local mid = (pos1 + pos2) / 2
                            local len = (pos1 - pos2).Magnitude
                            local rot = math.deg(math.atan2(pos2.Y - pos1.Y, pos2.X - pos1.X))

                            frame.Size = UDim2.new(0, len, 0, ESP.SkeletonThickness)
                            frame.Position = UDim2.new(0, mid.X, 0, mid.Y)
                            frame.Rotation = rot
                            frame.BackgroundColor3 = skelCol
                            frame.BackgroundTransparency = 1 - obj.Alpha
                            frame.Visible = true
                        else frame.Visible = false end
                    else frame.Visible = false end
                end
            else for _, f in pairs(obj.Skeletons) do f.Visible = false end end
        end

        if ESP.Highlight then
            obj.Highlight.Adornee = char
            obj.Highlight.OutlineColor, obj.Highlight.FillColor = hlCol, ESP.FillColor
            obj.Highlight.OutlineTransparency, obj.Highlight.FillTransparency = 1 - (ESP.Transparency.Outline * obj.Alpha), 1 - (ESP.Transparency.Fill * obj.Alpha)
            obj.Highlight.Enabled = true
        else obj.Highlight.Enabled = false end
    end)
end

function ESP:AddEspPlayer(params)
    local cfg = {} for k,v in pairs(self.PlayerConfig) do cfg[k]=v end
    if type(params) == "table" then
        if type(params.Team) == "function" then self.CheckTeamFunction = params.Team elseif params.Team ~= nil then cfg.Team = params.Team end
        for _, k in ipairs({"Text", "Name", "TeamColor", "Distance", "Color"}) do if params[k] ~= nil then cfg[k] = params[k] end end
    end
    for _, p in pairs(Players:GetPlayers()) do setupPlayer(p, cfg) end
end

for _, p in pairs(Players:GetPlayers()) do setupPlayer(p) end
Connections.PlayerAdded = Players.PlayerAdded:Connect(function(p) setupPlayer(p) end)
Connections.PlayerRemoving = Players.PlayerRemoving:Connect(function(p) ESP:RemoveEsp(p) end)

function ESP:Unload()
    self.Enabled = false
    for _, conn in pairs(Connections) do pcall(function() conn:Disconnect() end) end
    table.clear(Connections)
    for _, obj in pairs(Cache) do cleanObject(obj) end
    for _, obj in pairs(ObjectsCache) do cleanObject(obj) end
    if ESP_Folder then pcall(function() ESP_Folder:Destroy() end) end
    table.clear(Cache); table.clear(ObjectsCache)
end

return ESP
