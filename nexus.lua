local PG=game.Players.LocalPlayer.PlayerGui
local gui=Instance.new("ScreenGui")
gui.Name="NexusUI"
gui.ResetOnSpawn=false
gui.IgnoreGuiInset=true
gui.DisplayOrder=999
gui.Parent=PG
print("[Nexus] 1 gui")
local mn=Instance.new("Frame")
mn.Name="Main"
mn.Size=UDim2.new(0,520,0,380)
mn.Position=UDim2.new(0.5,-260,0.5,-190)
mn.BackgroundColor3=Color3.fromRGB(18,18,24)
mn.BorderSizePixel=0
mn.Parent=gui
print("[Nexus] 2 frame parent="..tostring(mn.Parent and mn.Parent.Name))

local P=game:GetService("Players")local U=game:GetService("UserInputService")
local R=game:GetService("RunService")local T=game:GetService("TweenService")
local MPS=game:GetService("MarketplaceService")local RS=game:GetService("ReplicatedStorage")
local L=P.LocalPlayer
local function N(c,p,par)local o=Instance.new(c)if p then for k,v in pairs(p)do if k~="Parent"then pcall(function()o[k]=v end)end end end
if p and p.Parent then o.Parent=p.Parent end if par then o.Parent=par end return o end
local A=Color3.fromRGB(125,70,255)local ae,gr={},{}local act=nil
local function hue(c,a)local r,g,b=c.R,c.G,c.B local mx,mn2=math.max(r,g,b),math.min(r,g,b)local d=mx-mn2 local h,s,v=0,0,mx
if mx>0 then s=d/mx end if d>0 then if mx==r then h=((g-b)/d)%6 elseif mx==g then h=((b-r)/d)+2 else h=((r-g)/d)+4 end h=h/6 end
return Color3.fromHSV((h+a)%1,s,v)end
local function cr(o,r)N("UICorner",{CornerRadius=UDim.new(0,r or 6)},o)end
local function sk(o,c,t)N("UIStroke",{Color=c or Color3.fromRGB(60,60,75),Thickness=t or 1,ApplyStrokeMode=Enum.ApplyStrokeMode.Border},o)end
local function acc(c)A=c local s2=hue(c,0.07)for _,e in ipairs(ae)do pcall(function()e.o[e.p]=A end)end
for _,g in ipairs(gr)do pcall(function()g.Color=ColorSequence.new(A,s2)end)end if act then pcall(function()act.BackgroundColor3=A end)end end
local us=N("UIScale",{Scale=1},mn)
local tp=N("Frame",{Size=UDim2.new(1,0,0,40),BackgroundColor3=A,BorderSizePixel=0},mn)cr(tp,10)
N("Frame",{Size=UDim2.new(1,0,0,14),Position=UDim2.new(0,0,1,-14),BackgroundColor3=A,BorderSizePixel=0},tp)
table.insert(gr,N("UIGradient",{Color=ColorSequence.new(A,hue(A,0.07))},tp))
N("TextLabel",{Size=UDim2.new(0,200,1,0),Position=UDim2.new(0,14,0,0),BackgroundTransparency=1,Font=Enum.Font.GothamBold,Text="NEXUS",TextSize=17,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=Color3.fromRGB(255,255,255)},tp)
N("TextLabel",{Size=UDim2.new(0,140,1,0),Position=UDim2.new(0,84,0,0),BackgroundTransparency=1,Font=Enum.Font.Gotham,Text="| hub",TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=Color3.fromRGB(215,210,235)},tp)
local mB=N("TextButton",{Size=UDim2.new(0,28,0,28),Position=UDim2.new(1,-68,0,6),BackgroundColor3=Color3.fromRGB(20,20,28),BackgroundTransparency=0.35,BorderSizePixel=0,Font=Enum.Font.GothamBold,Text="_",TextSize=14,TextColor3=Color3.fromRGB(255,255,255)},tp)cr(mB,6)
local cB=N("TextButton",{Size=UDim2.new(0,28,0,28),Position=UDim2.new(1,-36,0,6),BackgroundColor3=Color3.fromRGB(20,20,28),BackgroundTransparency=0.35,BorderSizePixel=0,Font=Enum.Font.GothamBold,Text="X",TextSize=12,TextColor3=Color3.fromRGB(255,255,255)},tp)cr(cB,6)
print("[Nexus] 3 titlebar")
local bub=N("Frame",{Size=UDim2.fromOffset(44,44),Position=UDim2.new(0,30,0.5,-22),BackgroundColor3=A,BorderSizePixel=0,Visible=false},gui)cr(bub,10)sk(bub,Color3.fromRGB(255,255,255),1)
N("TextLabel",{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Font=Enum.Font.GothamBlack,Text="N",TextSize=20,TextColor3=Color3.fromRGB(255,255,255)},bub)
local bB=N("TextButton",{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Text=""},bub)
local sd=N("Frame",{Size=UDim2.new(0,118,1,-40),Position=UDim2.new(0,0,0,40),BackgroundColor3=Color3.fromRGB(21,21,28),BorderSizePixel=0},mn)
local hd=N("Frame",{Size=UDim2.new(1,-128,1,-50),Position=UDim2.new(0,122,0,44),BackgroundTransparency=1},mn)
local pgs,tbs={},{}
local function page(nm)local p=N("ScrollingFrame",{Name=nm,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=3,ScrollBarImageColor3=Color3.fromRGB(60,60,75),CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,Visible=false},hd)pgs[nm]=p return p end
local function tab(nm)local b=N("TextButton",{Size=UDim2.new(1,-12,0,31),Position=UDim2.new(0,6,0,6+(#tbs*35)),BackgroundColor3=Color3.fromRGB(28,28,36),BackgroundTransparency=0.4,BorderSizePixel=0,Font=Enum.Font.GothamMedium,Text=nm,TextSize=12,TextColor3=Color3.fromRGB(170,170,190),AutoButtonColor=false},sd)
cr(b,6)table.insert(tbs,b)
b.MouseButton1Click:Connect(function()for n,p in pairs(pgs)do p.Visible=(n==nm)end
for _,t in ipairs(tbs)do pcall(function()T:Create(t,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(28,28,36),BackgroundTransparency=0.4,TextColor3=Color3.fromRGB(170,170,190)}):Play()end)end
pcall(function()T:Create(b,TweenInfo.new(0.15),{BackgroundColor3=A,BackgroundTransparency=0,TextColor3=Color3.fromRGB(255,255,255)}):Play()end)act=b end)return b end
local y,q=0,0
local function row(p)q=q+1 local r=N("Frame",{Size=UDim2.new(1,-10,0,30),Position=UDim2.new(0,0,0,y),BackgroundColor3=Color3.fromRGB(24,24,31),BorderSizePixel=0,LayoutOrder=q},p)cr(r,6)y=y+34 return r end
local function lb(p,t,w)return N("TextLabel",{Size=UDim2.new(1,w or -90,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Font=Enum.Font.Gotham,Text=t,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=Color3.fromRGB(205,205,218)},p)end
local function tog(p,t,def,fn,sh)sh=sh or{v=def or false,r={}}if fn and not sh.a then sh.a=fn end
local r=row(p)lb(r,t)
local tr=N("Frame",{Size=UDim2.new(0,38,0,18),Position=UDim2.new(1,-48,0.5,-9),BackgroundColor3=Color3.fromRGB(45,45,58),BorderSizePixel=0},r)cr(tr,9)
local kn=N("Frame",{Size=UDim2.new(0,14,0,14),Position=UDim2.new(0,2,0.5,-7),BackgroundColor3=Color3.fromRGB(230,230,240),BorderSizePixel=0},tr)cr(kn,7)
local function rd()pcall(function()T:Create(tr,TweenInfo.new(0.15),{BackgroundColor3=sh.v and A or Color3.fromRGB(45,45,58)}):Play()end)
pcall(function()T:Create(kn,TweenInfo.new(0.15),{Position=sh.v and UDim2.new(1,-16,0.5,-7)or UDim2.new(0,2,0.5,-7)}):Play()end)end
local function set(v)sh.v=v for _,f in ipairs(sh.r)do pcall(f)end if sh.a then pcall(sh.a,v)end end
table.insert(sh.r,rd)
local bt=N("TextButton",{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Text=""},r)bt.MouseButton1Click:Connect(function()set(not sh.v)end)
rd()return{set=set,get=function()return sh.v end,sh=sh}end
local function lp(p,t,s,e)local c return tog(p,t,false,function(on)if on then local ok,v=pcall(function()return s and s()end)if ok then c=v end elseif c then pcall(function()c:Disconnect()end)c=nil end if e then pcall(e)end end)end
local function bx(p,t,d,fn)local r=row(p)lb(r,t)
local b=N("TextBox",{Size=UDim2.new(0,70,0,22),Position=UDim2.new(1,-80,0.5,-11),BackgroundColor3=Color3.fromRGB(34,34,44),BorderSizePixel=0,Font=Enum.Font.Code,Text=tostring(d),TextSize=12,TextColor3=Color3.fromRGB(230,230,240),ClearTextOnFocus=false},r)cr(b,5)
b.FocusLost:Connect(function()local n=tonumber(b.Text)if n then pcall(fn,n)else b.Text=tostring(d)end end)return b end
local function stp(p,t,v,lo,hi,sp,fmt,fn)local r=row(p)lb(r,t,-128)
local mi=N("TextButton",{Size=UDim2.new(0,22,0,20),Position=UDim2.new(1,-108,0.5,-10),BackgroundColor3=Color3.fromRGB(40,40,52),BorderSizePixel=0,Font=Enum.Font.GothamBold,Text="-",TextSize=13,TextColor3=Color3.fromRGB(235,235,245)},r)cr(mi,5)
local vl=N("TextLabel",{Size=UDim2.new(0,46,1,0),Position=UDim2.new(1,-84,0,0),BackgroundTransparency=1,Font=Enum.Font.Code,Text=fmt(v),TextSize=11,TextColor3=Color3.fromRGB(225,225,240)},r)
local pl=N("TextButton",{Size=UDim2.new(0,22,0,20),Position=UDim2.new(1,-32,0.5,-10),BackgroundColor3=Color3.fromRGB(40,40,52),BorderSizePixel=0,Font=Enum.Font.GothamBold,Text="+",TextSize=13,TextColor3=Color3.fromRGB(235,235,245)},r)cr(pl,5)
local cv=v
local function ap(nv)cv=math.clamp(lo+math.floor((nv-lo)/sp+0.5)*sp,lo,hi)cv=math.floor(cv*1000+0.5)/1000 vl.Text=fmt(cv)if fn then pcall(fn,cv)end end
mi.MouseButton1Click:Connect(function()ap(cv-sp)end)pl.MouseButton1Click:Connect(function()ap(cv+sp)end)return{get=function()return cv end}end
local function btn(p,t,fn)local r=row(p)
local b=N("TextButton",{Size=UDim2.fromScale(1,1),BackgroundColor3=Color3.fromRGB(34,34,44),BorderSizePixel=0,Font=Enum.Font.GothamMedium,Text=t,TextSize=12,TextColor3=Color3.fromRGB(230,230,240),AutoButtonColor=false},r)cr(b,6)
b.MouseEnter:Connect(function()pcall(function()T:Create(b,TweenInfo.new(0.12),{BackgroundColor3=A}):Play()end)end)
b.MouseLeave:Connect(function()pcall(function()T:Create(b,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(34,34,44)}):Play()end)end)
b.MouseButton1Click:Connect(function()pcall(fn)end)return b end
local function ttl(p,t)q=q+1 local x=N("TextLabel",{Size=UDim2.new(1,0,0,20),Position=UDim2.new(0,0,0,y),BackgroundTransparency=1,Font=Enum.Font.GothamBold,Text=t:upper(),TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=Color3.fromRGB(110,110,130),LayoutOrder=q},p)y=y+24 return x end
local function dsc(p,t,h)q=q+1 local d=N("Frame",{Size=UDim2.new(1,-10,0,h),Position=UDim2.new(0,0,0,y),BackgroundColor3=Color3.fromRGB(22,22,29),BorderSizePixel=0,LayoutOrder=q},p)cr(d,6)
N("TextLabel",{Size=UDim2.new(1,-16,1,-12),Position=UDim2.new(0,8,0,6),BackgroundTransparency=1,Font=Enum.Font.Gotham,Text=t,TextSize=10,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Top,TextColor3=Color3.fromRGB(150,150,170)},d)y=y+h+4 return d end
print("[Nexus] 4 widgets")

local spV,jpV,spnV,flV=60,80,6,60
local eOn,trOn,bxOn,nmOn,rgbOn=false,false,false,false,false
local fIdx,jpOn=0,false
local cl,cn={},{}
local function trk(c)table.insert(cn,c)return c end
local function hrp()local c=L.Character return c and c:FindFirstChild("HumanoidRootPart")end
local function hum(p)local c=(p or L).Character return c and c:FindFirstChildOfClass("Humanoid")end
local function hed(p)local c=(p or L).Character return c and c:FindFirstChild("Head")end
local function oth(f)for _,p in ipairs(P:GetPlayers())do if p~=L and p.Character then f(p,p.Character)end end end
local function rb()return Color3.fromHSV((os.clock()*0.4)%1,1,1)end
local function gt(p,t,s)local h local x=tog(p,t,false,function(on)if on then local ok,v=pcall(s)if ok then h=v end elseif h then pcall(function()h:Disconnect()end)h=nil end end)
table.insert(cl,function()if x.get()then x.set(false)end end)return x end

pcall(function()
y=0
local stP=page("Settings")tab("Settings")
ttl(stP,"Appearance")
tog(stP,"Disable Gradient",false,function(on)for _,g in ipairs(gr)do pcall(function()g.Enabled=not on end)end end)
ttl(stP,"Menu Scale")
local sR=row(stP)lb(sR,"Menu Scale")
local sL=N("TextLabel",{Size=UDim2.new(0,42,1,0),Position=UDim2.new(1,-74,0,0),BackgroundTransparency=1,Font=Enum.Font.Code,Text="100%",TextSize=11,TextColor3=Color3.fromRGB(220,220,235)},sR)
local scV=1
local function ssc(v)scV=math.clamp(math.floor(v*10+0.5)/10,0.6,1.6)sL.Text=tostring(math.floor(scV*100)).."%"pcall(function()T:Create(us,TweenInfo.new(0.15),{Scale=scV}):Play()end)end
local sM=N("TextButton",{Size=UDim2.new(0,22,0,20),Position=UDim2.new(1,-100,0.5,-10),BackgroundColor3=Color3.fromRGB(40,40,52),BorderSizePixel=0,Font=Enum.Font.GothamBold,Text="-",TextSize=13,TextColor3=Color3.fromRGB(235,235,245)},sR)cr(sM,5)
local sPl=N("TextButton",{Size=UDim2.new(0,22,0,20),Position=UDim2.new(1,-30,0.5,-10),BackgroundColor3=Color3.fromRGB(40,40,52),BorderSizePixel=0,Font=Enum.Font.GothamBold,Text="+",TextSize=13,TextColor3=Color3.fromRGB(235,235,245)},sR)cr(sPl,5)
sM.MouseButton1Click:Connect(function()ssc(scV-0.1)end)sPl.MouseButton1Click:Connect(function()ssc(scV+0.1)end)
ttl(stP,"Menu Color")
local swR=N("Frame",{Size=UDim2.new(1,-10,0,30),Position=UDim2.new(0,0,0,y),BackgroundTransparency=1},stP)y=y+34
for i,c in ipairs({Color3.fromRGB(125,70,255),Color3.fromRGB(255,70,120),Color3.fromRGB(60,200,255),Color3.fromRGB(70,220,130),Color3.fromRGB(255,190,60),Color3.fromRGB(230,230,240)})do
local s=N("TextButton",{Size=UDim2.new(0,26,0,26),Position=UDim2.new(0,(i-1)*32,0,2),BackgroundColor3=c,BorderSizePixel=0,Text=""},swR)cr(s,6)s.MouseButton1Click:Connect(function()acc(c)end)end
_=scV
end)
print("[Nexus] 5 settings")

local gP=page("Game")tab("Game")
local uP=page("Universal")tab("Universal")
local uB=N("Frame",{Size=UDim2.new(1,0,0,0),BackgroundTransparency=1,AutomaticSize=Enum.AutomaticSize.Y},uP)
N("UIListLayout",{Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder},uB)
y=0
local mP=page("Movement")tab("Movement")
local fBV,fBG,fC,fbBP,spC
local aU,aD=false,false
local pd=N("Frame",{Size=UDim2.new(0,46,0,100),Position=UDim2.new(1,-66,1,-160),BackgroundTransparency=1,Visible=false},gui)
local function pdB(t,ps,k)local b=N("TextButton",{Size=UDim2.new(0,46,0,46),Position=ps,BackgroundColor3=Color3.fromRGB(30,30,40),BackgroundTransparency=0.25,BorderSizePixel=0,Font=Enum.Font.GothamBold,Text=t,TextSize=16,TextColor3=Color3.fromRGB(255,255,255)},pd)cr(b,10)
b.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then if k=="u"then aU=true else aD=true end end end)
b.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then if k=="u"then aU=false else aD=false end end end)end
pdB("+",UDim2.new(0,0,0,0),"u")pdB("-",UDim2.new(0,0,0,54),"d")
local function stopF()if fC then pcall(function()fC:Disconnect()end)fC=nil end if fBV then pcall(function()fBV:Destroy()end)fBV=nil end if fBG then pcall(function()fBG:Destroy()end)fBG=nil end pd.Visible=false end
local function startF()local h,hu=hrp(),hum()if not h then return end
fBV=N("BodyVelocity",{MaxForce=Vector3.new(1e5,1e5,1e5),Velocity=Vector3.new()},h)
fBG=N("BodyGyro",{MaxTorque=Vector3.new(1e5,1e5,1e5),P=12000,D=200},h)
pd.Visible=U.TouchEnabled and mn.Visible
fC=R.RenderStepped:Connect(function()local cam=workspace.CurrentCamera if not cam or not h.Parent or not fBV then return end
local d=Vector3.new()
if hu and hu.Parent then if hu.MoveDirection.Magnitude>0 then local l3=cam.CFrame:VectorToObjectSpace(hu.MoveDirection)d=(cam.CFrame.RightVector*l3.X)+(cam.CFrame.LookVector*-l3.Z)end
if hu.Jump or U:IsKeyDown(Enum.KeyCode.Space)or aU then d=d+Vector3.new(0,1,0)end end
if U:IsKeyDown(Enum.KeyCode.LeftControl)or aD then d=d-Vector3.new(0,1,0)end
pcall(function()fBV.Velocity=(d.Magnitude>0 and d.Unit or Vector3.new())*flV fBG.CFrame=cam.CFrame end)end)end
ttl(mP,"Flight")
tog(mP,"Fly",false,function(on)if on then startF()else stopF()end end)
bx(mP,"Fly Speed",flV,function(n)flV=math.clamp(n,5,500)end)
ttl(mP,"Motion")
tog(mP,"Spin",false,function(on)if spC then pcall(function()spC:Disconnect()end)spC=nil end
if on then spC=R.Heartbeat:Connect(function(dt)local h=hrp()if h then pcall(function()h.CFrame=h.CFrame*CFrame.Angles(0,math.rad(spnV)*dt*10,0)end)end end)end end)
bx(mP,"Spin Speed",spnV,function(n)spnV=math.clamp(n,1,100)end)
tog(mP,"Speed",false,function(on)local hu=hum()if hu then hu.WalkSpeed=on and spV or 16 end end)
bx(mP,"Movement Speed",spV,function(n)spV=math.clamp(n,16,500)local hu=hum()if hu and hu.WalkSpeed>16 then hu.WalkSpeed=spV end end)
bx(mP,"Jump Power",jpV,function(n)jpV=math.clamp(n,50,500)if jpOn then local hu=hum()if hu then hu.JumpPower=jpV end end end)
tog(mP,"Jump Boost",false,function(on)jpOn=on local hu=hum()if hu then hu.UseJumpPower=true hu.JumpPower=on and jpV or 50 end end)
tog(mP,"Float",false,function(on)if fbBP then pcall(function()fbBP:Destroy()end)fbBP=nil end
if on then local h=hrp()if h then fbBP=N("BodyPosition",{MaxForce=Vector3.new(1e5,1e5,1e5),P=12000,D=800,Position=h.Position},h)end end end)
print("[Nexus] 6 movement")

y=0
local vP=page("Visual")tab("Visual")
local es={}
local function wipe()for _,d in pairs(es)do for _,o in pairs(d)do pcall(function()if o.Remove then o:Remove()else o:Destroy()end end)end end es={}end
trk(R.RenderStepped:Connect(function()if not eOn then return end local cam=workspace.CurrentCamera if not cam then return end
local b=rgbOn and rb()or A
for _,pl in ipairs(P:GetPlayers())do if pl~=L and pl.Character then
local h=pl.Character:FindFirstChild("HumanoidRootPart")local hh=pl.Character:FindFirstChild("Head")
if h and hh then local d=es[pl]
if not d then d={}es[pl]=d
if bxOn then d.b=N("BoxHandleAdornment",{Adornee=h,Size=h.Size,AlwaysOnTop=true,ZIndex=5,Color3=b,Transparency=0.35},h)end
if nmOn then local bg=N("BillboardGui",{Adornee=hh,Size=UDim2.new(0,100,0,20),StudsOffset=Vector3.new(0,2.4,0),AlwaysOnTop=true},hh)
N("TextLabel",{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Font=Enum.Font.GothamBold,Text=pl.Name,TextSize=11,TextColor3=b,TextStrokeTransparency=0.4},bg)d.n=bg end
if trOn and Drawing then local ok,l=pcall(function()local q2=Drawing.new("Line")q2.Thickness=1.5 q2.Transparency=1 return q2 end)if ok then d.t=l end end end
if d.b then pcall(function()d.b.Color3=b d.b.Size=h.Size end)end
if d.n then local l=d.n:FindFirstChildOfClass("TextLabel")if l then l.TextColor3=b end end
if d.t then local sp,on=cam:WorldToViewportPoint(hh.Position)
pcall(function()if on and sp.Z>0 then d.t.Color=b d.t.From=Vector2.new(cam.ViewportSize.X/2,cam.ViewportSize.Y)d.t.To=Vector2.new(sp.X,sp.Y)d.t.Visible=true else d.t.Visible=false end end)end end end end
for p,d in pairs(es)do if not p.Parent or not p.Character then for _,o in pairs(d)do pcall(function()if o.Remove then o:Remove()else o:Destroy()end end)end es[p]=nil end end end))
ttl(vP,"Player ESP")
tog(vP,"ESP",false,function(on)eOn=on if not on then wipe()end end)
tog(vP,"Boxes",false,function(on)bxOn=on wipe()end)
tog(vP,"Name ESP",false,function(on)nmOn=on wipe()end)
tog(vP,"Tracers",false,function(on)trOn=on wipe()end)
tog(vP,"RGB Player",false,function(on)rgbOn=on end)

y=0
local fP=page("Fun")tab("Fun")
ttl(fP,"Movement Pranks")
lp(fP,"Sit Everyone",function()return R.Heartbeat:Connect(function()oth(function(_,c)local h=c:FindFirstChildOfClass("Humanoid")if h then pcall(function()h.Sit=true end)end end)end)end)
lp(fP,"Stand Everyone",function()return R.Heartbeat:Connect(function()oth(function(_,c)local h=c:FindFirstChildOfClass("Humanoid")if h then pcall(function()h.Sit=false end)end end)end)end)
lp(fP,"Unanchor All Parts",function()return R.Heartbeat:Connect(function()oth(function(_,c)for _,d in ipairs(c:GetDescendants())do if d:IsA("BasePart")and d.Name~="HumanoidRootPart"then pcall(function()d.Anchored=false end)end end end)end)end)
lp(fP,"Rainbow Character",function()return R.Heartbeat:Connect(function()local c=L.Character if not c then return end for _,d in ipairs(c:GetDescendants())do if d:IsA("BasePart")then pcall(function()d.Color=rb()end)end end end)end)

y=0
local oP=page("Overpowered")tab("Overpowered")
ttl(oP,"Bulk Actions")
lp(oP,"Bring All",function()return R.Heartbeat:Connect(function()local h=hrp()if not h then return end local i,tt=0,math.max(#P:GetPlayers(),1)
for _,p in ipairs(P:GetPlayers())do if p~=L and p.Character then local ph=p.Character:FindFirstChild("HumanoidRootPart")
if ph then i=i+1 local a=(i/tt)*math.pi*2 pcall(function()ph.CFrame=h.CFrame*CFrame.new(math.cos(a)*5,0,math.sin(a)*5)end)end end end end)end)
lp(oP,"Fling All",function()local sp=0 return R.Heartbeat:Connect(function(dt)local h=hrp()if not h then return end local ls={}
oth(function(p)local ph=p.Character and p.Character:FindFirstChild("HumanoidRootPart")if ph then table.insert(ls,ph)end end)
if #ls==0 then return end fIdx=(fIdx%#ls)+1 local t=ls[fIdx]sp=sp+math.rad(2400)*dt
pcall(function()h.CFrame=t.CFrame*CFrame.new(0,1.5,0)*CFrame.Angles(0,sp,0)h.AssemblyAngularVelocity=Vector3.new(6000,6000,6000)h.AssemblyLinearVelocity=Vector3.new(0,120,0)t.AssemblyAngularVelocity=Vector3.new(4000,4000,4000)end)end)end,function()fIdx=0 end)
lp(oP,"Bang All",function()local a2=0 return R.Heartbeat:Connect(function(dt)a2=a2+dt
if a2>=0.4 then a2=0 local h=hrp()if not h then return end
oth(function(_,c)local ph=c:FindFirstChild("HumanoidRootPart")if ph then pcall(function()ph.CFrame=h.CFrame*CFrame.new(math.random(-3,3),2,math.random(-3,3))ph.AssemblyAngularVelocity=Vector3.new(900,900,900)ph.AssemblyLinearVelocity=Vector3.new(math.random(-400,400),900,math.random(-400,400))end)end end)end end)end)

y=0
local cP=page("Credits")tab("Credits")
ttl(cP,"Developers")
for _,n in ipairs({"TRJacob","unknownbyz","Ultexxx","stackmakerr"})do local r=row(cP)N("TextLabel",{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Font=Enum.Font.GothamMedium,Text=n,TextSize=12,TextColor3=Color3.fromRGB(215,215,230)},r)end
print("[Nexus] 7 pages")

local aFov,aRct,aSm=120,0.12,0.35
local aOn,lkFov,silOn,silAcc=false,true,false,90
local aTgt,rAcc,fovC,aC=nil,0,nil,nil
if Drawing then local ok,c=pcall(function()local ci=Drawing.new("Circle")ci.Thickness=1.5 ci.NumSides=64 ci.Filled=false ci.Transparency=0.8 ci.Color=A ci.Visible=false return ci end)if ok then fovC=c end end
local function pick(rq)local cam=workspace.CurrentCamera if not cam then return nil end local ct=Vector2.new(cam.ViewportSize.X/2,cam.ViewportSize.Y/2)local b,bd=nil,math.huge
for _,p in ipairs(P:GetPlayers())do if p~=L and p.Character then local hh=p.Character:FindFirstChild("Head")local hu=p.Character:FindFirstChildOfClass("Humanoid")
if hh and hu and hu.Health>0 then local sp,on=cam:WorldToViewportPoint(hh.Position)
if on and sp.Z>0 then local d=(Vector2.new(sp.X,sp.Y)-ct).Magnitude if(not rq)or d<=aFov then if d<bd then b,bd=hh,d end end end end end end return b end
local function startA()if aC then pcall(function()aC:Disconnect()end)end rAcc=0
aC=R.RenderStepped:Connect(function(dt)local cam=workspace.CurrentCamera if not cam then return end
if fovC then pcall(function()fovC.Position=Vector2.new(cam.ViewportSize.X/2,cam.ViewportSize.Y/2)fovC.Radius=aFov fovC.Color=A fovC.Visible=true end)end
rAcc=rAcc+dt if rAcc>=aRct then rAcc=0 aTgt=pick(lkFov)end
if aTgt and aTgt.Parent then cam.CFrame=cam.CFrame:Lerp(CFrame.lookAt(cam.CFrame.Position,aTgt.Position),math.clamp(aSm,0.05,1))end end)end
local function stopA()if aC then pcall(function()aC:Disconnect()end)aC=nil end if fovC then pcall(function()fovC.Visible=false end)end aTgt=nil end
local hMT,oNC
pcall(function()if type(getrawmetatable)~="function"then return end local m=getrawmetatable(game)if not m then return end local raw=rawget(m,"__namecall")if not raw then return end
hMT,oNC=m,raw if type(setreadonly)=="function"then pcall(setreadonly,m,false)end
local w=function(s,...)local me="" if type(getnamecallmethod)=="function"then local ok,mm=pcall(getnamecallmethod)if ok and type(mm)=="string"then me=mm end end
if silOn and(me=="Raycast"or me:FindPartOnRay())then end
if silOn and(me=="Raycast"or me:find("FindPartOnRay"))then local cam=workspace.CurrentCamera local t=cam and pick(false)
if t then local a={...}local spr=math.rad((100-silAcc)*0.3)
local function jt(v)return(CFrame.fromEulerAnglesXYZ((math.random()-0.5)*spr,(math.random()-0.5)*spr,0)*v).Unit end
if me=="Raycast"and type(a[1])=="Vector3"and type(a[2])=="Vector3"then a[2]=jt(t.Position-a[1])*a[2].Magnitude
elseif type(a[1])=="Ray"then a[1]=Ray.new(a[1].Origin,jt(t.Position-a[1].Origin)*a[1].Direction.Magnitude)end
return raw(s,table.unpack(a))end end return raw(s,...)end
local fn=w if type(newcclosure)=="function"then local ok,nc=pcall(newcclosure,w)if ok and nc then fn=nc end end
m.__namecall=fn if type(setreadonly)=="function"then pcall(setreadonly,m,true)end end)

y=0
ttl(uB,"Universal Aimbot")
dsc(uB,"Locks your camera onto any player in any game. The FOV circle is where it can grab someone - the circle has to touch them before it locks.",52)
local aTg=tog(uB,"Aimbot",false,function(on)aOn=on if on then startA()else stopA()end end)
q=q+1
local aO=N("Frame",{Size=UDim2.new(1,0,0,0),BackgroundTransparency=1,AutomaticSize=Enum.AutomaticSize.None,Visible=false,LayoutOrder=q},uB)
N("UIListLayout",{Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder},aO)N("UIPadding",{PaddingLeft=UDim.new(0,6)},aO)
tog(aO,"Lock On FOV",true,function(on)lkFov=on end)
stp(aO,"FOV",120,40,700,10,function(v)return v.."px"end,function(v)aFov=v end)
stp(aO,"Smoothing",0.35,0.05,1,0.05,function(v)return string.format("%.2f",v)end,function(v)aSm=v end)
ttl(uB,"Universal Silent Aim")
dsc(uB,"Silent aim lets your shots land without your crosshair actually being on the target. Lower accuracy adds spread, higher keeps it tight.",52)
local sTg=tog(uB,"Silent Aim",false,function(on)silOn=on end)
q=q+1
local sO=N("Frame",{Size=UDim2.new(1,0,0,0),BackgroundTransparency=1,AutomaticSize=Enum.AutomaticSize.None,Visible=false,LayoutOrder=q},uB)
N("UIListLayout",{Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder},sO)N("UIPadding",{PaddingLeft=UDim.new(0,6)},sO)
stp
