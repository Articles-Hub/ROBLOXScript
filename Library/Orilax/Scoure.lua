local Orilax = {}

local tween = game:GetService("TweenService")
local tweeninfo = game:GetService("TweenService")
local input = game:GetService("UserInputService")
local run = game:GetService("RunService")

local Utility = {}
local Objects = {}

function Orilax:CreateLib(params)
local GUI = {}
Orilax.Name = params.Name or "Example Hub"
Orilax.SubName = params.SubName or "Version 1.1.1.1"

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "Orilax"

local M_Gui = Instance.new("Frame", gui)
M_Gui.Size = UDim2.new(0, 520, 0, 330)
M_Gui.Position = UDim2.new(0.5, -254, 0.5, -154)
M_Gui.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
M_Gui.Active = true
M_Gui.BackgroundTransparency = 0 
M_Gui.Draggable = true
M_Gui.ClipsDescendants = true

local M_Corner = Instance.new("UICorner", M_Gui)
M_Corner.CornerRadius = UDim.new(0, 10)

local M_Tomain = Instance.new("Frame", M_Gui)
M_Tomain.Size = UDim2.new(1, 0, 0, 50)
M_Tomain.Position = UDim2.new(0, 0, 0, 0)
M_Tomain.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
M_Tomain.Active = false
M_Tomain.BackgroundTransparency = 0 
M_Tomain.Draggable = false

local M_Corner = Instance.new("UICorner", M_Tomain)
M_Corner.CornerRadius = UDim.new(0, 10)

local M_Cover = Instance.new("Frame", M_Tomain)
M_Cover.Size = UDim2.new(1, 0, 0, 7)
M_Cover.Position = UDim2.new(0, 0, 1, -2)
M_Cover.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
M_Cover.BorderSizePixel = 0
M_Cover.BackgroundTransparency = 0
M_Cover.Visible = true

local M_Title = Instance.new("TextLabel", M_Tomain)
M_Title.Size = UDim2.new(0, 150, 0, 50)
M_Title.Position = UDim2.new(0, 10, 0, 5)
M_Title.Text = Orilax.Name
M_Title.BackgroundTransparency = 1
M_Title.TextColor3 = Color3.fromRGB(240, 240, 240)
M_Title.Font = Enum.Font.GothamBold
M_Title.TextSize = 17
M_Title.TextWrapped = true
M_Title.AutomaticSize = Enum.AutomaticSize.XY

local M_SubTitle = Instance.new("TextLabel", M_Tomain)
M_SubTitle.Size = UDim2.new(0, 100, 0, 30)
M_SubTitle.Position = UDim2.new(0, M_Title.AbsoluteSize.X + 25, 0, 17)
M_SubTitle.Text = Orilax.SubName
M_SubTitle.BackgroundTransparency = 1
M_SubTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
M_SubTitle.Font = Enum.Font.GothamBold
M_SubTitle.TextSize = 14
M_SubTitle.TextWrapped = true
M_SubTitle.AutomaticSize = Enum.AutomaticSize.XY

local M_MizeFrame = Instance.new("Frame", M_Tomain)
M_MizeFrame.Size = UDim2.new(0, 100, 0, 40)
M_MizeFrame.Position = UDim2.new(0.75, 0, 0, 10)
M_MizeFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
M_MizeFrame.BorderSizePixel = 0
M_MizeFrame.Active = false
M_MizeFrame.BackgroundTransparency = 0 
M_MizeFrame.Draggable = false

local M_Corner = Instance.new("UICorner", M_MizeFrame)
M_Corner.CornerRadius = UDim.new(0, 10)

local M_Stroke = Instance.new("UIStroke", M_MizeFrame)
M_Stroke.Color = Color3.fromRGB(60, 60, 60)
M_Stroke.Thickness = 0.5

local M_Line1 = Instance.new("Frame", M_MizeFrame)
M_Line1.Size = UDim2.new(0, 1, 1.01, 0)
M_Line1.Position = UDim2.new(0.5, 0, 0, 0)
M_Line1.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
M_Line1.BorderSizePixel = 0
M_Line1.Active = true
M_Line1.Rotation = 15
M_Line1.BackgroundTransparency = 0 
M_Line1.Draggable = false

local M_TabHolder = Instance.new("ScrollingFrame", M_Gui)
M_TabHolder.Size = UDim2.new(0.96, 0, 0, 50)
M_TabHolder.Position = UDim2.new(0, 10, 0, 60)
M_TabHolder.BackgroundColor3 = Color3.fromRGB(19, 19, 19)
M_TabHolder.BackgroundTransparency = 0
M_TabHolder.ScrollBarThickness = 0
M_TabHolder.CanvasSize = UDim2.new(0, 0, 0, 50)

local M_Corner = Instance.new("UICorner", M_TabHolder)
M_Corner.CornerRadius = UDim.new(0, 5)

local M_TabHolders = Instance.new("Frame", M_Gui)
M_TabHolders.Size = UDim2.new(0.96, 0, 0.575, 0)
M_TabHolders.Position = UDim2.new(0, 10, 0, 120)
M_TabHolders.BackgroundColor3 = Color3.fromRGB(19, 19, 19)
M_TabHolders.BorderSizePixel = 0
M_TabHolders.Active = false
M_TabHolders.BackgroundTransparency = 0
M_TabHolders.Draggable = false

local M_Corner = Instance.new("UICorner", M_TabHolders)
M_Corner.CornerRadius = UDim.new(0, 6)

local M_Line = Instance.new("Frame", M_TabHolders)
M_Line.Size = UDim2.new(0, 60, 1, 0)
M_Line.Position = UDim2.new(0.5, -30, 0, 0)
M_Line.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
M_Line.BorderSizePixel = 0
M_Line.BackgroundTransparency = 0
M_Line.Visible = true

local M_Close = Instance.new("ImageButton", M_MizeFrame)
M_Close.Size = UDim2.new(0, 30, 0, 30)
M_Close.Position = UDim2.new(0.5, 10, 0, 5)
M_Close.Image = "rbxassetid://7072725342"
M_Close.ImageTransparency = 0
M_Close.BackgroundTransparency = 1

Hide = false
local M_Mimize = Instance.new("ImageButton", M_MizeFrame)
M_Mimize.Size = UDim2.new(0, 30, 0, 30)
M_Mimize.Position = UDim2.new(0, 10, 0, 5)
M_Mimize.Image = "rbxassetid://7072719338"
M_Mimize.ImageTransparency = 0
M_Mimize.BackgroundTransparency = 1
M_Mimize.MouseButton1Click:Connect(function()
Hide = not Hide
if Hide then
game.TweenService:Create(M_Gui, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 520, 0, 60)
            }):Play()
            M_TabHolder.Visible = false
            M_Line.Visible = false
            M_Cover.Visible = false
else
game.TweenService:Create(M_Gui, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 520, 0, 330)
            }):Play()
            M_TabHolder.Visible = true
            M_Line.Visible = true
            M_Cover.Visible = true
            end
end)

local Tabs = {}
local Pages = {}
local x = 10

function GUI:NewTab(p)
    local Icon = p.Icon or "rbxassetid://0"

    local b = Instance.new("TextButton", M_TabHolder)
    b.Size = UDim2.new(0, 40, 0, 40)
    b.Position = UDim2.new(0, x, 0, 5)
    b.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
    b.Text = ""

    local c = Instance.new("UICorner", b)
    c.CornerRadius = UDim.new(0, 7)

    local i = Instance.new("ImageLabel", b)
    i.Size = UDim2.new(0.8, 0, 0.8, 0)
    i.Position = UDim2.new(0, 4, 0, 4)
    i.Image = Icon
    i.BackgroundTransparency = 1

    x = x + 50

    local PageLeft = Instance.new("ScrollingFrame", M_TabHolders)
    PageLeft.Size = UDim2.new(0.435, 0, 1, 0)
    PageLeft.Position = UDim2.new(0, 0, 0, 0)
    PageLeft.BorderSizePixel = 0
    PageLeft.BackgroundTransparency = 1
    PageLeft.ScrollBarThickness = 0
    PageLeft.CanvasSize = UDim2.new(0, 0, 0, 100)
    PageLeft.AutomaticCanvasSize = Enum.AutomaticSize.Y
    PageLeft.Visible = false
    
    local M_Stroke1 = Instance.new("UIStroke", PageLeft)
    M_Stroke1.Color = Color3.fromRGB(60, 60, 60)
    M_Stroke1.Thickness = 0.5

    local M_Layout1 = Instance.new("UIListLayout", PageLeft)
    M_Layout1.HorizontalAlignment = Enum.HorizontalAlignment.Center
    M_Layout1.SortOrder = Enum.SortOrder.LayoutOrder
    M_Layout1.Padding = UDim.new(0, 10)

    local PageRight = Instance.new("ScrollingFrame", M_TabHolders)
    PageRight.Size = UDim2.new(0.435, 0, 1, 0)
    PageRight.Position = UDim2.new(0.565999985, 0, 0, 0)
    PageRight.BorderSizePixel = 0
    PageRight.BackgroundTransparency = 1
    PageRight.ScrollBarThickness = 0
    PageRight.CanvasSize = UDim2.new(0, 0, 0, 100)
    PageRight.AutomaticCanvasSize = Enum.AutomaticSize.Y
    PageRight.Visible = false

    local M_Stroke2 = Instance.new("UIStroke", PageRight)
    M_Stroke2.Color = Color3.fromRGB(60, 60, 60)
    M_Stroke2.Thickness = 0.5

    local M_Layout2 = Instance.new("UIListLayout", PageRight)
    M_Layout2.HorizontalAlignment = Enum.HorizontalAlignment.Center
    M_Layout2.SortOrder = Enum.SortOrder.LayoutOrder
    M_Layout2.Padding = UDim.new(0, 10)

    table.insert(Tabs, b)
    table.insert(Pages, {PageLeft, PageRight})

    b.MouseButton1Click:Connect(function()
        for _, pages in pairs(Pages) do
            for _, page in pairs(pages) do
                page.Visible = false
            end
        end
        PageLeft.Visible = true
        PageRight.Visible = true
    end)

    local PageFunctions = {}
    
        function PageFunctions:NewToggle(Params)
	        local ToggleSet = {}
            local M_ToggleOuter = Instance.new("Frame", self.Page) 
M_ToggleOuter.Size = UDim2.new(0, 200, 0, 40)  
M_ToggleOuter.Position = UDim2.new(0, 10, 0, 10)  
M_ToggleOuter.BackgroundColor3 = Color3.fromRGB(32, 32, 32)  
M_ToggleOuter.Active = true  
M_ToggleOuter.BackgroundTransparency = 0   
M_ToggleOuter.Draggable = false  
  
local M_Corner = Instance.new("UICorner", M_ToggleOuter)  
M_Corner.CornerRadius = UDim.new(0, 7)  
  
local M_Stroke = Instance.new("UIStroke", M_ToggleOuter)  
M_Stroke.Color = Color3.fromRGB(60, 60, 60)  
M_Stroke.Thickness = 0.5  
  
local M_TBox = Instance.new("Frame", M_ToggleOuter)  
M_TBox.Size = UDim2.new(0, 70, 0, 30)  
M_TBox.Position = UDim2.new(0.6, 0, 0, 5)  
M_TBox.BackgroundColor3 = Color3.fromRGB(24, 24, 24)  
M_TBox.Active = true  
M_TBox.BackgroundTransparency = 0   
  
local M_Corner = Instance.new("UICorner", M_TBox)  
M_Corner.CornerRadius = UDim.new(0, 7)  
  
local M_Stroke = Instance.new("UIStroke", M_TBox)  
M_Stroke.Color = Color3.fromRGB(60, 60, 60)  
M_Stroke.Thickness = 0.5  
  
local M_BToggle = Instance.new("ImageButton", M_TBox)  
M_BToggle.Size = UDim2.new(0.5, 0, 1, 0)  
M_BToggle.Position = UDim2.new(0, 0, 0, 0)  
M_BToggle.Image = "rbxassetid://3944680095"  
M_BToggle.BackgroundTransparency = 0  
M_BToggle.BackgroundColor3 = Color3.fromRGB(155, 0, 51)  
M_BToggle.ImageTransparency = 1  
  
local M_Corner = Instance.new("UICorner", M_BToggle)  
M_Corner.CornerRadius = UDim.new(0, 7)  
  
local M_Stroke = Instance.new("UIStroke", M_BToggle)  
M_Stroke.Color = Color3.fromRGB(60, 60, 60)  
M_Stroke.Thickness = 1  
  
local T_Name = Instance.new("TextLabel", M_ToggleOuter)  
T_Name.Size = UDim2.new(0, 0, 1, 0)  
T_Name.Position = UDim2.new(0, 60, 0, 0)  
T_Name.Text = Params.Name
T_Name.TextSize = 14  
T_Name.BackgroundTransparency = 1  
T_Name.TextColor3 = Color3.new(255, 255, 255)  
T_Name.Font = Enum.Font.GothamBold  

            local ToggleState = false

M_BToggle.MouseButton1Click:Connect(function()
    ToggleState = not ToggleState
    
    M_BToggle.BackgroundColor3 = ToggleState and Color3.fromRGB(0, 155, 51) or Color3.fromRGB(155, 0, 51)

    local targetPosition = ToggleState and UDim2.new(0.5, 0, 0, 0) or UDim2.new(0, 0, 0, 0)
    
    game.TweenService:Create(M_BToggle, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
        Position = targetPosition
    }):Play()

    if Params and Params.Call then
        pcall(function()
            Params.Call(ToggleState)
        end)
    end
end)

function ToggleSet:SetValue(Bool)
    ToggleState = Bool
    
    M_BToggle.BackgroundColor3 = ToggleState and Color3.fromRGB(0, 155, 51) or Color3.fromRGB(155, 0, 51)

    local targetPosition = ToggleState and UDim2.new(0.5, 0, 0, 0) or UDim2.new(0, 0, 0, 0)
    
    game.TweenService:Create(M_BToggle, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
        Position = targetPosition
    }):Play()

    if Params and Params.Call then
        pcall(function()
            Params.Call(ToggleState)
        end)
    end
end

return ToggleSet
            end
            
            function PageFunctions:NewButton(Params)
    local M_ButtonOuter = Instance.new("Frame", self.Page)
    M_ButtonOuter.Size = UDim2.new(0, 200, 0, 40)
    M_ButtonOuter.Position = UDim2.new(0, 10, 0, 60)
    M_ButtonOuter.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
    M_ButtonOuter.Active = true

    local M_Corner = Instance.new("UICorner", M_ButtonOuter)
    M_Corner.CornerRadius = UDim.new(0, 7)

    local M_Stroke = Instance.new("UIStroke", M_ButtonOuter)
    M_Stroke.Color = Color3.fromRGB(60, 60, 60)
    M_Stroke.Thickness = 0.5

    local B_Name = Instance.new("TextLabel", M_ButtonOuter)
    B_Name.Size = UDim2.new(0, 0, 1, 0)
    B_Name.Position = UDim2.new(0, 60, 0, 0)
    B_Name.Text = Params.Name or "Button"
    B_Name.TextSize = 14
    B_Name.BackgroundTransparency = 1
    B_Name.TextColor3 = Color3.new(255, 255, 255)
    B_Name.Font = Enum.Font.GothamBold

    local M_BImg = Instance.new("ImageButton", M_ButtonOuter)
    M_BImg.Size = UDim2.new(0, 35, 0, 30)
    M_BImg.Position = UDim2.new(0.775, 0, 0, 5)
    M_BImg.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    M_BImg.Image = "rbxassetid://3944703587"
    M_BImg.ImageTransparency = 0
    M_BImg.BackgroundTransparency = 1

    if Params and type(Params.Callback) == "function" then
        M_BImg.MouseButton1Click:Connect(function()
            Params.Callback()
        end)
    end
end
            
            function PageFunctions:NewDropdown(Params)
            Text = Params.Name or "select item"
            PlaceHolders = Params.PlaceHolder or "Nothing"
    local M_DropDownOuter = Instance.new("Frame", self.Page)
 M_DropDownOuter.Size = UDim2.new(0, 200, 0, 150)
 M_DropDownOuter.Position = UDim2.new(0.5, 0, 0.5, 0)
 M_DropDownOuter.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
 
 local M_Corner = Instance.new("UICorner", M_DropDownOuter)
 M_Corner.CornerRadius = UDim.new(0, 7)
 
 local M_Stroke = Instance.new("UIStroke", M_DropDownOuter)
 M_Stroke.Color = Color3.fromRGB(60, 60, 60)
 M_Stroke.Thickness = 0.5
 
 local M_DName = Instance.new("TextLabel", M_DropDownOuter)
 M_DName.Size = UDim2.new(0, 0, 0, 0)
 M_DName.Position = UDim2.new(0, 60, 0, 20)
 M_DName.Text = Text
 M_DName.TextSize = 14
 M_DName.BackgroundTransparency = 1
 M_DName.TextColor3 = Color3.new(255, 255, 255)
 M_DName.Font = Enum.Font.GothamBold
 
 local M_DropDownBox = Instance.new("TextButton", M_DropDownOuter)
 M_DropDownBox.Size = UDim2.new(0, 60, 0, 30)
 M_DropDownBox.Position = UDim2.new(0.65, 0, 0, 5)
 M_DropDownBox.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
 M_DropDownBox.BorderColor3 = Color3.new(0, 0, 0)
 M_DropDownBox.BorderSizePixel = 1
 M_DropDownBox.Text = PlaceHolders
 M_DropDownBox.TextSize = 14
 M_DropDownBox.TextScaled = false
 M_DropDownBox.BackgroundTransparency = 0 
 M_DropDownBox.TextColor3 = Color3.new(255, 255, 255)
 M_DropDownBox.Font = Enum.Font.GothamBold
 local M_Corner = Instance.new("UICorner", M_DropDownBox)
 M_Corner.CornerRadius = UDim.new(0, 7)
 
 local M_Stroke = Instance.new("UIStroke", M_DropDownBox)
 M_Stroke.Color = Color3.fromRGB(60, 60, 60)
 M_Stroke.Thickness = 0.5
 
 local M_ItemList = Instance.new("ScrollingFrame", M_DropDownOuter)
 M_ItemList.Size = UDim2.new(0.9, 0, 0.7, 0)
 M_ItemList.Position = UDim2.new(0, 10, 0, 40)
 M_ItemList.BackgroundColor3 = Color3.fromRGB(19, 19, 19)
 M_ItemList.BorderSizePixel = 0
 M_ItemList.BackgroundTransparency = 0 
 M_ItemList.ScrollBarThickness = 0
 M_ItemList.CanvasSize = UDim2.new(0, 0, 0, 100)
 M_ItemList.AutomaticCanvasSize = Enum.AutomaticSize.Y
 
 local M_Stroke = Instance.new("UIStroke", M_ItemList)
 M_Stroke.Color = Color3.fromRGB(60, 60, 60)
 M_Stroke.Thickness = 0.5
 
 local M_Layout = Instance.new("UIListLayout", M_ItemList)
 M_Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
 M_Layout.SortOrder = Enum.SortOrder.LayoutOrder
 M_Layout.Padding = UDim.new(0, 10)
 
 
 for _, item in ipairs(Params.List or {}) do
 local I_Item = Instance.new("TextButton", M_ItemList)
 I_Item.Size = UDim2.new(0, 170, 0, 40)
 I_Item.Position = UDim2.new(0.5, 0, 0.5, 0)
 I_Item.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
 I_Item.Text = item
 I_Item.TextSize = 14
 I_Item.TextColor3 = Color3.new(255, 255, 255)
 I_Item.Font = Enum.Font.GothamBold
 
 local M_Corner = Instance.new("UICorner", I_Item)
 M_Corner.CornerRadius = UDim.new(0, 7)
 
 local M_Stroke = Instance.new("UIStroke", I_Item)
 M_Stroke.Color = Color3.fromRGB(60, 60, 60)
 M_Stroke.Thickness = 0.5
 M_Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        I_Item.MouseButton1Click:Connect(function()
            M_DropDownBox.Text = item
            if Params.Call then
                Params.Call(item)
            end
        end)
        end
        
        
        function PageFunctions:NewLabel(Params)
    local LabelSet = {}
    local M_LabelOuter = Instance.new("Frame", self.Page)
    M_LabelOuter.Size = UDim2.new(0, 200, 0, 40)
    M_LabelOuter.Position = UDim2.new(0, 10, 0, 60)
    M_LabelOuter.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
    M_LabelOuter.Active = true

    local M_Corner = Instance.new("UICorner", M_LabelOuter)
    M_Corner.CornerRadius = UDim.new(0, 7)

    local M_Stroke = Instance.new("UIStroke", M_LabelOuter)
    M_Stroke.Color = Color3.fromRGB(60, 60, 60)
    M_Stroke.Thickness = 0.5

    local B_Name = Instance.new("TextLabel", M_LabelOuter)
    B_Name.Size = UDim2.new(1, -20, 1, 0)
    B_Name.Position = UDim2.new(0, 10, 0, 0)
    B_Name.Text = Params.Name or "Label"
    B_Name.TextSize = 14
    B_Name.BackgroundTransparency = 1
    B_Name.TextColor3 = Color3.new(255, 255, 255)
    B_Name.Font = Enum.Font.GothamBold
    B_Name.TextWrapped = true
    B_Name.AutomaticSize = Enum.AutomaticSize.Y
    
    function LabelSet:SetText(Text)
	    if B_Name.Text ~= Text then
			B_Name.Text = Text
		end
	end
	return LabelSet
	end
	
	function PageFunctions:NewSlider(Params)
    local Min, Max = Params.Min or 0, Params.Max or 100
    local Value = Params.Default or Min
    local Dragging = false
    local SliderSet = {}

    local M_SliderOuter = Instance.new("Frame", self.Page)
    M_SliderOuter.Size = UDim2.new(0, 200, 0, 60)
    M_SliderOuter.Position = UDim2.new(0, 10, 0, 60)
    M_SliderOuter.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
    M_SliderOuter.Active = true

    local M_Corner = Instance.new("UICorner", M_SliderOuter)
    M_Corner.CornerRadius = UDim.new(0, 7)

    local M_Stroke = Instance.new("UIStroke", M_SliderOuter)
    M_Stroke.Color = Color3.fromRGB(60, 60, 60)
    M_Stroke.Thickness = 0.5

    local B_Name = Instance.new("TextLabel", M_SliderOuter)
    B_Name.Size = UDim2.new(1, -20, 1, 0)
    B_Name.Position = UDim2.new(0, 10, 0, -20)
    B_Name.Text = Params.Name
    B_Name.TextSize = 14
    B_Name.BackgroundTransparency = 1
    B_Name.TextColor3 = Color3.new(255, 255, 255)
    B_Name.Font = Enum.Font.GothamBold
    B_Name.TextWrapped = true

    local M_SliderFrame = Instance.new("Frame", M_SliderOuter)
    M_SliderFrame.Size = UDim2.new(0.9, 0, 0, 35)
    M_SliderFrame.Position = UDim2.new(0.05, 0, 0, 20)
    M_SliderFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    M_SliderFrame.Active = true
    M_SliderFrame.BackgroundTransparency = 0.7
    M_SliderFrame.ClipsDescendants = true  -- Giữ input trong khu vực slider

    local M_Corner = Instance.new("UICorner", M_SliderFrame)
    M_Corner.CornerRadius = UDim.new(0, 5)

    local M_Stroke = Instance.new("UIStroke", M_SliderFrame)
    M_Stroke.Color = Color3.fromRGB(60, 60, 60)
    M_Stroke.Thickness = 1

    local M_NumSlider = Instance.new("TextLabel", M_SliderFrame)
    M_NumSlider.Size = UDim2.new(1, 0, 1, 0)
    M_NumSlider.Position = UDim2.new(0, 0, 0, 0)
    M_NumSlider.Text = tostring(Value)
    M_NumSlider.TextSize = 17
    M_NumSlider.BackgroundTransparency = 1
    M_NumSlider.TextColor3 = Color3.fromRGB(200, 200, 200)
    M_NumSlider.Font = Enum.Font.GothamBold

    local M_SliderBar = Instance.new("Frame", M_SliderFrame)
    M_SliderBar.Size = UDim2.new((Value - Min) / (Max - Min), 0, 1, 0)
    M_SliderBar.Position = UDim2.new(0, 0, 0, 0)
    M_SliderBar.BackgroundColor3 = Color3.fromRGB(205, 205, 205)
    M_SliderBar.Active = true
    M_SliderBar.BackgroundTransparency = 0.3

    local M_Corner = Instance.new("UICorner", M_SliderBar)
    M_Corner.CornerRadius = UDim.new(0, 5)

    local function UpdateSlider(Input)
        if not Dragging then return end
        if Input.Position.X < M_SliderFrame.AbsolutePosition.X or Input.Position.X > (M_SliderFrame.AbsolutePosition.X + M_SliderFrame.AbsoluteSize.X) then
            return 
        end

        local SizeScale = math.clamp((Input.Position.X - M_SliderFrame.AbsolutePosition.X) / M_SliderFrame.AbsoluteSize.X, 0, 1)
        Value = math.floor(Min + ((Max - Min) * SizeScale))
        M_SliderBar.Size = UDim2.new(SizeScale, 0, 1, 0)
        M_NumSlider.Text = tostring(Value)
        if Params.Callback then Params.Callback(Value) end
    end

    M_SliderFrame.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            UpdateSlider(Input)
        end
    end)

    M_SliderFrame.InputEnded:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = false
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(Input)
        if Dragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
            UpdateSlider(Input)
        end
    end)

    function SliderSet:SetValue(NewValue)
        Value = math.clamp(NewValue, Min, Max)
        local SizeScale = (Value - Min) / (Max - Min)
        M_SliderBar.Size = UDim2.new(SizeScale, 0, 1, 0)
        M_NumSlider.Text = tostring(Value)
        if Params.Callback then Params.Callback(Value) end
    end

    return SliderSet
end

end

        local LeftPage = setmetatable({Page = PageLeft}, {__index = PageFunctions})
    local RightPage = setmetatable({Page = PageRight}, {__index = PageFunctions})

    return {LeftPage = LeftPage, RightPage = RightPage}
end

    return GUI
end

return Orilax
