local Orilax = {}

local tween = game:GetService("TweenService")
local input = game:GetService("User InputService")
local run = game:GetService("RunService")

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "Orilax"

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

function Orilax.CreateLib(params)
    Orilax.Name = params.Name or "Example Hub"
    Orilax.SubName = params.SubName or "Version 1.1.1.1"

    local M_Gui = Create("Frame", {
        Size = UDim2.new(0, 520, 0, 330),
        Position = UDim2.new(0.5, -254, 0.5, -154),
        BackgroundColor3 = Color3.fromRGB(24, 24, 24),
        Active = true,
        Draggable = true,
        ClipsDescendants = true
    }, { Create("UICorner", { CornerRadius = UDim.new(0, 10) }) })

    local M_Tomain = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 50),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(32, 32, 32),
        Active = false
    }, { Create("UICorner", { CornerRadius = UDim.new(0, 10) }) })

    Create("TextLabel", {
        Size = UDim2.new(0, 150, 0, 50),
        Position = UDim2.new(0, 10, 0, 5),
        Text = Orilax.Name,
        TextSize = 25,
        BackgroundTransparency = 1,
        TextColor3 = Color3.fromRGB(240, 240, 240),
        Font = Enum.Font.GothamBold,
        Parent = M_Tomain
    })

    Create("TextLabel", {
        Size = UDim2.new(0, 100, 0, 30),
        Position = UDim2.new(0, 150, 0, 17),
        Text = Orilax.SubName,
        TextSize = 15,
        BackgroundTransparency = 1,
        TextColor3 = Color3.fromRGB(150, 150, 150),
        Font = Enum.Font.GothamBold,
        Parent = M_Tomain
    })

    local M_MizeFrame = Create("Frame", {
        Size = UDim2.new(0, 100, 0, 40),
        Position = UDim2.new(0.75, 0, 0, 10),
        BackgroundColor3 = Color3.fromRGB(24, 24, 24),
        BorderSizePixel = 0
    }, { Create("UICorner", { CornerRadius = UDim.new(0, 10) }) })

    Create("ImageButton", {
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(0.5, 10, 0, 5),
        Image = "rbxassetid://7072725342",
        BackgroundTransparency = 1,
        Parent = M_MizeFrame
    })

    local M_Mimize = Create("ImageButton", {
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(0, 10, 0, 5),
        Image = "rbxassetid://7072719338",
        BackgroundTransparency = 1,
        Parent = M_MizeFrame
    })

    local M_TabHolder = Create("ScrollingFrame", {
        Size = UDim2.new(0.96, 0, 0, 50),
        Position = UDim2.new(0, 10, 0, 60),
        BackgroundColor3 = Color3.fromRGB(19, 19, 19),
        ScrollBarThickness = 0,
        CanvasSize = UDim2.new(0, 0, 0, 50
    }, { Create("UICorner", { CornerRadius = UDim.new(0, 5) }) })

    local Tabs = {}
    local x = 10

    function Tabs:NewTab(p)
        local b = Create("TextButton", {
            Size = UDim2.new(0, 40, 0, 40),
            Position = UDim2.new(0, x, 0, 5),
            BackgroundColor3 = Color3.fromRGB(29, 29, 29),
            Text = ""
        }, { Create("UICorner", { CornerRadius = UDim.new(0, 7) }) })

        local i = Create("ImageLabel", {
            Size = UDim2.new(0.8, 0, 0.8, 0),
            Position = UDim2.new(0, 4, 0, 4),
            Image = p.Icon or "rbxassetid://0",
            BackgroundTransparency = 1
        })

        x = x + 50

        local M_PageLeft = Create("ScrollingFrame", {
            Size = UDim2.new(0.435, 0, 1, 0),
            BackgroundTransparency = 1,
            ScrollBarThickness = 0,
            CanvasSize = UDim2.new(0, 0, 0, 100),
            AutomaticCanvasSize = Enum.AutomaticSize.Y
        }, { Create("UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 10) }) })

        Orilax.Elements[p.Name] = { Tab = b, Page = M_PageLeft }
    end

    function Tabs:CreateButton(params)
        local button = Create("TextButton", {
            Size = UDim2.new(0, 200, 0, 40),
            BackgroundColor3 = Color3.fromRGB(32, 32, 32),
            Text = params.Text or "Button",
            TextSize = 14,
            TextColor3 = Color3.new(255, 255, 255),
            Font = Enum.Font.GothamBold
        }, { Create("UICorner", { CornerRadius = UDim.new(0, 7) }) })

        button.MouseButton1Click:Connect(params.Callback)
        return button
    end

    function Tabs:CreateToggle(params)
        local toggle = Create("Frame", {
            Size = UDim2.new(0, 200, 0, 40),
            BackgroundColor3 = Color3.fromRGB(32, 32, 32)
        }, { Create("UICorner", { CornerRadius = UDim.new(0, 7) }) })

        local toggleButton = Create("ImageButton", {
            Size = UDim2.new(0.5, 0, 1, 0),
            BackgroundColor3 = Color3.fromRGB(155, 0, 51),
            ImageTransparency = 1
        })

        toggleButton.MouseButton1Click:Connect(function()
            toggleButton.ImageTransparency = toggleButton.ImageTransparency == 1 and 0 or 1
            if params.Callback then params.Callback(toggleButton.ImageTransparency == 0) end
        end)

        return toggle
    end

    function Tabs:CreateDropdown(params)
        local dropdown = Create("Frame", {
            Size = UDim2.new(0, 200, 0, 150),
            BackgroundColor3 = Color3.fromRGB(32, 32, 32)
        }, { Create("UICorner", { CornerRadius = UDim.new(0, 7) }) })

        local dropdownButton = Create("TextButton", {
            Size = UDim2.new(0, 60, 0, 30),
            BackgroundColor3 = Color3.fromRGB(24, 24, 24),
            Text = params.Text or "Select Item",
            TextSize = 14,
            TextColor3 = Color3.new(255, 255, 255),
            Font = Enum.Font.GothamBold
        })

        local itemList = Create("ScrollingFrame", {
            Size = UDim2.new(0.9, 0, 0.7, 0),
            Position = UDim2.new(0, 10, 0, 40),
            BackgroundColor3 = Color3.fromRGB(19, 19, 19),
            ScrollBarThickness = 0,
            CanvasSize = UDim2.new(0, 0, 0, 100),
            AutomaticCanvasSize = Enum.AutomaticSize.Y
        }, { Create("UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 10) }) })

        -- Populate dropdown items
        for _, item in ipairs(params.Items) do
            local itemButton = Create("TextButton", {
                Size = UDim2.new(0, 170, 0, 40),
                BackgroundColor3 = Color3.fromRGB(32, 32, 32),
                Text = item.Name,
                TextSize = 14,
                TextColor3 = Color3.new(255, 255, 255),
                Font = Enum.Font.GothamBold
            })

            itemButton.MouseButton1Click:Connect(function()
                dropdownButton.Text = item.Name
                if item.Callback then
                    item.Callback()
                end
            end)

            itemButton.Parent = itemList
        end

        dropdownButton.MouseButton1Click:Connect(function()
            itemList.Visible = not itemList.Visible
        end)

        dropdownButton.Parent = dropdown
        itemList.Parent = dropdown

        return dropdown
    end

    M_Mimize.MouseButton1Click:Connect(function()
        if M_Gui.Size.Y.Offset == 330 then
            M_Gui.Size = UDim2.new(0, 520, 0, 50)
            M_Tomain.Visible = true
            for _, child in pairs(M_Gui:GetChildren()) do
                if child ~= M_Tomain then
                    child.Visible = false
                end
            end
        else
            M_Gui.Size = UDim2.new(0, 520, 0, 330)
            for _, child in pairs(M_Gui:GetChildren()) do
                child.Visible = true
            end
        end
    end)

    return Tabs
end

return Orilax
