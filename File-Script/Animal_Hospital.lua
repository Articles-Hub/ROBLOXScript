if not game:IsLoaded() then
    game.Loaded:Wait()
end

if makefolder then makefolder("Translate") end
if writefile and isfile and not isfile("Translate/Animal-Hospital") then
	writefile("Translate/Animal-Hospital", "en")
end

pcall(function()
	if readfile then
		local TranslateFile = readfile("Translate/Animal-Hospital")
		Translate = loadstring(game:HttpGet("https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/Translate/Animal%20Hospital/"..TranslateFile..".luau"))()
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
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Backpack = LocalPlayer:WaitForChild("Backpack")

spawn(function()
	while true do
		Character = LocalPlayer.Character or nil
		RootPart = (Character and Character:FindFirstChild("HumanoidRootPart")) or nil
		Humanoid = (Character and Character:FindFirstChild("Humanoid")) or nil
	task.wait()
	end
end)

local allItems = {
    "Eye Drops", "IV Drops", "Medkit", "Thermo", 
    "Ointment", "Bandages", "Maple Syrup", "Cough Syrup", 
    "Medicine", "Herbs", "Organ", "Scalpel", "Transplant"
}

local treatedNPCs = {}
local IsCurrentlyTreating = false

--- Function ---

_G.Connect = {}
function Connect(Signal, Function)
	local SignalConnect = Signal:Connect(Function)
    table.insert(_G.Connect, SignalConnect)
    return SignalConnect
end

function t(text)
	return (Translate and Translate[text]) or text
end

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

function GetTool(name)
	local SuccessFound
	local function Check(object)
		if object:IsA("Tool") and object.Name:lower():find(name:lower()) then
			SuccessFound = object
		end
	end
	for i, v in pairs(Character:GetChildren()) do
		Check(v)
	end
	for i, v in pairs(Backpack:GetChildren()) do
		Check(v)
	end
	return SuccessFound
end

function CheckTool()
	local SuccessFound = {}
	local function Check(object)
		if object:IsA("Tool") and not object:GetAttribute("Liquid") and object:GetAttribute("Steanlable") then
			table.insert(SuccessFound, object)
		end
	end
	for i, v in pairs(Character:GetChildren()) do
		Check(v)
	end
	for i, v in pairs(Backpack:GetChildren()) do
		Check(v)
	end
	return SuccessFound
end

local function GetItem(root, ...)
    local current = root
    for _, name in ipairs({...}) do
        if not current then return nil end
        if type(name) == "number" then
            local children = current:GetChildren()
            current = children[name]
        else
            current = current:FindFirstChild(name)
        end
    end
    return current
end

local function PositionModel(inst)
    if not inst then return nil end
    if inst:IsA("Model") then
        if inst.PrimaryPart then
            return inst.PrimaryPart.Position
        end
        return inst:GetPivot().Position
    elseif inst:IsA("BasePart") then
        return inst.Position
    end
    return nil
end

local function findItem(name)
    local targetInstance = nil
    if name == "Organ" then
        targetInstance = GetItem(workspace, "Rooms", "Emergency", "Room8", "Minigame", "Medicine", 3, "Organ")
    elseif name == "Scalpel" then
        targetInstance = GetItem(workspace, "Rooms", "Emergency", "Room8", "Minigame", "Medicine", "Model", "Scalpel")
    elseif name == "Transplant" then
        targetInstance = GetItem(workspace, "Rooms", "Emergency", "Room8", "Minigame", "Medicine", "Model", "Transplant")
    end
    if targetInstance then
        local prompt = targetInstance:FindFirstChildOfClass("ProximityPrompt") or targetInstance:FindFirstChild("PP")
        if prompt then
            return prompt, targetInstance
        end
    end
    for _, desc in ipairs(workspace:GetDescendants()) do
        if desc:IsA("ProximityPrompt") then
            local parent = desc.Parent
            local model = parent and parent:FindFirstAncestorOfClass("Model")
            if (parent and parent.Name == name) or (model and model.Name == name) then
                return desc, (model or parent)
            end
        end
    end
    return nil
end

local function isAnom()
    local npcsFolder = workspace:FindFirstChild("NPCs")
    if not npcsFolder then return false end
    local checkIn1 = workspace:FindFirstChild("Misc") and workspace.Misc:FindFirstChild("CheckIn")
    local checkIn2 = workspace:FindFirstChild("Misc") and workspace.Misc:FindFirstChild("CheckIn2")
    for _, npc in ipairs(npcsFolder:GetChildren()) do
        if npc:IsA("Model") and npc.PrimaryPart then
            local isSkinwalker = npc:GetAttribute("Skinwalker")
            if isSkinwalker then
                if checkIn1 then
                    local bell = checkIn1:FindFirstChild("Bell")
                    local bellPos = PositionModel(bell) or PositionModel(checkIn1:FindFirstChild("Form"))
                    if bellPos and (npc.PrimaryPart.Position - bellPos).Magnitude <= 5 then
                        return true, checkIn1, "CheckIn"
                    end
                end  
                if checkIn2 then
                    local bell = checkIn2:FindFirstChild("Bell")
                    local bellPos = PositionModel(bell) or PositionModel(checkIn2:FindFirstChild("Form"))
                    if bellPos and (npc.PrimaryPart.Position - bellPos).Magnitude <= 5 then
                        return true, checkIn2, "CheckIn2"
                    end
                end
            end
        end
    end
    return false
end

function GetRoom(number)
    if number >= 1 and number <= 5 then
        return workspace:FindFirstChild("Rooms") and workspace.Rooms:FindFirstChild("Medical") and workspace.Rooms.Medical:FindFirstChild("Room"..number)
    elseif number >= 6 and number <= 8 then
        return workspace:FindFirstChild("Rooms") and workspace.Rooms:FindFirstChild("Emergency") and workspace.Rooms.Emergency:FindFirstChild("Room"..number)
    end
    return nil
end

function CheckInv(room)
    local inv = room:FindFirstChild("Minigame") 
        and room.Minigame:FindFirstChild("TV")
        and room.Minigame.TV:FindFirstChild("Screen")
        and room.Minigame.TV.Screen:FindFirstChild("UI")
        and room.Minigame.TV.Screen.UI:FindFirstChild("Report")
        and room.Minigame.TV.Screen.UI.Report:FindFirstChild("inv")
        
    if not inv then
        for _, v in ipairs(room:GetDescendants()) do
            if v.Name == "inv" and v.Parent and v.Parent.Name == "Report" then
                inv = desc
                break
            end
        end
    end
    return inv
end

local BedDetectionRadius = 1
local XrayDetectionRadius = 2.5
local function getRoom(num)
    local room = GetRoom(num)
    if not room then return nil, nil end
    if num == 6 then
        local targetPos = Vector3.new(-181.62, 3.01, 53.96)
        local npcsFolder = workspace:FindFirstChild("NPCs")
        if npcsFolder then
            for _, npc in ipairs(npcsFolder:GetChildren()) do
                if npc:IsA("Model") and npc.PrimaryPart then
                    if (npc.PrimaryPart.Position - targetPos).Magnitude <= XrayDetectionRadius then
                        return npc, targetPos
                    end
                end
            end
        end
        return nil, nil
    end
    local checkPart = room:FindFirstChild("Minigame") and room.Minigame:FindFirstChild("Bed")
    if not checkPart then return nil, nil end
    local checkPos = checkPart:IsA("Model") and checkPart:GetPivot().Position or checkPart.Position
    local npcsFolder = workspace:FindFirstChild("NPCs")
    if npcsFolder then
        for _, npc in ipairs(npcsFolder:GetChildren()) do
            if npc:IsA("Model") and npc:GetAttribute("InBed") and npc.PrimaryPart then
                if (npc.PrimaryPart.Position - checkPos).Magnitude <= BedDetectionRadius then
                    return npc, checkPos
                end
            end
        end
    end
    return nil, nil
end

local function shutBtn(desk, name)
    local misc = Workspace:FindFirstChild("Misc")
    if not misc then return nil end
    local shutter = desk:FindFirstChild("ShutterButton") or desk:FindFirstChild("Shutter")
    if shutter then return shutter end
    local suffix = string.match(name, "%d+$") or ""
    if suffix ~= "" then
        shutter = misc and (misc:FindFirstChild("ShutterButton" .. suffix) or misc:FindFirstChild("Shutter" .. suffix))
        if shutter then return shutter end
    end
    return misc:FindFirstChild("ShutterButton") or misc:FindFirstChild("Shutter")
end

local ClosedShutters = {}
local function actNpc(desk)
    local NPCs = workspace:FindFirstChild("NPCs")
    local form = desk:FindFirstChild("Form")
    if not NPCs or not form then return nil end
    local formPos = PositionModel(form)
    if not formPos then return nil end
    local closestNPC = nil
    local minDistance = math.huge
    for _, npc in ipairs(NPCs:GetChildren()) do
        local hrp = npc:FindFirstChild("HumanoidRootPart")
        if hrp then
            local dist = (hrp.Position - formPos).Magnitude
            if dist < minDistance then
                minDistance = dist
                closestNPC = npc
            end
        end
    end
    if minDistance < 8 then
        return closestNPC
    end
    return nil
end

local function getJobs()
    local jobs = {}
    for _, deskName in ipairs({"CheckIn", "CheckIn2"}) do
        local desk = workspace:FindFirstChild("Misc") and workspace.Misc:FindFirstChild(deskName)
        if desk then
            local form = desk:FindFirstChild("Form")
            local formPrompt = form and form:FindFirstChild("PP")
            local camera = desk:FindFirstChild("Camera")
            local cameraPrompt = camera and camera:FindFirstChild("PP")
            if formPrompt or (cameraPrompt and cameraPrompt.Enabled) then
                local npc = actNpc(desk)
                if npc then
                    local isSkinwalker = npc:GetAttribute("Skinwalker")
                    table.insert(jobs, {
                        deskName = deskName,
                        desk = desk,
                        formPrompt = formPrompt,
                        npc = npc,
                        isSkinwalker = isSkinwalker
                    })
                end
            end
        end
    end
    return jobs
end

local function isShutClsd()
    local shutterPart = workspace:FindFirstChild("Misc") and workspace.Misc:FindFirstChild("Shutters") and workspace.Misc.Shutters:FindFirstChild("Part")
    if shutterPart then
        return shutterPart.Position.Y < 8.2
    end
    return false
end

function GetCF(inst)
    if not inst then return nil end
    if inst:IsA("Model") then
        return inst:GetPivot()
    elseif inst:IsA("BasePart") then
        return inst.CFrame
    end
    
    local parent = inst.Parent
    if parent then
        if parent:IsA("Model") then
            return parent:GetPivot()
        elseif parent:IsA("BasePart") then
            return parent.CFrame
        end
    end
    return nil
end

function GetProximity(inst, name)
    if not inst then
        return nil
    end
    if inst:IsA("ProximityPrompt") then
        if not name or v.Name:lower():find(name:lower()) then
		    return v
		end
    end
    for _, v in ipairs(inst:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            if not name or v.Name:lower():find(name:lower()) then
			    return v
			end
        end
    end
    return nil
end

local function FindInParents(obj, className)
	while obj and obj ~= workspace do
		if obj:IsA(className) then
			return obj
		end
		local found = obj:FindFirstChildWhichIsA(className, true)
		if found then
			return found
		end
		obj = obj.Parent
	end
	return nil
end

function Distance(Target)
	if RootPart then
		local part = Target:IsA("BasePart") and Target or GetCF(Target)
		if not part then
			return 9e9
		end
		return (RootPart.Position - part.Position).Magnitude
	end
end

local function Teleport(tgt, dist)
    if RootPart and Humanoid and Humanoid.Health > 0 then
        RootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        RootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        local targetCF
        if typeof(tgt) == "Instance" then
            if tgt:IsA("Model") then
                targetCF = tgt:GetPivot()
            elseif tgt:IsA("BasePart") then
                targetCF = tgt.CFrame
            end
        elseif typeof(tgt) == "CFrame" then
            targetCF = tgt
        end
        if not targetCF then return end
        local distance = dist or 1.2
        local targetPos = targetCF.Position
        local targetLook = targetCF.LookVector
        local lookDirection = Vector3.new(targetLook.X, 0, targetLook.Z)
        if lookDirection.Magnitude > 0 then
            lookDirection = lookDirection.Unit
        else
            lookDirection = Vector3.new(0, 0, -1) 
        end
        local spawnPos = targetPos + (lookDirection * distance) + Vector3.new(0, 0.2, 0)
        local lookAtTarget = Vector3.new(targetPos.X, spawnPos.Y, targetPos.Z)
        local targetRotation = CFrame.lookAt(spawnPos, lookAtTarget)
        Humanoid:ChangeState(Enum.HumanoidStateType.Running)
        RootPart.Anchored = true
        Character:PivotTo(targetRotation)
        task.wait(0.02)
        if RootPart then
            RootPart.Anchored = false
            RootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            RootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        end
    end
end

function Fire(object, data)
	data = data or {}
	if not object or typeof(object) ~= "Instance" then
		return
	end
	if data.fireclick and fireclickdetector then
		local click = FindInParents(object, "ClickDetector")
		if click then
			fireclickdetector(click, 0)
			fireclickdetector(click, 1)
		end
	end
	if data.firetouch and firetouchinterest and RootPart then
		local touch = GetCF(object)
		if touch then
			firetouchinterest(RootPart, touch, 0)
			firetouchinterest(RootPart, touch, 1)
		end
	end
	if data.fireprompt and fireproximityprompt then
		local prompt = FindInParents(object, "ProximityPrompt")
		if prompt then
			fireproximityprompt(prompt, 0)
			fireproximityprompt(prompt, 1)
		end
	end
end

function PromptSetting(Cooldown)
	if Cooldown:IsA("ProximityPrompt") then
		if _G.InstantPrompt then
			Cooldown:SetAttribute("__OldCooldown", Cooldown.HoldDuration)
			Cooldown.HoldDuration = 0
		else
			if Cooldown:GetAttribute("__OldCooldown") then
				Cooldown.HoldDuration = Cooldown:GetAttribute("__OldCooldown")
			end
		end
		if _G.PromptReach then
			Cooldown:SetAttribute("__OldReach", Cooldown.MaxActivationDistance)
			Cooldown.MaxActivationDistance = Cooldown.MaxActivationDistance * 1.5
		else
			if Cooldown:GetAttribute("__OldReach") then
				Cooldown.MaxActivationDistance = Cooldown:GetAttribute("__OldReach")
			end
		end
	end
end

function ActivePromptSetting()
	for _, v in ipairs(workspace:GetDescendants()) do
		PromptSetting(v)
	end
end

--- Script ---

_G.Table = {}
local function AddObject(obj)
	table.insert(_G.Table, obj)
	obj.Destroying:Connect(function()
		local index = table.find(_G.Table, obj)
		if index then
			table.remove(_G.Table, index)
		end
	end)
end

local function WatchFolder(folder)
	if not folder:IsA("Folder") then
		return
	end
	for _, obj in ipairs(folder:GetDescendants()) do
		AddObject(obj)
	end
	Connect(folder.DescendantAdded, AddObject)
end

for _, v in ipairs(workspace:GetChildren()) do
	WatchFolder(v)
end

Connect(workspace.ChildAdded, WatchFolder)
Connect(workspace.DescendantAdded, PromptSetting)

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

local OrionSource = game:HttpGet("https://raw.githubusercontent.com/tanhoangviet/OrionLib-Modded/main/scr/Orion.lua?cache=" .. tostring(os.time()))
local OrionLib = loadstring(OrionSource, "OrionLib")()

local Window = OrionLib:CreateWindow({
    Title = "Giang Hub",
    Author = "Open Here",
    Size = UDim2.fromOffset(690, 430),
    SidebarCompact = true,
    SidebarCompactWidth = 54,
})

local lastJump = 0
local FrameTimer = tick()
local FrameCounter = 0
local FPS = 60
local LastProcess = 0
local Delay = 0.5
Connect(RunService.Heartbeat, function()
	FrameCounter += 1
	if (tick() - FrameTimer) >= 1 then
	    FPS = FrameCounter
	    FrameTimer = tick()
	    FrameCounter = 0
	end
	if Humanoid then SpeedUp = Humanoid.WalkSpeed else SpeedUp = 0 end
	wminfo.setText(("%s Speed | %s FPS | %s MS"):format(
		math.floor(SpeedUp or 0),
	    math.floor(FPS),
	    math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
	))
	
	if RootPart and os.clock() - LastProcess > Delay then
		LastProcess = os.clock()
		for i, v in pairs(_G.Table) do
			if _G.AutoStampFireRoom and v:IsA("Model") and v.Name:lower():find("fire") then
				for _, l in pairs(v:GetDescendants()) do
					if l:IsA("BasePart") and l:FindFirstChild("PP") then
						if not (IsCurrentlyTreating and IsCurrentlyCheckIn and IsCurrentlyHelpNpc) then
							Teleport(l)
							task.wait(0.3)
							Fire(l.PP, {fireprompt = true})
						end
					end
				end
			end
		end
		if _G.AutoCleanSmile then
			for i, v in pairs(workspace.Misc:GetChildren()) do
				if v.Name:find("Slime") then
					local slimeCF = GetCF(v)
					local slimePrompt = v:FindFirstChild("PP", true)
					if slimeCF and slimePrompt and slimePrompt.Enabled then
						if not (IsCurrentlyTreating and IsCurrentlyCheckIn and IsCurrentlyHelpNpc) then
							Teleport(slimeCF)
							Fire(slimePrompt, {fireprompt = true})
						end
					end
				end
			end
		end
		if _G.AutoFixCamera then
			for i, v in pairs(workspace.Misc.Cameras:GetChildren()) do
				if v:FindFirstChild("MainLook") and v.MainLook:FindFirstChildOfClass("ProximityPrompt") then
					if not (IsCurrentlyTreating and IsCurrentlyCheckIn and IsCurrentlyHelpNpc) then
						Teleport(v.MainLook)
						Fire(v.MainLook:FindFirstChildOfClass("ProximityPrompt"), {fireprompt = true})
					end
				end
			end
		end
	end
	if _G.EspPlayer then
		for i, v in pairs(Players:GetPlayers()) do
			local Char = v.Character
			if v ~= LocalPlayer and Char and Char:FindFirstChild("HumanoidRootPart") and Char:FindFirstChild("Humanoid") then
				ESPLibrary:AddESP({
					Object = Char,
					Text = v.Name,
					Color = Color3.fromRGB(62, 36, 227)
				})
			end
		end
	end
	if _G.EspNPC then
		for i, v in pairs(workspace.NPCs:GetChildren()) do
			if v:IsA("Model") then
				if v:GetAttribute("Skinwalker") then
					ColorNPC = Color3.new(255, 0, 0)
					NameNpc = "Skinwalker"
				elseif v:GetAttribute("IsVisitor") and v:GetAttribute("IsVisitor") > 0 then
					ColorNPC = Color3.new(0, 0, 255)
					NameNpc = "Visitor"
				else
					ColorNPC = Color3.new(0, 255, 0)
					NameNpc = v.Name
				end
				ESPLibrary:AddESP({
					Object = v,
					Text = NameNpc,
					Color = ColorNPC
				})
				ESPLibrary:UpdateObjectText(v, NameNpc)
				ESPLibrary:UpdateObjectColor(v, ColorNPC)
				ESPLibrary:SetOutlineColor(ColorNPC)
			end
		end
	end
end)

Tabs = {
	Main = Window:Tab({Title = t"Main", Icon = "rbxassetid://7734053426"}),
	Misc = Window:Tab({Title = t"Misc", Icon = "rbxassetid://4370318685"}),
	["UI Settings"] = Window:Tab({Title = "UI Settings", Icon = "rbxassetid://7733955511"})
}

local Main = Tabs.Main
local ProcessGroup = Main:GroupBox({
    Title = t"Auto working",
})

ProcessGroup:Toggle({
    Title = t"Auto Check Npc",
    Value = false,
    Flag = "Auto Check Npc",
    Type = "Switch",
    Callback = function(Value)
_G.AutoCheckNpc = Value
if not _G.AutoCheckNpc then
	IsCurrentlyCheckIn = false
	oldCF = nil
end
while _G.AutoCheckNpc do
    if _G.AutoCheckNpc and (IsCurrentlyTreating or IsCurrentlyHelpNpc) then
        task.wait(0.5)
        continue
    end
    local anomalyNear, nearDesk, nearDeskName = isAnom()
    if anomalyNear then
        if not isShutClsd() then
            local shutterButton = shutBtn(nearDesk, nearDeskName)
            local shutterPrompt = shutterButton and shutterButton:FindFirstChild("PP")
            local shutterCF = GetCF(shutterButton)
            if shutterPrompt and shutterCF then
                Teleport(shutterCF)
                task.wait(0.3)
                Fire(shutterPrompt, {fireprompt = true})
                task.wait(0.5)
            end
        end
        task.wait(0.5)
        continue
    else
        if isShutClsd() then
            local checkInDesk = workspace:FindFirstChild("Misc") and workspace.Misc:FindFirstChild("CheckIn")
            if checkInDesk then
                local shutterButton = shutBtn(checkInDesk, "CheckIn")
                local shutterPrompt = shutterButton and shutterButton:FindFirstChild("PP")
                local shutterCF = GetCF(shutterButton)
                if shutterPrompt and shutterCF then
                    Teleport(shutterCF)
                    task.wait(0.3)
                    Fire(shutterPrompt, {fireprompt = true})
                    task.wait(0.5)
                end
            end
        end
    end
    local oldCF
    local jobs = getJobs()
    if #jobs > 0 then
        table.sort(jobs, function(a, b)
            if a.isSkinwalker ~= b.isSkinwalker then
                return not a.isSkinwalker
            end
            return false
        end)
        local currentJob = jobs[1]
        if currentJob and not currentJob.isSkinwalker then
	        IsCurrentlyCheckIn = true
			oldCF = RootPart and RootPart.CFrame
            local desk = currentJob.desk
            local deskName = currentJob.deskName
            local formPrompt = currentJob.formPrompt
            local npc = currentJob.npc
            local formCF = GetCF(desk:FindFirstChild("Form"))
            if formCF and formPrompt then
	            if formPrompt.Enabled then
	                Teleport(formCF)
	                task.wait(0.45)
	                Fire(formPrompt, {fireprompt = true})
	                task.wait(0.5)
				end
            end
            local camera = desk:FindFirstChild("Camera")
            local cameraPrompt = camera and camera:FindFirstChild("PP")
            local cameraCF = GetCF(camera)
            if cameraPrompt and cameraCF and cameraPrompt.Enabled then
                Teleport(cameraCF)
                task.wait(0.45)
                Fire(cameraPrompt, {fireprompt = true})
                task.wait(0.5)
            end
            local computer = desk:FindFirstChild("Computer")
            if not computer and deskName == "CheckIn2" then
                local checkIn1 = workspace:FindFirstChild("Misc") and workspace.Misc:FindFirstChild("CheckIn")
                computer = checkIn1 and checkIn1:FindFirstChild("Computer")
            end
            local computerPrompt = computer and computer:FindFirstChild("PP")
            local computerCF = GetCF(computer)
            if computerPrompt and computerCF and computerPrompt.Enabled then
                Teleport(computerCF)
                task.wait(0.45)
                Fire(computerPrompt, {fireprompt = true})
                task.wait(0.5)
            end
            local printer = desk:FindFirstChild("Printer")
            if not printer and deskName == "CheckIn2" then
                local checkIn1 = workspace:FindFirstChild("Misc") and workspace.Misc:FindFirstChild("CheckIn")
                printer = checkIn1 and checkIn1:FindFirstChild("Printer")
            end
            local printerPrompt = printer and printer:FindFirstChild("PP")
            local printerCF = GetCF(printer)
            if printerPrompt and printerCF and printerPrompt.Enabled then
                Teleport(printerCF)
                task.wait(0.45)
                Fire(printerPrompt, {fireprompt = true})
                task.wait(0.5)
            end
            local badge = nil
            local badgePrompt = nil
            local maxWait = 25 
            local waited = 0
            while _G.AutoCheckNpc and waited < maxWait do
                badge = desk:FindFirstChild("PrintedBadge")
                if not badge and deskName == "CheckIn2" then
                    local checkIn1 = workspace:FindFirstChild("Misc") and workspace.Misc:FindFirstChild("CheckIn")
                    badge = checkIn1 and checkIn1:FindFirstChild("PrintedBadge")
                end
                badgePrompt = badge and badge:FindFirstChild("PP")
                if badgePrompt and badgePrompt.Enabled then
                    break
                end
                task.wait(0.2)
                waited = waited + 0.2
            end      
            if badge and badgePrompt and badgePrompt.Enabled then
                local badgeCF = GetCF(badge)
                if badgeCF then
                    Teleport(badgeCF)
                    task.wait(0.45)
                    Fire(badgePrompt, {fireprompt = true})
                    task.wait(0.5)
                end
            end
            local npcPrompt = npc:FindFirstChild("PP") or npc:FindFirstChildOfClass("ProximityPrompt")
            local npcPart = npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChildOfClass("Part")
            local npcCF = GetCF(npcPart)
            if npcPrompt and npcCF and npcPrompt.Enabled then
                Teleport(npcCF)
                task.wait(0.3)
                Fire(npcPrompt, {fireprompt = true})
                task.wait(1)
            end
        end
    end
    if oldCF then
		RootPart.CFrame = oldCF
	end
    task.wait(0.35)
    IsCurrentlyCheckIn = false
    task.wait(0.5)
end
    end
})

ProcessGroup:Toggle({
    Title = t"Auto Treat",
    Value = false,
    Flag = "Auto Treat",
    Type = "Switch",
    Callback = function(Value)
_G.AutoTreat = Value
if not _G.AutoTreat then
	IsCurrentlyTreating = false 
end
while _G.AutoTreat and task.wait() do
	if _G.AutoTreat and (IsCurrentlyCheckIn or IsCurrentlyHelpNpc) then
		task.wait(0.5)
        continue
	end
    local function autoTreating(i)
		local targetNpc, checkPos = getRoom(i)
        local room = GetRoom(i)
        if not targetNpc or targetNpc:GetAttribute("HealedAtleastOnce") then
	        IsCurrentlyTreating = false
			return true
        end
        if targetNpc and not targetNpc:GetAttribute("HealedAtleastOnce") and room then
            IsCurrentlyTreating = true 
            oldCF = RootPart and RootPart.CFrame
            local isSkinwalker = targetNpc:GetAttribute("Skinwalker") == true                  
            local isRoom8 = (i == 8)
            local inv = CheckInv(room)
            local ui = inv and inv.Parent and inv.Parent.Parent
            local framesCountSkip = 0
            local IsLoadFrame = false
            if ui then
			    local healing = ui:FindFirstChild("Healing")
			    local interrupted = ui:FindFirstChild("Interrupted")
			    if (healing and healing.Visible) or (interrupted and interrupted.Visible) then
			        IsCurrentlyTreating = false
			        return true
			    end
			end
            for _, child in ipairs(inv:GetChildren()) do
                if inv.Visible and child:IsA("Frame") then
                    framesCountSkip = framesCountSkip + 1
                end
            end
            if framesCountSkip <= 0 then
	            task.wait(0.4)
	            if i >= 1 and i <= 5 then
	                local monitor = room.Minigame:FindFirstChild("Monitor")
	                local monitorPrompt2 = monitor and monitor:FindFirstChild("PP2")
	                local monitorCF = GetCF(monitor)
	                if monitorPrompt2 and monitorCF then
	                    Teleport(monitorCF)
	                    task.wait(0.7)
						Fire(monitorPrompt2, {fireprompt = true})
	                    task.wait(0.5)
	                end
	            elseif i == 6 or i == 7 then
	                local monitor = room.Minigame:FindFirstChild("Monitor")
	                local monitorPrompt2 = monitor and monitor:FindFirstChild("PP2")
	                local monitorCF = GetCF(monitor)
	                if monitorPrompt2 and monitorCF then
	                    Teleport(monitorCF)
	                    task.wait(0.6)
						Fire(monitorPrompt2, {fireprompt = true})
	                end                 
	                local xray = nil
	                local xrayPrompt = nil
	                local startXrayWait = os.clock()
	                while _G.AutoTreat and os.clock() - startXrayWait < 10 do
	                    xray = room.Minigame:FindFirstChild("PrintedXRay")
	                    xrayPrompt = xray and xray:FindFirstChild("PP")
	                    if xrayPrompt and xrayPrompt.Enabled then
	                        break
	                    end
	                    task.wait(0.1) 
	                end
	                if xrayPrompt then
	                    local xrayCF = GetCF(xray)
	                    if xrayCF then
							Teleport(xrayCF)
	                        task.wait(0.6)
							Fire(xrayPrompt, {fireprompt = true})
	                        task.wait(0.4)
	                    end
	                end
	            elseif i == 8 then
	                local bedModel = room.Minigame:FindFirstChild("Bed")
	                local inBed = bedModel and bedModel:FindFirstChild("InBed")
	                local monitorPrompt2 = inBed and inBed:FindFirstChild("PP2")
	                if monitorPrompt2 then
	                    local targetCF = GetCF(monitorPrompt2.Parent) or GetCF(bedModel)
	                    if targetCF then
							Teleport(targetCF)
	                        task.wait(0.6)
							Fire(monitorPrompt2, {fireprompt = true})
	                        task.wait(0.4)
	                    end
	                end
	            end                  
	            local startInvWait = os.clock()
	            while _G.AutoTreat and os.clock() - startInvWait < 5 do
	                local inv = CheckInv(room)
	                if inv then
	                    local framesCount = 0
	                    for _, child in ipairs(inv:GetChildren()) do
	                        if child:IsA("Frame") then
	                            framesCount = framesCount + 1
	                        end
	                    end
	                    if framesCount > 0 then
							IsLoadFrame = true
	                        break
	                    end
	                end
	                task.wait(isRoom8 and 0.05 or 0.2) 
	            end
			elseif framesCountSkip > 0 then
				IsLoadFrame = true
			end
			if IsLoadFrame then
	            while _G.AutoTreat do
	                if not targetNpc or not targetNpc.Parent then break end
					if targetNpc:GetAttribute("HealedAtleastOnce") then break end
	                local hrp = targetNpc:FindFirstChild("HumanoidRootPart")
	                local currentRadius = (i == 6 and XrayDetectionRadius or BedDetectionRadius)
	                if not hrp or (hrp.Position - checkPos).Magnitude > currentRadius then
	                    break
	                end
	                local inv = CheckInv(room)
	                if not inv then
	                    task.wait(isRoom8 and 0.05 or 0.3)
	                    continue
	                end
	                local itemToFetch = nil
	                local itemFrames = {}
	                local targetFrame = nil
	                for _, child in ipairs(inv:GetChildren()) do
	                    if child:IsA("Frame") then
	                        table.insert(itemFrames, child)
	                    end
	                end
	                for _, frame in ipairs(itemFrames) do
	                    if frame and frame:FindFirstChild("check") then
		                    if frame.check.Visible == false then
								targetFrame = frame
		                        itemToFetch = frame.Name
								break
							end
	                    end
	                end
	                if not inv or targetNpc:GetAttribute("HealedAtleastOnce") then
	                    break
	                end
	                if itemToFetch then
	                    local itemToPick = itemToFetch
	                    if isSkinwalker then
	                        for _, dummyItem in ipairs(allItems) do
	                            if dummyItem ~= itemToFetch then
	                                itemToPick = dummyItem
	                                break
	                            end
	                        end
	                    end
	                    task.wait(0.12) 
	                    local itemPrompt, itemInstance = findItem(itemToPick)
						if itemPrompt and itemInstance then
						    local itemCF = GetCF(itemInstance)
						    if itemCF then
								if not (Backpack:FindFirstChild(itemToPick) and Character:FindFirstChild(itemToPick)) then
									Teleport(itemCF)
							        task.wait(0.3)
									Fire(itemPrompt, {fireprompt = true})
								end
						        local timeout = os.clock()
						        repeat task.wait() until Backpack:FindFirstChild(itemToPick) or Character:FindFirstChild(itemToPick) or os.clock() - timeout > 2
								task.wait(0.3)
						        if Backpack:FindFirstChild(itemToPick) or Character:FindFirstChild(itemToPick) then
									local deliveryPrompt = nil
				                    local deliveryCF = nil
				                    if i == 6 then
				                        local npcInFolder = workspace:FindFirstChild("NPCs") and workspace.NPCs:FindFirstChild(targetNpc.Name)
				                        deliveryPrompt = npcInFolder and npcInFolder:FindFirstChild("PP")
				                        deliveryCF = GetCF(npcInFolder)
				                    else
				                        local bedModel = room.Minigame:FindFirstChild("Bed")
				                        local inBed = bedModel and bedModel:FindFirstChild("InBed")
				                        deliveryPrompt = inBed and inBed:FindFirstChild("PP")
				                        deliveryCF = GetCF(inBed or bedModel)
				                    end
				                    if deliveryCF and deliveryPrompt then
				                        if Backpack:FindFirstChild(itemToPick) then
				                            Humanoid:EquipTool(Backpack:FindFirstChild(itemToPick))
				                        end
								        task.wait(isRoom8 and 0.2 or 0.4) 
										Teleport(deliveryCF)
				                        task.wait(isRoom8 and 0.2 or 0.4) 
										if targetFrame and targetFrame:FindFirstChild("check") and targetFrame.check.Visible == false then
											Fire(deliveryPrompt, {fireprompt = true})
										end
										task.wait(isRoom8 and 0.05 or 0.2)
				                        if targetFrame then
				                            local startCheck = os.clock()
				                            while _G.AutoTreat and os.clock() - startCheck < 5 do
				                                task.wait(isRoom8 and 0.05 or 0.2)
				                                if not targetFrame.Parent or (targetFrame and targetFrame:FindFirstChild("check") and targetFrame.check.Visible == true) then
				                                    break 
				                                end
				                            end
				                        end
					                end
						        end
						    end
						end
					end
	                task.wait(isRoom8 and 0.05 or 0.3)
	            end
				if oldCF then
					RootPart.CFrame = oldCF
				end
				task.wait(0.5)
	            IsCurrentlyTreating = false
				task.wait(0.3)
	        end
	    end
		return false
    end
    local npcHelp, npcRoom
	local npcsFolder = workspace:FindFirstChild("NPCs")
    if npcsFolder then
        for _, npc in ipairs(npcsFolder:GetChildren()) do
            if npc:IsA("Model") and not npc:FindFirstChild("RagdollDummy") and not npc:FindFirstChild("Skinwalker") and npc:GetAttribute("DesignatedRoom") then
	            local npcCounter = npc:FindFirstChild("Counter", true)
				local npcUI = npcCounter and npcCounter:FindFirstChild("UI")
				local timeDealth = npcUI and npcUI:FindFirstChildOfClass("TextLabel")
				local npcGetRoom = tonumber(npc:GetAttribute("DesignatedRoom"):match("%d+"))
				if timeDealth and npcGetRoom and timeDealth.Visible and npcUI.Enabled and tonumber(timeDealth.Text:match("%d+")) then
					npcHelp, npcRoom = true, npcGetRoom
					break
				end
            end
        end
    end
    if npcHelp and npcRoom then
	    autoTreating(npcRoom)
    else
		for i = 1, 8 do
			if _G.AutoTreat == false then break end
			local treating = autoTreating(i)
			if treating then break end
		end
	end
	task.wait(0.5)
    IsCurrentlyTreating = false
end
    end
})

ProcessGroup:Toggle({
    Title = t"Auto Stamp Fire Room",
    Value = false,
    Flag = "Auto Stamp Fire Room",
    Type = "Switch",
    Callback = function(Value)
        _G.AutoStampFireRoom = Value
    end
})

ProcessGroup:Toggle({
    Title = t"Auto Stamp Fire Npc",
    Value = false,
    Flag = "Auto Stamp Fire Npc",
    Type = "Switch",
    Callback = function(Value)
_G.AutoStampFireNpc = Value
while _G.AutoStampFireNpc and task.wait(0.4) do
	if _G.AutoStampFireNpc and (IsCurrentlyTreating or IsCurrentlyCheckIn or IsCurrentlyHelpNpc) then
		task.wait(0.5)
		continue
	end
	local npcsFolder = workspace:FindFirstChild("NPCs")
	if npcsFolder then
	    for _, npc in ipairs(npcsFolder:GetChildren()) do
			if npc:IsA("Model") and not npc:GetAttribute("Skinwalker") then
				local npcCounter = npc:FindFirstChild("Counter", true)
				local npcUI = npcCounter and npcCounter:FindFirstChild("UI")
				local timeDealth = npcUI and npcUI:FindFirstChildOfClass("TextLabel")
				local itemGui = npcUI and npcUI:FindFirstChildOfClass("ImageLabel")
				local npcCF = GetCF(npc)
				local firePP = GetProximity(npc, "FirePP")
				local IsCured = npc:GetAttribute("IsCured")
				if firePP and npcUI and itemGui and timeDealth and firePP.Enabled and npcUI.Enabled and timeDealth.Visible and tonumber(timeDealth.Text:match("%d+")) then
					Teleport(npcCF)
					task.wait(0.3)
					Fire(firePP, {fireprompt = true})
				end
				if not IsCured and firePP and npcUI and itemGui and timeDealth and firePP.Enabled and npcUI.Enabled and not timeDealth.Visible and itemGui.Visible then
					local itemPrompt, itemInstance = findItem("Ointment")
					if itemPrompt and itemInstance then
					    local itemCF = GetCF(itemInstance)
					    if itemCF then
							if not (Backpack:FindFirstChild("Ointment") and Character:FindFirstChild("Ointment")) then
								Teleport(itemCF)
						        task.wait(0.3)
								Fire(itemPrompt, {fireprompt = true})
							end
					        local timeout = os.clock()
					        repeat task.wait() until Backpack:FindFirstChild("Ointment") or Character:FindFirstChild("Ointment") or os.clock() - timeout > 2
							task.wait(0.3)
					        if Backpack:FindFirstChild("Ointment") or Character:FindFirstChild("Ointment") then
								Teleport(npcCF)
								task.wait(0.5)
								Fire(firePP, {fireprompt = true})
							end
						end
					end
				end
			end
		end
	end
end
    end
})

ProcessGroup:Toggle({
    Title = t"Auto Ask Npc Leave",
    Value = false,
    Flag = "Auto Ask Leave Npc",
    Type = "Switch",
    Callback = function(Value)
_G.AutoAskLeaveNpc = Value
while _G.AutoAskLeaveNpc and task.wait(0.3) do
	if IsCurrentlyTreating or IsCurrentlyCheckIn or IsCurrentlyHelpNpc then
		task.wait(0.5) 
		continue
	end
	local npcsFolder = workspace:FindFirstChild("NPCs")
    if npcsFolder then
        for _, npc in ipairs(npcsFolder:GetChildren()) do
            if npc:IsA("Model") then
				local npcCF = GetCF(npc)
				local npcPrompt = GetProximity(npc)
				if npcCF and npcPrompt and npcPrompt.Enabled and npcPrompt.ActionText:lower():find("ask") then
					if Backpack:FindFirstChild("Coffee") then
                        Humanoid:EquipTool(Backpack:FindFirstChild("Coffee"))
                    end
					if Character:FindFirstChild("Coffee") then
						Teleport(npcCF)
						task.wait(0.67)
						if npcPrompt.Enabled then
							Fire(npcPrompt, {fireprompt = true})
						end
					end
				end
			end
		end
	end
end
    end
})

ProcessGroup:Toggle({
    Title = t"Auto Clean Smile",
    Value = false,
    Flag = "Auto Clean Smile",
    Type = "Switch",
    Callback = function(Value)
        _G.AutoCleanSmile = Value
    end
})

ProcessGroup:Toggle({
    Title = t"Auto Fix Camera",
    Value = false,
    Flag = "Auto Stamp Fire",
    Type = "Switch",
    Callback = function(Value)
        _G.AutoFixCamera = Value
    end
})

ProcessGroup:Toggle({
    Title = t"Auto Barney",
    Value = false,
    Flag = "Auto Barney",
    Type = "Switch",
    Callback = function(Value)
        _G.AutoBarney = Value
        while _G.AutoBarney and task.wait(0.3) do
	        if _G.AutoBarney and (IsCurrentlyTreating or IsCurrentlyHelpNpc) then
				task.wait(0.5) 
				continue
			end
			local npcBarney
			for i, v in pairs(workspace.NPCs:GetChildren()) do
				if v:IsA("Model") and v.Name:lower():find("barney") and v:FindFirstChild("RootPart") then
					npcBarney = v.RootPart
				end
			end
			if npcBarney and npcBarney.Parent then
				local barneyCounter = npcBarney:FindFirstChild("Counter", true)
				local barneyGui = barneyCounter and barneyCounter:FindFirstChild("UI")
				local barneyCF = GetCF(npcBarney)
				local barneyPrompt = GetProximity(npcBarney.Parent)
				if barneyGui and barneyGui.Enabled then
					for _, ui in pairs(barneyGui:GetChildren()) do
						if ui:IsA("ImageLabel") and ui.Visible then
							if barneyPrompt and barneyCF then
								if tonumber(ui.Image:match("%d+")) == 118223977489343 then
									if Backpack:FindFirstChild("Coffee") then
			                            Humanoid:EquipTool(Backpack:FindFirstChild("Coffee"))
			                        end
									if Character:FindFirstChild("Coffee") then
										Teleport(barneyCF)
										task.wait(0.5)
										Fire(barneyPrompt, {fireprompt = true})
									end
								elseif tonumber(ui.Image:match("%d+")) == 93721219255457 then
									local nameItem = "Organ"
									local itemPrompt, itemInstance = findItem(nameItem)
									if itemPrompt and itemInstance then
									    local itemCF = GetCF(itemInstance)
									    if itemCF then
											if not (Backpack:FindFirstChild(nameItem) and Character:FindFirstChild(nameItem)) then
												Teleport(itemCF)
										        task.wait(0.3)
												Fire(itemPrompt, {fireprompt = true})
											end
									        local timeout = os.clock()
									        repeat task.wait() until Backpack:FindFirstChild(nameItem) or Character:FindFirstChild(nameItem) or os.clock() - timeout > 2
											task.wait(0.3)
									        if Backpack:FindFirstChild(nameItem) or Character:FindFirstChild(nameItem) then
												Teleport(barneyCF)
												task.wait(0.3)
												if Humanoid then
													Humanoid:EquipTool(Backpack:FindFirstChild(nameItem))
													task.wait(0.5)
												end
												if Character:FindFirstChild(nameItem) then
													fire(barneyPrompt, {fireprompt = true})
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
})

ProcessGroup:Dropdown({
    Title = t"Taser Npc",
    Options = {"Skinwalker", "Patients"},
    Default = "Treatment",
    Callback = function(Value)
		_G.TaserNPC = Value
    end
})

ProcessGroup:Toggle({
    Title = t"Auto Taser NPC",
    Value = false,
    Flag = "Auto Taser NPC",
    Type = "Switch",
    Callback = function(Value)
        _G.AutoTaserNPC = Value
        while _G.AutoTaserNPC and task.wait(1.67) do
			if not (Backpack:FindFirstChild("Taser") and Character:FindFirstChild("Taser")) then
				if not (IsCurrentlyTreating and IsCurrentlyCheckIn and IsCurrentlyHelpNpc) then
					local taserModel = workspace.Misc:FindFirstChild("TaserStation")
					local tasetMain = taserModel and taserModel:FindFirstChild("Main")
					local HasTaser = taserModel and taserModel:GetAttribute("HasTaser")
					local Recharging = taserModel and taserModel:GetAttribute("Recharging")
					if HasTaser and not Recharging and tasetMain then
						local taserCF = GetCF(tasetMain)
						local taserPrompt = GetProximity(tasetMain)
						if taserCF and taserPrompt then
							Teleport(taserCF)
							task.wait(0.5)
							Fire(taserPrompt, {fireprompt = true})
							task.wait(0.7)
						end
					end
				end
			end
			for i, v in pairs(workspace.NPCs:GetChildren()) do
				if v:IsA("Model") and v.Name:lower():find("hide") and v:GetAttribute("Skinwalker") then
					if Backpack:FindFirstChild("Taser") then
						Humanoid:EquipTool(Backpack:FindFirstChild("Taser"))
					end
					game:GetService("ReplicatedStorage"):WaitForChild("Util"):WaitForChild("Net"):WaitForChild("RE/TaserFired"):FireServer(v)
				end
			end
        end
    end
})

ProcessGroup:Dropdown({
    Title = t"Help Npc Interrupted",
    Options = {"Treatment", "Trashed"},
    Default = "Treatment",
    Callback = function(Value)
		_G.HelpNpc = Value
    end
})

ProcessGroup:Toggle({
    Title = t"Auto Help Npc Interrupted",
    Value = false,
    Flag = "Auto Help Npc Interrupted",
    Type = "Switch",
    Callback = function(Value)
_G.AutoHelpNpcInterrupted = Value
if not _G.AutoHelpNpcInterrupted then
	IsCurrentlyHelpNpc = false
end
while _G.AutoHelpNpcInterrupted and task.wait(0.35) do
	if _G.AutoHelpNpcInterrupted and (IsCurrentlyTreating or IsCurrentlyCheckIn) then
		task.wait(0.5)
        continue
	end
	local npcHelp, npcRoom, foundragdoll
	local npcsFolder = workspace:FindFirstChild("NPCs")
    if npcsFolder then
        for _, npc in ipairs(npcsFolder:GetChildren()) do
            if npc:IsA("Model") and not npc:FindFirstChild("Skinwalker") and npc:GetAttribute("DesignatedRoom") then
	            local npcCounter = npc:FindFirstChild("Counter", true)
				local npcUI = npcCounter and npcCounter:FindFirstChild("UI")
				local timeDealth = npcUI and npcUI:FindFirstChildOfClass("TextLabel")
				local npcGetRoom = tonumber(npc:GetAttribute("DesignatedRoom"):match("%d+"))
				for _, v in pairs(npc:GetChildren()) do
					if v:IsA("Model") and v.Name:lower():find("ragdoll") then
						foundragdoll = v
					end
				end
				if timeDealth and npcGetRoom and timeDealth.Visible and npcUI.Enabled and tonumber(timeDealth.Text:match("%d+")) then
					npcHelp, npcRoom = npc, npcGetRoom
					break
				end
            end
        end
    end
    if npcHelp and npcRoom and foundragdoll then
		local room = GetRoom(npcRoom)
		if room then
			IsCurrentlyHelpNpc = true
			if foundragdoll then
				local npcCF = GetCF(npcHelp)
				local npcPrompt = GetProximity(npcHelp, "FaintedPP")
				if npcCF and npcPrompt then
					repeat task.wait()
						Teleport(npcCF)
						task.wait(0.5)
						Fire(npcPrompt, {fireprompt = true})
					until not _G.AutoHelpNpcInterrupted or not npcHelp or not npcHelp.Parent or not foundragdoll or not foundragdoll.Parent
					task.wait(0.8)
				end
			end
		end
		if npcHelp and npcRoom and (not foundragdoll or not foundragdoll.Parent) then
			if _G.HelpNpc == "Treatment" then
				local bedModel = room.Minigame:FindFirstChild("Bed")
	            local inBed = bedModel and bedModel:FindFirstChild("InBed")
	            local deliveryPrompt = inBed and inBed:FindFirstChild("PP")
	            local deliveryCF = GetCF(inBed or bedModel)
				if deliveryPrompt and deliveryCF then
					repeat task.wait()
						Teleport(deliveryCF)
						task.wait(0.5)
						Fire(deliveryPrompt, {fireprompt = true})
					until not _G.AutoHelpNpcInterrupted or not npcHelp or npcHelp:GetAttribute("InBed")
					task.wait(0.57)
				end
			elseif _G.HelpNpc == "Trashed" then
				for _, v in pairs(workspace:GetChildren()) do
					if v.Name:lower():find("trash") and v:FindFirstChild("Main") then
						local trashCF = GetCF(v.Main)
						local trashPrompt = GetProximity(v, "PP")
						if trashCF and trashPrompt then
							repeat task.wait()
								Teleport(trashCF)
								task.wait(0.4)
								Fire(trashPrompt, {fireprompt = true})
							until not _G.AutoHelpNpcInterrupted or not npcHelp or not npcHelp.Parent
							task.wait(0.5)
							break
						end
					end
				end
			end
			task.wait(0.6)
	        IsCurrentlyHelpNpc = false
			task.wait(0.6)
		end
	end
end
    end
})

local Misc = Tabs.Misc
local EspGroup = Misc:GroupBox({
    Title = t"Esp",
})

EspGroup:Toggle({
    Title = t"Esp Npc",
    Value = false,
    Flag = "Esp Npc",
    Type = "Switch",
    Callback = function(Value)
		_G.EspNPC = Value
		if not _G.EspNPC then
			for i, v in pairs(workspace.NPCs:GetChildren()) do
				if v:IsA("Model") then
					ESPLibrary:RemoveESP(v)
				end
			end
		end
    end
})

EspGroup:Toggle({
    Title = t"Esp Player",
    Value = false,
    Flag = "Esp Npc",
    Type = "Switch",
    Callback = function(Value)
		_G.EspPlayer = Value
		if not _G.EspPlayer then
			for i, v in pairs(Players:GetPlayers()) do
				local Char = v.Character
				if v ~= LocalPlayer and Char and Char:FindFirstChild("HumanoidRootPart") and Char:FindFirstChild("Humanoid") then
					ESPLibrary:RemoveESP(Char)
				end
			end
		end
    end
})

local GuiMap = {}
local function GetGui(frame)
    return GuiMap[frame]
end
local function RemoveGui(frame)
    local gui = GuiMap[frame]
    if gui then
        gui:Destroy()
        GuiMap[frame] = nil
    end
end
EspGroup:Toggle({
    Title = t"Esp Item",
    Value = false,
    Flag = "Esp Item",
    Type = "Switch",
    Callback = function(Value)
_G.EspItem = Value
while _G.EspItem and task.wait() do
	for i = 1, 8 do
	    local room = GetRoom(i)
	    if room then
	        local inv = CheckInv(room)
			local itemFrames = {}
			local bedModel = room.Minigame:FindFirstChild("Bed")
            local inBed = bedModel and bedModel:FindFirstChild("InBed")
            local monitorModel = room.Minigame:FindFirstChild("Monitor")
            local espItemGui = (i == 6 and (monitorModel and monitorModel:FindFirstChild("EspItem")) or (inBed and inBed:FindFirstChild("EspItem")))
            local parent = (i == 6 and monitorModel or inBed)
			if inv then
				for _, child in ipairs(inv:GetChildren()) do
		            if child:IsA("Frame") then
						table.insert(itemFrames, child)
					end
				end
			end
			if espItemGui and #itemFrames <= 0 then
				espItemGui:Destroy()
			end
			if i == 8 then
			    if not inv or #inv:GetChildren() == 0 then
			        if espItemGui then
			            espItemGui:Destroy()
			        end
			        continue
			    end
			end
			if #itemFrames > 0 then
				local Count = #itemFrames
                if parent and not espItemGui then
					Create("BillboardGui", {Parent = parent, Adornee = parent, Name = "EspItem", Size = UDim2.new(0, 500, 0, 500), AlwaysOnTop = true, StudsOffset = Vector3.new(0, 2 + Count, 0)}, {
						Create("Frame", {BackgroundTransparency = 1, Name = "Inv", AnchorPoint = Vector2.new(0.5,0), Position = UDim2.new(0.5,0,0,0), Size = UDim2.new(1,0,1,0)}, {
							Create("UIListLayout", {Parent = Holder, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Center, FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0,5)})
						})
					})
				end
				if espItemGui then 
					for _, frame in ipairs(itemFrames) do
					    if frame:FindFirstChild("check") and frame:FindFirstChild("icon") and espItemGui:FindFirstChild("Inv") then
					        if i == 8 then
					            for oldFrame, gui in pairs(GuiMap) do
					                if not oldFrame.Parent then
					                    gui:Destroy()
					                    GuiMap[oldFrame] = nil
					                end
					            end
					        end
					        local gui = GetGui(frame)
					        if frame.check.Visible then
					            RemoveGui(frame)
					        else
					            if not gui then
					                gui = Create("Frame",{
					                    Parent = espItemGui.Inv,
					                    BackgroundTransparency = 1,
					                    Size = UDim2.fromOffset(70,85)
					                },{
					                    Create("UIListLayout",{
					                        FillDirection = Enum.FillDirection.Vertical,
					                        HorizontalAlignment = Enum.HorizontalAlignment.Center,
					                        VerticalAlignment = Enum.VerticalAlignment.Top,
					                        Padding = UDim.new(0,2)
					                    }),
					
					                    Create("ImageLabel",{
					                        Name = "Icon",
					                        BackgroundTransparency = 1,
					                        Size = UDim2.fromOffset(48,48),
					                        Image = frame.icon.Image
					                    }),
					
					                    Create("TextLabel",{
					                        Name = "Name",
					                        BackgroundTransparency = 1,
					                        Size = UDim2.new(1,0,0,20),
					                        Text = frame.Name,
					                        Font = Enum.Font.GothamBold,
					                        TextScaled = true,
					                        TextColor3 = Color3.new(1,1,1),
					                        TextStrokeTransparency = 0
					                    })
					                })
					                GuiMap[frame] = gui
					                frame.Destroying:Connect(function()
					                    RemoveGui(frame)
					                end)
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
})

local TPGroup = Misc:GroupBox({
    Title = t"Teleport",
})

TPGroup:Button({
    Title = t"Goto Spawn",
    Callback = function()
local spawnLoc = Workspace:FindFirstChild("Misc") and Workspace.Misc:FindFirstChild("SpawnLocation")
if spawnLoc then
    Teleport(spawnLoc.CFrame)
end
    end
}) 

local MiscGroup = Misc:GroupBox({
    Title = t"Misc",
})

MiscGroup:AddToggle({
    Name = t"Instant Prompt",
    Default = false,
    Type = "Switch",
    Flag = "Instant Prompt",
    Callback = function(Value)
	    _G.InstantPrompt = Value
		spawn(function()
			ActivePromptSetting()
		end)
    end
})

MiscGroup:AddToggle({
    Name = t"Prompt Reach",
    Default = false,
    Type = "Switch",
    Flag = "Prompt Reach",
    Callback = function(Value)
		_G.PromptReach = Value
		spawn(function()
			ActivePromptSetting()
		end)
    end
})

MiscGroup:AddToggle({
    Name = t"Unlock Person",
    Default = false,
    Type = "Switch",
    Flag = "Unlock Person",
    Callback = function(Value)
_G.UnlockPerson = Value
while _G.UnlockPerson do
if LocalPlayer.CameraMode ~= "Classic" then
	LocalPlayer.CameraMode = "Classic"
end
task.wait()
end
    end
})

MiscGroup:AddToggle({
    Name = t"Auto Collect Coffee",
    Default = false,
    Type = "Switch",
    Flag = "Auto Collect Coffe",
    Callback = function(Value)
_G.AutoCollectCoffe = Value
while _G.AutoCollectCoffe and task.wait(0.3) do
	local misc = workspace:FindFirstChild("Misc")
	local coffeeModel = misc and misc:FindFirstChild("CoffeeMachine")
	local inCoffee = coffeeModel and coffeeModel:FindFirstChild("Coffee")
	if inCoffee and inCoffee.Transparency <= 0 then
		local coffeeCF = GetCF(inCoffee)
		local coffeeProximity = GetProximity(inCoffee)
		if coffeeCF and coffeeProximity then
			if not IsCurrentlyTreating and not IsCurrentlyCheckIn then
				Teleport(coffeeCF)
		        task.wait(0.3)
				Fire(coffeeProximity, {fireprompt = true})
			end
		end
	end
end
    end
})

MiscGroup:AddToggle({
    Name = t"Auto Monster Bed",
    Default = false,
    Type = "Switch",
    Flag = "Auto Monster Bed",
    Callback = function(Value)
_G.AutoMonsterBed = Value
while _G.AutoMonsterBed and task.wait(0.3) do
	for i = 1, 7 do
		if IsCurrentlyTreating or IsCurrentlyHelpNpc or IsCurrentlyCheckIn then break end
		local room = GetRoom(i)
		if room and room:FindFirstChild("Minigame") and room.Minigame:FindFirstChild("MonsterBed") then
			if room.Minigame.MonsterBed:FindFirstChild("HitLocation") and room.Minigame.MonsterBed.HitLocation.Transparency <= 0 then
				local nameItem = "Organ"
				local itemPrompt, itemInstance = findItem(nameItem)
				if itemPrompt and itemInstance then
				    local itemCF = GetCF(itemInstance)
				    if itemCF then
						if not (Backpack:FindFirstChild(nameItem) and Character:FindFirstChild(nameItem)) then
							Teleport(itemCF)
					        task.wait(0.3)
							Fire(itemPrompt, {fireprompt = true})
						end
				        local timeout = os.clock()
				        repeat task.wait() until Backpack:FindFirstChild(nameItem) or Character:FindFirstChild(nameItem) or os.clock() - timeout > 2
						task.wait(0.3)
				        if Backpack:FindFirstChild(nameItem) or Character:FindFirstChild(nameItem) then
							local monsterCF = GetCF(room.Minigame.MonsterBed.HitLocation)
							if monsterCF then
								if Backpack:FindFirstChild(nameItem) then
		                            Humanoid:EquipTool(Backpack:FindFirstChild(nameItem))
		                        end
						        task.wait(0.5)
								if Character:FindFirstChild(nameItem) then
									Teleport(monsterCF)
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
})

MiscGroup:Button({
    Title = t"Remove Door",
    Callback = function()
if workspace:FindFirstChild("Doors") then
	workspace.Doors:Destroy()
end
    end
}) 

MiscGroup:Button({
    Title = t"Inf Stanity",
    Callback = function()
local Event = game:GetService("ReplicatedStorage"):FindFirstChild("Util"):FindFirstChild("Net"):FindFirstChild("RE/PlayerLostSanity")
Event:FireServer(tonumber("-nan"))
    end
}) 

local UISettings = Tabs["UI Settings"]
local UISettingsGroup = UISettings:GroupBox({
    Title = "Translate",
})

UISettingsGroup:Dropdown({
    Title = "Translate",
    Options = {"vn", "ru", "br"},
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
	writefile("Translate/Animal-Hospital", _G.TranslateScript)
	if readfile then
		local TranslateFile = readfile("Translate/Animal-Hospital")
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
	if _G.Connect then
		for i, v in pairs(_G.Connect) do
			v:Disconnect()
		end
	_G.Connect = nil
	end
end)