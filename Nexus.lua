--=====================================================================
--  NEXUS  |  Script Hub
--  Credits: TRJacob, unknownbyz, Ultexxx, stackmakerr
--  Delta. RightShift = hide/show.
--=====================================================================

local Players  = game:GetService("Players")
local UIS      = game:GetService("UserInputService")
local RunS     = game:GetService("RunService")
local TS       = game:GetService("TweenService")
local MPS      = game:GetService("MarketplaceService")
local RS       = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local LP       = Players.LocalPlayer

--=====================================================================
-- parent
--=====================================================================
local PARENT
do
    local ok, h = pcall(function()
        if type(gethui) == "function" then return gethui() end
    end)
    if ok and h then PARENT = h end
    if not PARENT then
        local ok2, pg = pcall(function() return LP:FindFirstChildOfClass("PlayerGui") end)
        if ok2 then PARENT = pg end
    end
    if not PARENT then
        local ok3, pg = pcall(function() return LP:WaitForChild("PlayerGui", 10) end)
        if ok3 then PARENT = pg end
    end
    if not PARENT then
        local ok4, cg = pcall(function() return game:GetService("CoreGui") end)
        if ok4 then PARENT = cg end
    end
    if not PARENT then PARENT = LP end
end

pcall(function()
    for _, v in ipairs(PARENT:GetChildren()) do
        if v.Name == "NexusUI" or v.Name == "NexusError" then v:Destroy() end
    end
end)

--=====================================================================
-- helpers
--=====================================================================
local function new(class, props, parent)
    local o = Instance.new(class)
    local late = nil
    if props then
        for k, v in pairs(props) do
            if k == "Parent" then late = v else pcall(function() o[k] = v end) end
        end
    end
    if late then pcall(function() o.Parent = late end) end
    if parent then pcall(function() o.Parent = parent end) end
    return o
end

local function toHSV(c)
    local r, g, b = c.R, c.G, c.B
    local mx, mn = math.max(r, g, b), math.min(r, g, b)
    local d = mx - mn
    local h, s, v = 0, 0, mx
    if mx > 0 then s = d / mx end
    if d > 0 then
        if mx == r then h = ((g - b) / d) % 6
        elseif mx == g then h = ((b - r) / d) + 2
        else h = ((r - g) / d) + 4 end
        h = h / 6
    end
    return h, s, v
end

local function shiftHue(c, amt)
    local h, s, v = toHSV(c)
    return Color3.fromHSV((h + amt) % 1, s, v)
end

local UP  = Vector3.new(0, 1, 0)
local ZERO = Vector3.new(0, 0, 0)

local STEP = 0
local statusLbl = nil
local function ck(name)
    STEP = STEP + 1
    pcall(function() print(("[Nexus] %d %s"):format(STEP, name)) end)
    if statusLbl then pcall(function() statusLbl.Text = "| boot " .. STEP end) end
end

local function showError(msg)
    pcall(function()
        local g = Instance.new("ScreenGui")
        g.Name = "NexusError"
        g.ResetOnSpawn = false
        g.DisplayOrder = 99999
        g.IgnoreGuiInset = true
        g.Parent = PARENT
        local f = Instance.new("Frame")
        f.Size = UDim2.new(1, -20, 0, 260)
        f.Position = UDim2.new(0, 10, 0, 10)
        f.BackgroundColor3 = Color3.fromRGB(22, 12, 12)
        f.BorderSizePixel = 0
        f.Parent = g
        local c = Instance.new("UICorner")
        c.CornerRadius = UDim.new(0, 8)
        c.Parent = f
        local t = Instance.new("TextLabel")
        t.Size = UDim2.new(1, -16, 1, -16)
        t.Position = UDim2.new(0, 8, 0, 8)
        t.BackgroundTransparency = 1
        t.Font = Enum.Font.Code
        t.TextSize = 10
        t.TextWrapped = true
        t.TextXAlignment = Enum.TextXAlignment.Left
        t.TextYAlignment = Enum.TextYAlignment.Top
        t.TextColor3 = Color3.fromRGB(255, 170, 170)
        t.Text = "NEXUS ERROR (step " .. tostring(STEP) .. ")\n\n" .. tostring(msg)
        t.Parent = f
    end)
end

--=====================================================================
-- guarded body
--=====================================================================
local okRun, errRun = xpcall(function()

local ACCENT = Color3.fromRGB(125, 70, 255)
local accentEls, gradients = {}, {}
local activeTab = nil

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

local function registerAccent(obj, prop)
    table.insert(accentEls, { obj = obj, prop = prop })
end

local function applyAccent(c)
    ACCENT = c
    local second = shiftHue(c, 0.07)
    for _, e in ipairs(accentEls) do pcall(function() e.obj[e.prop] = ACCENT end) end
    for _, g in ipairs(gradients) do
        pcall(function() g.Color = ColorSequence.new(ACCENT, second) end)
    end
    if activeTab then pcall(function() activeTab.BackgroundColor3 = ACCENT end) end
end

--=====================================================================
-- gui + window (first, before any yield)
--=====================================================================
local loadGui = new("ScreenGui", {
    Name = "NexusUI",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 999,
    Enabled = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, PARENT)
ck("screengui")

local main = new("Frame", {
    Size = UDim2.new(0, 520, 0, 380),
    Position = UDim2.new(0.5, -260, 0.5, -190),
    BackgroundColor3 = Color3.fromRGB(18, 18, 24),
    BorderSizePixel = 0,
    Visible = true
}, loadGui)
corner(main, 10)
stroke(main, Color3.fromRGB(45, 45, 58), 1)
ck("main")

local uiScale = new("UIScale", { Scale = 1 }, main)

local topbar = new("Frame", {
    Size = UDim2.new(1, 0, 0, 40),
    BackgroundColor3 = ACCENT,
    BorderSizePixel = 0
}, main)
corner(topbar, 10)
new("Frame", {
    Size = UDim2.new(1, 0, 0, 14),
    Position = UDim2.new(0, 0, 1, -14),
    BackgroundColor3 = ACCENT,
    BorderSizePixel = 0
}, topbar)
table.insert(gradients, new("UIGradient", {
    Color = ColorSequence.new(ACCENT, shiftHue(ACCENT, 0.07))
}, topbar))

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

statusLbl = new("TextLabel", {
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
ck("titlebar")

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

--=====================================================================
-- loader overlay
--=====================================================================
local loader = new("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = Color3.fromRGB(8, 8, 12),
    BorderSizePixel = 0,
    ZIndex = 50
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

pcall(function()
    TS:Create(lBar, TweenInfo.new(1.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        { Size = UDim2.fromScale(1, 1) }):Play()
end)

task.spawn(function()
    task.wait(1.7)
    pcall(function() TS:Create(loader, TweenInfo.new(0.25), { BackgroundTransparency = 1 }):Play() end)
    for _, d in ipairs(loader:GetDescendants()) do
        if d:IsA("TextLabel") then pcall(function() d.TextTransparency = 1 end)
        elseif d:IsA("Frame") then pcall(function() d.BackgroundTransparency = 1 end) end
    end
    task.wait(0.3)
    pcall(function() loader:Destroy() end)
end)
ck("loader")

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
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Visible = false
    }, pageHolder)
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
            pcall(function()
                TS:Create(tb, TweenInfo.new(0.15), {
                    BackgroundColor3 = Color3.fromRGB(28, 28, 36),
                    BackgroundTransparency = 0.4,
                    TextColor3 = Color3.fromRGB(170, 170, 190)
                }):Play()
            end)
        end
        pcall(function()
            TS:Create(b, TweenInfo.new(0.15), {
                BackgroundColor3 = ACCENT,
                BackgroundTransparency = 0,
                TextColor3 = Color3.fromRGB(255, 255, 255)
            }):Play()
        end)
        activeTab = b
    end)
    return b
end
ck("layout")

--=====================================================================
-- widgets
--=====================================================================
local yOff = 0
local layoutSeq = 0

local function row(parent)
    layoutSeq = layoutSeq + 1
    local r = new("Frame", {
        Size = UDim2.new(1, -10, 0, 30),
        Position = UDim2.new(0, 0, 0, yOff),
        BackgroundColor3 = Color3.fromRGB(24, 24, 31),
        BorderSizePixel = 0,
        LayoutOrder = layoutSeq
    }, parent)
    corner(r, 6)
    yOff = yOff + 34
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
        pcall(function()
            TS:Create(track, TweenInfo.new(0.15), {
                BackgroundColor3 = shared.v and ACCENT or Color3.fromRGB(45, 45, 58)
            }):Play()
        end)
        pcall(function()
            TS:Create(knob, TweenInfo.new(0.15), {
                Position = shared.v and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
            }):Play()
        end)
    end

    local function set(v)
        shared.v = v
        for _, rfn in ipairs(shared.renders) do pcall(rfn) end
        if shared.action then pcall(shared.action, v) end
    end

    table.insert(shared.renders, render)

    local btn = new("TextButton", {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Text = ""
    }, r)
    btn.MouseButton1Click:Connect(function() set(not shared.v) end)

    render()
    return { set = set, get = function() return shared.v end, shared = shared }
end

local function makeLoopToggle(parent, text, startFn, stopFn, shared)
    local conn
    return makeToggle(parent, text, false, function(on)
        if on then
            local ok, c = pcall(function() return startFn and startFn() end)
            if ok then conn = c end
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

local function makeStepper(parent, text, value, mn, mx, step, fmt, callback)
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
        local steps = math.floor((v - mn) / step + 0.5)
        current = math.clamp(mn + (steps * step), mn, mx)
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
        pcall(function() TS:Create(b, TweenInfo.new(0.12), { BackgroundColor3 = ACCENT }):Play() end)
    end)
    b.MouseLeave:Connect(function()
        pcall(function()
            TS:Create(b, TweenInfo.new(0.12), { BackgroundColor3 = Color3.fromRGB(34, 34, 44) }):Play()
        end)
    end)
    b.MouseButton1Click:Connect(function() pcall(callback) end)
    return b
end

local function sectionTitle(parent, text)
    layoutSeq = layoutSeq + 1
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
    yOff = yOff + 24
    return t
end

local function descText(parent, text, height)
    layoutSeq = layoutSeq + 1
    local d = new("Frame", {
        Size = UDim2.new(1, -10, 0, height),
        Position = UDim2.new(0, 0, 0, yOff),
        BackgroundColor3 = Color3.fromRGB(22, 22, 29),
        BorderSizePixel = 0,
        LayoutOrder = layoutSeq
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
    yOff = yOff + height + 4
    return d
end
ck("widgets")

--=====================================================================
-- state
--=====================================================================
local speedValue, jumpPowerValue, spinSpeedValue, flySpeedValue = 60, 80, 6, 60
local espOn, tracerOn, boxOn, nameOn, rgbOn = false, false, false, false, false
local flingIndex = 0
local jumpBoostOn = false
local gameCleanup = {}
local extraConns = {}

local function track(c)
    table.insert(extraConns, c)
    return c
end

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
    return Color3.fromHSV((os.clock() * 0.4) % 1, 1, 1)
end

local function gToggle(parent, text, startFn)
    local h
    local t = makeToggle(parent, text, false, function(on)
        if on then
            local ok, c = pcall(startFn)
            if ok then h = c end
        else
            if h then pcall(function() h:Disconnect() end); h = nil end
        end
    end)
    table.insert(gameCleanup, function() if t.get() then t.set(false) end end)
    return t
end

--=====================================================================
-- settings
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
    pcall(function() TS:Create(uiScale, TweenInfo.new(0.15), { Scale = scaleValue }):Play() end)
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
yOff = yOff + 66

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
yOff = yOff + 30

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
ck("settings")

--=====================================================================
-- page slots
--=====================================================================
yOff = 0
local gamePage = makePage("Game")
makeTab("Game")

yOff = 0
local uniPage = makePage("Universal")
makeTab("Universal")

local uniBody = new("Frame", {
    Size = UDim2.new(1, 0, 0, 0),
    BackgroundTransparency = 1,
    AutomaticSize = Enum.AutomaticSize.Y
}, uniPage)
new("UIListLayout", { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder }, uniBody)

--=====================================================================
-- movement
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
    if flyConn then pcall(function() flyConn:Disconnect() end); flyConn = nil end
    if flyBV then pcall(function() flyBV:Destroy() end); flyBV = nil end
    if flyBG then pcall(function() flyBG:Destroy() end); flyBG = nil end
    flyPad.Visible = false
end

local function startFly()
    local h = hrp()
    local hum = humOf()
    if not h then return end
    flyBV = new("BodyVelocity", { MaxForce = Vector3.new(1e5, 1e5, 1e5), Velocity = ZERO }, h)
    flyBG = new("BodyGyro", { MaxTorque = Vector3.new(1e5, 1e5, 1e5), P = 12000, D = 200 }, h)
    flyPad.Visible = UIS.TouchEnabled and main.Visible

    flyConn = RunS.RenderStepped:Connect(function()
        local cam = workspace.CurrentCamera
        if not cam or not h.Parent or not flyBV or not flyBG then return end
        local dir = ZERO
        if hum and hum.Parent then
            local md = hum.MoveDirection
            if md.Magnitude > 0 then
                local l3 = cam.CFrame:VectorToObjectSpace(md)
                dir = (cam.CFrame.RightVector * l3.X) + (cam.CFrame.LookVector * -l3.Z)
            end
            if hum.Jump or UIS:IsKeyDown(Enum.KeyCode.Space) or altUp then dir = dir + UP end
        end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) or UIS:IsKeyDown(Enum.KeyCode.LeftShift) or altDown then
            dir = dir - UP
        end
        pcall(function()
            flyBV.Velocity = (dir.Magnitude > 0 and dir.Unit or ZERO) * flySpeedValue
            flyBG.CFrame = cam.CFrame
        end)
    end)
end

sectionTitle(movePage, "Flight")
makeToggle(movePage, "Fly", false, function(on)
    if on then startFly() else stopFly() end
end)
makeTextBox(movePage, "Fly Speed", flySpeedValue, function(n)
    flySpeedValue = math.clamp(n, 5, 500)
end)

sectionTitle(movePage, "Motion")
makeToggle(movePage, "Spin", false, function(on)
    if spinConn then pcall(function() spinConn:Disconnect() end); spinConn = nil end
    if on then
        spinConn = RunS.Heartbeat:Connect(function(dt)
            local h = hrp()
            if h then
                pcall(function()
                    h.CFrame = h.CFrame * CFrame.Angles(0, math.rad(spinSpeedValue) * dt * 10, 0)
                end)
            end
        end)
    end
end)
makeTextBox(movePage, "Spin Speed", spinSpeedValue, function(n)
    spinSpeedValue = math.clamp(n, 1, 100)
end)

makeToggle(movePage, "Speed", false, function(on)
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

makeToggle(movePage, "Float", false, function(on)
    if floatBP then pcall(function() floatBP:Destroy() end); floatBP = nil end
    if on then
        local h = hrp()
        if h then
