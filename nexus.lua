repeat task.wait() until game.Players.LocalPlayer
local PG=game.Players.LocalPlayer:WaitForChild("PlayerGui")
local gui=Instance.new("ScreenGui",PG)
gui.Name="NexusUI"
gui.ResetOnSpawn=false
gui.IgnoreGuiInset=true
gui.DisplayOrder=999
print("[Nexus] A")
local mn=Instance.new("Frame",gui)
mn.Size=UDim2.new(0,520,0,380)
mn.Position=UDim2.new(0.5,-260,0.5,-190)
mn.BackgroundColor3=Color3.fromRGB(18,18,24)
mn.BorderSizePixel=0
print("[Nexus] B")
local U=game:GetService("UserInputService")
local R=game:GetService("RunService")
local L=game.Players.LocalPlayer
local A=Color3.fromRGB(125,70,255)
local function N(c,p,par)local o=Instance.new(c)if p then for k,v in pairs(p)do pcall(function()o[k]=v end)end end if par then o.Parent=par end return o end
local function cr(o,r)N("UICorner",{CornerRadius=UDim.new(0,r or 6)},o)end
local tp=N("Frame",{Size=UDim2.new(1,0,0,40),BackgroundColor3=A,BorderSizePixel=0},mn)cr(tp,10)
N("Frame",{Size=UDim2.new(1,0,0,14),Position=UDim2.new(0,0,1,-14),BackgroundColor3=A,BorderSizePixel=0},tp)
N("TextLabel",{Size=UDim2.new(0,200,1,0),Position=UDim2.new(0,14,0,0),BackgroundTransparency=1,Font=Enum.Font.GothamBold,Text="NEXUS",TextSize=17,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=Color3.fromRGB(255,255,255)},tp)
N("TextLabel",{Size=UDim2.new(0,140,1,0),Position=UDim2.new(0,84,0,0),BackgroundTransparency=1,Font=Enum.Font.Gotham,Text="| hub",TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=Color3.fromRGB(215,210,235)},tp)
local cB=N("TextButton",{Size=UDim2.new(0,28,0,28),Position=UDim2.new(1,-36,0,6),BackgroundColor3=Color3.fromRGB(20,20,28),BackgroundTransparency=0.35,BorderSizePixel=0,Font=Enum.Font.GothamBold,Text="X",TextSize=12,TextColor3=Color3.fromRGB(255,255,255)},tp)cr(cB,6)
print("[Nexus] C")
local sd=N("Frame",{Size=UDim2.new(0,118,1,-40),Position=UDim2.new(0,0,0,40),BackgroundColor3=Color3.fromRGB(21,21,28),BorderSizePixel=0},mn)
local hd=N("Frame",{Size=UDim2.new(1,-128,1,-50),Position=UDim2.new(0,122,0,44),BackgroundTransparency=1},mn)
local pgs,tbs={},{}
local y=0
local function page(nm)local p=N("ScrollingFrame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=3,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,Visible=false},hd)pgs[nm]=p return p end
local function tab(nm)local b=N("TextButton",{Size=UDim2.new(1,-12,0,31),Position=UDim2.new(0,6,0,6+(#tbs*35)),BackgroundColor3=Color3.fromRGB(28,28,36),BackgroundTransparency=0.4,BorderSizePixel=0,Font=Enum.Font.GothamMedium,Text=nm,TextSize=12,TextColor3=Color3.fromRGB(170,170,190)},sd)cr(b,6)table.insert(tbs,b)
b.MouseButton1Click:Connect(function()for n,p in pairs(pgs)do p.Visible=(n==nm)end
for _,t in ipairs(tbs)do t.BackgroundColor3=Color3.fromRGB(28,28,36)t.TextColor3=Color3.fromRGB(170,170,190)end
b.BackgroundColor3=A b.TextColor3=Color3.fromRGB(255,255,255)end)return b end
local function row(p)local r=N("Frame",{Size=UDim2.new(1,-10,0,30),Position=UDim2.new(0,0,0,y),BackgroundColor3=Color3.fromRGB(24,24,31),BorderSizePixel=0},p)cr(r,6)y=y+34 return r end
local function ttl(p,t)local x=N("TextLabel",{Size=UDim2.new(1,0,0,20),Position=UDim2.new(0,0,0,y),BackgroundTransparency=1,Font=Enum.Font.GothamBold,Text=t:upper(),TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=Color3.fromRGB(110,110,130)},p)y=y+24 return x end
local function tog(p,t,def,fn)local v=def or false local r=row(p)
N("TextLabel",{Size=UDim2.new(1,-90,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Font=Enum.Font.Gotham,Text=t,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=Color3.fromRGB(205,205,218)},r)
local tr=N("Frame",{Size=UDim2.new(0,38,0,18),Position=UDim2.new(1,-48,0.5,-9),BackgroundColor3=v and A or Color3.fromRGB(45,45,58),BorderSizePixel=0},r)cr(tr,9)
local kn=N("Frame",{Size=UDim2.new(0,14,0,14),Position=UDim2.new(0,2,0.5,-7),BackgroundColor3=Color3.fromRGB(230,230,240),BorderSizePixel=0},tr)cr(kn,7)
local b=N("TextButton",{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Text=""},r)
b.MouseButton1Click:Connect(function()v=not v tr.BackgroundColor3=v and A or Color3.fromRGB(45,45,58)kn.Position=v and UDim2.new(1,-16,0.5,-7)or UDim2.new(0,2,0.5,-7)pcall(fn,v)end)return b end
print("[Nexus] D")

y=0
local mP=page("Movement")tab("Movement")
ttl(mP,"Motion")
tog(mP,"Speed",false,function(on)local h=L.Character and L.Character:FindFirstChildOfClass("Humanoid")if h then h.WalkSpeed=on and 100 or 16 end end)
tog(mP,"Jump Boost",false,function(on)local h=L.Character and L.Character:FindFirstChildOfClass("Humanoid")if h then h.UseJumpPower=true h.JumpPower=on and 120 or 50 end end)
y=0
local vP=page("Visual")tab("Visual")
ttl(vP,"Player ESP")
local eOn=false
local es={}
local function wipe()for _,d in pairs(es)do for _,o in pairs(d)do pcall(function()o:Destroy()end)end end es={}end
R.RenderStepped:Connect(function()
if not eOn then return end
for _,pl in ipairs(game.Players:GetPlayers())do
if pl~=L and pl.Character then
local h=pl.Character:FindFirstChild("HumanoidRootPart")
if h then local d=es[pl]
if not d then d={}es[pl]=d d.b=N("BoxHandleAdornment",{Adornee=h,Size=h.Size,AlwaysOnTop=true,ZIndex=5,Color3=A,Transparency=0.35},h)end
d.b.Size=h.Size end end end
for p,d in pairs(es)do if not p.Character then for _,o in pairs(d)do pcall(function()o:Destroy()end)end es[p]=nil end end end end)
tog(vP,"ESP",false,function(on)eOn=on if not on then wipe()end end)
print("[Nexus] E")

for n,p in pairs(pgs)do p.Visible=(n=="Movement")end
tbs[1].BackgroundColor3=A tbs[1].TextColor3=Color3.fromRGB(255,255,255)
cB.MouseButton1Click:Connect(function()gui:Destroy()end)
print("[Nexus] READY")
