if not game:IsLoaded() then
    game.Loaded:Wait()
end

function identifyexecutor()
   return "Executor"
end

if game.CoreGui:FindFirstChild("Execute") == nil then
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "Execute"

if game.CoreGui.Execute:FindFirstChild("ToggleUi1") == nil then
local TOGGLE = {}
TOGGLE["Ui"] = Instance.new("ScreenGui", gui)
TOGGLE["DaIcon"] = Instance.new("ImageButton", TOGGLE["Ui"])
TOGGLE["das"] = Instance.new("UICorner", TOGGLE["DaIcon"])

TOGGLE["Ui"].Name = "ToggleUi1"
TOGGLE["Ui"].ResetOnSpawn = false

TOGGLE["DaIcon"].Size = UDim2.new(0,45,0,45)
local DaIconPositionX = game:GetService("GuiService"):GetScreenResolution().X / 2 - TOGGLE["DaIcon"].Size.X.Offset / 2
local DaIconPositionY = game:GetService("GuiService"):GetScreenResolution().Y / 2 - TOGGLE["DaIcon"].Size.Y.Offset / 2
TOGGLE["DaIcon"].Position = UDim2.new(0,DaIconPositionX,0,DaIconPositionY/20)
TOGGLE["DaIcon"].Draggable = true
TOGGLE["DaIcon"].Image = "rbxassetid://7734091286"
TOGGLE["DaIcon"].BackgroundColor3 = Color3.fromRGB(255, 186, 117)
TOGGLE["DaIcon"].BorderColor3 = Color3.fromRGB(255, 186, 117)
task.spawn(function()
while true do
    for i = 0, 255, 4 do
        TOGGLE["DaIcon"].BorderColor3 = Color3.fromHSV(i/256, 1, 1)
        TOGGLE["DaIcon"].BackgroundColor3 = Color3.fromHSV(i/256, .5, .8)
        wait()
    end
end
end)
TOGGLE["DaIcon"].MouseButton1Click:Connect(function()
game.CoreGui.Execute.Frame.Visible = not game.CoreGui.Execute.Frame.Visible
end)
TOGGLE["das"]["CornerRadius"] = UDim.new(0.20000000298023224, 0)
end

------// Clear Script \\------

function CreateClear(Name,call)
if game.CoreGui.Execute:FindFirstChild(Name) ~= nil then
game.CoreGui.Execute:FindFirstChild(Name):Destroy()
else
local StartClear = Instance.new("Frame")
StartClear.Name = Name
StartClear.Size = UDim2.new(0.4, 0, 0.35, 0)
StartClear.Position = UDim2.new(0.3, 0, 0.3, 0)
StartClear.BackgroundColor3 = Color3.new(1, 1, 1)
StartClear.Active = true
StartClear.BackgroundTransparency = 0 
StartClear.Draggable = true
StartClear.Parent = gui

local LabelClear = Instance.new("TextLabel")
LabelClear.Size = UDim2.new(0.95, 0, 0.35, 0)
LabelClear.Position = UDim2.new(0.025, 0, 0.08, 0)
LabelClear.BackgroundColor3 = Color3.new(1,1,1)
LabelClear.Text = "Are You Ready To "..Name
LabelClear.TextSize = 11
LabelClear.TextWrapped = true
LabelClear.TextColor3 = Color3.new(0,0,0)
LabelClear.Parent = StartClear

local YesClear = Instance.new("TextButton")
YesClear.Size = UDim2.new(0.4, 0, 0.4, 0)
YesClear.Position = UDim2.new(0.06, 0, 0.5, 0)
YesClear.BackgroundColor3 = Color3.new(1,1,1)
YesClear.Text = "Yes"
YesClear.TextSize = 15
YesClear.BackgroundTransparency = 0
YesClear.TextColor3 = Color3.new(0,0,0)
YesClear.Parent = StartClear
YesClear.MouseButton1Click:Connect(function()
pcall(call)
game.CoreGui.Execute:FindFirstChild(Name):Destroy()
end)

local NoClear = Instance.new("TextButton")
NoClear.Size = UDim2.new(0.4, 0, 0.4, 0)
NoClear.Position = UDim2.new(0.52, 0, 0.5, 0)
NoClear.BackgroundColor3 = Color3.new(1,1,1)
NoClear.Text = "No"
NoClear.TextSize = 15
NoClear.TextColor3 = Color3.new(0,0,0)
NoClear.Parent = StartClear
NoClear.MouseButton1Click:Connect(function()
game.CoreGui.Execute:FindFirstChild(Name):Destroy()
end)
end
end

_G.ExecuteKey = {
	["Execute"] = Enum.KeyCode.L,
	["ONOFF"] = Enum.KeyCode.RightShift,
	["Copyscript"] = Enum.KeyCode.C,
	["Clearscript"] = Enum.KeyCode.O,
	["OpenCloseScriptHub"] = Enum.KeyCode.P,
	["OpenCloseChooseUi"] = Enum.KeyCode.U
}

KeyCodeBo = game:GetService("UserInputService").InputBegan:Connect(function(input)
if _G.KeyboardExecute == true then
if input.KeyCode == _G.ExecuteKey["Execute"] then
if game.CoreGui:FindFirstChild("Execute") and game.CoreGui.Execute:FindFirstChild("Frame") and game.CoreGui.Execute.Frame:FindFirstChild("ScriptTextBox") then
for i,v in pairs(game.CoreGui.Execute.Frame:GetChildren()) do
if v:IsA("TextBox") then
if v.Visible == true then
local func, err = loadstring(v.Text)
        if func then
            pcall(func)
        else
            print(err)
      end
end
end
end
end
elseif input.KeyCode == _G.ExecuteKey["ONOFF"] then
if game.CoreGui:FindFirstChild("Execute") and game.CoreGui.Execute:FindFirstChild("Frame") then
game.CoreGui.Execute.Frame.Visible = not game.CoreGui.Execute.Frame.Visible
end
elseif input.KeyCode == _G.ExecuteKey["Copyscript"] then
if game.CoreGui:FindFirstChild("Execute") and game.CoreGui.Execute:FindFirstChild("Frame") then
for i,v in pairs(game.CoreGui.Execute.Frame:GetChildren()) do
if v:IsA("TextBox") then
if v.Visible == true then
setclipboard(v.Text)
end
end
end
end
elseif input.KeyCode == _G.ExecuteKey["Clearscript"] then
if game.CoreGui:FindFirstChild("Execute") and game.CoreGui.Execute:FindFirstChild("Frame") then
CreateClear("Clear script?", function()
for i,v in pairs(game.CoreGui.Execute.Frame:GetChildren()) do
if v:IsA("TextBox") then
if v.Visible == true then
v.Text = ""
end
end
end
end)
end
elseif input.KeyCode == _G.ExecuteKey["OpenCloseScriptHub"] then
if game.CoreGui.Execute.Frame1.Visible == false then
game.CoreGui.Execute.Frame1.Visible = true
else
game.CoreGui.Execute.Frame1.Visible = false
end
elseif input.KeyCode == _G.ExecuteKey["OpenCloseChooseUi"] then
if game.CoreGui.Execute.Frame6New.Visible == false then
game.CoreGui.Execute.Frame6New.Visible = true
else
game.CoreGui.Execute.Frame6New.Visible = false
end
end
end
end)

------// Execute | Ui Library \\------

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0.6, 0, 0.7, 0)
Frame.Position = UDim2.new(0.2, 0, 0.1, 0)
Frame.BackgroundColor3 = Color3.new(1, 1, 1)
Frame.Active = true
Frame.Draggable = true
Frame.Parent = gui

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(1, 0, 0.15, 0)
TextLabel.Position = UDim2.new(0, 0, 0, 0)
TextLabel.BackgroundColor3 = Color3.new(255, 255, 255)
TextLabel.Text = "Execute | Ui Library"
TextLabel.TextSize = 15
TextLabel.BackgroundTransparency = 0 
TextLabel.TextColor3 = Color3.new(0,0,0)
TextLabel.Parent = Frame

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.1, 0, 0.15, 0)
TextButton.Position = UDim2.new(0.9, 0, 0, 0)
TextButton.BackgroundColor3 = Color3.new(255,255,255)
TextButton.Text = "X"
TextButton.TextSize = 18
TextButton.BackgroundTransparency = 1
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = Frame
TextButton.MouseButton1Click:Connect(function()
gui:Destroy()
end)

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.1, 0, 0.15, 0)
TextButton.Position = UDim2.new(0.8, 0, 0, 0)
TextButton.BackgroundColor3 = Color3.new(255,255,255)
TextButton.Text = "-"
TextButton.TextSize = 18
TextButton.BackgroundTransparency = 1
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = Frame
TextButton.MouseButton1Click:Connect(function()
game.CoreGui.Execute.Frame.Visible = false
end)

local TextBox = Instance.new("TextBox")
TextBox.Name = "ScriptTextBox"
TextBox.Size = UDim2.new(1, 0, 0.57, 0)
TextBox.Position = UDim2.new(0, 0, 0.154, 0)
TextBox.BackgroundColor3 = Color3.new(255,255,255)
TextBox.Text = ""
TextBox.PlaceholderText = "Welcome To Execute | Ui library, Get Some You Have Insert the Script so it can be Execute"
TextBox.TextXAlignment = Enum.TextXAlignment.Left
TextBox.TextYAlignment = Enum.TextYAlignment.Top
TextBox.TextWrapped = true
TextBox.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
TextBox.ClipsDescendants = true
TextBox.MultiLine = true
TextBox.ClearTextOnFocus = false
TextBox.TextColor3 = Color3.new(0,0,0)
TextBox.TextSize = 15
TextBox.Parent = Frame

local TextButton = Instance.new("TextButton")
TextButton.Name = "ExecuteNow"
TextButton.Size = UDim2.new(0.2, 0, 0.28, 0)
TextButton.Position = UDim2.new(0, 0, 0.72, 0)
TextButton.BackgroundColor3 = Color3.new(255,255,255)
TextButton.Text = "Execute"
TextButton.TextSize = 10
TextButton.BackgroundTransparency = 0 
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = Frame
TextButton.MouseButton1Click:Connect(function()
for i,v in pairs(game.CoreGui.Execute.Frame:GetChildren()) do
if v:IsA("TextBox") then
if v.Visible == true then
local func, err = loadstring(v.Text)
        if func then
            pcall(func)
        else
            print(err)
      end
end
end
end
end)

local TextButton = Instance.new("TextButton")
TextButton.Name = "ClearNow"
TextButton.Size = UDim2.new(0.2, 0, 0.28, 0)
TextButton.Position = UDim2.new(0.2, 0, 0.72, 0)
TextButton.BackgroundColor3 = Color3.new(255,255,255)
TextButton.Text = "Clear"
TextButton.TextSize = 10
TextButton.BackgroundTransparency = 0 
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = Frame
TextButton.MouseButton1Click:Connect(function()
CreateClear("Clear script?", function()
for i,v in pairs(game.CoreGui.Execute.Frame:GetChildren()) do
if v:IsA("TextBox") then
if v.Visible == true then
v.Text = ""
end
end
end
end)
end)

local TextButton = Instance.new("TextButton")
TextButton.Name = "CopyScriptNow"
TextButton.Size = UDim2.new(0.2, 0, 0.28, 0)
TextButton.Position = UDim2.new(0.4, 0, 0.72, 0)
TextButton.BackgroundColor3 = Color3.new(255,255,255)
TextButton.Text = "Copy Script"
TextButton.TextSize = 10
TextButton.BackgroundTransparency = 0 
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = Frame
TextButton.MouseButton1Click:Connect(function()
for i,v in pairs(game.CoreGui.Execute.Frame:GetChildren()) do
if v:IsA("TextBox") then
if v.Visible == true then
setclipboard(v.Text)
end
end
end
end)

local ButtonClipBoard = Instance.new("TextButton")
ButtonClipBoard.Name = "ButtonClipBoardNow"
ButtonClipBoard.Size = UDim2.new(0.2, 0, 0.28, 0)
ButtonClipBoard.Position = UDim2.new(0.6, 0, 0.72, 0)
ButtonClipBoard.BackgroundColor3 = Color3.new(255,255,255)
ButtonClipBoard.Text = "Execute Clipboard"
ButtonClipBoard.TextSize = 10
ButtonClipBoard.TextWrapped = true
ButtonClipBoard.TextColor3 = Color3.new(0,0,0)
ButtonClipBoard.Parent = Frame
ButtonClipBoard.MouseButton1Click:Connect(function()
if getclipboard then
local func, err = loadstring(getclipboard())
        if func then
            pcall(func)
        else
            print(err)
      end
elseif not getclipboard then
for i,v in pairs(game.CoreGui.Execute.Frame:GetChildren()) do
if v:IsA("TextBox") then
if v.Visible == true then
v.Text = "Not only executor you bruh, Chill Guys"
end
end
end
end
end)

local TextButton = Instance.new("TextButton")
TextButton.Name = "ScriptHub"
TextButton.Size = UDim2.new(0.2, 0, 0.28, 0)
TextButton.Position = UDim2.new(0.8, 0, 0.72, 0)
TextButton.BackgroundColor3 = Color3.new(255,255,255)
TextButton.Text = "Script Hub"
TextButton.TextSize = 10
TextButton.BackgroundTransparency = 0 
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = Frame
TextButton.MouseButton1Click:Connect(function()
if game.CoreGui.Execute.Frame1.Visible == false then
game.CoreGui.Execute.Frame1.Visible = true
else
game.CoreGui.Execute.Frame1.Visible = false
end
end)

local ImageButton = Instance.new("ImageButton")
ImageButton.Size = UDim2.new(0.1, 0, 0.15, 0)
ImageButton.Position = UDim2.new(0, 0, 0, 0)
ImageButton.BackgroundColor3 = Color3.new(255,255,255)
ImageButton.ImageColor3 = Color3.new(0,0,0)
ImageButton.Image = "rbxassetid://4370318685"
ImageButton.Parent = Frame
ImageButton.MouseButton1Click:Connect(function()
game.CoreGui.Execute.Frame.Frame6.Visible = not game.CoreGui.Execute.Frame.Frame6.Visible
end)

local Frame6 = Instance.new("Frame")
Frame6.Name = "Frame6"
Frame6.Size = UDim2.new(0.28, 0, 1, 0)
Frame6.Position = UDim2.new(-0.29, 0, 0, 0)
Frame6.BackgroundColor3 = Color3.new(1, 1, 1)
Frame6.Active = true
Frame6.Visible = false
Frame6.Parent = Frame

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollingFrame.Position = UDim2.new(0, 0, 0, 0)
ScrollingFrame.BackgroundColor3 = Color3.new(1, 1, 1)
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 186, 117)
ScrollingFrame.ScrollBarThickness = 0
ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollingFrame.Parent = Frame6

local Ui = Instance.new("UIListLayout")
Ui.HorizontalAlignment = Enum.HorizontalAlignment.Center
Ui.SortOrder = Enum.SortOrder.LayoutOrder
Ui.Padding = UDim.new(0, 10)
Ui.Parent = ScrollingFrame

local Padding = Instance.new("UIPadding")
Padding.PaddingTop = UDim.new(0, 10)
Padding.Parent = ScrollingFrame

function ButtonChoose(Name, Call)
local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.8, 0, 0.13, 0)
TextButton.Position = UDim2.new(0, 0, 0, 0)
TextButton.BackgroundColor3 = Color3.new(255,255,255)
TextButton.Text = Name
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = ScrollingFrame
TextButton.MouseButton1Click:Connect(function()
pcall(Call)
end)
end

ButtonChoose("Setting", function()
if game.CoreGui.Execute.Frame10.Visible == false then
game.CoreGui.Execute.Frame10.Visible = true
else
game.CoreGui.Execute.Frame10.Visible = false
end
end)

ButtonChoose("Cloud", function()
if game.CoreGui.Execute.Frame13.Visible == false then
game.CoreGui.Execute.Frame13.Visible = true
else
game.CoreGui.Execute.Frame13.Visible = false
end
end)

ButtonChoose("Save Script", function()
if game.CoreGui.Execute.Frame15.Visible == false then
game.CoreGui.Execute.Frame15.Visible = true
else
game.CoreGui.Execute.Frame15.Visible = false
end
end)

ButtonChoose("Script Tab", function()
if game.CoreGui.Execute.Frame23.Visible == false then
game.CoreGui.Execute.Frame23.Visible = true
else
game.CoreGui.Execute.Frame23.Visible = false
end
end)

ButtonChoose("Console", function()
if game.CoreGui.Execute.Frame24.Visible == false then
game.CoreGui.Execute.Frame24.Visible = true
else
game.CoreGui.Execute.Frame24.Visible = false
end
end)

ButtonChoose("Search Player", function()
if game.CoreGui.Execute.Frame26.Visible == false then
game.CoreGui.Execute.Frame26.Visible = true
else
game.CoreGui.Execute.Frame26.Visible = false
end
end)

ButtonChoose("Dex V0.6", function()
if game.CoreGui.Execute.Frame29.Visible == false then
game.CoreGui.Execute.Frame29.Visible = true
else
game.CoreGui.Execute.Frame29.Visible = false
end
end)

--------// Clone Frame 6 \\---------

local Frame6New = Instance.new("Frame")
Frame6New.Name = "Frame6New"
Frame6New.Size = UDim2.new(0.17, 0, 0.7, 0)
Frame6New.Position = UDim2.new(0.1, 0, 0.1, 0)
Frame6New.BackgroundColor3 = Color3.new(1, 1, 1)
Frame6New.Active = true
Frame6New.BackgroundTransparency = 1
Frame6New.Draggable = true
Frame6New.Visible = false
Frame6New.Parent = gui

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(1, 0, 0.1, 0)
TextButton.Position = UDim2.new(0, 0, -0.12, 0)
TextButton.BackgroundColor3 = Color3.new(255, 255, 255)
TextButton.Text = "X"
TextButton.TextSize = 10
TextButton.BackgroundTransparency = 0 
TextButton.TextColor3 = Color3.new(0, 0, 0)
TextButton.Parent = Frame6New
TextButton.MouseButton1Click:Connect(function()
game.CoreGui.Execute.Frame6New.Visible = false
end)

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollingFrame.Position = UDim2.new(0, 0, 0, 0)
ScrollingFrame.BackgroundColor3 = Color3.new(1, 1, 1)
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 186, 117)
ScrollingFrame.ScrollBarThickness = 0
ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollingFrame.Parent = Frame6New

local Ui = Instance.new("UIListLayout")
Ui.HorizontalAlignment = Enum.HorizontalAlignment.Center
Ui.SortOrder = Enum.SortOrder.LayoutOrder
Ui.Padding = UDim.new(0, 10)
Ui.Parent = ScrollingFrame

local Padding = Instance.new("UIPadding")
Padding.PaddingTop = UDim.new(0, 10)
Padding.Parent = ScrollingFrame

function ButtonChooseClone(Name, Call)
local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.8, 0, 0.13, 0)
TextButton.Position = UDim2.new(0, 0, 0, 0)
TextButton.BackgroundColor3 = Color3.new(255,255,255)
TextButton.Text = Name
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = ScrollingFrame
TextButton.MouseButton1Click:Connect(function()
pcall(Call)
end)
end

ButtonChooseClone("Setting", function()
if game.CoreGui.Execute.Frame10.Visible == false then
game.CoreGui.Execute.Frame10.Visible = true
else
game.CoreGui.Execute.Frame10.Visible = false
end
end)

ButtonChooseClone("Cloud", function()
if game.CoreGui.Execute.Frame13.Visible == false then
game.CoreGui.Execute.Frame13.Visible = true
else
game.CoreGui.Execute.Frame13.Visible = false
end
end)

ButtonChooseClone("Save Script", function()
if game.CoreGui.Execute.Frame15.Visible == false then
game.CoreGui.Execute.Frame15.Visible = true
else
game.CoreGui.Execute.Frame15.Visible = false
end
end)

ButtonChooseClone("Script Tab", function()
if game.CoreGui.Execute.Frame23.Visible == false then
game.CoreGui.Execute.Frame23.Visible = true
else
game.CoreGui.Execute.Frame23.Visible = false
end
end)

ButtonChooseClone("Console", function()
if game.CoreGui.Execute.Frame24.Visible == false then
game.CoreGui.Execute.Frame24.Visible = true
else
game.CoreGui.Execute.Frame24.Visible = false
end
end)

ButtonChooseClone("Search Player", function()
if game.CoreGui.Execute.Frame26.Visible == false then
game.CoreGui.Execute.Frame26.Visible = true
else
game.CoreGui.Execute.Frame26.Visible = false
end
end)

ButtonChooseClone("Dex V0.6", function()
if game.CoreGui.Execute.Frame29.Visible == false then
game.CoreGui.Execute.Frame29.Visible = true
else
game.CoreGui.Execute.Frame29.Visible = false
end
end)

--------// Script Hub \\-------

local Frame1 = Instance.new("Frame")
Frame1.Name = "Frame1"
Frame1.Size = UDim2.new(0.5, 0, 0.8, 0)
Frame1.Position = UDim2.new(0.2, 0, 0.1, 0)
Frame1.BackgroundColor3 = Color3.new(1, 1, 1)
Frame1.Active = true
Frame1.BackgroundTransparency = 0 
Frame1.Draggable = true
Frame1.Visible = false
Frame1.Parent = gui

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(1, 0, 0.13, 0)
TextLabel.Position = UDim2.new(0, 0, 0, 0)
TextLabel.BackgroundColor3 = Color3.new(255, 255, 255)
TextLabel.Text = "Script Hub | Ui Library"
TextLabel.TextSize = 10
TextLabel.BackgroundTransparency = 0 
TextLabel.TextColor3 = Color3.new(0, 0, 0)
TextLabel.Parent = Frame1

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.15, 0, 1, 0)
TextButton.Position = UDim2.new(0.85, 0, 0, 0)
TextButton.BackgroundColor3 = Color3.new(255, 255, 255)
TextButton.Text = "X"
TextButton.TextSize = 15
TextButton.BackgroundTransparency = 1
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = TextLabel
TextButton.MouseButton1Click:Connect(function()
game.CoreGui.Execute.Frame1.Visible = false
end)

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(0.94, 0, 0.13, 0)
TextBox.Position = UDim2.new(0.03, 0, 0.18, 0)
TextBox.BackgroundColor3 = Color3.new(255, 255, 255)
TextBox.Text = ""
TextBox.TextColor3 = Color3.new(0, 0, 0)
TextBox.BackgroundTransparency = 0
TextBox.TextSize = 10
TextBox.Parent = Frame1
TextBox.Changed:Connect(function()
	if TextBox.Text:lower() ~= "" then
		for i,v in pairs(game.CoreGui.Execute.Frame1.ScrollingFrame:GetDescendants()) do
			if v:IsA("TextButton") then
				if string.find(v.Text:lower(), TextBox.Text:lower()) then
					v.Visible = true
				else
					v.Visible = false
				end
			end
		end
	else
		for i, v in pairs(game.CoreGui.Execute.Frame1.ScrollingFrame:GetDescendants()) do
			if v:IsA("TextButton") then
				v.Visible = true
			end
		end
	end
end)

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(0.94, 0, 0.6, 0)
ScrollingFrame.Position = UDim2.new(0.03, 0, 0.35, 0)
ScrollingFrame.BackgroundColor3 = Color3.new(1, 1, 1)
ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollingFrame.ScrollBarThickness = 0
ScrollingFrame.Parent = Frame1

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.Parent = ScrollingFrame

local Padding = Instance.new("UIPadding")
Padding.PaddingTop = UDim.new(0, 8)
Padding.Parent = ScrollingFrame

function CreatorButton(Name, call)
local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.9, 0, 0.23, 0)
TextButton.Position = UDim2.new(0, 0, 0, 0)
TextButton.BackgroundColor3 = Color3.new(255, 255, 255)
TextButton.Text = Name
TextButton.TextSize = 10
TextButton.BackgroundTransparency = 0 
TextButton.TextColor3 = Color3.new(0, 0, 0)
TextButton.Parent = ScrollingFrame
TextButton.MouseButton1Click:Connect(function()
pcall(call)
end)
end

CreatorButton("Fly PE", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Giangplay/Script/main/Fly_V3.lua"))()
end)

CreatorButton("Inf Yield Delta", function()
loadstring(game:HttpGet("https://gist.githubusercontent.com/lxnnydev/c533c374ca4c1dcef4e1e10e33fa4a0c/raw/03e74f184f801dad77d3ebe1e2f18c6ac87ca612/delta___IY.gistfile1.txt.lua",true))()
end)

CreatorButton("Inf Yield", function()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()
end)

CreatorButton("Dex V4", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/SCRIPT/Dex-v4.lua"))()
end)

CreatorButton("Dex V3", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()
end)

CreatorButton("Dex V2", function()
loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Dex%20Explorer.txt"))()
wait(2)
repeat task.wait()
if game.Players.LocalPlayer.PlayerGui:FindFirstChild("Dex") and game.Players.LocalPlayer.PlayerGui.Dex.ResetOnSpawn == true then
game.Players.LocalPlayer.PlayerGui.Dex.ResetOnSpawn = false
end
until game.Players.LocalPlayer.PlayerGui:FindFirstChild("Dex") and game.Players.LocalPlayer.PlayerGui.Dex.ResetOnSpawn == false
end)

CreatorButton("Anti AFK", function()
if getconnections then
for i,v in next, getconnections(game.Players.LocalPlayer.Idled) do
v:Disable() 
end
end
end)

CreatorButton("Simple Spy", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/SCRIPT/SimpleSpy/SourceBeta.lua"))()
end)

CreatorButton("Fly Gui", function()
if game.CoreGui.Execute.FlyGot.Visible == false then
game.CoreGui.Execute.FlyGot.Visible = true
else
game.CoreGui.Execute.FlyGot.Visible = false
end
end)

CreatorButton("Postiton & CFrame", function()
if game.CoreGui.Execute.Frame19.Visible == false then
game.CoreGui.Execute.Frame19.Visible = true
else
game.CoreGui.Execute.Frame19.Visible = false
end
end)

CreatorButton("Postiton & CFrame Player", function()
if game.CoreGui.Execute.Frame20.Visible == false then
game.CoreGui.Execute.Frame20.Visible = true
else
game.CoreGui.Execute.Frame20.Visible = false
end
end)

CreatorButton("Shift lock", function()
if game.CoreGui.Execute.ShiftLockButton.Visible == false then
game.CoreGui.Execute.ShiftLockButton.Visible = true
else
game.CoreGui.Execute.ShiftLockButton.Visible = false
end
end)

-----// Setting \\-----

local SettingF = Instance.new("Frame")
SettingF.Name = "Frame10"
SettingF.Size = UDim2.new(0.5, 0, 0.8, 0)
SettingF.Position = UDim2.new(0.2, 0, 0, 0)
SettingF.BackgroundColor3 = Color3.new(1, 1, 1)
SettingF.Active = true
SettingF.Visible = false
SettingF.Draggable = true
SettingF.Parent = gui

local SettingL = Instance.new("TextLabel")
SettingL.Size = UDim2.new(1, 0, 0.13, 0)
SettingL.Position = UDim2.new(0, 0, 0, 0)
SettingL.BackgroundColor3 = Color3.new(1,1,1)
SettingL.Text = "Setting | Ui Library"
SettingL.TextSize = 10
SettingL.TextColor3 = Color3.new(0,0,0)
SettingL.Parent = SettingF

local SettingX = Instance.new("TextButton")
SettingX.Size = UDim2.new(0.12, 0, 0.13, 0)
SettingX.Position = UDim2.new(0.88, 0, 0, 0)
SettingX.BackgroundColor3 = Color3.new(1,1,1)
SettingX.Text = "X"
SettingX.TextSize = 10
SettingX.BackgroundTransparency = 1
SettingX.TextColor3 = Color3.new(0,0,0)
SettingX.Parent = SettingF
SettingX.MouseButton1Click:Connect(function()
game.CoreGui.Execute.Frame10.Visible = false
end)

local SettingSC = Instance.new("ScrollingFrame")
SettingSC.Size = UDim2.new(1, 0, 0.867, 0)
SettingSC.Position = UDim2.new(0, 0, 0.134, 0)
SettingSC.BackgroundColor3 = Color3.new(1, 1, 1)
SettingSC.ScrollBarImageColor3 = Color3.fromRGB(255, 186, 117)
SettingSC.AutomaticCanvasSize = Enum.AutomaticSize.Y
SettingSC.Parent = SettingF

local Ui = Instance.new("UIListLayout")
Ui.HorizontalAlignment = Enum.HorizontalAlignment.Center
Ui.SortOrder = Enum.SortOrder.LayoutOrder
Ui.Padding = UDim.new(0, 5)
Ui.Parent = SettingSC

------// Toggle \\-------

function CreateToggle(Name,call,Winds)
local SettingL2 = Instance.new("TextLabel")
SettingL2.Size = UDim2.new(0.8, 0, 0.2, 0)
SettingL2.Position = UDim2.new(0, 0, 0, 0)
SettingL2.BackgroundColor3 = Color3.new(1, 1, 1)
SettingL2.Text = Name
SettingL2.TextSize = 10
SettingL2.TextXAlignment = Enum.TextXAlignment.Left
SettingL2.BackgroundTransparency = 0 
SettingL2.TextColor3 = Color3.new(0,0,0)
SettingL2.Parent = SettingSC

_G.ToggleGet = false
local SettingToggle = Instance.new("ImageButton")
SettingToggle.Size = UDim2.new(0.14, 0, 0.8, 0)
SettingToggle.Position = UDim2.new(0.83, 0, 0.1, 0)
SettingToggle.BackgroundColor3 = Color3.fromRGB(255, 186, 117)
SettingToggle.ImageColor3 = Color3.fromRGB(245, 21, 17)
SettingToggle.Image = "rbxassetid://7743878857"
SettingToggle.Parent = SettingL2
SettingToggle.MouseButton1Click:Connect(function()
_G.ToggleGet = not _G.ToggleGet
SettingToggle.Image = (_G.ToggleGet and "rbxassetid://3944680095") or "rbxassetid://7743878857"
SettingToggle.ImageColor3 = (_G.ToggleGet and Color3.fromRGB(17, 245, 97)) or Color3.fromRGB(245, 21, 17)
pcall(call,_G.ToggleGet)
end)
end

------// Button \\-------

function CreateButton(Name,call)
local SettingB = Instance.new("TextButton")
SettingB.Size = UDim2.new(0.8, 0, 0.2, 0)
SettingB.Position = UDim2.new(0, 0, 0, 0)
SettingB.BackgroundColor3 = Color3.new(1,1,1)
SettingB.Text = Name
SettingB.TextWrapped = true
SettingB.TextSize = 10
SettingB.TextXAlignment = Enum.TextXAlignment.Left
SettingB.BackgroundTransparency = 0 
SettingB.TextColor3 = Color3.new(0,0,0)
SettingB.Parent = SettingSC
SettingB.MouseButton1Click:Connect(function()
pcall(call)
end)
end

---------// TextBox \\----------

function CreateTextBox(Name,Wind,callback)
Wind.Default = Wind.Default or "Put..."
Wind.TextDisappear = Wind.TextDisappear or true

local SettingL3 = Instance.new("TextLabel")
SettingL3.Size = UDim2.new(0.8, 0, 0.2, 0)
SettingL3.Position = UDim2.new(0.5, 0, 0.5, 0)
SettingL3.BackgroundColor3 = Color3.new(1,1,1)
SettingL3.Text = Name
SettingL3.TextSize = 10
SettingL3.TextXAlignment = Enum.TextXAlignment.Left
SettingL3.TextColor3 = Color3.new(0,0,0)
SettingL3.Parent = SettingSC

local SettingBox = Instance.new("TextBox")
SettingBox.Size = UDim2.new(0.3, 0, 0.8, 0)
SettingBox.Position = UDim2.new(0.67, 0, 0.1, 0)
SettingBox.BackgroundColor3 = Color3.new(1,1,1)
SettingBox.Text = Wind.Default
SettingBox.TextWrapped = true
SettingBox.ClearTextOnFocus = Wind.TextDisappear
SettingBox.TextColor3 = Color3.new(0,0,0)
SettingBox.BackgroundTransparency = 0
SettingBox.TextSize = 10
SettingBox.Parent = SettingL3
SettingBox.FocusLost:Connect(function(enterPressed)
if enterPressed then
callback(SettingBox.Text)
end
end)
end

--------// Started \\---------

CreateTextBox("WalkSpeed", {Default = "Speed", TextDisappear = false}, function(Value)
_G.SpeedGet = Value
end)

CreateToggle("Auto Set Speed", function(Value)
_G.AutiSetSpeed = Value
while _G.AutiSetSpeed do
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") ~= nil and game.Players.LocalPlayer.Character.Humanoid.WalkSpeed ~= _G.SpeedGet then
                    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = _G.SpeedGet
                end
task.wait()
end
end)

CreateTextBox("Jump Power", {Default = "Jump", TextDisappear = false}, function(Value)
_G.JumpGet = Value
end)

CreateToggle("Auto Set Jump", function(Value)
_G.AutiSetJump = Value
while _G.AutiSetJump do
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") ~= nil and game.Players.LocalPlayer.Character.Humanoid.JumpPower ~= _G.JumpGet then
     game.Players.LocalPlayer.Character.Humanoid.JumpPower = _G.JumpGet
end
task.wait()
end
end)

CreateTextBox("Hip Height", {Default = "Hip", TextDisappear = false}, function(Value)
_G.HipHeight = Value
end)

CreateToggle("Auto Set Hip Height", function(Value)
KeepHipHeight = Value
           while KeepHipHeight do
              if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") ~= nil and game.Players.LocalPlayer.Character.Humanoid.HipHeight ~= _G.HipHeight then
                  game.Players.LocalPlayer.Character.Humanoid.HipHeight = _G.HipHeight
              end
task.wait()
         end
end)

CreateTextBox("Gravity", {Default = "Gravity", TextDisappear = false}, function(Value)
_G.Gravity = Value
end)

CreateToggle("Auto Set Hip Height", function(Value)
KeepGravity = Value
           while KeepGravity do
              if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") ~= nil and game.Workspace.Gravity ~= _G.Gravity then
                  game.Workspace.Gravity = _G.Gravity
              end
task.wait()
         end
end)


CreateToggle("Anti Afk", function(Value)
_G.AntiAfk = Value
for i,v in next, getconnections(game.Players.LocalPlayer.Idled) do
if _G.AntiAfk then
v:Disable() 
else
v:Enable()
end
end
end)

CreateToggle("Infinity Jump", function(Value)
_G.InfiniteJump = Value
game:GetService("UserInputService").JumpRequest:connect(function()
if _G.InfiniteJump then
game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
end
end)
end)

if _G.SetSpeedFly == nil then
_G.SetSpeedFly = 100
end
CreateTextBox("Speed Fly", {Default = "Speed", TextDisappear = false}, function(Value)
_G.SetSpeedFly = Value
end)

CreateToggle("Fly", function(Value)
_G.StartFly = Value
if _G.StartFly == false then
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and game.Players.LocalPlayer.Character.Humanoid.RootPart and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityHandler") and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("GyroHandler") then
game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler:Destroy()
game.Players.LocalPlayer.Character.HumanoidRootPart.GyroHandler:Destroy()
game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
end
end
while _G.StartFly do
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and game.Players.LocalPlayer.Character.Humanoid.RootPart and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityHandler") and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("GyroHandler") then
game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.MaxForce = Vector3.new(9e9,9e9,9e9)
game.Players.LocalPlayer.Character.HumanoidRootPart.GyroHandler.MaxTorque = Vector3.new(9e9,9e9,9e9)
game.Players.LocalPlayer.Character.Humanoid.PlatformStand = true
game.Players.LocalPlayer.Character.HumanoidRootPart.GyroHandler.CFrame = Workspace.CurrentCamera.CoordinateFrame
game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = Vector3.new()
if require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule")):GetMoveVector().X > 0 then
game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity + game.Workspace.CurrentCamera.CFrame.RightVector * (require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule")):GetMoveVector().X * _G.SetSpeedFly)
end
if require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule")):GetMoveVector().X < 0 then
game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity + game.Workspace.CurrentCamera.CFrame.RightVector * (require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule")):GetMoveVector().X * _G.SetSpeedFly)
end
if require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule")):GetMoveVector().Z > 0 then
game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity - game.Workspace.CurrentCamera.CFrame.LookVector * (require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule")):GetMoveVector().Z * _G.SetSpeedFly)
end
if require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule")):GetMoveVector().Z < 0 then
game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity - game.Workspace.CurrentCamera.CFrame.LookVector * (require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule")):GetMoveVector().Z * _G.SetSpeedFly)
end
elseif game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and game.Players.LocalPlayer.Character.Humanoid.RootPart and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityHandler") == nil and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("GyroHandler") == nil then
local bv = Instance.new("BodyVelocity")
local bg = Instance.new("BodyGyro")

bv.Name = "VelocityHandler"
bv.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
bv.MaxForce = Vector3.new(0,0,0)
bv.Velocity = Vector3.new(0,0,0)

bg.Name = "GyroHandler"
bg.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
bg.MaxTorque = Vector3.new(0,0,0)
bg.P = 1000
bg.D = 50
end
task.wait()
end
end)

CreateTextBox("Player", {Default = "All", TextDisappear = false}, function(Value)
local targetAbbreviation = Value
local targetPlayer
for _, v in pairs(game.Players:GetPlayers()) do
if string.sub(v.Name, 1, #targetAbbreviation):lower() == targetAbbreviation:lower() then
targetPlayer = v
break
end
end
if targetPlayer then
_G.PlayerNow = targetPlayer.Name
game:GetService("StarterGui"):SetCore("SendNotification",{Title = "Error",Text = "Found Player [ ".._G.PlayerNow.." ]",Icon = "rbxassetid://7733658504",Duration = 2})
else
game:GetService("StarterGui"):SetCore("SendNotification",{Title = "Error",Text = "Can't find player.",Icon = "rbxassetid://7733658504",Duration = 2})
end
end)

CreateButton("Teleport Player", function()
if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players[_G.PlayerNow].Character:FindFirstChild("HumanoidRootPart") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[_G.PlayerNow].Character.HumanoidRootPart.CFrame
end
end)

CreateToggle("Auto Teleport Player", function(Value)
_G.AutoTeleportPlayer = Value
while _G.AutoTeleportPlayer do
if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players[_G.PlayerNow].Character:FindFirstChild("HumanoidRootPart") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[_G.PlayerNow].Character.HumanoidRootPart.CFrame
end
task.wait()
end
end)

CreateToggle("Auto View Player", function(Value)
_G.AutoViewPlayer = Value
while _G.AutoViewPlayer do
if game.Workspace.CurrentCamera and game.Players[_G.PlayerNow].Character and game.Players[_G.PlayerNow].Character:FindFirstChildOfClass("Humanoid") then
game.Workspace.CurrentCamera.CameraSubject = game.Players[_G.PlayerNow].Character:FindFirstChildOfClass("Humanoid")
end
task.wait()
end
end)

CreateTextBox("Size", {Default = "Size", TextDisappear = false}, function(Value)
_G.ReachHitbox = Value
end)

if _G.ReachHitbox == nil then
_G.ReachHitbox = 20
end
CreateToggle("Hitbox", function(Value)
_G.AutoHitbox = Value
while _G.AutoHitbox do
for i,v in pairs(game.Players:GetChildren()) do
                    if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        v.Character.HumanoidRootPart.Size = Vector3.new(_G.ReachHitbox,_G.ReachHitbox,_G.ReachHitbox)
                        v.Character.HumanoidRootPart.Transparency = 0.75
                    end
                end
task.wait()
end
if _G.AutoHitbox == false then
for i,v in pairs(game.Players:GetChildren()) do
                    if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        v.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
                        v.Character.HumanoidRootPart.Transparency = 1
                    end
                end
end
end)

CreateToggle("Keyboard Executor", function(Value)
_G.KeyboardExecute = Value
if _G.KeyboardExecute == true then
_G.OldText = {}
for i,v in pairs(game.CoreGui.Execute.Frame:GetChildren()) do
if v:IsA("TextBox") then
_G.OldText[#_G.OldText + 1] = v.PlaceholderText
end
end
for i,v in pairs(game.CoreGui.Execute.Frame:GetChildren()) do
if v:IsA("TextBox") then
v.PlaceholderText = ([[
1. Execute [ Key L ]
2. Close / Open Ui [ Key RightShift ]
3. Copy script [ Key C ]
4. Clear [ Key O ]
5. Close / Open Script Hub [ Key P ]
6. Close / Open Choose Ui [ Key U ]
]])
end
end
elseif _G.KeyboardExecute == false then
if _G.OldText then
_G.Tab = 1
for i,v in pairs(game.CoreGui.Execute.Frame:GetChildren()) do
if v:IsA("TextBox") then
v.PlaceholderText = _G.OldText[_G.Tab]
_G.Tab = _G.Tab + 1
end
end
end
end
end)

CreateTextBox("Text Size Execute", {Default = "Size", TextDisappear = false}, function(Value)
for i,v in pairs(game.CoreGui.Execute.Frame:GetChildren()) do
if v:IsA("TextBox") then
v.TextSize = Value
end
end
end)

----// Save Script \\----

makefolder("ExecuteGet/Script")

local Frame15 = Instance.new("Frame")
Frame15.Name = "Frame15"
Frame15.Size = UDim2.new(0.5, 0, 0.8, 0)
Frame15.Position = UDim2.new(0.25, 0, 0.1, 0)
Frame15.BackgroundColor3 = Color3.new(1, 1, 1)
Frame15.Visible = false
Frame15.Active = true
Frame15.Draggable = true
Frame15.Parent = gui

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(1, 0, 0.13, 0)
TextLabel.Position = UDim2.new(0, 0, 0, 0)
TextLabel.BackgroundColor3 = Color3.new(255,255,255)
TextLabel.Text = "Save Script | Ui Library"
TextLabel.TextSize = 10
TextLabel.TextColor3 = Color3.new(0,0,0)
TextLabel.Parent = Frame15

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.12, 0, 0.13, 0)
TextButton.Position = UDim2.new(0.88, 0, 0, 0)
TextButton.BackgroundColor3 = Color3.new(1,1,1)
TextButton.Text = "X"
TextButton.TextSize = 15
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = Frame15
TextButton.MouseButton1Click:Connect(function()
game.CoreGui.Execute.Frame15.Visible = false
end)

local TextBox5 = Instance.new("TextBox")
TextBox5.Name = "SaveScriptnow"
TextBox5.Size = UDim2.new(0.95, 0, 0.43, 0)
TextBox5.Position = UDim2.new(0.03, 0, 0.3, 0)
TextBox5.BackgroundColor3 = Color3.new(255, 255, 255)
TextBox5.Text = ""
TextBox5.PlaceholderText = "Welcome To Save Script | Ui library, Save Script Get Add Script you Execute"
TextBox5.TextXAlignment = Enum.TextXAlignment.Left
TextBox5.TextYAlignment = Enum.TextYAlignment.Top
TextBox5.FontFace = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
TextBox5.TextWrapped = true
TextBox5.ClipsDescendants = true
TextBox5.MultiLine = true
TextBox5.ClearTextOnFocus = false
TextBox5.TextColor3 = Color3.new(0,0,0)
TextBox5.TextSize = 15
TextBox5.Parent = Frame15

local TextBox6 = Instance.new("TextBox")
TextBox6.Name = "NameScript"
TextBox6.Size = UDim2.new(0.95, 0, 0.1, 0)
TextBox6.Position = UDim2.new(0.03, 0, 0.16, 0)
TextBox6.BackgroundColor3 = Color3.new(255, 255, 255)
TextBox6.Text = ""
TextBox6.PlaceholderText = "Name"
TextBox6.TextWrapped = true
TextBox6.ClearTextOnFocus = false
TextBox6.TextColor3 = Color3.new(0,0,0)
TextBox6.TextSize = 10
TextBox6.Parent = Frame15

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.21, 0, 0.2, 0)
TextButton.Position = UDim2.new(0.03, 0, 0.77, 0)
TextButton.BackgroundColor3 = Color3.new(255, 255, 255)
TextButton.Text = "Save"
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = Frame15
TextButton.MouseButton1Click:Connect(function()
SavedScriptsAdd({Name = game.CoreGui.Execute.Frame15.NameScript.Text..".txt", Script = game.CoreGui.Execute.Frame15.SaveScriptnow.Text})
writefile("ExecuteGet/"..game.CoreGui.Execute.Frame15.NameScript.Text..".txt", game.CoreGui.Execute.Frame15.SaveScriptnow.Text)
game:GetService("StarterGui"):SetCore("SendNotification",{Title = "Error",Text = "Save Success.",Icon = "rbxassetid://7733658504",Duration = 4})
end)

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.21, 0, 0.2, 0)
TextButton.Position = UDim2.new(0.26, 0, 0.77, 0)
TextButton.BackgroundColor3 = Color3.new(255, 255, 255)
TextButton.Text = "Clear"
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = Frame15
TextButton.MouseButton1Click:Connect(function()
CreateClear("Clear Save?", function()
game.CoreGui.Execute.Frame15.SaveScriptnow.Text = ""
end)
end)

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.21, 0, 0.2, 0)
TextButton.Position = UDim2.new(0.49, 0, 0.77, 0)
TextButton.BackgroundColor3 = Color3.new(255, 255, 255)
TextButton.Text = "Open Clipboard"
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = Frame15
TextButton.MouseButton1Click:Connect(function()
game.CoreGui.Execute.Frame15.SaveScriptnow.Text = getclipboard()
end)

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.25, 0, 0.2, 0)
TextButton.Position = UDim2.new(0.72, 0, 0.77, 0)
TextButton.BackgroundColor3 = Color3.new(255, 255, 255)
TextButton.Text = "Open Save Menu"
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = Frame15
TextButton.MouseButton1Click:Connect(function()
if game.CoreGui.Execute.Frame11.Visible == false then
game.CoreGui.Execute.Frame11.Visible = true
else
game.CoreGui.Execute.Frame11.Visible = false
end
end)

----// Menu Save Script \\----

local Frame20 = Instance.new("Frame")
Frame20.Name = "Frame11"
Frame20.Size = UDim2.new(0.5, 0, 0.8, 0)
Frame20.Position = UDim2.new(0.2, 0, 0.1, 0)
Frame20.BackgroundColor3 = Color3.new(1, 1, 1)
Frame20.Active = true
Frame20.Visible = false
Frame20.BackgroundTransparency = 0 
Frame20.Draggable = true
Frame20.Parent = gui

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(1, 0, 0.13, 0)
TextLabel.Position = UDim2.new(0, 0, 0, 0)
TextLabel.BackgroundColor3 = Color3.new(255, 255, 255)
TextLabel.Text = "Menu Save | Ui Library"
TextLabel.TextSize = 10
TextLabel.BackgroundTransparency = 0 
TextLabel.TextColor3 = Color3.new(0, 0, 0)
TextLabel.Parent = Frame20

local ButtonX = Instance.new("TextButton")
ButtonX.Size = UDim2.new(0.1, 0, 1, 0)
ButtonX.Position = UDim2.new(0.9, 0, 0, 0)
ButtonX.BackgroundColor3 = Color3.new(255, 255, 255)
ButtonX.Text = "X"
ButtonX.TextSize = 13
ButtonX.BackgroundTransparency = 1
ButtonX.TextColor3 = Color3.new(0, 0, 0)
ButtonX.Parent = TextLabel
ButtonX.MouseButton1Click:Connect(function()
game.CoreGui.Execute.Frame11.Visible = false
end)

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(0.94, 0, 0.78, 0)
ScrollingFrame.Position = UDim2.new(0.03, 0, 0.17, 0)
ScrollingFrame.BackgroundColor3 = Color3.new(1, 1, 1)
ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollingFrame.ScrollBarThickness = 0
ScrollingFrame.Parent = Frame20

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Parent = ScrollingFrame

function SavedScriptsAdd(SaveGet)
SaveGet.Name = SaveGet.Name or "Get Name"
SaveGet.Script = SaveGet.Script or "Put Hehe Now"

local SaveLabel = Instance.new("TextLabel")
SaveLabel.Name = SaveGet.Name
SaveLabel.Size = UDim2.new(1, 0, 0.2, 0)
SaveLabel.Position = UDim2.new(0, 0, 0, 0)
SaveLabel.BackgroundColor3 = Color3.new(255, 255, 255)
SaveLabel.Text = SaveGet.Name
SaveLabel.TextSize = 10
SaveLabel.BackgroundTransparency = 0 
SaveLabel.TextColor3 = Color3.new(0, 0, 0)
SaveLabel.Parent = ScrollingFrame

local ButtonExe = Instance.new("TextButton")
ButtonExe.Size = UDim2.new(0.2, 0, 1, 0)
ButtonExe.Position = UDim2.new(0.795, 0, 0, 0)
ButtonExe.BackgroundColor3 = Color3.new(255, 255, 255)
ButtonExe.Text = "Execute"
ButtonExe.BackgroundTransparency = 0 
ButtonExe.TextColor3 = Color3.new(0, 0, 0)
ButtonExe.Parent = SaveLabel
ButtonExe.MouseButton1Click:Connect(function()
local func, err = loadstring(SaveGet.Script)
        if func then
            pcall(func)
        else
            print(err)
      end
end)

local ButtonDelete = Instance.new("TextButton")
ButtonDelete.Size = UDim2.new(0.2, 0, 1, 0)
ButtonDelete.Position = UDim2.new(0, 0, 0, 0)
ButtonDelete.BackgroundColor3 = Color3.new(255, 255, 255)
ButtonDelete.Text = "Delete"
ButtonDelete.BackgroundTransparency = 0 
ButtonDelete.TextColor3 = Color3.new(0, 0, 0)
ButtonDelete.Parent = SaveLabel
ButtonDelete.MouseButton1Click:Connect(function()
CreateClear("Delete File?", function()
delfile("ExecuteGet/"..SaveGet.Name)
SaveLabel:Destroy()
end)
end)
end

-------// Could \\-------

local Frame13 = Instance.new("Frame")
Frame13.Name = "Frame13"
Frame13.Size = UDim2.new(0.65, 0, 0.85, 0)
Frame13.Position = UDim2.new(0.15, 0, 0, 0)
Frame13.BackgroundColor3 = Color3.new(1, 1, 1)
Frame13.Active = true
Frame13.Visible = false
Frame13.Draggable = true
Frame13.Parent = gui

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(1, 0, 0.14, 0)
TextLabel.Position = UDim2.new(0, 0, 0, 0)
TextLabel.BackgroundColor3 = Color3.new(1,1,1)
TextLabel.Text = "Could | Ui Library"
TextLabel.TextColor3 = Color3.new(0,0,0)
TextLabel.TextSize = 10
TextLabel.Parent = Frame13

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.1, 0, 0.14, 0)
TextButton.Position = UDim2.new(0.9, 0, 0, 0)
TextButton.BackgroundColor3 = Color3.new(1,1,1)
TextButton.Text = "X"
TextButton.TextSize = 16
TextButton.BackgroundTransparency = 1
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = Frame13
TextButton.MouseButton1Click:Connect(function()
game.CoreGui.Execute.Frame13.Visible = false
end)

local TextBoxScript = Instance.new("TextBox")
TextBoxScript.Name = "ScriptTextBox2"
TextBoxScript.Size = UDim2.new(0.75, 0, 0.11, 0)
TextBoxScript.Position = UDim2.new(0, 0, 0.143, 0)
TextBoxScript.BackgroundColor3 = Color3.new(1,1,1)
TextBoxScript.Text = "Search On Scriptbox"
TextBoxScript.TextColor3 = Color3.new(0,0,0)
TextBoxScript.TextSize = 10
TextBoxScript.Parent = Frame13

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.3, 0, 0.114, 0)
TextButton.Position = UDim2.new(0.7, 0, 0.142, 0)
TextButton.BackgroundColor3 = Color3.new(1,1,1)
TextButton.Text = "Check"
TextButton.BackgroundTransparency = 0 
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = Frame13
TextButton.MouseButton1Click:Connect(function()
for _, v in ipairs(game.CoreGui.Execute.Frame13.ScrollingFrame:GetChildren()) do
            if v:IsA("ImageLabel") then
                v:Destroy()
            end
        end
ScriptBoxHehe = TextBoxScript.Text
decoded = game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://scriptblox.com/api/script/search?filters=free&q="..string.gsub(ScriptBoxHehe, " ", "%%20")))
        for _, v in pairs(decoded.result.scripts) do
            if(v.isUniversal == true) then
                AddTabScript("https://assetgame.roblox.com/Game/Tools/ThumbnailAsset.ashx?aid=7234087065&fmt=png&wd=420&ht=420", v.title, v.script)
            else
                AddTabScript("https://assetgame.roblox.com/Game/Tools/ThumbnailAsset.ashx?aid="..v.game.gameId.."&fmt=png&wd=420&ht=420", v.title, v.script)
            end
        end
end)

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, 0, 0.8, 0)
ScrollingFrame.Position = UDim2.new(0, 0, 0.25, 0)
ScrollingFrame.BackgroundColor3 = Color3.new(1, 1, 1)
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 186, 117)
ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollingFrame.Parent = Frame13

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.Parent = ScrollingFrame

function AddTabScript(imageTab, scriptname, source)
local ImageLabel = Instance.new("ImageLabel")
ImageLabel.Size = UDim2.new(1, 0, 0.95, 0)
ImageLabel.Position = UDim2.new(0, 0, 0, 0)
ImageLabel.BackgroundColor3 = Color3.fromRGB(26, 27, 36)
ImageLabel.Image = imageTab
ImageLabel.Parent = ScrollingFrame

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(1, 0, 0.15, 0)
TextLabel.Position = UDim2.new(0, 0, 0, 0)
TextLabel.BackgroundColor3 = Color3.new(1,1,1)
TextLabel.Text = scriptname
TextLabel.TextSize = 8
TextLabel.TextColor3 = Color3.new(0,0,0)
TextLabel.Parent = ImageLabel

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.25, 0, 0.2, 0)
TextButton.Position = UDim2.new(0, 0, 0.8, 0)
TextButton.BackgroundColor3 = Color3.new(1,1,1)
TextButton.Text = "Execute"
TextButton.TextSize = 9
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = ImageLabel
TextButton.MouseButton1Click:Connect(function()
local func, err = loadstring(source)
        if func then
            pcall(func)
        else
            print(err)
      end
end)

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.23, 0, 0.2, 0)
TextButton.Position = UDim2.new(0.25, 0, 0.8, 0)
TextButton.BackgroundColor3 = Color3.new(1,1,1)
TextButton.Text = "Copy Script"
TextButton.TextSize = 9
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = ImageLabel
TextButton.MouseButton1Click:Connect(function()
setclipboard(source)
end)

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.23, 0, 0.2, 0)
TextButton.Position = UDim2.new(0.48, 0, 0.8, 0)
TextButton.BackgroundColor3 = Color3.new(1,1,1)
TextButton.Text = "Open Script"
TextButton.TextSize = 9
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = ImageLabel
TextButton.MouseButton1Click:Connect(function()
for i,v in pairs(game.CoreGui.Execute.Frame:GetChildren()) do
if v:IsA("TextBox") then
if v.Visible == true then
v.Text = source
end
end
end
end)

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.3, 0, 0.2, 0)
TextButton.Position = UDim2.new(0.7, 0, 0.8, 0)
TextButton.BackgroundColor3 = Color3.new(1,1,1)
TextButton.Text = "Save Script"
TextButton.TextSize = 9
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = ImageLabel
TextButton.MouseButton1Click:Connect(function()
SavedScriptsAdd({Name = scriptname..".txt", Script = source, ScriptSave = source})
writefile("ExecuteGet/"..scriptname..".txt", source)
end)
end

-------// Tab Next \\-------

local Frame20 = Instance.new("Frame")
Frame20.Name = "Frame23"
Frame20.Size = UDim2.new(0.5, 0, 0.8, 0)
Frame20.Position = UDim2.new(0.2, 0, 0.1, 0)
Frame20.BackgroundColor3 = Color3.new(1, 1, 1)
Frame20.Active = true
Frame20.Visible = false
Frame20.BackgroundTransparency = 0 
Frame20.Draggable = true
Frame20.Parent = gui

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(1, 0, 0.13, 0)
TextLabel.Position = UDim2.new(0, 0, 0, 0)
TextLabel.BackgroundColor3 = Color3.new(255, 255, 255)
TextLabel.Text = "Create Tab | Ui Library"
TextLabel.TextSize = 10
TextLabel.BackgroundTransparency = 0 
TextLabel.TextColor3 = Color3.new(0, 0, 0)
TextLabel.Parent = Frame20

local ButtonX = Instance.new("TextButton")
ButtonX.Size = UDim2.new(0.1, 0, 1, 0)
ButtonX.Position = UDim2.new(0.9, 0, 0, 0)
ButtonX.BackgroundColor3 = Color3.new(255, 255, 255)
ButtonX.Text = "X"
ButtonX.TextSize = 13
ButtonX.BackgroundTransparency = 1
ButtonX.TextColor3 = Color3.new(0, 0, 0)
ButtonX.Parent = TextLabel
ButtonX.MouseButton1Click:Connect(function()
game.CoreGui.Execute.Frame23.Visible = false
end)

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(0.94, 0, 0.65, 0)
ScrollingFrame.Position = UDim2.new(0.03, 0, 0.3, 0)
ScrollingFrame.BackgroundColor3 = Color3.new(1, 1, 1)
ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollingFrame.ScrollBarThickness = 0
ScrollingFrame.Parent = Frame20

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Parent = ScrollingFrame

local Padding = Instance.new("UIPadding")
Padding.PaddingTop = UDim.new(0, 8)
Padding.Parent = ScrollingFrame

local TextButton = Instance.new("TextButton")
TextButton.Name = "Normal"
TextButton.Size = UDim2.new(0.8, 0, 0.23, 0)
TextButton.Position = UDim2.new(0, 0, 0, 0)
TextButton.BackgroundColor3 = Color3.new(255, 255, 255)
TextButton.Text = "Normal"
TextButton.TextSize = 10
TextButton.BackgroundTransparency = 0 
TextButton.TextColor3 = Color3.new(0, 0, 0)
TextButton.Parent = ScrollingFrame
TextButton.MouseButton1Down:connect(function()
for i,v in pairs(game.CoreGui.Execute.Frame:GetChildren()) do
if v:IsA("TextBox") then
if v.Visible == true then
v.Visible = false
end
end
end
if game.CoreGui.Execute.Frame:FindFirstChild("ScriptTextBox").Visible == false then
game.CoreGui.Execute.Frame:FindFirstChild("ScriptTextBox").Visible = true
end
end)

function CreateButtonTab(Scripts)
Scripts.Name = Scripts.Name

local TextButton = Instance.new("TextButton")
TextButton.Name = Scripts.Name
TextButton.Size = UDim2.new(0.8, 0, 0.23, 0)
TextButton.Position = UDim2.new(0, 0, 0, 0)
TextButton.BackgroundColor3 = Color3.new(255, 255, 255)
TextButton.Text = Scripts.Name
TextButton.TextSize = 10
TextButton.BackgroundTransparency = 0 
TextButton.TextColor3 = Color3.new(0, 0, 0)
TextButton.Parent = ScrollingFrame
TextButton.MouseButton1Down:connect(function()
for i,v in pairs(game.CoreGui.Execute.Frame:GetChildren()) do
if v:IsA("TextBox") then
if v.Visible == true then
v.Visible = false
end
end
end
if game.CoreGui.Execute.Frame:FindFirstChild(Scripts.Name).Visible == false then
game.CoreGui.Execute.Frame:FindFirstChild(Scripts.Name).Visible = true
end
end)

local ButtonDelete = Instance.new("TextButton")
ButtonDelete.Name = "ButtonDelete"
ButtonDelete.Size = UDim2.new(0.2, 0, 1, 0)
ButtonDelete.Position = UDim2.new(0.8, 0, 0, 0)
ButtonDelete.BackgroundColor3 = Color3.new(255, 255, 255)
ButtonDelete.Text = "×"
ButtonDelete.TextSize = 20
ButtonDelete.BackgroundTransparency = 0 
ButtonDelete.TextColor3 = Color3.new(0, 0, 0)
ButtonDelete.Parent = TextButton
ButtonDelete.MouseButton1Down:connect(function()
game.CoreGui.Execute.Frame23.ScrollingFrame:FindFirstChild(Scripts.Name):Destroy()
game.CoreGui.Execute.Frame:FindFirstChild(Scripts.Name):Destroy()
_G.MusTab = 1
_G.TextBox = 0
for i,v in pairs(game.CoreGui.Execute.Frame23.ScrollingFrame:GetChildren()) do
if v.Name ~= "UIListLayout" and v.Name ~= "UIPadding" then
_G.TextBox = _G.TextBox + 1
_G.MusTab = _G.MusTab + 1
end
end
if _G.TextBox > 0 then
if game.CoreGui.Execute.Frame.ScriptTextBox.Visible == false then
game.CoreGui.Execute.Frame.ScriptTextBox.Visible = true
end
elseif _G.TextBox == 0 then
if game.CoreGui.Execute.Frame.ScriptTextBox.Visible == false then
game.CoreGui.Execute.Frame.ScriptTextBox.Visible = true
end
end
if _G.MusTab > 1 then
game.CoreGui.Execute.Frame23.TextBoxScript.Text = "Script "..tostring(_G.MusTab)
elseif _G.MusTab == 1 then
game.CoreGui.Execute.Frame23.TextBoxScript.Text = "Script 1"
end
end)

local TextBox = Instance.new("TextBox")
TextBox.Name = Scripts.Name
TextBox.Size = UDim2.new(1, 0, 0.57, 0)
TextBox.Position = UDim2.new(0, 0, 0.154, 0)
TextBox.BackgroundColor3 = Color3.new(255,255,255)
TextBox.Text = ""
TextBox.PlaceholderText = "Script "..tostring(_G.MusTab).." (New Tab Script)"
TextBox.TextXAlignment = Enum.TextXAlignment.Left
TextBox.TextYAlignment = Enum.TextYAlignment.Top
TextBox.TextWrapped = true
TextBox.Visible = false
TextBox.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
TextBox.ClipsDescendants = true
TextBox.MultiLine = true
TextBox.ClearTextOnFocus = false
TextBox.TextColor3 = Color3.new(0,0,0)
TextBox.TextSize = 19
TextBox.Parent = game.CoreGui.Execute.Frame
end

local TextBox = Instance.new("TextBox")
TextBox.Name = "TextBoxScript"
TextBox.Size = UDim2.new(0.65, 0, 0.13, 0)
TextBox.Position = UDim2.new(0.03, 0, 0.15, 0)
TextBox.BackgroundColor3 = Color3.new(255, 255, 255)
TextBox.Text = "Script 1"
TextBox.TextSize = 10
TextBox.TextColor3 = Color3.new(0, 0, 0)
TextBox.BackgroundTransparency = 0
TextBox.Parent = Frame20

_G.MusTab = 1
local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.27, 0, 0.13, 0)
TextButton.Position = UDim2.new(0.7, 0, 0.15, 0)
TextButton.BackgroundColor3 = Color3.new(255, 255, 255)
TextButton.Text = "+"
TextButton.TextSize = 20
TextButton.BackgroundTransparency = 0 
TextButton.TextColor3 = Color3.new(0, 0, 0)
TextButton.Parent = Frame20
TextButton.MouseButton1Down:connect(function()
CreateButtonTab({Name = game.CoreGui.Execute.Frame23.TextBoxScript.Text})
_G.MusTab = _G.MusTab + 1
game.CoreGui.Execute.Frame23.TextBoxScript.Text = "Script "..tostring(_G.MusTab)
end)

------Console | Ui Library-------

logTable = {}
local Frame24 = Instance.new("Frame")
Frame24.Name = "Frame24"
Frame24.Size = UDim2.new(0.5, 0, 0.8, 0)
Frame24.Position = UDim2.new(0.2, 0, 0.1, 0)
Frame24.BackgroundColor3 = Color3.new(1, 1, 1)
Frame24.Active = true
Frame24.Visible = false
Frame24.BackgroundTransparency = 0 
Frame24.Draggable = true
Frame24.Parent = gui

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(1, 0, 0.14, 0)
TextLabel.Position = UDim2.new(0, 0, 0, 0)
TextLabel.BackgroundColor3 = Color3.new(255, 255, 255)
TextLabel.Text = "Console | Ui Library"
TextLabel.TextSize = 10
TextLabel.BackgroundTransparency = 0 
TextLabel.TextColor3 = Color3.new(0, 0, 0)
TextLabel.Parent = Frame24

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.1, 0, 1, 0)
TextButton.Position = UDim2.new(0.9, 0, 0, 0)
TextButton.BackgroundColor3 = Color3.new(255, 255, 255)
TextButton.Text = "X"
TextButton.TextSize = 13
TextButton.BackgroundTransparency = 1
TextButton.TextColor3 = Color3.new(0, 0, 0)
TextButton.Parent = TextLabel
TextButton.MouseButton1Click:Connect(function()
game.CoreGui.Execute.Frame24.Visible = false
end)

local LogConsole = Instance.new("TextBox")
LogConsole.Name = "LogConsole"
LogConsole.Size = UDim2.new(0.94, 0, 0.6, 0)
LogConsole.Position = UDim2.new(0.03, 0, 0.18, 0)
LogConsole.BackgroundColor3 = Color3.new(255, 255, 255)
LogConsole.Text = ""
LogConsole.MultiLine = true
LogConsole.ClearTextOnFocus = false
LogConsole.TextXAlignment = Enum.TextXAlignment.Left
LogConsole.TextYAlignment = Enum.TextYAlignment.Top
LogConsole.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
LogConsole.TextColor3 = Color3.new(0, 0, 0)
LogConsole.BackgroundTransparency = 0
LogConsole.TextSize = 15
LogConsole.TextWrapped = true
LogConsole.Parent = Frame24

local typeToInfo = {
	MessageOutput = {
		prefix = "Print"
	},
	MessageInfo = {
		prefix = "Info"
	},
	MessageWarning = {
		prefix = "Warning"
	},
	MessageError = {
		prefix = "Error"
	}
}

local function appendConsole(msg, msgType)
	local info = typeToInfo[msgType.Name]
		if info == nil then
			return
		end
logTable[#logTable + 1] = "[ "..string.format(info.prefix).." ]".." - ".."[ "..os.date("%X").." ]".." - ".."[ "..string.format(msg).." ]"
game.CoreGui.Execute.Frame24.LogConsole.Text = (table.concat(logTable, "\n\n"))
end

game:GetService("LogService").MessageOut:Connect(appendConsole)

local Clear = Instance.new("TextButton")
Clear.Size = UDim2.new(0.45, 0, 0.16, 0)
Clear.Position = UDim2.new(0.03, 0, 0.8, 0)
Clear.BackgroundColor3 = Color3.new(255, 255, 255)
Clear.Text = "Clear"
Clear.TextSize = 12
Clear.BackgroundTransparency = 0 
Clear.TextColor3 = Color3.new(0, 0, 0)
Clear.Parent = Frame24
Clear.MouseButton1Click:Connect(function()
logTable = {}
game.CoreGui.Execute.Frame24.LogConsole.Text = ""
end)

local Copy = Instance.new("TextButton")
Copy.Size = UDim2.new(0.47, 0, 0.16, 0)
Copy.Position = UDim2.new(0.5, 0, 0.8, 0)
Copy.BackgroundColor3 = Color3.new(255, 255, 255)
Copy.Text = "Copy"
Copy.TextSize = 12
Copy.BackgroundTransparency = 0 
Copy.TextColor3 = Color3.new(0, 0, 0)
Copy.Parent = Frame24
Copy.MouseButton1Click:Connect(function()
setclipboard(game.CoreGui.Execute.Frame24.LogConsole.Text)
end)

------PlayerCheck | Ui Library-------

local Frame26 = Instance.new("Frame")
Frame26.Name = "Frame26"
Frame26.Size = UDim2.new(0.5, 0, 0.8, 0)
Frame26.Position = UDim2.new(0.2, 0, 0.1, 0)
Frame26.BackgroundColor3 = Color3.new(1, 1, 1)
Frame26.Active = true
Frame26.Visible = false
Frame26.BackgroundTransparency = 0 
Frame26.Draggable = true
Frame26.Parent = gui

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(1, 0, 0.13, 0)
TextLabel.Position = UDim2.new(0, 0, 0, 0)
TextLabel.BackgroundColor3 = Color3.new(255, 255, 255)
TextLabel.Text = "Search Player | Ui Library"
TextLabel.TextSize = 10
TextLabel.BackgroundTransparency = 0 
TextLabel.TextColor3 = Color3.new(0, 0, 0)
TextLabel.Parent = Frame26

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.1, 0, 1, 0)
TextButton.Position = UDim2.new(0.9, 0, 0, 0)
TextButton.BackgroundColor3 = Color3.new(255, 255, 255)
TextButton.Text = "X"
TextButton.TextSize = 12
TextButton.BackgroundTransparency = 1
TextButton.TextColor3 = Color3.new(0, 0, 0)
TextButton.Parent = TextLabel
TextButton.MouseButton1Click:Connect(function()
game.CoreGui.Execute.Frame26.Visible = false
end)

local ImageLabel = Instance.new("ImageLabel")
ImageLabel.Name = "Image1"
ImageLabel.Size = UDim2.new(0.3, 0, 0.37, 0)
ImageLabel.Position = UDim2.new(0.03, 0, 0.17, 0)
ImageLabel.BackgroundColor3 = Color3.new(1,1,1)
ImageLabel.Image = "rbxassetid://0"
ImageLabel.BackgroundTransparency = 0 
ImageLabel.Parent = Frame26

local Image = Instance.new("ImageButton")
Image.Name = "Image2"
Image.Size = UDim2.new(0.3, 0, 0.39, 0)
Image.Position = UDim2.new(0.03, 0, 0.57, 0)
Image.BackgroundColor3 = Color3.new(1,1,1)
Image.Image = "rbxassetid://0"
Image.BackgroundTransparency = 0 
Image.Parent = Frame26

local TextLabel = Instance.new("TextLabel")
TextLabel.Name = "Usernames"
TextLabel.Size = UDim2.new(0.6, 0, 0.13, 0)
TextLabel.Position = UDim2.new(0.37, 0, 0.17, 0)
TextLabel.BackgroundColor3 = Color3.new(255, 255, 255)
TextLabel.Text = "Username"
TextLabel.TextSize = 10
TextLabel.BackgroundTransparency = 0 
TextLabel.TextColor3 = Color3.new(0, 0, 0)
TextLabel.Parent = Frame26

local TextLabel = Instance.new("TextLabel")
TextLabel.Name = "IDName"
TextLabel.Size = UDim2.new(0.6, 0, 0.13, 0)
TextLabel.Position = UDim2.new(0.37, 0, 0.33, 0)
TextLabel.BackgroundColor3 = Color3.new(255, 255, 255)
TextLabel.Text = "ID Name"
TextLabel.TextSize = 10
TextLabel.BackgroundTransparency = 0 
TextLabel.TextColor3 = Color3.new(0, 0, 0)
TextLabel.Parent = Frame26

local TextBox = Instance.new("TextBox")
TextBox.Name = "CheckText"
TextBox.Size = UDim2.new(0.6, 0, 0.13, 0)
TextBox.Position = UDim2.new(0.37, 0, 0.49, 0)
TextBox.BackgroundColor3 = Color3.new(255, 255, 255)
TextBox.Text = ""
TextBox.PlaceholderText = "Username"
TextBox.TextColor3 = Color3.new(0, 0, 0)
TextBox.BackgroundTransparency = 0
TextBox.TextSize = 10
TextBox.Parent = Frame26

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.3, 0, 0.3, 0)
TextButton.Position = UDim2.new(0.37, 0, 0.66, 0)
TextButton.BackgroundColor3 = Color3.new(255, 255, 255)
TextButton.Text = "Check Player"
TextButton.TextSize = 10
TextButton.TextWrapped = true
TextButton.BackgroundTransparency = 0 
TextButton.TextColor3 = Color3.new(0, 0, 0)
TextButton.Parent = Frame26
TextButton.MouseButton1Click:Connect(function()
local Success, Result = pcall(function()
	local Player = game.CoreGui.Execute.Frame26.CheckText.Text
	if Player then
		 A = game.Players:GetUserIdFromNameAsync(Player) or nil
		 B = game.Players:GetNameFromUserIdAsync(A)
		 T = game.Players:GetUserThumbnailAsync(A, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
	    T2 = game.Players:GetUserThumbnailAsync(A, Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size420x420)
		if A ~= nil then
				game.CoreGui.Execute.Frame26.Usernames.Text = B
				game.CoreGui.Execute.Frame26.IDName.Text = A
				game.CoreGui.Execute.Frame26.Image1.Image = T
				game.CoreGui.Execute.Frame26.Image2.Image = T2
		end
	end
	end)
if not Success then
Old = game.CoreGui.Execute.Frame26.CheckText.Text
game.CoreGui.Execute.Frame26.Usernames.Text = "Does not exist"
game.CoreGui.Execute.Frame26.IDName.Text = ""
game.CoreGui.Execute.Frame26.CheckText.Text = ""
wait(3)
if A ~= nil and B ~= nil and Old ~= nil then
game.CoreGui.Execute.Frame26.Usernames.Text = B
game.CoreGui.Execute.Frame26.IDName.Text = A
game.CoreGui.Execute.Frame26.CheckText.Text = Old
end
end
end)

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.3, 0, 0.3, 0)
TextButton.Position = UDim2.new(0.67, 0, 0.66, 0)
TextButton.BackgroundColor3 = Color3.new(255, 255, 255)
TextButton.Text = "Clear Check Player"
TextButton.TextSize = 10
TextButton.TextWrapped = true
TextButton.BackgroundTransparency = 0 
TextButton.TextColor3 = Color3.new(0, 0, 0)
TextButton.Parent = Frame26
TextButton.MouseButton1Click:Connect(function()
game.CoreGui.Execute.Frame26.Usernames.Text = ""
game.CoreGui.Execute.Frame26.IDName.Text = ""
game.CoreGui.Execute.Frame26.CheckText.Text = ""
end)

-----Fly | Ui library-----

local FlyFrame = Instance.new("Frame")
FlyFrame.Name = "FlyGot"
FlyFrame.Size = UDim2.new(0.3, 0, 0.6, 0)
FlyFrame.Position = UDim2.new(0.35, 0, 0.2, 0)
FlyFrame.BackgroundColor3 = Color3.new(1, 1, 1)
FlyFrame.Active = true
FlyFrame.Visible = false
FlyFrame.Draggable = true
FlyFrame.Parent = gui

local FlyLabel = Instance.new("TextLabel")
FlyLabel.Size = UDim2.new(1, 0, 0.15, 0)
FlyLabel.Position = UDim2.new(0, 0, 0, 0)
FlyLabel.BackgroundColor3 = Color3.new(255, 255, 255)
FlyLabel.Text = "Fly | Ui Library"
FlyLabel.TextSize = 10
FlyLabel.BackgroundTransparency = 0
FlyLabel.TextColor3 = Color3.new(0, 0, 0)
FlyLabel.Parent = FlyFrame

local FlyX = Instance.new("TextButton")
FlyX.Size = UDim2.new(0.15, 0, 0.15, 0)
FlyX.Position = UDim2.new(0.85, 0, 0, 0)
FlyX.BackgroundColor3 = Color3.new(255, 255, 255)
FlyX.Text = "X"
FlyX.TextSize = 13
FlyX.BackgroundTransparency = 1
FlyX.TextColor3 = Color3.new(0, 0, 0)
FlyX.Parent = FlyFrame

local FlyButton1 = Instance.new("TextButton")
FlyButton1.Size = UDim2.new(0.25, 0, 0.2, 0)
FlyButton1.Position = UDim2.new(0.04, 0, 0.75, 0)
FlyButton1.BackgroundColor3 = Color3.new(255, 255, 255)
FlyButton1.Text = "+"
FlyButton1.TextSize = 17
FlyButton1.BackgroundTransparency = 0 
FlyButton1.TextColor3 = Color3.new(0, 0, 0)
FlyButton1.Parent = FlyFrame

local FlyButton2 = Instance.new("TextButton")
FlyButton2.Size = UDim2.new(0.25, 0, 0.2, 0)
FlyButton2.Position = UDim2.new(0.04, 0, 0.51, 0)
FlyButton2.BackgroundColor3 = Color3.new(255, 255, 255)
FlyButton2.Text = "-"
FlyButton2.TextSize = 17
FlyButton2.BackgroundTransparency = 0 
FlyButton2.TextColor3 = Color3.new(0, 0, 0)
FlyButton2.Parent = FlyFrame

local FlyButton3 = Instance.new("TextButton")
FlyButton3.Size = UDim2.new(0.25, 0, 0.2, 0)
FlyButton3.Position = UDim2.new(0.7, 0, 0.51, 0)
FlyButton3.BackgroundColor3 = Color3.new(255, 255, 255)
FlyButton3.Text = "UP"
FlyButton3.TextSize = 10
FlyButton3.BackgroundTransparency = 0 
FlyButton3.TextColor3 = Color3.new(0, 0, 0)
FlyButton3.Parent = FlyFrame

local FlyButton4 = Instance.new("TextButton")
FlyButton4.Size = UDim2.new(0.25, 0, 0.2, 0)
FlyButton4.Position = UDim2.new(0.7, 0, 0.75, 0)
FlyButton4.BackgroundColor3 = Color3.new(255, 255, 255)
FlyButton4.Text = "DOWN"
FlyButton4.TextSize = 10
FlyButton4.BackgroundTransparency = 0
FlyButton4.TextColor3 = Color3.new(0, 0, 0)
FlyButton4.Parent = FlyFrame

local FlyButton5 = Instance.new("TextButton")
FlyButton5.Size = UDim2.new(0.35, 0, 0.45, 0)
FlyButton5.Position = UDim2.new(0.32, 0, 0.5, 0)
FlyButton5.BackgroundColor3 = Color3.new(255, 255, 255)
FlyButton5.Text = "Fly"
FlyButton5.TextSize = 16
FlyButton5.BackgroundTransparency = 0 
FlyButton5.TextColor3 = Color3.new(0, 0, 0)
FlyButton5.Parent = FlyFrame

local FlySpeed = Instance.new("TextLabel")
FlySpeed.Size = UDim2.new(0.91, 0, 0.25, 0)
FlySpeed.Position = UDim2.new(0.04, 0, 0.21, 0)
FlySpeed.BackgroundColor3 = Color3.new(1,1,1)
FlySpeed.Text = "Speed [ 1 ]"
FlySpeed.TextSize = 10
FlySpeed.BackgroundTransparency = 0 
FlySpeed.TextColor3 = Color3.new(0, 0, 0)
FlySpeed.Parent = FlyFrame

speeds = 1

local speaker = game:GetService("Players").LocalPlayer
local chr = game.Players.LocalPlayer.Character
local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")

nowe = false 
FlyButton5.MouseButton1Down:connect(function()
    if nowe == true then
        nowe = false
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,true)
        speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
    else 
        nowe = true
        for i = 1, speeds do
            spawn(function()
                local hb = game:GetService("RunService").Heartbeat    
                tpwalking = true
                local chr = game.Players.LocalPlayer.Character
                local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                    if hum.MoveDirection.Magnitude > 0 then
                        chr:TranslateBy(hum.MoveDirection)
                    end
                end
            end)
        end
        game.Players.LocalPlayer.Character.Animate.Disabled = true
        local Char = game.Players.LocalPlayer.Character
        local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController")
        for i,v in next, Hum:GetPlayingAnimationTracks() do
            v:AdjustSpeed(0)
        end
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
        speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
    end
    if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
        local plr = game.Players.LocalPlayer
        local torso = plr.Character.Torso
        local flying = true
        local deb = true
        local ctrl = {f = 0, b = 0, l = 0, r = 0}
        local lastctrl = {f = 0, b = 0, l = 0, r = 0}
        local maxspeed = 50
        local speed = 0
        local bg = Instance.new("BodyGyro", torso)
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.cframe = torso.CFrame
        local bv = Instance.new("BodyVelocity", torso)
        bv.velocity = Vector3.new(0,0.1,0)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        if nowe == true then
            plr.Character.Humanoid.PlatformStand = true
        end
        while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
            game:GetService("RunService").RenderStepped:Wait()
            if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                speed = speed+.5+(speed/maxspeed)
                if speed > maxspeed then
                    speed = maxspeed
                end
            elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
                speed = speed-1
                if speed < 0 then
                    speed = 0
                end
            end
            if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
                lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
            elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
                bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
            else
                bv.velocity = Vector3.new(0,0,0)
            end
            bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
        end
        ctrl = {f = 0, b = 0, l = 0, r = 0}
        lastctrl = {f = 0, b = 0, l = 0, r = 0}
        speed = 0
        bg:Destroy()
        bv:Destroy()
        plr.Character.Humanoid.PlatformStand = false
        game.Players.LocalPlayer.Character.Animate.Disabled = false
        tpwalking = false
    else
        local plr = game.Players.LocalPlayer
        local UpperTorso = plr.Character.UpperTorso
        local flying = true
        local deb = true
        local ctrl = {f = 0, b = 0, l = 0, r = 0}
        local lastctrl = {f = 0, b = 0, l = 0, r = 0}
        local maxspeed = 50
        local speed = 0
        local bg = Instance.new("BodyGyro", UpperTorso)
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.cframe = UpperTorso.CFrame
        local bv = Instance.new("BodyVelocity", UpperTorso)
        bv.velocity = Vector3.new(0,0.1,0)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        if nowe == true then
            plr.Character.Humanoid.PlatformStand = true
        end
        while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
            wait()
            if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                speed = speed+.5+(speed/maxspeed)
                if speed > maxspeed then
                    speed = maxspeed
                end
            elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
                speed = speed-1
                if speed < 0 then
                    speed = 0
                end
            end
            if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
                lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
            elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
                bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
            else
                bv.velocity = Vector3.new(0,0,0)
            end
            bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
        end
        ctrl = {f = 0, b = 0, l = 0, r = 0}
        lastctrl = {f = 0, b = 0, l = 0, r = 0}
        speed = 0
        bg:Destroy()
        bv:Destroy()
        plr.Character.Humanoid.PlatformStand = false
        game.Players.LocalPlayer.Character.Animate.Disabled = false
        tpwalking = false
    end
end)

local tis
FlyButton3.MouseButton1Down:connect(function()
    tis = FlyButton3.MouseEnter:connect(function()
        while tis do
            wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,1,0)
        end
    end)
end)

FlyButton3.MouseLeave:connect(function()
    if tis then
        tis:Disconnect()
        tis = nil
    end
end)

local dis
FlyButton4.MouseButton1Down:connect(function()
    dis = FlyButton4.MouseEnter:connect(function()
        while dis do
            wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,0)
        end
    end)
end)

FlyButton4.MouseLeave:connect(function()
    if dis then
        dis:Disconnect()
        dis = nil
    end
end)

game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(char)
    wait(0.7)
    game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
    game.Players.LocalPlayer.Character.Animate.Disabled = false
end)

FlyButton1.MouseButton1Down:connect(function()
            speeds = speeds + 1
            FlySpeed.Text = "Speed [ "..speeds.." ]"
            if nowe == true then
        tpwalking = false
        for i = 1, speeds do
            spawn(function()
                local hb = game:GetService("RunService").Heartbeat    
                tpwalking = true
                local chr = game.Players.LocalPlayer.Character
                local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                    if hum.MoveDirection.Magnitude > 0 then
                        chr:TranslateBy(hum.MoveDirection)
                    end
                end
            end)
        end
    end
end)

FlyButton2.MouseButton1Down:connect(function()
    if speeds == 1 then
        FlySpeed.Text = "Speed [ Cannot Be Less Than 1 ]"
        wait(1)
        FlySpeed.Text = "Speed [ "..speeds.." ]"
    else
       speeds = speeds - 1
            FlySpeed.Text = "Speed [ "..speeds.." ]"
        if nowe == true then
            tpwalking = false
            for i = 1, speeds do
                spawn(function()
                    local hb = game:GetService("RunService").Heartbeat    
                    tpwalking = true
                    local chr = game.Players.LocalPlayer.Character
                    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                    while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                        if hum.MoveDirection.Magnitude > 0 then
                            chr:TranslateBy(hum.MoveDirection)
                        end
                    end
                end)
            end
        end
    end
end)

FlyX.MouseButton1Click:Connect(function()
    game.CoreGui.Execute.FlyGot.Visible = false
end)

----// Position & CFrame \\----

local Frame = Instance.new("Frame")
Frame.Name = "Frame19"
Frame.Size = UDim2.new(0.5, 0, 0.7, 0)
Frame.Position = UDim2.new(0.25, 0, 0.1, 0)
Frame.BackgroundColor3 = Color3.new(1, 1, 1)
Frame.Active = true
Frame.Visible = false
Frame.Draggable = true
Frame.Parent = gui

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(1, 0, 0.13, 0)
TextLabel.Position = UDim2.new(0, 0, 0, 0)
TextLabel.BackgroundColor3 = Color3.new(1,1,1)
TextLabel.Text = "Position & CFrame | Ui Library"
TextLabel.TextSize = 10
TextLabel.TextColor3 = Color3.new(0,0,0)
TextLabel.Parent = Frame

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.13, 0, 0.13, 0)
TextButton.Position = UDim2.new(0.87, 0, 0, 0)
TextButton.BackgroundColor3 = Color3.new(1,1,1)
TextButton.Text = "X"
TextButton.TextSize = 15
TextButton.BackgroundTransparency = 1
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = Frame
TextButton.MouseButton1Click:Connect(function()
    game.CoreGui.Execute.Frame19.Visible = false
end)

local TextLabel = Instance.new("TextLabel")
TextLabel.Name = "CheckUse"
TextLabel.Size = UDim2.new(0.3, 0, 0.1, 0)
TextLabel.Position = UDim2.new(0.35, 0, 0.13, 0)
TextLabel.BackgroundColor3 = Color3.new(1,1,1)
TextLabel.Text = "You Using Position"
TextLabel.TextSize = 10
TextLabel.BackgroundTransparency = 1
TextLabel.TextColor3 = Color3.new(0,0,0)
TextLabel.Parent = Frame

local TextBox = Instance.new("TextBox")
TextBox.Name = "Check"
TextBox.Size = UDim2.new(0.93, 0, 0.2, 0)
TextBox.Position = UDim2.new(0.04, 0, 0.22, 0)
TextBox.BackgroundColor3 = Color3.new(1,1,1)
TextBox.Text = ""
TextBox.TextWrapped = true
TextBox.TextColor3 = Color3.new(0,0,0)
TextBox.TextSize = 10
TextBox.Parent = Frame

local TextButton = Instance.new("TextButton")
TextButton.Name = "CheckTele"
TextButton.Size = UDim2.new(0.28, 0, 0.2, 0)
TextButton.Position = UDim2.new(0.05, 0, 0.5, 0)
TextButton.BackgroundColor3 = Color3.new(1,1,1)
TextButton.Text = "Check"
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = Frame
TextButton.MouseButton1Click:Connect(function()
if game.CoreGui.Execute.Frame19.CheckUse.Text == "You Using Position" then
game.CoreGui.Execute.Frame19.Check.Text = tostring(math.round(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X)..", ".. math.round(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y)..", "..math.round(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z))
elseif game.CoreGui.Execute.Frame19.CheckUse.Text == "You Using CFrame" then
game.CoreGui.Execute.Frame19.Check.Text = tostring(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
end
end)

local TextButton = Instance.new("TextButton")
TextButton.Name = "Teleport"
TextButton.Size = UDim2.new(0.28, 0, 0.2, 0)
TextButton.Position = UDim2.new(0.36, 0, 0.5, 0)
TextButton.BackgroundColor3 = Color3.new(1,1,1)
TextButton.Text = "Teleport"
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = Frame
TextButton.MouseButton1Click:Connect(function()
local ValuesTele = {}
for Value in string.gmatch(game.CoreGui.Execute.Frame19.Check.Text, "[^, ]+") do
            table.insert(ValuesTele, tonumber(Value))
        end        
        if #ValuesTele >= 3 then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(ValuesTele[1], ValuesTele[2], ValuesTele[3]))
        else
         local success, CheckCFrame = pcall(function()
            return loadstring("return "..game.CoreGui.Execute.Frame19.Check.Text)()
        end)
        if success and typeof(CheckCFrame) == "CFrame" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CheckCFrame
        end
    end
end)

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.28, 0, 0.2, 0)
TextButton.Position = UDim2.new(0.05, 0, 0.75, 0)
TextButton.BackgroundColor3 = Color3.new(1,1,1)
TextButton.Text = "[ Copy ] Available Teleport"
TextButton.TextWrapped = true
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = Frame
TextButton.MouseButton1Click:Connect(function()
setclipboard("game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new("..game.CoreGui.Execute.Frame19.Check.Text..")")
end)

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.28, 0, 0.2, 0)
TextButton.Position = UDim2.new(0.36, 0, 0.75, 0)
TextButton.BackgroundColor3 = Color3.new(1,1,1)
TextButton.Text = "[ Copy ] No Available Teleport"
TextButton.TextWrapped = true
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = Frame
TextButton.MouseButton1Click:Connect(function()
setclipboard(game.CoreGui.Execute.Frame19.Check.Text)
end)

local TextButton = Instance.new("TextButton")
TextButton.Name = "Getcheck"
TextButton.Size = UDim2.new(0.28, 0, 0.45, 0)
TextButton.Position = UDim2.new(0.67, 0, 0.5, 0)
TextButton.BackgroundColor3 = Color3.new(1,1,1)
TextButton.Text = "Convert In [ CFrame ]"
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = Frame
TextButton.MouseButton1Click:Connect(function()
if game.CoreGui.Execute.Frame19.CheckUse.Text ~= "You Using Position" then
game.CoreGui.Execute.Frame19.CheckUse.Text = "You Using Position"
game.CoreGui.Execute.Frame19.Getcheck.Text = "Convert In [ CFrame ]"
game.CoreGui.Execute.Frame19.Check.Text = tostring(math.round(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X)..", ".. math.round(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y)..", "..math.round(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z))
elseif game.CoreGui.Execute.Frame19.CheckUse.Text == "You Using Position" then
game.CoreGui.Execute.Frame19.CheckUse.Text = "You Using CFrame"
game.CoreGui.Execute.Frame19.Getcheck.Text = "Convert In [ Position ]"
game.CoreGui.Execute.Frame19.Check.Text = tostring(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
end
end)

----// Position & CFrame Player \\----

local Frame = Instance.new("Frame")
Frame.Name = "Frame20"
Frame.Size = UDim2.new(0.5, 0, 0.7, 0)
Frame.Position = UDim2.new(0.25, 0, 0.1, 0)
Frame.BackgroundColor3 = Color3.new(1, 1, 1)
Frame.Active = true
Frame.Visible = false
Frame.Draggable = true
Frame.Parent = gui

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(1, 0, 0.13, 0)
TextLabel.Position = UDim2.new(0, 0, 0, 0)
TextLabel.BackgroundColor3 = Color3.new(1,1,1)
TextLabel.Text = "Position & CFrame Player | Ui Library"
TextLabel.TextSize = 10
TextLabel.TextColor3 = Color3.new(0,0,0)
TextLabel.Parent = Frame

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.13, 0, 0.13, 0)
TextButton.Position = UDim2.new(0.87, 0, 0, 0)
TextButton.BackgroundColor3 = Color3.new(1,1,1)
TextButton.Text = "X"
TextButton.TextSize = 15
TextButton.BackgroundTransparency = 1
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = Frame
TextButton.MouseButton1Click:Connect(function()
    game.CoreGui.Execute.Frame20.Visible = false
end)

local TextLabel = Instance.new("TextLabel")
TextLabel.Name = "CheckUse1"
TextLabel.Size = UDim2.new(0.3, 0, 0.1, 0)
TextLabel.Position = UDim2.new(0.35, 0, 0.13, 0)
TextLabel.BackgroundColor3 = Color3.new(1,1,1)
TextLabel.Text = "Player Using Position"
TextLabel.TextSize = 10
TextLabel.BackgroundTransparency = 1
TextLabel.TextColor3 = Color3.new(0,0,0)
TextLabel.Parent = Frame

local TextBox = Instance.new("TextBox")
TextBox.Name = "Check1"
TextBox.Size = UDim2.new(0.52, 0, 0.2, 0)
TextBox.Position = UDim2.new(0.04, 0, 0.22, 0)
TextBox.BackgroundColor3 = Color3.new(1,1,1)
TextBox.Text = ""
TextBox.TextWrapped = true
TextBox.TextColor3 = Color3.new(0,0,0)
TextBox.TextSize = 10
TextBox.Parent = Frame

local TextBox = Instance.new("TextBox")
TextBox.Name = "CheckPlayer"
TextBox.Size = UDim2.new(0.35, 0, 0.2, 0)
TextBox.Position = UDim2.new(0.6, 0, 0.22, 0)
TextBox.BackgroundColor3 = Color3.new(1,1,1)
TextBox.Text = ""
TextBox.PlaceholderText = "Put Player..."
TextBox.TextWrapped = true
TextBox.TextColor3 = Color3.new(0,0,0)
TextBox.TextSize = 10
TextBox.Parent = Frame
TextBox.FocusLost:Connect(function(enterPressed)
if enterPressed then
local targetAbbreviation = TextBox.Text
local targetPlayer
for _, v in pairs(game.Players:GetPlayers()) do
if string.sub(v.Name, 1, #targetAbbreviation):lower() == targetAbbreviation:lower() then
targetPlayer = v
break
end
end
if targetPlayer then
_G.GetPlayerGot = targetPlayer.Name
TextBox.Text = _G.GetPlayerGot
game:GetService("StarterGui"):SetCore("SendNotification",{Title = "Error",Text = "Found Player [ ".._G.GetPlayerGot.." ]",Icon = "rbxassetid://7733658504",Duration = 2})
else
game:GetService("StarterGui"):SetCore("SendNotification",{Title = "Error",Text = "Can't find player.",Icon = "rbxassetid://7733658504",Duration = 2})
end
end
end)

local TextButton = Instance.new("TextButton")
TextButton.Name = "CheckTele1"
TextButton.Size = UDim2.new(0.28, 0, 0.2, 0)
TextButton.Position = UDim2.new(0.05, 0, 0.5, 0)
TextButton.BackgroundColor3 = Color3.new(1,1,1)
TextButton.Text = "Check"
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = Frame
TextButton.MouseButton1Click:Connect(function()
if game.CoreGui.Execute.Frame20.CheckUse1.Text == "Player Using Position" then
game.CoreGui.Execute.Frame20.Check1.Text = tostring(math.round(game.Players[_G.GetPlayerGot].Character.HumanoidRootPart.Position.X)..", ".. math.round(game.Players[_G.GetPlayerGot].Character.HumanoidRootPart.Position.Y)..", "..math.round(game.Players[_G.GetPlayerGot].Character.HumanoidRootPart.Position.Z))
elseif game.CoreGui.Execute.Frame20.CheckUse1.Text == "Player Using CFrame" then
game.CoreGui.Execute.Frame20.Check1.Text = tostring(game.Players[_G.GetPlayerGot].Character.HumanoidRootPart.CFrame)
end
end)

local TextButton = Instance.new("TextButton")
TextButton.Name = "Teleport1"
TextButton.Size = UDim2.new(0.28, 0, 0.2, 0)
TextButton.Position = UDim2.new(0.36, 0, 0.5, 0)
TextButton.BackgroundColor3 = Color3.new(1,1,1)
TextButton.Text = "Teleport"
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = Frame
TextButton.MouseButton1Click:Connect(function()
_G.TeleportGet = tostring(game.CoreGui.Execute.Frame20.Check1.Text)
game.Players.LocalPlayer.Character:MoveTo(_G.TeleportGet)
end)

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.28, 0, 0.2, 0)
TextButton.Position = UDim2.new(0.05, 0, 0.75, 0)
TextButton.BackgroundColor3 = Color3.new(1,1,1)
TextButton.Text = "[ Copy ] Available Teleport"
TextButton.TextWrapped = true
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = Frame
TextButton.MouseButton1Click:Connect(function()
setclipboard("game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new("..game.CoreGui.Execute.Frame20.Check1.Text..")")
end)

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.28, 0, 0.2, 0)
TextButton.Position = UDim2.new(0.36, 0, 0.75, 0)
TextButton.BackgroundColor3 = Color3.new(1,1,1)
TextButton.Text = "[ Copy ] No Available Teleport"
TextButton.TextWrapped = true
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = Frame
TextButton.MouseButton1Click:Connect(function()
setclipboard(game.CoreGui.Execute.Frame20.Check1.Text)
end)

local TextButton = Instance.new("TextButton")
TextButton.Name = "Getcheck1"
TextButton.Size = UDim2.new(0.28, 0, 0.45, 0)
TextButton.Position = UDim2.new(0.67, 0, 0.5, 0)
TextButton.BackgroundColor3 = Color3.new(1,1,1)
TextButton.Text = "Convert In [ CFrame ]"
TextButton.TextColor3 = Color3.new(0,0,0)
TextButton.Parent = Frame
TextButton.MouseButton1Click:Connect(function()
if game.CoreGui.Execute.Frame20.CheckUse1.Text ~= "Player Using Position" then
game.CoreGui.Execute.Frame20.CheckUse1.Text = "Player Using Position"
game.CoreGui.Execute.Frame20.Getcheck1.Text = "Convert In [ CFrame ]"
game.CoreGui.Execute.Frame20.Check1.Text = tostring(math.round(game.Players[_G.GetPlayerGot].Character.HumanoidRootPart.Position.X)..", ".. math.round(game.Players[_G.GetPlayerGot].Character.HumanoidRootPart.Position.Y)..", "..math.round(game.Players[_G.GetPlayerGot].Character.HumanoidRootPart.Position.Z))
elseif game.CoreGui.Execute.Frame20.CheckUse1.Text == "Player Using Position" then
game.CoreGui.Execute.Frame20.CheckUse1.Text = "Player Using CFrame"
game.CoreGui.Execute.Frame20.Getcheck1.Text = "Convert In [ Position ]"
game.CoreGui.Execute.Frame20.Check1.Text = tostring(game.Players[_G.GetPlayerGot].Character.HumanoidRootPart.CFrame)
end
end)

-----// Dex V0.5 \\------

local Frame29 = Instance.new("Frame")
Frame29.Name = "Frame29"
Frame29.Size = UDim2.new(0.45, 0, 0.7, 0)
Frame29.Position = UDim2.new(0.2, 0, 0.1, 0)
Frame29.BackgroundColor3 = Color3.new(1, 1, 1)
Frame29.Active = true
Frame29.BackgroundTransparency = 0 
Frame29.Draggable = true
Frame29.Visible = false
Frame29.Parent = gui

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(1, 0, 0.15, 0)
TextLabel.Position = UDim2.new(0, 0, 0, 0)
TextLabel.BackgroundColor3 = Color3.new(255, 255, 255)
TextLabel.Text = "Dex V0.6"
TextLabel.TextSize = 10
TextLabel.BackgroundTransparency = 0 
TextLabel.TextColor3 = Color3.new(0, 0, 0)
TextLabel.Parent = Frame29

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.13, 0, 1, 0)
TextButton.Position = UDim2.new(0.87, 0, 0, 0)
TextButton.BackgroundColor3 = Color3.new(255, 255, 255)
TextButton.Text = "X"
TextButton.TextSize = 13
TextButton.BackgroundTransparency = 1
TextButton.TextColor3 = Color3.new(0, 0, 0)
TextButton.Parent = TextLabel
TextButton.MouseButton1Click:Connect(function()
game.CoreGui.Execute.Frame29.Visible = false
end)

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.3, 0, 0.13, 0)
TextButton.Position = UDim2.new(0.03, 0, 0.2, 0)
TextButton.BackgroundColor3 = Color3.new(255, 255, 255)
TextButton.Text = "Copy"
TextButton.TextSize = 10
TextButton.BackgroundTransparency = 0 
TextButton.TextColor3 = Color3.new(0, 0, 0)
TextButton.Parent = Frame29
TextButton.MouseButton1Click:Connect(function()
if setclipboard then
setclipboard(game.CoreGui.Execute.Frame29.TextBox.Text)
end
end)

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.3, 0, 0.13, 0)
TextButton.Position = UDim2.new(0.35, 0, 0.2, 0)
TextButton.BackgroundColor3 = Color3.new(255, 255, 255)
TextButton.Text = "Clear"
TextButton.TextSize = 10
TextButton.BackgroundTransparency = 0 
TextButton.TextColor3 = Color3.new(0, 0, 0)
TextButton.Parent = Frame29
TextButton.MouseButton1Click:Connect(function()
game.CoreGui.Execute.Frame29.TextBox.Text = ""
end)

_G.ToggleDex = false
local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.3, 0, 0.13, 0)
TextButton.Position = UDim2.new(0.67, 0, 0.2, 0)
TextButton.BackgroundColor3 = Color3.new(255, 255, 255)
TextButton.Text = "OFF"
TextButton.TextSize = 10
TextButton.BackgroundTransparency = 0 
TextButton.TextColor3 = Color3.new(0, 0, 0)
TextButton.Parent = Frame29
TextButton.MouseButton1Click:Connect(function()
_G.ToggleDex = not _G.ToggleDex
if _G.ToggleDex == true then
TextButton.Text = "ON"
else
TextButton.Text = "OFF"
end
end)

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(0.94, 0, 0.6, 0)
TextBox.Position = UDim2.new(0.03, 0, 0.35, 0)
TextBox.BackgroundColor3 = Color3.new(255,255,255)
TextBox.Text = "Click target (Get Show, Turn On / OFF)."
TextBox.TextWrapped = true
TextBox.ClipsDescendants = true
TextBox.MultiLine = true
TextBox.ClearTextOnFocus = false
TextBox.TextColor3 = Color3.new(0,0,0)
TextBox.TextSize = 12
TextBox.Parent = Frame29

local NextButton = Instance.new("TextButton")
NextButton.Size = UDim2.new(0.07, 0, 0.1, 0)
NextButton.Position = UDim2.new(0.93, 0, -0.12, 0)
NextButton.BackgroundColor3 = Color3.new(255, 255, 255)
NextButton.Text = ">"
NextButton.TextSize = 15
NextButton.BackgroundTransparency = 0
NextButton.TextColor3 = Color3.new(0, 0, 0)
NextButton.Parent = Frame29
NextButton.MouseButton1Click:Connect(function()
game.CoreGui.Execute.Frame29.Frame.Visible = not game.CoreGui.Execute.Frame29.Frame.Visible
if game.CoreGui.Execute.Frame29.Frame.Visible == false then
NextButton.Text = ">"
else
NextButton.Text = "<"
end
end)

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0.6, 0, 1, 0)
Frame.Position = UDim2.new(1.02, 0, 0, 0)
Frame.BackgroundColor3 = Color3.new(1, 1, 1)
Frame.BorderColor3 = Color3.new(0, 0, 0)
Frame.BorderSizePixel = 1
Frame.Active = true
Frame.Visible = false
Frame.BackgroundTransparency = 0 
Frame.Parent = Frame29

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollingFrame.Position = UDim2.new(0, 0, 0, 0)
ScrollingFrame.BackgroundColor3 = Color3.new(1, 1, 1)
ScrollingFrame.BorderColor3 = Color3.new(0, 0, 0)
ScrollingFrame.BorderSizePixel = 1
ScrollingFrame.BackgroundTransparency = 0 
ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollingFrame.ScrollBarThickness = 0
ScrollingFrame.Parent = Frame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Parent = ScrollingFrame

function CreateToggleFrame(Name,call,Winds)
local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(1, 0, 0.2, 0)
TextLabel.Position = UDim2.new(0, 0, 0, 0)
TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel.Text = Name
TextLabel.TextSize = 10
TextLabel.TextXAlignment = Enum.TextXAlignment.Left
TextLabel.BackgroundTransparency = 0 
TextLabel.TextColor3 = Color3.new(0,0,0)
TextLabel.Parent = ScrollingFrame

_G.ToggleGet = false
local ToggleButton = Instance.new("ImageButton")
ToggleButton.Size = UDim2.new(0.2, 0, 0.8, 0)
ToggleButton.Position = UDim2.new(0.78, 0, 0.1, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 186, 117)
ToggleButton.ImageColor3 = Color3.fromRGB(245, 21, 17)
ToggleButton.Image = "rbxassetid://7743878857"
ToggleButton.Parent = TextLabel
ToggleButton.MouseButton1Click:Connect(function()
_G.ToggleGet = not _G.ToggleGet
ToggleButton.Image = (_G.ToggleGet and "rbxassetid://3944680095") or "rbxassetid://7743878857"
ToggleButton.ImageColor3 = (_G.ToggleGet and Color3.fromRGB(17, 245, 97)) or Color3.fromRGB(245, 21, 17)
pcall(call,_G.ToggleGet)
end)
end

_G.Dex = {
	["Workspace"] = false,
	["InfoPart"] = false,
	["InfoMeshPart"] = false
}

CreateToggleFrame("Workspace", function(Value)
for v in pairs(_G.Dex) do
     _G.Dex[v] = false
end
_G.Dex["Workspace"] = Value
end)

CreateToggleFrame("Info Part", function(Value)
for v in pairs(_G.Dex) do
     _G.Dex[v] = false
end
_G.Dex["InfoPart"] = Value
end)

CreateToggleFrame("Info MeshPart", function(Value)
for v in pairs(_G.Dex) do
     _G.Dex[v] = false
end
_G.Dex["InfoMeshPart"] = Value
end)

game.Players.LocalPlayer:GetMouse().Button1Down:Connect(function()
    if _G.ToggleDex == true then
       if _G.Dex["Workspace"] == true then
        if game.Players.LocalPlayer:GetMouse().Target and game.Players.LocalPlayer:GetMouse().Target:IsDescendantOf(workspace) then
            local Code = "game.Workspace"
            local Click = game.Players.LocalPlayer:GetMouse().Target
            local Parts = {}
            while Click and Click.Parent and Click.Parent ~= game do
                table.insert(Parts, 1, Click.Name)
                Click = Click.Parent
            end
            for i, v in ipairs(Parts) do
                if i == #Parts then
                    if string.find(v, " ") or string.find(v, "/") or string.find(v, "-") or string.find(v, "@") or string.find(v, "#") or string.find(v, "₫") or string.find(v, "&") or string.find(v, "+") or string.find(v, "*") or string.find(v, ":") or string.find(v, ";") or string.find(v, "!") or string.find(v, "?") or string.find(v, "€") or string.find(v, "£") or string.find(v, "~") then
                        Code = Code..'["'..v..'"]'
                    else
                        Code = Code.."."..v
                    end
                else
                    if string.find(v, " ") or string.find(v, "/") or string.find(v, "-") or string.find(v, "@") or string.find(v, "#") or string.find(v, "₫") or string.find(v, "&") or string.find(v, "+") or string.find(v, "*") or string.find(v, ":") or string.find(v, ";") or string.find(v, "!") or string.find(v, "?") or string.find(v, "€") or string.find(v, "£") or string.find(v, "~") then
                        Code = Code..'["'..v..'"]'
                    else
                        Code = Code.."."..v
                    end
                end
            end
        TextBox.Text = Code
    end
else
if game.Players.LocalPlayer:GetMouse().Target and game.Players.LocalPlayer:GetMouse().Target:IsDescendantOf(workspace) then
    local Click = game.Players.LocalPlayer:GetMouse().Target
    if Click.ClassName == "Part" and _G.Dex["InfoPart"] == true or Click.ClassName == "MeshPart" and _G.Dex["InfoMeshPart"] == true then
        local Code = Click
        local Parts = {}
        while Click and Click.Parent and Click.Parent ~= game do
            table.insert(Parts, 1, Click.Name)
            Click = Click.Parent
        end
        local CodeString = "game.Workspace"
        for i, v in ipairs(Parts) do
            if i == #Parts then
                if string.find(v, " ") or string.find(v, "/") or string.find(v, "-") or string.find(v, "@") or string.find(v, "#") or string.find(v, "₫") or string.find(v, "&") or string.find(v, "+") or string.find(v, "*") or string.find(v, ":") or string.find(v, ";") or string.find(v, "!") or string.find(v, "?") or string.find(v, "€") or string.find(v, "£") or string.find(v, "~") then
                    CodeString = CodeString..'["'..v..'"]'
                else
                    CodeString = CodeString.."."..v
                end
            else
                if string.find(v, " ") or string.find(v, "/") or string.find(v, "-") or string.find(v, "@") or string.find(v, "#") or string.find(v, "₫") or string.find(v, "&") or string.find(v, "+") or string.find(v, "*") or string.find(v, ":") or string.find(v, ";") or string.find(v, "!") or string.find(v, "?") or string.find(v, "€") or string.find(v, "£") or string.find(v, "~") then
                    CodeString = CodeString..'["'..v..'"]'
                else
                    CodeString = CodeString.."."..v
                end
            end
        end
     if _G.Dex["InfoPart"] == true then
        TextBox.Text = 
        "local "..Code.Name..' = Instance.new("Part", '..(CodeString:gsub("."..Code.Name, "") or "nil")..')\n'..
        Code.Name..".Position = Vector3.new("..tostring(Code.Position)..")\n"..
        Code.Name..".Name = "..'"'..Code.Name..'"\n'..
        Code.Name..".Size = Vector3.new("..tostring(Code.Size)..")\n"..
        Code.Name..".Orientation = Vector3.new("..tostring(Code.Orientation)..")\n"..
        Code.Name..".Anchored = "..tostring(Code.Anchored).."\n"..
        Code.Name..".CanCollide = "..tostring(Code.CanCollide).."\n"..
        Code.Name..".Locked = "..tostring(Code.Locked).."\n"..
        Code.Name..".Material = Enum.Material."..tostring(Code.Material).."\n"..
        Code.Name..'.BrickColor = BrickColor.new("'..tostring(Code.BrickColor)..'")\n'..
        Code.Name..".Transparency = "..tostring(Code.Transparency).."\n"..
        Code.Name..".Reflectance = "..tostring(Code.Reflectance).."\n"..
        Code.Name..".Color = Color3.new("..tostring(Code.Color)..")\n"..
        Code.Name..".Shape = Enum.Material."..tostring(Code.Shape)
    elseif _G.Dex["InfoMeshPart"] == true then
        TextBox.Text = 
        "local "..Code.Name..' = Instance.new("MeshPart", '..(CodeString:gsub("."..Code.Name, "") or "nil")..')\n'..
        Code.Name..".Position = Vector3.new("..tostring(Code.Position)..")\n"..
        Code.Name..".Name = "..'"'..Code.Name..'"\n'..
        Code.Name..".Size = Vector3.new("..tostring(Code.Size)..")\n"..
        Code.Name..".Orientation = Vector3.new("..tostring(Code.Orientation)..")\n"..
        Code.Name..'.MeshId = "'..Code.MeshId..'"\n'..
        Code.Name..".Anchored = "..tostring(Code.Anchored).."\n"..
        Code.Name..".CanCollide = "..tostring(Code.CanCollide).."\n"..
        Code.Name..".Locked = "..tostring(Code.Locked).."\n"..
        Code.Name..".Material = Enum.Material."..tostring(Code.Material).."\n"..
        Code.Name..'.BrickColor = BrickColor.new("'..tostring(Code.BrickColor)..'")\n'..
        Code.Name..".Transparency = "..tostring(Code.Transparency).."\n"..
        Code.Name..".Reflectance = "..tostring(Code.Reflectance).."\n"..
        Code.Name..".Color = Color3.new("..tostring(Code.Color)..")"
    end
end
end
end
end
end)

------// Shiftlock \\--------

local Active
local States = {
    Off = "rbxasset://textures/ui/mouseLock_off@2x.png",
    On = "rbxasset://textures/ui/mouseLock_on@2x.png",
    Lock = "rbxasset://textures/MouseLockedCursor.png",
    Lock2 = "rbxasset://SystemCursors/Cross"
}

local ShiftLockButton = Instance.new("ImageButton")
ShiftLockButton.Name = "ShiftLockButton"
ShiftLockButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ShiftLockButton.BackgroundTransparency = 1.000
ShiftLockButton.Position = UDim2.new(0.7, 0, 0.75, 0)
ShiftLockButton.Size = UDim2.new(0.0636147112, 0, 0.0661305636, 0)
ShiftLockButton.SizeConstraint = Enum.SizeConstraint.RelativeXX
ShiftLockButton.Visible = false
ShiftLockButton.Draggable = true
ShiftLockButton.Image = States.Off
ShiftLockButton.Parent = gui

local ShiftlockCursor = Instance.new("ImageLabel")
ShiftlockCursor.Name = "Shiftlock Cursor"
ShiftlockCursor.Parent = ShiftLockButton
ShiftlockCursor.Image = States.Lock
ShiftlockCursor.Size = UDim2.new(0.03, 0, 0.03, 0)
ShiftlockCursor.Position = UDim2.new(0.5, 0, 0.5, 0)
ShiftlockCursor.AnchorPoint = Vector2.new(0.5, 0.5)
ShiftlockCursor.SizeConstraint = Enum.SizeConstraint.RelativeXX
ShiftlockCursor.BackgroundTransparency = 1
ShiftlockCursor.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ShiftlockCursor.Visible = false

ShiftLockButton.MouseButton1Click:Connect(function()
        if not Active then
            Active = game:GetService("RunService").RenderStepped:Connect(function()
                    game.Players.LocalPlayer.Character.Humanoid.AutoRotate = false
                    ShiftLockButton.Image = States.On
                    ShiftlockCursor.Visible = true
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, Vector3.new(workspace.CurrentCamera.CFrame.LookVector.X * 900000, game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y, workspace.CurrentCamera.CFrame.LookVector.Z * 900000))
                    workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(1.7, 0, 0)
                    workspace.CurrentCamera.Focus = CFrame.fromMatrix(workspace.CurrentCamera.Focus.Position, workspace.CurrentCamera.CFrame.RightVector, workspace.CurrentCamera.CFrame.UpVector) * CFrame.new(1.7, 0, 0)
                end)
        else
            game.Players.LocalPlayer.Character.Humanoid.AutoRotate = true
            ShiftLockButton.Image = States.Off
            workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(-1.7, 0, 0)
            ShiftlockCursor.Visible = false
            pcall(function()
                    Active:Disconnect()
                    Active = nil
            end)
        end
    end)

------// Auto Delete \\---------

while true do
if game.CoreGui:FindFirstChild("Execute") == nil then
pcall(function()
if Active then
   Active:Disconnect()
   Active = nil
elseif KeyCodeBo then
   KeyCodeBo:Disconnect()
   KeyCodeBo = nil
elseif AutoDelete then
AutoDelete:Disconnect()
AutoDelete = nil
end
end)
end
task.wait()
end
wait(0.7)
for i,v in ipairs(listfiles("ExecuteGet")) do
SavedScriptsAdd({Name = v:sub(12, #v), Script = readfile(v), true})
end
end
