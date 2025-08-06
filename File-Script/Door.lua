if game.Players.LocalPlayer.PlayerGui:FindFirstChild("LoadingUI") and game.Players.LocalPlayer.PlayerGui.LoadingUI.Enabled == true then
repeat task.wait() until game.Players.LocalPlayer.PlayerGui.LoadingUI.Enabled == false
end

getgenv().TranslationCounter = nil
Name = "Door"
local success, result = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/Translation/Translation.lua"))()
end)

if success then
    Translations = result
else
    TranslationCounter = "English"
end
if Translations["English"] and Translations["English"][Name] then
loadstring(game:HttpGet("https://pastefy.app/yavAjgX3/raw"))()
repeat task.wait() until TranslationCounter
if game.CoreGui:FindFirstChild("Country") then
game.CoreGui.Country:Destroy()
end
end

function Translation(Section, Text)
	if TranslationCounter == "English" then
		return Text
	end
	local lang = Translations[TranslationCounter]
	if lang and lang[Name] and lang[Name][Section] and lang[Name][Section][Text] then
		return lang[Name][Section][Text]
	else
		return Text
	end
end
Tran = {"Main", "Misc", "Esp", "Information"}

function Distance(pos)
	if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		return (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - pos).Magnitude
	end
end

_G.GetOldBright = {
	Brightness = game.Lighting.Brightness,
	ClockTime = game.Lighting.ClockTime,
	FogEnd = game.Lighting.FogEnd,
	GlobalShadows = game.Lighting.GlobalShadows,
	OutdoorAmbient = game.Lighting.OutdoorAmbient
}

AntiScreech = false
local old
old = hookmetamethod(game, "__namecall", newcclosure(function(self,...)
    local args = {...}
    local method = getnamecallmethod()
    if tostring(self) == "Screech" and method == "FireServer" and AntiScreech == true then
        args[1] = true
        return old(self, unpack(args))
    end
    return old(self,...)
end))

workspace.DescendantAdded:Connect(function(v)
if v.Name == "ChandelierObstruction" or v.Name == "Seek_Arm" then
if _G.NoSeek == true then
for d, i in pairs(v:GetDescendants()) do
if i:IsA("BasePart") then i.CanTouch = false end
end
end
end
end)

---- Script ----

local ui = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local win = ui:CreateWindow({
    Title = "Door",
    Icon = "door-open",
    Folder = "Article Hub",
    Size = UDim2.fromOffset(700, 320),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 200,
    Background = "",
})

Tabs = {
    Tab = win:Tab({Title = Translation(Tran[1], "Main")}),
    Tab1 = win:Tab({Title = Translation(Tran[2], "Misc")}),
    Tab2 = win:Tab({Title = Translation(Tran[3], "Esp")}),
    ["Info"] = win:Tab({Title = Translation(Tran[4], "Information")}),
}

local Main = Tabs.Tab
local MainTran = "Main" 
Main:Toggle({
    Title = Translation(MainTran, "Fullbright"),
    Type = "Toggle",
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

Main:Toggle({
    Title = Translation(MainTran, "Instant Prompt"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.NoCooldownProximity = Value
if _G.NoCooldownProximity == true then
for i, v in pairs(workspace:GetDescendants()) do
if v.ClassName == "ProximityPrompt" then
v.HoldDuration = 0
end
end
CooldownProximity = workspace.DescendantAdded:Connect(function(Cooldown)
if _G.NoCooldownProximity == true then
if Cooldown:IsA("ProximityPrompt") then
Cooldown.HoldDuration = 0
end
end
end)
else
if CooldownProximity then
CooldownProximity:Disconnect()
CooldownProximity = nil
end
end
    end
})

Main:Section({Title = Translation(MainTran, "Anti"), TextXAlignment = "Left", TextSize = 17})

Main:Toggle({
    Title = Translation(MainTran, "Anti Screech"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.NoScreech = Value
AntiScreech = Value
while _G.NoScreech do
for i, v in pairs(workspace.CurrentCamera:GetChildren()) do
	if v.Name == "Screech" then
	   v:Destroy()
	end
end
task.wait()
end
    end
})

Main:Toggle({
    Title = Translation(MainTran, "Anti Seek"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.NoSeek = Value
for i,v in pairs(child:GetDescendants()) do
if v.Name == "ChandelierObstruction" or v.Name == "Seek_Arm" then
for d, i in pairs(v:GetDescendants()) do
if i:IsA("BasePart") then i.CanTouch = false end
end
end
end
    end
})

local Misc = Tabs.Tab1
local MiscTr = "Misc"
local EntityGet = Misc:Dropdown({
    Title = Translation(MiscTr, "Choose Entity"),
    Values = {"Rush", "Seek", "Figure", "Sally", "Eyes", "Window", "LookMan", "BackdoorRush", "Giggle", "GloombatSwarm", "Ambush", "A-60", "A-120"},
    Value = {"Rush"},
    Multi = true,
    AllowNone = true,
    Callback = function(Value) 
_G.EntityChoose = Value
    end
})

Misc:Toggle({
    Title = Translation(MiscTr, "Notification Entity"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.NotifyEntity = Value
if _G.NotifyEntity then
EntityChild = workspace.ChildAdded:Connect(function(child)
for _, v in ipairs(_G.EntityChoose) do
    if child.Name:find(v) then
    repeat task.wait() until game.Players.LocalPlayer:DistanceFromCharacter(child:GetPivot().Position) < 1000 or not child:IsDescendantOf(workspace)
	    if child:IsDescendantOf(workspace) then
			ui:Notify({Title = v..Translation(MiscTr, " Spawn!!"), Duration = 5})
			if _G.NotifyEntityChat then
				game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(v..Translation(MiscTr, " Spawn!!"))
			end
		end
    end
end
end)
else
if EntityChild then
EntityChild:Disconnect()
EntityChild = nil
end
end
    end
})

Misc:Toggle({
    Title = Translation(MiscTr, "Notification Entity Chat"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.NotifyEntityChat = Value
    end
})

Misc:Toggle({
    Title = Translation(MiscTr, "Auto Loot"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.AutoLoot = Value
if _G.AutoLoot then
local function CheckTab(v)
    if v.Name == "DrawerContainer" and v:FindFirstChild("Knobs") then
        return true
    elseif v.Name:find("Pile") and v:FindFirstChild("LootPrompt") then
        return true
    elseif v.Name == "ChestBox" and v:FindFirstChild("ActivateEventPrompt") then
        return true
    elseif v.Name == "RolltopContainer" and v:FindFirstChild("ActivateEventPrompt") then
        return true
    elseif v.Name:find("Key") and v:FindFirstChild("ModulePrompt") and v:FindFirstChild("Hitbox") then
        return true
    elseif v.Name == "LiveHintBook" and v:FindFirstChildOfClass("ProximityPrompt") then
        return true
    elseif v.Name == "Handle" and v.Parent:FindFirstChildOfClass("ProximityPrompt") then
        return true
    end
    return false
end
lootables = {}
local ChildAllNext
local RemoveChild

local function LootCheck(v)
    if not table.find(lootables, v) and CheckTab(v) then
        table.insert(lootables, v)
    end
end
for _, v in ipairs(workspace:GetDescendants()) do
	LootCheck(v)
end
ChildAllNext = workspace.DescendantAdded:Connect(function(v)
    LootCheck(v)
end)
RemoveChild = workspace.DescendantRemoving:Connect(function(v)
    for i = #lootables, 1, -1 do
        if lootables[i] == v then
            table.remove(lootables, i)
            break
        end
    end
end)
else
if ChildAllNext then
ChildAllNext:Disconnect()
ChildAllNext = nil
end
if RemoveChild then
RemoveChild:Disconnect()
RemoveChild = nil
end
end
while _G.AutoLoot do
for i, v in pairs(lootables) do
	if v:IsA("Model") then
		if v.Name == "DrawerContainer" then
		    local knob
	        if v:FindFirstChild("Knobs") then
		        knob = v.Knobs
	        end
	        if knob then
				if knob:FindFirstChild("ActivateEventPrompt") and not knob.ActivateEventPrompt:GetAttribute("Interactions") then
	                if Distance(knob.Position) <= 12 then
	                    fireproximityprompt(knob.ActivateEventPrompt)
	                end
		        end
	        end
	    elseif v.Name:find("Pile") then
	        if v:FindFirstChild("LootPrompt") and v.LootPrompt:GetAttribute("Interactions") == nil then
	            if v.PrimaryPart then
				    if Distance(v.PrimaryPart.Position) <= 12 then
				        fireproximityprompt(v.LootPrompt)
				    end
				end
	        end
	    elseif v.Name == "ChestBox" then
	        if v:FindFirstChild("ActivateEventPrompt") and v.ActivateEventPrompt:GetAttribute("Interactions") == nil then
	            if v.PrimaryPart then
				    if Distance(v.PrimaryPart.Position) <= 12 then
				        fireproximityprompt(v.ActivateEventPrompt)
				    end
				end
	        end
	    elseif v.Name == "RolltopContainer" then
	        if v:FindFirstChild("ActivateEventPrompt") and v.ActivateEventPrompt:GetAttribute("Interactions") == nil then
	            if v.PrimaryPart then
				    if Distance(v.PrimaryPart.Position) <= 12 then
				        fireproximityprompt(v.ActivateEventPrompt)
				    end
				end
	        end
	    elseif v.Name:find("Key") then
			if v:FindFirstChild("ModulePrompt") and v:FindFirstChild("Hitbox") then
				if game.Players.LocalPlayer.Character:FindFirstChild("Key") == nil and game.Players.LocalPlayer.Backpack:FindFirstChild("Key") == nil then
					if Distance(v.Hitbox.Position) <= 12 then
	                    fireproximityprompt(v.ModulePrompt)
	                end
				end
			end
		elseif v.Name == "LiveHintBook" then
			if v:FindFirstChildOfClass("ProximityPrompt") then
				if v.PrimaryPart then
	                if Distance(v.PrimaryPart.Position) <= 12 then
	                    fireproximityprompt(v:FindFirstChildOfClass("ProximityPrompt"))
	                end
				end
			end
	    end
	end
	if v.Name == "Handle" then
		if v.Parent:FindFirstChildOfClass("ProximityPrompt") then
			if Distance(v.Position) <= 12 then
	            fireproximityprompt(v.Parent:FindFirstChildOfClass("ProximityPrompt"))
	        end
		end
	end
end
task.wait()
end
    end
})

Misc:Slider({
    Title = Translation(MiscTr, "Walkspeed"),
    Step = 1,
    Value = {
        Min = 16,
        Max = 21,
        Default = 16,
    },
    Callback = function(Value)
_G.WalkSpeedTp = Value
    end
})

Misc:Toggle({
    Title = Translation(MiscTr, "WalkSpeed"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.SpeedWalk = Value
while _G.SpeedWalk do
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = _G.WalkSpeedTp
end
task.wait()
end
    end
})

local Esp = Tabs.Tab2
local EspTr = "Esp"

Esp:Toggle({
    Title = Translation(EspTr, "Esp Key"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.EspKey = Value
if _G.EspKey == false then
_G.KeyAdd = {}
if KeySpawn then
KeySpawn:Disconnect()
KeySpawn = nil
end
if KeyRemove then
KeyRemove:Disconnect()
KeyRemove = nil
end
for _, v in pairs(workspace:GetDescendants()) do 
if v.Name:find("Key") and v:FindFirstChild("Hitbox") then
for i, z in pairs(v:GetChildren()) do
if z.Name:find("Esp_") then
z:Destroy()
end
end
end
end
else
function Keys(v)
if v.Name:find("Key") and v:FindFirstChild("Hitbox") then
if v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight").FillColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
	v:FindFirstChild("Esp_Highlight").OutlineColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
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
	        (_G.EspName == true and "Key" or "")..
            (_G.EspDistance == true and "\nDistance ("..string.format("%.0f", Distance(v.Hitbox.Position)).."m)" or "")
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 15
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(255, 255, 255)
end
if _G.EspGui == true and v:FindFirstChild("Esp_Gui") == nil then
	GuiEsp = Instance.new("BillboardGui", v)
	GuiEsp.Adornee = v
	GuiEsp.Name = "Esp_Gui"
	GuiEsp.Size = UDim2.new(0, 100, 0, 150)
	GuiEsp.AlwaysOnTop = true
	GuiEspText = Instance.new("TextLabel", GuiEsp)
	GuiEspText.BackgroundTransparency = 1
	GuiEspText.Font = Enum.Font.Code
	GuiEspText.Size = UDim2.new(0, 100, 0, 100)
	GuiEspText.TextSize = 15
	GuiEspText.TextColor3 = Color3.new(0,0,0) 
	GuiEspText.TextStrokeTransparency = 0.5
	GuiEspText.Text = ""
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Color = Color3.new(0, 0, 0)
	UIStroke.Thickness = 1.5
	UIStroke.Parent = GuiEspText
	elseif _G.EspGui == false and v:FindFirstChild("Esp_Gui") then
	v:FindFirstChild("Esp_Gui"):Destroy()
end
end
end
local function CheckKey(v)
    if not table.find(_G.KeyAdd, v) and v.Name:find("Key") and v:FindFirstChild("ModulePrompt") and v:FindFirstChild("Hitbox") then
        table.insert(_G.KeyAdd, v)
    end
end
for _, v in ipairs(workspace:GetDescendants()) do
	CheckKey(v)
end
KeySpawn = workspace.DescendantAdded:Connect(function(v)
    CheckKey(v)
end)
KeyRemove = workspace.DescendantRemoving:Connect(function(v)
    for i = #_G.KeyAdd, 1, -1 do
        if _G.KeyAdd[i] == v then
            table.remove(_G.KeyAdd, i)
            break
        end
    end
end)
end
while _G.EspKey do
for i, v in pairs(_G.KeyAdd) do
if v:IsA("Model") then
Keys(v)
end
end
task.wait()
end
    end
})

Esp:Toggle({
    Title = Translation(EspTr, "Esp Door"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.EspDoor = Value
if _G.EspDoor == false then
for _, v in pairs(game.Workspace:FindFirstChild("CurrentRooms"):GetChildren()) do 
if v:isA("Model") then
for i, z in pairs(v:GetChildren()) do
if z.Name:find("Esp_") then
z:Destroy()
end
end
end
end
end
while _G.EspDoor do
for i, v in pairs(game.Workspace:FindFirstChild("CurrentRooms"):GetChildren()) do
if v:IsA("Model") and v:FindFirstChild("Door") and v.Door:FindFirstChild("Door") then
if v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight").FillColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
	v:FindFirstChild("Esp_Highlight").OutlineColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
end
if _G.EspHighlight == true and v:FindFirstChild("Esp_Highlight") == nil then
	local Highlight = Instance.new("Highlight")
	Highlight.Name = "Esp_Highlight"
	Highlight.FillColor = Color3.fromRGB(255, 255, 255) 
	Highlight.OutlineColor = Color3.fromRGB(255, 255, 255) 
	Highlight.FillTransparency = 0.5
	Highlight.OutlineTransparency = 0
	Highlight.Adornee = v.Door
	Highlight.Parent = v
	elseif _G.EspHighlight == false and v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight"):Destroy()
end
if v:FindFirstChild("Esp_Gui") and v["Esp_Gui"]:FindFirstChild("TextLabel") then
	v["Esp_Gui"]:FindFirstChild("TextLabel").Text = 
	        (_G.EspName == true and "Door "..((v.Door:FindFirstChild("Sign") and v.Door.Sign:FindFirstChild("Stinker") and v.Door.Sign.Stinker.Text) or (v.Door.Sign:FindFirstChild("SignText") and v.Door.Sign.SignText.Text)):gsub("^0+", "")..(v.Door:FindFirstChild("Lock") and " (lock)" or "") or "")..
            (_G.EspDistance == true and "\nDistance ("..string.format("%.0f", Distance(v.Door.Door.Position)).."m)" or "")
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 15
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(255, 255, 255)
end
if _G.EspGui == true and v:FindFirstChild("Esp_Gui") == nil then
	GuiEsp = Instance.new("BillboardGui", v)
	GuiEsp.Adornee = v.Door
	GuiEsp.Name = "Esp_Gui"
	GuiEsp.Size = UDim2.new(0, 100, 0, 150)
	GuiEsp.AlwaysOnTop = true
	GuiEspText = Instance.new("TextLabel", GuiEsp)
	GuiEspText.BackgroundTransparency = 1
	GuiEspText.Font = Enum.Font.Code
	GuiEspText.Size = UDim2.new(0, 100, 0, 100)
	GuiEspText.TextSize = 15
	GuiEspText.TextColor3 = Color3.new(0,0,0) 
	GuiEspText.TextStrokeTransparency = 0.5
	GuiEspText.Text = ""
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Color = Color3.new(0, 0, 0)
	UIStroke.Thickness = 1.5
	UIStroke.Parent = GuiEspText
	elseif _G.EspGui == false and v:FindFirstChild("Esp_Gui") then
	v:FindFirstChild("Esp_Gui"):Destroy()
end
end
end
task.wait()
end
    end
})

Esp:Toggle({
    Title = Translation(EspTr, "Esp Book"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.EspBook = Value
if _G.EspBook == false then
_G.BookAdd = {}
if BookSpawn then
BookSpawn:Disconnect()
BookSpawn = nil
end
if BookRemove then
BookRemove:Disconnect()
BookRemove = nil
end
for _, v in pairs(workspace:GetDescendants()) do 
if v.Name:find("LiveHintBook") then
for i, z in pairs(v:GetChildren()) do
if z.Name:find("Esp_") then
z:Destroy()
end
end
end
end
else
function Books(v)
if v.Name:find("LiveHintBook") and v.PrimaryPart then
if v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight").FillColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
	v:FindFirstChild("Esp_Highlight").OutlineColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
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
	        (_G.EspName == true and "Book" or "")..
            (_G.EspDistance == true and "\nDistance ("..string.format("%.0f", Distance(v.PrimaryPart.Position)).."m)" or "")
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 15
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(255, 255, 255)
end
if _G.EspGui == true and v:FindFirstChild("Esp_Gui") == nil then
	GuiEsp = Instance.new("BillboardGui", v)
	GuiEsp.Adornee = v
	GuiEsp.Name = "Esp_Gui"
	GuiEsp.Size = UDim2.new(0, 100, 0, 150)
	GuiEsp.AlwaysOnTop = true
	GuiEspText = Instance.new("TextLabel", GuiEsp)
	GuiEspText.BackgroundTransparency = 1
	GuiEspText.Font = Enum.Font.Code
	GuiEspText.Size = UDim2.new(0, 100, 0, 100)
	GuiEspText.TextSize = 15
	GuiEspText.TextColor3 = Color3.new(0,0,0) 
	GuiEspText.TextStrokeTransparency = 0.5
	GuiEspText.Text = ""
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Color = Color3.new(0, 0, 0)
	UIStroke.Thickness = 1.5
	UIStroke.Parent = GuiEspText
	elseif _G.EspGui == false and v:FindFirstChild("Esp_Gui") then
	v:FindFirstChild("Esp_Gui"):Destroy()
end
end
end
local function CheckBook(v)
    if not table.find(_G.BookAdd, v) and v.Name == "LiveHintBook" then
        table.insert(_G.BookAdd, v)
    end
end
for _, v in ipairs(workspace:GetDescendants()) do
	CheckBook(v)
end
BookSpawn = workspace.DescendantAdded:Connect(function(v)
    CheckBook(v)
end)
BookRemove = workspace.DescendantRemoving:Connect(function(v)
    for i = #_G.BookAdd, 1, -1 do
        if _G.BookAdd[i] == v then
            table.remove(_G.BookAdd, i)
            break
        end
    end
end)
end
while _G.EspBook do
for i, v in pairs(_G.BookAdd) do
if v:IsA("Model") then
Books(v)
end
end
task.wait()
end
    end
})

Esp:Toggle({
    Title = Translation(EspTr, "Esp Hiding Spots"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.EspHiding = Value
if _G.EspHiding == false then
_G.HidingAdd = {}
if HidingSpawn then
HidingSpawn:Disconnect()
HidingSpawn = nil
end
if HidingRemove then
HidingRemove:Disconnect()
HidingRemove = nil
end
for _, v in pairs(workspace:GetDescendants()) do 
if v.Name == "Bed" or v.Name == "Wardrobe" or v.Name == "Backdoor_Wardrobe" or v.Name == "Locker_Large" or v.Name == "Rooms_Locker" then
for i, z in pairs(v:GetChildren()) do
if z.Name:find("Esp_") then
z:Destroy()
end
end
end
end
else
function Hidings(v)
if (v.Name == "Bed" or v.Name == "Wardrobe" or v.Name == "Backdoor_Wardrobe" or v.Name == "Locker_Large" or v.Name == "Rooms_Locker") and v.PrimaryPart then
if v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight").FillColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
	v:FindFirstChild("Esp_Highlight").OutlineColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
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
	        (_G.EspName == true and v.Name or "")..
            (_G.EspDistance == true and "\nDistance ("..string.format("%.0f", Distance(v.PrimaryPart.Position)).."m)" or "")
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 15
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(255, 255, 255)
end
if _G.EspGui == true and v:FindFirstChild("Esp_Gui") == nil then
	GuiEsp = Instance.new("BillboardGui", v)
	GuiEsp.Adornee = v
	GuiEsp.Name = "Esp_Gui"
	GuiEsp.Size = UDim2.new(0, 100, 0, 150)
	GuiEsp.AlwaysOnTop = true
	GuiEspText = Instance.new("TextLabel", GuiEsp)
	GuiEspText.BackgroundTransparency = 1
	GuiEspText.Font = Enum.Font.Code
	GuiEspText.Size = UDim2.new(0, 100, 0, 100)
	GuiEspText.TextSize = 15
	GuiEspText.TextColor3 = Color3.new(0,0,0) 
	GuiEspText.TextStrokeTransparency = 0.5
	GuiEspText.Text = ""
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Color = Color3.new(0, 0, 0)
	UIStroke.Thickness = 1.5
	UIStroke.Parent = GuiEspText
	elseif _G.EspGui == false and v:FindFirstChild("Esp_Gui") then
	v:FindFirstChild("Esp_Gui"):Destroy()
end
end
end
local function CheckHiding(v)
    if not table.find(_G.HidingAdd, v) and v.Name == "Bed" or v.Name == "Wardrobe" or v.Name == "Backdoor_Wardrobe" or v.Name == "Locker_Large" or v.Name == "Rooms_Locker" then
        table.insert(_G.HidingAdd, v)
    end
end
for _, v in ipairs(workspace:GetDescendants()) do
	CheckHiding(v)
end
BookSpawn = workspace.DescendantAdded:Connect(function(v)
    CheckHiding(v)
end)
BookRemove = workspace.DescendantRemoving:Connect(function(v)
    for i = #_G.HidingAdd, 1, -1 do
        if _G.HidingAdd[i] == v then
            table.remove(_G.HidingAdd, i)
            break
        end
    end
end)
end
while _G.EspHiding do
for i, v in pairs(_G.HidingAdd) do
if v:IsA("Model") then
Hidings(v)
end
end
task.wait()
end
    end
})

Esp:Section({Title = Translation(EspTr, "Settings Esp"), TextXAlignment = "Left", TextSize = 17})

Esp:Toggle({
    Title = Translation(MiscTr, "Esp Gui"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.EspGui = Value
    end
})

Esp:Toggle({
    Title = Translation(MiscTr, "Esp HightLight"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.EspHighlight = Value
    end
})

Esp:Section({Title = Translation(EspTr, "Settings Color"), TextXAlignment = "Left", TextSize = 17})

Esp:Colorpicker({
    Title = Translation(EspTr, "Color Gui"),
    Default = Color3.fromRGB(255, 255, 255),
    Transparency = 0,
    Locked = false,
    Callback = function(Value) 
_G.EspGuiTextColor = Value
    end
})

Esp:Colorpicker({
    Title = Translation(EspTr, "Color HightLight"),
    Default = Color3.fromRGB(255, 255, 255),
    Transparency = 0,
    Locked = false,
    Callback = function(Value) 
_G.ColorLight = Value
    end
})

Esp:Slider({
    Title = Translation(EspTr, "Text Size [ Gui ]"),
    Step = 1,
    Value = {
        Min = 5,
        Max = 50,
        Default = 10,
    },
    Callback = function(Value)
_G.EspGuiTextSize = Value
    end
})

Esp:Section({Title = Translation(EspTr, "Settings Text"), TextXAlignment = "Left", TextSize = 17})

Esp:Toggle({
    Title = Translation(MiscTr, "Esp Name"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.EspName = Value
    end
})

Esp:Toggle({
    Title = Translation(MiscTr, "Esp Distance"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.EspDistance = Value
    end
})

Esp:Toggle({
    Title = Translation(MiscTr, "Esp Health"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.EspHealth = Value
    end
})

-----------------------------------
Info = Tabs["Info"]
local InviteCode = "NE4fqyAStd"
local DiscordAPI = "https://discord.com/api/v10/invites/" .. InviteCode .. "?with_counts=true&with_expiration=true"
local function LoadDiscordInfo()
    local success, result = pcall(function()
        return game:GetService("HttpService"):JSONDecode(ui.Creator.Request({
            Url = DiscordAPI,
            Method = "GET",
            Headers = {
                ["User-Agent"] = "RobloxBot/1.0",
                ["Accept"] = "application/json"
            }
        }).Body)
    end)

    if success and result and result.guild then
        local DiscordInfo = Info:Paragraph({
            Title = result.guild.name,
            Desc = ' <font color="#52525b">•</font> Member Count : ' .. tostring(result.approximate_member_count) ..
                '\n <font color="#16a34a">•</font> Online Count : ' .. tostring(result.approximate_presence_count),
            Image = "https://cdn.discordapp.com/icons/" .. result.guild.id .. "/" .. result.guild.icon .. ".png?size=1024",
            ImageSize = 42,
        })

        Info:Button({
            Title = "Update Info",
            Callback = function()
                local updated, updatedResult = pcall(function()
                    return game:GetService("HttpService"):JSONDecode(ui.Creator.Request({
                        Url = DiscordAPI,
                        Method = "GET",
                    }).Body)
                end)

                if updated and updatedResult and updatedResult.guild then
                    DiscordInfo:SetDesc(
                        ' <font color="#52525b">•</font> Member Count : ' .. tostring(updatedResult.approximate_member_count) ..
                        '\n <font color="#16a34a">•</font> Online Count : ' .. tostring(updatedResult.approximate_presence_count)
                    )
                end
            end
        })

        Info:Button({
            Title = "Copy Discord Invite",
            Callback = function()
                setclipboard("https://discord.gg/" .. InviteCode)
            end
        })
    else
        Info:Paragraph({
            Title = "Error fetching Discord Info",
            Desc = game:GetService("HttpService"):JSONEncode(result),
            Image = "triangle-alert",
            ImageSize = 26,
            Color = "Red",
        })
    end
end

LoadDiscordInfo()

Info:Divider()
Info:Section({ 
    Title = "All Creator Hub",
    TextXAlignment = "Center",
    TextSize = 17,
})
Info:Divider()
local Owner = Info:Paragraph({
    Title = "Nova Hoang (Nguyn Ngô Tn Hoàng)",
    Desc = "Owner Of Article Hub and Nihahaha Hub",
    Image = "rbxassetid://77933782593847",
    ImageSize = 30,
    Thumbnail = "",
    ThumbnailSize = 0,
    Locked = false,
})

local CoOwner = Info:Paragraph({
    Title = "Giang Hub (Giang)",
    Desc = "Co-Owner Of Article Hub and Nihahaha Hub",
    Image = "rbxassetid://138779531145636",
    ImageSize = 30,
    Thumbnail = "",
    ThumbnailSize = 0,
    Locked = false,
})
