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
    
```
local Window = Library:CreateWindow({
    Title = 'Example menu',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})
```

** CALLBACK NOTE: **
- Passing in callback functions via the initial element parameters (i.e. Callback = function(Value)...) works

- HOWEVER, using Toggles/Options.INDEX:OnChanged(function(Value) ... ) is the RECOMMENDED way to do this.

- I strongly recommend decoupling UI code from logic code. i.e. Create your UI elements FIRST, and THEN setup :OnChanged functions later.

- You do not have to set your tabs & groups up this way, just a prefrence.

# Tabs

- Creates a new tab titled Main

```lua
local Tabs = {
    Main = Window:AddTab('Main'),
    ['UI Settings'] = Window:AddTab('UI Settings'),l
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
local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Groupbox')
```

- We can also get our Main tab via the following code:
```lua
local LeftGroupBox = Window.Tabs.Main:AddLeftGroupbox('Groupbox')
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
