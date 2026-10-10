-- ============================================================
-- ALEX UI - Ejemplo de uso completo
-- Creador: AlexOfficial
-- ============================================================

-- 1. Cargar la librería
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/alexgamingofficial2026-del/Apex-UI/main/Source.lua"))()

-- 2. Crear la ventana principal
local Window = Library:CreateWindow("ALEX UI - Ejemplo")

-- 3. Crear pestañas
local MainTab = Window:CreateTab("Principal")
local VisualTab = Window:CreateTab("Visuales")
local PlayerTab = Window:CreateTab("Jugadores")
local TpTab = Window:CreateTab("Teleport")
local SettingsTab = Window:CreateTab("Ajustes")

-- ============================================================
-- PESTAÑA PRINCIPAL
-- ============================================================
local MoveSection = MainTab:CreateSection("Movimiento")

MoveSection:CreateSlider("Velocidad", 16, 300, 16, function(value)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").WalkSpeed = value
    end
end)

MoveSection:CreateSlider("Salto", 50, 500, 50, function(value)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").JumpPower = value
    end
end)

MoveSection:CreateToggle("Salto Infinito", false, function(state)
    if state then
        local UIS = game:GetService("UserInputService")
        _G.InfConn = UIS.JumpRequest:Connect(function()
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChildOfClass("Humanoid") then
                char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    else
        if _G.InfConn then _G.InfConn:Disconnect() end
    end
end)

MoveSection:CreateToggle("Noclip", false, function(state)
    if state then
        _G.NoclipConn = game:GetService("RunService").Stepped:Connect(function()
            local char = game.Players.LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    else
        if _G.NoclipConn then _G.NoclipConn:Disconnect() end
    end
end)

MoveSection:CreateButton("Restablecer Movimiento", function()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
        char:FindFirstChildOfClass("Humanoid").JumpPower = 50
    end
    Library:Notify("ALEX UI", "Movimiento restablecido", 3)
end)

local FlySection = MainTab:CreateSection("Vuelo")

FlySection:CreateToggle("Fly", false, function(state)
    _G.FlyEnabled = state
    local char = game.Players.LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if state then
        local bv = Instance.new("BodyVelocity")
        bv.Name = "ALEX_Fly"
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Velocity = Vector3.zero
        bv.Parent = hrp

        _G.FlyConn = game:GetService("RunService").RenderStepped:Connect(function()
            if not _G.FlyEnabled then return end
            local moveDir = Vector3.zero
            local camera = workspace.CurrentCamera
            local UIS = game:GetService("UserInputService")
            if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + camera.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - camera.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - camera.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + camera.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end
            bv.Velocity = moveDir.Magnitude > 0 and moveDir * (_G.FlySpeed or 50) or Vector3.zero
        end)
    else
        if _G.FlyConn then _G.FlyConn:Disconnect() end
        local bv = hrp:FindFirstChild("ALEX_Fly")
        if bv then bv:Destroy() end
    end
end)

FlySection:CreateSlider("Velocidad de Fly", 10, 200, 50, function(value)
    _G.FlySpeed = value
end)

-- ============================================================
-- PESTAÑA VISUALES
-- ============================================================
local EspSection = VisualTab:CreateSection("ESP")

local espHighlights = {}

EspSection:CreateToggle("ESP Jugadores", false, function(state)
    if state then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player.Character then
                local hl = Instance.new("Highlight")
                hl.Name = "ALEX_ESP"
                hl.FillColor = Color3.fromRGB(155, 92, 246)
                hl.OutlineColor = Color3.new(1, 1, 1)
                hl.FillTransparency = 0.5
                hl.OutlineTransparency = 0
                hl.Parent = player.Character
                table.insert(espHighlights, hl)
            end
        end
    else
        for _, h in pairs(espHighlights) do
            if h and h.Parent then h:Destroy() end
        end
        espHighlights = {}
    end
end)

EspSection:CreateColorpicker("Color del ESP", Color3.fromRGB(155, 92, 246), function(color)
    for _, h in pairs(espHighlights) do
        if h and h.Parent then h.FillColor = color end
    end
end)

local LightSection = VisualTab:CreateSection("Iluminación")

LightSection:CreateToggle("Fullbright", false, function(state)
    local lighting = game:GetService("Lighting")
    if state then
        lighting.Brightness = 3
        lighting.Ambient = Color3.fromRGB(255, 255, 255)
    else
        lighting.Brightness = 1
        lighting.Ambient = Color3.fromRGB(0, 0, 0)
    end
end)

-- ============================================================
-- PESTAÑA JUGADORES
-- ============================================================
local PlayerListSection = PlayerTab:CreateSection("Jugadores en Servidor")

local playerNames = {}
for _, p in pairs(game.Players:GetPlayers()) do
    if p ~= game.Players.LocalPlayer then
        table.insert(playerNames, p.Name)
    end
end
if #playerNames == 0 then playerNames = {"Ninguno"} end

PlayerListSection:CreateDropdown("Seleccionar Jugador", playerNames, playerNames[1], function(value)
    _G.SelectedPlayer = value
    Library:Notify("ALEX UI", "Seleccionaste: " .. value, 3)
end)

local ActionSection = PlayerTab:CreateSection("Acciones")

ActionSection:CreateButton("Teletransportarse al Jugador", function()
    if not _G.SelectedPlayer then return end
    local target = game.Players:FindFirstChild(_G.SelectedPlayer)
    local myChar = game.Players.LocalPlayer.Character
    if target and target.Character and myChar and myChar:FindFirstChild("HumanoidRootPart") then
        myChar.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        Library:Notify("ALEX UI", "Teletransportado a " .. _G.SelectedPlayer, 3)
    end
end)

ActionSection:CreateButton("Traer Jugador a Mí", function()
    if not _G.SelectedPlayer then return end
    local target = game.Players:FindFirstChild(_G.SelectedPlayer)
    local myChar = game.Players.LocalPlayer.Character
    if target and target.Character and myChar and myChar:FindFirstChild("HumanoidRootPart") then
        target.Character.HumanoidRootPart.CFrame = myChar.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        Library:Notify("ALEX UI", "Trajiste a " .. _G.SelectedPlayer, 3)
    end
end)

local InventedSection = PlayerTab:CreateSection("Objetos Inventados")

local InventedItems = {
    "Poción de Velocidad Turbo",
    "Espada Láser Cuántica",
    "Escudo Anti-Gravedad",
    "Capa de Invisibilidad",
    "Botas de Salto Dimensional",
    "Guantes de Fuerza Titánica",
    "Casco de Visión Infrarroja",
    "Anillo de Teletransporte",
    "Amuleto de Vida Infinita",
    "Gafas de Rayos X"
}

InventedSection:CreateDropdown("Seleccionar Objeto", InventedItems, InventedItems[1], function(value)
    Library:Notify("ALEX UI", "¡Obtuviste: " .. value .. "!", 3)
end)

InventedSection:CreateButton("Obtener Objeto Aleatorio", function()
    local randomItem = InventedItems[math.random(1, #InventedItems)]
    Library:Notify("ALEX UI", "¡Obtuviste: " .. randomItem .. "!", 3)
end)

-- ============================================================
-- PESTAÑA TELEPORT
-- ============================================================
local TpSection = TpTab:CreateSection("Teletransporte Básico")

TpSection:CreateButton("Ir al Spawn", function()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local spawn = workspace:FindFirstChildOfClass("SpawnLocation")
        if spawn then
            char.HumanoidRootPart.CFrame = spawn.CFrame + Vector3.new(0, 3, 0)
            Library:Notify("ALEX UI", "Teletransportado al spawn", 3)
        end
    end
end)

TpSection:CreateButton("Subir 50 studs", function()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(0, 50, 0)
    end
end)

TpSection:CreateButton("Bajar 50 studs", function()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame - Vector3.new(0, 50, 0)
    end
end)

TpSection:CreateButton("Volver al Suelo", function()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(char.HumanoidRootPart.Position.X, 5, char.HumanoidRootPart.Position.Z)
    end
end)

-- ============================================================
-- PESTAÑA AJUSTES
-- ============================================================
local ThemeSection = SettingsTab:CreateSection("Temas")

ThemeSection:CreateDropdown("Seleccionar Tema", {"Default", "SpeedHub", "Midnight"}, "Default", function(theme)
    Library:SetTheme(theme)
    Library:Notify("ALEX UI", "Tema cambiado a: " .. theme, 3)
end)

local KeybindSection = SettingsTab:CreateSection("Atajos")

KeybindSection:CreateKeybind("Tecla de Prueba", "F", function(key)
    Library:Notify("ALEX UI", "Presionaste: " .. key.Name, 2)
end)

KeybindSection:CreateKeybind("Teletransporte Rápido", "T", function(key)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(0, 50, 0)
    end
end)

local TextSection = SettingsTab:CreateSection("Texto")

TextSection:CreateTextbox("Escribe algo", "Escribe aquí...", function(text)
    Library:Notify("ALEX UI", "Escribiste: " .. text, 3)
end)

local InfoSection = SettingsTab:CreateSection("Información")

InfoSection:CreateLabel("ALEX UI v1.0")
InfoSection:CreateLabel("Usando ALEX UI Library")
InfoSection:CreateLabel("Creado por AlexOfficial")

-- ============================================================
-- NOTIFICACIÓN DE CARGA
-- ============================================================
Library:Notify("ALEX UI", "¡Script cargado correctamente!", 5)
Library:Notify("ALEX UI", "Ejemplo completo funcionando", 5)

print("[ALEX UI] Ejemplo cargado correctamente")
