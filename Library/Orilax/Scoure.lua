local Orilax = {}
local TweenService = game:GetService("TweenService")
local InputService = game:GetService("UserInputService")

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "Orilax"

local function Create(Name, Properties, Children)
	local Object = Instance.new(Name)
	for i, v in pairs(Properties or {}) do Object[i] = v end
	for i, v in pairs(Children or {}) do v.Parent = Object end
	return Object
end

local MainGui = Create("Frame", {
	Size = UDim2.new(0, 520, 0, 330),
	Position = UDim2.new(0.5, -260, 0.5, -160),
	BackgroundColor3 = Color3.fromRGB(24, 24, 24),
	Parent = gui,
	ClipsDescendants = true,
	Draggable = true,
}, {
	Create("UICorner", { CornerRadius = UDim.new(0, 10) })
})

local TopBar = Create("Frame", {
	Size = UDim2.new(1, 0, 0, 50),
	BackgroundColor3 = Color3.fromRGB(32, 32, 32),
	Parent = MainGui,
}, {
	Create("UICorner", { CornerRadius = UDim.new(0, 10) }),
	Create("TextLabel", {
		Size = UDim2.new(0, 150, 0, 50),
		Text = "Orilax Hub",
		TextSize = 20,
		Font = Enum.Font.GothamBold,
		TextColor3 = Color3.fromRGB(240, 240, 240),
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 10, 0, 0)
	})
})

local TabHolder = Create("ScrollingFrame", {
	Size = UDim2.new(0.96, 0, 0, 50),
	Position = UDim2.new(0, 10, 0, 60),
	BackgroundColor3 = Color3.fromRGB(19, 19, 19),
	ScrollBarThickness = 0,
	AutomaticCanvasSize = Enum.AutomaticSize.X,
	CanvasSize = UDim2.new(0, 0, 0, 50),
	Parent = MainGui
}, {
	Create("UICorner", { CornerRadius = UDim.new(0, 5) }),
	Create("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		Padding = UDim.new(0, 10),
		SortOrder = Enum.SortOrder.LayoutOrder
	})
})

local PageHolder = Create("Frame", {
	Size = UDim2.new(0.96, 0, 0.7, 0),
	Position = UDim2.new(0, 10, 0, 120),
	BackgroundColor3 = Color3.fromRGB(19, 19, 19),
	Parent = MainGui,
}, {
	Create("UICorner", { CornerRadius = UDim.new(0, 6) })
})

function Orilax:NewTab(TabName, Icon)
	local Tab = Create("TextButton", {
		Size = UDim2.new(0, 40, 0, 40),
		Text = "",
		BackgroundColor3 = Color3.fromRGB(29, 29, 29),
		Parent = TabHolder
	}, {
		Create("UICorner", { CornerRadius = UDim.new(0, 7) }),
		Create("ImageLabel", {
			Size = UDim2.new(0.8, 0, 0.8, 0),
			Position = UDim2.new(0.1, 0, 0.1, 0),
			BackgroundTransparency = 1,
			Image = Icon or "rbxassetid://0"
		})
	})

	local Page = Create("ScrollingFrame", {
		Size = UDim2.new(1, 0, 1, 0),
		Visible = false,
		BackgroundTransparency = 1,
		ScrollBarThickness = 0,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		Parent = PageHolder
	}, {
		Create("UIListLayout", {
			Padding = UDim.new(0, 10),
			SortOrder = Enum.SortOrder.LayoutOrder
		})
	})

	if not Orilax.CurrentPage then
		Orilax.CurrentPage = Page
		Page.Visible = true
	end

	Tab.MouseButton1Click:Connect(function()
		for _, page in pairs(PageHolder:GetChildren()) do
			if page:IsA("ScrollingFrame") then
				page.Visible = false
			end
		end
		Page.Visible = true
	end)

	return {
		CreateButton = function(self, params)
			local Button = Create("TextButton", {
				Size = UDim2.new(0, 200, 0, 40),
				Text = params.Text or "Button",
				BackgroundColor3 = Color3.fromRGB(32, 32, 32),
				TextColor3 = Color3.new(1, 1, 1),
				Font = Enum.Font.GothamBold,
				Parent = Page
			}, {
				Create("UICorner", { CornerRadius = UDim.new(0, 7) })
			})
			Button.MouseButton1Click:Connect(params.Callback)
		end,
		
		CreateToggle = function(self, params)
			local ToggleOuter = Create("Frame", {
				Size = UDim2.new(0, 200, 0, 40),
				BackgroundColor3 = Color3.fromRGB(32, 32, 32),
				Parent = Page
			}, {
				Create("UICorner", { CornerRadius = UDim.new(0, 7) }),
				Create("TextLabel", {
					Text = params.Text or "Toggle",
					Size = UDim2.new(0.6, 0, 1, 0),
					TextColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Position = UDim2.new(0.1, 0, 0, 0)
				})
			})

			local ToggleState = false
			local ToggleBtn = Create("ImageButton", {
				Size = UDim2.new(0, 40, 0, 40),
				Position = UDim2.new(0.8, 0, 0, 0),
				BackgroundColor3 = Color3.fromRGB(255, 0, 0),
				Parent = ToggleOuter
			}, {
				Create("UICorner", { CornerRadius = UDim.new(0, 7) })
			})

			ToggleBtn.MouseButton1Click:Connect(function()
				ToggleState = not ToggleState
				TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {
					BackgroundColor3 = ToggleState and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
				}):Play()
				params.Callback(ToggleState)
			end)
		end
	}
end

return Orilax
