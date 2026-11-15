--=====================================================================
--  NEXUS  |  Script Hub
--  Credits: TRJacob, unknownbyz, Ultexxx, stackmakerr
--  RightShift = hide/show
--=====================================================================

local function boot()

local Players = game:GetService("Players")
local UIS     = game:GetService("UserInputService")
local RunS    = game:GetService("RunService")
local TS      = game:GetService("TweenService")
local MPS     = game:GetService("MarketplaceService")
local RS      = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local LP      = Players.LocalPlayer

local PARENT = (gethui and gethui()) or game:GetService("CoreGui")

for _, v in ipairs(PARENT:GetChildren()) do
    if v.Name == "NexusUI" then v:Destroy() end
end

--=====================================================================
-- helpers
--=====================================================================
local function new(class, props, parent)
    local o = Instance.new(class)
    for k, v in pairs(props) do o[k] = v end
    if parent then o.Parent = parent end
    return o
end

local function corner(obj, r)
    new("UICorner", { CornerRadius = UDim.new(0, r or 6) }, obj)
end

local function stroke(obj, c, t)
    return new("UIStroke", {
        Color = c or Color3.fromRGB(60, 60, 75),
        Thickness = t or 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    }, obj)
end

local ACCENT = Color3.fromRGB(125, 70, 255)
local accentEls, gradients = {}, {}

local function shiftHue(c, amt)
    local h, s, v = Color3.toHSV(c)
    return Color3.fromHSV((h + amt) % 1, s, v)
end

local function registerAccent(obj, prop)
    table.insert(accentEls, { obj = obj, prop = prop })
end

local function applyAccent(c)
    ACCENT = c
    local second = shiftHue(c, 0.07)
    for _, e in ipairs(accentEls) do
        pcall(function() e.obj[e.prop] = ACCENT end)
    end
    for _, g in ipairs(gradients) do
        pcall(function() g.Color = ColorSequence.new(ACCENT, second) end)
    end
end

--=====================================================================
-- LOADING SCREEN
--=====================================================================
local loadGui = new("ScreenGui", {
    Name = "NexusUI",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 999,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, PARENT)

local loader = new("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = Color3.fromRGB(8, 8, 12),
    BorderSizePixel = 0
}, loadGui)

new("TextLabel", {
    Size = UDim2.new(0, 400, 0, 60),
    Position = UDim2.new(0.5, -200, 0.5, -100),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    Text = "NEXUS",
    TextSize = 46,
    TextColor3 = Color3.fromRGB(255, 255, 255)
}, loader)

local lBarBg = new("Frame", {
    Size = UDim2.new(0, 360, 0, 4),
    Position = UDim2.new(0.5, -180, 0.5, 10),
    BackgroundColor3 = Color3.fromRGB(30, 30, 40),
    BorderSizePixel = 0
}, loader)
corner(lBarBg, 3)

local lBar = new("Frame", {
    Size = UDim2.new(0, 0, 1, 0),
    BackgroundColor3 = ACCENT,
    BorderSizePixel = 0
}, lBarBg)
corner(lBar, 3)

new("TextLabel", {
    Size = UDim2.new(0, 400, 0, 16),
    Position = UDim2.new(0.5, -200, 0.5, 26),
    BackgroundTransparency = 1,
    Font = Enum.Font.Code,
    Text = "loading...",
    TextSize = 12,
    TextColor3 = Color3.fromRGB(110, 110, 130)
}, loader)

TS:Create(lBar, TweenInfo.new(1.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    { Size = UDim2.fromScale(1, 1) }):Play()

task.wait(1.95)
TS:Create(loader, TweenInfo.new(0.25), { BackgroundTransparency = 1 }):Play()
for _, d in ipairs(loader:GetDescendants()) do
    if d:IsA("TextLabel") then pcall(function() d.TextTransparency = 1 end)
    elseif d:IsA("Frame") then pcall(function() d.BackgroundTransparency = 1 end) end
end
task.wait(0.3)
loader:Destroy()

--=====================================================================
-- MAIN WINDOW
--=====================================================================
local main = new("Frame", {
    Size = UDim2.new(0, 520, 0, 380),
    Position = UDim2.new(0.5, -260, 0.5, -190),
    BackgroundColor3 = Color3.fromRGB(18, 18, 24),
    BorderSizePixel = 0
}, loadGui)
corner(main, 10)
stroke(main, Color3.fromRGB(45, 45, 58), 1)

local uiScale = new("UIScale", { Scale = 1 }, main)

local topbar = new("Frame", {
    Size = UDim2.new(1, 0, 0, 40),
    BackgroundColor3 = ACCENT,
    BorderSizePixel = 0
}, main)
corner(topbar, 10)
new("Frame", { Size = UDim2.new(1, 0, 0, 14), Position = UDim2.new(0, 0, 1, -14),
    BackgroundColor3 = ACCENT, BorderSizePixel = 0 }, topbar)
local topGrad = new("UIGradient", { Color = ColorSequence.new(ACCENT, shiftHue(ACCENT, 0.07)) }, topbar)
table.insert(gradients, topGrad)

new("TextLabel", {
    Size = UDim2.new(0, 200, 1, 0),
    Position = UDim2.new(0, 14, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    Text = "NEXUS",
    TextSize = 17,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = Color3.fromRGB(255, 255, 255)
}, topbar)

new("TextLabel", {
    Size = UDim2.new(0, 140, 1, 0),
    Position = UDim2.new(0, 84, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    Text = "| hub",
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = Color3.fromRGB(215, 210, 235)
}, topbar)

local minBtn = new("TextButton", {
    Size = UDim2.new(0, 28, 0, 28),
    Position = UDim2.new(1, -68, 0, 6),
    BackgroundColor3 = Color3.fromRGB(20, 20, 28),
    BackgroundTransparency = 0.35,
    BorderSizePixel = 0,
    Font = Enum.Font.GothamBold,
    Text = "_",
    TextSize = 14,
    TextColor3 = Color3.fromRGB(255, 255, 255)
}, topbar)
corner(minBtn, 6)

local closeBtn = new("TextButton", {
    Size = UDim2.new(0, 28, 0, 28),
    Position = UDim2.new(1, -36, 0, 6),
    BackgroundColor3 = Color3.fromRGB(20, 20, 28),
    BackgroundTransparency = 0.35,
    BorderSizePixel = 0,
    Font = Enum.Font.GothamBold,
    Text = "X",
    TextSize = 12,
    TextColor3 = Color3.fromRGB(255, 255, 255)
}, topbar)
corner(closeBtn, 6)

local dragging, dragStart, startPos
topbar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        dragging, dragStart, startPos = true, i.Position, main.Position
    end
end)
UIS.InputChanged:Connect(function(i)
    if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X,
                                  startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local bubble = new("Frame", {
    Size = UDim2.fromOffset(44, 44),
    Position = UDim2.new(0, 30, 0.5, -22),
    BackgroundColor3 = ACCENT,
    BorderSizePixel = 0,
    Visible = false
}, loadGui)
corner(bubble, 10)
stroke(bubble, Color3.fromRGB(255, 255, 255), 1)

new("TextLabel", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBlack,
    Text = "N",
    TextSize = 20,
    TextColor3 = Color3.fromRGB(255, 255, 255)
}, bubble)

local bubbleBtn = new("TextButton", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Text = ""
}, bubble)

local bDragging, bStart, bPos, bMoved
bubble.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        bDragging, bStart, bPos, bMoved = true, i.Position, bubble.Position, false
    end
end)
UIS.InputChanged:Connect(function(i)
    if bDragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - bStart
        if math.abs(d.X) + math.abs(d.Y) > 4 then bMoved = true end
        bubble.Position = UDim2.new(bPos.X.Scale, bPos.X.Offset + d.X,
                                    bPos.Y.Scale, bPos.Y.Offset + d.Y)
    end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        bDragging = false
    end
end)

--=====================================================================
-- layout
--=====================================================================
local sidebar = new("Frame", {
    Size = UDim2.new(0, 118, 1, -40),
    Position = UDim2.new(0, 0, 0, 40),
    BackgroundColor3 = Color3.fromRGB(21, 21, 28),
    BorderSizePixel = 0
}, main)

local pageHolder = new("Frame", {
    Size = UDim2.new(1, -128, 1, -50),
    Position = UDim2.new(0, 122, 0, 44),
    BackgroundTransparency = 1
}, main)

local pages, tabButtons = {}, {}

local function makePage(name)
    local p = new("ScrollingFrame", {
        Name = name,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Color3.fromRGB(60, 60, 75),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        Visible = false
    }, pageHolder)
    pcall(function() p.AutomaticCanvasSize = Enum.AutomaticSize.Y end)
    pages[name] = p
    return p
end

local function makeTab(name)
    local b = new("TextButton", {
        Size = UDim2.new(1, -12, 0, 31),
        Position = UDim2.new(0, 6, 0, 6 + (#tabButtons * 35)),
        BackgroundColor3 = Color3.fromRGB(28, 28, 36),
        BackgroundTransparency = 0.4,
        BorderSizePixel = 0,
        Font = Enum.Font.GothamMedium,
        Text = name,
        TextSize = 12,
        TextColor3 = Color3.fromRGB(170, 170, 190),
        AutoButtonColor = false
    }, sidebar)
    corner(b, 6)
    table.insert(tabButtons, b)

    b.MouseButton1Click:Connect(function()
        for n, pg in pairs(pages) do pg.Visible = (n == name) end
        for _, tb in ipairs(tabButtons) do
            TS:Create(tb, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(28, 28, 36),
                BackgroundTransparency = 0.4, TextColor3 = Color3.fromRGB(170, 170, 190) }):Play()
        end
        TS:Create(b, TweenInfo.new(0.15), { BackgroundColor3 = ACCENT,
            BackgroundTransparency = 0, TextColor3 = Color3.fromRGB(255, 255, 255) }):Play()
    end)
    return b
end

--=====================================================================
-- WIDGETS
--=====================================================================
local yOff = 0
local layoutSeq = 0

local function row(parent)
    layoutSeq += 1
    local r = new("Frame", {
        Size = UDim2.new(1, -10, 0, 30),
        Position = UDim2.new(0, 0, 0, yOff),
        BackgroundColor3 = Color3.fromRGB(24, 24, 31),
        BorderSizePixel = 0,
        LayoutOrder = layoutSeq
    }, parent)
    corner(r, 6)
    yOff += 34
    return r
end

local function label(parent, text, width)
    return new("TextLabel", {
        Size = UDim2.new(1, width or -90, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        Text = text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = Color3.fromRGB(205, 205, 218)
    }, parent)
end

local function makeToggle(parent, text, default, action, shared)
    shared = shared or { v = default or false, renders = {} }
    if action and not shared.action then shared.action = action end

    local r = row(parent)
    label(r, text)
    local track = new("Frame", {
        Size = UDim2.new(0, 38, 0, 18),
        Position = UDim2.new(1, -48, 0.5, -9),
        BackgroundColor3 = Color3.fromRGB(45, 45, 58),
        BorderSizePixel = 0
    }, r)
    corner(track, 9)
    local knob = new("Frame", {
        Size = UDim2.new(0, 14, 0, 14),
        Position = UDim2.new(0, 2, 0.5, -7),
        BackgroundColor3 = Color3.fromRGB(230, 230, 240),
        BorderSizePixel = 0
    }, track)
    corner(knob, 7)

    local function render()
        TS:Create(track, TweenInfo.new(0.15), {
            BackgroundColor3 = shared.v and ACCENT or Color3.fromRGB(45, 45, 58) }):Play()
        TS:Create(knob, TweenInfo.new(0.15), {
            Position = shared.v and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7) }):Play()
    end

    local function set(v)
        shared.v = v
        for _, rfn in ipairs(shared.renders) do pcall(rfn) end
        if shared.action then pcall(shared.action, v) end
    end

    table.insert(shared.renders, render)

    local btn = new("TextButton", { Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1, Text = "" }, r)
    btn.MouseButton1Click:Connect(function() set(not shared.v) end)

    render()
    return { set = set, get = function() return shared.v end, shared = shared }
end

local function makeLoopToggle(parent, text, startFn, stopFn, shared)
    local conn
    return makeToggle(parent, text, false, function(on)
        if on then
            conn = startFn and startFn()
        else
            if conn then pcall(function() conn:Disconnect() end); conn = nil end
            if stopFn then pcall(stopFn) end
        end
    end, shared)
end

local function makeTextBox(parent, text, default, callback)
    local r = row(parent)
    label(r, text)
    local box = new("TextBox", {
        Size = UDim2.new(0, 70, 0, 22),
        Position = UDim2.new(1, -80, 0.5, -11),
        BackgroundColor3 = Color3.fromRGB(34, 34, 44),
        BorderSizePixel = 0,
        Font = Enum.Font.Code,
        Text = tostring(default),
        TextSize = 12,
        TextColor3 = Color3.fromRGB(230, 230, 240),
        ClearTextOnFocus = false
    }, r)
    corner(box, 5)
    box.FocusLost:Connect(function()
        local n = tonumber(box.Text)
        if n then pcall(callback, n) else box.Text = tostring(default) end
    end)
    return box
end

local function makeTextInput(parent, text, default, callback)
    local r = row(parent)
    label(r, text)
    local box = new("TextBox", {
        Size = UDim2.new(0, 130, 0, 22),
        Position = UDim2.new(1, -140, 0.5, -11),
        BackgroundColor3 = Color3.fromRGB(34, 34, 44),
        BorderSizePixel = 0,
        Font = Enum.Font.Code,
        Text = tostring(default),
        TextSize = 11,
        TextColor3 = Color3.fromRGB(230, 230, 240),
        ClearTextOnFocus = false
    }, r)
    corner(box, 5)
    box.FocusLost:Connect(function() pcall(callback, box.Text) end)
    return box
end

local function makeStepper(parent, text, value, min, max, step, fmt, callback)
    local r = row(parent)
    label(r, text, -128)

    local minus = new("TextButton", {
        Size = UDim2.new(0, 22, 0, 20),
        Position = UDim2.new(1, -108, 0.5, -10),
        BackgroundColor3 = Color3.fromRGB(40, 40, 52),
        BorderSizePixel = 0,
        Font = Enum.Font.GothamBold,
        Text = "-",
        TextSize = 13,
        TextColor3 = Color3.fromRGB(235, 235, 245)
    }, r)
    corner(minus, 5)

    local valLabel = new("TextLabel", {
        Size = UDim2.new(0, 46, 1, 0),
        Position = UDim2.new(1, -84, 0, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.Code,
        Text = fmt(value),
        TextSize = 11,
        TextColor3 = Color3.fromRGB(225, 225, 240)
    }, r)

    local plus = new("TextButton", {
        Size = UDim2.new(0, 22, 0, 20),
        Position = UDim2.new(1, -32, 0.5, -10),
        BackgroundColor3 = Color3.fromRGB(40, 40, 52),
        BorderSizePixel = 0,
        Font = Enum.Font.GothamBold,
        Text = "+",
        TextSize = 13,
        TextColor3 = Color3.fromRGB(235, 235, 245)
    }, r)
    corner(plus, 5)

    local current = value
    local function apply(v)
        current = math.clamp(math.floor(v / step + 0.5) * step, min, max)
        current = math.floor(current * 1000 + 0.5) / 1000
        valLabel.Text = fmt(current)
        if callback then pcall(callback, current) end
    end

    minus.MouseButton1Click:Connect(function() apply(current - step) end)
    plus.MouseButton1Click:Connect(function() apply(current + step) end)

    return { get = function() return current end, set = apply }
end

local function makeButton(parent, text, callback, height)
    local r = row(parent)
    if height then r.Size = UDim2.new(1, -10, 0, height) end
    local b = new("TextButton", {
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.fromRGB(34, 34, 44),
        BorderSizePixel = 0,
        Font = Enum.Font.GothamMedium,
        Text = text,
        TextSize = 12,
        TextColor3 = Color3.fromRGB(230, 230, 240),
        AutoButtonColor = false
    }, r)
    corner(b, 6)
    b.MouseEnter:Connect(function()
        TS:Create(b, TweenInfo.new(0.12), { BackgroundColor3 = ACCENT }):Play()
    end)
    b.MouseLeave:Connect(function()
        TS:Create(b, TweenInfo.new(0.12), { BackgroundColor3 = Color3.fromRGB(34, 34, 44) }):Play()
    end)
    b.MouseButton1Click:Connect(function() pcall(callback) end)
    return b
end

local function sectionTitle(parent, text)
    layoutSeq += 1
    local t = new("TextLabel", {
        Size = UDim2.new(1, 0, 0, 20),
        Position = UDim2.new(0, 0, 0, yOff),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        Text = text:upper(),
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = Color3.fromRGB(110, 110, 130),
        LayoutOrder = layoutSeq
    }, parent)
    yOff += 24
    return t
end

local function descText(parent, text, height)
    layoutSeq += 1
    local order = layoutSeq
    local d = new("Frame", {
        Size = UDim2.new(1, -10, 0, height),
        Position = UDim2.new(0, 0, 0, yOff),
        BackgroundColor3 = Color3.fromRGB(22, 22, 29),
        BorderSizePixel = 0,
        LayoutOrder = order
    }, parent)
    corner(d, 6)
    new("TextLabel", {
        Size = UDim2.new(1, -16, 1, -12),
        Position = UDim2.new(0, 8, 0, 6),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        Text = text,
        TextSize = 10,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextColor3 = Color3.fromRGB(150, 150, 170)
    }, d)
    yOff += height + 4
    return d
end

--=====================================================================
-- STATE
--=====================================================================
local speedValue, jumpPowerValue, spinSpeedValue, flySpeedValue = 60, 80, 6, 60
local espOn, tracerOn, boxOn, nameOn, rgbOn = false, false, false, false, false
local flingIndex = 0
local jumpBoostOn = false
local gameCleanup = {}

local function hrp()
    local c = LP.Character
    return c and c:FindFirstChild("HumanoidRootPart")
end

local function humOf(p)
    local c = (p or LP).Character
    return c and c:FindFirstChildOfClass("Humanoid")
end

local function headOf(p)
    local c = (p or LP).Character
    return c and c:FindFirstChild("Head")
end

local function eachOther(fn)
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then fn(p, p.Character) end
    end
end

local function rainbow()
    return Color3.fromHSV((tick() * 0.4) % 1, 1, 1)
end

local function gToggle(parent, text, startFn)
    local h
    local t = makeToggle(parent, text, false, function(on)
        if on then
            h = startFn()
        else
            if h then pcall(function() h:Disconnect() end); h = nil end
        end
    end)
    table.insert(gameCleanup, function() if t.get() then t.set(false) end end)
    return t
end

--=====================================================================
-- SETTINGS
--=====================================================================
yOff = 0
local settingsPage = makePage("Settings")
makeTab("Settings")

sectionTitle(settingsPage, "Appearance")
makeToggle(settingsPage, "Disable Gradient", false, function(on)
    for _, g in ipairs(gradients) do pcall(function() g.Enabled = not on end) end
end)

sectionTitle(settingsPage, "Menu Scale")
local scaleRow = row(settingsPage)
label(scaleRow, "Menu Scale")

local scaleLabel = new("TextLabel", {
    Size = UDim2.new(0, 42, 1, 0),
    Position = UDim2.new(1, -74, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.Code,
    Text = "100%",
    TextSize = 11,
    TextColor3 = Color3.fromRGB(220, 220, 235)
}, scaleRow)

local scaleValue = 1
local function setScale(v)
    scaleValue = math.clamp(math.floor(v * 10 + 0.5) / 10, 0.6, 1.6)
    scaleLabel.Text = tostring(math.floor(scaleValue * 100)) .. "%"
    TS:Create(uiScale, TweenInfo.new(0.15), { Scale = scaleValue }):Play()
end

local minusBtn = new("TextButton", {
    Size = UDim2.new(0, 22, 0, 20),
    Position = UDim2.new(1, -100, 0.5, -10),
    BackgroundColor3 = Color3.fromRGB(40, 40, 52),
    BorderSizePixel = 0,
    Font = Enum.Font.GothamBold,
    Text = "-",
    TextSize = 13,
    TextColor3 = Color3.fromRGB(235, 235, 245)
}, scaleRow)
corner(minusBtn, 5)

local plusBtn = new("TextButton", {
    Size = UDim2.new(0, 22, 0, 20),
    Position = UDim2.new(1, -30, 0.5, -10),
    BackgroundColor3 = Color3.fromRGB(40, 40, 52),
    BorderSizePixel = 0,
    Font = Enum.Font.GothamBold,
    Text = "+",
    TextSize = 13,
    TextColor3 = Color3.fromRGB(235, 235, 245)
}, scaleRow)
corner(plusBtn, 5)

minusBtn.MouseButton1Click:Connect(function() setScale(scaleValue - 0.1) end)
plusBtn.MouseButton1Click:Connect(function() setScale(scaleValue + 0.1) end)

sectionTitle(settingsPage, "Menu Color")
local pickerRow = new("Frame", {
    Size = UDim2.new(1, -10, 0, 62),
    Position = UDim2.new(0, 0, 0, yOff),
    BackgroundColor3 = Color3.fromRGB(24, 24, 31),
    BorderSizePixel = 0
}, settingsPage)
corner(pickerRow, 6)
yOff += 66

local preview = new("Frame", {
    Size = UDim2.new(0, 34, 0, 34),
    Position = UDim2.new(0, 10, 0, 14),
    BackgroundColor3 = ACCENT,
    BorderSizePixel = 0
}, pickerRow)
corner(preview, 6)
stroke(preview, Color3.fromRGB(60, 60, 75), 1)

local rgbBoxes = {}
for i, ch in ipairs({ "R", "G", "B" }) do
    local bx = new("TextBox", {
        Size = UDim2.new(0, 42, 0, 22),
        Position = UDim2.new(0, 54 + ((i - 1) * 48), 0, 8),
        BackgroundColor3 = Color3.fromRGB(34, 34, 44),
        BorderSizePixel = 0,
        Font = Enum.Font.Code,
        PlaceholderText = ch,
        Text = "",
        TextSize = 11,
        TextColor3 = Color3.fromRGB(230, 230, 240)
    }, pickerRow)
    corner(bx, 5)
    rgbBoxes[i] = bx
end

local function readRGB()
    local r = tonumber(rgbBoxes[1].Text) or ACCENT.R * 255
    local g = tonumber(rgbBoxes[2].Text) or ACCENT.G * 255
    local b = tonumber(rgbBoxes[3].Text) or ACCENT.B * 255
    return Color3.fromRGB(math.clamp(r, 0, 255), math.clamp(g, 0, 255), math.clamp(b, 0, 255))
end

local applyBtn = new("TextButton", {
    Size = UDim2.new(0, 60, 0, 22),
    Position = UDim2.new(0, 54, 0, 34),
    BackgroundColor3 = ACCENT,
    BorderSizePixel = 0,
    Font = Enum.Font.GothamBold,
    Text = "APPLY",
    TextSize = 10,
    TextColor3 = Color3.fromRGB(255, 255, 255)
}, pickerRow)
corner(applyBtn, 5)
applyBtn.MouseButton1Click:Connect(function()
    local c = readRGB()
    preview.BackgroundColor3 = c
    applyAccent(c)
end)

local swatchRow = new("Frame", {
    Size = UDim2.new(1, -10, 0, 26),
    Position = UDim2.new(0, 0, 0, yOff),
    BackgroundTransparency = 1
}, settingsPage)
yOff += 30

for i, c in ipairs({
    Color3.fromRGB(125, 70, 255), Color3.fromRGB(255, 70, 120),
    Color3.fromRGB(60, 200, 255), Color3.fromRGB(70, 220, 130),
    Color3.fromRGB(255, 190, 60), Color3.fromRGB(230, 230, 240)
}) do
    local s = new("TextButton", {
        Size = UDim2.new(0, 26, 0, 26),
        Position = UDim2.new(0, (i - 1) * 32, 0, 0),
        BackgroundColor3 = c,
        BorderSizePixel = 0,
        Text = ""
    }, swatchRow)
    corner(s, 6)
    s.MouseButton1Click:Connect(function()
        preview.BackgroundColor3 = c
        applyAccent(c)
    end)
end

--=====================================================================
-- GAME (slot)
--=====================================================================
yOff = 0
local gamePage = makePage("Game")
makeTab("Game")

--=====================================================================
-- UNIVERSAL (slot)
--=====================================================================
yOff = 0
local uniPage = makePage("Universal")
makeTab("Universal")

local uniBody = new("Frame", {
    Size = UDim2.new(1, 0, 0, 0),
    BackgroundTransparency = 1
}, uniPage)
pcall(function() uniBody.AutomaticSize = Enum.AutomaticSize.Y end)
new("UIListLayout", { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder }, uniBody)

--=====================================================================
-- MOVEMENT
--=====================================================================
yOff = 0
local movePage = makePage("Movement")
makeTab("Movement")

local flyBV, flyBG, flyConn, floatBP, spinConn
local altUp, altDown = false, false

local flyPad = new("Frame", {
    Size = UDim2.new(0, 46, 0, 100),
    Position = UDim2.new(1, -66, 1, -160),
    BackgroundTransparency = 1,
    Visible = false
}, loadGui)

local function padBtn(text, pos, key)
    local b = new("TextButton", {
        Size = UDim2.new(0, 46, 0, 46),
        Position = pos,
        BackgroundColor3 = Color3.fromRGB(30, 30, 40),
        BackgroundTransparency = 0.25,
        BorderSizePixel = 0,
        Font = Enum.Font.GothamBold,
        Text = text,
        TextSize = 16,
        TextColor3 = Color3.fromRGB(255, 255, 255)
    }, flyPad)
    corner(b, 10)
    b.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
            if key == "u" then altUp = true else altDown = true end
        end
    end)
    b.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
            if key == "u" then altUp = false else altDown = false end
        end
    end)
end
padBtn("+", UDim2.new(0, 0, 0, 0), "u")
padBtn("-", UDim2.new(0, 0, 0, 54), "d")

local function stopFly()
    if flyConn then flyConn:Disconnect(); flyConn = nil end
    if flyBV then flyBV:Destroy(); flyBV = nil end
    if flyBG then flyBG:Destroy(); flyBG = nil end
    flyPad.Visible = false
end

local function startFly()
    local h = hrp()
    local hum = humOf()
    if not h then return end
    flyBV = new("BodyVelocity", { MaxForce = Vector3.new(1e5, 1e5, 1e5), Velocity = Vector3.zero }, h)
    flyBG = new("BodyGyro", { MaxTorque = Vector3.new(1e5, 1e5, 1e5), P = 12000, D = 200 }, h)
    flyPad.Visible = UIS.TouchEnabled and main.Visible

    flyConn = RunS.RenderStepped:Connect(function()
        local cam = workspace.CurrentCamera
        if not cam or not h.Parent then return end
        local dir = Vector3.zero
        if hum and hum.Parent then
            local md = hum.MoveDirection
            if md.Magnitude > 0 then
                local local3 = cam.CFrame:VectorToObjectSpace(md)
                dir = (cam.CFrame.RightVector * local3.X) + (cam.CFrame.LookVector * -local3.Z)
            end
            if hum.Jump or UIS:IsKeyDown(Enum.KeyCode.Space) or altUp then dir += Vector3.yAxis end
        end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) or UIS:IsKeyDown(Enum.KeyCode.LeftShift) or altDown then
            dir -= Vector3.yAxis
        end
        flyBV.Velocity = (dir.Magnitude > 0 and dir.Unit or Vector3.zero) * flySpeedValue
        flyBG.CFrame = cam.CFrame
    end)
end

sectionTitle(movePage, "Flight")
local flyToggle = makeToggle(movePage, "Fly", false, function(on)
    if on then startFly() else stopFly() end
end)
makeTextBox(movePage, "Fly Speed", flySpeedValue, function(n)
    flySpeedValue = math.clamp(n, 5, 500)
end)

sectionTitle(movePage, "Motion")
local spinToggle = makeToggle(movePage, "Spin", false, function(on)
    if spinConn then spinConn:Disconnect(); spinConn = nil end
    if on then
        spinConn = RunS.Heartbeat:Connect(function(dt)
            local h = hrp()
            if h then h.CFrame = h.CFrame * CFrame.Angles(0, math.rad(spinSpeedValue) * dt * 10, 0) end
        end)
    end
end)
makeTextBox(movePage, "Spin Speed", spinSpeedValue, function(n)
    spinSpeedValue = math.clamp(n, 1, 100)
end)

local speedToggle = makeToggle(movePage, "Speed", false, function(on)
    local hum = humOf()
    if hum then hum.WalkSpeed = on and speedValue or 16 end
end)
makeTextBox(movePage, "Movement Speed", speedValue, function(n)
    speedValue = math.clamp(n, 16, 500)
    local hum = humOf()
    if hum and hum.WalkSpeed > 16 then hum.WalkSpeed = speedValue end
end)

makeTextBox(movePage, "Jump Power", jumpPowerValue, function(n)
    jumpPowerValue = math.clamp(n, 50, 500)
    if jumpBoostOn then
        local hum = humOf()
        if hum then hum.JumpPower = jumpPowerValue end
    end
end)

makeToggle(movePage, "Jump Boost", false, function(on)
    jumpBoostOn = on
    local hum = humOf()
    if hum then
        hum.UseJumpPower = true
        hum.JumpPower = on and jumpPowerValue or 50
    end
end)

local floatToggle = makeToggle(movePage, "Float", false, function(on)
    if floatBP then floatBP:Destroy(); floatBP = nil end
    if on then
        local h = hrp()
        if h then
            floatBP = new("BodyPosition", {
                MaxForce = Vector3.new(1e5, 1e5, 1e5),
                P = 12000, D = 800,
                Position = h.Position
            }, h)
        end
    end
end)

--=====================================================================
-- VISUAL
--=====================================================================
yOff = 0
local visPage = makePage("Visual")
makeTab("Visual")

local espStore = {}
local function wipeESP()
    for _, d in pairs(espStore) do
        for _, o in pairs(d) do
            pcall(function() if o.Remove then o:Remove() else o:Destroy() end end)
        end
    end
    espStore = {}
end

RunS.RenderStepped:Connect(function()
    if not espOn then return end
    local cam = workspace.CurrentCamera
    if not cam then return end
    local base = rgbOn and rainbow() or ACCENT

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP and plr.Character then
            local h = plr.Character:FindFirstChild("HumanoidRootPart")
            local head = plr.Character:FindFirstChild("Head")
            if h and head then
                local data = espStore[plr]
                if not data then
                    data = {}
                    espStore[plr] = data
                    if boxOn then
                        data.box = new("BoxHandleAdornment", {
                            Adornee = h, Size = h.Size,
                            AlwaysOnTop = true, ZIndex = 5,
                            Color3 = base, Transparency = 0.35
                        }, h)
                    end
                    if nameOn then
                        local bg = new("BillboardGui", {
                            Adornee = head, Size = UDim2.new(0, 100, 0, 20),
                            StudsOffset = Vector3.new(0, 2.4, 0), AlwaysOnTop = true
                        }, head)
                        new("TextLabel", {
                            Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
                            Font = Enum.Font.GothamBold, Text = plr.Name,
                            TextSize = 11, TextColor3 = base,
                            TextStrokeTransparency = 0.4
                        }, bg)
                        data.name = bg
                    end
                    if tracerOn and Drawing then
                        local ok, ln = pcall(function()
                            local l = Drawing.new("Line")
                            l.Thickness = 1.5; l.Transparency = 1
                            return l
                        end)
                        if ok then data.tracer = ln end
                    end
                end

                if data.box then
                    data.box.Color3 = base
                    data.box.Size = h.Size
                end
                if data.name then
                    local lbl = data.name:FindFirstChildOfClass("TextLabel")
                    if lbl then lbl.TextColor3 = base end
                end
                if data.tracer then
                    local sp, on = cam:WorldToViewportPoint(head.Position)
                    pcall(function()
                        if on then
                            data.tracer.Color = base
                            data.tracer.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
                            data.tracer.To = Vector2.new(sp.X, sp.Y)
                            data.tracer.Visible = true
                        else
                            data.tracer.Visible = false
                        end
                    end)
                end
            end
        end
    end
end)

sectionTitle(visPage, "Player ESP")
local espToggle = makeToggle(visPage, "ESP", false, function(on)
    espOn = on
    if not on then wipeESP() end
end)
local boxToggle = makeToggle(visPage, "Boxes", false, function(on)
    boxOn = on; wipeESP()
end)
local nameToggle = makeToggle(visPage, "Name ESP", false, function(on)
    nameOn = on; wipeESP()
end)
local tracerToggle = makeToggle(visPage, "Tracers", false, function(on)
    tracerOn = on; wipeESP()
end)
makeToggle(visPage, "RGB Player", false, function(on)
    rgbOn = on
end)

--=====================================================================
-- FUN
--=====================================================================
yOff = 0
local funPage = makePage("Fun")
makeTab("Fun")

sectionTitle(funPage, "Movement Pranks")

makeLoopToggle(funPage, "Sit Everyone", function()
    return RunS.Heartbeat:Connect(function()
        eachOther(function(_, c)
            local hum = c:FindFirstChildOfClass("Humanoid")
            if hum then hum.Sit = true end
        end)
    end)
end)

makeLoopToggle(funPage, "Stand Everyone", function()
    return RunS.Heartbeat:Connect(function()
        eachOther(function(_, c)
            local hum = c:FindFirstChildOfClass("Humanoid")
            if hum then hum.Sit = false end
        end)
    end)
end)

makeLoopToggle(funPage, "Unanchor All Parts", function()
    return RunS.Heartbeat:Connect(function()
        eachOther(function(_, c)
            for _, d in ipairs(c:GetDescendants()) do
                if d:IsA("BasePart") and d.Name ~= "HumanoidRootPart" then
                    pcall(function() d.Anchored = false end)
                end
            end
        end)
    end)
end)

makeLoopToggle(funPage, "Rainbow Character", function()
    return RunS.Heartbeat:Connect(function()
        local c = LP.Character
        if not c then return end
        for _, d in ipairs(c:GetDescendants()) do
            if d:IsA("BasePart") then pcall(function() d.Color = rainbow() end) end
        end
    end)
end)

--=====================================================================
-- OVERPOWERED
--=====================================================================
yOff = 0
local opPage = makePage("Overpowered")
makeTab("Overpowered")

local function bringAll()
    local h = hrp()
    if not h then return end
    local i = 0
    local total = math.max(#Players:GetPlayers(), 1)
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local ph = p.Character:FindFirstChild("HumanoidRootPart")
            if ph then
                i += 1
                local a = (i / total) * math.pi * 2
                pcall(function()
                    ph.CFrame = h.CFrame * CFrame.new(math.cos(a) * 5, 0, math.sin(a) * 5)
                end)
            end
        end
    end
end

local function bangAll()
    local h = hrp()
    if not h then return end
    eachOther(function(_, c)
        local ph = c:FindFirstChild("HumanoidRootPart")
        if ph then
            pcall(function()
                ph.CFrame = h.CFrame * CFrame.new(math.random(-3, 3), 2, math.random(-3, 3))
                ph.AssemblyAngularVelocity = Vector3.new(900, 900, 900)
                ph.AssemblyLinearVelocity = Vector3.new(
                    math.random(-400, 400), 900, math.random(-400, 400))
            end)
        end
    end)
end

sectionTitle(opPage, "Bulk Actions")

local bringToggle = makeLoopToggle(opPage, "Bring All", function()
    return RunS.Heartbeat:Connect(bringAll)
end)

local flingToggle = makeLoopToggle(opPage, "Fling All", function()
    local spin = 0
    return RunS.Heartbeat:Connect(function(dt)
        local h = hrp()
        if not h then return end
        local list = {}
        eachOther(function(p)
            local ph = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
            if ph then table.insert(list, ph) end
        end)
        if #list == 0 then return end
        flingIndex = (flingIndex % #list) + 1
        local target = list[flingIndex]
        spin += math.rad(2400) * dt
        pcall(function()
            h.CFrame = target.CFrame * CFrame.new(0, 1.5, 0) * CFrame.Angles(0, spin, 0)
            h.AssemblyAngularVelocity = Vector3.new(6000, 6000, 6000)
            h.AssemblyLinearVelocity = Vector3.new(0, 120, 0)
            target.AssemblyAngularVelocity = Vector3.new(4000, 4000, 4000)
        end)
    end)
end, function()
    flingIndex = 0
end)

local bangToggle = makeLoopToggle(opPage, "Bang All", function()
    local acc = 0
    return RunS.Heartbeat:Connect(function(dt)
        acc += dt
        if acc >= 0.4 then
            acc = 0
            bangAll()
        end
    end)
end)

--=====================================================================
-- CREDITS
--=====================================================================
yOff = 0
local credPage = makePage("Credits")
makeTab("Credits")

sectionTitle(credPage, "Developers")
for _, n in ipairs({ "TRJacob", "unknownbyz", "Ultexxx", "stackmakerr" }) do
    local r = row(credPage)
    new("TextLabel", {
        Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
        Font = Enum.Font.GothamMedium, Text = n, TextSize = 12,
        TextColor3 = Color3.fromRGB(215, 215, 230)
    }, r)
end

sectionTitle(credPage, "Supported Games")
for _, n in ipairs({
    "Natural Disaster Survival", "RIVALS", "Murder Mystery 2",
    "Timebomb Anklebreak!", "Brookhaven", "Fling Things and People"
}) do
    local r = row(credPage)
    new("TextLabel", {
        Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
        Font = Enum.Font.Gotham, Text = n, TextSize = 11,
        TextColor3 = Color3.fromRGB(185, 185, 205)
    }, r)
end

makeButton(credPage, "See all at nxus.gg/supportedgames", function()
    if setclipboard then setclipboard("https://nxus.gg/supportedgames") end
end)

sectionTitle(credPage, "Info")
local info = row(credPage)
info.Size = UDim2.new(1, -10, 0, 46)
new("TextLabel", {
    Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
    Font = Enum.Font.Code, Text = "NEXUS  v2.2",
    TextSize = 11, TextColor3 = Color3.fromRGB(140, 140, 160)
}, info)
yOff += 20

--=====================================================================
-- AIMBOT / SILENT AIM CORE
--=====================================================================
local aimFov, aimReact, aimSmooth = 120, 0.12, 0.35
local aimbotOn, lockFovOn, silentOn = false, true, false
local silentAccuracy = 90
local aimTarget, reactAcc = nil, 0
local fovCircle, aimConn

pcall(function()
    if Drawing then
        local cir = Drawing.new("Circle")
        cir.Thickness = 1.5
        cir.NumSides = 64
        cir.Filled = false
        cir.Transparency = 0.8
        cir.Color = ACCENT
        cir.Visible = false
        fovCircle = cir
    end
end)

local function centerOf(cam)
    return Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
end

local function pickTarget(requireFov)
    local cam = workspace.CurrentCamera
    if not cam then return nil end
    local center = centerOf(cam)
    local best, bestDist = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local head = p.Character:FindFirstChild("Head")
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if head and hum and hum.Health > 0 then
                local sp, on = cam:WorldToViewportPoint(head.Position)
                if on and sp.Z > 0 then
                    local d = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                    if (not requireFov) or d <= aimFov then
                        if d < bestDist then best, bestDist = head, d end
                    end
                end
            end
        end
    end
    return best
end

local function startAimbot()
    if aimConn then aimConn:Disconnect() end
    reactAcc = 0
    aimConn = RunS.RenderStepped:Connect(function(dt)
        local cam = workspace.CurrentCamera
        if not cam then return end
        local center = centerOf(cam)

        if fovCircle then
            pcall(function()
                fovCircle.Position = center
                fovCircle.Radius = aimFov
                fovCircle.Color = ACCENT
                fovCircle.Visible = true
            end)
        end

        reactAcc += dt
        if reactAcc >= aimReact then
            reactAcc = 0
            aimTarget = pickTarget(lockFovOn)
        end

        if aimTarget and aimTarget.Parent then
            local goal = CFrame.lookAt(cam.CFrame.Position, aimTarget.Position)
            cam.CFrame = cam.CFrame:Lerp(goal, math.clamp(aimSmooth, 0.05, 1))
        end
    end)
end

local function stopAimbot()
    if aimConn then aimConn:Disconnect(); aimConn = nil end
    if fovCircle then pcall(function() fovCircle.Visible = false end) end
    aimTarget = nil
end

pcall(function()
    local mt = getrawmetatable(game)
    if not mt then error("no metatable") end
    local old = mt.__namecall
    if setreadonly then setreadonly(mt, false) end

    local wrapped = function(self, ...)
        local method = getnamecallmethod()
        if silentOn and (method == "Raycast" or method == "FindPartOnRay"
            or method == "FindPartOnRayWithIgnoreList" or method == "FindPartOnRayWithWhitelist") then
            local cam = workspace.CurrentCamera
            local target = cam and pickTarget(false)
            if target then
                local args = { ... }
                local spread = math.rad((100 - silentAccuracy) * 0.3)
                local function jitter(v)
                    local rot = CFrame.fromEulerAnglesXYZ(
                        (math.random() - 0.5) * spread,
                        (math.random() - 0.5) * spread, 0)
                    return (rot * v).Unit
                end

                if method == "Raycast" and type(args[1]) == "Vector3" then
                    local origin, dir = args[1], args[2]
                    args[2] = jitter((target.Position - origin)) * dir.Magnitude
                elseif type(args[1]) == "Ray" then
                    local ray = args[1]
                    args[1] = Ray.new(ray.Origin,
                        jitter((target.Position - ray.Origin)) * ray.Direction.Magnitude)
                end
                return old(self, table.unpack(args))
            end
        end
        return old(self, ...)
    end

    mt.__namecall = (newcclosure and newcclosure(wrapped)) or wrapped
    if setreadonly then setreadonly(mt, true) end
end)

--=====================================================================
-- UNIVERSAL CONTENT
--=====================================================================
yOff = 0

sectionTitle(uniBody, "Universal Aimbot")
descText(uniBody,
    "Locks your camera onto any player in any game. The FOV circle is where it can grab someone - the circle has to touch them before it locks.", 52)

local aimbotToggle = makeToggle(uniBody, "Aimbot", false, function(on)
    aimbotOn = on
    if on then startAimbot() else stopAimbot() end
end)

layoutSeq += 1
local aimOpts = new("Frame", {
    Size = UDim2.new(1, 0, 0, 0),
    BackgroundTransparency = 1,
    Visible = false,
    LayoutOrder = layoutSeq
}, uniBody)
new("UIListLayout", { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder }, aimOpts)
new("UIPadding", { PaddingLeft = UDim.new(0, 6) }, aimOpts)

makeToggle(aimOpts, "Lock On FOV", true, function(on) lockFovOn = on end)
makeStepper(aimOpts, "FOV", 120, 40, 700, 10, function(v) return v .. "px" end,
    function(v) aimFov = v end)
makeStepper(aimOpts, "Reaction Time", 0.12, 0, 0.6, 0.02, function(v)
    return string.format("%.2fs", v)
end, function(v) aimReact = v end)
makeStepper(aimOpts, "Smoothing", 0.35, 0.05, 1, 0.05, function(v)
    return string.format("%.2f", v)
end, function(v) aimSmooth = v end)

sectionTitle(uniBody, "Universal Silent Aim")
descText(uniBody,
    "Silent aim lets your shots land without your crosshair actually being on the target. Lower accuracy adds spread, higher keeps it tight.", 60)

local silentToggle = makeToggle(uniBody, "Silent Aim", false, function(on)
    silentOn = on
end)

layoutSeq += 1
local silentOpts = new("Frame", {
    Size = UDim2.new(1, 0, 0, 0),
    BackgroundTransparency = 1,
    Visible = false,
    LayoutOrder = layoutSeq
}, uniBody)
new("UIListLayout", { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder }, silentOpts)
new("UIPadding", { PaddingLeft = UDim.new(0, 6) }, silentOpts)

makeStepper(silentOpts, "Accuracy", 90, 10, 100, 5, function(v) return v .. "%" end,
    function(v) silentAccuracy = v end)

local function bindCollapse(toggle, panel)
    local function sync()
        if toggle.get() then
            panel.Visible = true
            pcall(function() panel.AutomaticSize = Enum.AutomaticSize.Y end)
        else
            panel.Visible = false
            pcall(function() panel.AutomaticSize = Enum.AutomaticSize.None end)
            panel.Size = UDim2.new(1, 0, 0, 0)
        end
    end
    table.insert(toggle.shared.renders, sync)
    sync()
end

bindCollapse(aimbotToggle, aimOpts)
bindCollapse(silentToggle, silentOpts)

--=====================================================================
-- GAME FEATURE LIBRARY
--=====================================================================
local function fireNamed(pattern, ...)
    for _, d in ipairs(RS:GetDescendants()) do
        if d:IsA("RemoteEvent") and d.Name:lower():find(pattern, 1, true) then
            pcall(function() d:FireServer(...) end)
        end
    end
end

local function teleportTo(part, up)
    local h = hrp()
    if h and part then
        pcall(function() h.CFrame = CFrame.new(part.Position + Vector3.new(0, up or 4, 0)) end)
    end
end

local function healthESP(parent, text)
    return gToggle(parent, text, function()
        local guis, fills = {}, {}
        return RunS.Heartbeat:Connect(function()
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LP and p.Character then
                    local head, hum = headOf(p), humOf(p)
                    if head and hum then
                        local g = guis[p]
                        if not g then
                            g = new("BillboardGui", {
                                Adornee = head, Size = UDim2.new(0, 80, 0, 26),
                                StudsOffset = Vector3.new(0, 2.9, 0), AlwaysOnTop = true
                            }, head)
                            local bar = new("Frame", {
                                Size = UDim2.new(1, 0, 0, 5),
                                Position = UDim2.new(0, 0, 0, 16),
                                BackgroundColor3 = Color3.fromRGB(40, 40, 48),
                                BorderSizePixel = 0
                            }, g)
                            corner(bar, 2)
                            local fill = new("Frame", {
                                Size = UDim2.new(1, 0, 1, 0),
                                BackgroundColor3 = Color3.fromRGB(80, 220, 120),
                                BorderSizePixel = 0
                            }, bar)
                            corner(fill, 2)
                            new("TextLabel", {
                                Size = UDim2.new(1, 0, 0, 14), BackgroundTransparency = 1,
                                Font = Enum.Font.GothamBold, TextSize = 11,
                                TextColor3 = Color3.fromRGB(255, 255, 255),
                                TextStrokeTransparency = 0.4, Text = ""
                            }, g)
                            guis[p] = g
                            fills[p] = fill
                        end
                        local fill = fills[p]
                        local ratio = math.clamp(hum.Health / math.max(hum.MaxHealth, 1), 0, 1)
                        if fill then
                            fill.Size = UDim2.new(ratio, 0, 1, 0)
                            fill.BackgroundColor3 = Color3.fromRGB(
                                math.floor(255 * (1 - ratio)), math.floor(255 * ratio), 60)
                        end
                        local lbl = g:FindFirstChildOfClass("TextLabel")
                        if lbl then lbl.Text = math.floor(hum.Health) .. " HP" end
                    end
                end
            end
            for p, g in pairs(guis) do
                if not p.Parent or not p.Character then
                    pcall(function() g:Destroy() end)
                    guis[p] = nil
                    fills[p] = nil
                end
            end
        end)
    end)
end

local function roleESP(parent, text, roleName, color, getRole)
    local objs = {}
    local conn
    local t = makeToggle(parent, text, false, function(on)
        if on then
            conn = RunS.Heartbeat:Connect(function()
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LP then
                        local head = headOf(p)
                        if head and getRole(p) == roleName then
                            if not objs[p] then
                                local bg = new("BillboardGui", {
                                    Adornee = head, Size = UDim2.new(0, 90, 0, 18),
                                    StudsOffset = Vector3.new(0, 2.6, 0), AlwaysOnTop = true
                                }, head)
                                new("TextLabel", {
                                    Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
                                    Font = Enum.Font.GothamBold, Text = roleName,
                                    TextSize = 11, TextColor3 = color, TextStrokeTransparency = 0.4
                                }, bg)
                                objs[p] = bg
                            end
                        elseif objs[p] then
                            pcall(function() objs[p]:Destroy() end)
                            objs[p] = nil
                        end
                    end
                end
            end)
        else
            if conn then conn:Disconnect(); conn = nil end
            for _, o in pairs(objs) do pcall(function() o:Destroy() end) end
            objs = {}
        end
    end)
    table.insert(gameCleanup, function() if t.get() then t.set(false) end end)
    return t
end

--=====================================================================
-- GAME DEFINITIONS
--=====================================================================
local SUPPORTED = {
    {
        id = 189707, name = "Natural Disaster Survival",
        build = function(page)
            gToggle(page, "No Fall Damage", function()
                local conn
                local function bind()
                    local hum = humOf()
                    if not hum then return end
                    conn = hum.StateChanged:Connect(function(_, newState)
                        if newState == Enum.HumanoidStateType.FallingDown then
                            task.wait(0.12)
                            if hum.Parent then
                                hum:ChangeState(Enum.HumanoidStateType.Running)
                                hum.Health = hum.MaxHealth
                            end
                        end
                    end)
                end
                bind()
                local added = LP.CharacterAdded:Connect(function()
                    task.wait(1)
                    if conn then conn:Disconnect() end
                    bind()
                end)
                return { Disconnect = function()
                    if conn then conn:Disconnect() end
                    added:Disconnect()
                end }
            end)

            gToggle(page, "No Weather GUI FX", function()
                local offed = {}
                local conn = RunS.Heartbeat:Connect(function()
                    local pg = LP:FindFirstChild("PlayerGui")
                    if pg then
                        for _, g in ipairs(pg:GetChildren()) do
                            if g:IsA("ScreenGui") and g.Name:lower():find("weather", 1, true) then
                                g.Enabled = false
                            end
                        end
                    end
                    for _, e in ipairs(Lighting:GetChildren()) do
                        if (e:IsA("BlurEffect") or e:IsA("ColorCorrectionEffect")
                            or e:IsA("DepthOfFieldEffect") or e:IsA("SunRaysEffect")) and e.Enabled then
                            e.Enabled = false
                            offed[e] = true
                        end
                    end
                end)
                return { Disconnect = function()
                    conn:Disconnect()
                    for e in pairs(offed) do pcall(function() e.Enabled = true end) end
                end }
            end)

            gToggle(page, "God Mode", function()
                return RunS.Heartbeat:Connect(function()
                    local hum = humOf()
                    if hum and hum.Health > 0 then
                        hum.Health = hum.MaxHealth
                        pcall(function()
                            hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                        end)
                    end
                end)
            end)

            layoutSeq += 1
            local card = new("Frame", {
                Size = UDim2.new(1, -10, 0, 44),
                BackgroundColor3 = Color3.fromRGB(24, 24, 31),
                BorderSizePixel = 0,
                LayoutOrder = layoutSeq
            }, page)
            corner(card, 6)
            new("TextLabel", {
                Size = UDim2.new(1, -20, 0, 16), Position = UDim2.new(0, 10, 0, 6),
                BackgroundTransparency = 1, Font = Enum.Font.GothamBold,
                Text = "NEXT DISASTER", TextSize = 9,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextColor3 = Color3.fromRGB(110, 110, 130)
            }, card)
            local dv = new("TextLabel", {
                Size = UDim2.new(1, -20, 0, 18), Position = UDim2.new(0, 10, 0, 22),
                BackgroundTransparency = 1, Font = Enum.Font.Code,
                Text = "detecting...", TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextColor3 = Color3.fromRGB(220, 220, 235)
            }, card)
            yOff += 48

            local function scan()
                local found
                for _, root in ipairs({ RS, workspace }) do
                    for _, d in ipairs(root:GetDescendants()) do
                        if d:IsA("StringValue") and d.Name:lower():find("disaster", 1, true)
                            and d.Value ~= "" then
                            found = d.Value
                            break
                        end
                    end
                    if found then break end
                end
                dv.Text = found or "none active"
            end
            local scanConn = RunS.Heartbeat:Connect(function() pcall(scan) end)
            table.insert(gameCleanup, function() scanConn:Disconnect() end)
        end
    },

    {
        name = "RIVALS",
        build = function(page)
            makeButton(page, "Unlock All Skins", function()
                local names = {}
                for _, d in ipairs(RS:GetDescendants()) do
                    local n = d.Name:lower()
                    if (d:IsA("StringValue") or d:IsA("ModuleScript"))
                        and (n:find("skin") or n:find("wrap") or n:find("charm")) then
                        table.insert(names, d.Name)
                    end
                end
                task.spawn(function()
                    for _, n in ipairs(names) do
                        fireNamed("equip", n)
                        fireNamed("skin", n)
                        task.wait(0.03)
                    end
                end)
            end)

            gToggle(page, "Aimbot (optimised)", function()
                aimFov = 70
                aimSmooth = 0.45
                aimReact = 0.05
                if not aimbotOn then aimbotToggle.set(true) end
                return { Disconnect = function() aimbotToggle.set(false) end }
            end)

            gToggle(page, "Silent Aim (optimised)", function()
                silentAccuracy = 100
                if not silentOn then silentToggle.set(true) end
                return { Disconnect = function() silentToggle.set(false) end }
            end)

            local fireRate = 12
            local fireConn
            gToggle(page, "Auto Fire", function()
                fireConn = RunS.Heartbeat:Connect(function()
                    local c = LP.Character
                    local tool = c and c:FindFirstChildOfClass("Tool")
                    if tool then pcall(function() tool:Activate() end) end
                end)
                return { Disconnect = function()
                    if fireConn then fireConn:Disconnect() end
                end }
            end)
            makeStepper(page, "Fire Rate", fireRate, 1, 60, 1, function(v)
                return v .. "/s"
            end, function(v) fireRate = v end)

            healthESP(page, "Health ESP")
        end
    },

    {
        name = "Brookhaven",
        build = function(page)
            gToggle(page, "Rainbow Character", function()
                return RunS.Heartbeat:Connect(function()
                    local c = LP.Character
                    if not c then return end
                    for _, d in ipairs(c:GetDescendants()) do
                        if d:IsA("BasePart") then pcall(function() d.Color = rainbow() end) end
                    end
                end)
            end)

            gToggle(page, "Big Character", function()
                local c = LP.Character
                if c then pcall(function() c:ScaleTo(1.9) end) end
                return { Disconnect = function()
                    local cc = LP.Character
                    if cc then pcall(function() cc:ScaleTo(1) end) end
                end }
            end)

            gToggle(page, "Rainbow Name", function()
                return RunS.Heartbeat:Connect(function()
                    local c = LP.Character
                    if not c then return end
                    for _, d in ipairs(c:GetDescendants()) do
                        if d:IsA("BillboardGui") then
                            local lbl = d:FindFirstChildOfClass("TextLabel")
                            if lbl then pcall(function() lbl.TextColor3 = rainbow() end) end
                        end
                    end
                end)
            end)

            gToggle(page, "Rainbow Bio", function()
                local bio
                local function find()
                    for _, d in ipairs(LP:GetDescendants()) do
                        if d:IsA("StringValue") and d.Name:lower():find("bio") then bio = d; return end
                    end
                end
                find()
                local added = LP.ChildAdded:Connect(function()
                    task.wait(0.3)
                    if not bio then find() end
                end)
                return { Disconnect = function()
                    added:Disconnect()
                    if bio then pcall(function() bio.Value = "" end) end
                end }
            end)

            makeButton(page, "Bring All Cars", function()
                local h = hrp()
                if not h then return end
                local i = 0
                for _, d in ipairs(workspace:GetDescendants()) do
                    if d:IsA("VehicleSeat") then
                        local model = d:FindFirstAncestorOfClass("Model")
                        if model and model.PrimaryPart then
                            i += 1
                            local a = i * 0.9
                            pcall(function()
                                model:PivotTo(h.CFrame * CFrame.new(math.cos(a) * 12, 2, math.sin(a) * 12))
                            end)
                        end
                    end
                end
            end)

            makeButton(page, "Unanchor All Parts", function()
                for _, d in ipairs(workspace:GetDescendants()) do
                    if d:IsA("BasePart") and d.Anchored and d.Name ~= "HumanoidRootPart" then
                        pcall(function() d.Anchored = false end)
                    end
                end
            end)
        end
    },

    {
        name = "Timebomb Anklebreak!",
        build = function(page)
            makeButton(page, "Give Player Bomb", function()
                fireNamed("bomb")
                fireNamed("give")
            end)

            gToggle(page, "Auto Juke", function()
                local dir = 1
                local acc = 0
                return RunS.Heartbeat:Connect(function(dt)
                    acc += dt
                    local hum = humOf()
                    if not hum then return end
                    if acc >= 0.22 then
                        acc = 0
                        dir = -dir
                    end
                    local cam = workspace.CurrentCamera
                    if cam then hum:Move(cam.CFrame.RightVector * dir, false) end
                end)
            end)

            makeButton(page, "Raise", function()
                local h = hrp()
                if not h then return end
                local plat = new("Part", {
                    Size = Vector3.new(7, 0.5, 7),
                    Anchored = true,
                    CanCollide = true,
                    Material = Enum.Material.Neon,
                    Color = ACCENT,
                    CFrame = h.CFrame * CFrame.new(0, -3.2, 0),
                    Parent = workspace
                })
                task.spawn(function()
                    for _ = 1, 70 do
                        if not plat.Parent then break end
                        plat.CFrame = plat.CFrame * CFrame.new(0, 1.1, 0)
                        local hh = hrp()
                        if hh then pcall(function() hh.CFrame = plat.CFrame * CFrame.new(0, 3, 0) end) end
                        task.wait(0.04)
                    end
                    task.wait(4)
                    pcall(function() plat:Destroy() end)
                end)
            end)
        end
    },

    {
        id = 142823291, name = "Murder Mystery 2",
        build = function(page)
            local function getRole(p)
                for _, d in ipairs(p:GetDescendants()) do
                    if d:IsA("StringValue") and d.Name:lower():find("role") then
                        return d.Value
                    end
                end
                local function has(n)
                    local bp = p:FindFirstChild("Backpack")
                    if bp and bp:FindFirstChild(n, true) then return true end
                    local c = p.Character
                    if c and c:FindFirstChild(n, true) then return true end
                    return false
                end
                if has("Knife") then return "Murderer" end
                if has("Gun") then return "Sheriff" end
                return "Innocent"
            end

            roleESP(page, "Murderer ESP", "Murderer", Color3.fromRGB(255, 80, 80), getRole)
            roleESP(page, "Sheriff ESP", "Sheriff", Color3.fromRGB(80, 160, 255), getRole)
            roleESP(page, "Innocent ESP", "Innocent", Color3.fromRGB(90, 230, 130), getRole)

            local gunObjs = {}
            gToggle(page, "Dropped Gun ESP", function()
                return RunS.Heartbeat:Connect(function()
                    for _, d in ipairs(workspace:GetDescendants()) do
                        if d:IsA("Model") and d.Name:lower():find("gun")
                            and not d:FindFirstAncestorOfClass("Tool") and d.PrimaryPart
                            and not gunObjs[d] then
                            local bg = new("BillboardGui", {
                                Adornee = d.PrimaryPart, Size = UDim2.new(0, 90, 0, 18),
                                StudsOffset = Vector3.new(0, 2, 0), AlwaysOnTop = true
                            }, d.PrimaryPart)
                            new("TextLabel", {
                                Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
                                Font = Enum.Font.GothamBold, Text = "GUN",
                                TextSize = 11, TextColor3 = Color3.fromRGB(255, 210, 60),
                                TextStrokeTransparency = 0.3
                            }, bg)
                            gunObjs[d] = bg
                        end
                    end
                    for m, g in pairs(gunObjs) do
                        if not m.Parent then
                            pcall(function() g:Destroy() end)
                            gunObjs[m] = nil
                        end
                    end
                end)
            end)

            local function flingRole(role)
                return RunS.Heartbeat:Connect(function()
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LP and getRole(p) == role then
                            local ph = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
                            if ph then
                                pcall(function()
                                    ph.AssemblyAngularVelocity = Vector3.new(900, 900, 900)
                                    ph.AssemblyLinearVelocity = Vector3.new(0, 250, 0)
                                end)
                            end
                        end
                    end
                end)
            end

            gToggle(page, "Fling Murderer", function() return flingRole("Murderer") end)
            gToggle(page, "Fling Sheriff", function() return flingRole("Sheriff") end)

            gToggle(page, "Auto Pick Up Gun", function()
                return RunS.Heartbeat:Connect(function()
                    for _, d in ipairs(workspace:GetDescendants()) do
                        if d:IsA("Model") and d.Name:lower():find("gun")
                            and not d:FindFirstAncestorOfClass("Tool") and d.PrimaryPart then
                            teleportTo(d.PrimaryPart, 1)
                            break
                        end
                    end
                end)
            end)
        end
    },

    {
        name = "Fling Things and People",
        build = function(page)
            local itemName = ""
            local flingPower, throwPower = 500, 500

            makeTextInput(page, "Item Name", "", function(v) itemName = v end)

            makeButton(page, "Spawn Any Item", function()
                if itemName == "" then return end
                fireNamed("spawn", itemName, flingPower)
                fireNamed("place", itemName, flingPower)
            end)

            makeButton(page, "Bring Any Item", function()
                if itemName == "" then return end
                fireNamed("bring", itemName)
                fireNamed("grab", itemName)
            end)

            makeStepper(page, "Fling Power", flingPower, 50, 5000, 50, function(v)
                return tostring(v)
            end, function(v) flingPower = v end)

            makeStepper(page, "Throw Power", throwPower, 50, 5000, 50, function(v)
                return tostring(v)
            end, function(v) throwPower = v end)
        end
    }
}

local function detectGame()
    local placeId = game.PlaceId
    local gname = game.Name
    pcall(function()
        local ok, info2 = pcall(function() return MPS:GetProductInfo(placeId) end)
        if ok and info2 and info2.Name then gname = info2.Name end
    end)
    local lower = gname:lower()
    for _, g in ipairs(SUPPORTED) do
        if (g.id and g.id == placeId) or lower:find(g.name:lower(), 1, true) then
            return g, gname
        end
    end
    return nil, gname
end

local function buildGamePage()
    for _, fn in ipairs(gameCleanup) do pcall(fn) end
    gameCleanup = {}

    for _, c in ipairs(gamePage:GetChildren()) do c:Destroy() end
    yOff = 0

    local game, gname = detectGame()

    local head = new("Frame", {
        Size = UDim2.new(1, -10, 0, 96),
        BackgroundColor3 = Color3.fromRGB(24, 24, 31),
        BorderSizePixel = 0
    }, gamePage)
    corner(head, 6)
    stroke(head, Color3.fromRGB(45, 45, 58), 1)
    yOff += 100

    new("TextLabel", {
        Size = UDim2.new(1, -20, 0, 20),
        Position = UDim2.new(0, 10, 0, 8),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        Text = "Welcome, " .. LP.DisplayName .. "!",
        TextSize = 13, TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextColor3 = Color3.fromRGB(245, 245, 255)
    }, head)

    new("TextLabel", {
        Size = UDim2.new(1, -20, 0, 36),
        Position = UDim2.new(0, 10, 0, 30),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        Text = "Your in game: " .. gname,
        TextSize = 11, TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextColor3 = Color3.fromRGB(190, 190, 210)
    }, head)

    new("TextLabel", {
        Size = UDim2.new(1, -20, 0, 20),
        Position = UDim2.new(0, 10, 0, 70),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        Text = "Which is " .. (game and "supported" or "not supported") .. "!",
        TextSize = 11, TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextColor3 = game and Color3.fromRGB(90, 220, 130) or Color3.fromRGB(230, 110, 110)
    }, head)

    if game then
        sectionTitle(gamePage, game.name .. " Menu")
        local ok, err = pcall(game.build, gamePage)
        if not ok then
            local note = new("Frame", {
                Size = UDim2.new(1, -10, 0, 40),
                BackgroundColor3 = Color3.fromRGB(40, 24, 24),
                BorderSizePixel = 0
            }, gamePage)
            corner(note, 6)
            yOff += 44
            new("TextLabel", {
                Size = UDim2.new(1, -20, 1, 0), Position = UDim2.new(0, 10, 0, 0),
                BackgroundTransparency = 1, Font = Enum.Font.Gotham,
                Text = "Build error: " .. tostring(err), TextSize = 10, TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextColor3 = Color3.fromRGB(255, 150, 150)
            }, note)
        end
    else
        sectionTitle(gamePage, "Game Menu")
        local note = new("Frame", {
            Size = UDim2.new(1, -10, 0, 44),
            BackgroundColor3 = Color3.fromRGB(24, 24, 31),
            BorderSizePixel = 0
        }, gamePage)
        corner(note, 6)
        yOff += 48
        new("TextLabel", {
            Size = UDim2.new(1, -20, 1, 0), Position = UDim2.new(0, 10, 0, 0),
            BackgroundTransparency = 1, Font = Enum.Font.Gotham,
            Text = "No game-specific features yet. Try the Universal tab.",
            TextSize = 11, TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = Color3.fromRGB(160, 160, 180)
        }, note)
    end

    local refresh = makeButton(gamePage, "Refresh Detection", buildGamePage)
    refresh.BackgroundColor3 = Color3.fromRGB(30, 26, 42)

    pcall(function() gamePage.CanvasSize = UDim2.new(0, 0, 0, yOff + 10) end)
end

buildGamePage()

--=====================================================================
-- MINIMIZE / RESTORE
--=====================================================================
local animating = false

local function minimize()
    if animating or not main.Visible then return end
    animating = true
    flyPad.Visible = false

    local saved = main.Position
    local bs = bubble.AbsolutePosition

    local out = TweenInfo.new(0.24, Enum.EasingStyle.Back, Enum.EasingDirection.In)
    TS:Create(uiScale, out, { Scale = 0.05 }):Play()
    TS:Create(main, out, { Position = UDim2.fromOffset(bs.X, bs.Y) }):Play()
    TS:Create(main, TweenInfo.new(0.24), { BackgroundTransparency = 0.6 }):Play()

    task.wait(0.25)
    main.Visible = false
    main.BackgroundTransparency = 0
    main.Position = saved
    uiScale.Scale = scaleValue

    bubble.Size = UDim2.fromOffset(0, 0)
    bubble.Visible = true
    TS:Create(bubble, TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        { Size = UDim2.fromOffset(44, 44) }):Play()
    animating = false
end

local function restore()
    if animating or main.Visible then return end
    animating = true

    local saved = main.Position
    local bs = bubble.AbsolutePosition

    TS:Create(bubble, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        { Size = UDim2.fromOffset(0, 0) }):Play()
    task.wait(0.14)
    bubble.Visible = false

    main.Position = UDim2.fromOffset(bs.X, bs.Y)
    uiScale.Scale = 0.05
    main.Visible = true

    local back = TweenInfo.new(0.34, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    TS:Create(uiScale, back, { Scale = scaleValue }):Play()
    TS:Create(main, back, { Position = saved }):Play()

    task.wait(0.35)
    if flyConn and UIS.TouchEnabled then flyPad.Visible = true end
    animating = false
end

minBtn.MouseButton1Click:Connect(minimize)
bubbleBtn.MouseButton1Click:Connect(function()
    if bMoved then bMoved = false; return end
    restore()
end)

--=====================================================================
-- FINISH
--=====================================================================
for n, pg in pairs(pages) do pg.Visible = (n == "Settings") end
tabButtons[1].BackgroundColor3 = ACCENT
tabButtons[1].BackgroundTransparency = 0
tabButtons[1].TextColor3 = Color3.fromRGB(255, 255, 255)
registerAccent(tabButtons[1], "BackgroundColor3")

local function unload()
    stopFly()
    stopAimbot()
    for _, fn in ipairs(gameCleanup) do pcall(fn) end
    if spinConn then spinConn:Disconnect() end
    if floatBP then floatBP:Destroy() end
    if fovCircle then pcall(function() fovCircle:Remove() end) end
    wipeESP()
    loadGui:Destroy()
end

closeBtn.MouseButton1Click:Connect(unload)

UIS.InputBegan:Connect(function(i, gp)
    if gp then return end
    if i.KeyCode == Enum.KeyCode.RightShift then
        if main.Visible then minimize() else restore() end
    end
end)

LP.CharacterAdded:Connect(function(c)
    task.wait(1)
    local hum = c:FindFirstChildOfClass("Humanoid")
    if hum and jumpBoostOn then
        hum.UseJumpPower = true
        hum.JumpPower = jumpPowerValue
    end
end)

print("[Nexus] loaded v2.2")

end -- boot

local ok, err = xpcall(boot, function(e)
    return tostring(e) .. "\n" .. debug.traceback()
end)

if not ok then
    print("[Nexus] FAILED:\n" .. tostring(err))
    local g = Instance.new("ScreenGui")
    g.IgnoreGuiInset = true
    g.DisplayOrder = 9999
    g.Parent = (gethui and gethui()) or game:GetService("CoreGui")
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -40, 0, 200)
    f.Position = UDim2.new(0, 20, 0, 60)
    f.BackgroundColor3 = Color3.fromRGB(20, 12, 12)
    f.Parent = g
    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, -20, 1, -20)
    t.Position = UDim2.new(0, 10, 0, 10)
    t.BackgroundTransparency = 1
    t.Font = Enum.Font.Code
    t.TextSize = 11
    t.TextWrapped = true
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.TextYAlignment = Enum.TextYAlignment.Top
    t.TextColor3 = Color3.fromRGB(255, 140, 140)
    t.Text = "NEXUS ERROR\n\n" .. tostring(err)
    t.Parent = f
end
