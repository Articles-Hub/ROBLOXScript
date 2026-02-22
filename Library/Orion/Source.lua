local cloneref = (cloneref or clonereference or function(instance: any)
    return instance
end)
local getgenv = getgenv or function()
    return shared
end
local UserInputService: UserInputService = cloneref(game:GetService("UserInputService"))
local TweenService: TweenService = cloneref(game:GetService("TweenService"))
local RunService: RunService = cloneref(game:GetService("RunService"))
local HttpService: HttpService = cloneref(game:GetService("HttpService"))
local ContentProvider: ContentProvider = cloneref(game:GetService("ContentProvider"))
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = cloneref(LocalPlayer:GetMouse())

local PARENT = (gethui and gethui()) or cloneref(game:GetService("CoreGui"))
local request = http_request or request or (syn and syn.request) or (fluxus and fluxus.request)
local getcustomasset = getcustomasset or getsynasset
local makefolder = makefolder or function() end

OrionLib = {
        Elements = {},
        ThemeObjects = {},
        Connections = {},
        Flags = {},
        OnDestroyTo = {},
        Themes = {
                Default = {
                        Main = Color3.fromRGB(25, 25, 25),
                        Second = Color3.fromRGB(32, 32, 32),
                        Stroke = Color3.fromRGB(60, 60, 60),
                        Divider = Color3.fromRGB(60, 60, 60),
                        Text = Color3.fromRGB(240, 240, 240),
                        TextDark = Color3.fromRGB(150, 150, 150)
                }
        },
        NotifyVolume = 3,
        SelectedTheme = "Default",
        Folder = "OrionLibSave",
}

getgenv().Destroy = false

--Feather Icons https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/Library/Orion/icons.json
local Icons = {}

local Success, Response = pcall(function()
        Icons = HttpService:JSONDecode(game:HttpGetAsync("https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/Library/Orion/icons.json")).icons
end)

if not Success then
        warn("\nOrion Library - Failed to load Feather Icons. Error code: " .. Response .. "\n")
end

local function GetIcon(IconName: string)
		local IconLower = IconName:lower() or ""
        if Icons[IconLower] ~= nil then
                return Icons[IconLower]
        else
                return nil
        end
end   

Orion = Instance.new("ScreenGui")
Orion.Name = "Orion"
Orion.Parent = PARENT

_currentKey = Enum.KeyCode.RightShift
function OrionLib:SetKeyToggleUI(key: Enum.KeyCode)
    local success, keyui = pcall(function()
		return Enum.KeyCode[key]
	end)
	_currentKey = (success and keyui or Enum.KeyCode.RightShift)
end

function OrionLib:SetVideoLink(link: string)
    if typeof(link) == "string" then
	    if not MainWindowVideo then
		    for i, v in pairs(Orion:GetChildren()) do
				if v:IsA("VideoFrame") then
					MainWindowVideo = v
				end
			end
		end
		if MainWindowVideo and MainWindowVideo:IsA("VideoFrame") then
			local loaded = OrionLib:MakeAsset({Icon = link}, {Root = "OrionLibSave", Folder = "OrionVideo"})
			if loaded then
				MainWindowVideo.Video = loaded.Icon
				MainWindowVideo.BackgroundColor3 = Color3.new(255, 255, 255)
				
				spawn(function()
					repeat task.wait() until MainWindowVideo and MainWindowVideo:FindFirstChild("ItemContainer")
					for i, v in pairs(MainWindowVideo:GetChildren()) do
						if v.Name == "ItemContainer" then
							for k, j in pairs(v:GetChildren()) do
								if j:IsA("Frame") and j.BackgroundTransparency < 1 then
									j.BackgroundTransparency = 0.15
								end
							end
						end
					end
				end)
			else
				spawn(function()
					repeat task.wait() until MainWindowVideo and MainWindowVideo:FindFirstChild("ItemContainer")
					for i, v in pairs(MainWindowVideo:GetChildren()) do
						if v.Name == "ItemContainer" then
							for k, j in pairs(v:GetChildren()) do
								if j:IsA("Frame") and j.BackgroundTransparency < 1 then
									j.BackgroundTransparency = 0
								end
							end
						end
					end
				end)
				pcall(function() MainWindowVideo.Video = "" end)
			end
		end
	end
end

function OrionLib:SetFont(font: Enum.Font)
	if Orion then
		local success, fontui = pcall(function()
			return Enum.Font[font]
		end)
		fontlocal = (success and fontui or Enum.Font.GothamBold)
		for i, v in pairs(Orion:GetDescendants()) do
			if (v:IsA("TextButton") or v:IsA("TextLabel") or v:IsA("TextBox")) then
				v.Font = fontlocal
			end
		end
	end
end

function OrionLib:AddConnect(Signal, Function)
	if getgenv().Destroy then return end
	local SignalConnect = Signal:Connect(Function)
    table.insert(OrionLib.Connections, SignalConnect)
    return SignalConnect
end

OrionLib:SetFont("GothamBold")

function OrionLib:IsRunning()
        return Orion.Parent == PARENT
end

local function AddConnection(Signal, Function)
        if (not OrionLib:IsRunning()) or getgenv().Destroy then
                return
        end
        local SignalConnect = Signal:Connect(Function)
        table.insert(OrionLib.Connections, SignalConnect)
        return SignalConnect
end

task.spawn(function()
        while (OrionLib:IsRunning()) or getgenv().Destroy do
                wait()
        end

        for _, Connection in next, OrionLib.Connections do
                Connection:Disconnect()
        end
end)

local function MakeDraggable(instance: Instance, main: Instance)
    local dragging = false
    local dragInput
    local mousePos
    local framePos

    AddConnection(instance.InputBegan, function(input: InputObject)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mousePos = input.Position
            framePos = main.Position

            AddConnection(input.Changed, function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    AddConnection(instance.InputChanged, function(input: InputObject)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or Enum.UserInputType.Touch) then
            dragInput = input
        end
    end)

    AddConnection(UserInputService.InputChanged, function(input: InputObject)
        if dragging and input == dragInput then
            local delta = input.Position - mousePos
            main.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)
end

function OrionLib:MakeAsset(list, options)
    options = options or {}
    local root = options.Root or "AssetsHub"
    local folder = root .. "/" .. (options.Folder or "Cache")
    local retries = options.Retries or 3
    local minSize = options.MinSize or 100
    local proxy = options.Proxy or ""

    if not isfolder(root) then makefolder(root) end
    if not isfolder(folder) then makefolder(folder) end

    local assets = {}
    local preloadBatch = {}

    for id, url in pairs(list) do
        local cleanId = tostring(id):gsub("[^%w%-%_]", "_")
        local ext = url:match("^[^%?]+"):match("%.([%w]+)$") or "png"
        local path = folder .. "/" .. cleanId .. "." .. ext
        local success, content = pcall(readfile, path)
        if not success or #content < minSize then
            for _ = 1, retries do
                local response = request({
                    Url = proxy .. url,
                    Method = "GET"
                })
                if response and response.Body and #response.Body >= minSize then
                    content = response.Body
                    writefile(path, content)
                    break
                end
                task.wait(0.2)
            end
        end
        if isfile(path) then
            local assetId = getcustomasset(path)
            assets[id] = assetId
            
            if not ext:find("mp4") and not ext:find("webm") and not ext:find("mkv") then
                table.insert(preloadBatch, assetId)
            end
        end
    end
    if #preloadBatch > 0 then
        task.spawn(function()
            pcall(function() ContentProvider:PreloadAsync(preloadBatch) end)
        end)
    end
    return assets
end

local function Create(Name, Properties, Children)
        local Object = Instance.new(Name)
        for i, v in next, Properties or {} do
                Object[i] = v
        end
        for i, v in next, Children or {} do
                v.Parent = Object
        end
        return Object
end

local function CreateElement(ElementName, ElementFunction)
        OrionLib.Elements[ElementName] = function(...)
                return ElementFunction(...)
        end
end

local function AddItemTable(Table, Item, Value)
        local Item = tostring(Item)
        local Count = 1

        while Table[Item] do
                Count = Count + 1
                Item = string.format('%s-%d', Item, Count)
        end

        Table[Item] = Value
end


local function MakeElement(ElementName, ...)
        local NewElement = OrionLib.Elements[ElementName](...)
        return NewElement
end

local function SetProps(Element, Props)
        table.foreach(Props, function(Property, Value)
                Element[Property] = Value
        end)
        return Element
end

local Total = {
        SetChildren = 0;
        AddThemeObject = 0;
};

local function SetChildren(Element, Children)
        Total.SetChildren += 1;
    table.foreach(Children, function(_, Child)
                Child.Parent = Element
        end)
        return Element
end

local function Round(Number, Factor)
	local decimals = tostring(Factor):match("%.(%d+)")
	decimals = decimals and #decimals or 0	
	local result = math.floor(Number / Factor + 0.5) * Factor
	return tonumber(string.format("%." .. decimals .. "f", result))
end

local function ReturnProperty(Object)
        if Object:IsA("Frame") or Object:IsA("TextButton") then
                return "BackgroundColor3"
        end 
        if Object:IsA("ScrollingFrame") then
                return "ScrollBarImageColor3"
        end 
        if Object:IsA("UIStroke") then
                return "Color"
        end 
        if Object:IsA("TextLabel") or Object:IsA("TextBox") then
                return "TextColor3"
        end   
        if Object:IsA("ImageLabel") or Object:IsA("ImageButton") then
                return "ImageColor3"
        end   
end

local function AddThemeObject(Object, Type)
    if not OrionLib.ThemeObjects[Type] then
        OrionLib.ThemeObjects[Type] = {}
    end    
    table.insert(OrionLib.ThemeObjects[Type], Object)
    local property = ReturnProperty(Object)
    local theme = OrionLib.Themes[OrionLib.SelectedTheme]
    if property and theme and theme[Type] then
        Object[property] = theme[Type]
    end
    return Object
end

local function SetTheme()
        for Name, Type in pairs(OrionLib.ThemeObjects) do
                for _, Object in pairs(Type) do
                        Object[ReturnProperty(Object)] = OrionLib.Themes[OrionLib.SelectedTheme][Name]
                end    
        end    
end

local function PackColor(Color)
        return {R = Color.R * 255, G = Color.G * 255, B = Color.B * 255}
end    

local function UnpackColor(Color)
        return Color3.fromRGB(Color.R, Color.G, Color.B)
end

parser = {
    Toggle = {
        Save = function(data)
            return {Type = "Toggle", Value = data.Value}
        end,
        Load = function(flag, data)
            if OrionLib.Flags[flag] then
                OrionLib.Flags[flag]:Set(data.Value)
            end
        end
    },
    Slider = {
        Save = function(data)
            return {Type = "Slider", Value = data.Value}
        end,
        Load = function(flag, data)
            if OrionLib.Flags[flag] then
                OrionLib.Flags[flag]:Set(data.Value)
            end
        end
    },
    Input = {
        Save = function(data)
            return {Type = "Input", Text = data.Value}
        end,
        Load = function(flag, data)
            if OrionLib.Flags[flag] then
                OrionLib.Flags[flag]:Set(data.Text)
            end
        end
    },
    Dropdown = {
        Save = function(data)
            return {Type = "Dropdown", Value = data.Value}
        end,
        Load = function(flag, data)
            if OrionLib.Flags[flag] then
                OrionLib.Flags[flag]:SetValue(data.Value)
            end
        end
    },
    Bind = {
        Save = function(data)
            return {Type = "Bind", Keybind = tostring(data.Value)}
        end,
        Load = function(flag, data)
            if OrionLib.Flags[flag] then
                OrionLib.Flags[flag]:Set(GetKeybindFromString(data.Keybind))
            end
        end
    },
    Colorpicker = {
        Save = function(data)
            return {Type = "Colorpicker", Color = data.Value:ToHex()}
        end,
        Load = function(flag, data)
            if OrionLib.Flags[flag] then
                OrionLib.Flags[flag]:Set(Color3.fromHex(data.Color))
            end
        end
    }
}

function CheckSaveFolder()
    if OrionLib.Folder == nil then return false end    
    if not isfolder(OrionLib.Folder) then
        makefolder(OrionLib.Folder)
    end
    if not isfolder(OrionLib.Folder.."/configs") then
        makefolder(OrionLib.Folder.."/configs")
    end
    return true
end

function SaveConfig(name)
    if not CheckSaveFolder() then return false, "Save is nil" end
    if not writefile then return false, "Where a writefile?" end
    if name:gsub(" ", "") == "" then return OrionLib:MakeNotification({Name = "[Save Config]", Content = "Config Name can't be empty", Time = 5}) end
    local data = {}
    for i, v in pairs(OrionLib.Flags) do
        if v.Type and parser[v.Type] then
            data[i] = parser[v.Type].Save(v)
        end
    end
	writefile(OrionLib.Folder.."/configs/"..name..".json", tostring(HttpService:JSONEncode(data)))
    return true
end

function LoadConfig(name)
    if not CheckSaveFolder() then return false, "Save is nil" end
    if not isfile then return false, "Where a isfile?" end
    if name:gsub(" ", "") == "" then return OrionLib:MakeNotification({Name = "[Save Config]", Content = "Config Name can't be empty", Time = 5}) end
    local file = OrionLib.Folder.."/configs/"..name..".json"
    if not isfile(file) then 
        return false, "Invalid file"
    end
    local data = HttpService:JSONDecode(readfile(file))
    for i, v in pairs(data) do
        if not (v.Type and parser[v.Type]) then continue end
        task.spawn(parser[v.Type].Load, i, v)
    end
    return true
end

function GetSavedConfigs()
    if not CheckSaveFolder() then return false, "Save is nil" end
    local path = OrionLib.Folder.."/configs"
    local configsList = listfiles(path)
    local configs = {}
    for i = 1, #configsList do
        local config = configsList[i]
        if config:sub(-5) == ".json" then
            table.insert(configs, config:sub(#path + 2, -6))
        end
    end
    return configs
end
		
function OrionLib:LoadAutoloadConfig()
    if not CheckSaveFolder() then return end
    local settingsData = {}
    if isfile(OrionLib.Folder.."/settings.json") then
        settingsData = HttpService:JSONDecode(readfile(OrionLib.Folder.."/settings.json"))
    end
    if settingsData["Autoload"] then
        LoadConfig(settingsData["Autoload"])
        OrionLib:MakeNotification({Name = "[Save Config]", Content = "Autoload "..'"'..settingsData["Autoload"]..'"'.." Success", Time = 5})
    end
end

function OrionLib:SetAutoloadConfig(name)
    if not CheckSaveFolder() then return end
    if name:gsub(" ", "") == "" then return OrionLib:MakeNotification({Name = "[Save Config]", Content = "Autoload can't be empty", Time = 5}) end
    local data = {["Autoload"] = name}
    writefile(OrionLib.Folder.."/settings.json", tostring(HttpService:JSONEncode(data)))
end

function OrionLib:SetUnAutoloadConfig(name)
    if not CheckSaveFolder() then return end
    if name:gsub(" ", "") == "" then return OrionLib:MakeNotification({Name = "[Save Config]", Content = "Unautoload can't be empty", Time = 5}) end
    if not isfile then return end
    local path = OrionLib.Folder.."/settings.json"
    local data = {}
    if isfile(path) then
        local raw = readfile(path)
        local ok, decoded = pcall(function()
            return HttpService:JSONDecode(raw)
        end)
        if ok and typeof(decoded) == "table" then
            data = decoded
        end
    end
    if data.Autoload == name then
	    data.Autoload = nil
	else
		return OrionLib:MakeNotification({Name = "[Save Config]", Content = "Config Name can't be autoload", Time = 5})
	end
    writefile(path, HttpService:JSONEncode(data))
end

local WhitelistedMouse = {Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2,Enum.UserInputType.MouseButton3}
local BlacklistedKeys = {Enum.KeyCode.Unknown,Enum.KeyCode.W,Enum.KeyCode.A,Enum.KeyCode.S,Enum.KeyCode.D,Enum.KeyCode.Up,Enum.KeyCode.Left,Enum.KeyCode.Down,Enum.KeyCode.Right,Enum.KeyCode.Slash,Enum.KeyCode.Tab,Enum.KeyCode.Backspace,Enum.KeyCode.Escape}

local function CheckKey(Table, Key)
        for _, v in next, Table do
                if v == Key then
                        return true
                end
        end
end

CreateElement("Corner", function(Scale, Offset)
        local Corner = Create("UICorner", {
                CornerRadius = UDim.new(Scale or 0, Offset or 10)
        })
        return Corner
end)

CreateElement("Stroke", function(Color, Thickness)
        local Stroke = Create("UIStroke", {
                Color = Color or Color3.fromRGB(255, 255, 255),
                Thickness = Thickness or 1
        })
        return Stroke
end)

CreateElement("List", function(Scale, Offset)
        local List = Create("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(Scale or 0, Offset or 0)
        })
        return List
end)

CreateElement("Padding", function(Bottom, Left, Right, Top)
        local Padding = Create("UIPadding", {
                PaddingBottom = UDim.new(0, Bottom or 4),
                PaddingLeft = UDim.new(0, Left or 4),
                PaddingRight = UDim.new(0, Right or 4),
                PaddingTop = UDim.new(0, Top or 4)
        })
        return Padding
end)

CreateElement("TFrame", function()
        local TFrame = Create("Frame", {
                BackgroundTransparency = 1
        })
        return TFrame
end)

CreateElement("Frame", function(Color)
        local Frame = Create("Frame", {
                BackgroundColor3 = Color or Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0
        })
        return Frame
end)

CreateElement("RoundFrame", function(Color, Scale, Offset)
        local Frame = Create("Frame", {
                BackgroundColor3 = Color or Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0
        }, {
                Create("UICorner", {
                        CornerRadius = UDim.new(Scale, Offset)
                })
        })
        return Frame
end)

CreateElement("RoundVideo", function(Color, Scale, Offset)
        local Video = Create("VideoFrame", {
                BackgroundColor3 = Color or Color3.fromRGB(255, 255, 255),
                Looped = true,
                Playing = true
        }, {
                Create("UICorner", {
                        CornerRadius = UDim.new(Scale, Offset)
                })
        })
        return Video
end)

CreateElement("Button", function()
        local Button = Create("TextButton", {
                Text = "",
                AutoButtonColor = false,
                BackgroundTransparency = 1,
                BorderSizePixel = 0
        })
        return Button
end)

CreateElement("ScrollFrame", function(Color, Width)
        local ScrollFrame = Create("ScrollingFrame", {
                BackgroundTransparency = 1,
                MidImage = "rbxassetid://7445543667",
                BottomImage = "rbxassetid://7445543667",
                TopImage = "rbxassetid://7445543667",
                ScrollBarImageColor3 = Color,
                BorderSizePixel = 0,
                ScrollBarThickness = Width,
                CanvasSize = UDim2.new(0, 0, 0, 0)
        })
        return ScrollFrame
end)

CreateElement("Image", function(ImageID)
        local ImageNew = Create("ImageLabel", {
                Image = ImageID,
                BackgroundTransparency = 1
        })

        if GetIcon(ImageID) ~= nil then
                ImageNew.Image = GetIcon(ImageID)
        end        

        return ImageNew
end)

CreateElement("ImageButton", function(ImageID)
        local Image = Create("ImageButton", {
                Image = ImageID,
                BackgroundTransparency = 1
        })
        return Image
end)

CreateElement("Label", function(Text, TextSize, Transparency)
        local Label = Create("TextLabel", {
                Text = Text or "",
                TextColor3 = Color3.fromRGB(240, 240, 240),
                TextTransparency = Transparency or 0,
                TextSize = TextSize or 15,
                Font = Enum.Font.Gotham,
                RichText = true,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left
        })
        return Label
end)

local NotificationHolder = SetProps(SetChildren(MakeElement("TFrame"), {
        SetProps(MakeElement("List"), {
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Bottom,
                Padding = UDim.new(0, 5)
        })
}), {
        Position = UDim2.new(1, -25, 1, -25),
        Size = UDim2.new(0, 300, 1, -25),
        AnchorPoint = Vector2.new(1, 1),
        Parent = Orion
})

function OrionLib:MakeNotification(NotificationConfig)
	if getgenv().Destroy then return end
	task.spawn(function()
		NotificationConfig.Name = NotificationConfig.Name or "Notification"
		NotificationConfig.Content = NotificationConfig.Content or "Content"
		NotificationConfig.Image = NotificationConfig.Image or "rbxassetid://14229447778"
		NotificationConfig.Time = NotificationConfig.Time or 5
		NotificationConfig.Volume = NotificationConfig.Volume or OrionLib.NotifyVolume
		
		local function ParseText(Str)
			if type(Str) ~= "string" then return Str end
			Str = Str:gsub("%[Highlight:['\"](.-)['\"]%]", '<font color="#ffffff"><b>%1</b></font>')
			Str = Str:gsub("%[underline:['\"](.-)['\"]%]", '<u>%1</u>')
			Str = Str:gsub("%[Color_(.-):['\"](.-)['\"]%]", '<font color="%1">%2</font>')
			return Str
		end

		local IconId = NotificationConfig.Image
		if not tostring(IconId):find("rbxassetid") and tostring(IconId):match("%d+") then
			IconId = "rbxassetid://" .. tostring(IconId):match("%d+")
		end

		local NotificationParent = SetProps(MakeElement("Frame"), {
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			Parent = NotificationHolder,
			BackgroundTransparency = 1,
			ClipsDescendants = false
		})
		
		local Card = SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(25, 25, 25), 0, 8), {
			Parent = NotificationParent,
			Size = UDim2.new(1, -20, 0, 0),
			Position = UDim2.new(1, 30, 0, 0), 
			AutomaticSize = Enum.AutomaticSize.Y
		}), {
			MakeElement("Stroke", Color3.fromRGB(60, 60, 60), 1),
			Create("UIPadding", {
				PaddingTop = UDim.new(0, 10),
				PaddingBottom = UDim.new(0, 10),
				PaddingLeft = UDim.new(0, 12),
				PaddingRight = UDim.new(0, 12)
			})
		})

		local List = Create("UIListLayout", {
			Parent = Card,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 6),
			HorizontalAlignment = Enum.HorizontalAlignment.Center
		})
		
		local Header = Create("Frame", {
			Parent = Card,
			Size = UDim2.new(1, 0, 0, 20),
			BackgroundTransparency = 1,
			LayoutOrder = 1
		})
		
		Create("UIListLayout", {
			Parent = Header,
			FillDirection = Enum.FillDirection.Horizontal,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			Padding = UDim.new(0, 8)
		})
		
		Create("ImageLabel", {
			Parent = Header,
			Size = UDim2.new(0, 16, 0, 16),
			Image = IconId,
			ImageColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1
		})
		
		Create("TextLabel", {
			Parent = Header,
			AutomaticSize = Enum.AutomaticSize.XY,
			Text = ParseText(NotificationConfig.Name),
			Font = Enum.Font.GothamBold,
			TextSize = 13,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			RichText = true
		})

		if NotificationConfig.Banner then
			local Banner = Create("ImageLabel", {
				Parent = Card,
				Size = UDim2.new(1, 0, 0, 100),
				Image = NotificationConfig.Banner,
				ScaleType = Enum.ScaleType.Crop,
				BackgroundTransparency = 1,
				LayoutOrder = 2
			})
			Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = Banner})
			Create("UIStroke", {
				Parent = Banner, 
				Transparency = 0.5, 
				Color = Color3.fromRGB(80,80,80),
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			})
		end
		
		Create("TextLabel", {
			Parent = Card,
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			Text = ParseText(NotificationConfig.Content),
			Font = Enum.Font.GothamSemibold,
			TextSize = 12,
			TextColor3 = Color3.fromRGB(200, 200, 200),
			BackgroundTransparency = 1,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextWrapped = true,
			RichText = true,
			LayoutOrder = 3
		})

		Create("Frame", {Parent = Card, Size = UDim2.new(1,0,0,2), BackgroundTransparency = 1, LayoutOrder = 4})

		local BarWrapper = Create("Frame", {
			Parent = Card,
			Size = UDim2.new(1, 4, 0, 2),
			BackgroundColor3 = Color3.fromRGB(45, 45, 45),
			BorderSizePixel = 0,
			LayoutOrder = 5
		})
		Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = BarWrapper})

		local Bar = Create("Frame", {
			Parent = BarWrapper,
			Size = UDim2.new(0, 0, 1, 0),
			BackgroundColor3 = Color3.fromRGB(0, 170, 255),
			BorderSizePixel = 0
		})
		Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = Bar})

		if NotificationConfig.SoundId then
			local sId = tostring(NotificationConfig.SoundId):match("%d+")
			if sId then
				local s = Instance.new("Sound", workspace)
				s.SoundId = "rbxassetid://" .. sId
				s.Volume = NotificationConfig.Volume
				s.PlayOnRemove = true
				s:Destroy()
			end
		end

		TweenService:Create(Card, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(1, -272, 0, 0)}):Play()
		TweenService:Create(Bar, TweenInfo.new(NotificationConfig.Time, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 1, 0)}):Play()
		task.wait(NotificationConfig.Time)
		local Out = TweenService:Create(Card, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(1, 90, 0, 0)})
		Out:Play()
		Out.Completed:Wait()
		NotificationParent:Destroy()
	end)
end

getgenv().TogglesSaveTable = {}
getgenv().NameBindKey = {}
function KeyBindAdd()
	KeyBindFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
	        Size = UDim2.new(0, 235, 0, 160),
			Position = UDim2.fromOffset(6, 6),
	        BackgroundTransparency = 0,
	        Name = "KeyBind",
			Visible = false,
	        Parent = Orion
	}), {
	        AddThemeObject(SetProps(MakeElement("Label", "Key Binds", 15), {
	                Size = UDim2.new(1, -12, 0.15, 0),
	                Position = UDim2.new(0, 8, 0, 0),
	                Font = Enum.Font.GothamBold,
	                Name = "Content"
	        }), "Text"),
	        AddThemeObject(MakeElement("Stroke"), "Stroke")
	}), "Second")
	
	local WindowTopBarLine = AddThemeObject(SetProps(MakeElement("Frame"), {
            Size = UDim2.new(1, 0, 0, 1),
            Position = UDim2.new(0, 0, 0, 25),
            Parent = KeyBindFrame
    }), "Stroke")
	
	local Container = AddThemeObject(SetChildren(SetProps(MakeElement("ScrollFrame", Color3.fromRGB(255, 255, 255), 5), {
		Size = UDim2.new(1, 0, 0.83, 0),
		Position = UDim2.new(0, 0, 0.17, 0),
		Parent = KeyBindFrame,
		Name = "ItemContainer"
	}), {
		MakeElement("List", 0, 6),
		MakeElement("Padding", 15, 10, 10, 15)
	}), "Divider")
	
	MakeDraggable(KeyBindFrame.Content, KeyBindFrame)
	AddConnection(Container.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
		Container.CanvasSize = UDim2.new(0, 0, 0, Container.UIListLayout.AbsoluteContentSize.Y + 30)
	end)
end

KeyBindAdd()
function OrionLib:SetKeyBindVisible(visi: bool)
	if KeyBindFrame then
		KeyBindFrame.Visible = visi
	end
end

function OrionLib:MakeWatermark(Watermark)
	Watermark = Watermark or {}
	Watermark.Text = Watermark.Text or "Nah"
	Watermark.Visible = Watermark.Visible or false
	Watermark.Flag = Watermark.Flag or nil
	
	local WatermarkHe = {}
	local LabelFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
	        Size = UDim2.new(0, 24, 0, 40),
			Position = UDim2.fromOffset(6, 6),
	        BackgroundTransparency = 0,
			Visible = Watermark.Visible,
	        Parent = Orion
	}), {
	        AddThemeObject(SetProps(MakeElement("Label", Watermark.Text, 15), {
	                Size = UDim2.new(1, -12, 1, 0),
	                Position = UDim2.new(0, 8, 0, 0),
	                Font = Enum.Font.GothamBold,
	                Name = "Content"
	        }), "Text"),
	        AddThemeObject(MakeElement("Stroke"), "Stroke")
	}), "Second")
	
	MakeDraggable(LabelFrame.Content, LabelFrame)
	
	function WatermarkHe:SetText(text: string)
		if getgenv().Destroy then return end
		if LabelFrame and LabelFrame:FindFirstChild("Content") then
			LabelFrame.Content.Text = text
		end
	end
	function WatermarkHe:SetVisible(visi: bool)
		if getgenv().Destroy then return end
		if LabelFrame then
			LabelFrame.Visible = visi
		end
	end
	if LabelFrame and LabelFrame:FindFirstChild("Content") then
		AddConnection(LabelFrame.Content:GetPropertyChangedSignal("Text"), function()
			local width = LabelFrame.Content.TextBounds.X + 20
			TweenService:Create(LabelFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, width, 0, 35)}):Play()
			TweenService:Create(LabelFrame.Content, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, width, 0, 35)}):Play()
		end)
	end	
	if Watermark.Flag then
		OrionLib.Flags[Watermark.Flag] = WatermarkHe
	end
	return WatermarkHe
end

function OrionLib:MakeWindow(WindowConfig)
        local FirstTab = true
        local Minimized = false
        local Loaded = false
        local UIHidden = false

        WindowConfig = WindowConfig or {}
        WindowConfig.Name = WindowConfig.Name or "Library"
        WindowConfig.ConfigFolder = WindowConfig.ConfigFolder or WindowConfig.Name
        WindowConfig.SaveConfig = WindowConfig.SaveConfig or false
        WindowConfig.HidePremium = WindowConfig.HidePremium or false
        if WindowConfig.IntroEnabled == nil then
                WindowConfig.IntroEnabled = true
        end
        WindowConfig.IntroText = WindowConfig.IntroText or "Orion Library"
        WindowConfig.CloseCallback = WindowConfig.CloseCallback or function() end
        WindowConfig.ShowIcon = WindowConfig.ShowIcon or false
        WindowConfig.Icon = WindowConfig.Icon or "rbxassetid://14229447778"
        WindowConfig.IntroIcon = WindowConfig.IntroIcon or "rbxassetid://14229447778"
        WindowConfig.SearchBar = WindowConfig.SearchBar or nil
        WindowConfig.LinkVideo = WindowConfig.LinkVideo or nil

        local TabHolder = AddThemeObject(SetChildren(SetProps(MakeElement("ScrollFrame", Color3.fromRGB(255, 255, 255), 4),
                WindowConfig.SearchBar and WindowConfig.SearchBar.Tabs == true and {
                        Size = UDim2.new(1, 0, 1, -90),
                        Position = UDim2.new(0, 0, 0, 40),
                } or {
                        Size = UDim2.new(1, 0, 1, -50)
                }),
                {
                        MakeElement("List"),
                        MakeElement("Padding", 8, 0, 0, 8)
                }), "Divider")
                
        if TabHolder then
	        TabHolder.BackgroundTransparency = 1
		end

        AddConnection(TabHolder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
                TabHolder.CanvasSize = UDim2.new(0, 0, 0, TabHolder.UIListLayout.AbsoluteContentSize.Y + 16)
        end)

        local CloseBtn = SetChildren(SetProps(MakeElement("Button"), {
                Size = UDim2.new(0.5, 0, 1, 0),
                Position = UDim2.new(0.5, 0, 0, 0),
                BackgroundTransparency = 1
        }), {
                AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072725342"), {
                        Position = UDim2.new(0, 9, 0, 6),
                        Size = UDim2.new(0, 18, 0, 18),
                }), "Text")
        })

        local MinimizeBtn = SetChildren(SetProps(MakeElement("Button"), {
                Size = UDim2.new(0.5, 0, 1, 0),
                BackgroundTransparency = 1
        }), {
                AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072719338"), {
                        Position = UDim2.new(0, 9, 0, 6),
                        Size = UDim2.new(0, 18, 0, 18),
                        Name = "Ico"
                }), "Text")
        })

        local DragPoint = SetProps(MakeElement("TFrame"), {
                Size = UDim2.new(1, 0, 0, 50)
        })
		
		local hasLinkVideo = typeof(WindowConfig.LinkVideo) == "string"
        local WindowStuff = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 10), {
                Size = UDim2.new(0, 150, 1, -50),
                Position = UDim2.new(0, 0, 0, 50),
                BackgroundTransparency = hasLinkVideo and 1 or 0
        }), {
                AddThemeObject(SetProps(MakeElement("Frame"), {
                        Size = UDim2.new(1, 0, 0, 10),
                        Position = UDim2.new(0, 0, 0, 0),
                        Visible = not hasLinkVideo
                }), "Second"), 
                AddThemeObject(SetProps(MakeElement("Frame"), {
                        Size = UDim2.new(0, 10, 1, 0),
                        Position = UDim2.new(1, -10, 0, 0),
                        Visible = not hasLinkVideo
                }), "Second"), 
                AddThemeObject(SetProps(MakeElement("Frame"), {
                        Size = UDim2.new(0, 1, 1, 0),
                        Position = UDim2.new(1, -1, 0, 0),
                }), "Stroke"), 
                TabHolder,
                SetChildren(SetProps(MakeElement("TFrame"), {
                        Size = UDim2.new(1, 0, 0, 50),
                        Position = UDim2.new(0, 0, 1, -50)
                }), {
                        AddThemeObject(SetProps(MakeElement("Frame"), {
                                Size = UDim2.new(1, 0, 0, 1)
                        }), "Stroke"), 
                        AddThemeObject(SetChildren(SetProps(MakeElement("Frame"), {
                                AnchorPoint = Vector2.new(0, 0.5),
                                Size = UDim2.new(0, 32, 0, 32),
                                Position = UDim2.new(0, 10, 0.5, 0)
                        }), {
                                SetChildren(SetProps(MakeElement("Image", "https://www.roblox.com/headshot-thumbnail/image?userId=".. LocalPlayer.UserId .."&width=420&height=420&format=png"), {
                                        Size = UDim2.new(1, 0, 1, 0)
                                }), {MakeElement("Corner", 1)}),
                                AddThemeObject(SetChildren(SetProps(MakeElement("Image", "rbxassetid://4031889928"), {
                                        Size = UDim2.new(1, 0, 1, 0),
                                }), {MakeElement("Corner", 1)}), "Second"),
                                MakeElement("Corner", 1)
                        }), "Divider"),
                        SetChildren(SetProps(MakeElement("TFrame"), {
                                AnchorPoint = Vector2.new(0, 0.5),
                                Size = UDim2.new(0, 32, 0, 32),
                                Position = UDim2.new(0, 10, 0.5, 0)
                        }), {
                                AddThemeObject(MakeElement("Stroke"), "Stroke"),
                                MakeElement("Corner", 1)
                        }),
                        AddThemeObject(SetProps(MakeElement("Label", LocalPlayer.DisplayName, WindowConfig.HidePremium and 14 or 13), {
                                Size = UDim2.new(1, -60, 0, 13),
                                Position = WindowConfig.HidePremium and UDim2.new(0, 50, 0, 19) or UDim2.new(0, 50, 0, 12),
                                Font = Enum.Font.GothamBold,
                                ClipsDescendants = true
                        }), "Text"),
                        AddThemeObject(SetProps(MakeElement("Label", "", 12), {
                                Size = UDim2.new(1, -60, 0, 12),
                                Position = UDim2.new(0, 50, 1, -25),
                                Visible = not WindowConfig.HidePremium
                        }), "TextDark")
                }),
        }), "Second")

        if WindowConfig.SearchBar and WindowConfig.SearchBar.Tabs == true then
                local SearchBox = Create("TextBox", {
                        Size = UDim2.new(1, 0, 1, 0),
                        BackgroundTransparency = 1,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        PlaceholderColor3 = Color3.fromRGB(210,210,210),
                        PlaceholderText = WindowConfig.SearchBar.Default or "🔍 Search",
                        Font = Enum.Font.GothamBold,
                        TextWrapped = true,
                        Text = "",
                        TextXAlignment = Enum.TextXAlignment.Center,
                        TextSize = 14,
                        ClearTextOnFocus = WindowConfig.SearchBar.ClearTextOnFocus or true
                })

                local TextboxActual = AddThemeObject(SearchBox, "Text")

                local SearchBar = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 1, 6), {
                        Parent = WindowStuff,
                        Size = UDim2.new(0, 130, 0, 24),
                        Position = UDim2.new(1.013, -12, 0.075, 0),
                        BackgroundTransparency = typeof(WindowConfig.LinkVideo) == "string" and 0.5 or 0,
                        AnchorPoint = Vector2.new(1, 0.5)
                }), {
                        AddThemeObject(MakeElement("Stroke"), "Stroke"),
                        TextboxActual
                }), "Main")

                local function SearchHandle()
                        local Text = string.lower(SearchBox.Text)

                        for i,v in pairs(TabHolder:GetChildren()) do
                                if v:IsA("TextButton") then
                                        if string.find(string.lower(i), Text) then
                                                v.Visible = true
                                        else
                                                v.Visible = false
                                        end
                                end
                        end
                end

                AddConnection(TextboxActual:GetPropertyChangedSignal("Text"), SearchHandle);
        end

        local WindowName = AddThemeObject(SetChildren(SetProps(MakeElement("Label", WindowConfig.Name, 14), {
                Size = UDim2.new(1, -30, 2, 0),
                Position = UDim2.new(0, 25, 0, -24),
                Font = Enum.Font.GothamBlack,
                TextSize = 20
        }), {AddThemeObject(MakeElement("Stroke"), "Stroke")}), "Text")

        local WindowTopBarLine = AddThemeObject(SetProps(MakeElement("Frame"), {
                Size = UDim2.new(1, 0, 0, 1),
                Position = UDim2.new(0, 0, 1, -1)
        }), "Stroke")
		
		if typeof(WindowConfig.LinkVideo) == "string" then
			RoundMainWindow = "RoundVideo" 
		else
			RoundMainWindow = "RoundFrame"
		end
        local MainWindow = AddThemeObject(SetChildren(SetProps(MakeElement(RoundMainWindow or "RoundFrame", Color3.fromRGB(255, 255, 255), 0, 10), {
                Parent = Orion,
                Position = UDim2.new(0.5, -307, 0.5, -172),
                Size = UDim2.new(0, 615, 0, 344),
                ClipsDescendants = true
        }), {
                SetChildren(SetProps(MakeElement("TFrame"), {
                        Size = UDim2.new(1, 0, 0, 50),
                        Name = "TopBar"
                }), {
                        WindowName,
                        WindowTopBarLine,
                        AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 7), {
                                Size = UDim2.new(0, 70, 0, 30),
                                BackgroundTransparency = typeof(WindowConfig.LinkVideo) == "string" and 0.2 or 0,
                                Position = UDim2.new(1, -90, 0, 10)
                        }), {
                                AddThemeObject(MakeElement("Stroke"), "Stroke"),
                                AddThemeObject(SetProps(MakeElement("Frame"), {
                                        Size = UDim2.new(0, 1, 1, 0),
                                        BackgroundTransparency = typeof(WindowConfig.LinkVideo) == "string" and 0.2 or 0,
                                        Position = UDim2.new(0.5, 0, 0, 0)
                                }), "Stroke"), 
                                CloseBtn,
                                MinimizeBtn
                        }), "Second"), 
                }),
                DragPoint,
                WindowStuff
        }), "Main")
        
        if WindowConfig.SearchBar and WindowConfig.SearchBar.Mains == true then
                local SearchBox = Create("TextBox", {
                        Size = UDim2.new(1, 0, 1, 0),
                        BackgroundTransparency = 1,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        PlaceholderColor3 = Color3.fromRGB(210,210,210),
                        PlaceholderText = WindowConfig.SearchBar.DefaultMain or "🔍 Search",
                        Font = Enum.Font.GothamBold,
                        TextWrapped = true,
                        Text = "",
                        TextXAlignment = Enum.TextXAlignment.Center,
                        TextSize = 14,
                        ClearTextOnFocus = WindowConfig.SearchBar.ClearTextOnFocus or true
                })

                local TextboxActual = AddThemeObject(SearchBox, "Text")

                local SearchBar = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 1, 6), {
                        Parent = MainWindow,
                        BackgroundTransparency = typeof(WindowConfig.LinkVideo) == "string" and 0.5 or 0,
                        Size = UDim2.new(0, 447, 0, 24),
                        Position = UDim2.new(0, 606, 0, 72),
                        AnchorPoint = Vector2.new(1, 0.5)
                }), {
                        AddThemeObject(MakeElement("Stroke"), "Stroke"),
                        TextboxActual
                }), "Main")

                local function SearchHandleMain()
                        local Text = string.lower(SearchBox.Text)
                        
						for i, v in pairs(MainWindow:GetChildren()) do
							if v.Name == "ItemContainer" and v.Visible == true then
								for _, j in pairs(v:GetChildren()) do
									if j:IsA("Frame") then
										local ContentFind = j:FindFirstChild("Content", true) or nil
										if ContentFind then
											if string.find(string.lower(ContentFind.Text), Text) then
												j.Visible = true
											else
												j.Visible = false
											end
										end
									end
								end
							end
						end
                end

                AddConnection(TextboxActual:GetPropertyChangedSignal("Text"), SearchHandleMain)
        end

        if WindowConfig.ShowIcon then
		        local IconTogglesUi = "rbxassetid://"..WindowConfig.Icon:match("%d+")
                WindowName.Position = UDim2.new(0, 50, 0, -24)
                local WindowIcon = SetProps(MakeElement("Image", WindowConfig.Icon), {
                        Size = UDim2.new(0, 20, 0, 20),
                        Position = UDim2.new(0, 25, 0, 15)
                })
                WindowIcon.Parent = MainWindow.TopBar
        end

        MakeDraggable(DragPoint, MainWindow)
        local isMobile = table.find({Enum.Platform.IOS, Enum.Platform.Android}, UserInputService:GetPlatform())
        local MobileReopenButton = SetChildren(SetProps(MakeElement("Button"), {
                Parent = Orion,
                Size = UDim2.new(0, 40, 0, 40),
                Position = UDim2.new(0.5, -20, 0, 20),
                BackgroundTransparency = 0,
                BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Main,
                Visible = false
        }), {
                AddThemeObject(SetProps(MakeElement("Image", WindowConfig.IntroToggleIcon or "http://www.roblox.com/asset/?id=8834748103"), {
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        Size = UDim2.new(0.7, 0, 0.7, 0),
                }), "Text"),
                MakeElement("Corner", 1)
        })

        MakeDraggable(MobileReopenButton, MobileReopenButton)

        AddConnection(MobileReopenButton.MouseButton1Click, function()
                MainWindow.Visible = true
                TweenService:Create(MainWindow, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Size = UDim2.new(0, 615, 0, 344),
				}):Play()
				WindowStuff.Visible = true
				WindowTopBarLine.Visible = true
				MinimizeBtn.Ico.Image = "rbxassetid://7072719338"
                MobileReopenButton.Visible = false
                Minimized = false
        end)

        AddConnection(CloseBtn.MouseButton1Up, function()
		        MainWindow.ClipsDescendants = true
				local WindowLoading = TweenService:Create(MainWindow, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Size = UDim2.new(0, 0, 0, 0)
				})
				WindowLoading:Play()
				WindowLoading.Completed:Wait()
                MainWindow.Visible = false
                UIHidden = true

                if UserInputService.TouchEnabled then
                        MobileReopenButton.Visible = true
                end
                OrionLib:MakeNotification({
                        Name = "Hide Gui",
                        Content = (isMobile and "interact icon to reopen" or "Press Key ".._currentKey.Name).." To Repoen gui",
                        Time = 5
                })
                WindowConfig.CloseCallback()
        end)

        AddConnection(UserInputService.InputBegan, function(Input)
                if Input.KeyCode == _currentKey then
                        MobileReopenButton.Visible = false
                        if MinimizedKey then
	                        TweenService:Create(MainWindow, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 615, 0, 344)}):Play()
	                        MinimizeBtn.Ico.Image = "rbxassetid://7072719338"
	                        wait(.02)
	                        MainWindow.ClipsDescendants = false
	                        WindowStuff.Visible = true
	                        WindowTopBarLine.Visible = true
		                else
	                        MainWindow.ClipsDescendants = true
	                        WindowTopBarLine.Visible = false
	                        MinimizeBtn.Ico.Image = "rbxassetid://7072720870"
	                        TweenService:Create(MainWindow, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, WindowName.TextBounds.X + 140, 0, 50)}):Play()
	                        wait(0.1)
	                        WindowStuff.Visible = false        
		                end
		                MinimizedKey = not MinimizedKey
                end
        end)

        AddConnection(MinimizeBtn.MouseButton1Up, function()
                if Minimized then
                        TweenService:Create(MainWindow, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 615, 0, 344)}):Play()
                        MinimizeBtn.Ico.Image = "rbxassetid://7072719338"
                        wait(.02)
                        MainWindow.ClipsDescendants = false
                        WindowStuff.Visible = true
                        WindowTopBarLine.Visible = true
                else
                        MainWindow.ClipsDescendants = true
                        WindowTopBarLine.Visible = false
                        MinimizeBtn.Ico.Image = "rbxassetid://7072720870"

                        TweenService:Create(MainWindow, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, WindowName.TextBounds.X + 140, 0, 50)}):Play()
                        wait(0.1)
                        WindowStuff.Visible = false        
                end
                Minimized = not Minimized    
        end)

        local function LoadSequence()
	        MainWindow.Size = UDim2.new(0, 0, 0, 0)
			MainWindow.Visible = false
			local Blur = Create("BlurEffect", {
				Name = "IntroBlur",
				Size = 0,
				Parent = game:GetService("Lighting")
			})
		
			local BaseFrame = SetProps(MakeElement("Frame"), {
				Parent = Orion,
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				ZIndex = 999
			})
			
			local LoadSequenceLogo = SetChildren(SetProps(MakeElement("Image", "rbxassetid://"..WindowConfig.IntroIcon:match("%d+")), {
				Parent = BaseFrame,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0.4, 0),
				Size = UDim2.new(0, 0, 0, 0),
				ImageColor3 = Color3.fromRGB(255, 255, 255),
				ImageTransparency = 1,
				Rotation = -180,
				ZIndex = 101
			}), {MakeElement("Corner", 0, 5)})
			
			local LoadSequenceGlow = SetProps(MakeElement("Image", "rbxassetid://7072706859"), {
				Parent = BaseFrame,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0.45, 0),
				Size = UDim2.new(0, 0, 0, 0),
				ImageColor3 = Color3.fromRGB(255, 255, 255),
				ImageTransparency = 1,
				ZIndex = 100
			})
		
			local LoadSequenceText = SetProps(MakeElement("Label", WindowConfig.IntroText, 22), {
				Parent = BaseFrame,
				Size = UDim2.new(0, 400, 0, 40),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0.55, 0),
				TextXAlignment = Enum.TextXAlignment.Center,
				Font = Enum.Font.GothamBlack,
				TextTransparency = 1,
				ZIndex = 101
			})
			
			TweenService:Create(Blur, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = 18}):Play()
			task.wait(0.2)
			TweenService:Create(LoadSequenceLogo, TweenInfo.new(1, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, 0, false, 0.2), {
				Size = UDim2.new(0, 56, 0, 56), 
				ImageTransparency = 0,
				Rotation = 0
			}):Play()
			TweenService:Create(LoadSequenceGlow, TweenInfo.new(1, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, 0, false, 0.2), {
				Size = UDim2.new(0, 140, 0, 140), 
				ImageTransparency = 0.6
			}):Play()
			task.wait(0.3)
			TweenService:Create(LoadSequenceText, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
				TextTransparency = 0,
				Position = UDim2.new(0.5, 0, 0.52, 0)
			}):Play()
			task.wait(2)
			TweenService:Create(LoadSequenceText, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				TextTransparency = 1,
				Position = UDim2.new(0.5, 0, 0.55, 0)
			}):Play()
			task.wait(0.1)
			TweenService:Create(LoadSequenceLogo, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
				Size = UDim2.new(0, 0, 0, 0), 
				Rotation = 56
			}):Play()
			TweenService:Create(LoadSequenceGlow, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
				Size = UDim2.new(0, 0, 0, 0)
			}):Play()
			local BlurTween = TweenService:Create(Blur, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = 0})
			BlurTween:Play()
			BlurTween.Completed:Wait()
			wait(0.15)
			MainWindow.Visible = true
			Blur:Destroy()
			BaseFrame:Destroy()
			TweenService:Create(MainWindow, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Size = UDim2.new(0, 615, 0, 344),
			}):Play()
		end 
		
		if WindowConfig.IntroEnabled then
			LoadSequence()
		end
		
		if typeof(WindowConfig.LinkVideo) == "string" then
			OrionLib:SetVideoLink(WindowConfig.LinkVideo)
		end

        local Functions = {}
		local TabName = {}
		function Functions:MakeTab(TabConfig)
			TabConfig = TabConfig or {}
			TabConfig.Name = TabConfig.Name or "Tab"
			TabConfig.Icon = TabConfig.Icon or ""
			TabConfig.Visible = TabConfig.Visible ~= false
			TabConfig.Disabled = TabConfig.Disabled == true
		
			local Tabs = {
				Disabled = TabConfig.Disabled,
				Visible = TabConfig.Visible,
				Type = "Tabs"
			}
		
			local TabFrame = SetChildren(SetProps(MakeElement("Button"), {
				Size = UDim2.new(1, 0, 0, 30),
				Parent = TabHolder,
				Visible = TabConfig.Visible,
				AutoButtonColor = not TabConfig.Disabled
			}), {
				AddThemeObject(SetProps(MakeElement("Image", TabConfig.Icon), {
					AnchorPoint = Vector2.new(0, 0.5),
					Size = UDim2.new(0, 18, 0, 18),
					Position = UDim2.new(0, 10, 0.5, 0),
					ImageTransparency = TabConfig.Disabled and 0.7 or 0.4,
					Name = "Ico"
				}), "Text"),
		
				AddThemeObject(SetChildren(SetProps(MakeElement("Label", TabConfig.Name, 14), {
					Size = UDim2.new(1, -35, 1, 0),
					Position = UDim2.new(0, 35, 0, 0),
					Font = Enum.Font.GothamSemibold,
					TextTransparency = TabConfig.Disabled and 0.7 or 0.4,
					Name = "Title"
				}), {AddThemeObject(MakeElement("Stroke"), "Stroke")}), "Text")
			})
		
			AddItemTable(Tabs, TabConfig.Name, TabFrame)
			
			local Container = AddThemeObject(SetChildren(SetProps(MakeElement("ScrollFrame", Color3.fromRGB(255, 255, 255), 5), {
				Size = UDim2.new(1, -150, 1, (WindowConfig.SearchBar and WindowConfig.SearchBar.Mains == true) and -90 or -50),
				Position = UDim2.new(0, 150, 0, (WindowConfig.SearchBar and WindowConfig.SearchBar.Mains == true) and 90 or 50),
				Parent = MainWindow,
				Visible = false,
				Name = "ItemContainer"
			}), {
				MakeElement("List", 0, 6),
				MakeElement("Padding", 15, 10, 10, (WindowConfig.SearchBar and WindowConfig.SearchBar.Mains == true) and 10 or 15)
			}), "Divider")
			
			AddConnection(Container.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
				Container.CanvasSize = UDim2.new(0, 0, 0, Container.UIListLayout.AbsoluteContentSize.Y + ((WindowConfig.SearchBar and WindowConfig.SearchBar.Mains == true) and 25 or 30))
			end)
		
			AddConnection(TabFrame.MouseButton1Click, function()
				if Tabs.Disabled then return end
				for _, Tab in next, TabHolder:GetChildren() do
					if Tab:IsA("TextButton") then
						Tab.Ico.ImageTransparency = 0.4
						Tab.Title.TextTransparency = 0.4
					end
				end
				for _, c in next, MainWindow:GetChildren() do
					if c.Name == "ItemContainer" then c.Visible = false end
				end
				TabFrame.Ico.ImageTransparency = 0
				TabFrame.Title.TextTransparency = 0
				Container.Visible = true
			end)
			
			function Tabs:SetDisabled(state)
				Tabs.Disabled = state
				TabFrame.AutoButtonColor = not state
				TabFrame.Ico.ImageTransparency = state and 0.7 or 0.4
				TabFrame.Title.TextTransparency = state and 0.7 or 0.4
				if state then
					Container.Visible = false
				end
			end

			function Tabs:SetVisible(state)
				Tabs.Visible = state
				TabFrame.Visible = state
				if not state then Container.Visible = false end
			end
			
                local function GetElements(ItemParent)
                        local ElementFunction = {}
                        function ElementFunction:AddDivider()
					        local DividerHolder = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
					            BackgroundTransparency = 1,
					            Size = UDim2.new(1, 0, 0, 14),
					            Parent = ItemParent
					        }), {
						        MakeElement("Padding"),
								Create("Frame", {
						            BackgroundColor3 = Color3.fromRGB(25, 25, 25),
						            Size = UDim2.fromScale(1, 1)
						        }),
						        Create("UICorner", {CornerRadius = UDim.new(1, 0)}),
						        AddThemeObject(MakeElement("Stroke"), "Stroke")
							}), "Second")
							
							local DividerFunction = {}
                            function DividerFunction:Remove()
	                            if DividerHolder then
		                            DividerHolder:Destroy()
	                            end
                            end
                            return DividerFunction 
					    end
                        function ElementFunction:AddLog(Text)
                                local Label = MakeElement("Label", Text, 15)
                                local LogFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
                                        Size = UDim2.new(1, 0, 1, 0),
                                        BackgroundTransparency = 0.7,
                                        Parent = ItemParent
                                }), {
                                        AddThemeObject(SetProps(Label, {
                                                Size = UDim2.new(1, -12, 1, 0),
                                                Position = UDim2.new(0, 12, 0, 0),
                                                TextXAlignment = Enum.TextXAlignment.Center,
                                                TextSize = 19,
                                                TextWrapped = true,
                                                Font = Enum.Font.GothamBold,
                                                Name = "Content"
                                        }), "Text"),
                                        AddThemeObject(MakeElement("Stroke"), "Stroke")
                                }), "Second")

                                local LogFunction = {}
                                function LogFunction:Set(ToChange)
                                        LogFrame.Content.Text = ToChange
                                end
                                return LogFunction
                        end
                        function ElementFunction:AddLabel(Text, Log)
						    Log = Log or {}
						    local DefaultBackground = OrionLib.Themes[OrionLib.SelectedTheme].Second
						    local LabelFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255,255,255), 0, 5), {
						            Size = UDim2.new(1, 0, 0, 30),
						            Parent = ItemParent,
						            BackgroundColor3 = DefaultBackground
						        }), {
						        Create("ImageLabel", {
						            Name = "Icon",
						            Size = UDim2.new(0, 18, 0, 18),
						            Position = UDim2.new(0, 8, 0.5, -9),
						            BackgroundTransparency = 1,
						            Image = "",
						            Visible = false
						        }),
						        AddThemeObject(SetProps(MakeElement("Label", Text, 15), {
						            Size = UDim2.new(1, -12, 1, 0),
						            Position = UDim2.new(0, 8, 0, 0),
						            Font = Enum.Font.GothamBold,
						            TextWrapped = true,
						            Name = "Content",
						            TextXAlignment = Enum.TextXAlignment.Left
						        }), "Text"),
						        AddThemeObject(MakeElement("Stroke"), "Stroke")
						    }), "Second")
						
						    AddConnection(LabelFrame.Content:GetPropertyChangedSignal("Text"), function()
						        if LabelFrame then
						            LabelFrame.Size = UDim2.new(1, 0, 0, LabelFrame.Content.TextBounds.Y + 25)
						        end
						    end)
						
						    local Icons = {
						        success = "rbxassetid://3926305904",
						        error = "rbxassetid://3926307971",
						        warning = "rbxassetid://3926305904",
						        fail = "rbxassetid://7743878857"
						    }
						    
						    local StateColors = {
						        success = Color3.fromRGB(0, 120, 60),
						        error = Color3.fromRGB(150, 40, 40),
						        warning = Color3.fromRGB(150, 110, 0),
						        fail = Color3.fromRGB(120, 0, 0)
						    }
						    
						    local function ResetState()
						        Log.Error = nil
						        Log.Warning = nil
						        Log.Success = nil
						        Log.Fail = nil
								
								if LabelFrame and LabelFrame:FindFirstChild("UIStroke") then
									LabelFrame:FindFirstChild("UIStroke"):Destroy()
								end
						        LabelFrame.Icon.Visible = false
						        LabelFrame.Icon.Image = ""
								LabelFrame.BackgroundTransparency = 0
								LabelFrame.Content.Size = UDim2.new(1, -12, 1, 0)
								LabelFrame.Content.Position = UDim2.new(0, 8, 0, 0)
						        LabelFrame.BackgroundColor3 = DefaultBackground
						    end
						    
						    local LabelFunction = {}
						    function LabelFunction:Set(ToChange, State)
						        if getgenv().Destroy then return end
						        if not LabelFrame then return end
						        ResetState()
						        LabelFrame.Content.Text = ToChange
						        if State then
						            State = string.lower(State)
						            if Icons[State] then
										LabelFrame.Content.Size = UDim2.new(1,-36,1,0)
										LabelFrame.Content.Position = UDim2.new(0,30,0,0)
						                LabelFrame.Icon.Visible = true
										LabelFrame.BackgroundTransparency = 0.6
						                LabelFrame.Icon.Image = Icons[State]
										local Stroke = Create("UIStroke", {
							                Color = StateColors[State],
							                Thickness = 1.6,
											Parent = LabelFrame
								        })
						            end
						            if StateColors[State] then
						                LabelFrame.BackgroundColor3 = StateColors[State]
						            end
						            Log[State:sub(1,1):upper()..State:sub(2)] = true
						        end
						    end
						    return LabelFunction
						end
                        function ElementFunction:AddParagraph(Text, Content)
                                Text = Text or "Text"
                                Content = Content or "Content"

                                local ParagraphFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
                                        Size = UDim2.new(1, 0, 0, 30),
                                        BackgroundTransparency = 0.7,
                                        Parent = ItemParent
                                }), {
                                        AddThemeObject(SetProps(MakeElement("Label", Text, 15), {
                                                Size = UDim2.new(1, -12, 0, 14),
                                                Position = UDim2.new(0, 12, 0, 10),
                                                Font = Enum.Font.GothamBold,
                                                Name = "Title"
                                        }), "Text"),
                                        AddThemeObject(SetProps(MakeElement("Label", "", 13), {
                                                Size = UDim2.new(1, -24, 0, 0),
                                                Position = UDim2.new(0, 12, 0, 26),
                                                Font = Enum.Font.GothamSemibold,
                                                Name = "Content",
                                                TextWrapped = true
                                        }), "TextDark"),
                                        AddThemeObject(MakeElement("Stroke"), "Stroke")
                                }), "Second")

                                AddConnection(ParagraphFrame.Content:GetPropertyChangedSignal("Text"), function()
                                        ParagraphFrame.Content.Size = UDim2.new(1, -24, 0, ParagraphFrame.Content.TextBounds.Y)
                                        ParagraphFrame.Size = UDim2.new(1, 0, 0, ParagraphFrame.Content.TextBounds.Y + 35)
                                end)

                                ParagraphFrame.Content.Text = Content

                                local ParagraphFunction = {}
                                function ParagraphFunction:Set(ToChange)
	                                if getgenv().Destroy then return end
	                                if ParagraphFrame and ParagraphFrame:FindFirstChild("Content") then
                                        ParagraphFrame.Content.Text = ToChange
                                    end
                                end
                                return ParagraphFunction
                        end    
                        function ElementFunction:AddButton(ButtonConfig)
                                ButtonConfig = ButtonConfig or {}
                                ButtonConfig.Visible = ButtonConfig.Visible or true
                                ButtonConfig.Disabled = ButtonConfig.Disabled or false
                                ButtonConfig.Name = ButtonConfig.Name or "Button"
                                ButtonConfig.Callback = ButtonConfig.Callback or function() end
                                ButtonConfig.Icon = ButtonConfig.Icon or "rbxassetid://3944703587"
                                local Button = {Disabled = ButtonConfig.Disabled, Visible = ButtonConfig.Visible}

                                local Click = SetProps(MakeElement("Button"), {
                                        Size = UDim2.new(1, 0, 1, 0)
                                })
                                
                                local ButtonFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
                                        Size = UDim2.new(1, 0, 0, 33),
                                        Visible = ButtonConfig.Visible,
                                        Parent = ItemParent
                                }), {
                                        AddThemeObject(SetProps(MakeElement("Label", ButtonConfig.Name, 15), {
                                                Size = UDim2.new(1, -12, 1, 0),
                                                Position = UDim2.new(0, 12, 0, 0),
                                                Font = Enum.Font.GothamBold,
                                                Name = "Content"
                                        }), "Text"),
                                        AddThemeObject(SetProps(MakeElement("Image", ButtonConfig.Icon), {
                                                Size = UDim2.new(0, 20, 0, 20),
                                                Position = UDim2.new(1, -30, 0, 7),
                                        }), "TextDark"),
                                        AddThemeObject(MakeElement("Stroke"), "Stroke"),
                                        Click
                                }), "Second")

                                AddConnection(Click.MouseEnter, function()
		                                if ButtonConfig.Disabled then return end
                                        TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
                                end)

                                AddConnection(Click.MouseLeave, function()
		                                if ButtonConfig.Disabled then return end
                                        TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Second}):Play()
                                end)

                                AddConnection(Click.MouseButton1Up, function()
		                                if ButtonConfig.Disabled then return end
                                        TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
                                        spawn(function()
                                                Button:Click()
                                        end)
                                end)

                                AddConnection(Click.MouseButton1Down, function()
		                                if ButtonConfig.Disabled then return end
                                        TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 6)}):Play()
                                end)

                                function Button:Set(ButtonText)
	                                if getgenv().Destroy or ButtonConfig.Disabled then return end
	                                if ButtonFrame and ButtonFrame:FindFirstChild("Content") then
                                        ButtonFrame.Content.Text = ButtonText
                                    end
                                end
                                
                                function Button:SetDisabled(state)
									if getgenv().Destroy then return end
									Button.Disabled = state
									ButtonConfig.Disabled = state
									if ButtonFrame then
										TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {BackgroundTransparency = state and 0.5 or 0}):Play()
									end
									if Click then
										Click.Active = not state
										Click.AutoButtonColor = not state
									end
									if ButtonFrame and ButtonFrame:FindFirstChild("Content") then
										ButtonFrame.Content.TextTransparency = state and 0.5 or 0
									end
								end
                                
                                function Button:SetVisible(state)
									if getgenv().Destroy then return end
									if ButtonFrame then
										ButtonFrame.Visible = state
										Button.Visible = state
									end
								end
                                
                                function Button:Click()
								    if ButtonConfig.Callback and not ButtonConfig.Disabled then
								        local success, err = pcall(ButtonConfig.Callback)
								        if not success then
								            OrionLib:MakeNotification({Name = "Error Script", Content = err, Time = 5})
								        end
								    end
								end
                                
                                function Button:SetCallback(callback)
	                                if getgenv().Destroy or ButtonConfig.Disabled then return end
								    ButtonConfig.Callback = callback
								end
                                return Button
                        end    
                        function ElementFunction:AddImage(ImageConfig)
							ImageConfig = ImageConfig or {}
							ImageConfig.Name = ImageConfig.Name or "Image"
							ImageConfig.Icon = ImageConfig.Icon or "rbxassetid://0"
							ImageConfig.Size = ImageConfig.Size or 20
							ImageConfig.Flag = ImageConfig.Flag or false
							ImageConfig.Visible = ImageConfig.Visible or true
							ImageConfig.Padding = ImageConfig.Padding or 8
						
							local Image = {Default = ImageConfig.Icon, Size = ImageConfig.Size, Type = "Image"}
						
							local function FrameHeight(iconSize)
								return iconSize + ImageConfig.Padding * 2
							end
						
							local ImageFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
									Name = ImageConfig.Name,
									Size = UDim2.new(1, 0, 0, FrameHeight(ImageConfig.Size)),
									Visible = ImageConfig.Visible,
									Parent = ItemParent
								}), {
								AddThemeObject(SetProps(MakeElement("Image", ImageConfig.Icon), {
										Name = "Icon",
										AnchorPoint = Vector2.new(0.5, 0.5),
										Size = UDim2.new(0, ImageConfig.Size, 0, ImageConfig.Size),
										Position = UDim2.new(0.5, 0, 0.5, 0),
										BackgroundTransparency = 1
									}), "TextDark"),
								AddThemeObject(MakeElement("Stroke"), "Stroke")
							}), "Second")
							
							IconImage = ImageFrame:FindFirstChild("Icon", true)
							local function updateLayout(size)
								if getgenv().Destroy then return end
								if IconImage then
									ImageFrame.Size = UDim2.new(1, 0, 0, FrameHeight(size))
									IconImage.Size = UDim2.new(0, size, 0, size)
									IconImage.Position = UDim2.new(0.5, 0, 0.5, 0)
								end
							end
						
							function Image:SetIcon(iconId)
								if getgenv().Destroy then return end
								if IconImage then
									IconImage.Image = tostring(iconId)
								end
							end
							
							function Image:SetVisible(ToChange)
								if getgenv().Destroy then return end
								if ImageFrame then
									ImageFrame.Visible = ToChange
								end
							end
						
							function Image:SetSize(size)
								if getgenv().Destroy then return end
								updateLayout(tonumber(size))
							end
							
							if ImageConfig.Flag then
								OrionLib.Flags[ImageConfig.Flag] = Image
							end
							return Image
						end
                        function ElementFunction:AddToggle(ToggleConfig)
							ToggleConfig = ToggleConfig or {}
							ToggleConfig.Name = ToggleConfig.Name or "Toggle"
							ToggleConfig.Default = ToggleConfig.Default or false
							ToggleConfig.Callback = ToggleConfig.Callback or function() end
							ToggleConfig.Color = ToggleConfig.Color or Color3.fromRGB(9, 99, 195)
							ToggleConfig.Visible = ToggleConfig.Visible or true
							ToggleConfig.Disabled = ToggleConfig.Disabled or false
							ToggleConfig.Type = ToggleConfig.Type or "CheckBox"
							ToggleConfig.Flag = ToggleConfig.Flag or nil
							ToggleConfig.Save = ToggleConfig.Save or false
						
							local Toggle = {
								Type = "Toggle",
								Value = ToggleConfig.Default,
								Save = ToggleConfig.Save,
								Visible = ToggleConfig.Visible,
								Disabled = ToggleConfig.Disabled,
								["__DisplayName"] = {}
							}
						
							local Click = SetProps(MakeElement("Button"), {
								Size = UDim2.new(1, 0, 1, 0)
							})
							local ToggleBox
							if ToggleConfig.Type == "Switch" then
								ToggleBox = SetChildren(SetProps(MakeElement("RoundFrame", OrionLib.Themes.Default.Divider, 0, 12), {
									Size = UDim2.new(0, 40, 0, 20),
									Position = UDim2.new(1, -8, 0.5, 0),
									AnchorPoint = Vector2.new(1, 0.5),
									BackgroundColor3 = OrionLib.Themes.Default.Divider,
									Name = "Switch"
								}), {
									AddThemeObject(MakeElement("Stroke"), "Stroke"),
									SetProps(MakeElement("RoundFrame", Color3.fromRGB(255,255,255), 0, 10), {
										Size = UDim2.new(0, 18, 0, 18),
										Position = UDim2.new(0, 1, 0.48, 0),
										AnchorPoint = Vector2.new(0, 0.5),
										Name = "Knob"
									})
								})
							else
								ToggleBox = SetChildren(SetProps(MakeElement("RoundFrame", ToggleConfig.Color, 0, 4), {
									Size = UDim2.new(0, 24, 0, 24),
									Position = UDim2.new(1, -24, 0.5, 0),
									AnchorPoint = Vector2.new(0.5, 0.5),
									BackgroundColor3 = OrionLib.Themes.Default.Divider,
									Name = "Check"
								}), {
									SetProps(MakeElement("Stroke"), {
										Color = OrionLib.Themes.Default.Stroke,
										Name = "Stroke",
										Transparency = 0.5
									}),
									SetProps(MakeElement("Image", "rbxassetid://3944680095"), {
										Size = UDim2.new(0, 8, 0, 8),
										AnchorPoint = Vector2.new(0.5, 0.5),
										Position = UDim2.new(0.5, 0, 0.5, 0),
										ImageColor3 = Color3.fromRGB(255, 255, 255),
										ImageTransparency = 1,
										Name = "Ico"
									})
								})
							end
							local ToggleFrame = AddThemeObject(SetChildren(SetProps(
								MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
									Size = UDim2.new(1, 0, 0, 38),
									Parent = ItemParent
								}), {
									AddThemeObject(SetProps(MakeElement("Label", ToggleConfig.Name, 15), {
										Size = UDim2.new(1, -12, 1, 0),
										Position = UDim2.new(0, 12, 0, 0),
										Font = Enum.Font.GothamBold,
										Name = "Content",
									}), "Text"),
									AddThemeObject(MakeElement("Stroke"), "Stroke"),
									ToggleBox,
									Click
							}), "Second")
							
							function UpdateTweenKeyBindToggles(Object, bool)
								if Object:FindFirstChild("Switch") and Object.Switch:FindFirstChild("Knob") then
									TweenService:Create(Object.Switch, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
										BackgroundColor3 = bool and ToggleConfig.Color or OrionLib.Themes.Default.Divider
									}):Play()
									TweenService:Create(Object.Switch.Knob, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
										Position = bool and UDim2.new(1, -19, 0.48, 0) or UDim2.new(0, 1, 0.48, 0)
									}):Play()
								end
								if Object:FindFirstChild("Check") then
									TweenService:Create(Object.Check, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
										BackgroundColor3 = bool and ToggleConfig.Color or OrionLib.Themes.Default.Divider
									}):Play()
									TweenService:Create(Object.Check.Stroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
										Color = bool and ToggleConfig.Color or OrionLib.Themes.Default.Stroke
									}):Play()
									TweenService:Create(Object.Check.Ico, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
										ImageTransparency = bool and 0 or 1,
										Size = bool and UDim2.new(0, 20, 0, 20) or UDim2.new(0, 8, 0, 8)
									}):Play()
								end
							end
							
							local function GetUniqueToggleName(baseName: string)
								getgenv().ToggleNameCount = getgenv().ToggleNameCount or {}
								if not getgenv().ToggleNameCount[baseName] then
									getgenv().ToggleNameCount[baseName] = 1
									return baseName
								else
									getgenv().ToggleNameCount[baseName] += 1
									return string.format("%s (%d)", baseName, getgenv().ToggleNameCount[baseName])
								end
							end
						
							function AddTogglesKeyBind(name: string)
								local KeyBindAdd = ToggleFrame:Clone()
								KeyBindAdd.Parent = Orion.KeyBind.ItemContainer
								local displayName = GetUniqueToggleName(name)
								getgenv().TogglesSaveTable[displayName] = KeyBindAdd
								Toggle.__DisplayName = displayName
								if KeyBindAdd then
									if KeyBindAdd:FindFirstChild("ButtonKey") then
										KeyBindAdd:FindFirstChild("ButtonKey"):Destroy()
									end
									if KeyBindAdd:FindFirstChild("TextButton") then
										AddConnection(KeyBindAdd:FindFirstChild("TextButton").MouseButton1Up, function()
											Toggle:Set(not Toggle.Value)
											UpdateTweenKeyBindToggles(KeyBindAdd, Toggle.Value)
										end)
									end
									if KeyBindAdd:FindFirstChild("Frame") and KeyBindAdd.Frame:FindFirstChild("Value") then
										AddConnection(KeyBindAdd.Frame.Value:GetPropertyChangedSignal("Text"), function()
											local width = KeyBindAdd.Frame.Value.TextBounds.X + 20
											TweenService:Create(KeyBindAdd.Frame, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {Size = UDim2.new(0, width, 0, 24)}):Play()
										end)
									end
								end
							end
							
							function Toggle:Set(Value)
								if getgenv().Destroy or ToggleConfig.Disabled then return end
								Toggle.Value = Value
								UpdateTweenKeyBindToggles(ToggleFrame, Toggle.Value)
								local ok, err = pcall(function()
									ToggleConfig.Callback(Toggle.Value)
								end)
								if not ok then
									OrionLib:MakeNotification({Name = "Error Script", Content = err, Time = 5})
								end
							end
							
							function Toggle:SetDisabled(state)
								if getgenv().Destroy then return end
								ToggleConfig.Disabled = state
								Toggle.Disabled = state
								if ToggleFrame then
									ToggleFrame.BackgroundTransparency = state and 0.6 or 0
									if ToggleFrame:FindFirstChild("Content") then
										ToggleFrame.Content.TextTransparency = state and 0.5 or 0
									end
								end
								if Click then
									Click.Active = not state
									Click.AutoButtonColor = not state
								end
								if ToggleBox then
									if ToggleConfig.Type == "Switch" and ToggleBox:FindFirstChild("Knob") then
										TweenService:Create(ToggleBox, TweenInfo.new(0.2), {
											BackgroundColor3 = state and Color3.fromRGB(120,120,120)
												or (Toggle.Value and ToggleConfig.Color or OrionLib.Themes.Default.Divider)
										}):Play()
									elseif ToggleBox:FindFirstChild("Stroke") then
										TweenService:Create(ToggleBox.Stroke, TweenInfo.new(0.2), {
											Color = state and Color3.fromRGB(120,120,120) or (Toggle.Value and ToggleConfig.Color or OrionLib.Themes.Default.Stroke)
										}):Play()
									end
								end
								if Toggle.__DisplayName and getgenv().TogglesSaveTable[Toggle.__DisplayName] then
									local data = getgenv().TogglesSaveTable[Toggle.__DisplayName]
									if data then
										if data:FindFirstChild("TextButton", true) then
											data:FindFirstChild("TextButton", true).Active = not state
											data:FindFirstChild("TextButton", true).AutoButtonColor = not state
										end
										data.BackgroundTransparency = state and 0.6 or 0
										if data:FindFirstChild("Content", true) then
											data:FindFirstChild("Content", true).TextTransparency = state and 0.5 or 0
										end
									end
								end
							end
							
							function Toggle:SetVisible(state)
								if getgenv().Destroy then return end
								Toggle.Visible = state
								if ToggleFrame then
									ToggleFrame.Visible = state
								end
								if Toggle.__DisplayName and getgenv().TogglesSaveTable[Toggle.__DisplayName] then
									local data = getgenv().TogglesSaveTable[Toggle.__DisplayName]
									if data then
										data.Visible = state
									end
								end
							end
							
							function Toggle:SetCallback(ToChange)
								if getgenv().Destroy or ToggleConfig.Disabled then return end
								ToggleConfig.Callback = ToChange
							end
							
							function Toggle:SetText(ToChange)
								if getgenv().Destroy or ToggleConfig.Disabled then return end
								if ToggleFrame and ToggleFrame:FindFirstChild("Content") then
									ToggleFrame.Content.Text = ToChange
								end
								if Toggle.__DisplayName then
									if getgenv().TogglesSaveTable[Toggle.__DisplayName] then
										local FrameToHere = getgenv().TogglesSaveTable[Toggle.__DisplayName]
										if FrameToHere and FrameToHere:FindFirstChild("Content", true) then
											FrameToHere:FindFirstChild("Content", true).Text = ToChange
										end
									end
								end
							end
							
							if ToggleConfig.Default == true then
								Toggle:Set(true)
							end
							
							AddConnection(Click.MouseButton1Up, function()
								if ToggleConfig.Disabled then return end
								Toggle:Set(not Toggle.Value)
								if Toggle.__DisplayName then
									local data = getgenv().TogglesSaveTable[Toggle.__DisplayName]
									if data then
										UpdateTweenKeyBindToggles(data, Toggle.Value)
									end
								end
							end)
						
							function Toggle:AddBind(BindConfig)
								BindConfig = BindConfig or {}
								BindConfig.Default = BindConfig.Default or Enum.KeyCode.Unknown
								BindConfig.Hold = BindConfig.Hold or false
								BindConfig.Flag = BindConfig.Flag or nil
								BindConfig.Save = BindConfig.Save or false
						
								local Bind = {
									Value = BindConfig.Default.Name or BindConfig.Default,
									Type = "Bind",
									Save = BindConfig.Save,
									Binding = false
								}
						
								local Click = SetProps(MakeElement("Button"), {
									Size = UDim2.new(0, 30, 0, 24),
									Position = (ToggleConfig.Type == "Switch" and UDim2.new(1, -55, 0.5, 0) or UDim2.new(1, -48, 0.5, 0)),
									AnchorPoint = Vector2.new(1, 0.5),
									Parent = ToggleFrame,
									Name = "ButtonKey",
									ZIndex = 4
								})
						
								local BindBox = AddThemeObject(SetChildren(SetProps(
									MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), {
										Size = UDim2.new(0, 30, 0, 24),
										Position = Click.Position,
										AnchorPoint = Vector2.new(1, 0.5),
										Parent = ToggleFrame,
										ZIndex = 1
									}), {
										AddThemeObject(MakeElement("Stroke"), "Stroke"),
										AddThemeObject(SetProps(MakeElement("Label", Bind.Value, 14), {
											Size = UDim2.new(1, 0, 1, 0),
											Font = Enum.Font.GothamBold,
											TextXAlignment = Enum.TextXAlignment.Center,
											Name = "Value",
											ZIndex = 1
										}), "Text")
									}), "Main")
						
								AddConnection(BindBox.Value:GetPropertyChangedSignal("Text"), function()
									local width = BindBox.Value.TextBounds.X + 20
									TweenService:Create(BindBox, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {Size = UDim2.new(0, width, 0, 24)}):Play()
									TweenService:Create(Click, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {Size = UDim2.new(0, width, 0, 24)}):Play()
								end)
						
								AddConnection(Click.InputEnded, function(Input)
									if ToggleConfig.Disabled then return end
									if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
										if Bind.Binding then return end
										Bind.Binding = true
										BindBox.Value.Text = "..."
									end
								end)
						
								AddConnection(UserInputService.InputBegan, function(Input, gp)
									if ToggleConfig.Disabled then return end
									if gp then return end
									if UserInputService:GetFocusedTextBox() then return end
									if Bind.Binding then
										if Input.KeyCode ~= Enum.KeyCode.Unknown then
											Bind.Value = Input.KeyCode.Name
											BindBox.Value.Text = Bind.Value
											Bind.Binding = false
											if Toggle.__DisplayName then
												if getgenv().TogglesSaveTable[Toggle.__DisplayName] then
													local FrameToHere = getgenv().TogglesSaveTable[Toggle.__DisplayName]
													if FrameToHere and FrameToHere:FindFirstChild("Frame") and FrameToHere.Frame:FindFirstChild("Value") then
														FrameToHere.Frame:FindFirstChild("Value").Text = Input.KeyCode.Name
													end
												end
											end
										end
										return
									end
									if Input.KeyCode.Name == Bind.Value then
										Toggle:Set(not Toggle.Value)
										if Toggle.__DisplayName then
											local data = getgenv().TogglesSaveTable[Toggle.__DisplayName]
											if data then
												UpdateTweenKeyBindToggles(data, Toggle.Value)
											end
										end
									end
								end)
						
								function Bind:Set(Key)
									if ToggleConfig.Disabled then return end
									Bind.Value = Key.Name or Key
									BindBox.Value.Text = Bind.Value
									if Toggle.__DisplayName then
										if getgenv().TogglesSaveTable[Toggle.__DisplayName] then
											local FrameToHere = getgenv().TogglesSaveTable[Toggle.__DisplayName]
											if FrameToHere and FrameToHere:FindFirstChild("Frame") and FrameToHere.Frame:FindFirstChild("Value") then
												FrameToHere.Frame:FindFirstChild("Value").Text = Key
											end
										end
									end
								end
								
								AddTogglesKeyBind(ToggleConfig.Name)
						
								if BindConfig.Flag then
									OrionLib.Flags[Toggle][BindConfig.Flag] = Bind
								end
								return Bind
							end
							if ToggleConfig.Flag then
								OrionLib.Flags[ToggleConfig.Flag] = Toggle
							end
							return Toggle
						end
						function ElementFunction:AddSlider(SliderConfig)
							SliderConfig = SliderConfig or {}
							SliderConfig.Name = SliderConfig.Name or "Slider"
							SliderConfig.Visible = SliderConfig.Visible or true
							SliderConfig.Disabled = SliderConfig.Disabled or false
							SliderConfig.Min = SliderConfig.Min or 0
							SliderConfig.Max = SliderConfig.Max or 100
							SliderConfig.Increment = SliderConfig.Increment or 1
							SliderConfig.Default = SliderConfig.Default or 50
							SliderConfig.Callback = SliderConfig.Callback or function() end
							SliderConfig.ValueName = SliderConfig.ValueName or ""
							SliderConfig.Color = SliderConfig.Color or Color3.fromRGB(9, 149, 98)
							SliderConfig.Flag = SliderConfig.Flag or nil
							SliderConfig.Save = SliderConfig.Save or false
							
							local Slider = {
								Type = "Slider",
								Value = SliderConfig.Default,
								Save = SliderConfig.Save,
								Disabled = SliderConfig.Disabled,
								Visible = SliderConfig.Visible
							}
							local Dragging = false  
						  
							local SliderDrag = SetChildren(SetProps(MakeElement("RoundFrame", SliderConfig.Color, 0, 5), {  
								Size = UDim2.new(0, 0, 1, 0),  
								BackgroundTransparency = 0.3,  
								ClipsDescendants = true  
							}), {  
								AddThemeObject(SetProps(MakeElement("Label", "value", 13), {  
									Size = UDim2.new(1, -12, 0, 14),  
									Position = UDim2.new(0, 12, 0, 6),  
									Font = Enum.Font.GothamBold,  
									Name = "Value",  
									TextTransparency = 0  
								}), "Text")  
							})  
						  
							local SliderBar = SetChildren(SetProps(MakeElement("RoundFrame", SliderConfig.Color, 0, 5), {  
								Size = UDim2.new(1, -24, 0, 26),  
								Position = UDim2.new(0, 12, 0, 30),  
								BackgroundTransparency = 0.9  
							}), {  
								SetProps(MakeElement("Stroke"), {Color = SliderConfig.Color}),  
								AddThemeObject(SetProps(MakeElement("Label", "value", 13), {  
									Size = UDim2.new(1, -12, 0, 14),  
									Position = UDim2.new(0, 12, 0, 6),  
									Font = Enum.Font.GothamBold,  
									Name = "Value",  
									TextTransparency = 0.8  
								}), "Text"),  
								SliderDrag  
							})  
						  
							local SliderFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), {  
								Size = UDim2.new(1, 0, 0, 65),  
								Visible = SliderConfig.Visible,
								Parent = ItemParent  
							}), {  
								AddThemeObject(SetProps(MakeElement("Label", SliderConfig.Name, 15), {  
									Size = UDim2.new(1, -12, 0, 14),  
									Position = UDim2.new(0, 12, 0, 10),  
									Font = Enum.Font.GothamBold,  
									Name = "Content"  
								}), "Text"),  
								AddThemeObject(MakeElement("Stroke"), "Stroke"),  
								SliderBar  
							}), "Second")  
							  
							local function DraggingUi(parent)  
								parent.InputBegan:Connect(function(Input)  
									if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then  
										Dragging = true  
									end  
								end)  
							  
								parent.InputEnded:Connect(function(Input)  
									if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then  
										Dragging = false  
									end  
								end)  
							end  
							  
							DraggingUi(SliderBar)  
							AddConnection(UserInputService.InputChanged, function(Input)
								if Dragging and not Slider.Disabled then
									local SizeScale = math.clamp((Input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
									Slider:Set(SliderConfig.Min + ((SliderConfig.Max - SliderConfig.Min) * SizeScale))
								end
							end)
						  
							local function Update()  
								if getgenv().Destroy then return end
								TweenService:Create(SliderDrag, TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromScale((Slider.Value - SliderConfig.Min) / (SliderConfig.Max - SliderConfig.Min), 1)}):Play()  
								SliderBar.Value.Text = tostring(Slider.Value) .. " " .. SliderConfig.ValueName  
								SliderDrag.Value.Text = tostring(Slider.Value) .. " " .. SliderConfig.ValueName  
								SliderConfig.Callback(Slider.Value)  
							end  
						  
							function Slider:Set(Value)  
								if getgenv().Destroy then return end
								Slider.Value = math.clamp(Round(Value, SliderConfig.Increment), SliderConfig.Min, SliderConfig.Max)  
								Update()  
							end  
							
							function Slider:SetDisabled(state)
								if getgenv().Destroy then return end
								Slider.Disabled = state
								SliderConfig.Disabled = state
								if SliderFrame then
									TweenService:Create(SliderFrame, TweenInfo.new(0.2), {BackgroundTransparency = state and 0.5 or 0}):Play()
								end
								if SliderBar then
									TweenService:Create(SliderBar, TweenInfo.new(0.2), {BackgroundTransparency = state and 0.95 or 0.9}):Play()
								end
								if SliderFrame:FindFirstChild("Content") then
									SliderFrame.Content.TextTransparency = state and 0.5 or 0
								end
							end
							
							function Slider:SetVisible(state)
								if getgenv().Destroy then return end
								Slider.Visible = state
								if SliderFrame then
									SliderFrame.Visible = state
								end
							end
							  
							function Slider:SetMax(Value: number)  
								if getgenv().Destroy then return end
								local MaxToFix = tonumber(Value) or 5
								SliderConfig.Max = (MaxToFix > 0 and MaxToFix or 5)  
								Slider.Value = math.clamp(Round(Slider.Value, SliderConfig.Increment), SliderConfig.Min, SliderConfig.Max)  
								Update()  
							end  
						  
							function Slider:SetMin(Value: number)  
								if getgenv().Destroy then return end
								SliderConfig.Min = tonumber(Value) or 5
								Slider.Value = math.clamp(Round(Slider.Value, SliderConfig.Increment), SliderConfig.Min, SliderConfig.Max)  
								Update()  
							end  
						  
							function Slider:SetText(ToChange)  
								if getgenv().Destroy then return end
								if SliderFrame and SliderFrame:FindFirstChild("Content") then  
									SliderFrame.Content.Text = ToChange  
								end  
							end  
							  
							function Slider:SetTextValue(ToChange)  
								if getgenv().Destroy then return end
								SliderConfig.ValueName = ToChange  
								SliderBar.Value.Text = tostring(Slider.Value) .. " " .. SliderConfig.ValueName  
								SliderDrag.Value.Text = tostring(Slider.Value) .. " " .. SliderConfig.ValueName  
							end  
						  
							function Slider:SetCallback(ToChange)  
								if getgenv().Destroy then return end
								SliderConfig.Callback = ToChange  
							end  
							
							if SliderConfig.Disabled then
								Slider:SetDisabled(true)
							end
							if SliderConfig.Visible == false then
								Slider:SetVisible(false)
							end
						  
							Slider.Value = math.clamp(Slider.Value, SliderConfig.Min, SliderConfig.Max)  
							TweenService:Create(SliderDrag, TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromScale((Slider.Value - SliderConfig.Min) / (SliderConfig.Max - SliderConfig.Min), 1)}):Play()  
							SliderBar.Value.Text = tostring(Slider.Value) .. " " .. SliderConfig.ValueName  
							SliderDrag.Value.Text = tostring(Slider.Value) .. " " .. SliderConfig.ValueName  
							
							if SliderConfig.Flag then  
								OrionLib.Flags[SliderConfig.Flag] = Slider  
							end  
							return Slider  
						end
                        function ElementFunction:AddDropdown(DropdownConfig)
							DropdownConfig = DropdownConfig or {}
							DropdownConfig.Name = DropdownConfig.Name or "Dropdown"
							DropdownConfig.Options = DropdownConfig.Options or {}
							DropdownConfig.Multi = DropdownConfig.Multi or false
							DropdownConfig.MultiTrue = DropdownConfig.MultiTrue or false
							DropdownConfig.Default = DropdownConfig.Default or (DropdownConfig.Multi and {} or nil)
							DropdownConfig.Callback = DropdownConfig.Callback or function() end
							DropdownConfig.Flag = DropdownConfig.Flag or nil
							DropdownConfig.Save = DropdownConfig.Save or false
							DropdownConfig.Visible = DropdownConfig.Visible ~= false
							DropdownConfig.Disabled = DropdownConfig.Disabled or false
							
							if DropdownConfig.MultiTrue then
							    DropdownConfig.Multi = true
							end
						
							local Dropdown = {
								Value = DropdownConfig.Default,
								Options = {},
								RawOptions = DropdownConfig.Options,
								Buttons = {},
								Toggled = false,
								Type = "Dropdown",
								Save = DropdownConfig.Save,
								Disabled = DropdownConfig.Disabled or false,
								Visible = DropdownConfig.Visible ~= false
							}
						
							local MaxElementsHeight = 250
						
							local function GetKeyList(tbl)
								local keys = {}
								for k, v in pairs(tbl) do
									if type(k) == "string" then
										table.insert(keys, k)
									else
										table.insert(keys, v)
									end
								end
								return keys
							end
						
							Dropdown.Options = GetKeyList(DropdownConfig.Options)
						
							if DropdownConfig.Multi then
							    if type(Dropdown.Value) ~= "table" then
							        Dropdown.Value = {}
							    end
							
							    if DropdownConfig.MultiTrue then
							        for _, v in ipairs(Dropdown.Options) do
							            if Dropdown.Value[v] == nil then
							                Dropdown.Value[v] = false
							            end
							        end
							    end
							else
								if Dropdown.Value ~= nil and not table.find(Dropdown.Options, Dropdown.Value) then
									Dropdown.Value = nil
								end
							end
						
							local DropdownList = MakeElement("List")
						
							local DropdownContainer = AddThemeObject(SetProps(SetChildren(
								MakeElement("ScrollFrame", Color3.fromRGB(40, 40, 40), 4),
								{DropdownList}
							), {
								Parent = ItemParent,
								Position = UDim2.new(0, 0, 0, 38),
								Size = UDim2.new(1, 0, 1, -38),
								ClipsDescendants = true
							}), "Divider")
						
							local Click = SetProps(MakeElement("Button"), {
								Size = UDim2.new(1, 0, 1, 0)
							})
						
							local DropdownFrame = AddThemeObject(SetChildren(SetProps(
								MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5),
								{
									Size = UDim2.new(1, 0, 0, 38),
									Parent = ItemParent,
									ClipsDescendants = true
								}
							), {
								DropdownContainer,
								SetProps(SetChildren(MakeElement("TFrame"), {
									AddThemeObject(SetProps(MakeElement("Label", DropdownConfig.Name, 15), {
										Size = UDim2.new(1, -12, 1, 0),
										Position = UDim2.new(0, 12, 0, 0),
										Font = Enum.Font.GothamBold,
										Name = "Content"
									}), "Text"),
						
									AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072706796"), {
										Size = UDim2.new(0, 20, 0, 20),
										AnchorPoint = Vector2.new(0, 0.5),
										Position = UDim2.new(1, -30, 0.5, 0),
										ImageColor3 = Color3.fromRGB(240, 240, 240),
										Name = "Ico"
									}), "TextDark"),
						
									AddThemeObject(SetProps(MakeElement("Label", "...", 13), {
										Size = UDim2.new(1, -40, 1, 0),
										Font = Enum.Font.Gotham,
										Name = "Selected",
										TextXAlignment = Enum.TextXAlignment.Right
									}), "TextDark"),
						
									AddThemeObject(SetProps(MakeElement("Frame"), {
										Size = UDim2.new(1, 0, 0, 1),
										Position = UDim2.new(0, 0, 1, -1),
										Name = "Line",
										Visible = false
									}), "Stroke"),
						
									Click
								}), {
									Size = UDim2.new(1, 0, 0, 38),
									ClipsDescendants = true,
									Name = "F"
								}),
								AddThemeObject(MakeElement("Stroke"), "Stroke"),
								MakeElement("Corner")
							}), "Second")
						
							AddConnection(DropdownList:GetPropertyChangedSignal("AbsoluteContentSize"), function()
								DropdownContainer.CanvasSize = UDim2.new(0, 0, 0, DropdownList.AbsoluteContentSize.Y)
							end)
						
							local function AddOptions(Options)
								for k, v in pairs(Options) do
									local OptionVal = (type(k) == "string" and k) or v
									local Data = (type(k) == "string" and v) or {}
									local HasData = (type(v) == "table")
									
									local TitleStr = HasData and (Data.Title or Data.title or OptionVal) or OptionVal
									local DescStr = HasData and (Data.Desc or Data.desc or nil) or nil
									local IconStr = HasData and (Data.Icon or Data.icon or nil) or nil
									local ThumbStr = HasData and (Data.Thumbnail or Data.thumbnail or nil) or nil
									
									local ButtonHeight = (ThumbStr and 65) or ((DescStr or IconStr) and 45) or 30
						
									local Elements = {
										MakeElement("Corner", 0, 6)
									}
									
									local TextLeftPadding = 8
						
									if ThumbStr then
										local strokeProps = {
											Color = Color3.fromRGB(60, 60, 60),
											Thickness = 1,
											Transparency = 0.5
										}
						
										table.insert(Elements, SetProps(SetChildren(MakeElement("Image", ThumbStr), {
											MakeElement("Corner", 0, 4),
											SetProps(MakeElement("Stroke"), strokeProps)
										}), {
											Size = UDim2.new(0, 55, 0, 55),
											AnchorPoint = Vector2.new(0, 0.5),
											Position = UDim2.new(0, 6, 0.5, 0),
											ImageTransparency = 0,
											Name = "Thumbnail",
											ScaleType = Enum.ScaleType.Crop,
											BackgroundColor3 = Color3.fromRGB(20, 20, 20)
										}))
										TextLeftPadding = 70
									elseif IconStr then
										table.insert(Elements, SetProps(MakeElement("Image", IconStr), {
											Size = UDim2.new(0, 26, 0, 26),
											Position = UDim2.new(0, 8, 0.5, -13),
											ImageTransparency = 0.4,
											Name = "Icon"
										}))
										TextLeftPadding = 42
									end
						
									local TitleY = DescStr and 6 or 0
									if ThumbStr and DescStr then TitleY = 12 end
						
									table.insert(Elements, AddThemeObject(SetProps(MakeElement("Label", TitleStr, 13, 0.4), {
										Position = UDim2.new(0, TextLeftPadding, 0, TitleY),
										Size = UDim2.new(1, -(TextLeftPadding + 10), (DescStr and 0 or 1), (DescStr and 16 or 0)),
										TextXAlignment = Enum.TextXAlignment.Left,
										Name = "Title",
										Font = Enum.Font.GothamBold,
										ClipsDescendants = true
									}), "Text"))
						
									if DescStr then
										local DescY = ThumbStr and 30 or 22
										table.insert(Elements, AddThemeObject(SetProps(MakeElement("Label", DescStr, 11, 0.4), {
											Position = UDim2.new(0, TextLeftPadding, 0, DescY),
											Size = UDim2.new(1, -(TextLeftPadding + 10), 0, 14),
											TextXAlignment = Enum.TextXAlignment.Left,
											Name = "Desc",
											Font = Enum.Font.Gotham,
											TextColor3 = Color3.fromRGB(150, 150, 150),
											ClipsDescendants = true
										}), "Text"))
									end
						
									local OptionBtn = AddThemeObject(SetProps(SetChildren(
										MakeElement("Button", Color3.fromRGB(40, 40, 40)),
										Elements
									), {
										Parent = DropdownContainer,
										Size = UDim2.new(1, 0, 0, ButtonHeight),
										BackgroundTransparency = 1,
										ClipsDescendants = true
									}), "Divider")
						
									AddConnection(OptionBtn.MouseButton1Click, function()
										if Dropdown.Disabled then return end
										Dropdown:Set(OptionVal)
									end)
						
									Dropdown.Buttons[OptionVal] = OptionBtn
								end
							end
							
							function Dropdown:SetDisabled(state)
								if getgenv().Destroy then return end
								Dropdown.Disabled = state
								DropdownConfig.Disabled = state
								if state and Dropdown.Toggled then
									Dropdown.Toggled = false
									TweenService:Create(DropdownFrame.F.Ico, TweenInfo.new(.15), {Rotation = 0}):Play()
									TweenService:Create(DropdownFrame, TweenInfo.new(.15), {
										Size = UDim2.new(1, 0, 0, 38)
									}):Play()
								end
								if DropdownFrame then
									TweenService:Create(DropdownFrame, TweenInfo.new(0.2), {
										BackgroundTransparency = state and 0.5 or 0
									}):Play()
								end
								if DropdownFrame:FindFirstChild("F") and DropdownFrame.F:FindFirstChild("Content") then
									DropdownFrame.F.Content.TextTransparency = state and 0.5 or 0
								end
								if DropdownFrame.F:FindFirstChild("Selected") then
									DropdownFrame.F.Selected.TextTransparency = state and 0.5 or 0
								end
							end
							
							function Dropdown:SetVisible(state)
								if getgenv().Destroy then return end
								Dropdown.Visible = state
								DropdownConfig.Visible = state
								if DropdownFrame then
									DropdownFrame.Visible = state
								end
							end
						
							function Dropdown:SetCallback(call)
								if getgenv().Destroy then return end
								DropdownConfig.Callback = call
							end
						
							function Dropdown:Refresh(Options, Delete)
								if getgenv().Destroy then return end
								if Delete then
									for _, v in pairs(Dropdown.Buttons) do
										v:Destroy()
									end
									table.clear(Dropdown.Options)
									table.clear(Dropdown.Buttons)
								end
								
								Dropdown.RawOptions = Options
								Dropdown.Options = GetKeyList(Options)
								AddOptions(Options)
							end
						
							function Dropdown:Set(Value)
								if getgenv().Destroy or Dropdown.Disabled then return end
								if not table.find(Dropdown.Options, Value) then
									Dropdown.Value = DropdownConfig.Multi and {} or nil
									DropdownFrame.F.Selected.Text = "..."
									for _, v in pairs(Dropdown.Buttons) do
										TweenService:Create(v, TweenInfo.new(.15), {BackgroundTransparency = 1}):Play()
										TweenService:Create(v.Title, TweenInfo.new(.15), {TextTransparency = 0.4}):Play()
										if v:FindFirstChild("Desc") then TweenService:Create(v.Desc, TweenInfo.new(.15), {TextTransparency = 0.5}):Play() end
										if v:FindFirstChild("Icon") then TweenService:Create(v.Icon, TweenInfo.new(.15), {ImageTransparency = 0.4}):Play() end
									end
									return
								end
						
								if DropdownConfig.Multi then
								    local btn = Dropdown.Buttons[Value]
								    if not btn then return end
								    if DropdownConfig.MultiTrue then
								        Dropdown.Value[Value] = not Dropdown.Value[Value]
								        local state = Dropdown.Value[Value]
								        if state then
								            TweenService:Create(btn, TweenInfo.new(.15), {BackgroundTransparency = 0}):Play()
								            TweenService:Create(btn.Title, TweenInfo.new(.15), {TextTransparency = 0}):Play()
								            if btn:FindFirstChild("Desc") then
								                TweenService:Create(btn.Desc, TweenInfo.new(.15), {TextTransparency = 0}):Play()
								            end
								            if btn:FindFirstChild("Icon") then
								                TweenService:Create(btn.Icon, TweenInfo.new(.15), {ImageTransparency = 0}):Play()
								            end
								        else
								            TweenService:Create(btn, TweenInfo.new(.15), {BackgroundTransparency = 1}):Play()
								            TweenService:Create(btn.Title, TweenInfo.new(.15), {TextTransparency = 0.4}):Play()
								            if btn:FindFirstChild("Desc") then
								                TweenService:Create(btn.Desc, TweenInfo.new(.15), {TextTransparency = 0.5}):Play()
								            end
								            if btn:FindFirstChild("Icon") then
								                TweenService:Create(btn.Icon, TweenInfo.new(.15), {ImageTransparency = 0.4}):Play()
								            end
								        end
								        local selectedList = {}
								        for k, v in pairs(Dropdown.Value) do
								            if v == true then
								                table.insert(selectedList, k)
								            end
								        end
								        if #selectedList == 0 then
								            DropdownFrame.F.Selected.Text = "..."
								        else
								            local text = table.concat(selectedList, ", ")
								            DropdownFrame.F.Selected.Text =
								                (#text > 20) and string.sub(text, 1, 17) .. "..." or text
								        end
								        return DropdownConfig.Callback(Dropdown.Value)
								    else
								        local index = table.find(Dropdown.Value, Value)
								        if index then
								            table.remove(Dropdown.Value, index)
								            TweenService:Create(btn, TweenInfo.new(.15), {BackgroundTransparency = 1}):Play()
								            TweenService:Create(btn.Title, TweenInfo.new(.15), {TextTransparency = 0.4}):Play()
								            if btn:FindFirstChild("Desc") then
								                TweenService:Create(btn.Desc, TweenInfo.new(.15), {TextTransparency = 0.5}):Play()
								            end
								            if btn:FindFirstChild("Icon") then
								                TweenService:Create(btn.Icon, TweenInfo.new(.15), {ImageTransparency = 0.4}):Play()
								            end
								        else
								            table.insert(Dropdown.Value, Value)
								            TweenService:Create(btn, TweenInfo.new(.15), {BackgroundTransparency = 0}):Play()
								            TweenService:Create(btn.Title, TweenInfo.new(.15), {TextTransparency = 0}):Play()
								            if btn:FindFirstChild("Desc") then
								                TweenService:Create(btn.Desc, TweenInfo.new(.15), {TextTransparency = 0}):Play()
								            end
								            if btn:FindFirstChild("Icon") then
								                TweenService:Create(btn.Icon, TweenInfo.new(.15), {ImageTransparency = 0}):Play()
								            end
								        end
								        if #Dropdown.Value == 0 then
								            DropdownFrame.F.Selected.Text = "..."
								        else
								            local text = table.concat(Dropdown.Value, ", ")
								            DropdownFrame.F.Selected.Text =
								                (#text > 20) and string.sub(text, 1, 17) .. "..." or text
								        end
								        return DropdownConfig.Callback(Dropdown.Value)
								    end
								end
								
								Dropdown.Value = Value
								local dataInfo = Dropdown.RawOptions[Value]
								local titleShow = Value
								if type(dataInfo) == "table" and dataInfo.Title then titleShow = dataInfo.Title end
								DropdownFrame.F.Selected.Text = titleShow
						
								for _, v in pairs(Dropdown.Buttons) do
									TweenService:Create(v, TweenInfo.new(.15), {BackgroundTransparency = 1}):Play()
									TweenService:Create(v.Title, TweenInfo.new(.15), {TextTransparency = 0.4}):Play()
									if v:FindFirstChild("Desc") then TweenService:Create(v.Desc, TweenInfo.new(.15), {TextTransparency = 0.5}):Play() end
									if v:FindFirstChild("Icon") then TweenService:Create(v.Icon, TweenInfo.new(.15), {ImageTransparency = 0.4}):Play() end
								end
						
								local selBtn = Dropdown.Buttons[Value]
								if selBtn then
									TweenService:Create(selBtn, TweenInfo.new(.15), {BackgroundTransparency = 0}):Play()
									TweenService:Create(selBtn.Title, TweenInfo.new(.15), {TextTransparency = 0}):Play()
									if selBtn:FindFirstChild("Desc") then TweenService:Create(selBtn.Desc, TweenInfo.new(.15), {TextTransparency = 0.2}):Play() end
									if selBtn:FindFirstChild("Icon") then TweenService:Create(selBtn.Icon, TweenInfo.new(.15), {ImageTransparency = 0}):Play() end
								end
								return DropdownConfig.Callback(Dropdown.Value)
							end
						
							AddConnection(Click.MouseButton1Click, function()
								if Dropdown.Disabled then return end
								Dropdown.Toggled = not Dropdown.Toggled
								DropdownFrame.F.Line.Visible = Dropdown.Toggled
								TweenService:Create(DropdownFrame.F.Ico, TweenInfo.new(.15), {Rotation = Dropdown.Toggled and 180 or 0}):Play()
						
								local currentContentSize = DropdownList.AbsoluteContentSize.Y
								local expandSize = math.min(currentContentSize, MaxElementsHeight)
								local sizeY = (currentContentSize > 0)
									and (38 + expandSize)
									or 38
						
								TweenService:Create(DropdownFrame, TweenInfo.new(.15), {
									Size = Dropdown.Toggled and UDim2.new(1, 0, 0, sizeY) or UDim2.new(1, 0, 0, 38)
								}):Play()
							end)
						
							Dropdown:Refresh(DropdownConfig.Options, false)
							if DropdownConfig.Disabled then
								Dropdown:SetDisabled(true)
							end
							if DropdownConfig.Visible == false then
								Dropdown:SetVisible(false)
							end
							if DropdownConfig.Multi then
								for _, v in ipairs(Dropdown.Value) do
									Dropdown:Set(v)
								end
							else
								if Dropdown.Value then
									Dropdown:Set(Dropdown.Value)
								end
							end
						
							if DropdownConfig.Flag then
								OrionLib.Flags[DropdownConfig.Flag] = Dropdown
							end
						
							return Dropdown
						end
                        function ElementFunction:AddBind(BindConfig)
                                BindConfig.Name = BindConfig.Name or "Bind"
                                BindConfig.Default = BindConfig.Default or Enum.KeyCode.Unknown
                                BindConfig.Hold = BindConfig.Hold or false
                                BindConfig.Callback = BindConfig.Callback or function() end
                                BindConfig.Flag = BindConfig.Flag or nil
                                BindConfig.Save = BindConfig.Save or false
                                BindConfig.Visible = BindConfig.Visible ~= false
                                BindConfig.Disabled = BindConfig.Disabled or false

                                local Bind = {
								    Value,
								    Binding = false,
								    Type = "Bind",
								    Save = BindConfig.Save,
								    Visible = BindConfig.Visible,
								    Disabled = BindConfig.Disabled
								}
								
                                local Holding = false

                                local Click = SetProps(MakeElement("Button"), {
                                        Size = UDim2.new(1, 0, 1, 0)
                                })

                                local BindBox = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), {
                                        Size = UDim2.new(0, 24, 0, 24),
                                        Position = UDim2.new(1, -12, 0.5, 0),
                                        AnchorPoint = Vector2.new(1, 0.5)
                                }), {
                                        AddThemeObject(MakeElement("Stroke"), "Stroke"),
                                        AddThemeObject(SetProps(MakeElement("Label", BindConfig.Name, 14), {
                                                Size = UDim2.new(1, 0, 1, 0),
                                                Font = Enum.Font.GothamBold,
                                                TextXAlignment = Enum.TextXAlignment.Center,
                                                Name = "Value"
                                        }), "Text")
                                }), "Main")

                                local BindFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
                                        Size = UDim2.new(1, 0, 0, 38),
                                        Parent = ItemParent
                                }), {
                                        AddThemeObject(SetProps(MakeElement("Label", BindConfig.Name, 15), {
                                                Size = UDim2.new(1, -12, 1, 0),
                                                Position = UDim2.new(0, 12, 0, 0),
                                                Font = Enum.Font.GothamBold,
                                                Visible = BindConfig.Visible,
                                                Name = "Content"
                                        }), "Text"),
                                        AddThemeObject(MakeElement("Stroke"), "Stroke"),
                                        BindBox,
                                        Click
                                }), "Second")

                                AddConnection(BindBox.Value:GetPropertyChangedSignal("Text"), function()
                                        TweenService:Create(BindBox, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, BindBox.Value.TextBounds.X + 16, 0, 24)}):Play()
                                end)

                                AddConnection(Click.InputEnded, function(Input)
		                                if Bind.Disabled then return end
                                        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                                                if Bind.Binding then return end
                                                Bind.Binding = true
                                                BindBox.Value.Text = ""
                                        end
                                end)

                                AddConnection(UserInputService.InputBegan, function(Input)
		                                if Bind.Disabled then return end
                                        if UserInputService:GetFocusedTextBox() then return end
                                        if (Input.KeyCode.Name == Bind.Value or Input.UserInputType.Name == Bind.Value) and not Bind.Binding then
                                                if BindConfig.Hold then
                                                        Holding = true
                                                        BindConfig.Callback(Holding)
                                                else
                                                        BindConfig.Callback(Input)
                                                end
                                        elseif Bind.Binding then
                                                local Key
                                                pcall(function()
                                                        if not CheckKey(BlacklistedKeys, Input.KeyCode) then
                                                                Key = Input.KeyCode
                                                        end
                                                end)
                                                pcall(function()
                                                        if CheckKey(WhitelistedMouse, Input.UserInputType) and not Key then
                                                                Key = Input.UserInputType
                                                        end
                                                end)
                                                Key = Key or Bind.Value
                                                Bind:Set(Key)
                                        end
                                end)

                                AddConnection(UserInputService.InputEnded, function(Input)
		                                if Bind.Disabled then return end
                                        if Input.KeyCode.Name == Bind.Value or Input.UserInputType.Name == Bind.Value then
                                                if BindConfig.Hold and Holding then
                                                        Holding = false
                                                        BindConfig.Callback(Holding)
                                                end
                                        end
                                end)

                                AddConnection(Click.MouseEnter, function()
                                        TweenService:Create(BindFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
                                end)

                                AddConnection(Click.MouseLeave, function()
                                        TweenService:Create(BindFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Second}):Play()
                                end)

                                AddConnection(Click.MouseButton1Up, function()
                                        TweenService:Create(BindFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
                                end)

                                AddConnection(Click.MouseButton1Down, function()
                                        TweenService:Create(BindFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 6)}):Play()
                                end)

                                function Bind:Set(Key)
		                                if getgenv().Destroy or Bind.Disabled then return end
                                        Bind.Binding = false
                                        Bind.Value = Key or Bind.Value
                                        Bind.Value = Bind.Value.Name or Bind.Value
                                        BindBox.Value.Text = Bind.Value
                                end
                                
                                function Bind:SetText(ToChange)
	                                if getgenv().Destroy or Bind.Disabled then return end
	                                if BindFrame and BindFrame:FindFirstChild("Content") then
										BindFrame.Content.Text = ToChange
									end
                                end
                                
                                function Bind:SetCallback(ToChange)
	                                if getgenv().Destroy or Bind.Disabled then return end
	                                BindConfig.Callback = ToChange
                                end
                                
                                function Bind:SetVisible(State)
								    if getgenv().Destroy then return end
								    Bind.Visible = State
								    if BindFrame then
								        BindFrame.Visible = State
								    end
								end
								
								function Bind:SetDisabled(State)
								    if getgenv().Destroy then return end
								    Bind.Disabled = State
								    
								    if State then
								        TweenService:Create(BindFrame, TweenInfo.new(.2), {
								            BackgroundTransparency = 0.5
								        }):Play()
								    else
								        TweenService:Create(BindFrame, TweenInfo.new(.2), {
								            BackgroundTransparency = 0
								        }):Play()
								    end
								end

                                Bind:Set(BindConfig.Default)
                                if BindConfig.Flag then                                
                                        OrionLib.Flags[BindConfig.Flag] = Bind
                                end
                                return Bind
                        end  
                        function ElementFunction:AddTextbox(TextboxConfig)
                                TextboxConfig = TextboxConfig or {}
                                TextboxConfig.Name = TextboxConfig.Name or "Textbox"
                                TextboxConfig.Finished = TextboxConfig.Finished or false
                                TextboxConfig.Save = TextboxConfig.Save or false
                                TextboxConfig.Numeric = TextboxConfig.Numeric or false
                                TextboxConfig.Flag = TextboxConfig.Flag or nil
                                TextboxConfig.Default = TextboxConfig.Default or ""
                                TextboxConfig.TextDisappear = TextboxConfig.TextDisappear or false
                                TextboxConfig.Callback = TextboxConfig.Callback or function() end
                                TextboxConfig.Visible = TextboxConfig.Visible ~= false
                                TextboxConfig.Disabled = TextboxConfig.Disabled or false
                                
                                local Textbox = {
								    Value = TextboxConfig.Default,
								    Type = "Input",
								    Save = TextboxConfig.Save,
								    Visible = TextboxConfig.Visible,
								    Disabled = TextboxConfig.Disabled
								}

                                local Click = SetProps(MakeElement("Button"), {
                                        Size = UDim2.new(1, 0, 1, 0)
                                })

                                local TextboxActual = AddThemeObject(Create("TextBox", {
                                        Size = UDim2.new(1, 0, 1, 0),
                                        BackgroundTransparency = 1,
                                        TextColor3 = Color3.fromRGB(255, 255, 255),
                                        PlaceholderColor3 = Color3.fromRGB(210,210,210),
                                        PlaceholderText = "Input",
                                        Text = Textbox.Value or "",
                                        ClearTextOnFocus = TextboxConfig.TextDisappear,
                                        Font = Enum.Font.GothamSemibold,
                                        ClipsDescendants = true,
                                        TextXAlignment = Enum.TextXAlignment.Center,
                                        TextSize = 14
                                }), "Text")

                                local TextContainer = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), {
                                        Size = UDim2.new(0, 100, 0, 24),
                                        Position = UDim2.new(1, -12, 0.5, 0),
                                        AnchorPoint = Vector2.new(1, 0.5)
                                }), {
                                        AddThemeObject(MakeElement("Stroke"), "Stroke"),
                                        TextboxActual
                                }), "Main")


                                local TextboxFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
                                        Size = UDim2.new(1, 0, 0, 38),
                                        Parent = ItemParent
                                }), {
                                        AddThemeObject(SetProps(MakeElement("Label", TextboxConfig.Name, 15), {
                                                Size = UDim2.new(1, -12, 1, 0),
                                                Position = UDim2.new(0, 12, 0, 0),
                                                Font = Enum.Font.GothamBold,
                                                Visible = TextboxConfig.Visible,
                                                Name = "Content"
                                        }), "Text"),
                                        AddThemeObject(MakeElement("Stroke"), "Stroke"),
                                        TextContainer,
                                        Click
                                }), "Second")
                                
                                local function SetValue()
	                                if Textbox.Disabled then return end
		                            if TextboxConfig.Numeric then
										if #TextboxActual.Text > 0 and not tonumber(TextboxActual.Text) then
											TextboxActual.Text = TextboxActual.Text:match("%d+") or ""
										end
									end
									Textbox.Value = TextboxActual.Text
	                                TextboxConfig.Callback(TextboxActual.Text)
                                end
                                
                                if TextboxConfig.Finished then
	                                AddConnection(TextboxActual.FocusLost, function()
		                                SetValue()
	                                end)
                                else
	                                AddConnection(TextboxActual:GetPropertyChangedSignal("Text"), function()
		                                SetValue()
	                                end)
                                end
                                
                                function Textbox:SetText(ToChange)
	                                if getgenv().Destroy or Textbox.Disabled then return end
	                                if TextboxActual then
										TextboxActual.Text = ToChange
										if TextboxConfig.Finished == false then
											SetValue()
										end
									end
                                end
                                
                                function Textbox:SetLabel(ToChange)
	                                if getgenv().Destroy or Textbox.Disabled then return end
	                                if TextboxFrame and TextboxFrame:FindFirstChild("Content") then
										TextboxFrame.Content.Text = ToChange
									end
                                end
                                
                                function Textbox:SetCallback(ToChange)
	                                if getgenv().Destroy or Textbox.Disabled then return end
	                                TextboxConfig.Callback = ToChange
                                end
                                
                                function Textbox:SetVisible(State)
								    if getgenv().Destroy then return end
								    Textbox.Visible = State
								    if TextboxFrame then
								        TextboxFrame.Visible = State
								    end
								end
								
								function Textbox:SetDisabled(State)
								    if getgenv().Destroy then return end
								    Textbox.Disabled = State
								    if State then
								        TweenService:Create(TextboxFrame, TweenInfo.new(.2), {
								            BackgroundTransparency = 0.5
								        }):Play()
								    else
								        TweenService:Create(TextboxFrame, TweenInfo.new(.2), {
								            BackgroundTransparency = 0
								        }):Play()
								    end
									if TextboxActual then
										TextboxActual.TextEditable = not State
									end
								end

                                AddConnection(Click.MouseEnter, function()
                                        TweenService:Create(TextboxFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
                                end)

                                AddConnection(Click.MouseLeave, function()
                                        TweenService:Create(TextboxFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Second}):Play()
                                end)

                                AddConnection(Click.MouseButton1Up, function()
                                        TweenService:Create(TextboxFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
                                        TextboxActual:CaptureFocus()
                                end)

                                AddConnection(Click.MouseButton1Down, function()
                                        TweenService:Create(TextboxFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 6)}):Play()
                                end)
                                
                                if TextboxConfig.Flag then
	                                OrionLib.Flags[TextboxConfig.Flag] = Textbox
		                        end
							return Textbox
						end
                        function ElementFunction:AddColorpicker(ColorpickerConfig)
							ColorpickerConfig = ColorpickerConfig or {}
							ColorpickerConfig.Name = ColorpickerConfig.Name or "Colorpicker"
							ColorpickerConfig.Default = ColorpickerConfig.Default or Color3.fromRGB(255, 255, 255)
							ColorpickerConfig.DefaultAlpha = ColorpickerConfig.DefaultAlpha or 0
							ColorpickerConfig.Callback = ColorpickerConfig.Callback or function() end
							ColorpickerConfig.Flag = ColorpickerConfig.Flag or nil
							ColorpickerConfig.Save = ColorpickerConfig.Save or false
							ColorpickerConfig.Alpha = ColorpickerConfig.Alpha or false
						
							local ColorH, ColorS, ColorV = 1, 1, 1
							local AlphaValue = ColorpickerConfig.DefaultAlpha
							local Colorpicker = {
								Value = ColorpickerConfig.Default,
								Alpha = AlphaValue,
								Toggled = false,
								Type = "Colorpicker",
								Save = ColorpickerConfig.Save,
								RecentColors = {}
							}
						
							local function RGBToHex(c)
								return string.format("#%02X%02X%02X", c.R * 255, c.G * 255, c.B * 255)
							end
						
							local function HexToRGB(hex)
								hex = hex:gsub("#", "")
								return Color3.fromRGB(tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6)))
							end
						
							local ColorSelection = Create("ImageLabel", {
								Size = UDim2.new(0, 18, 0, 18),
								Position = UDim2.new(select(3, Color3.toHSV(Colorpicker.Value))),
								ScaleType = Enum.ScaleType.Fit,
								AnchorPoint = Vector2.new(0.5, 0.5),
								BackgroundTransparency = 1,
								Image = "http://www.roblox.com/asset/?id=4805639000"
							})
						
							local HueSelection = Create("ImageLabel", {
								Size = UDim2.new(0, 18, 0, 18),
								Position = UDim2.new(0.5, 0, 1 - select(1, Color3.toHSV(Colorpicker.Value))),
								ScaleType = Enum.ScaleType.Fit,
								AnchorPoint = Vector2.new(0.5, 0.5),
								BackgroundTransparency = 1,
								Image = "http://www.roblox.com/asset/?id=4805639000"
							})
							
							local AlphaSelection = Create("ImageLabel", {
								Size = UDim2.new(0, 18, 0, 18),
								Position = UDim2.new(0.5, 0, 1 - AlphaValue, 0),
								ScaleType = Enum.ScaleType.Fit,
								AnchorPoint = Vector2.new(0.5, 0.5),
								BackgroundTransparency = 1,
								Image = "http://www.roblox.com/asset/?id=4805639000"
							})
						
							local ColorP = Create("ImageLabel", {
								Size = UDim2.new(1, -50, 0, 150),
								Visible = false,
								Image = "rbxassetid://4155801252"
							}, {
								Create("UICorner", {CornerRadius = UDim.new(0, 5)}),
								ColorSelection
							})
						
							local Hue = Create("Frame", {
								Size = UDim2.new(0, 20, 0, 150),
								Position = UDim2.new(1, -45, 0, 0),
								Visible = false
							}, {
								Create("UIGradient", {
									Rotation = 90,
									Color = ColorSequence.new{
										ColorSequenceKeypoint.new(0.00, Color3.fromHSV(1, 1, 1)),
										ColorSequenceKeypoint.new(0.17, Color3.fromHSV(0.83, 1, 1)),
										ColorSequenceKeypoint.new(0.33, Color3.fromHSV(0.67, 1, 1)),
										ColorSequenceKeypoint.new(0.50, Color3.fromHSV(0.5, 1, 1)),
										ColorSequenceKeypoint.new(0.67, Color3.fromHSV(0.33, 1, 1)),
										ColorSequenceKeypoint.new(0.83, Color3.fromHSV(0.17, 1, 1)),
										ColorSequenceKeypoint.new(1.00, Color3.fromHSV(0, 1, 1))
									}
								}),
								Create("UICorner", {CornerRadius = UDim.new(0, 5)}),
								HueSelection
							})
							
							local AlphaFrame = Create("Frame", {
								Size = UDim2.new(0, 20, 0, 150),
								Position = UDim2.new(1, -20, 0, 0),
								Visible = false
							}, {
								Create("ImageLabel", {
									Size = UDim2.new(1,0,1,0),
									Image = "rbxassetid://3885141947",
									ScaleType = Enum.ScaleType.Tile,
									TileSize = UDim2.new(0, 10, 0, 10),
									BackgroundTransparency = 0.5
								}, {
									Create("UICorner", {CornerRadius = UDim.new(0, 5)})
								}),
								Create("Frame", {
									Size = UDim2.new(1, 0, 1, 0),
									BackgroundColor3 = Color3.new(1,1,1),
									Name = "GradientHolder"
								}, {
									Create("UIGradient", {
										Rotation = 90,
										Transparency = NumberSequence.new({
											NumberSequenceKeypoint.new(0, 0),
											NumberSequenceKeypoint.new(1, 1)
										})
									}),
									Create("UICorner", {CornerRadius = UDim.new(0, 5)}),
								}),
								Create("UICorner", {CornerRadius = UDim.new(0, 5)}),
								AlphaSelection
							})
						
							if not ColorpickerConfig.Alpha then
								ColorP.Size = UDim2.new(1, -25, 0, 150)
								Hue.Position = UDim2.new(1, -20, 0, 0)
								AlphaFrame.Visible = false
							end
						
							local Inputs = Create("Frame", {
								Size = UDim2.new(1, 0, 0, 30),
								Position = UDim2.new(0, 0, 0, 160),
								BackgroundTransparency = 1,
								Visible = false
							}, {
								Create("UIListLayout", {
									FillDirection = Enum.FillDirection.Horizontal,
									SortOrder = Enum.SortOrder.LayoutOrder,
									Padding = UDim.new(0, 5)
								})
							})
							
							local HexBox = Create("TextBox", {
								Size = UDim2.new(0, 70, 1, 0),
								BackgroundColor3 = Color3.fromRGB(30, 30, 30),
								TextColor3 = Color3.fromRGB(255, 255, 255),
								Text = RGBToHex(Colorpicker.Value),
								Font = Enum.Font.GothamBold,
								TextSize = 12,
								PlaceholderText = "HEX"
							}, {Create("UICorner", {CornerRadius = UDim.new(0, 4)})})
							
							local RBox = Create("TextBox", {Size = UDim2.new(0, 40, 1, 0), BackgroundColor3 = Color3.fromRGB(30,30,30), TextColor3 = Color3.new(1,0,0), Text = math.floor(Colorpicker.Value.R*255), Font=Enum.Font.GothamBold, TextSize=12}, {Create("UICorner", {CornerRadius=UDim.new(0,4)})})
							local GBox = Create("TextBox", {Size = UDim2.new(0, 40, 1, 0), BackgroundColor3 = Color3.fromRGB(30,30,30), TextColor3 = Color3.new(0,1,0), Text = math.floor(Colorpicker.Value.G*255), Font=Enum.Font.GothamBold, TextSize=12}, {Create("UICorner", {CornerRadius=UDim.new(0,4)})})
							local BBox = Create("TextBox", {Size = UDim2.new(0, 40, 1, 0), BackgroundColor3 = Color3.fromRGB(30,30,30), TextColor3 = Color3.new(0.3,0.3,1), Text = math.floor(Colorpicker.Value.B*255), Font=Enum.Font.GothamBold, TextSize=12}, {Create("UICorner", {CornerRadius=UDim.new(0,4)})})
							
							local EyedropperBtn = Create("TextButton", {
								Size = UDim2.new(0, 30, 1, 0),
								BackgroundColor3 = Color3.fromRGB(40, 40, 40),
								Text = "",
							}, {
								Create("UICorner", {CornerRadius = UDim.new(0, 4)}),
								Create("ImageLabel", {
									Size = UDim2.new(0, 16, 0, 16),
									AnchorPoint = Vector2.new(0.5, 0.5),
									Position = UDim2.new(0.5, 0, 0.5, 0),
									Image = "rbxassetid://6031256372",
									BackgroundTransparency = 1
								})
							})
							
							HexBox.Parent = Inputs
							RBox.Parent = Inputs
							GBox.Parent = Inputs
							BBox.Parent = Inputs
							EyedropperBtn.Parent = Inputs
							
							local RecentFrame = Create("Frame", {
								Size = UDim2.new(1, 0, 0, 20),
								Position = UDim2.new(0, 0, 0, 195),
								BackgroundTransparency = 1,
								Visible = false
							}, {
								Create("UIListLayout", {
									FillDirection = Enum.FillDirection.Horizontal,
									SortOrder = Enum.SortOrder.LayoutOrder,
									Padding = UDim.new(0, 6)
								})
							})
						
							local ColorpickerContainer = Create("Frame", {
								Position = UDim2.new(0, 0, 0, 38),
								Size = UDim2.new(1, 0, 1, -38),
								BackgroundTransparency = 1,
								ClipsDescendants = true
							}, {
								Hue,
								ColorP,
								AlphaFrame,
								Inputs,
								RecentFrame,
								Create("UIPadding", {
									PaddingLeft = UDim.new(0, 10),
									PaddingRight = UDim.new(0, 10),
									PaddingBottom = UDim.new(0, 10),
									PaddingTop = UDim.new(0, 10)
								})
							})
						
							local Click = SetProps(MakeElement("Button"), {
								Size = UDim2.new(1, 0, 1, 0)
							})
						
							local ColorpickerBox = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), {
								Size = UDim2.new(0, 24, 0, 24),
								Position = UDim2.new(1, -12, 0.5, 0),
								AnchorPoint = Vector2.new(1, 0.5)
							}), {
								AddThemeObject(MakeElement("Stroke"), "Stroke")
							}), "Main")
						
							local ColorpickerFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
								Size = UDim2.new(1, 0, 0, 38),
								Parent = ItemParent
							}), {
								SetProps(SetChildren(MakeElement("TFrame"), {
									AddThemeObject(SetProps(MakeElement("Label", ColorpickerConfig.Name, 15), {
										Size = UDim2.new(1, -12, 1, 0),
										Position = UDim2.new(0, 12, 0, 0),
										Font = Enum.Font.GothamBold,
										Name = "Content"
									}), "Text"),
									ColorpickerBox,
									Click,
									AddThemeObject(SetProps(MakeElement("Frame"), {
										Size = UDim2.new(1, 0, 0, 1),
										Position = UDim2.new(0, 0, 1, -1),
										Name = "Line",
										Visible = false
									}), "Stroke"), 
								}), {
									Size = UDim2.new(1, 0, 0, 38),
									ClipsDescendants = true,
									Name = "F"
								}),
								ColorpickerContainer,
								AddThemeObject(MakeElement("Stroke"), "Stroke"),
							}), "Second")
							
							local function AddRecentColor(Col)
								local found = false
								for _, v in ipairs(Colorpicker.RecentColors) do
									if v == Col then found = true end
								end
								if not found then
									table.insert(Colorpicker.RecentColors, 1, Col)
									if #Colorpicker.RecentColors > 5 then
										table.remove(Colorpicker.RecentColors, 6)
									end
								end
								
								for _, child in pairs(RecentFrame:GetChildren()) do
									if child:IsA("ImageButton") then child:Destroy() end
								end
								
								for _, rc in ipairs(Colorpicker.RecentColors) do
									local cBtn = Create("ImageButton", {
										Size = UDim2.new(0, 20, 0, 20),
										BackgroundColor3 = rc,
										AutoButtonColor = false
									}, {Create("UICorner", {CornerRadius = UDim.new(0, 4)})})
									cBtn.Parent = RecentFrame
									AddConnection(cBtn.MouseButton1Click, function()
										Colorpicker:Set(rc)
									end)
								end
							end
						
							local function UpdateInputDisplays()
								local col = Colorpicker.Value
								HexBox.Text = RGBToHex(col)
								RBox.Text = tostring(math.floor(col.R * 255))
								GBox.Text = tostring(math.floor(col.G * 255))
								BBox.Text = tostring(math.floor(col.B * 255))
								AlphaFrame.GradientHolder.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
							end
						
							local function UpdateColorPicker(BlockCallback)
								ColorpickerBox.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
								ColorP.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)
								
								Colorpicker.Value = ColorpickerBox.BackgroundColor3
								
								if not BlockCallback then
									ColorpickerConfig.Callback(Colorpicker.Value, AlphaValue)
								end
								
								UpdateInputDisplays()
							end
							
							ColorH, ColorS, ColorV = Color3.toHSV(Colorpicker.Value)
						
							AddConnection(Click.MouseButton1Click, function()
								Colorpicker.Toggled = not Colorpicker.Toggled
								local sizeH = ColorpickerConfig.Alpha and 270 or 270
								TweenService:Create(ColorpickerFrame, TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = Colorpicker.Toggled and UDim2.new(1, 0, 0, sizeH) or UDim2.new(1, 0, 0, 38)}):Play()
								ColorP.Visible = Colorpicker.Toggled
								Hue.Visible = Colorpicker.Toggled
								AlphaFrame.Visible = Colorpicker.Toggled and ColorpickerConfig.Alpha
								Inputs.Visible = Colorpicker.Toggled
								RecentFrame.Visible = Colorpicker.Toggled
								ColorpickerFrame.F.Line.Visible = Colorpicker.Toggled
								if not Colorpicker.Toggled then
									AddRecentColor(Colorpicker.Value)
								end
							end)
						
							AddConnection(EyedropperBtn.MouseButton1Click, function()
								local mouse = game.Players.LocalPlayer:GetMouse()
								local pickerConnect
								pickerConnect = AddConnection(game:GetService("RunService").RenderStepped, function()
									local target = mouse.Target
									if target and target:IsA("BasePart") then
										EyedropperBtn.BackgroundColor3 = target.Color
										EyedropperBtn.Text = ""
									else
										EyedropperBtn.BackgroundColor3 = Color3.new(0,0,0)
										EyedropperBtn.Text = "?"
									end
								end)
								
								local clickConnect
								clickConnect = AddConnection(game:GetService("UserInputService").InputBegan, function(input)
									if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
										local target = mouse.Target
										if target and target:IsA("BasePart") then
											Colorpicker:Set(target.Color)
										end
										pickerConnect:Disconnect()
										clickConnect:Disconnect()
										EyedropperBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
									end
								end)
							end)
							
							AddConnection(HexBox.FocusLost, function()
								pcall(function()
									local nC = HexToRGB(HexBox.Text)
									Colorpicker:Set(nC)
								end)
							end)
							
							local function UpdateRGB()
								local r, g, b = tonumber(RBox.Text) or 0, tonumber(GBox.Text) or 0, tonumber(BBox.Text) or 0
								Colorpicker:Set(Color3.fromRGB(r, g, b))
							end
							AddConnection(RBox.FocusLost, UpdateRGB)
							AddConnection(GBox.FocusLost, UpdateRGB)
							AddConnection(BBox.FocusLost, UpdateRGB)
						
							AddConnection(ColorP.InputBegan, function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
									if ColorInput then ColorInput:Disconnect() end
									ColorInput = AddConnection(RunService.RenderStepped, function()
										local ColorX = (math.clamp(Mouse.X - ColorP.AbsolutePosition.X, 0, ColorP.AbsoluteSize.X) / ColorP.AbsoluteSize.X)
										local ColorY = (math.clamp(Mouse.Y - ColorP.AbsolutePosition.Y, 0, ColorP.AbsoluteSize.Y) / ColorP.AbsoluteSize.Y)
										ColorSelection.Position = UDim2.new(ColorX, 0, ColorY, 0)
										ColorS = ColorX
										ColorV = 1 - ColorY
										UpdateColorPicker()
									end)
								end
							end)
						
							AddConnection(ColorP.InputEnded, function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
									if ColorInput then ColorInput:Disconnect() end
								end
							end)
						
							AddConnection(Hue.InputBegan, function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
									if HueInput then HueInput:Disconnect() end
									HueInput = AddConnection(RunService.RenderStepped, function()
										local HueY = (math.clamp(Mouse.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y)
										HueSelection.Position = UDim2.new(0.5, 0, HueY, 0)
										ColorH = 1 - HueY
										UpdateColorPicker()
									end)
								end
							end)
						
							AddConnection(Hue.InputEnded, function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
									if HueInput then HueInput:Disconnect() end
								end
							end)
							
							AddConnection(AlphaFrame.InputBegan, function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
									if AlphaInput then AlphaInput:Disconnect() end
									AlphaInput = AddConnection(RunService.RenderStepped, function()
										local AY = (math.clamp(Mouse.Y - AlphaFrame.AbsolutePosition.Y, 0, AlphaFrame.AbsoluteSize.Y) / AlphaFrame.AbsoluteSize.Y)
										AlphaSelection.Position = UDim2.new(0.5, 0, AY, 0)
										AlphaValue = 1 - AY
										ColorpickerConfig.Callback(Colorpicker.Value, AlphaValue)
									end)
								end
							end)
							
							AddConnection(AlphaFrame.InputEnded, function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
									if AlphaInput then AlphaInput:Disconnect() end
								end
							end)
						
							function Colorpicker:Set(Value, Alpha)
								if getgenv().Destroy then return end
								if typeof(Value) == "Color3" then
									Colorpicker.Value = Value
									local h, s, v = Color3.toHSV(Value)
									ColorH, ColorS, ColorV = h, s, v
									ColorSelection.Position = UDim2.new(ColorS, 0, 1 - ColorV, 0)
									HueSelection.Position = UDim2.new(0.5, 0, 1 - ColorH, 0)
									UpdateColorPicker(true)
								end
								if Alpha then
									AlphaValue = Alpha
									AlphaSelection.Position = UDim2.new(0.5, 0, 1 - AlphaValue, 0)
									ColorpickerConfig.Callback(Colorpicker.Value, AlphaValue)
								end
							end
						
							Colorpicker:Set(Colorpicker.Value, AlphaValue)
							if ColorpickerConfig.Flag then OrionLib.Flags[ColorpickerConfig.Flag] = Colorpicker end
							return Colorpicker
						end
							return ElementFunction   
						end	
						
						local ElementFunction = {}
						function ElementFunction:AddSection(SectionConfig)
							SectionConfig.Name = SectionConfig.Name or "Section"
							SectionConfig.Flag = SectionConfig.Flag or nil
							local Section = {Type = "Section"}
				
							local SectionFrame = SetChildren(SetProps(MakeElement("TFrame"), {
								Size = UDim2.new(1, 0, 0, 26),
								Parent = Container
							}), {
								AddThemeObject(SetProps(MakeElement("Label", SectionConfig.Name, 14), {
									Size = UDim2.new(1, -12, 0, 16),
									Position = UDim2.new(0, 0, 0, 3),
									Font = Enum.Font.GothamSemibold
								}), "TextDark"),
								SetChildren(SetProps(MakeElement("TFrame"), {
									AnchorPoint = Vector2.new(0, 0),
									Size = UDim2.new(1, 0, 1, -24),
									Position = UDim2.new(0, 0, 0, 23),
									Name = "Holder"
								}), {
									MakeElement("List", 0, 6)
								}),
							})
							
							function Section:Set(ToChange)
								if getgenv().Destroy then return end
								if SectionFrame and SectionFrame:FindFirstChildOfClass("TextLabel") then
									SectionFrame:FindFirstChildOfClass("TextLabel").Text = ToChange
								end
							end
							
							function Section:SetTextSize(ToChange: number)
								if getgenv().Destroy then return end
								if SectionFrame and SectionFrame:FindFirstChildOfClass("TextLabel") then
									SectionFrame:FindFirstChildOfClass("TextLabel").TextSize = ToChange
								end
							end
				
							AddConnection(SectionFrame.Holder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
								SectionFrame.Size = UDim2.new(1, 0, 0, SectionFrame.Holder.UIListLayout.AbsoluteContentSize.Y + 31)
								SectionFrame.Holder.Size = UDim2.new(1, 0, 0, SectionFrame.Holder.UIListLayout.AbsoluteContentSize.Y)
							end)
				
							local SectionFunction = {}
							for i, v in next, GetElements(SectionFrame.Holder) do
								SectionFunction[i] = v 
							end
							
							if SectionConfig.Flag then
								OrionLib.Flags[SectionConfig.Flag] = Section
							end
							return Section
						end	
				
						for i, v in next, GetElements(Container) do
							ElementFunction[i] = v 
						end
				
						if TabConfig.PremiumOnly then
							for i, v in next, ElementFunction do
								ElementFunction[i] = function() end
							end    
							Container:FindFirstChild("UIListLayout"):Destroy()
							Container:FindFirstChild("UIPadding"):Destroy()
							SetChildren(SetProps(MakeElement("TFrame"), {
								Size = UDim2.new(1, 0, 1, 0),
								Parent = ItemParent
							}), {
								AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://3610239960"), {
									Size = UDim2.new(0, 18, 0, 18),
									Position = UDim2.new(0, 15, 0, 15),
									ImageTransparency = 0.4
								}), "Text"),
								AddThemeObject(SetProps(MakeElement("Label", "Unauthorised Access", 14), {
									Size = UDim2.new(1, -38, 0, 14),
									Position = UDim2.new(0, 38, 0, 18),
									TextTransparency = 0.4
								}), "Text"),
								AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://4483345875"), {
									Size = UDim2.new(0, 56, 0, 56),
									Position = UDim2.new(0, 84, 0, 110),
								}), "Text"),
								AddThemeObject(SetProps(MakeElement("Label", "Premium Features", 14), {
									Size = UDim2.new(1, -150, 0, 14),
									Position = UDim2.new(0, 150, 0, 112),
									Font = Enum.Font.GothamBold
								}), "Text"),
								AddThemeObject(SetProps(MakeElement("Label", "This part of the script is locked to Sirius Premium users. Purchase Premium in the Discord server (discord.gg/sirius)", 12), {
									Size = UDim2.new(1, -200, 0, 14),
									Position = UDim2.new(0, 150, 0, 138),
									TextWrapped = true,
									TextTransparency = 0.4
								}), "Text")
							})
						end
						return ElementFunction, Tabs
					end  
					
        function Functions:Destroy()
                for _, Connection in next, OrionLib.Connections do
                        Connection:Disconnect()
                end
                MainWindow:Destroy()
                MobileIcon:Destroy()
        end        
        return Functions
end   

function OrionLib:BuildSettings(Tab: table)
    Tab:AddToggle({
		Name = "Toggle Keybind",
		Default = false,
		Callback = function(Value)
			OrionLib:SetKeyBindVisible(Value)
		end    
	})
    
    Tab:AddSlider({
        Name = "Notify Volume",
        Min = 0,
        Max = 10,
        Increment = 0.5,
        Value = OrionLib.NotifyVolume,
        Color = Color3.fromRGB(255,255,255),
        ValueName = "Volume",
        Callback = function(value)
            OrionLib.NotifyVolume = value
        end
    })

    Tab:AddButton({
        Name = "Destroy Orion",
        Callback = function()
            OrionLib:Destroy()
        end
    })
    
    local configName = Tab:AddTextbox({
        Name = "Config Name"
    })

    local configList = Tab:AddDropdown({
        Name = "Configs List",
        Options = GetSavedConfigs()
    })

    Tab:AddDivider()
    Tab:AddButton({
        Name = "Create Config",
        Callback = function()
            local name = configName.Value
            if name:gsub(" ", "") == "" then return  end
            local success, error = SaveConfig(name)
            if success then
	            OrionLib:MakeNotification({Name = "[Save Config]", Content = string.format("Created config: %s", name), Time = 5})
            else
                OrionLib:MakeNotification({Name = "[Save Config]", Content = string.format("Failed to create config: %s", name), Time = 5})
            end            
            configList:Refresh(GetSavedConfigs(), true)
        end
    })

    Tab:AddButton({
        Name = "Load Config",
        Callback = function()
            local name = configList.Value
            if not name then return OrionLib:MakeNotification({Name = "[Save Config]", Content = "Select a config to load", Time = 5}) end
            local success, error = LoadConfig(name)
            if success then
	            OrionLib:MakeNotification({Name = "[Save Config]", Content = string.format("Loaded config: %s", name), Time = 5})
            else
                OrionLib:MakeNotification({Name = "[Save Config]", Content = string.format("Failed to load config: %s\nError: %s", name, error), Time = 5})
            end
        end
    })

    Tab:AddButton({
        Name = "Overwrite Config",
        DoubleClick = true,
        Callback = function()
            local name = configList.Value
            if not name then return OrionLib:MakeNotification({Name = "[Save Config]", Content = "Select a config to load", Time = 5}) end
            local success, error = SaveConfig(name)
            if success then
	            OrionLib:MakeNotification({Name = "[Save Config]", Content = string.format("Overwrote config: %s", name), Time = 5})
            else
                OrionLib:MakeNotification({Name = "[Save Config]", Content = string.format("Failed to overwrite config: %s", name), Time = 5})
            end
        end
    })

    Tab:AddButton({
        Name = "Set as Autoload",
        Callback = function()
            local name = configList.Value
            if not name then return OrionLib:MakeNotification({Name = "[Save Config]", Content = "Select a config to autoload", Time = 5}) end
            OrionLib:SetAutoloadConfig(name)
            OrionLib:MakeNotification({Name = "[Save Config]", Content = string.format('Set "%s" to autoload', name), Time = 5})
        end
    })
    
    Tab:AddButton({
        Name = "Set as Unautoload",
        Callback = function()
            local name = configList.Value
            if not name then return OrionLib:MakeNotification({Name = "[Save Config]", Content = "Select a config to Unautoload", Time = 5}) end
            OrionLib:SetUnAutoloadConfig(name)
            OrionLib:MakeNotification({Name = "[Save Config]", Content = string.format('Set "%s" to Unautoload', name), Time = 5})
        end
    })

    Tab:AddButton({
        Name = "Refresh List",
        Callback = function()
            configList:Refresh(GetSavedConfigs(), true)
        end
    })
end

function OrionLib:Destroy()
	for _, fn in next, OrionLib.OnDestroyTo do
		pcall(fn)
	end
	for _, conn in next, OrionLib.Connections do
		if typeof(conn) == "RBXScriptConnection" then
			conn:Disconnect()
		end
	end
	if Orion then
		Orion:Destroy()
	end
	getgenv().Destroy = true
end

function OrionLib:OnDestroy(fn)
	if type(fn) == "function" then
		table.insert(OrionLib.OnDestroyTo, fn)
	end
end

return OrionLib