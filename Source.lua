-- ============================================================
-- ALEX UI v1.0 - Redz Hub Style
-- Creador: AlexOfficial
-- ============================================================

local ALEXUI = {}
ALEXUI.__index = ALEXUI

local UserInputService = game:GetService("UserInputService")

-- ============================================================
-- TEMA REDZ HUB
-- ============================================================
local Theme = {
    Background = Color3.fromRGB(15, 15, 20),
    Header = Color3.fromRGB(22, 22, 30),
    Accent = Color3.fromRGB(130, 80, 220),
    AccentDark = Color3.fromRGB(95, 55, 170),
    Text = Color3.fromRGB(255, 255, 255),
    SubText = Color3.fromRGB(160, 160, 175),
    Element = Color3.fromRGB(30, 30, 40),
    ElementHover = Color3.fromRGB(40, 40, 52),
    ToggleOff = Color3.fromRGB(55, 55, 68),
    Danger = Color3.fromRGB(220, 60, 60),
    Success = Color3.fromRGB(60, 200, 60),
    Stroke = Color3.fromRGB(60, 60, 75)
}

local function Create(class, props)
    local i = Instance.new(class)
    for k, v in pairs(props or {}) do i[k] = v end
    return i
end

-- ============================================================
-- VENTANA
-- ============================================================
function ALEXUI:CreateWindow(title)
    local self = setmetatable({}, ALEXUI)
    self.Tabs = {}
    self.CurrentTab = nil

    self.ScreenGui = Create("ScreenGui", {
        Name = "ALEXUI",
        ResetOnSpawn = false,
        DisplayOrder = 999999,
        IgnoreGuiInset = true,
        Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    })

    self.Main = Create("Frame", {
        Size = UDim2.new(0, 440, 0, 340),
        Position = UDim2.new(0.5, -220, 0.5, -170),
        BackgroundColor),
3 = Theme.Background,
               BorderSizePixel = 0,
 Background        Active = true,
Color        Parent = self.ScreenGui
   3 })
    Create("UICor =ner", { CornerRadius = UDim.new(0, 12), Parent = self.Main })
    Create("UIStroke", { Color = Theme.Stroke, Thickness = 1, Transparency = 0.3, Parent = self.Main })

    -- Barra de título
    local titleBar = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 36 Theme.Header,
        BorderSizePixel = 0,
        Parent = self.Main
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 12), Parent = titleBar })
    Create("Frame", {
        Size = UDim2.new(1, 0, 0, 10),
        Position = UDim2.new(0, 0, 1, -10),
        BackgroundColor3 = Theme.Header,
        BorderSizePixel = 0,
        Parent = titleBar
    })

    Create("Frame", {
        Size = UDim2.new(0, 3, 0, 22),
        Position = UDim2.new(0, 12, 0.5, -11),
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0,
        Parent = titleBar
    })

    Create("TextLabel", {
        Size = UDim2.new(1, -100, 1, 0),
        Position = UDim2.new(0, 24, 0, 0),
        BackgroundTransparency = 1,
        Text = title or "ALEX UI",
        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = titleBar
    })

    -- Botón minimizar
    local minBtn = Create("TextButton", {
        Size = UDim2.new(0, 24, 0, 24),
        Position = UDim2.new(1, -58, 0, 6),
        BackgroundColor3 = Color3.fromRGB(240, 180, 60),
        Text = "—",
        TextColor3 = Color3.new(1,1,1),
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        AutoButtonColor = false,
        Parent = titleBar
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = minBtn })
    minBtn.MouseButton1Click:Connect(function()
        local isMin = self.Main.Size.Y.Offset < 100
        self.Main.Size = isMin and UDim2.new(0, 440, 0, 340) or UDim2.new(0, 440, 0, 36)
    end)

    -- Botón cerrar
    local closeBtn = Create("TextButton", {
        Size = UDim2.new(0, 24, 0, 24),
        Position = UDim2.new(1, -30, 0, 6),
        BackgroundColor3 = Theme.Danger,
        Text = "X",
        TextColor3 = Color3.new(1,1,1),
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        AutoButtonColor = false,
        Parent = titleBar
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = closeBtn })
    closeBtn.MouseButton1Click:Connect(function() self.ScreenGui:Destroy() end)

    -- Arrastrable
    local dragging, dragStart, startPos
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = self.Main.Position
        end
    end)
    titleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            self.Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- Sidebar
    self.Sidebar = Create("Frame", {
        Size = UDim2.new(0, 120, 1, -50),
        Position = UDim2.new(0, 10, 0, 44),
        BackgroundColor3 = Theme.Header,
        BorderSizePixel = 0,
        Parent = self.Main
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 10), Parent = self.Sidebar })

    -- Content
    self.Content = Create("Frame", {
        Size = UDim2.new(1, -145, 1, -50),
        Position = UDim2.new(0, 135, 0, 44),
        BackgroundColor3 = Theme.Header,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = self.Main
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 10), Parent = self.Content })

    return self
end

-- ============================================================
-- TAB
-- ============================================================
function ALEXUI:CreateTab(name)
    local tab = { Name = name, Y = 10 }

    local btn = Create("TextButton", {
        Size = UDim2.new(1, -12, 0, 30),
        Position = UDim2.new(0, 6, 0, 6 + (#self.Tabs * 34)),
        BackgroundColor3 = Theme.Background,
        Text = "  " .. name,
        TextColor3 = Theme.SubText,
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        AutoButtonColor = false,
        Parent = self.Sidebar
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = btn })

    local frame = Create("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Visible = false,
        Parent = self.Content
    })

    tab.Button = btn
    tab.Frame = frame

    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(self.Tabs) do
            t.Frame.Visible = false
            t.Button.BackgroundColor3 = Theme.Background
            t.Button.TextColor3 = Theme.SubText
        end
        frame.Visible = true
        btn.BackgroundColor3 = Theme.Accent
        btn.TextColor3 = Theme.Text
        self.CurrentTab = tab
    end)

    table.insert(self.Tabs, tab)
    if #self.Tabs == 1 then
        frame.Visible = true
        btn.BackgroundColor3 = Theme.Accent
        btn.TextColor3 = Theme.Text
        self.CurrentTab = tab
    end

    return tab
end

-- ============================================================
-- SECTION
-- ============================================================
function ALEXUI:CreateSection(tab, name)
    local label = Create("TextLabel", {
        Size = UDim2.new(1, -20, 0, 22),
        Position = UDim2.new(0, 10, 0, tab.Y),
        BackgroundTransparency = 1,
        Text = "▸ " .. name,
        TextColor3 = Theme.Accent,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = tab.Frame
    })
    tab.Y = tab.Y + 26

    return { Name = name, Frame = tab.Frame, Tab = tab }
end

-- ============================================================
-- BOTÓN
-- ============================================================
function ALEXUI:CreateButton(section, name, callback)
    local tab = section.Tab
    local btn = Create("TextButton", {
        Size = UDim2.new(1, -20, 0, 32),
        Position = UDim2.new(0, 10, 0, tab.Y),
        BackgroundColor3 = Theme.Element,
        Text = name,
        TextColor3 = Theme.Text,
        Font = Enum.Font.Gotham,
        TextSize = 12,
        AutoButtonColor = false,
        Parent = section.Frame
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = btn })
    Create("UIStroke", { Color = Theme.Stroke, Thickness = 1, Transparency = 0.5, Parent = btn })
    tab.Y = tab.Y + 36

    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Theme.ElementHover
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Theme.Element
    end)

    btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)

    return btn
end

-- ============================================================
-- TOGGLE
-- ============================================================
function ALEXUI:CreateToggle(section, name, default, callback)
    local tab = section.Tab
    local state = default or false

    local container = Create("Frame", {
        Size = UDim2.new(1, -20, 0, 32),
        Position = UDim2.new(0, 10, 0, tab.Y),
        BackgroundColor3 = Theme.Element,
        Parent = section.Frame
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = container })
    Create("UIStroke", { Color = Theme.Stroke, Thickness = 1, Transparency = 0.5, Parent = container })
    tab.Y = tab.Y + 36

    Create("TextLabel", {
        Size = UDim2.new(1, -60, 1, 0),
        Position = UDim2.new(0, 12, 0, 0),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = Theme.Text,
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = container
    })

    local toggleBtn = Create("TextButton", {
        Size = UDim2.new(0, 38, 0, 20),
        Position = UDim2.new(1, -48, 0.5, -10),
        BackgroundColor3 = state and Theme.Accent or Theme.ToggleOff,
        Text = "",
        AutoButtonColor = false,
        Parent = container
    })
    Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = toggleBtn })

    local circle = Create("Frame", {
        Size = UDim2.new(0, 16, 0, 16),
        Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
        BackgroundColor3 = Color3.new(1, 1, 1),
        Parent = toggleBtn
    })
    Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = circle })

    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        toggleBtn.BackgroundColor3 = state and Theme.Accent or Theme.ToggleOff
        circle.Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        if callback then callback(state) end
    end)

    return toggleBtn
end

-- ============================================================
-- SLIDER
-- ============================================================
function ALEXUI:CreateSlider(section, name, min, max, default, callback)
    local tab = section.Tab
    min = min or 0
    max = max or 100
    local value = default or min

    local container = Create("Frame", {
        Size = UDim2.new(1, -20, 0, 46),
        Position = UDim2.new(0, 10, 0, tab.Y),
        BackgroundColor3 = Theme.Element,
        Parent = section.Frame
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = container })
    Create("UIStroke", { Color = Theme.Stroke, Thickness = 1, Transparency = 0.5, Parent = container })
    tab.Y = tab.Y + 50

    local label = Create("TextLabel", {
        Size = UDim2.new(1, -20, 0, 16),
        Position = UDim2.new(0, 12, 0, 5),
        BackgroundTransparency = 1,
        Text = name .. ": " .. value,
        TextColor3 = Theme.Text,
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = container
    })

    local bar = Create("Frame", {
        Size = UDim2.new(1, -24, 0, 6),
        Position = UDim2.new(0, 12, 0, 30),
        BackgroundColor3 = Theme.Background,
        Parent = container
    })
    Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = bar })

    local fill = Create("Frame", {
        Size = UDim2.new((value - min) / (max - min), 0, 1, 0),
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0,
        Parent = bar
    })
    Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = fill })

    local dragging = false
    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
            local relX = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            value = math.floor(min + (max - min) * relX)
            fill.Size = UDim2.new(relX, 0, 1, 0)
            label.Text = name .. ": " .. value
            if callback then callback(value) end
        end
    end)

    return bar
end

-- ============================================================
-- DROPDOWN
-- ============================================================
function ALEXUI:CreateDropdown(section, name, options, default, callback)
    local tab = section.Tab
    local container = Create("Frame", {
        Size = UDim2.new(1, -20, 0, 32),
        Position = UDim2.new(0, 10, 0, tab.Y),
        BackgroundColor3 = Theme.Element,
        ClipsDescendants = true,
        Parent = section.Frame
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = container })
    Create("UIStroke", { Color = Theme.Stroke, Thickness = 1, Transparency = 0.5, Parent = container })

    local selected = default or (options and options[1]) or "Ninguno"

    local header = Create("TextButton", {
        Size = UDim2.new(1, 0, 0, 32),
        BackgroundTransparency = 1,
        Text = name .. ": " .. tostring(selected) .. "  ▼",
        TextColor3 = Theme.Text,
        Font = Enum.Font.Gotham,
        TextSize = 12,
        AutoButtonColor = false,
        Parent = container
    })

    local listFrame = Create("Frame", {
        Size = UDim2.new(1, -10, 0, 0),
        Position = UDim2.new(0, 5, 0, 34),
        BackgroundTransparency = 1,
        Visible = false,
        Parent = container
    })

    tab.Y = tab.Y + 36

    local open = false
    header.MouseButton1Click:Connect(function()
        open = not open
        if open then
            for _, child in pairs(listFrame:GetChildren()) do
                if child:IsA("TextButton") then child:Destroy() end
            end
            for i, opt in pairs(options) do
                local optBtn = Create("TextButton", {
                    Size = UDim2.new(1, 0, 0, 26),
                    Position = UDim2.new(0, 0, 0, (i - 1) * 28),
                    BackgroundColor3 = Theme.Background,
                    Text = tostring(opt),
                    TextColor3 = Theme.Text,
                    Font = Enum.Font.Gotham,
                    TextSize = 11,
                    Parent = listFrame
                })
                Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = optBtn })
                optBtn.MouseButton1Click:Connect(function()
                    selected = opt
                    header.Text = name .. ": " .. tostring(opt) .. "  ▼"
                    open = false
                    container.Size = UDim2.new(1, -20, 0, 32)
                    listFrame.Visible = false
                    if callback then callback(opt) end
                end)
            end
            local height = math.min(#options * 28, 130)
            container.Size = UDim2.new(1, -20, 0, 32 + height + 5)
            listFrame.Size = UDim2.new(1, -10, 0, height)
            listFrame.Visible = true
        else
            container.Size = UDim2.new(1, -20, 0, 32)
            listFrame.Visible = false
        end
    end)

    return header
end

-- ============================================================
-- TEXTBOX
-- ============================================================
function ALEXUI:CreateTextbox(section, name, placeholder, callback)
    local tab = section.Tab
    local container = Create("Frame", {
        Size = UDim2.new(1, -20, 0, 32),
        Position = UDim2.new(0, 10, 0, tab.Y),
        BackgroundColor3 = Theme.Element,
        Parent = section.Frame
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = container })
    Create("UIStroke", { Color = Theme.Stroke, Thickness = 1, Transparency = 0.5, Parent = container })
    tab.Y = tab.Y + 36

    local box = Create("TextBox", {
        Size = UDim2.new(1, -24, 1, -8),
        Position = UDim2.new(0, 12, 0, 4),
        BackgroundTransparency = 1,
        Text = "",
        PlaceholderText = placeholder or name,
        PlaceholderColor3 = Theme.SubText,
        TextColor3 = Theme.Text,
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
        Parent = container
    })

    box.FocusLost:Connect(function()
        if callback then callback(box.Text) end
    end)

    return box
end

-- ============================================================
-- COLORPICKER
-- ============================================================
function ALEXUI:CreateColorpicker(section, name, default, callback)
    local tab = section.Tab
    local container = Create("Frame", {
        Size = UDim2.new(1, -20, 0, 32),
        Position = UDim2.new(0, 10, 0, tab.Y),
        BackgroundColor3 = Theme.Element,
        Parent = section.Frame
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = container })
    Create("UIStroke", { Color = Theme.Stroke, Thickness = 1, Transparency = 0.5, Parent = container })
    tab.Y = tab.Y + 36

    Create("TextLabel", {
        Size = UDim2.new(1, -60, 1, 0),
        Position = UDim2.new(0, 12, 0, 0),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = Theme.Text,
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = container
    })

    local colorBtn = Create("TextButton", {
        Size = UDim2.new(0, 38, 0, 20),
        Position = UDim2.new(1, -48, 0.5, -10),
        BackgroundColor3 = default or Color3.fromRGB(255, 0, 0),
        Text = "",
        AutoButtonColor = false,
        Parent = container
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 7), Parent = colorBtn })

    local palette = {
        Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 0, 255),
        Color3.fromRGB(255, 255, 0), Color3.fromRGB(255, 0, 255), Color3.fromRGB(0, 255, 255),
        Color3.fromRGB(255, 255, 255), Color3.fromRGB(0, 0, 0)
    }
    local index = 1

    colorBtn.MouseButton1Click:Connect(function()
        index = index + 1
        if index > #palette then index = 1 end
        colorBtn.BackgroundColor3 = palette[index]
        if callback then callback(palette[index]) end
    end)

    return colorBtn
end

-- ============================================================
-- KEYBIND
-- ============================================================
function ALEXUI:CreateKeybind(section, name, defaultKey, callback)
    local tab = section.Tab
    local container = Create("Frame", {
        Size = UDim2.new(1, -20, 0, 32),
        Position = UDim2.new(0, 10, 0, tab.Y),
        BackgroundColor3 = Theme.Element,
        Parent = section.Frame
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = container })
    Create("UIStroke", { Color = Theme.Stroke, Thickness = 1, Transparency = 0.5, Parent = container })
    tab.Y = tab.Y + 36

    Create("TextLabel", {
        Size = UDim2.new(1, -80, 1, 0),
        Position = UDim2.new(0, 12, 0, 0),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = Theme.Text,
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = container
    })

    local keyBtn = Create("TextButton", {
        Size = UDim2.new(0, 60, 0, 20),
        Position = UDim2.new(1, -70, 0.5, -10),
        BackgroundColor3 = Theme.Background,
        Text = defaultKey or "NONE",
        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        AutoButtonColor = false,
        Parent = container
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 7), Parent = keyBtn })

    local listening = false
    keyBtn.MouseButton1Click:Connect(function()
        listening = true
        keyBtn.Text = "..."
    end)

    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if listening and input.UserInputType == Enum.UserInputType.Keyboard then
            keyBtn.Text = input.KeyCode.Name
            listening = false
            if callback then callback(input.KeyCode) end
        end
    end)

    return keyBtn
end

-- ============================================================
-- LABEL
-- ============================================================
function ALEXUI:CreateLabel(section, text)
    local tab = section.Tab
    local label = Create("TextLabel", {
        Size = UDim2.new(1, -20, 0, 22),
        Position = UDim2.new(0, 10, 0, tab.Y),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = Theme.SubText,
        Font = Enum.Font.Gotham,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = section.Frame
    })
    tab.Y = tab.Y + 26
    return label
end

-- ============================================================
-- NOTIFICACIÓN
-- ============================================================
local notifCount = 0
function ALEXUI:Notify(title, text, duration)
    duration = duration or 3
    notifCount = notifCount + 1
    local notif = Create("Frame", {
        Size = UDim2.new(0, 260, 0, 60),
        Position = UDim2.new(1, -270, 0, 20 + (notifCount - 1) * 70),
        BackgroundColor3 = Theme.Header,
        BorderSizePixel = 0,
        Parent = self.ScreenGui
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 10), Parent = notif })
    Create("UIStroke", { Color = Theme.Stroke, Thickness = 1, Transparency = 0.3, Parent = notif })

    Create("Frame", {
        Size = UDim2.new(0, 3, 0, 32),
        Position = UDim2.new(0, 8, 0.5, -16),
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0,
        Parent = notif
    })

    Create("TextLabel", {
        Size = UDim2.new(1, -30, 0, 18), Position = UDim2.new(0, 18, 0, 8),
        BackgroundTransparency = 1, Text = title, TextColor3 = Theme.Accent,
        Font = Enum.Font.GothamBold, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, Parent = notif
    })

    Create("TextLabel", {
        Size = UDim2.new(1, -30, 0, 18), Position = UDim2.new(0, 18, 0, 30),
        BackgroundTransparency = 1, Text = text, TextColor3 = Theme.Text,
        Font = Enum.Font.Gotham, TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left, Parent = notif
    })

    task.delay(duration, function() notif:Destroy() end)
end

-- ============================================================
-- TEMAS
-- ============================================================
function ALEXUI:SetTheme(name)
    local themes = {
        Default = {
            Background = Color3.fromRGB(15, 15, 20),
            Header = Color3.fromRGB(22, 22, 30),
            Accent = Color3.fromRGB(130, 80, 220),
            Text = Color3.fromRGB(255, 255, 255),
            SubText = Color3.fromRGB(160, 160, 175),
            Element = Color3.fromRGB(30, 30, 40),
            ElementHover = Color3.fromRGB(40, 40, 52),
            ToggleOff = Color3.fromRGB(55, 55, 68),
            Danger = Color3.fromRGB(220, 60, 60),
            Success = Color3.fromRGB(60, 200, 60),
            Stroke = Color3.fromRGB(60, 60, 75)
        },
        SpeedHub = {
            Background = Color3.fromRGB(12, 12, 16),
            Header = Color3.fromRGB(20, 20, 26),
            Accent = Color3.fromRGB(255, 60, 60),
            Text = Color3.fromRGB(255, 255, 255),
            SubText = Color3.fromRGB(150, 150, 160),
            Element = Color3.fromRGB(28, 28, 36),
            ElementHover = Color3.fromRGB(38, 38, 46),
            ToggleOff = Color3.fromRGB(50, 50, 60),
            Danger = Color3.fromRGB(220, 60, 60),
            Success = Color3.fromRGB(60, 200, 60),
            Stroke = Color3.fromRGB(50, 50, 60)
        },
        Midnight = {
            Background = Color3.fromRGB(10, 15, 30),
            Header = Color3.fromRGB(20, 25, 45),
            Accent = Color3.fromRGB(80, 150, 255),
            Text = Color3.fromRGB(240, 245, 255),
            SubText = Color3.fromRGB(150, 160, 180),
            Element = Color3.fromRGB(25, 35, 55),
            ElementHover = Color3.fromRGB(35, 45, 70),
            ToggleOff = Color3.fromRGB(45, 55, 80),
            Danger = Color3.fromRGB(220, 60, 60),
            Success = Color3.fromRGB(60, 200, 60),
            Stroke = Color3.fromRGB(50, 70, 100)
        }
    }
    
    if themes[name] then
        for k, v in pairs(themes[name]) do
            Theme[k] = v
        end
        return true
    end
    return false
end

function ALEXUI:GetThemes()
    return {"Default", "SpeedHub", "Midnight"}
end

return ALEXUI
