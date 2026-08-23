✦ ESP Library

«A lightweight and customizable ESP library for Roblox.»

<p align="center">Boxes • Tracers • Names • Distance • Skeletons • Healthbars • Highlights • Rainbow

</p>---

✧ Features

- 🎯 Player ESP
- 📦 Object ESP
- ◈ Box ESP
- ─ Tracers
- ♡ Healthbars
- ✦ Skeleton ESP
- ✧ Highlight ESP
- 🏷️ Name ESP
- 📏 Distance ESP
- 🌈 Rainbow mode
- 👥 Team checking
- 🎨 Custom colors
- 🖱️ Mouse tracer origin
- ⚡ Tween / fade animation
- 📦 Drawing API support
- 🖥️ UI fallback when Drawing is unavailable
- 🧹 Automatic cleanup

---

◈ Installation

Place the source inside a Roblox "ModuleScript".

local ESP = require(path.to.ESP)

The module returns the "ESP" object.

---

✦ Quick Start

local ESP = require(path.to.ESP)

ESP.Enabled = true

ESP.Boxes = true
ESP.Tracers = true
ESP.Names = true
ESP.ShowDistance = true

ESP.Highlight = false
ESP.Skeletons = false
ESP.Healthbar = true

ESP.MaxDistance = 2000

ESP.BoxColor = Color3.fromRGB(255, 0, 0)
ESP.TracerColor = Color3.fromRGB(255, 0, 0)
ESP.TextColor = Color3.fromRGB(255, 255, 255)

ESP:SetTracerOrigin("Bottom")
ESP:SetTweenTime(0.3)

ESP:AddEspPlayer()

---

◇ API Reference

Core

Function| Type| Parameters| Description| Returns
"ESP:Toggle()"| "Function"| "Boolean?"| Toggle the entire ESP system| "nil"
"ESP:Unload()"| "Function"| "None"| Completely destroy the ESP system| "nil"

Example

ESP:Toggle(true)

ESP:Toggle(false)

ESP:Toggle()

---

◇ Feature Controls

Function| Type| Parameters| Description| Returns
"ESP:SetTracers()"| "Function"| "Boolean?"| Enable or disable tracers| "nil"
"ESP:SetBoxes()"| "Function"| "Boolean?"| Enable or disable boxes| "nil"
"ESP:SetHighlight()"| "Function"| "Boolean?"| Enable or disable highlights| "nil"
"ESP:SetNames()"| "Function"| "Boolean?"| Enable or disable names| "nil"
"ESP:SetDistance()"| "Function"| "Boolean?"| Enable or disable distance text| "nil"
"ESP:SetSkeletons()"| "Function"| "Boolean?"| Enable or disable skeletons| "nil"
"ESP:SetHealthbar()"| "Function"| "Boolean?"| Enable or disable healthbars| "nil"
"ESP:SetRainbow()"| "Function"| "Boolean?"| Enable or disable rainbow mode| "nil"

Example

ESP:SetBoxes(true)
ESP:SetTracers(true)
ESP:SetNames(true)
ESP:SetDistance(true)

ESP:SetSkeletons(false)
ESP:SetHealthbar(false)
ESP:SetHighlight(false)

---

◇ Object ESP

Function| Type| Parameters| Description| Returns
"ESP:AddESP()"| "Function"| "Instance, String?, Color3?"| Add ESP to an object| "ESPObject"
"ESP:SetText()"| "Function"| "Instance, String?, Color3?"| Change object ESP text| "ESPObject"
"ESP:SetColor()"| "Function"| "Instance, Mode, Color3"| Change ESP colors| "ESPObject"
"ESP:RemoveEsp()"| "Function"| "Instance"| Remove ESP from an object| "nil"

Add Object

ESP:AddESP(workspace.SomePart)

Add Object With Name

ESP:AddESP(
    workspace.SomePart,
    "Target"
)

Add Object With Name And Color

ESP:AddESP(
    workspace.SomePart,
    "Target",
    Color3.fromRGB(255, 0, 0)
)

---

◇ Player ESP

Function| Type| Parameters| Description| Returns
"ESP:AddEspPlayer()"| "Function"| "Table?"| Enable/configure player ESP| "nil"
"ESP:CheckTeam()"| "Function"| "Player"| Check player team filtering| "Boolean"

Enable Player ESP

ESP:AddEspPlayer()

Player Configuration

ESP.PlayerConfig.Team = true
ESP.PlayerConfig.TeamColor = true
ESP.PlayerConfig.Distance = true

---

◇ Text

Function| Type| Parameters| Description| Returns
"ESP:SetText()"| "Function"| "Instance, String?, Color3?"| Set custom ESP text| "ESPObject"

Text Only

ESP:SetText(
    Object,
    "Enemy"
)

Text + Color

ESP:SetText(
    Object,
    "Enemy",
    Color3.fromRGB(255, 0, 0)
)

---

◇ Colors

Function| Type| Parameters| Description| Returns
"ESP:SetColor()"| "Function"| "Instance, String/Table, Color3"| Set one or multiple ESP colors| "ESPObject"

Supported Modes

Mode| Affects
"All"| Everything
"Text"| Text
"Boxes"| Box
"Box"| Box
"Tracer"| Tracer
"Tracers"| Tracer
"Highlight"| Highlight
"Skeleton"| Skeleton
"Skeletons"| Skeleton
"Line"| Tracer

All

ESP:SetColor(
    Object,
    "All",
    Color3.fromRGB(255, 0, 0)
)

One Component

ESP:SetColor(
    Object,
    "Boxes",
    Color3.fromRGB(255, 0, 0)
)

Multiple Components

ESP:SetColor(
    Object,
    {"Text", "Boxes", "Tracer"},
    Color3.fromRGB(255, 255, 0)
)

---

◇ Animation

Function| Type| Parameters| Description| Returns
"ESP:SetTweenTime()"| "Function"| "Number"| Set ESP fade animation duration| "nil"
"ESP:SetDelayEsp()"| "Function"| "Number"| Set render delay| "nil"

Tween

ESP:SetTweenTime(0.3)

Render Delay

ESP:SetDelayEsp(0)

---

◇ Rainbow

Function| Type| Parameters| Description| Returns
"ESP:SetRainbow()"| "Function"| "Boolean?"| Enable/disable rainbow mode| "nil"
"ESP:SetRainbowSpeed()"| "Function"| "Number"| Set rainbow animation speed| "nil"

Example

ESP:SetRainbow(true)
ESP:SetRainbowSpeed(2)

Disable:

ESP:SetRainbow(false)

---

◇ Tracer

Function| Type| Parameters| Description| Returns
"ESP:SetTracerOrigin()"| "Function"| "String"| Change tracer starting position| "nil"

Available Origins

Origin| Description
"Top"| Top-center of screen
"Center"| Center of screen
"Mouse"| Mouse position
"Bottom"| Bottom-center of screen

Example

ESP:SetTracerOrigin("Bottom")

ESP:SetTracerOrigin("Mouse")

---

◇ Transparency

Function| Type| Parameters| Description| Returns
"ESP:SetBoxTransparent()"| "Function"| "Table"| Configure box transparency| "nil"

Named Configuration

ESP:SetBoxTransparent({
    Outline = 1,
    Fill = 0.5
})

Array Configuration

ESP:SetBoxTransparent({
    1,
    0.5
})

---

◇ Configuration

General

Property| Type| Default| Description
"Enabled"| "Boolean"| "true"| Master ESP state
"MaxDistance"| "Number"| "2000"| Maximum render distance
"TweenTime"| "Number"| "0.3"| Fade animation duration
"RenderDelay"| "Number"| "0"| Render delay

---

Features

Property| Type| Default| Description
"Boxes"| "Boolean"| "true"| Display boxes
"Tracers"| "Boolean"| "true"| Display tracers
"Names"| "Boolean"| "true"| Display names
"ShowDistance"| "Boolean"| "true"| Display distance
"Highlight"| "Boolean"| "false"| Display highlights
"Skeletons"| "Boolean"| "false"| Display skeletons
"Healthbar"| "Boolean"| "false"| Display healthbars
"Rainbow"| "Boolean"| "false"| Enable rainbow colors

---

◇ Appearance

Property| Type| Default| Description
"TextSize"| "Number"| "16"| Text size
"TextOutline"| "Boolean"| "true"| Enable text outline
"BoxThickness"| "Number"| "2"| Box thickness
"TracerThickness"| "Number"| "2"| Tracer thickness
"SkeletonThickness"| "Number"| "1.5"| Skeleton thickness
"HealthbarThickness"| "Number"| "2"| Healthbar thickness
"Font"| "Number"| "2"| Drawing font

---

◇ Colors

Property| Type| Default| Description
"TextColor"| "Color3"| White| Text color
"BoxColor"| "Color3"| Red| Box color
"TracerColor"| "Color3"| Red| Tracer color
"HighlightColor"| "Color3"| Red| Highlight outline color
"FillColor"| "Color3"| Red| Highlight fill color
"SkeletonColor"| "Color3"| White| Skeleton color

---

◇ Player Configuration

Property| Type| Default| Description
"Team"| "Boolean"| "false"| Filter teammates
"TeamColor"| "Boolean"| "false"| Use player team color
"Distance"| "Boolean"| "true"| Enable player distance
"Name"| "Table"| —| Name configuration

---

◇ Transparency Configuration

ESP.Transparency = {
    Text = 1,
    Outline = 1,
    Fill = 0.5
}

Property| Type| Default| Description
"Text"| "Number"| "1"| Text transparency
"Outline"| "Number"| "1"| Outline transparency
"Fill"| "Number"| "0.5"| Fill transparency

---

◇ Type Reference

The API uses the following parameter types:

Type| Meaning
"Boolean"| "true" / "false"
"Boolean?"| Optional Boolean
"Number"| Numeric value
"String"| Text value
"String?"| Optional String
"Color3"| Roblox "Color3" value
"Color3?"| Optional "Color3"
"Instance"| Roblox Instance
"Player"| Roblox Player
"Table"| Lua table
"Table?"| Optional table
"Function"| Lua function
"None"| No parameters

---

◇ Full API Signature

ESP:Toggle(Boolean?)

ESP:SetTracers(Boolean?)
ESP:SetBoxes(Boolean?)
ESP:SetHighlight(Boolean?)
ESP:SetNames(Boolean?)
ESP:SetDistance(Boolean?)
ESP:SetSkeletons(Boolean?)
ESP:SetHealthbar(Boolean?)
ESP:SetRainbow(Boolean?)

ESP:SetRainbowSpeed(Number)
ESP:SetDelayEsp(Number)
ESP:SetTweenTime(Number)
ESP:SetTracerOrigin(String)
ESP:SetBoxTransparent(Table)

ESP:AddESP(Instance, String?, Color3?)
ESP:AddEspPlayer(Table?)

ESP:SetText(Instance, String?, Color3?)
ESP:SetColor(Instance, String/Table, Color3)

ESP:CheckTeam(Player)

ESP:RemoveEsp(Instance)
ESP:Unload()

---

◇ Complete Example

local ESP = require(path.to.ESP)

-- Core
ESP:Toggle(true)

-- Features
ESP:SetBoxes(true)
ESP:SetTracers(true)
ESP:SetNames(true)
ESP:SetDistance(true)

ESP:SetHighlight(false)
ESP:SetSkeletons(false)
ESP:SetHealthbar(true)

-- Appearance
ESP.TextSize = 16
ESP.BoxThickness = 2
ESP.TracerThickness = 2
ESP.SkeletonThickness = 1.5

-- Colors
ESP.TextColor = Color3.fromRGB(255, 255, 255)
ESP.BoxColor = Color3.fromRGB(255, 0, 0)
ESP.TracerColor = Color3.fromRGB(255, 0, 0)
ESP.HighlightColor = Color3.fromRGB(255, 0, 0)
ESP.SkeletonColor = Color3.fromRGB(255, 255, 255)

-- Distance
ESP.MaxDistance = 2000

-- Animation
ESP:SetTweenTime(0.3)
ESP:SetDelayEsp(0)

-- Tracer
ESP:SetTracerOrigin("Bottom")

-- Team
ESP.PlayerConfig.Team = true
ESP.PlayerConfig.TeamColor = false

-- Rainbow
ESP:SetRainbow(false)

-- Player ESP
ESP:AddEspPlayer()

---

◇ Cleanup

When you no longer need the ESP:

ESP:Unload()

This disconnects connections, removes cached objects, destroys ESP instances, and clears the internal caches.

---

⚠️ Source Fix

There is currently a typo in the source code.

Find:

elseif obj.BoxFrame meand

Replace it with:

elseif obj.BoxFrame then

The original line causes a Lua syntax error.

---

✦ License

Use, modify, and customize this project according to the license included with your repository.

---

<p align="center">ESP Library

Simple • Configurable • Lightweight

</p>