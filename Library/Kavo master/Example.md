# Kavo Ui Library Master

## Getting Loadstring Old
```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/Library/Kavo%20master/Scoure.lua"))()
```

## Creating UI Library Window
```lua
local Window = Library.CreateLib("Name", "Ocean")
```

## Theme
You put the theme in Ocean and don't put in the name
```
LightTheme
```

```
DarkTheme
```

```
GrapeTheme
```

```
BloodTheme
```

```
Ocean
```

```
Midnight
```

```
Sentinel
```

```
Synapse
```

## Creating Tabs
```lua
local Tabs = {
    Tab = Window:NewTab("TabName"),
    Tab2 = Window:NewTab("TabName")
}
```

If you want it shorter, you have to use local
```lua
local Tab1 = Tabs.Tab
```
used multiple tabs

## Creating Section
```lua
local Section = Tab1:NewSection("Section Name")
```

## Update Section
```lua
Section:UpdateSection("Section New Title")
```

## Creating Labels
```lua
local label = Section:NewLabel("LabelText")
```

## Update Labels
```lua
label:UpdateLabel("New Text")
```

## Creating Button
```lua
local button = Section:NewButton("ButtonText", "ButtonInfo", function()
    print("Clicked")
end)
```

## Update Button
```lua
button:UpdateButton("New Text")
```
Make sure your button or ... is local when updating it.

## Creating Toggle
```lua
Section:NewToggle("ToggleText", "ToggleInfo", function(state)
    if state then
        print("Toggle On")
    else
        print("Toggle Off")
    end
end)
```

## Creating Slider
Max Value | Min Value / can be used by number
```lua
Section:NewSlider("SliderText", "SliderInfo", 500, 0, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)
```

## Creating KeyBing
KeyCode keyboard can be used remotely
```lua
Section:NewKeybind("KeybindText", "KeybindInfo", Enum.KeyCode.F, function()
	print("You just clicked the bind")
end)
```

## Toggle Kavo Ui Library
```lua
Section:NewKeybind("KeybindText", "KeybindInfo", Enum.KeyCode.F, function()
	Library:ToggleUI()
end)
```

## Dropdown / Creating / Refresh
```lua
local dropdown = Section:NewDropdown("Dropdown","Info", 
    {"Bruh, "Bag"} -- used to select what you need
, function(Value)
if Value == "Bruh" then
   print("Bruh)
elseif Value == "Bag" then
   print("Bag")
else
   print("Nah")
end
end)

Section:NewButton("Update Dropdown", "Refreshes Dropdown", function()
  dropdown:Refresh({"Gg", "Gg2"})
end)

Section:NewButton("Update Dropdown", "Refreshes Dropdown", function()
  dropdown:Refresh({"Old", "Old2"})
end)
```

## Creating ColorPicker
can see the color change you like 
```lua
Section:NewColorPicker("ColorText", "ColorInfo", Color3.fromRGB(0,0,0), function(color)
    print(color)
end)
```

## Applying Custom Themes / Colors
```lua
local colors = {
    SchemeColor = Color3.fromRGB(0,255,255),
    Background = Color3.fromRGB(0, 0, 0),
    Header = Color3.fromRGB(0, 0, 0),
    TextColor = Color3.fromRGB(255,255,255),
    ElementColor = Color3.fromRGB(20, 20, 20)
}
```

## Want to add fully customizable UI?
```lua
for theme, color in pairs(themes) do
    Section:NewColorPicker(theme, "Change your "..theme, color, function(color3)
        Library:ChangeColor(theme, color3)
    end)
end
```
