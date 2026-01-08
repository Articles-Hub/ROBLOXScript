# Orion Library
This documentation is for the stable release of Orion Library.

# Icons
```lua
https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/Library/Orion/icons.json
```
This icon You can access it to copy the icon ID.



## Booting the Library
```lua
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/Library/Orion/Source.lua')))()
```



## Creating a Window
```lua
local Window = OrionLib:MakeWindow({Name = "Title of the library", SearchBar = {Default = "Search Tabs", ClearTextOnFocus = true}, IntroToggleIcon = "rbxassetid://7734091286", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})

--[[
Name = <string> - The name of the UI.
HidePremium = <bool> - Whether or not the user details shows Premium status or not.
SaveConfig = <bool> - Toggles the config saving in the UI.
ConfigFolder = <string> - The name of the folder where the configs are saved.
IntroEnabled = <bool> - Whether or not to show the intro animation.
IntroText = <string> - Text to show in the intro animation.
SearchBar = {
	Default = <string> - The name of the search.
	ClearTextOnFocus = <bool> - The clean text focus of the search.
} 
IntroToggleIcon = <string> - the intro icon toggle to the UI/window can be opened
IntroIcon = <string> - URL to the image you want to use in the intro animation.
Icon = <string> - URL to the image you want displayed on the window.
CloseCallback = <function> - Function to execute when the window is closed.
]]
```



## Creating a Tab
```lua
local Tab = Window:MakeTab({
        Name = "Tab 1",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
})

--[[
Name = <string> - The name of the tab.
Icon = <string> - The icon of the tab.
PremiumOnly = <bool> - Makes the tab accessible to Sirus Premium users only.
]]
```
## Creating a Section
```lua
local Section = Tab:AddSection({
        Name = "Section"
})

--[[
Name = <string> - The name of the section.
]]
```
You can add elements to sections the same way you would add them to a tab normally.

## Notifying the user
```lua
OrionLib:MakeNotification({
        Name = "Title!",
        Content = "Notification content... what will it say??",
        Image = "rbxassetid://4483345998",
        Time = 5
})

--[[
Title = <string> - The title of the notification.
Content = <string> - The content of the notification.
Image = <string> - The icon of the notification.
Time = <number> - The duration of the notfication.
]]
```



## Creating a Button
```lua
ButtonClick = Tab:AddButton({
        Name = "Button!",
        Callback = function()
                      print("button pressed")
          end    
})

--[[
Name = <string> - The name of the button.
Callback = <function> - The function of the button.
]]
```


## Change label a Button
```lua
ButtonClick:Set("Button?")
```


## Change script a Button
```lua
ButtonClick:SetCallback(function()
	print("is button!")
end)
```


## Creating a Checkbox toggle
```lua
Tab:AddToggle({
	Name = "This is a toggle!",
	Default = false,
	Flag = "Toggles",
	Callback = function(Value)
		print(Value)
	end    
}):AddBind({
	Default = Enum.KeyCode.F
})

--[[
Name = <string> - The name of the toggle.
Default = <bool> - The default value of the toggle.
Callback = <function> - The function of the toggle.
Flag = <string> - flag remote of the toggle
Save = <bool> - The save of the toggle in turn on/off

AddBind:
Default = <keycode> - The default value of the bind toggles.
Flag = <string> - flag remote of the bind toggles
Save = <bool> - The save of the bind in <key>
]]
```

### Changing the value of an existing Toggle
```lua
CoolToggle:Set(true)
OrionLib.Flags["Toggles"]:Set(true)
```

### Changing the label of an existing Toggle
```lua
CoolToggle:SetText("This is a toggle?")
OrionLib.Flags["Toggles"]:SetText("This is a toggle?")
```

### Changing the script of an existing Toggle
```lua
CoolToggle:SetCallback(function(Value)
	print("This is a toggle!", Value)
end)

OrionLib.Flags["Toggles"]:SetCallback(function(Value)
	print("This is a toggle!", Value)
end)
```



## Creating a Color Picker
```lua
Tab:AddColorpicker({
        Name = "Colorpicker",
        Default = Color3.fromRGB(255, 0, 0),
        Flag = "Color",
        Callback = function(Value)
                print(Value)
        end          
})

--[[
Name = <string> - The name of the colorpicker.
Default = <color3> - The default value of the colorpicker.
Callback = <function> - The function of the colorpicker.
Flag = <string> - The flag remote to the colorpicker.
Save = <bool> - The save of the colorpicker
]]
```

### Setting the color picker's value
```lua
ColorPicker:Set(Color3.fromRGB(255,255,255))
OrionLib.Flags["Color"]:Set(Color3.fromRGB(255,255,255))
```

### Changing the script of an colorpicker
```lua
ColorPicker:SetCallback(function(Value)
	print("This is a Colorpicker!", Value)
end)

OrionLib.Flags["Color"]:SetCallback(function(Value)
	print("This is a Colorpicker!", Value)
end)
```


## Creating a Slider
```lua
Tab:AddSlider({
        Name = "Slider",
        Min = 0,
        Max = 20,
        Default = 5,
        Color = Color3.fromRGB(255,255,255),
        Increment = 1,
        ValueName = "bananas",
        Flag = "SliderTo",
        Callback = function(Value)
                print(Value)
        end    
})

--[[
Name = <string> - The name of the slider.
Min = <number> - The minimal value of the slider.
Max = <number> - The maxium value of the slider.
Increment = <number> - How much the slider will change value when dragging.
Default = <number> - The default value of the slider.
ValueName = <string> - The text after the value number.
Flag = <string> - The flag remote to the slider.
Callback = <function> - The function of the slider.
]]
```

### Change Slider Value
```lua
Slider:Set(2)
OrionLib.Flags["SliderTo"]:Set(2)
```


### Change Slider Value Max
```lua
Slider:SetMax(90)
OrionLib.Flags["SliderTo"]:SetMax(90)
```


### Change Slider Value Min
```lua
Slider:SetMin(10)
OrionLib.Flags["SliderTo"]:SetMax(10)
```


### Change script in Slider
```lua
Slider:SetCallback(function(Value)
	print(Value, "Good")
end)

OrionLib.Flags["SliderTo"]:SetCallback(function(Value)
	print(Value, "Good")
end)
```
Make sure you make your slider a variable (local CoolSlider = Tab:AddSlider...) for this to work.


## Creating a Label
```lua
CoolLabel = Tab:AddLabel("Label")
```

### Changing the value of an existing label
```lua
CoolLabel:Set("Label New!")
```


## Creating a Paragraph
```lua
CoolParagraph = Tab:AddParagraph("Paragraph","Paragraph Content")
```

### Changing an existing paragraph
```lua
CoolParagraph:Set("Paragraph New!", "New Paragraph Content!")
```


## Creating an Adaptive Input
```lua
Tab:AddTextbox({
        Name = "Textbox",
        Default = "default box input",
        TextDisappear = true,
        Flag = "TextBox",
        Finished = true,
        Numeric = false,
        Callback = function(Value)
                print(Value)
        end          
})

--[[
Name = <string> - The name of the textbox.
Default = <string> - The default value of the textbox.
TextDisappear = <bool> - Makes the text disappear in the textbox after losing focus.
Flag = <string> - The flag remote to the textbox.
Finished = <bool> - the finished enter of the textbox.
Numeric = <bool> - the numeric a adaptive input number, no <string>
Callback = <function> - The function of the textbox.
]]
```


## Change value an Adaptive Input
```lua
TextBoxCool:SetText("What")
OrionLib.Flags["TextBox"]:SetText("How?")
```


## Change label an Adaptive Input
```lua
TextBoxCool:SetLabel("Why")
OrionLib.Flags["TextBox"]:SetLabel("Nothing?")
```


## Change script an Adaptive Input
```lua
TextBoxCool:SetCallback(function(Value)
	print("is input (TextBox) ", Value)
end)

OrionLib.Flags["TextBox"]:SetCallback(function(Value)
	print("is input (TextBox) ", Value)
end)
```


## Creating a Keybind
```lua
Tab:AddBind({
        Name = "Bind",
        Default = Enum.KeyCode.E,
        Hold = false,
        Flag = "Bind",
        Callback = function()
                print("press")
        end    
})

--[[
Name = <string> - The name of the bind.
Default = <keycode> - The default value of the bind.
Hold = <bool> - Makes the bind work like: Holding the key > The bind returns true, Not holding the key > Bind returns false.
Flag = <string> - The flag remote to the keybind.
Callback = <function> - The function of the bind.
]]
```

### Chaning the value of a bind
```lua
Bind:Set(Enum.KeyCode.E)
OrionLib.Flags["Bind"]:Set(Enum.KeyCode.E)
```


### Chaning the label of a bind
```lua
Bind:SetText("Hello")
OrionLib.Flags["Bind"]:SetText("Bruh")
```


### Chaning the script of a bind
```lua
Bind:SetCallback(function()
	print("huh")
end)

OrionLib.Flags["Bind"]:SetCallback(function()
	print("huh")
end)
```


## Creating a Dropdown menu
```lua
Tab:AddDropdown({
        Name = "Dropdown",
        Default = "1",
        Options = {"1", "2"},
        Multi = false,
        Flag = "Dropdown",
        Callback = function(Value)
                print(Value)
        end    
})

---- Multi ----

Tab:AddDropdown({
        Name = "Dropdown",
        Default = {"4", "5"},
        Options = {"4", "5", "6"},
        Multi = true,
        Flag = "Dropdown",
        Callback = function(Value)
                print(Value)
        end    
})

--[[
Name = <string> - The name of the dropdown.
Default = <string> - The default value of the dropdown.
Options = <table> - The options in the dropdown.
Flag = <string> - The flag remote to the dropdown.
Multi = <bool> - the multi of the dropdown.
Callback = <function> - The function of the dropdown.
]]
```

### Adding a set of new Dropdown buttons to an existing menu
```lua
Dropdown:Refresh(List<table>,true)
OrionLib.Flags["Dropdown"]:Refresh(List<table>,true)
```

The above boolean value "true" is whether or not the current buttons will be deleted.
### Selecting a dropdown option
```lua
Dropdown:Set("dropdown option")
OrionLib.Flags["Dropdown"]:Set("dropdown option")

---- Multi ----

Dropdown:Set({"dropdown option", "dropdown option 2"})
OrionLib.Flags["Dropdown"]:Set({"dropdown option", "dropdown option 2"})
```

### Chaning the script of a dropdown
```lua
Dropdown:SetCallback(function(Value)
	print("huh", Value)
	for i, v in next, Value do
		print(i, v)
	end
end)

OrionLib.Flags["Dropdown"]:SetCallback(function(Value)
	print("hub", Value)
	for i, v in next, Value do
		print(i, v)
	end
end)
```

# Finishing your script (REQUIRED)
The below function needs to be added at the end of your code.
```lua
OrionLib:Init()
```

### How flags work.
The flags feature in the ui may be confusing for some people. It serves the purpose of being the ID of an element in the config file, and makes accessing the value of an element anywhere in the code possible.
Below in an example of using flags.
```lua
Tab1:AddToggle({
    Name = "Toggle",
    Default = true,
    Save = true,
    Flag = "toggle"
})

print(OrionLib.Flags["toggle"].Value) -- prints the value of the toggle.
```
Flags only work with the toggle, slider, dropdown, bind, textbox and colorpicker.

### Making your interface work with configs.

In order to make your interface use the configs function you first need to add the `SaveConfig` and `ConfigFolder` arguments to your window function. The explanation of these arguments in above.
Then you need to add the `Flag` and `Save` values to every toggle, slider, dropdown, bind, textbox and colorpicker you want to include in the config file.
The `Flag = <string>` argument is the ID of an element in the config file.
The `Save = <bool>` argument includes the element in the config file.
Config files are made for every game the library is launched in.

## Destroying the Interface
```lua
OrionLib:Destroy()
```

## OnDestroying the if remove Interface
```lua
OrionLib:OnDestroy(function()
	print("HELL YEAAA")
end)
```
