local ESP = {}

local tracked = {}
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

_G.Setting = {
	Rainbow = false,
	Tracers = true,
	FillTransparency = 0.5,
	OutlineTransparency = 0,
	DistanceCheck = false
}

local function Tracer()
	local line = Drawing.new("Line")
	line.Visible = false
	line.Thickness = 1
	line.Color = Color3.new(1, 1, 1)
	return line
end

local function Highlight(Name)
	local Highlight = Instance.new("Highlight")
	Highlight.FillTransparency = _G.Setting.FillTransparency
	Highlight.OutlineTransparency = _G.Setting.OutlineTransparency
	Highlight.OutlineColor = _G.Setting.OutlineColor
	Highlight.Enabled = false
	return Highlight
end

local function Billboard(Name)
	local GuiEsp = Instance.new("BillboardGui")
	GuiEsp.Name = Name
	GuiEsp.Size = UDim2.new(0, 100, 0, 50)
	GuiEsp.AlwaysOnTop = true
	
	local GuiEspText = Instance.new("TextLabel", GuiEsp)
	GuiEspText.BackgroundTransparency = 1
	GuiEspText.Font = Enum.Font.Code
	GuiEspText.Size = UDim2.new(0, 100, 0, 100)
	GuiEspText.TextColor3 = Color3.new(0,0,0) 
	GuiEspText.TextStrokeTransparency = 0.5
	GuiEspText.TextScaled = true
	GuiEspText.Text = ""
	
	local GuiEspTextSizeConstraint = Instance.new("UITextSizeConstraint", GuiEspText)
	GuiEspTextSizeConstraint.MaxTextSize = 35
	
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Color = Color3.new(0, 0, 0)
	UIStroke.Thickness = 1.5
	UIStroke.Parent = GuiEspText
	
	return GuiEsp
end

function ESP:SetRainbow(Value)
	_G.Setting.Rainbow = Value
end

function ESP:SetTracers(Value)
	_G.Setting.Tracers = Value
end

function ESP:SetDistanceCheck(Value)
	_G.Setting.DistanceCheck = Value
end

function ESP:SetFillTransparency(value)
	_G.Setting.FillTransparency = value
end

function ESP:SetOutlineTransparency(value)
	_G.Setting.OutlineTransparency = value
end

function ESP:SetOutlineColor(color)
	_G.Setting.OutlineColor = color
end

function ESP:Add(Esp)
	Esp.Model = Esp.Model or nil
	Esp.Part = Esp.Part or Esp.Model or nil
	Esp.Color = Esp.Color or Color3.fromRGB(255, 0, 0)
	Esp.DisplayName = Esp.DisplayName or "Esp_Gui"
	Esp.Text = Esp.Text or ""
	
	if tracked[Esp.Model] then return end
	
	local Highlight = Highlight()
	Highlight.Adornee = Esp.Part
	Highlight.Parent = Esp.Model

	local Billboard = Billboard(Esp.DisplayName)
	Billboard.Adornee = Esp.Part
	Billboard.Parent = Esp.Model
	Billboard.Text = Esp.Text

	local tracer = createTracer()

	tracked[Esp.Model] = {
		model = Esp.Model,
		part = Esp.Part,
		highlight = Highlight,
		billboard = Billboard,
		tracer = tracer
	}
end

function ESP:Remove(model)
	local t = tracked[model]
	if t then
		if t.highlight then t.highlight:Destroy() end
		if t.billboard then t.billboard:Destroy() end
		if t.tracer then t.tracer:Remove() end
		tracked[model] = nil
	end
end

function ESP:Clear()
	for v in pairs(tracked) do
		self:Remove(v)
	end
end

function ESP:Update(Gui)
	Gui.Text = Gui.Text or ""
	Gui.Color = Gui.Color or Color3.new(0,0,0) 
	
	local v = tracked[model]
	if v then
		if v.highlight then
			if not _G.Setting.Rainbow then
				v.highlight.OutlineColor = Gui.Color
				v.highlight.FillColor = Gui.Color
			end
		end
		if v.tracer then
			if not _G.Setting.Rainbow then
				v.tracer.Color = Gui.Color
			end
		end
		if v.billboard:FindFirstChild("TextLabel") then
			v.billboard.TextLabel.Text = Gui.Text
			if _G.Setting.Rainbow then
				v.billboard.TextLabel.TextColor3 = Gui.Color
			end
		end
	end
end

RunService.RenderStepped:Connect(function()
	local viewportSize = Camera.ViewportSize
	for i, v in pairs(tracked) do
		local part = v.part
		if not part or not part:IsDescendantOf(workspace) then
			ESP:Remove(i)
			continue
		end
		local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)		
		local fullyVisible = onScreen and
			screenPos.Z > 0 and
			screenPos.X >= 0 and screenPos.X <= viewportSize.X and
			screenPos.Y >= 0 and screenPos.Y <= viewportSize.Y

		v.highlight.Enabled = fullyVisible
		v.billboard.Enabled = fullyVisible
		if v.tracer then
			v.tracer.Visible = fullyVisible and _G.Setting.Tracers
			if v.tracer.Visible then
				v.tracer.From = Vector2.new(viewportSize.X / 2, viewportSize.Y)
				v.tracer.To = Vector2.new(screenPos.X, screenPos.Y)
			end
		end

		if fullyVisible and _G.Setting.Rainbow then
			local t = tick() * 2
			local r = math.sin(t) * 0.5 + 0.5
			local g = math.sin(t + 2) * 0.5 + 0.5
			local b = math.sin(t + 4) * 0.5 + 0.5
			local c = Color3.new(r, g, b)
			v.highlight.FillColor = c
			if v.billboard:FindFirstChild("TextLabel") then
				v.billboard.TextLabel.TextColor3 = c
			end
			if v.tracer then
				v.tracer.Color = c
			end
		end
	end
end)

return ESP