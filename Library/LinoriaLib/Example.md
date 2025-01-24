# New example script written by Giang
# You can suggest changes with a pull request or something

```lua
local repo = 'https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/Library/LinoriaLib/'

local Library = loadstring(game:HttpGet(repo .. 'Source.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
```

# Window
Set Center to true if you want the menu to appear in the center
- Set AutoShow to true if you want the menu to appear when it is created
- Position and Size are also valid options here
- but you do not need to define them unless you are changing them :)
    
```lua
local Window = Library:CreateWindow({
    Title = 'Example menu',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})
```

** CALLBACK NOTE: ***
- Passing in callback functions via the initial element parameters (i.e. Callback = function(Value)...) works

- HOWEVER, using Toggles/Options.INDEX:OnChanged(function(Value) ... ) is the RECOMMENDED way to do this.

- I strongly recommend decoupling UI code from logic code. i.e. Create your UI elements FIRST, and THEN setup :OnChanged functions later.

- You do not have to set your tabs & groups up this way, just a prefrence.

# Tabs

- Creates a new tab titled Main

```lua
local Tabs = {
    Main = Window:AddTab('Main'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}
```
```lua
NameTab = Window:AddTab('NameTab'),
```

- Groupbox and Tabbox inherit the same functions
- ** except Tabboxes you have to call the functions on a tab (Tabbox:AddTab(name)) **
```lua
local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Groupbox')
```
```lua
local RightGroupBox = Tabs.Main:AddRightGroupbox('Groupbox')
```

- We can also get our Main tab via the following code:
```lua
local LeftGroupBox = Window.Tabs.Main:AddLeftGroupbox('Groupbox')
```
```lua
local RightGroupBox = Window.Tabs.Main:AddRightGroupbox('Groupbox')
```
### Tabboxes are a tiny bit different, but here's a basic example:

```lua
local TabBox = Tabs.Main:AddLeftTabbox() -- Add Tabbox on left side
```
```lua
local Tab1 = TabBox:AddTab('Tab 1')
local Tab2 = TabBox:AddTab('Tab 2')
```

# Toggle 

- You can now call AddToggle, etc on the tabs you added to the Tabbox

- Groupbox:AddToggle
- Arguments: Index, Options
```lua
LeftGroupBox:AddToggle('MyToggle', {
    Text = 'This is a toggle',
    Default = true, -- Default value (true / false)
    Tooltip = 'This is a tooltip', -- Information shown when you hover over the toggle

    Callback = function(Value)
        print('[cb] MyToggle changed to:', Value)
    end
})
```

- Fetching a toggle object for later use:
- Toggles.MyToggle.Value

- Toggles is a table added to getgenv() by the library
- You index Toggles with the specified index, in this case it is 'MyToggle'
- To get the state of the toggle you do toggle.Value

### Calls the passed function when the toggle is updated
```lua
Toggles.MyToggle:OnChanged(function()
    -- here we get our toggle object & then get its value
    print('MyToggle changed to:', Toggles.MyToggle.Value)
end)
```

### This should print to the console: "My toggle state changed! New value: false"
```lua
Toggles.MyToggle:SetValue(false)
```

# Button

- About Button
```lua
    Groupbox:AddButton
    Arguments: {
        Text = string,
        Func = function,
        DoubleClick = boolean
        Tooltip = string,
    }

    You can call :AddButton on a button to add a SubButton!
```

# Example
```lua
local MyButton = LeftGroupBox:AddButton({
    Text = 'Button',
    Func = function()
        print('You clicked a button!')
    end,
    DoubleClick = false,
    Tooltip = 'This is the main button'
})
```

```lua
local MyButton2 = MyButton:AddButton({
    Text = 'Sub button',
    Func = function()
        print('You clicked a sub button!')
    end,
    DoubleClick = true, -- You will have to click this button twice to trigger the callback
    Tooltip = 'This is the sub button (double click me!)'
})
```

### NOTE: You can chain the button methods!
- **EXAMPLE:**
```Lua
    LeftGroupBox:AddButton({ Text = 'Kill all', Func = Functions.KillAll, Tooltip = 'This will kill everyone in the game!' })
        :AddButton({ Text = 'Kick all', Func = Functions.KickAll, Tooltip = 'This will kick everyone in the game!' })
```

# Label

- Groupbox:AddLabel
- Arguments: Text, DoesWrap
```lua
LeftGroupBox:AddLabel('This is a label')
```
```lua
LeftGroupBox:AddLabel('This is a label\n\nwhich wraps its text!', true)
```
# Divider
- Groupbox:AddDivider
- Arguments: None
```lua
LeftGroupBox:AddDivider()
```

# Slider

- Groupbox:AddSlider
- Arguments: Idx, SliderOptions

```lua
SliderOptions: {
        Text = string,
        Default = number,
        Min = number,
        Max = number,
        Suffix = string,
        Rounding = number,
        Compact = boolean,
        HideMax = boolean,
    }
```
- Text, Default, Min, Max, Rounding must be specified.
- Suffix is optional.
- Rounding is the number of decimal places for precision.

- Compact will hide the title label of the Slider

- HideMax will only display the value instead of the value & max value of the slider
- Compact will do the same thing

### Example
```lua
LeftGroupBox:AddSlider('MySlider', {
    Text = 'This is my slider!',
    Default = 0,
    Min = 0,
    Max = 5,
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        print('[cb] MySlider was changed! New value:', Value)
    end
})
```

- Options is a table added to getgenv() by the library
- You index Options with the specified index, in this case it is 'MySlider'
- To get the value of the slider you do slider.Value
```lua
local Number = Options.MySlider.Value
Options.MySlider:OnChanged(function()
    print('MySlider was changed! New value:', Options.MySlider.Value)
end)
```

- This should print to the console: "MySlider was changed! New value: 3"
```lua
Options.MySlider:SetValue(3)
```

# TextBox (Input)

- Groupbox:AddInput
- Arguments: Idx, Info

### Example
```lua
LeftGroupBox:AddInput('MyTextbox', {
    Default = 'My textbox!',
    Numeric = false, -- true / false, only allows numbers
    Finished = false, -- true / false, only calls callback when you press enter

    Text = 'This is a textbox',
    Tooltip = 'This is a tooltip', -- Information shown when you hover over the textbox

    Placeholder = 'Placeholder text', -- placeholder text when the box is empty
    -- MaxLength is also an option which is the max length of the text

    Callback = function(Value)
        print('[cb] Text updated. New text:', Value)
    end
})
```
```lua
Options.MyTextbox:OnChanged(function()
    print('Text updated. New text:', Options.MyTextbox.Value)
end)
```

# Dropdown

- Groupbox:AddDropdown
- Arguments: Idx, Info

# Example
```lua
LeftGroupBox:AddDropdown('MyDropdown', {
    Values = { 'This', 'is', 'a', 'dropdown' },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'A dropdown',
    Tooltip = 'This is a tooltip', -- Information shown when you hover over the dropdown

    Callback = function(Value)
        print('[cb] Dropdown got changed. New value:', Value)
    end
})
```

```lua
Options.MyDropdown:OnChanged(function()
    print('Dropdown got changed. New value:', Options.MyDropdown.Value)
end)
```
```lua
Options.MyDropdown:SetValue('This')
```

# Multi dropdowns

### Example
```lua
LeftGroupBox:AddDropdown('MyMultiDropdown', {
    -- Default is the numeric index (e.g. "This" would be 1 since it if first in the values list)
    -- Default also accepts a string as well

    -- Currently you can not set multiple values with a dropdown

    Values = { 'This', 'is', 'a', 'dropdown' },
    Default = 1,
    Multi = true, -- true / false, allows multiple choices to be selected

    Text = 'A dropdown',
    Tooltip = 'This is a tooltip', -- Information shown when you hover over the dropdown

    Callback = function(Value)
        print('[cb] Multi dropdown got changed:', Value)
    end
})
```
```lua
Options.MyMultiDropdown:OnChanged(function()
    -- print('Dropdown got changed. New value:', )
    print('Multi dropdown got changed:')
    for key, value in next, Options.MyMultiDropdown.Value do
        print(key, value) -- should print something like This, true
    end
end)
```

```lua
Options.MyMultiDropdown:SetValue({
    This = true,
    is = true,
})
```
# Players Dropdown
### Example
```lua
LeftGroupBox:AddDropdown('MyPlayerDropdown', {
    SpecialType = 'Player',
    Text = 'A player dropdown',
    Tooltip = 'This is a tooltip', -- Information shown when you hover over the dropdown

    Callback = function(Value)
        print('[cb] Player dropdown got changed:', Value)
    end
})
```

# Color Picker

- Label:AddColorPicker
- Arguments: Idx, Info

- You can also ColorPicker & KeyPicker to a Toggle as well

### Example
```lua
LeftGroupBox:AddLabel('Color'):AddColorPicker('ColorPicker', {
    Default = Color3.new(0, 1, 0), -- Bright green
    Title = 'Some color', -- Optional. Allows you to have a custom color picker title (when you open it)
    Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

    Callback = function(Value)
        print('[cb] Color changed!', Value)
    end
})
```
```lua
Options.ColorPicker:OnChanged(function()
    print('Color changed!', Options.ColorPicker.Value)
    print('Transparency changed!', Options.ColorPicker.Transparency)
end)
```
```lua
Options.ColorPicker:SetValueRGB(Color3.fromRGB(0, 255, 140))
```

# KeyPicker

- Label:AddKeyPicker
- Arguments: Idx, Info

```lua
LeftGroupBox:AddLabel('Keybind'):AddKeyPicker('KeyPicker', {
    -- SyncToggleState only works with toggles.
    -- It allows you to make a keybind which has its state synced with its parent toggle

    -- Example: Keybind which you use to toggle flyhack, etc.
    -- Changing the toggle disables the keybind state and toggling the keybind switches the toggle state

    Default = 'MB2', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
    SyncToggleState = false,


    -- You can define custom Modes but I have never had a use for it.
    Mode = 'Toggle', -- Modes: Always, Toggle, Hold

    Text = 'Auto lockpick safes', -- Text to display in the keybind menu
    NoUI = false, -- Set to true if you want to hide from the Keybind menu,

    -- Occurs when the keybind is clicked, Value is `true`/`false`
    Callback = function(Value)
        print('[cb] Keybind clicked!', Value)
    end,

    -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
    ChangedCallback = function(New)
        print('[cb] Keybind changed!', New)
    end
})
```


- OnClick is only fired when you press the keybind and the mode is Toggle
- Otherwise, you will have to use Keybind:GetState()
```lua
Options.KeyPicker:OnClick(function()
    print('Keybind clicked!', Options.KeyPicker:GetState())
end)
```
``` lua
Options.KeyPicker:OnChanged(function()
    print('Keybind changed!', Options.KeyPicker.Value)
end)
```

```lua
task.spawn(function()
    while true do
        wait(1)

        -- example for checking if a keybind is being pressed
        local state = Options.KeyPicker:GetState()
        if state then
            print('KeyPicker is being held down')
        end

        if Library.Unloaded then break end
    end
end)

Options.KeyPicker:SetValue({ 'MB2', 'Toggle' }) -- Sets keybind to MB2, mode to Hold
```

# Keybind Instant
- Toggle Keybind for Mobile 
```lua
:AddKeyPicker("keybind", {
    Default = "Z",
    Text = "Keybind Toggle",
    Mode = Library.IsMobile and "Toggle",
    SyncToggleState = Library.IsMobile,
})
```
- Button Keybind For Mobile
```lua
:AddKeyPicker("Keybind", {
    Default = "Y",
    Text = "Keybind",
    Mode = Library.IsMobile and "Button",
    SyncToggleState = Library.IsMobile,
})
```

# TextLabel Pro

- Long text label to demonstrate UI scrolling behaviour.
```lua
local LeftGroupBox2 = Tabs.Main:AddLeftGroupbox('Groupbox #2');
```
```lua
LeftGroupBox2:AddLabel('Oh no...\nThis label spans multiple lines!\n\nWe\'re gonna run out of UI space...\nJust kidding! Scroll down!\n\n\nHello from below!', true)
```

# Toggle Pro

```lua
local TabBox = Tabs.Main:AddRightTabbox() -- Add Tabbox on right side
```

- Anything we can do in a Groupbox, we can do in a Tabbox tab (AddToggle, AddSlider, AddLabel, etc etc...)
```lua
local Tab1 = TabBox:AddTab('Tab 1')
Tab1:AddToggle('Tab1Toggle', { Text = 'Tab1 Toggle' });
```
```lua
local Tab2 = TabBox:AddTab('Tab 2')
Tab2:AddToggle('Tab2Toggle', { Text = 'Tab2 Toggle' });
```

- Dependency boxes let us control the visibility of UI elements depending on another UI elements state.
- e.g. we have a 'Feature Enabled' toggle, and we only want to show that features sliders, dropdowns etc when it's enabled!
- Dependency box example:
```lua
local RightGroupbox = Tabs.Main:AddRightGroupbox('Groupbox #3');
RightGroupbox:AddToggle('ControlToggle', { Text = 'Dependency box toggle' });
```
```lua
local Depbox = RightGroupbox:AddDependencyBox();
Depbox:AddToggle('DepboxToggle', { Text = 'Sub-dependency box toggle' });
```

# DepBox

- We can also nest dependency boxes!
- When we do this, our SupDepbox automatically relies on the visiblity of the Depbox - on top of whatever additional dependencies we set
### Example
```lua
local SubDepbox = Depbox:AddDependencyBox();
SubDepbox:AddSlider('DepboxSlider', { Text = 'Slider', Default = 50, Min = 0, Max = 100, Rounding = 0 });
SubDepbox:AddDropdown('DepboxDropdown', { Text = 'Dropdown', Default = 1, Values = {'a', 'b', 'c'} });
```
```lua
Depbox:SetupDependencies({
    { Toggles.ControlToggle, true } -- We can also pass `false` if we only want our features to show when the toggle is off!
});
```
```lua
SubDepbox:SetupDependencies({
    { Toggles.DepboxToggle, true }
});
```
# WaterMark
- Library functions
- Sets the watermark visibility
```lua
Library:SetWatermarkVisibility(true)
```

- Example of dynamically-updating watermark with common traits (fps and ping)
### Example
```lua
local FrameTimer = tick()
local FrameCounter = 0;
local FPS = 60;

local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
    FrameCounter += 1;

    if (tick() - FrameTimer) >= 1 then
        FPS = FrameCounter;
        FrameTimer = tick();
        FrameCounter = 0;
    end;

    Library:SetWatermark(('LinoriaLib demo | %s fps | %s ms'):format(
        math.floor(FPS),
        math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
    ));
end);
```

# Library Settings
```lua
Library.KeybindFrame.Visible = true; -- todo: add a function for this
```
## Unload
- Have WatermarkConnection:Disconnect()
- Only Work If Have Watermark
```lua
Library:OnUnload(function()
    WatermarkConnection:Disconnect()

    print('Unloaded!')
    Library.Unloaded = true
end)
```
- No Have WatermarkConnection:Disconnect()
- 100% Work
```lua
Library:OnUnload(function()
    WatermarkConnection:Disconnect()

    print('Unloaded!')
    Library.Unloaded = true
end)
```

- UI Settings
```lua
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')
```

- I set NoUI so it does not show up in the keybinds menu
```lua
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })
```
```lua
Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu
```
## Addons:
- SaveManager (Allows you to have a configuration system)
- ThemeManager (Allows you to have a menu theme system)

- Hand the library over to our managers
```lua
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
```

- Ignore keys that are used by ThemeManager.
- (we dont want configs to save themes, do we?)
```lua
SaveManager:IgnoreThemeSettings()
```

- Adds our MenuKeybind to the ignore list
- (do you want each config to have a different menu key? probably not.)
```lua
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
```

- use case for doing it this way:
- a script hub could have themes in a global folder
- and game configs in a separate folder per game
```lua
ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')
```

- Builds our config menu on the right side of our tab
```lua
SaveManager:BuildConfigSection(Tabs['UI Settings'])
```

- Builds our theme menu (with plenty of built in themes) on the left side
- NOTE: you can also call ThemeManager:ApplyToGroupbox to add it to a specific groupbox
```lua
ThemeManager:ApplyToTab(Tabs['UI Settings'])
```

- You can use the SaveManager:LoadAutoloadConfig() to load a config
- which has been marked to be one that auto loads!
```lua
SaveManager:LoadAutoloadConfig()
```
## if You no Want copy slowly
- Here 
```lua
Library:OnUnload(function()
    WatermarkConnection:Disconnect()

    print('Unloaded!')
    Library.Unloaded = true
end)
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })
Library.ToggleKeybind = Options.MenuKeybind
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')
SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])
SaveManager:LoadAutoloadConfig()
```
