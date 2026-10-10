--[[
    █████╗ ██╗     ███████╗██╗  ██╗   ██╗   ██╗██╗
    ██╔══██╗██║     ██╔════╝╚██╗██╔╝   ██║   ██║██║
    ███████║██║     █████╗   ╚███╔╝    ██║   ██║██║
    ██╔══██║██║     ██╔══╝   ██╔██╗    ██║   ██║██║
    ██║  ██║███████╗███████╗██╔╝ ██╗   ╚██████╔╝██║
    ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝    ╚═════╝ ╚═╝

    Alex-UI — Example Script
    Author: Alex (alexgamingofficial2026-del)
    Version: 1.0

    This script demonstrates every component available in Alex-UI.
    Run it in Delta Executor (or any compatible executor) to preview the UI.
]]

-- ============================================
-- 1. LOAD THE LIBRARY
-- ============================================
local AlexUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/alexgamingofficial2026-del/Alex-UI/main/Alex-UI.lua"
))()

-- Services
local Players          = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Lighting         = game:GetService("Lighting")
local LocalPlayer      = Players.LocalPlayer

-- ============================================
-- 2. CREATE THE MAIN WINDOW
-- ============================================
local Window = AlexUI:CreateWindow({
    Name      = "Alex-UI Demo",
    Subtitle  = "v1.0 by Alex",
    ToggleKey = Enum.KeyCode.RightShift
})

-- ============================================
-- 3. CREATE TABS
-- ============================================
local MainTab     = Window:CreateTab("Main")
local VisualTab   = Window:CreateTab("Visuals")
local SettingsTab = Window:CreateTab("Settings")

-- ============================================
-- MAIN TAB
-- ============================================
MainTab:CreateSection("MOVEMENT")

-- Speed slider
MainTab:CreateSlider({
    Name     = "Walk Speed",
    Min      = 16,
    Max      = 300,
    Default  = 16,
    Flag     = "WalkSpeed",
    Callback = function(value)
        local char = LocalPlayer.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char.Humanoid.WalkSpeed = value
        end
    end
})

-- Jump slider
MainTab:CreateSlider({
    Name     = "Jump Power",
    Min      = 50,
    Max      = 500,
    Default  = 50,
    Flag     = "JumpPower",
    Callback = function(value)
        local char = LocalPlayer.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char.Humanoid.UseJumpPower = true
            char.Humanoid.JumpPower = value
        end
    end
})

-- Infinite Jump toggle
local infJumpConn = nil
MainTab:CreateToggle({
    Name     = "Infinite Jump",
    Default  = false,
    Flag     = "InfiniteJump",
    Callback = function(state)
        if state then
            infJumpConn = UserInputService.JumpRequest:Connect(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChildOfClass("Humanoid") then
                    char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        else
            if infJumpConn then
                infJumpConn:Disconnect()
                infJumpConn = nil
            end
        end
    end
})

-- Noclip toggle
local noclipConn = nil
MainTab:CreateToggle({
    Name     = "Noclip",
    Default  = false,
    Flag     = "Noclip",
    Callback = function(state)
        if state then
            noclipConn = game:GetService("RunService").Stepped:Connect(function()
                local char = LocalPlayer.Character
                if char then
                    for _, part in ipairs(char:GetDescendants()) do
                        if part:IsA("BasePart") and part.CanCollide then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            if noclipConn then
                noclipConn:Disconnect()
                noclipConn = nil
            end
        end
    end
})

MainTab:CreateSection("ACTIONS")

-- Reset button
MainTab:CreateButton({
    Name     = "Respawn",
    Callback = function()
        local char = LocalPlayer.Character
        if char then
            char:BreakJoints()
        end
    end
})

-- Test notification
MainTab:CreateButton({
    Name     = "Test Notification",
    Callback = function()
        AlexUI:Notify({
            Title    = "Alex-UI",
            Text     = "Everything is working! ✅",
            Duration = 4
        })
    end
})

-- ============================================
-- VISUALS TAB
-- ============================================
VisualTab:CreateSection("INTERFACE")

-- Theme dropdown
VisualTab:CreateDropdown({
    Name     = "Accent Color",
    Options  = { "Purple", "Blue", "Red", "Green", "Orange" },
    Default  = "Purple",
    Flag     = "AccentColor",
    Callback = function(option)
        local themes = {
            Purple = Color3.fromRGB(138, 43, 226),
            Blue   = Color3.fromRGB(0, 120, 255),
            Red    = Color3.fromRGB(220, 60, 60),
            Green  = Color3.fromRGB(60, 200, 120),
            Orange = Color3.fromRGB(255, 140, 0),
        }
        if themes[option] then
            AlexUI.Theme.Accent = themes[option]
        end
    end
})

VisualTab:CreateSection("LIGHTING")

-- Fullbright toggle
VisualTab:CreateToggle({
    Name     = "Fullbright",
    Default  = false,
    Flag     = "Fullbright",
    Callback = function(state)
        if state then
            Lighting.Ambient    = Color3.fromRGB(255, 255, 255)
            Lighting.Brightness = 3
        else
            Lighting.Ambient    = Color3.fromRGB(70, 70, 70)
            Lighting.Brightness = 1
        end
    end
})

-- Clock time slider
VisualTab:CreateSlider({
    Name     = "Time of Day",
    Min      = 0,
    Max      = 24,
    Default  = 14,
    Flag     = "TimeOfDay",
    Callback = function(value)
        Lighting.ClockTime = value
    end
})

-- Fog toggle
VisualTab:CreateToggle({
    Name     = "Remove Fog",
    Default  = false,
    Flag     = "NoFog",
    Callback = function(state)
        if state then
            Lighting.FogEnd   = 100000
            Lighting.FogStart = 100000
        else
            Lighting.FogEnd   = 1000
            Lighting.FogStart = 0
        end
    end
})

-- ============================================
-- SETTINGS TAB
-- ============================================
SettingsTab:CreateSection("KEYBINDS")

-- Keybind example
SettingsTab:CreateKeybind({
    Name     = "Quick Notification",
    Default  = Enum.KeyCode.F,
    Flag     = "NotifyKey",
    Callback = function()
        AlexUI:Notify({
            Title = "Keybind",
            Text  = "You pressed the quick key!"
        })
    end
})

SettingsTab:CreateSection("CONFIGURATION")

-- TextBox example
SettingsTab:CreateTextBox({
    Name        = "Notes",
    Placeholder = "Type anything here...",
    Default     = "",
    Callback    = function(text)
        print("[Alex-UI] Notes:", text)
    end
})

-- Save / Load buttons
SettingsTab:CreateButton({
    Name     = "Save Config",
    Callback = function()
        Window:SaveConfig("alexui_config.json")
    end
})

SettingsTab:CreateButton({
    Name     = "Load Config",
    Callback = function()
        Window:LoadConfig("alexui_config.json")
    end
})

SettingsTab:CreateSection("DANGER ZONE")

-- Destroy UI button
SettingsTab:CreateButton({
    Name     = "Unload Alex-UI",
    Callback = function()
        AlexUI:Notify({
            Title    = "Alex-UI",
            Text     = "Unloading in 2 seconds...",
            Duration = 2
        })
        task.wait(2)
        AlexUI:Destroy()
    end
})

-- ============================================
-- 4. WELCOME NOTIFICATION
-- ============================================
AlexUI:Notify({
    Title    = "Alex-UI",
    Text     = "Loaded successfully! Press RightShift to toggle.",
    Duration = 5
})

-- ============================================
-- END OF EXAMPLE
-- ============================================
