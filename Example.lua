-- 1. Cargar la librería
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/alexgamingofficial2026-del/Apex-UI/main/Source.lua"))()

-- 2. Crear la ventana
local Window = Library:CreateWindow("Mi Script")

-- 3. Crear una pestaña
local Tab = Window:CreateTab("Principal")

-- 4. Crear una sección
local Section = Tab:CreateSection("Movimiento")

-- 5. Añadir elementos
Section:CreateButton("Mi Botón", function()
    print("¡Botón pulsado!")
end)

Section:CreateToggle("Mi Toggle", false, function(state)
    print("Estado:", state)
end)

Section:CreateSlider("Velocidad", 16, 300, 16, function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

Section:CreateDropdown("Seleccionar", {"Opción 1", "Opción 2"}, "Opción 1", function(value)
    print("Seleccionaste:", value)
end)

-- 6. Notificación
Library:Notify("Mi Script", "Cargado correctamente", 3)
