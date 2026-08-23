# 👁️ Advanced Roblox ESP Framework

[![Luau](https://img.shields.io/badge/Language-Luau-blue.svg)](https://luau-lang.org)
[![Roblox](https://img.shields.io/badge/Platform-Roblox-00A2FF.svg)](https://roblox.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

An optimized, feature-rich **ESP (Extra Sensory Perception)** library designed for Roblox executors. Offers high performance with low-level `Drawing` API support and automatic `CoreGui` fallbacks for universal compatibility.

---

## ✨ Features

- 🚀 **Dual Rendering Pipeline:** Full `Drawing` API support with seamless fallback to `CoreGui` instances (`BillboardGui`, `Highlight`, `Frame`).
- 🎯 **Target Tracking:** Track both `Player` entities and generic `Workspace` models/parts effortlessly.
- 🦴 **Full Skeleton & Healthbar:** Real-time character skeletal rendering and dynamic HP tracking.
- 🎨 **Granular Customization:** Advanced color mapping (`"All"`, multi-mode tables), custom distance origins, and RGB rainbow support.
- 🧹 **Automatic Cleanup:** Built-in garbage collection via `ESP:RemoveEsp()` and full disconnect on `ESP:Unload()`.

---

## ⚡ Quick Start

```lua
local ESP = loadstring(game:HttpGet("[https://raw.githubusercontent.com/YourUsername/Roblox-ESP-Framework/main/ESP.lua](https://raw.githubusercontent.com/YourUsername/Roblox-ESP-Framework/main/ESP.lua)"))()

-- 1. Enable Global Rules
ESP:Toggle(true)
ESP:SetBoxes(true)
ESP:SetTracers(true)
ESP:SetNames(true)
ESP:SetDistance(true)

-- 2. Start Player Tracking
ESP:AddEspPlayer()

📖 API Documentation
🛠️ Global Methods & Toggles
Calling toggle methods without parameters will automatically invert the current boolean state.
| Method | Parameters | Description |
|---|---|---|
| ESP:Toggle(state) | state (boolean) | Enable/disable the entire ESP system globally |
| ESP:SetBoxes(state) | state (boolean) | Toggle 2D bounding boxes |
| ESP:SetTracers(state) | state (boolean) | Toggle snaplines / tracers |
| ESP:SetNames(state) | state (boolean) | Toggle target display names |
| ESP:SetDistance(state) | state (boolean) | Toggle distance meters ([100m]) |
| ESP:SetHighlight(state) | state (boolean) | Toggle 3D highlight fill and outline |
| ESP:SetSkeletons(state) | state (boolean) | Toggle character skeletal structure |
| ESP:SetHealthbar(state) | state (boolean) | Toggle character health bars |
| ESP:SetRainbow(state) | state (boolean) | Toggle dynamic RGB rainbow mode |
⚙️ System Configuration
ESP:SetTracerOrigin(mode)     -- "Bottom" | "Top" | "Center" | "Mouse"
ESP:SetRainbowSpeed(speed)    -- Speed factor for dynamic RGB cycling (number)
ESP:SetDelayEsp(delay)        -- Render delay interval in seconds (improves FPS)
ESP:SetTweenTime(time)        -- Smooth fade-in/out transition duration
ESP:SetBoxTransparent(tbl)    -- Set box opacity: {Outline = 1, Fill = 0.5} or {1, 0.5}

🎯 Target Management
ESP:AddESP(target, [name], [color])
Registers a BasePart or Model instance into the tracking loop.
local chest = workspace:FindFirstChild("Chest")

-- Track with default configurations
ESP:AddESP(chest)

-- Track with custom display name and theme color
ESP:AddESP(chest, "Golden Chest", Color3.fromRGB(255, 215, 0))

ESP:AddEspPlayer([config])
Enables automated tracking for all current and future joining players.
ESP:AddEspPlayer({
    Team = false,             -- Set to true to filter out teammates
    TeamColor = false,        -- Inherit player team colors if available
    Color = Color3.fromRGB(255, 255, 255)
})

ESP:RemoveEsp(target)
Destroys all associated UI elements and removes the target from tracking.
ESP:RemoveEsp(workspace.Chest)

ESP:Unload()
Disconnects all active connections, purges memory caches, and destroys rendering folders.
ESP:Unload()

🎨 Dynamic Modifiers
ESP:SetText(Object, Text, [Color])
Updates label properties dynamically. Supports flexible parameter formats.
-- Standard syntax (Text only)
ESP:SetText(workspace.Chest, "Unlocked Chest")

-- Standard syntax (Text + Color3)
ESP:SetText(workspace.Chest, "Unlocked Chest", Color3.fromRGB(0, 255, 120))

-- Single array syntax
ESP:SetText({workspace.Chest, "Unlocked Chest", Color3.fromRGB(0, 255, 120)})

ESP:SetColor(Object, Mode, Color3)
Modifies visual element colors based on targeted modes.
-- Apply color across ALL visual components
ESP:SetColor(target, "All", Color3.fromRGB(255, 0, 0))

-- Apply color to SPECIFIC components using an array table
ESP:SetColor(target, {"Tracer", "Boxes", "Text"}, Color3.fromRGB(255, 255, 0))

-- Apply color to a SINGLE component
ESP:SetColor(target, "Highlight", Color3.fromRGB(0, 150, 255))

> Valid Mode Keywords: "All", "Text", "Boxes" ("Box"), "Tracer" ("Tracers", "Line"), "Highlight", "Skeleton" ("Skeletons").
> 
💡 Practical Integration Example
local ESP = require(path.to.ESP)

-- Global Setup
ESP:SetBoxes(true)
ESP:SetTracers(true)
ESP:SetTracerOrigin("Bottom")
ESP.MaxDistance = 1500

-- Track Server Players
ESP:AddEspPlayer({ Team = false })

-- Dynamic Boss Instance Handling
local boss = workspace:WaitForChild("WorldBoss")
ESP:AddESP(boss, "Phase 1: Guardian", Color3.fromRGB(255, 200, 0))

-- Simulate Event Trigger Update
task.delay(10, function()
    if boss and boss.Parent then
        -- Update text and switch all visual modes to red
        ESP:SetText(boss, "Phase 2: Enraged Guardian")
        ESP:SetColor(boss, "All", Color3.fromRGB(255, 0, 50))
    end
end)

📜 License
Distributed under the MIT License. See LICENSE for details.

<ElicitationsGroup message="Next steps for your repository setup:">
  <Elicitation label="Generate MIT License file text" query="Generate a standard MIT License file text for a Roblox ESP repository."/>
  <Elicitation label="Create a Luau module file setup" query="Provide the modular Luau setup showing how to package this ESP script into a clean ModuleScript structure."/>
</ElicitationsGroup>
