local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local HttpService = game:GetService("HttpService")

local PARENT = (gethui and gethui()) or game:GetService('CoreGui')

OrionLib = {
    Elements = {},
    ThemeObjects = {},
    Connections = {},
    Flags = {},
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
    Folder = nil,
    SaveCfg = false
}

local Icons = {}

local Success, Response = pcall(function()
    Icons = HttpService:JSONDecode(game:HttpGet("https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/Library/Orion/icons.json")).icons
end)

if not Success then
    warn("\nOrion Library - Failed to load Feather Icons. Error code: " .. Response .. "\n")
end

local function GetIcon(IconName)
    if Icons[IconName] ~= nil then
        return Icons[IconName]
    else
        return nil
    end
end

Orion = Instance.new("ScreenGui")
Orion.Name = "Orion"
Orion.Parent = PARENT
Orion.ResetOnSpawn = false

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

OrionLib:SetFont("GothamBold")

function OrionLib:IsRunning()
    return Orion.Parent == PARENT
end

local function AddConnection(Signal, Function)
    if (not OrionLib:IsRunning()) then
        return
    end
    local SignalConnect = Signal:Connect(Function)
    table.insert(OrionLib.Connections, SignalConnect)
    return SignalConnect
end

task.spawn(function()
    while (OrionLib:IsRunning()) do
        task.wait()
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
                TweenService:Create(Main, TweenInfo.new(0.05, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position  = UDim2.new(FramePos.X.Scale,FramePos.X.Offset + Delta.X, FramePos.Y.Scale,FramePos.Y.Offset + Delta.Y)}):Play()
                Main.Position  = UDim2.new(FramePos.X.Scale,FramePos.X.Offset + Delta.X, FramePos.Y.Scale,FramePos.Y.Offset + Delta.Y)
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
    local Result = math.floor(Number/Factor + (math.sign(Number) * 0.5)) * Factor
    if Result < 0 then Result = Result + Factor end
    return Result
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
    local Data = HttpService:JSONDecode(Config)
    table.foreach(Data, function(a,b)
        if OrionLib.Flags[a] then
            task.spawn(function() 
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

local function SaveCfg(Name)
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
            Str = Str:gsub("%[Highlight:['\"](.-)['\"]%]", '<font color="#f5f5f5"><b>%1</b></font>')
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
        
        local Out = TweenService:Create(Card, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(1, 30, 0, 0)})
        Out:Play()
        Out.Completed:Wait()
        NotificationParent:Destroy()
    end)
end

function OrionLib:Init()
    if OrionLib.SaveCfg and (isfile and readfile) then        
        pcall(function()
            if isfile(OrionLib.Folder .. "/" .. game.GameId .. ".txt") then
                LoadCfg(readfile(OrionLib.Folder .. "/" .. game.GameId .. ".txt"))
                OrionLib:MakeNotification({
                    Name = "Configuration",
                    Content = "Auto-loaded configuration for the game " .. game.GameId .. ".",
                    Time = 5
                })
            end
        end)                
    end        
end        

function OrionLib:MakeWindow(WindowConfig)
    local FirstTab = true
    local Minimized = false
    local Loaded = false
    local UIHidden = false
    local TabButtons = {}

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
        WindowConfig.SearchBar and {
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

    if WindowConfig.SearchBar then
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

            for i,v in pairs(TabButtons) do
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
        MobileReopenButton.Visible = false
    end)

    AddConnection(CloseBtn.MouseButton1Up, function()
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
            MainWindow.Visible = not MainWindow.Visible
        end
    end)

    AddConnection(MinimizeBtn.MouseButton1Up, function()
        if Minimized then
            TweenService:Create(MainWindow, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 615, 0, 344)}):Play()
            MinimizeBtn.Ico.Image = "rbxassetid://7072719338"
            task.wait(.02)
            MainWindow.ClipsDescendants = false
            WindowStuff.Visible = true
            WindowTopBarLine.Visible = true
        else
            MainWindow.ClipsDescendants = true
            WindowTopBarLine.Visible = false
            MinimizeBtn.Ico.Image = "rbxassetid://7072720870"

            TweenService:Create(MainWindow, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, WindowName.TextBounds.X + 140, 0, 50)}):Play()
            task.wait(0.1)
            WindowStuff.Visible = false        
        end
        Minimized = not Minimized    
    end)

    local function LoadSequence()
        MainWindow.Visible = false
        local Lighting = game:GetService("Lighting")
        
        local Blur = Instance.new("BlurEffect")
        Blur.Name = "IntroBlur"
        Blur.Size = 0
        Blur.Parent = Lighting

        local BaseFrame = SetProps(MakeElement("Frame"), {
            Parent = Orion,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            ZIndex = 999
        })
        
        local LoadSequenceLogo = SetProps(MakeElement("Image", WindowConfig.IntroIcon), {
            Parent = BaseFrame,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.45, 0),
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

        task.wait(1.8)

        TweenService:Create(LoadSequenceText, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            TextTransparency = 1,
            Position = UDim2.new(0.5, 0, 0.55, 0)
        }):Play()
        
        task.wait(0.1)

        TweenService:Create(LoadSequenceLogo, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0), 
            Rotation = 45
        }):Play()
        
        TweenService:Create(LoadSequenceGlow, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
        
        TweenService:Create(Blur, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = 0}):Play()

        task.wait(0.5)
        
        MainWindow.Visible = true
        Blur:Destroy()
        BaseFrame:Destroy()
    end 

    if WindowConfig.IntroEnabled then
        LoadSequence()
    end

    local function GetElements(ItemParent)
        local ElementFunction = {}

        local function AddTooltip(Obj, Text)
            local Tooltip = MakeElement("RoundFrame", Color3.fromRGB(20,20,20), 0, 5)
            Tooltip.Size = UDim2.new(0, 0, 0, 0)
            Tooltip.Position = UDim2.new(0.5, 0, 0, -10)
            Tooltip.AnchorPoint = Vector2.new(0.5, 1)
            Tooltip.Parent = Obj
            Tooltip.ZIndex = 10
            Tooltip.Visible = false

            local TooltipText = MakeElement("Label", Text, 14)
            TooltipText.Parent = Tooltip
            TooltipText.Size = UDim2.new(1, -10, 1, -6)
            TooltipText.Position = UDim2.new(0, 5, 0, 3)
            TooltipText.BackgroundTransparency = 1
            TooltipText.TextWrapped = true
            
            AddConnection(Obj.MouseEnter, function()
                Tooltip.Visible = true
                TweenService:Create(Tooltip, TweenInfo.new(0.2), {Size = UDim2.new(0, TooltipText.TextBounds.X + 20, 0, TooltipText.TextBounds.Y + 10)}):Play()
            end)
            AddConnection(Obj.MouseLeave, function()
                TweenService:Create(Tooltip, TweenInfo.new(0.2), {Size = UDim2.new(0, 0, 0, 0)}):Play()
                task.wait(0.2)
                Tooltip.Visible = false
            end)
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
            
            AddConnection(LabelFrame.Content:GetPropertyChangedSignal("TextBounds"), function()
                if LabelFrame then
                    LabelFrame.Size = UDim2.new(1, 0, 0, LabelFrame.Content.TextBounds.Y + 25)
                end
            end)

            local LabelFunction = {}
            function LabelFunction:Set(ToChange)
                if LabelFrame and LabelFrame:FindFirstChild("Content") then
                    LabelFrame.Content.Text = ToChange
                end
            end
            return LabelFunction
        end

        function ElementFunction:AddParagraph(ParagraphConfig)
            local CurrentTheme = OrionLib.Themes[OrionLib.SelectedTheme] or OrionLib.Themes.Default
            
            local isTable = type(ParagraphConfig) == "table"
            local TextStr = isTable and (ParagraphConfig.Title or "Title") or ParagraphConfig
            local ContentStr = isTable and (ParagraphConfig.Content or "Content") or "Content"
            
            ParagraphConfig = isTable and ParagraphConfig or {}
            
            local CustomIcon = nil
            local iconMatch = TextStr:match("%[emoji:['\"](.-)['\"]%]")
            if iconMatch then
                CustomIcon = iconMatch
                TextStr = TextStr:gsub("%[emoji:['\"](.-)['\"]%]", "")
            end

            ParagraphConfig.Title = TextStr
            ParagraphConfig.Content = ContentStr
            ParagraphConfig.Image = ParagraphConfig.Image or nil
            ParagraphConfig.Thumbnail = ParagraphConfig.Thumbnail or nil
            ParagraphConfig.Icon = ParagraphConfig.Icon or CustomIcon
            
            ParagraphConfig.Background = ParagraphConfig.Background or {} 
            ParagraphConfig.Background.Type = ParagraphConfig.Background.Type or "Default"
            ParagraphConfig.Buttons = ParagraphConfig.Buttons or {}
            
            local function ParseText(Str)
                if type(Str) ~= "string" then return Str end
                Str = Str:gsub("%[Highlight:['\"](.-)['\"]%]", '<font color="#ffffff"><b>%1</b></font>')
                Str = Str:gsub("%[underline:['\"](.-)['\"]%]", '<u>%1</u>')
                Str = Str:gsub("%[Color_(.-):['\"](.-)['\"]%]", '<font color="%1">%2</font>')
                return Str
            end

            local ContainerColor = CurrentTheme.Second 
            local ContainerTransparency = 0

            if ParagraphConfig.Background.Type == "Solid" then
                ContainerColor = ParagraphConfig.Background.Color or CurrentTheme.Main
            elseif ParagraphConfig.Background.Type == "Default" then
                ContainerColor = CurrentTheme.Second
            else
                ContainerTransparency = 0.7 
            end

            local ContainerProps = {
                Parent = ItemParent,
                Size = UDim2.new(1, 0, 0, 0),
                BackgroundColor3 = ContainerColor,
                BackgroundTransparency = ContainerTransparency,
                ClipsDescendants = true
            }
            
            if ParagraphConfig.Background.Type == "Image" then
                ContainerProps.BackgroundTransparency = 0
                ContainerProps.Image = ParagraphConfig.Background.Image or ""
                ContainerProps.ScaleType = Enum.ScaleType.Crop
                ContainerProps.ImageColor3 = Color3.fromRGB(255, 255, 255)
                ContainerProps.BackgroundColor3 = CurrentTheme.Main
            end

            local ContainerType = (ParagraphConfig.Background.Type == "Image") and "Image" or "RoundFrame"
            local ParagraphContainer = SetProps(MakeElement(ContainerType, ContainerColor, 0, 5), ContainerProps)
            
            if ParagraphConfig.Background.Type == "Default" then
                AddThemeObject(ParagraphContainer, "Second")
            end
            
            if ParagraphConfig.Background.Type == "Gradient" then
                Create("UIGradient", {
                    Color = ParagraphConfig.Background.ColorData or ColorSequence.new{
                        ColorSequenceKeypoint.new(0, CurrentTheme.Second), 
                        ColorSequenceKeypoint.new(1, CurrentTheme.Main)
                    },
                    Rotation = 45,
                    Parent = ParagraphContainer
                })
            end

            AddThemeObject(SetProps(MakeElement("Stroke"), {
                Transparency = 0.6, 
                Thickness = 1,
                Color = CurrentTheme.Stroke
            }), "Stroke").Parent = ParagraphContainer

            local ContentLayout = Create("UIListLayout", {
                Parent = ParagraphContainer,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 8),
                HorizontalAlignment = Enum.HorizontalAlignment.Left
            })
            
            Create("UIPadding", {
                Parent = ParagraphContainer,
                PaddingTop = UDim.new(0, 10),
                PaddingBottom = UDim.new(0, 10),
                PaddingLeft = UDim.new(0, 10),
                PaddingRight = UDim.new(0, 10)
            })

            if ParagraphConfig.Image then
                local Header = MakeElement("TFrame")
                Header.Size = UDim2.new(1, 0, 0, 0)
                Header.AutomaticSize = Enum.AutomaticSize.Y
                Header.LayoutOrder = 1
                Header.Parent = ParagraphContainer
                local Img = MakeElement("Image", ParagraphConfig.Image)
                Img.Size = UDim2.new(0, 40, 0, 40)
                Img.Parent = Header
                ContentLayout.Padding = UDim.new(0, 12)
            end

            local TitleObj = nil
            if ParagraphConfig.Title and ParagraphConfig.Title ~= "" then
                TitleObj = SetProps(MakeElement("Label", ParseText(ParagraphConfig.Title), 14), {
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.GothamBold,
                    BackgroundTransparency = 1,
                    LayoutOrder = 2,
                    RichText = true
                })
                TitleObj.Parent = ParagraphContainer
            end

            local ContentObj = SetProps(MakeElement("Label", ParseText(ParagraphConfig.Content), 13), {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                RichText = true,
                BackgroundTransparency = 1,
                LayoutOrder = 3
            })
            ContentObj.Parent = ParagraphContainer

            AddConnection(ContentObj:GetPropertyChangedSignal("TextBounds"), function()
                ParagraphContainer.Size = UDim2.new(1, 0, 0, ContentObj.TextBounds.Y + (ParagraphConfig.Image and 60 or 30) + (TitleObj and TitleObj.TextBounds.Y or 0))
            end)

            local ParagraphFunction = {}
            function ParagraphFunction:Set(ToChange)
                ContentObj.Text = ParseText(ToChange)
            end
            return ParagraphFunction
        end

        function ElementFunction:AddButton(ButtonConfig)
            ButtonConfig = ButtonConfig or {}
            ButtonConfig.Name = ButtonConfig.Name or "Button"
            ButtonConfig.Callback = ButtonConfig.Callback or function() end
            ButtonConfig.Icon = ButtonConfig.Icon or nil

            local ButtonFunc = {}

            local ButtonFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
                Size = UDim2.new(1, 0, 0, 30),
                BackgroundTransparency = 0.7,
                Parent = ItemParent
            }), {
                AddThemeObject(SetProps(MakeElement("Label", ButtonConfig.Name, 14), {
                    Size = UDim2.new(1, -12, 1, 0),
                    Position = UDim2.new(0, 12, 0, 0),
                    Font = Enum.Font.GothamBold,
                    Name = "BtnText"
                }), "Text"),
                AddThemeObject(MakeElement("Stroke"), "Stroke")
            }), "Second")

            if ButtonConfig.Icon then
                ButtonFrame.BtnText.Size = UDim2.new(1, -35, 1, 0)
                ButtonFrame.BtnText.Position = UDim2.new(0, 30, 0, 0)
                local BtnIcon = MakeElement("Image", ButtonConfig.Icon)
                BtnIcon.Size = UDim2.new(0, 16, 0, 16)
                BtnIcon.Position = UDim2.new(0, 10, 0.5, -8)
                BtnIcon.Parent = ButtonFrame
                BtnIcon.ImageTransparency = 0.4
            end

            local BtnHolder = SetProps(MakeElement("Button"), {
                Size = UDim2.new(1, 0, 1, 0),
                Parent = ButtonFrame,
                BackgroundTransparency = 1
            })

            local HoverTween = TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)})
            local LeaveTween = TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Second})

            AddConnection(BtnHolder.MouseEnter, function()
                HoverTween:Play()
            end)
            AddConnection(BtnHolder.MouseLeave, function()
                LeaveTween:Play()
            end)

            AddConnection(BtnHolder.MouseButton1Click, function()
                TweenService:Create(ButtonFrame, TweenInfo.new(0.1), {Size = UDim2.new(0.98, 0, 0.9, 0)}):Play()
                task.wait(0.1)
                TweenService:Create(ButtonFrame, TweenInfo.new(0.1), {Size = UDim2.new(1, 0, 1, 0)}):Play()
                task.spawn(ButtonConfig.Callback)
            end)

            function ButtonFunc:Set(ToChange)
                ButtonFrame.BtnText.Text = ToChange
            end

            return ButtonFunc
        end

        function ElementFunction:AddToggle(ToggleConfig)
            ToggleConfig = ToggleConfig or {}
            ToggleConfig.Name = ToggleConfig.Name or "Toggle"
            ToggleConfig.Default = ToggleConfig.Default or false
            ToggleConfig.Callback = ToggleConfig.Callback or function() end
            ToggleConfig.Flag = ToggleConfig.Flag or nil
            ToggleConfig.Save = ToggleConfig.Save or false

            local ToggleFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
                Size = UDim2.new(1, 0, 0, 30),
                BackgroundTransparency = 0.7,
                Parent = ItemParent
            }), {
                AddThemeObject(SetProps(MakeElement("Label", ToggleConfig.Name, 14), {
                    Size = UDim2.new(1, -50, 1, 0),
                    Position = UDim2.new(0, 10, 0, 0),
                    Font = Enum.Font.GothamBold
                }), "Text"),
                AddThemeObject(MakeElement("Stroke"), "Stroke")
            }), "Second")

            local ToggleContainer = SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 1, 4), {
                Size = UDim2.new(0, 24, 0, 14),
                Position = UDim2.new(1, -35, 0.5, 0),
                AnchorPoint = Vector2.new(1, 0.5),
                Parent = ToggleFrame
            }), {
                MakeElement("Stroke"),
                MakeElement("Corner", 1)
            })

            local ToggleButton = SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 1, 3), {
                Size = UDim2.new(0, 10, 0, 10),
                Position = UDim2.new(0, 2, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5)
            })

            if ToggleConfig.Flag then
                OrionLib.Flags[ToggleConfig.Flag] = {
                    Type = "Toggle",
                    Value = ToggleConfig.Default,
                    Callback = ToggleConfig.Callback,
                    Save = ToggleConfig.Save
                }
            end

            local function ToggleState(State)
                TweenService:Create(ToggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {
                    Position = UDim2.new(0, (State and 12 or 2), 0.5, 0),
                    BackgroundColor3 = (State and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(255,255,255))
                }):Play()
                ToggleConfig.Callback(State)
                if ToggleConfig.Flag then
                    OrionLib.Flags[ToggleConfig.Flag].Value = State
                end
            end

            local ToggleBtnHolder = SetProps(MakeElement("Button"), {
                Size = UDim2.new(1, 0, 1, 0),
                Parent = ToggleFrame,
                BackgroundTransparency = 1
            })

            local HoverTween = TweenService:Create(ToggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)})
            local LeaveTween = TweenService:Create(ToggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Second})

            AddConnection(ToggleBtnHolder.MouseEnter, function()
                HoverTween:Play()
            end)
            AddConnection(ToggleBtnHolder.MouseLeave, function()
                LeaveTween:Play()
            end)

            AddConnection(ToggleBtnHolder.MouseButton1Click, function()
                ToggleConfig.Default = not ToggleConfig.Default
                ToggleState(ToggleConfig.Default)
            end)

            ToggleButton.Parent = ToggleContainer
            ToggleState(ToggleConfig.Default)

            local ToggleFunction = {}
            function ToggleFunction:Set(ToChange)
                ToggleConfig.Default = ToChange
                ToggleState(ToChange)
            end
            return ToggleFunction
        end

        function ElementFunction:AddSlider(SliderConfig)
            SliderConfig = SliderConfig or {}
            SliderConfig.Name = SliderConfig.Name or "Slider"
            SliderConfig.Min = SliderConfig.Min or 0
            SliderConfig.Max = SliderConfig.Max or 100
            SliderConfig.Default = SliderConfig.Default or 50
            SliderConfig.Increment = SliderConfig.Increment or 1
            SliderConfig.Callback = SliderConfig.Callback or function() end
            SliderConfig.ValueName = SliderConfig.ValueName or ""
            SliderConfig.Flag = SliderConfig.Flag or nil
            SliderConfig.Save = SliderConfig.Save or false

            if SliderConfig.Default < SliderConfig.Min then SliderConfig.Default = SliderConfig.Min end
            if SliderConfig.Default > SliderConfig.Max then SliderConfig.Default = SliderConfig.Max end

            local SliderFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
                Size = UDim2.new(1, 0, 0, 40),
                BackgroundTransparency = 0.7,
                Parent = ItemParent
            }), {
                AddThemeObject(SetProps(MakeElement("Label", SliderConfig.Name, 14), {
                    Size = UDim2.new(1, 0, 0, 15),
                    Position = UDim2.new(0, 10, 0, 0),
                    Font = Enum.Font.GothamBold
                }), "Text"),
                AddThemeObject(MakeElement("Stroke"), "Stroke")
            }), "Second")

            local ValueLabel = SetProps(MakeElement("Label", SliderConfig.Default .. (SliderConfig.ValueName ~= "" and " " .. SliderConfig.ValueName or ""), 13), {
                Size = UDim2.new(1, -20, 0, 15),
                Position = UDim2.new(0, 10, 0, 20),
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Right
            })
            ValueLabel.Parent = SliderFrame
            AddThemeObject(ValueLabel, "Text")

            local SliderBarContainer = SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
                Size = UDim2.new(1, -20, 0, 8),
                Position = UDim2.new(0, 10, 1, -10),
                AnchorPoint = Vector2.new(0, 1),
                Parent = SliderFrame
            })
            SliderBarContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

            local SliderBarFill = SetProps(MakeElement("RoundFrame", Color3.fromRGB(0, 170, 255), 0, 5), {
                Size = UDim2.new(0, 0, 1, 0),
                Parent = SliderBarContainer
            })
            local SliderCircle = SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 1, 3), {
                Size = UDim2.new(0, 16, 0, 16),
                Position = UDim2.new(0, 0, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                Parent = SliderBarFill
            })

            if SliderConfig.Flag then
                OrionLib.Flags[SliderConfig.Flag] = {
                    Type = "Slider",
                    Value = SliderConfig.Default,
                    Callback = SliderConfig.Callback,
                    Save = SliderConfig.Save
                }
            end

            local function UpdateSlider(UDim2Value)
                local Val = math.floor((((UDim2Value.X.Scale * 100) / 100) * (SliderConfig.Max - SliderConfig.Min)) + SliderConfig.Min / SliderConfig.Increment) * SliderConfig.Increment
                local FinalVal = math.clamp(Val, SliderConfig.Min, SliderConfig.Max)
                
                TweenService:Create(SliderBarFill, TweenInfo.new(0.2), {Size = UDim2.new((FinalVal - SliderConfig.Min) / (SliderConfig.Max - SliderConfig.Min), 0, 1, 0)}):Play()
                ValueLabel.Text = tostring(FinalVal) .. (SliderConfig.ValueName ~= "" and " " .. SliderConfig.ValueName or "")
                SliderConfig.Callback(FinalVal)
                if SliderConfig.Flag then
                    OrionLib.Flags[SliderConfig.Flag].Value = FinalVal
                end
            end

            UpdateSlider(UDim2.new((SliderConfig.Default - SliderConfig.Min) / (SliderConfig.Max - SliderConfig.Min), 0, 0, 0))

            local Dragging = false
            AddConnection(SliderBarContainer.InputBegan, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Dragging = true
                end
            end)
            AddConnection(SliderBarContainer.InputEnded, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Dragging = false
                end
            end)
            AddConnection(UserInputService.InputChanged, function(Input)
                if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then
                    local SizeScale = math.clamp((Input.Position.X - SliderBarContainer.AbsolutePosition.X) / SliderBarContainer.AbsoluteSize.X, 0, 1)
                    UpdateSlider(UDim2.new(SizeScale, 0, 0, 0))
                end
            end)

            local SliderFunction = {}
            function SliderFunction:Set(ToChange)
                SliderConfig.Default = ToChange
                UpdateSlider(UDim2.new((ToChange - SliderConfig.Min) / (SliderConfig.Max - SliderConfig.Min), 0, 0, 0))
            end
            return SliderFunction
        end

        function ElementFunction:AddDropdown(DropdownConfig)
            DropdownConfig = DropdownConfig or {}
            DropdownConfig.Name = DropdownConfig.Name or "Dropdown"
            DropdownConfig.Default = DropdownConfig.Default or ""
            DropdownConfig.Options = DropdownConfig.Options or {}
            DropdownConfig.Callback = DropdownConfig.Callback or function() end
            DropdownConfig.Flag = DropdownConfig.Flag or nil
            DropdownConfig.Save = DropdownConfig.Save or false

            local DropdownFrame = SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
                Size = UDim2.new(1, 0, 0, 30),
                Parent = ItemParent,
                ClipsDescendants = true
            }), {
                AddThemeObject(SetProps(MakeElement("Label", DropdownConfig.Name, 14), {
                    Size = UDim2.new(1, -50, 1, 0),
                    Position = UDim2.new(0, 10, 0, 0),
                    Font = Enum.Font.GothamBold
                }), "Text"),
                AddThemeObject(MakeElement("Stroke"), "Stroke")
            })
            AddThemeObject(DropdownFrame, "Second")

            local SelectedOptionObj = SetProps(MakeElement("Label", DropdownConfig.Default, 13), {
                Size = UDim2.new(1, 0, 1, 0),
                Position = UDim2.new(0, 0, 0, 0),
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Right,
                Name = "Selected"
            })
            SelectedOptionObj.Parent = DropdownFrame
            AddThemeObject(SelectedOptionObj, "Text")

            local DropdownToggle = SetProps(MakeElement("Image", "rbxassetid://7072706618"), {
                Size = UDim2.new(0, 16, 0, 16),
                Position = UDim2.new(1, -20, 0.5, -8),
                AnchorPoint = Vector2.new(0, 0.5)
            })
            DropdownToggle.Parent = DropdownFrame
            AddThemeObject(DropdownToggle, "Text")

            local DropdownHolder = SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 1, 5),
                Parent = DropdownFrame
            })
            AddThemeObject(DropdownHolder, "Second")
            AddThemeObject(MakeElement("Stroke"), "Stroke").Parent = DropdownHolder

            local OptionList = MakeElement("ScrollFrame", Color3.fromRGB(255, 255, 255), 3)
            OptionList.Size = UDim2.new(1, 0, 0, 0)
            OptionList.Position = UDim2.new(0, 0, 0, 0)
            OptionList.Parent = DropdownHolder
            OptionList.ScrollBarThickness = 0
            AddThemeObject(OptionList, "Divider")

            local OptionsPadding = MakeElement("Padding", 4, 0, 0, 0)
            OptionsPadding.Parent = OptionList

            local OptionsLayout = MakeElement("List", 0, 4)
            OptionsLayout.Parent = OptionList

            local Expanded = false

            if DropdownConfig.Flag then
                OrionLib.Flags[DropdownConfig.Flag] = {
                    Type = "Dropdown",
                    Value = DropdownConfig.Default,
                    Callback = DropdownConfig.Callback,
                    Save = DropdownConfig.Save
                }
            end

            local function SelectOption(Option)
                DropdownConfig.Default = Option
                SelectedOptionObj.Text = Option
                DropdownConfig.Callback(Option)
                if DropdownConfig.Flag then
                    OrionLib.Flags[DropdownConfig.Flag].Value = Option
                end
            end

            local function RefreshOptions(Options)
                for _, v in pairs(OptionList:GetChildren()) do
                    if v:IsA("TextButton") then
                        v:Destroy()
                    end
                end

                for i, v in pairs(Options) do
                    local OptionBtn = SetProps(MakeElement("Button"), {
                        Size = UDim2.new(1, 0, 0, 25),
                        Text = "",
                        BackgroundTransparency = 1
                    })
                    
                    local OptionLabel = SetProps(MakeElement("Label", v, 13), {
                        Size = UDim2.new(1, 0, 1, 0),
                        Position = UDim2.new(0, 8, 0, 0),
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left
                    })
                    AddThemeObject(OptionLabel, "Text")

                    OptionBtn.MouseButton1Click:Connect(function()
                        SelectOption(v)
                    end)
                    
                    local HoverFrame = SetProps(MakeElement("Frame"), {
                        Size = UDim2.new(1, 0, 1, 0),
                        BackgroundTransparency = 0.9
                    })
                    AddThemeObject(HoverFrame, "Divider")

                    OptionBtn.MouseEnter:Connect(function()
                        TweenService:Create(HoverFrame, TweenInfo.new(0.1), {BackgroundTransparency = 0.7}):Play()
                    end)
                    OptionBtn.MouseLeave:Connect(function()
                        TweenService:Create(HoverFrame, TweenInfo.new(0.1), {BackgroundTransparency = 0.9}):Play()
                    end)

                    HoverFrame.Parent = OptionBtn
                    OptionLabel.Parent = OptionBtn
                    OptionBtn.Parent = OptionList
                end
                
                OptionList.CanvasSize = UDim2.new(0, 0, 0, OptionsLayout.AbsoluteContentSize.Y + 8)
            end

            RefreshOptions(DropdownConfig.Options)

            local DropdownBtn = SetProps(MakeElement("Button"), {
                Size = UDim2.new(1, 0, 1, 0),
                Parent = DropdownFrame,
                BackgroundTransparency = 1
            })

            AddConnection(DropdownBtn.MouseButton1Click, function()
                Expanded = not Expanded
                TweenService:Create(DropdownToggle, TweenInfo.new(0.2), {Rotation = Expanded and 180 or 0}):Play()
                TweenService:Create(DropdownHolder, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {Size = UDim2.new(1, 0, 0, Expanded and math.clamp(OptionsLayout.AbsoluteContentSize.Y + 8, 0, 150) or 0)}):Play()
            end)

            local DropdownFunction = {}
            function DropdownFunction:Set(ToChange)
                SelectOption(ToChange)
            end
            function DropdownFunction:Refresh(Options)
                RefreshOptions(Options)
            end
            return DropdownFunction
        end

        function ElementFunction:AddInput(InputConfig)
            InputConfig = InputConfig or {}
            InputConfig.Name = InputConfig.Name or "Input"
            InputConfig.Default = InputConfig.Default or ""
            InputConfig.Placeholder = InputConfig.Placeholder or "Input here..."
            InputConfig.RemoveTextAfterFocusLost = InputConfig.RemoveTextAfterFocusLost or false
            InputConfig.Callback = InputConfig.Callback or function() end
            InputConfig.Flag = InputConfig.Flag or nil
            InputConfig.Save = InputConfig.Save or false

            local InputFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
                Size = UDim2.new(1, 0, 0, 30),
                BackgroundTransparency = 0.7,
                Parent = ItemParent
            }), {
                AddThemeObject(SetProps(MakeElement("Label", InputConfig.Name, 14), {
                    Size = UDim2.new(1, -20, 1, 0),
                    Position = UDim2.new(0, 10, 0, 0),
                    Font = Enum.Font.GothamBold
                }), "Text"),
                AddThemeObject(MakeElement("Stroke"), "Stroke")
            }), "Second")

            local InputBox = SetProps(MakeElement("TextBox"), {
                Size = UDim2.new(1, 0, 1, 0),
                Position = UDim2.new(0, 10, 0, 0),
                Text = "",
                PlaceholderText = InputConfig.Placeholder,
                TextXAlignment = Enum.TextXAlignment.Right,
                BackgroundTransparency = 1,
                Font = Enum.Font.Gotham,
                TextSize = 14
            })
            AddThemeObject(InputBox, "Text")
            InputBox.Parent = InputFrame
            InputBox.ZIndex = 2

            if InputConfig.Flag then
                OrionLib.Flags[InputConfig.Flag] = {
                    Type = "Input",
                    Value = InputConfig.Default,
                    Callback = InputConfig.Callback,
                    Save = InputConfig.Save
                }
            end

            InputBox.FocusLost:Connect(function(EnterPressed)
                if EnterPressed then
                    InputConfig.Default = InputBox.Text
                    InputConfig.Callback(InputBox.Text)
                    if InputConfig.Flag then
                        OrionLib.Flags[InputConfig.Flag].Value = InputBox.Text
                    end
                    if InputConfig.RemoveTextAfterFocusLost then
                        InputBox.Text = ""
                    end
                end
            end)

            local InputFunction = {}
            function InputFunction:Set(ToChange)
                InputConfig.Default = ToChange
                InputBox.Text = ToChange
            end
            return InputFunction
        end

        function ElementFunction:AddColorPicker(ColorConfig)
            ColorConfig = ColorConfig or {}
            ColorConfig.Name = ColorConfig.Name or "ColorPicker"
            ColorConfig.Default = ColorConfig.Default or Color3.fromRGB(255, 255, 255)
            ColorConfig.Callback = ColorConfig.Callback or function() end
            ColorConfig.Flag = ColorConfig.Flag or nil
            ColorConfig.Save = ColorConfig.Save or false

            local ColorFrame = SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
                Size = UDim2.new(1, 0, 0, 30),
                Parent = ItemParent
            }), {
                AddThemeObject(SetProps(MakeElement("Label", ColorConfig.Name, 14), {
                    Size = UDim2.new(1, -40, 1, 0),
                    Position = UDim2.new(0, 10, 0, 0),
                    Font = Enum.Font.GothamBold
                }), "Text"),
                AddThemeObject(MakeElement("Stroke"), "Stroke")
            })
            AddThemeObject(ColorFrame, "Second")

            local ColorPreview = SetProps(MakeElement("RoundFrame", ColorConfig.Default, 1, 3), {
                Size = UDim2.new(0, 20, 0, 20),
                Position = UDim2.new(1, -28, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5)
            })
            ColorPreview.Parent = ColorFrame

            local PickerOpen = false

            local ColorPickerContainer = SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(25, 25, 25), 0, 8), {
                Size = UDim2.new(0, 180, 0, 0),
                Position = UDim2.new(1, -185, 1, 10),
                Parent = ItemParent,
                ZIndex = 10,
                ClipsDescendants = true
            }), {
                AddThemeObject(MakeElement("Stroke"), "Stroke"),
                MakeElement("Padding", 8, 0, 0, 8)
            })

            local Hue = Create("ImageButton", {
                Size = UDim2.new(1, 0, 0, 150),
                BackgroundTransparency = 1,
                ZIndex = 10,
                Image = "rbxassetid://4155801252"
            })
            Hue.Parent = ColorPickerContainer
            local HueSelector = SetProps(MakeElement("Frame"), {
                Size = UDim2.new(0, 0, 0, 0),
                Position = UDim2.new(0, 0, 0, 0),
                ZIndex = 11
            })
            HueSelector.Parent = Hue

            local ColorSelection = SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 2), {
                Size = UDim2.new(0, 150, 0, 150),
                Position = UDim2.new(0, 0, 0, 165),
                ZIndex = 10,
                BorderSizePixel = 0,
                ImageColor3 = ColorConfig.Default
            })
            ColorSelection.Parent = ColorPickerContainer
            
            local RainbowToggle = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), {
                Size = UDim2.new(1, 0, 0, 25),
                Position = UDim2.new(0, 0, 1, 8),
                ZIndex = 10
            }), {
                MakeElement("Stroke")
            }), "Second")
            RainbowToggle.Parent = ColorPickerContainer

            local RainbowText = SetProps(MakeElement("Label", "Rainbow", 13), {
                Size = UDim2.new(1, 0, 1, 0),
                Position = UDim2.new(0, 8, 0, 0),
                Font = Enum.Font.GothamBold,
                ZIndex = 10
            })
            AddThemeObject(RainbowText, "Text")
            RainbowText.Parent = RainbowToggle

            local RainbowBtn = SetProps(MakeElement("Button"), {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                ZIndex = 10
            })
            RainbowBtn.Parent = RainbowToggle

            local IsRainbow = false

            if ColorConfig.Flag then
                OrionLib.Flags[ColorConfig.Flag] = {
                    Type = "Colorpicker",
                    Value = ColorConfig.Default,
                    Callback = ColorConfig.Callback,
                    Save = ColorConfig.Save
                }
            end

            local function UpdateColor(Color)
                ColorPreview.BackgroundColor3 = Color
                ColorSelection.BackgroundColor3 = Color
                ColorConfig.Callback(Color)
                if ColorConfig.Flag then
                    OrionLib.Flags[ColorConfig.Flag].Value = Color
                end
            end

            AddConnection(RainbowBtn.MouseButton1Click, function()
                IsRainbow = not IsRainbow
                RainbowText.Text = (IsRainbow and "[Running] " or "") .. "Rainbow"
            end)

            spawn(function()
                while IsRainbow and OrionLib:IsRunning() do
                    local Hue = (tick() % 5) / 5
                    UpdateColor(Color3.fromHSV(Hue, 1, 1))
                    task.wait()
                end
            end)

            AddConnection(Hue.MouseButton1Down, function()
                local MoveHue, MoveColor;
                MoveHue = Hue.MouseMoved:Connect(function(x, y)
                    local Color = Color3.fromHSV((x - Hue.AbsolutePosition.X) / Hue.AbsoluteSize.X, 1, 1)
                    UpdateColor(Color)
                end)
                MoveColor = Hue.MouseButton1Up:Connect(function()
                    MoveHue:Disconnect()
                    MoveColor:Disconnect()
                end)
            end)

            local CPBtn = SetProps(MakeElement("Button"), {
                Size = UDim2.new(1, 0, 1, 0),
                Parent = ColorFrame,
                BackgroundTransparency = 1
            })

            AddConnection(CPBtn.MouseButton1Click, function()
                PickerOpen = not PickerOpen
                TweenService:Create(ColorPickerContainer, TweenInfo.new(0.2), {
                    Size = UDim2.new(0, 180, 0, PickerOpen and 200 or 0)
                }):Play()
            end)

            local ColorFunction = {}
            function ColorFunction:Set(ToChange)
                UpdateColor(ToChange)
            end
            return ColorFunction
        end

        return ElementFunction
    end

    function OrionLib:MakeTab(TabConfig)
        TabConfig = TabConfig or {}
        TabConfig.Name = TabConfig.Name or "Tab"
        TabConfig.Icon = TabConfig.Icon or ""
        TabConfig.PremiumOnly = TabConfig.PremiumOnly or false

        local TabFrame = Create("TextButton", {
            Parent = TabHolder,
            Size = UDim2.new(1, 0, 0, 32),
            BackgroundTransparency = 1,
            Text = "",
            Name = TabConfig.Name,
            AutoButtonColor = false
        })

        local IconImg = AddThemeObject(SetProps(MakeElement("Image", TabConfig.Icon), {
            Parent = TabFrame,
            AnchorPoint = Vector2.new(0, 0.5),
            Size = UDim2.new(0, 16, 0, 16),
            Position = UDim2.new(0, 10, 0.5, 0),
            ImageTransparency = 0.4,
            Name = "Ico"
        }), "TextDark")

        local TitleTxt = AddThemeObject(SetProps(MakeElement("Label", TabConfig.Name, 14), {
            Parent = TabFrame,
            Size = UDim2.new(1, -35, 1, 0),
            Position = UDim2.new(0, 35, 0, 0),
            Font = Enum.Font.GothamSemibold,
            TextTransparency = 0.4,
            TextXAlignment = Enum.TextXAlignment.Left,
            Name = "Title"
        }), "TextDark")

        AddItemTable(TabButtons, TabConfig.Name, TabFrame)

        if GetIcon(TabConfig.Icon) ~= nil then
            IconImg.Image = GetIcon(TabConfig.Icon)
        end        

        local Container = AddThemeObject(SetChildren(SetProps(MakeElement("ScrollFrame", Color3.fromRGB(255, 255, 255), 5), {
            Size = UDim2.new(1, -150, 1, -50),
            Position = UDim2.new(0, 150, 0, 50),
            Parent = MainWindow,
            Visible = false,
            Name = "ItemContainer",
            CanvasSize = UDim2.new(0,0,0,0)
        }), {
            MakeElement("List", 0, 6),
            MakeElement("Padding", 15, 10, 10, 15)
        }), "Divider")

        AddConnection(Container.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
            Container.CanvasSize = UDim2.new(0, 0, 0, Container.UIListLayout.AbsoluteContentSize.Y + 30)
        end)

        if FirstTab then
            FirstTab = false
            IconImg.ImageTransparency = 0
            IconImg.ImageColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Text
            TitleTxt.TextTransparency = 0
            TitleTxt.TextColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Text
            TitleTxt.Font = Enum.Font.GothamBold
            Container.Visible = true
        end    

        AddConnection(TabFrame.MouseButton1Click, function()
            for _, Item in next, TabHolder:GetChildren() do
                if Item:IsA("TextButton") then
                    TweenService:Create(Item.Title, TweenInfo.new(0.3), {TextTransparency = 0.4, TextColor3 = OrionLib.Themes[OrionLib.SelectedTheme].TextDark}):Play()
                    TweenService:Create(Item.Ico, TweenInfo.new(0.3), {ImageTransparency = 0.4, ImageColor3 = OrionLib.Themes[OrionLib.SelectedTheme].TextDark}):Play()
                    Item.Title.Font = Enum.Font.GothamSemibold
                end    
            end
            
            for _, ItemContainer in next, MainWindow:GetChildren() do
                if ItemContainer.Name == "ItemContainer" then
                    ItemContainer.Visible = false
                end    
            end  
            
            TweenService:Create(IconImg, TweenInfo.new(0.3), {ImageTransparency = 0, ImageColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Text}):Play()
            TweenService:Create(TitleTxt, TweenInfo.new(0.3), {TextTransparency = 0, TextColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Text}):Play()
            TitleTxt.Font = Enum.Font.GothamBold
            Container.Visible = true   
            
            Container.CanvasPosition = Vector2.new(0,0)
            Container.Position = UDim2.new(0, 150, 0, 60)
            TweenService:Create(Container, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0, 150, 0, 50)}):Play()
        end)

        local ElementFunction = GetElements(Container)
        
        function ElementFunction:AddSection(SectionConfig)
            SectionConfig = SectionConfig or {}
            SectionConfig.Name = SectionConfig.Name or "Section"
            
            local SectionFrame = SetChildren(SetProps(MakeElement("Frame"), {
                Parent = Container,
                Size = UDim2.new(1, 0, 0, 28),
                BackgroundTransparency = 1
            }), {
                AddThemeObject(SetProps(MakeElement("Label", SectionConfig.Name, 14), {
                    Size = UDim2.new(1, -10, 1, 0),
                    Position = UDim2.new(0, 5, 0, 0),
                    Font = Enum.Font.GothamBold,
                    TextXAlignment = Enum.TextXAlignment.Left
                }), "Text"),
                AddThemeObject(SetProps(MakeElement("Frame"), {
                    Size = UDim2.new(1, -10, 0, 1),
                    Position = UDim2.new(0, 5, 1, -2)
                }), "Stroke")
            })
            return SectionFrame
        end

        if TabConfig.PremiumOnly then
            for i, v in next, ElementFunction do
                ElementFunction[i] = function() end
            end    
            
            Container:ClearAllChildren()
            
            SetChildren(SetProps(MakeElement("TFrame"), {
                Size = UDim2.new(1, 0, 1, 0),
                Parent = Container
            }), {
                AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://3610239960"), {
                    Size = UDim2.new(0, 24, 0, 24),
                    Position = UDim2.new(0.5, 0, 0.4, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    ImageTransparency = 0.4
                }), "Text"),
                
                AddThemeObject(SetProps(MakeElement("Label", "Premium Locked", 16), {
                    Size = UDim2.new(1, 0, 0, 20),
                    Position = UDim2.new(0, 0, 0.45, 0),
                    TextXAlignment = Enum.TextXAlignment.Center,
                    Font = Enum.Font.GothamBold,
                    TextTransparency = 0.2
                }), "Text"),
                
                AddThemeObject(SetProps(MakeElement("Label", "This tab requires Sirius Premium.", 13), {
                    Size = UDim2.new(1, 0, 0, 20),
                    Position = UDim2.new(0, 0, 0.5, 0),
                    TextXAlignment = Enum.TextXAlignment.Center,
                    TextTransparency = 0.5
                }), "TextDark")
            })
        end
        
        return ElementFunction
            end

return OrionLib
