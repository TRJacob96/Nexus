local url = "https://raw.githubusercontent.com/USER/REPO/main/nexus.lua?v=1"

local g = Instance.new("ScreenGui")
g.IgnoreGuiInset = true
g.DisplayOrder = 99999
g.Parent = (gethui and gethui()) or game:GetService("CoreGui")

local f = Instance.new("Frame")
f.Size = UDim2.new(1, -40, 0, 90)
f.Position = UDim2.new(0, 20, 0, 60)
f.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
f.BorderSizePixel = 0
f.Parent = g

local t = Instance.new("TextLabel")
t.Size = UDim2.new(1, -20, 1, -20)
t.Position = UDim2.new(0, 10, 0, 10)
t.BackgroundTransparency = 1
t.Font = Enum.Font.Code
t.TextSize = 12
t.TextWrapped = true
t.TextXAlignment = Enum.TextXAlignment.Left
t.TextYAlignment = Enum.TextYAlignment.Top
t.TextColor3 = Color3.fromRGB(220, 220, 235)
t.Text = "fetching..."
t.Parent = f

local function say(msg, bad)
    t.Text = msg
    t.TextColor3 = bad and Color3.fromRGB(255, 120, 120) or Color3.fromRGB(220, 220, 235)
    print("[loader] " .. msg)
end

local ok, res = pcall(function() return game:HttpGet(url) end)
if not ok then
    say("HTTP ERROR\n" .. tostring(res), true)
    return
end

if type(res) ~= "string" or #res < 200 then
    say("Empty or tiny response (" .. tostring(res and #res) .. " bytes)", true)
    return
end

if res:sub(1, 1) == "<" then
    say("GOT HTML, NOT LUA - the URL is wrong.\nFirst line: " .. res:sub(1, 120), true)
    return
end

say("compiling...")
local fn, cerr = loadstring(res)
if not fn then
    say("COMPILE ERROR\n" .. tostring(cerr), true)
    return
end

say("running...")
local ok2, rerr = pcall(fn)
if not ok2 then
    say("RUNTIME ERROR\n" .. tostring(rerr), true)
    return
end

say("done - menu should be on screen")
task.delay(2, function() if g then g:Destroy() end end)
