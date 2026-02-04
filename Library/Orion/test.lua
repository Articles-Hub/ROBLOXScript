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
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = cloneref(LocalPlayer:GetMouse())

local PARENT = (gethui and gethui()) or cloneref(game:GetService("CoreGui"))

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
        SelectedTheme = "Default",
        Folder = "",
        SaveCfg = false
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

local function MakeDraggable(DragPoint, Main)
        pcall(function()
                local Dragging, DragInput, MousePos, FramePos = false
                AddConnection(DragPoint.InputBegan, function(Input)
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                                Dragging = true
                                MousePos = Input.Position
                                FramePos = Main.Position

                                Input.Changed:Connect(function()
                                        if Input.UserInputState == Enum.UserInputState.End then
                                                Dragging = false
                                        end
                                end)
                        end
                end)
                AddConnection(DragPoint.InputChanged, function(Input)
                        if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                                DragInput = Input
                        end
                end)
                AddConnection(UserInputService.InputChanged, function(Input)
                        if Input == DragInput and Dragging then
                                local Delta = Input.Position - MousePos
                                TweenService:Create(Main, TweenInfo.new(0.05, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position  = UDim2.new(FramePos.X.Scale,FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)}):Play()
                                Main.Position = UDim2.new(FramePos.X.Scale,FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)
                        end
                end)
        end)
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
        Total.AddThemeObject += 1;
        table.insert(OrionLib.ThemeObjects[Type], Object)
        Object[ReturnProperty(Object)] = OrionLib.Themes[OrionLib.SelectedTheme][Type]
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

local function LoadCfg(Config)
        if isfile and isfile(Config) then
			local ok, decoded = pcall(function()
				return HttpService:JSONDecode(readfile(Config))
			end)
			if ok and typeof(decoded) == "table" then
				Data = decoded
			end
		end
        table.foreach(Data, function(a,b)
                if OrionLib.Flags[a] then
                        spawn(function() 
                                if OrionLib.Flags[a].Type == "Colorpicker" then
                                        OrionLib.Flags[a]:Set(UnpackColor(b))
                                else
                                        OrionLib.Flags[a]:Set(b)
                                end    
                        end)
                else
                        warn("Orion Library Config Loader - Could not find ", a ,b)
                end
        end)
end

local function SaveCfg()
        local Data = {}
        for i,v in pairs(OrionLib.Flags) do
                if v.Save then
                        if v.Type == "Colorpicker" then
                                Data[i] = PackColor(v.Value)
                        else
                                Data[i] = v.Value
                        end
                end        
        end
    pcall(function()
        writefile(OrionLib.Folder .. "/" .. game.GameId .. ".json", HttpService:JSONEncode(Data))
	end)
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
		NotificationConfig.Volume = NotificationConfig.Volume or 1
		
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
				s.Volume = tonumber(NotificationConfig.Volume)
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

function OrionLib:Init()
        if OrionLib.SaveCfg and (isfile and readfile) then        
                pcall(function()
                        if isfile(OrionLib.Folder .. "/" .. game.GameId .. ".json") then
                                LoadCfg(OrionLib.Folder .. "/" .. game.GameId .. ".json")
                                OrionLib:MakeNotification({
                                        Name = "Configuration",
                                        Content = "Auto-loaded configuration for the game " .. game.GameId .. ".",
                                        Time = 5
                                })
                        end
                end)                
        end        
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
        OrionLib.Folder = WindowConfig.ConfigFolder
        OrionLib.SaveCfg = WindowConfig.SaveConfig

        if WindowConfig.SaveConfig then
                if (isfolder and makefolder) and not isfolder(WindowConfig.ConfigFolder) then
                        makefolder(WindowConfig.ConfigFolder)
                end        
        end

        local TabHolder = AddThemeObject(SetChildren(SetProps(MakeElement("ScrollFrame", Color3.fromRGB(255, 255, 255), 4),
                WindowConfig.SearchBar and WindowConfig.SearchBar.Tabs == true and {
                        Size = UDim2.new(1, 0, 1, -90),
                        Position = UDim2.new(0, 0, 0, 40)
                } or {
                        Size = UDim2.new(1, 0, 1, -50)
                }),
                {
                        MakeElement("List"),
                        MakeElement("Padding", 8, 0, 0, 8)
                }), "Divider")

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
                        Size = UDim2.new(0, 18, 0, 18)
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

        local WindowStuff = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 10), {
                Size = UDim2.new(0, 150, 1, -50),
                Position = UDim2.new(0, 0, 0, 50)
        }), {
                AddThemeObject(SetProps(MakeElement("Frame"), {
                        Size = UDim2.new(1, 0, 0, 10),
                        Position = UDim2.new(0, 0, 0, 0)
                }), "Second"), 
                AddThemeObject(SetProps(MakeElement("Frame"), {
                        Size = UDim2.new(0, 10, 1, 0),
                        Position = UDim2.new(1, -10, 0, 0)
                }), "Second"), 
                AddThemeObject(SetProps(MakeElement("Frame"), {
                        Size = UDim2.new(0, 1, 1, 0),
                        Position = UDim2.new(1, -1, 0, 0)
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
                                SetProps(MakeElement("Image", "https://www.roblox.com/headshot-thumbnail/image?userId=".. LocalPlayer.UserId .."&width=420&height=420&format=png"), {
                                        Size = UDim2.new(1, 0, 1, 0)
                                }),
                                AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://4031889928"), {
                                        Size = UDim2.new(1, 0, 1, 0),
                                }), "Second"),
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

        local WindowName = AddThemeObject(SetProps(MakeElement("Label", WindowConfig.Name, 14), {
                Size = UDim2.new(1, -30, 2, 0),
                Position = UDim2.new(0, 25, 0, -24),
                Font = Enum.Font.GothamBlack,
                TextSize = 20
        }), "Text")

        local WindowTopBarLine = AddThemeObject(SetProps(MakeElement("Frame"), {
                Size = UDim2.new(1, 0, 0, 1),
                Position = UDim2.new(0, 0, 1, -1)
        }), "Stroke")

        local MainWindow = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 10), {
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
                                Position = UDim2.new(1, -90, 0, 10)
                        }), {
                                AddThemeObject(MakeElement("Stroke"), "Stroke"),
                                AddThemeObject(SetProps(MakeElement("Frame"), {
                                        Size = UDim2.new(0, 1, 1, 0),
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
			
			local LoadSequenceLogo = SetProps(MakeElement("Image", "rbxassetid://"..WindowConfig.IntroIcon:match("%d+")), {
				Parent = BaseFrame,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0.4, 0),
				Size = UDim2.new(0, 0, 0, 0),
				ImageColor3 = Color3.fromRGB(255, 255, 255),
				ImageTransparency = 1,
				Rotation = -180,
				ZIndex = 101
			})
			
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
		
				AddThemeObject(SetProps(MakeElement("Label", TabConfig.Name, 14), {
					Size = UDim2.new(1, -35, 1, 0),
					Position = UDim2.new(0, 35, 0, 0),
					Font = Enum.Font.GothamSemibold,
					TextTransparency = TabConfig.Disabled and 0.7 or 0.4,
					Name = "Title"
				}), "Text")
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
                        function ElementFunction:AddLabel(Text)
                                local LabelFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
                                        Size = UDim2.new(1, 0, 0, 30),
                                        BackgroundTransparency = 0.7,
                                        Parent = ItemParent
                                }), {
                                        AddThemeObject(SetProps(MakeElement("Label", Text, 15), {
                                                Size = UDim2.new(1, -12, 1, 0),
                                                Position = UDim2.new(0, 8, 0, 0),
                                                Font = Enum.Font.GothamBold,
                                                TextWrapped = true,
                                                Name = "Content"
                                        }), "Text"),
                                        AddThemeObject(MakeElement("Stroke"), "Stroke")
                                }), "Second")
                                
                                AddConnection(LabelFrame.Content:GetPropertyChangedSignal("Text"), function()
	                                if LabelFrame then
                                        LabelFrame.Size = UDim2.new(1, 0, 0, LabelFrame.Content.TextBounds.Y + 25)
                                    end
                                end)

                                local LabelFunction = {}
                                function LabelFunction:Set(ToChange)
	                                if getgenv().Destroy then return end
	                                if LabelFrame and LabelFrame:FindFirstChild("Content") then
                                        LabelFrame.Content.Text = ToChange
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
                                ButtonConfig.Name = ButtonConfig.Name or "Button"
                                ButtonConfig.Callback = ButtonConfig.Callback or function() end
                                ButtonConfig.Icon = ButtonConfig.Icon or "rbxassetid://3944703587"
                                local Button = {}

                                local Click = SetProps(MakeElement("Button"), {
                                        Size = UDim2.new(1, 0, 1, 0)
                                })
                                
                                local ButtonFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
                                        Size = UDim2.new(1, 0, 0, 33),
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
                                        TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
                                end)

                                AddConnection(Click.MouseLeave, function()
                                        TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Second}):Play()
                                end)

                                AddConnection(Click.MouseButton1Up, function()
                                        TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
                                        spawn(function()
                                                Button:Click()
                                        end)
                                end)

                                AddConnection(Click.MouseButton1Down, function()
                                        TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 6)}):Play()
                                end)

                                function Button:Set(ButtonText)
	                                if getgenv().Destroy then return end
	                                if ButtonFrame and ButtonFrame:FindFirstChild("Content") then
                                        ButtonFrame.Content.Text = ButtonText
                                    end
                                end
                                
                                function Button:Click()
								    if ButtonConfig.Callback then
								        local success, err = pcall(ButtonConfig.Callback)
								        if not success then
								            OrionLib:MakeNotification({Name = "Error Script", Content = err, Time = 5})
								        end
								    end
								end
                                
                                function Button:SetCallback(callback)
	                                if getgenv().Destroy then return end
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
							ImageConfig.Padding = ImageConfig.Padding or 8
						
							local Image = {Default = ImageConfig.Icon, Size = ImageConfig.Size, Type = "Image"}
						
							local function FrameHeight(iconSize)
								return iconSize + ImageConfig.Padding * 2
							end
						
							local ImageFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
									Name = ImageConfig.Name,
									Size = UDim2.new(1, 0, 0, FrameHeight(ImageConfig.Size)),
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
							ToggleConfig.Type = ToggleConfig.Type or "CheckBox"
							ToggleConfig.Flag = ToggleConfig.Flag or nil
							ToggleConfig.Save = ToggleConfig.Save or false
						
							local Toggle = {
								Value = ToggleConfig.Default,
								Save = ToggleConfig.Save,
								Type = ToggleConfig.Type,
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
											SaveCfg()
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
								if getgenv().Destroy then return end
								Toggle.Value = Value
								UpdateTweenKeyBindToggles(ToggleFrame, Toggle.Value)
								local ok, err = pcall(function()
									ToggleConfig.Callback(Toggle.Value)
								end)
								if not ok then
									OrionLib:MakeNotification({Name = "Error Script", Content = err, Time = 5})
								end
							end
							
							if ToggleConfig.Default == true then
								Toggle:Set(true)
							end
							
							AddConnection(Click.MouseButton1Up, function()
								SaveCfg()
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
									
								function CheckBindTo()
									return ToggleFrame and ToggleFrame:FindFirstChild("Frame") and ToggleFrame.Frame:FindFirstChild("Value") and true or false
								end
						
								AddConnection(BindBox.Value:GetPropertyChangedSignal("Text"), function()
									local width = BindBox.Value.TextBounds.X + 20
									TweenService:Create(BindBox, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {Size = UDim2.new(0, width, 0, 24)}):Play()
									TweenService:Create(Click, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {Size = UDim2.new(0, width, 0, 24)}):Play()
								end)
						
								AddConnection(Click.InputEnded, function(Input)
									if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
										if Bind.Binding then return end
										Bind.Binding = true
										BindBox.Value.Text = "..."
									end
								end)
						
								AddConnection(UserInputService.InputBegan, function(Input, gp)
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
									if getgenv().Destroy then return end
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
							SliderConfig.Min = SliderConfig.Min or 0
							SliderConfig.Max = SliderConfig.Max or 100
							SliderConfig.Increment = SliderConfig.Increment or 1
							SliderConfig.Default = SliderConfig.Default or 50
							SliderConfig.Callback = SliderConfig.Callback or function() end
							SliderConfig.ValueName = SliderConfig.ValueName or ""
							SliderConfig.Color = SliderConfig.Color or Color3.fromRGB(9, 149, 98)
							SliderConfig.Flag = SliderConfig.Flag or nil
							SliderConfig.Save = SliderConfig.Save or false
							
							local Slider = {Value = SliderConfig.Default, Save = SliderConfig.Save}  
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
								if Dragging then   
									local SizeScale = math.clamp((Input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)  
									Slider:Set(SliderConfig.Min + ((SliderConfig.Max - SliderConfig.Min) * SizeScale))   
									SaveCfg(game.GameId)  
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
								SaveCfg()
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
	local TweenService = game:GetService("TweenService")
	
	DropdownConfig = DropdownConfig or {}
	DropdownConfig.Name = DropdownConfig.Name or "Dropdown"
	DropdownConfig.Options = DropdownConfig.Options or {}
	DropdownConfig.Multi = DropdownConfig.Multi or false
	DropdownConfig.Default = DropdownConfig.Default or (DropdownConfig.Multi and {} or nil)
	DropdownConfig.Callback = DropdownConfig.Callback or function() end
	DropdownConfig.Flag = DropdownConfig.Flag or nil
	DropdownConfig.Save = DropdownConfig.Save or false
	DropdownConfig.Type = DropdownConfig.Type or "Normal"

	local Dropdown = {
		Value = DropdownConfig.Default,
		Options = {},
		RawOptions = DropdownConfig.Options,
		Buttons = {},
		Toggled = false,
		Type = DropdownConfig.Type,
		Save = DropdownConfig.Save
	}

	local function GetKeyList(tbl)
		local keys = {}
		for k, v in pairs(tbl) do
			if not (type(v) == "table" and v.Diviner) then
				if type(k) == "string" then
					table.insert(keys, k)
				else
					if type(v) ~= "table" then
						table.insert(keys, v)
					end
				end
			end
		end
		return keys
	end

	Dropdown.Options = GetKeyList(DropdownConfig.Options)

	if DropdownConfig.Multi then
		if type(Dropdown.Value) ~= "table" then Dropdown.Value = {} end
	else
		if Dropdown.Value ~= nil and not table.find(Dropdown.Options, Dropdown.Value) then
			Dropdown.Value = nil
		end
	end

	local DropdownList = MakeElement("List")
	DropdownList.Padding = UDim.new(0, 6)

	local DropdownContainer = AddThemeObject(SetProps(SetChildren(
		MakeElement("ScrollFrame", Color3.fromRGB(40, 40, 40), 4),
		{DropdownList}
	), {
		Parent = ItemParent,
		Position = UDim2.new(0, 0, 0, 45),
		Size = UDim2.new(1, 0, 1, -45),
		ClipsDescendants = true,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		ScrollBarThickness = 2,
		ScrollBarImageTransparency = 1
	}), "Divider")

	local Click = SetProps(MakeElement("Button"), {
		Size = UDim2.new(1, 0, 1, 0),
		ZIndex = 2
	})

	local DropdownFrame = AddThemeObject(SetChildren(SetProps(
		MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 6),
		{
			Size = UDim2.new(1, 0, 0, 42),
			Parent = ItemParent,
			ClipsDescendants = true
		}
	), {
		DropdownContainer,
		SetProps(SetChildren(MakeElement("TFrame"), {
			AddThemeObject(SetProps(MakeElement("Label", DropdownConfig.Name, 14), {
				Size = UDim2.new(1, -12, 0, 42),
				Position = UDim2.new(0, 12, 0, 0),
				Font = Enum.Font.GothamBold,
				Name = "Content",
				TextXAlignment = Enum.TextXAlignment.Left
			}), "Text"),

			AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072706796"), {
				Size = UDim2.new(0, 20, 0, 20),
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.new(1, -30, 0, 21),
				ImageColor3 = Color3.fromRGB(240, 240, 240),
				Name = "Ico"
			}), "TextDark"),

			AddThemeObject(SetProps(MakeElement("Label", "...", 13), {
				Size = UDim2.new(1, -60, 0, 42),
				Position = UDim2.new(0, 0, 0, 0),
				Font = Enum.Font.Gotham,
				Name = "Selected",
				TextXAlignment = Enum.TextXAlignment.Right
			}), "TextDark"),
			
			SetProps(MakeElement("Image", ""), {
				Size = UDim2.new(0, 24, 0, 24),
				Position = UDim2.new(1, -65, 0, 9),
				Name = "PreviewIcon",
				Visible = false,
				ImageTransparency = 0.2
			}),

			Click
		}), {
			Size = UDim2.new(1, 0, 0, 42),
			ClipsDescendants = true,
			Name = "F"
		}),
		AddThemeObject(MakeElement("Stroke"), "Stroke"),
		MakeElement("Corner")
	}), "Second")

	AddConnection(DropdownList:GetPropertyChangedSignal("AbsoluteContentSize"), function()
		DropdownContainer.CanvasSize = UDim2.new(0, 0, 0, DropdownList.AbsoluteContentSize.Y + 12)
	end)

	local function AddOptions(Options)
		for k, v in pairs(Options) do
			local OptionVal = k
			if type(k) == "number" then OptionVal = v end
			
			if type(OptionVal) == "table" then
				OptionVal = OptionVal.Value or OptionVal.Name or "Option " .. tostring(k)
			end

			local Data = (type(v) == "table" and v) or {}
			local HasData = (type(v) == "table")
			
			if HasData and Data.Diviner then
				local TitleStr = Data.Title or Data.Value or OptionVal
				local DividerHeight = 30
				local DivFrame = SetProps(MakeElement("Frame"), {
					Parent = DropdownContainer,
					Size = UDim2.new(1, -4, 0, DividerHeight),
					Name = "div_" .. tostring(OptionVal),
					BackgroundTransparency = 1,
					ClipsDescendants = true
				})
				local lbl = SetProps(MakeElement("Label", tostring(TitleStr), 12), {
					Parent = DivFrame,
					Size = UDim2.new(0, 140, 0, 18),
					Position = UDim2.new(0.5, 0, 0, 6),
					AnchorPoint = Vector2.new(0.5, 0),
					Font = Enum.Font.GothamBold,
					TextXAlignment = Enum.TextXAlignment.Center
				})
				AddThemeObject(lbl, "TextDark")
				SetProps(MakeElement("Frame", Color3.fromRGB(120,120,120)), {
					Parent = DivFrame,
					Size = UDim2.new(0.5, -90, 0, 1),
					Position = UDim2.new(0, 12, 0, DividerHeight/2),
				})
				SetProps(MakeElement("Frame", Color3.fromRGB(120,120,120)), {
					Parent = DivFrame,
					Size = UDim2.new(0.5, -90, 0, 1),
					Position = UDim2.new(1, -12 - (lbl.Size.X.Offset / 2), 0, DividerHeight/2),
				})
			else
				local TitleStr = HasData and (Data.Title or Data.Value or OptionVal) or OptionVal
				local DescStr = HasData and (Data.Desc or Data.Description or nil) or nil
				local IconStr = HasData and (Data.Icon or nil) or nil
				local ThumbStr = HasData and (Data.Thumbnail or nil) or nil
				
				local Type = DropdownConfig.Type
				local ButtonHeight = 36
				
				if Type == "Card" then
					ButtonHeight = 130
					if not ThumbStr then ThumbStr = "rbxassetid://3033152795" end
				elseif Type == "Advanced" then
					ButtonHeight = 50
				elseif Type == "Icon" then
					ButtonHeight = 45
				end

				local ItemContainer = SetProps(MakeElement("Button", Color3.fromRGB(32, 32, 32)), {
					Parent = DropdownContainer,
					Size = UDim2.new(1, -4, 0, ButtonHeight),
					Name = tostring(OptionVal),
					ClipsDescendants = true
				})
				
				AddThemeObject(ItemContainer, "Second")
				MakeElement("Corner", 0, 6).Parent = ItemContainer
				local Stroke = MakeElement("Stroke")
				Stroke.Parent = ItemContainer
				
				if Type == "Card" then
					Stroke.Transparency = 0
					Stroke.Color = Color3.fromRGB(60, 60, 60)
					Stroke.Thickness = 1
				else
					Stroke.Transparency = 1
				end

				if Type == "Card" then
					local CardImage = SetProps(MakeElement("Image", ThumbStr), {
						Size = UDim2.new(1, 0, 1, 0),
						Parent = ItemContainer,
						ScaleType = Enum.ScaleType.Crop,
						ImageColor3 = Color3.fromRGB(200, 200, 200)
					})
					MakeElement("Corner", 0, 6).Parent = CardImage
					
					local Overlay = SetProps(MakeElement("Frame", Color3.fromRGB(20, 20, 20)), {
						Size = UDim2.new(1, 0, 0, 45),
						Position = UDim2.new(0, 0, 1, 0),
						AnchorPoint = Vector2.new(0, 1),
						Parent = ItemContainer,
						BackgroundTransparency = 0.2,
						ZIndex = 2
					})
					SetProps(MakeElement("Corner", 0, 6), {
						CornerRadius = UDim.new(0, 6)
					}).Parent = Overlay
					
					local TextX = 10
					if IconStr then
						SetProps(MakeElement("Image", IconStr), {
							Size = UDim2.new(0, 28, 0, 28),
							Position = UDim2.new(0, 8, 0.5, 0),
							AnchorPoint = Vector2.new(0, 0.5),
							Parent = Overlay,
							BackgroundTransparency = 1
						})
						TextX = 44
					end

					AddThemeObject(SetProps(MakeElement("Label", tostring(TitleStr), 13), {
						Parent = Overlay,
						Position = UDim2.new(0, TextX, 0, 6),
						Size = UDim2.new(1, -(TextX + 5), 0, 14),
						TextXAlignment = Enum.TextXAlignment.Left,
						Font = Enum.Font.GothamBold,
						ZIndex = 3
					}), "Text")
					
					AddThemeObject(SetProps(MakeElement("Label", tostring(DescStr or ""), 11), {
						Parent = Overlay,
						Position = UDim2.new(0, TextX, 0, 22),
						Size = UDim2.new(1, -(TextX + 5), 0, 14),
						TextXAlignment = Enum.TextXAlignment.Left,
						Font = Enum.Font.Gotham,
						TextColor3 = Color3.fromRGB(180, 180, 180),
						ZIndex = 3
					}), "Text")

				elseif Type == "Icon" or Type == "Advanced" then
					local TextX = 12
					
					if Type == "Icon" and IconStr then
						SetProps(MakeElement("Image", IconStr), {
							Size = UDim2.new(0, 24, 0, 24),
							Position = UDim2.new(0, 10, 0.5, 0),
							AnchorPoint = Vector2.new(0, 0.5),
							Parent = ItemContainer,
							ImageTransparency = 0.2
						})
						TextX = 42
					end
					
					local TitleY = (DescStr and 8 or 0)
					if Type == "Icon" and DescStr then TitleY = 8 elseif Type == "Icon" then TitleY = 11 end

					AddThemeObject(SetProps(MakeElement("Label", tostring(TitleStr), 13), {
						Parent = ItemContainer,
						Position = UDim2.new(0, TextX, 0, TitleY),
						Size = UDim2.new(1, -(TextX + 10), 0, 14),
						TextXAlignment = Enum.TextXAlignment.Left,
						Font = Enum.Font.GothamBold
					}), "Text")

					if DescStr then
						AddThemeObject(SetProps(MakeElement("Label", tostring(DescStr), 11), {
							Parent = ItemContainer,
							Position = UDim2.new(0, TextX, 0, TitleY + 16),
							Size = UDim2.new(1, -(TextX + 10), 0, 14),
							TextXAlignment = Enum.TextXAlignment.Left,
							Font = Enum.Font.Gotham,
							TextColor3 = Color3.fromRGB(160, 160, 160)
						}), "Text")
					end
				else
					AddThemeObject(SetProps(MakeElement("Label", tostring(TitleStr), 13), {
						Parent = ItemContainer,
						Position = UDim2.new(0, 12, 0, 0),
						Size = UDim2.new(1, -20, 1, 0),
						TextXAlignment = Enum.TextXAlignment.Left,
						Font = Enum.Font.GothamBold
					}), "Text")
				end

				AddConnection(ItemContainer.MouseButton1Click, function()
					Dropdown:Set(OptionVal)
					SaveCfg(game.GameId)
				end)

				Dropdown.Buttons[OptionVal] = ItemContainer
			end
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
		if getgenv().Destroy then return end
		
		local CurrentData = Dropdown.RawOptions[Value] or {}
		local IsTableData = (type(Dropdown.RawOptions[Value]) == "table")

		if DropdownConfig.Multi then
			local index = table.find(Dropdown.Value, Value)
			local btn = Dropdown.Buttons[Value]
			if index then
				table.remove(Dropdown.Value, index)
				if btn then
					TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(32, 32, 32)}):Play()
					if btn:FindFirstChild("Stroke") then 
						if DropdownConfig.Type == "Card" then
							TweenService:Create(btn.Stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(60, 60, 60)}):Play()
						else
							TweenService:Create(btn.Stroke, TweenInfo.new(0.2), {Transparency = 1}):Play()
						end
					end
				end
			else
				table.insert(Dropdown.Value, Value)
				if btn then
					TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}):Play()
					if btn:FindFirstChild("Stroke") then
						TweenService:Create(btn.Stroke, TweenInfo.new(0.2), {Transparency = 0, Color = Color3.fromRGB(200, 200, 200)}):Play()
					end
				end
			end
			
			local safeValues = {}
			for _, v in ipairs(Dropdown.Value) do
				table.insert(safeValues, tostring(v))
			end
			DropdownFrame.F.Selected.Text = (#safeValues == 0 and "...") or table.concat(safeValues, ", ")
			return DropdownConfig.Callback(Dropdown.Value)
		end

		if not table.find(Dropdown.Options, Value) then
			Dropdown.Value = nil
			DropdownFrame.F.Selected.Text = "None"
			DropdownFrame.F.PreviewIcon.Visible = false
			return
		end

		Dropdown.Value = Value

		local displayTitle = IsTableData and (CurrentData.Title or Value) or Value
		DropdownFrame.F.Selected.Text = tostring(displayTitle)
		
		local headerIcon = IsTableData and (CurrentData.Icon or CurrentData.Thumbnail) or nil
		if headerIcon then
			DropdownFrame.F.PreviewIcon.Image = headerIcon
			DropdownFrame.F.PreviewIcon.Visible = true
			DropdownFrame.F.Selected.Size = UDim2.new(1, -90, 0, 42)
		else
			DropdownFrame.F.PreviewIcon.Visible = false
			DropdownFrame.F.Selected.Size = UDim2.new(1, -60, 0, 42)
		end

		for val, v in pairs(Dropdown.Buttons) do
			if val ~= Value then
				TweenService:Create(v, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(32, 32, 32)}):Play()
				if v:FindFirstChild("Stroke") then 
					if DropdownConfig.Type == "Card" then
						TweenService:Create(v.Stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(60, 60, 60), Transparency = 0}):Play()
					else
						TweenService:Create(v.Stroke, TweenInfo.new(0.2), {Transparency = 1}):Play()
					end
				end
				if v:FindFirstChild("Label") then TweenService:Create(v.Label, TweenInfo.new(0.2), {TextTransparency = 0.4}):Play() end
			end
		end

		local selBtn = Dropdown.Buttons[Value]
		if selBtn then
			TweenService:Create(selBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
			if selBtn:FindFirstChild("Stroke") then TweenService:Create(selBtn.Stroke, TweenInfo.new(0.2), {Transparency = 0, Color = Color3.fromRGB(255, 255, 255)}):Play() end
			if selBtn:FindFirstChild("Label") then TweenService:Create(selBtn.Label, TweenInfo.new(0.2), {TextTransparency = 0}):Play() end
		end

		SaveCfg()
		return DropdownConfig.Callback(Dropdown.Value)
	end

	AddConnection(Click.MouseButton1Click, function()
		Dropdown.Toggled = not Dropdown.Toggled
		
		TweenService:Create(DropdownFrame.F.Ico, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = Dropdown.Toggled and 180 or 0}):Play()

		local currentContentSize = DropdownList.AbsoluteContentSize.Y
		local maxH = 280
		local expandSize = math.min(currentContentSize + 12, maxH)
		local sizeY = Dropdown.Toggled and (48 + expandSize) or 42

		TweenService:Create(DropdownFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			Size = UDim2.new(1, 0, 0, sizeY)
		}):Play()
		
		TweenService:Create(DropdownContainer, TweenInfo.new(0.25), {
			ScrollBarImageTransparency = Dropdown.Toggled and 0 or 1
		}):Play()
	end)

	Dropdown:Refresh(DropdownConfig.Options, false)
	if Dropdown.Value then Dropdown:Set(Dropdown.Value) end
	if DropdownConfig.Flag then OrionLib.Flags[DropdownConfig.Flag] = Dropdown end

	return Dropdown
end
                        function ElementFunction:AddBind(BindConfig)
                                BindConfig.Name = BindConfig.Name or "Bind"
                                BindConfig.Default = BindConfig.Default or Enum.KeyCode.Unknown
                                BindConfig.Hold = BindConfig.Hold or false
                                BindConfig.Callback = BindConfig.Callback or function() end
                                BindConfig.Flag = BindConfig.Flag or nil
                                BindConfig.Save = BindConfig.Save or false

                                local Bind = {Value, Binding = false, Type = "Bind", Save = BindConfig.Save}
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
                                        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                                                if Bind.Binding then return end
                                                Bind.Binding = true
                                                BindBox.Value.Text = ""
                                        end
                                end)

                                AddConnection(UserInputService.InputBegan, function(Input)
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
                                                SaveCfg(game.GameId)
                                        end
                                end)

                                AddConnection(UserInputService.InputEnded, function(Input)
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
		                                if getgenv().Destroy then return end
                                        Bind.Binding = false
                                        Bind.Value = Key or Bind.Value
                                        Bind.Value = Bind.Value.Name or Bind.Value
                                        BindBox.Value.Text = Bind.Value
                                        SaveCfg()
                                end
                                
                                function Bind:SetText(ToChange)
	                                if getgenv().Destroy then return end
	                                if BindFrame and BindFrame:FindFirstChild("Content") then
										BindFrame.Content.Text = ToChange
									end
                                end
                                
                                function Bind:SetCallback(ToChange)
	                                if getgenv().Destroy then return end
	                                BindConfig.Callback = ToChange
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
                                
                                local Textbox = {Value = TextboxConfig.Default, Type = "Input", Save = TextboxConfig.Save}

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
                                                Name = "Content"
                                        }), "Text"),
                                        AddThemeObject(MakeElement("Stroke"), "Stroke"),
                                        TextContainer,
                                        Click
                                }), "Second")
                                
                                local function SetValue()
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
	                                if getgenv().Destroy then return end
	                                if TextboxActual then
										TextboxActual.Text = ToChange
										if TextboxConfig.Finished == false then
											SetValue()
										end
									end
                                end
                                
                                function Textbox:SetLabel(ToChange)
	                                if getgenv().Destroy then return end
	                                if TextboxFrame and TextboxFrame:FindFirstChild("Content") then
										TextboxFrame.Content.Text = ToChange
									end
                                end
                                
                                function Textbox:SetCallback(ToChange)
	                                if getgenv().Destroy then return end
	                                TextboxConfig.Callback = ToChange
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
								SaveCfg(game.GameId)
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
									SaveCfg()
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
