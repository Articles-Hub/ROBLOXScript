local fix = {}
fix.__index = fix
self = setmetatable({}, fix)

local function test(name, callback)
	local success, result = pcall(callback)
	self[name] = success
end

test("fireclickdetector", function()
    local click = Instance.new("ClickDetector")
    fireclickdetector(click, 50, "MouseHoverEnter")
end)

test("fireproximityprompt", function()
    local prompt = Instance.new("ProximityPrompt", Instance.new("Part"))
    prompt.Enabled = true
    fireproximityprompt(prompt)
end)

for i, v in pairs(self) do
	if type(v) == "boolean" then
		print(i, ":", v == true and "Success" or "Failed")
	end
end

if not self.fireproximityprompt then
	function fix.fireproximityprompt(proximityprompt, amount, skip)
		assert(typeof(proximityprompt) == "Instance", "invalid argument #1 to 'fireproximityprompt' (Instance expected, got " .. typeof(proximityprompt) .. ") ", 2)
		assert(proximityprompt:IsA("ProximityPrompt"), "invalid argument #1 to 'fireproximityprompt' (ProximityPrompt expected, got " .. proximityprompt.ClassName .. ") ", 2)
		amount = amount or 1
		skip = skip or false
		assert(type(amount) == "number", "invalid argument #2 to 'fireproximityprompt' (number expected, got " .. type(amount) .. ") ", 2)
		assert(type(skip) == "boolean", "invalid argument #2 to 'fireproximityprompt' (boolean expected, got " .. type(amount) .. ") ", 2)
		local oldHoldDuration = proximityprompt.HoldDuration
		local oldMaxDistance = proximityprompt.MaxActivationDistance
		proximityprompt.MaxActivationDistance = 9e9
		proximityprompt:InputHoldBegin()
		for i = 1, amount or 1 do
			if skip then
				proximityprompt.HoldDuration = 0
			else
				task.wait(proximityprompt.HoldDuration + 0.01)
			end
		end
		proximityprompt:InputHoldEnd()
		proximityprompt.MaxActivationDistance = oldMaxDistance
		proximityprompt.HoldDuration = oldHoldDuration
	end
end

if not self.fireclickdetector then
	function fix.fireclickdetector(part)
		assert(typeof(part) == "Instance", "invalid argument #1 to 'fireclickdetector' (Instance expected, got " .. type(part) .. ") ", 2)
		local clickDetector = part:FindFirstChild("ClickDetector") or part
		local previousParent = clickDetector.Parent
		local newPart = Instance.new("Part", workspace)
		newPart.Transparency = 1
		newPart.Size = Vector3.new(30, 30, 30)
		newPart.Anchored = true
		newPart.CanCollide = false
		delay(15, function()
			if newPart:IsDescendantOf(game) then
				newPart:Destroy()
			end
		end)
		clickDetector.Parent = newPart
		clickDetector.MaxActivationDistance = math.huge
		local vUser = game:FindService("VirtualUser") or game:GetService("VirtualUser")
		local connection = RunService.Heartbeat:Connect(function()
			local camera = workspace.CurrentCamera or workspace.Camera
			newPart.CFrame = camera.CFrame * CFrame.new(0, 0, -20) * CFrame.new(camera.CFrame.LookVector.X, camera.CFrame.LookVector.Y, camera.CFrame.LookVector.Z)
			vUser:ClickButton1(Vector2.new(20, 20), camera.CFrame)
		end)
		clickDetector.MouseClick:Once(function()
			connection:Disconnect()
			clickDetector.Parent = previousParent
			newPart:Destroy()
		end)
	end
end

return fix, self