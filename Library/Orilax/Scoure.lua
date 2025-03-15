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

local M_Title = Instance.new("TextLabel", M_Tomain)
M_Title.Size = UDim2.new(0, 150, 0, 50)
M_Title.Position = UDim2.new(0, 10, 0, 5)
M_Title.Text = "Example Hub"
M_Title.TextSize = 25
M_Title.BackgroundTransparency = 1
M_Title.TextColor3 = Color3.fromRGB(240, 240, 240)
M_Title.Font = Enum.Font.GothamBold

local M_SubTitle = Instance.new("TextLabel", M_Tomain)
M_SubTitle.Size = UDim2.new(0, 100, 0, 30)
M_SubTitle.Position = UDim2.new(0, 150, 0, 17)
M_SubTitle.Text = "Version 1.1.1"
M_SubTitle.TextSize = 15
M_SubTitle.BackgroundTransparency = 1
M_SubTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
M_SubTitle.Font = Enum.Font.GothamBold

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
M_Line.Size = UDim2.new(0, 50, 1, 0)
M_Line.Position = UDim2.new(0.5, -30, 0, 0)
M_Line.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
M_Line.BorderSizePixel = 0
M_Line.BackgroundTransparency = 0

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
                Position = UDim2.new(0, 520, 0, 50)
            }):Play()
            M_TabHolder.Visible = false
else
game.TweenService:Create(M_Gui, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                Position = UDim2.new(0, 520, 0, 330)
            }):Play()
            M_TabHolder.Visible = true
end)

local Tabs = {}
    local Pages = {}
    local x = 10

    function GUI:NewTab(p)
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
        i.Image = p.Icon or "rbxassetid://0"
        i.BackgroundTransparency = 1

        x = x + 50

        local M_PageLeft = Instance.new("ScrollingFrame", M_TabHolders)
        M_PageLeft.Size = UDim2.new(0.435, 0, 1, 0)
        M_PageLeft.Position = UDim2.new(0, 0, 0, 0)
        M_PageLeft.BorderSizePixel = 0
        M_PageLeft.BackgroundTransparency = 1
        M_PageLeft.ScrollBarThickness = 0
        M_PageLeft.CanvasSize = UDim2.new(0, 0, 0, 100)
        M_PageLeft.AutomaticCanvasSize = Enum.AutomaticSize.Y
        M_PageLeft.Visible = false
        
        local M_Stroke = Instance.new("UIStroke", M_PageLeft)
            M_Stroke.Color = Color3.fromRGB(60, 60, 60)
            M_Stroke.Thickness = 0.5

        local M_Layout = Instance.new("UIListLayout", M_PageLeft)
        M_Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        M_Layout.SortOrder = Enum.SortOrder.LayoutOrder
        M_Layout.Padding = UDim.new(0, 10)

        table.insert(Tabs, b)
        table.insert(Pages, M_PageLeft)
        
        M_PageLeft.Visible = true

        b.MouseButton1Click:Connect(function()
            for _, page in pairs(Pages) do
                page.Visible = false
            end
            M_PageLeft.Visible = true
        end)

        local TabFunctions = {}

        function TabFunctions:NewToggle(Params)
            local M_ToggleOuter = Instance.new("Frame", M_PageLeft)  
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
                if ToggleState then
                    M_BToggle.BackgroundColor3 = Color3.fromRGB(0, 155, 51)
                    game.TweenService:Create(M_BToggle, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                Position = UDim2.new(0.5,0,0,0)
            }):Play()
                else
                    M_BToggle.BackgroundColor3 = Color3.fromRGB(155, 0, 51)
                    
                    game.TweenService:Create(M_BToggle, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                Position = UDim2.new(0,0,0,0)
            }):Play()
                end

                if Params.Call then
                    Params.Call(ToggleState)
                end
            end)
            end
            
            function TabFunctions:NewButton(Params)
            local M_ButtonOuter = Instance.new("Frame", M_PageLeft)
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
B_Name.Text = Params.Name
B_Name.TextSize = 14
B_Name.BackgroundTransparency = 1
B_Name.TextColor3 = Color3.new(255, 255, 255)
B_Name.Font = Enum.Font.GothamBold

local M_BImg = Instance.new("ImageButton", M_ButtonOuter)
M_BImg.Size = UDim2.new(0, 35, 0, 30)
M_BImg.Position = UDim2.new(0.775, 0, 0, 5)
M_BImg.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
M_BImg.Image = "rbxassetid://3944703587"
M_BImg.BackgroundColor3 = Color3.fromRGB(155, 0, 51)
M_BImg.ImageTransparency = 0
M_BImg.BackgroundTransparency = 1
            M_BImg.MouseButton1Click:Connect(Params.CallBack)
            end
            
            function TabFunctions:NewDropdown(Params)
    local M_DropDownOuter = Instance.new("Frame", M_PageLeft)
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
 M_DName.Text = "Select Item"
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
 M_DropDownBox.Text = "Skibidi"
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
        end

        return TabFunctions
    end

    return GUI
end

return Orilax
