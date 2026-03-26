local HBD = LibStub("HereBeDragons-2.0")
--local pins = LibStub("HereBeDragons-Pins-2.0")

local addonName, addon = ...

Lunacy.Text1 = "Unknown"
Lunacy.Text2 = "0"

Lunacy.Timer = 0
Lunacy.loadDelay = 5
Lunacy.iconsize = 24
Lunacy.iconsize2 = 64

local spdTsz = 9
local pokeMap = true
local linesUP
local blkQst = {
	[94815] = true
}

local distTab = {0,0,0,0,0,0,0,0,0}
local timeTab = {0,0,0,0,0,0,0,0,0}

Lunacy.tracker = {
	tracking = false,
	trackType = none,
	x = 0,
	y = 0,
	map = nil,
	text = "Unknown",
	idx = 1,
	sounds = {},
	destRadius = 15,
	lock = false,
	lastX = 0.5,
	lastY = 0.5,
	lastM = 0,
	lastObj = "Unknown",
	destCheck = false
}

Lunacy.NavFrame = nil

local destRadius = 7

local loco = {}
local elders = {}
local qComp = {}
--local pWay = nil

local ddC = 0

loco.idx = 0

local farmKeys = {
	["decay"] = function(val)
		if val then
			val = tonumber(val)
		end
		if type(val) ~= "number" then
			print(tostring(val).." > not a number..")
			return val
		end
		local x = math.floor((val - GetTimePreciseSec()) * 100) / 100
		return tostring(x).." seconds remaining.."
	end
}

local dbgLatch = true

--trackType[1] = "none"
--trackType[2] = "quests"
local sounds = {541055,559193,568873}
local trackType = {"gyre", "odometer", "compass"}
local destCheck = {false, false, true}
--Lunacy.tracker.sounds[1] = 559193
--Lunacy.tracker.sounds[2] = 568873
--Lunacy.tracker.sounds[3] = 540897
--PlaySoundFile("Interface\\Addons\\Lunacy\\Media\\Ping.mp3")

--Main Frame -- Container for the ui
local LunacyMainFrame = CreateFrame("Frame", "LunacyMainFrame", UIParent)
LunacyMainFrame:ClearAllPoints()
LunacyMainFrame:SetPoint("CENTER");
LunacyMainFrame:EnableMouse(enable)
LunacyMainFrame:SetWidth(96);
LunacyMainFrame:SetHeight(96);
LunacyMainFrame:SetMovable(true);
LunacyMainFrame:SetFrameLevel(1)

--Lunacy Gyre
local LunacyGyre = CreateFrame("Button", "LunacyGyre", LunacyMainFrame)
LunacyGyre:SetWidth(96);
LunacyGyre:SetHeight(96);
LunacyGyre:EnableMouse(enable)
LunacyGyre.texture = LunacyGyre:CreateTexture()
LunacyGyre.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\LunacyA")
LunacyGyre:SetPoint("CENTER")
LunacyGyre:SetFrameStrata("LOW")
LunacyGyre.texture:SetDrawLayer("ARTWORK", 5)
LunacyGyre.texture:SetBlendMode("BLEND")
LunacyGyre.texture:SetAllPoints(LunacyMainFrame)
LunacyGyre.texture:SetVertexColor(1.0, 1.0, 1.0, 1.0)
LunacyGyre:SetFrameLevel(1)

--Lunacy Dial
local LunacyFrameA = CreateFrame("Button", "LunacyFrameA", LunacyMainFrame)
LunacyFrameA:SetWidth(96);
LunacyFrameA:SetHeight(96);
LunacyFrameA:EnableMouse(enable)
LunacyFrameA.texture = LunacyFrameA:CreateTexture()
LunacyFrameA.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\Compass")
LunacyFrameA:SetPoint("CENTER")
LunacyFrameA:SetFrameStrata("LOW")
LunacyFrameA.texture:SetDrawLayer("ARTWORK", 1)
LunacyFrameA.texture:SetAllPoints(LunacyMainFrame)
LunacyFrameA.texture:SetVertexColor(0, 0.75, 0.75)
LunacyFrameA:SetFrameLevel(2)

local Lunadometer = CreateFrame("Button", "Lunadometer", LunacyMainFrame)
Lunadometer:SetWidth(96);
Lunadometer:SetHeight(96);
Lunadometer:EnableMouse(enable)
Lunadometer.texture = Lunadometer:CreateTexture()
Lunadometer.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\CompassH")
Lunadometer:SetPoint("CENTER")
Lunadometer:SetFrameStrata("LOW")
Lunadometer.texture:SetDrawLayer("ARTWORK", 1)
Lunadometer.texture:SetAllPoints(LunacyMainFrame)
Lunadometer.texture:SetVertexColor(0, 0.75, 0.75)
Lunadometer:SetFrameLevel(3)

--Lunacy Outer Ring
local LunacyFrameB = CreateFrame("Button", "LunacyFrameB", LunacyMainFrame)
LunacyFrameB:SetWidth(96);
LunacyFrameB:SetHeight(96);
LunacyFrameB:EnableMouse(enable)
LunacyFrameB.texture = LunacyFrameB:CreateTexture()
LunacyFrameB.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\CompassB")
LunacyFrameB:SetPoint("CENTER")
LunacyFrameB:SetFrameStrata("MEDIUM")
LunacyFrameB.texture:SetDrawLayer("ARTWORK", 4)
LunacyFrameB.texture:SetBlendMode("BLEND")
LunacyFrameB.texture:SetAllPoints(LunacyMainFrame)
--LunacyFrameB.texture:SetVertexColor(0.77, 0.77, 0.77, 1)
LunacyFrameB.texture:SetVertexColor(0.77, 0.91, 91)
LunacyFrameB:SetFrameLevel(2)

local diSStrip = {}
local frIdex = 0
repeat
	diSStrip[frIdex] = CreateFrame("Button", nil, LunacyFrameB)
	diSStrip[frIdex]:SetSize(8, 8)
	diSStrip[frIdex]:SetPoint("CENTER")
	diSStrip[frIdex]:SetPoint("BOTTOMRIGHT", LunacyMainFrame, "BOTTOMRIGHT", -29 - frIdex * 6, 16)
	diSStrip[frIdex]:SetFrameStrata("MEDIUM")
	diSStrip[frIdex]:SetFrameLevel(15)
	diSStrip[frIdex].texture = diSStrip[frIdex]:CreateTexture()
	diSStrip[frIdex].texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\StripA")
	diSStrip[frIdex].texture:SetDrawLayer("ARTWORK", 5)
	diSStrip[frIdex].texture:SetPoint("CENTER", diSStrip[frIdex])
	diSStrip[frIdex].texture:SetBlendMode("BLEND")
	diSStrip[frIdex].texture:SetAllPoints(diSStrip[frIdex])
	--Lunadometer[frIdex].texture:SetVertexColor(0.00, 0.95, 0.95)
	diSStrip[frIdex].texture:SetTexCoord(0, 1, 0.078125 * (0 + frIdex), 0.078125 * (1 + frIdex))
	frIdex = frIdex + 1
until frIdex > 5
--Texture Rotation
--https://www.wowinterface.com/forums/showthread.php?t=36679&page=2

diSStrip[0].texture:SetVertexColor(0.00, 0.95, 0.95)

local sandy =  CreateFrame("PlayerModel", "Sandy", LunacyFrameB)
sandy:SetPoint("CENTER")
sandy:SetPoint("TOPLEFT", LunacyFrameB, "TOPLEFT", 15, -8)
sandy:SetSize(66, 66)
sandy:SetDisplayInfo(21723)
--sandy:SetDisplayInfo(26375)
--sandy:SetPortraitZoom(1.5)
sandy:SetFrameStrata("MEDIUM")
sandy:SetFrameLevel(13)

--Lunacy Bubble
local LunacyFrameC = CreateFrame("Button", "LunacyFrameC", LunacyMainFrame)
LunacyFrameC:SetWidth(96);
LunacyFrameC:SetHeight(96);
LunacyFrameC:EnableMouse(enable)
LunacyFrameC.texture = LunacyFrameC:CreateTexture()
LunacyFrameC.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\CompassC")
LunacyFrameC:SetPoint("CENTER")
LunacyFrameC:SetFrameStrata("MEDIUM")
LunacyFrameC.texture:SetDrawLayer("ARTWORK", 5)
LunacyFrameC.texture:SetBlendMode("ADD")
LunacyFrameC.texture:SetAllPoints(LunacyMainFrame)
LunacyFrameC.texture:SetVertexColor(0.85, 0.85, 0.85, 0.45)
LunacyFrameC:SetFrameLevel(23)

--Lunacy Arrow
local CompArrow = CreateFrame("Button", "CompArrow", LunacyMainFrame)
CompArrow:SetWidth(96);
CompArrow:SetHeight(96);
CompArrow:EnableMouse(enable)
CompArrow.texture = CompArrow:CreateTexture()
CompArrow.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\Arrow")
CompArrow:SetPoint("CENTER")
CompArrow:SetFrameStrata("MEDIUM")
CompArrow:SetFrameLevel(14)
CompArrow.texture:SetDrawLayer("ARTWORK", 5)
CompArrow.texture:SetBlendMode("BLEND")
CompArrow.texture:SetAllPoints(LunacyMainFrame)
CompArrow.texture:SetVertexColor(0.0, 0.25, 0.90, 1)

local Reticule = CreateFrame("Button", "LunaReticule", LunacyMainFrame)
Reticule:SetWidth(96)
Reticule:SetHeight(96)
Reticule:EnableMouse(enable)
Reticule.texture = Reticule:CreateTexture()
Reticule.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\Reticule")
Reticule:SetPoint("CENTER")
Reticule:SetFrameStrata("MEDIUM")
Reticule:SetFrameLevel(10)
Reticule.texture:SetDrawLayer("ARTWORK", 5)
Reticule.texture:SetBlendMode("BLEND")
Reticule.texture:SetAllPoints(LunacyMainFrame)
Reticule.texture:SetVertexColor(0.1, 0.7, 0.1)

local LineArray = CreateFrame("Button", "LineArray", LunacyMainFrame)
LineArray:SetPoint("CENTER")
LineArray:EnableMouse(enable)
LineArray:SetWidth(96)
LineArray:SetHeight(96)
Reticule:SetFrameStrata("MEDIUM")
LineArray:SetFrameLevel(11)

CompArrow.visible = true
CompArrow.trackMap = 1
CompArrow.trackX = 0.5
CompArrow.trackY = 0.5

--[[
--Minimap Arrow -- POI
Lunacy.destIcon = CreateFrame("Button", "LunacyDestIcon", Minimap)
Lunacy.destIcon.texture = Lunacy.destIcon:CreateTexture(nil, "ARTWORK")
Lunacy.destIcon.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\MinimapArrow")
Lunacy.destIcon:SetWidth(32)
Lunacy.destIcon:SetHeight(32)
Lunacy.destIcon.texture:SetPoint("CENTER")
Lunacy.destIcon.texture:SetVertexColor(0, 1, 0)
]]--

--Distance Text
LunacyMainFrame.Distance = LunacyMainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
LunacyMainFrame.Distance:SetText(Lunacy.Text2.." yds")
LunacyMainFrame.Distance:SetPoint("CENTER", LunacyMainFrame)
LunacyMainFrame.Distance:SetPoint("BOTTOM", LunacyMainFrame, "TOP", 0, 6)
LunacyMainFrame.Distance:SetTextColor(1,1,1,1)
LunacyMainFrame.Distance:SetFont(LunacyMainFrame.Distance:GetFont(), 12, "OUTLINE")

--Speed Text
LunacyMainFrame.Speed = LunacyMainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
LunacyMainFrame.Speed:SetText(Lunacy.Text4)
LunacyMainFrame.Speed:SetPoint("CENTER", LunacyMainFrame)
LunacyMainFrame.Speed:SetPoint("BOTTOM", LunacyMainFrame, "TOP", 0, 22)
LunacyMainFrame.Speed:SetTextColor(1,1,1,1)
LunacyMainFrame.Speed:SetFont(LunacyMainFrame.Speed:GetFont(), 12, "OUTLINE")

--Objective Text 
LunacyMainFrame.Objective = LunacyMainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
LunacyMainFrame.Objective:SetText(Lunacy.Text1)
LunacyMainFrame.Objective:SetPoint("CENTER", LunacyMainFrame)
LunacyMainFrame.Objective:SetPoint("TOP", LunacyMainFrame, "BOTTOM", 0, -6)
LunacyMainFrame.Objective:SetTextColor(1,1,1,1)
LunacyMainFrame.Objective:SetFont(LunacyMainFrame.Objective:GetFont(), 12, "OUTLINE")

--ObjectiveB Text 
LunacyMainFrame.ObjectiveB = LunacyMainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
LunacyMainFrame.ObjectiveB:SetWordWrap(true)
LunacyMainFrame.ObjectiveB:SetText(Lunacy.Text3)
LunacyMainFrame.ObjectiveB:SetPoint("CENTER", LunacyMainFrame)
LunacyMainFrame.ObjectiveB:SetPoint("TOP", LunacyMainFrame, "BOTTOM", 0, -22)
LunacyMainFrame.ObjectiveB:SetTextColor(1,1,1,1)
LunacyMainFrame.ObjectiveB:SetFont(LunacyMainFrame.ObjectiveB:GetFont(), 12, "OUTLINE")

--ObjectiveC Text 
LunacyMainFrame.ObjectiveC = LunacyMainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
LunacyMainFrame.ObjectiveC:SetWidth(175)
LunacyMainFrame.ObjectiveC:SetHeight(40)
LunacyMainFrame.ObjectiveC:SetWordWrap(true)
LunacyMainFrame.ObjectiveC:SetText(Lunacy.Text5)
LunacyMainFrame.ObjectiveC:SetPoint("CENTER", LunacyMainFrame.ObjectiveB)
LunacyMainFrame.ObjectiveC:SetPoint("TOP", LunacyMainFrame.ObjectiveB, "BOTTOM", 0, -4)
LunacyMainFrame.ObjectiveC:SetTextColor(1,1,1,1)
LunacyMainFrame.ObjectiveC:SetFont(LunacyMainFrame.ObjectiveC:GetFont(), 12, "OUTLINE")
LunacyMainFrame.ObjectiveC:SetJustifyV("TOP")

--[[
local destIcon = CreateFrame("Button", "LunacyDestIcon", minimapParent)
destIcon:SetHeight(20)
destIcon:SetWidth(20)
destIcon.icon = destIcon:CreateTexture(nil,"OVERLAY")
destIcon.icon:SetPoint("CENTER", 0, 0)
destIcon.icon:SetBlendMode("BLEND")
destIcon.icon:SetTexture("Interface\\Addons\\Lunacy\\Media\\Alpaca32")

]]--

local function StripShow(show)
	local frIdex = 0
	repeat
		if show then
			diSStrip[frIdex]:Show()
		else
			diSStrip[frIdex]:Hide()
		end
		frIdex = frIdex + 1
	until (frIdex > 5)
end

local LineSet = {}

function HideLines(a,b)
	for i=a,b do
		if LineSet[i] then
			LineSet[i]:Hide()
		end
	end
end
function ShowLines(a,b)
	for i=a,b do
		if LineSet[i] then
			LineSet[i]:Show()
		end
	end
end

function initLineSet(spell)
	if not grimoire[spell] or loco.byeLines then
		return
	end
	local num,spin,rd,degInc,rdInc = grimoire[spell].num,grimoire[spell].spin,grimoire[spell].rd,grimoire[spell].degInc
	local colorSet,connect,smooth = grimoire[spell].colorSet,grimoire[spell].connect,grimoire[spell].smooth
	local drX,drY,pulse = grimoire[spell].drX,grimoire[spell].drY,grimoire[spell].pulse
	
	if loco.cants then
		HideLines(1,loco.cants)
	end
	
	loco.spell = spell
	loco.cants = num
	loco.liNes = {}
	loco.lsSpinRate = spin or 15
	loco.lsSpinOver = nil
	loco.overTime = GetTimePreciseSec()
	loco.lsOFFset = loco.lsOFFset or 0
	loco.lsConnect = connect
	loco.colorSet = colorSet or "CandyApple"
	loco.lineClr = grimoire[spell].lineClr
	loco.drX = drX
	loco.drY = drY
	loco.rube = grimoire[spell].rube
	loco.pulse = pulse
	loco.funcX = grimoire[spell].funcX
	loco.funcY = grimoire[spell].funcY
	loco.dippX = grimoire[spell].dippX
	loco.dippY = grimoire[spell].dippY
	loco.lineAlpha = loco.lineAlpha or 0.11
	loco.lsRadAdjX = grimoire[spell].lsRadAdjX or 1.37
	loco.lsRadAdjY = grimoire[spell].lsRadAdjY or 1.11
	loco.lsSkew = grimoire[spell].lsSkew or 31
	loco.gyreVert = grimoire[spell].gyreVert
	loco.gyreTex = grimoire[loco.spell].gyreTex or "LunacyA"
	loco.trOll = grimoire[loco.spell].trOll or 21723 --M'grgle
	
	loco.lsRotSmooth = smooth
	loco.lsStep = degInc
	loco.lsRad = rd or 11
	loco.lsRadInc = rdInc or 0
	
	if loco.gyreVert then
		r,g,b = hex2rgb(GetHexColor(loco.gyreVert))
		LunacyGyre.texture:SetVertexColor(r/255, g/255, b/255)
	end
	
	if loco.trOll then
		--print("troll")
		sandy:SetDisplayInfo(loco.trOll)
		if grimoire[spell].doMMy then
			r,g,b = hex2rgb(GetHexColor(grimoire[spell].doMMy))
			Lunadometer.texture:SetVertexColor(r/255, g/255, b/255)
			LunacyFrameA.texture:SetVertexColor(r/255, g/255, b/255)
		elseif loco.dommy then
			r,g,b = hex2rgb(GetHexColor(loco.dommy))
			Lunadometer.texture:SetVertexColor(r/255, g/255, b/255)
			LunacyFrameA.texture:SetVertexColor(r/255, g/255, b/255)
		else
			LunacyFrameA.texture:SetVertexColor(0, 0.75, 0.75)
			Lunadometer.texture:SetVertexColor(0, 0.75, 0.75)
		end
		if grimoire[spell].trOck then
			local trock = grimoire[spell].trOck
			sandy:SetPoint("TOPLEFT", LunacyFrameB, "TOPLEFT", trock.offX, trock.offY)
			if trock.anim and sandy:HasAnimation(trock.anim) then
				sandy:SetAnimation(trock.anim)
			end
			sandy:SetRotation(math.rad(trock.rot))
			sandy:SetCamDistanceScale(trock.camdis)
		elseif spell == "Scarlet" then
			if sandy:HasAnimation(69) then
				sandy:SetPoint("TOPLEFT", LunacyFrameB, "TOPLEFT", 15, -18)
				sandy:SetAnimation(69)
				sandy:SetRotation(math.rad(180))
				sandy:SetCamDistanceScale(0.88)
				sandy:SetDoBlend(true)
				sandy:ZeroCachedCenterXY()
				--sandy:SetPortraitZoom(100)
				--sandy:SetPoint("TOPLEFT", LunacyFrameB, "TOPLEFT", 15, -8)
				
			end
		else
			sandy:SetAnimation(0)
			sandy:SetRotation(0)
			sandy:SetCamDistanceScale(1)
			sandy:SetPoint("TOPLEFT", LunacyFrameB, "TOPLEFT", 15, -8)
		end
	end
	
	--local rdX
	for i=1,num do
		loco.liNes[i] = loco.liNes[i] or {}
		--loco.liNes[i].x1 = loco.liNes[i].x1 or (math.random(77) - 37)
		--loco.liNes[i].y1 = loco.liNes[i].y1 or (math.random(77) - 37)
		--loco.liNes[i].x2 = loco.liNes[i].x2 or (math.random(77) - 37)
		--loco.liNes[i].y2 = loco.liNes[i].y2 or (math.random(77) - 37)
		loco.liNes[i].rdA = loco.lsRad + loco.lsRadInc * i
		loco.liNes[i].angA = i * loco.lsStep
		loco.liNes[i].rdB = loco.lsRad + loco.lsRadInc * i
		loco.liNes[i].angB = (i + 1) * loco.lsStep
		if loco.lsConnect then
			if i > 1 and i < num then
				loco.liNes[i].rdA = loco.liNes[i-1].rdB
				loco.liNes[i].angA = loco.liNes[i-1].angB
				loco.liNes[i].rdB = loco.lsRad + loco.lsRadInc * i
				loco.liNes[i].angB = (i + 1) * loco.lsStep
			elseif i == num then
				loco.liNes[i].rdA = loco.liNes[i-1].rdB
				loco.liNes[i].angA = loco.liNes[i-1].angB
				loco.liNes[i].rdB = loco.liNes[1].rdA
				loco.liNes[i].angB = loco.liNes[1].angA
			else
				loco.liNes[i].rdA = loco.lsRad + loco.lsRadInc * i
				loco.liNes[i].angA = (i + 1) * loco.lsStep
				loco.liNes[i].rdB = loco.lsRad + loco.lsRadInc * (i+1)
				loco.liNes[i].angB = (i + 2) * loco.lsStep
			end
		end
		loco.liNes[i].x1 = math.cos(math.rad(loco.liNes[i].angA)) * loco.liNes[i].rdA
		loco.liNes[i].y1 = math.sin(math.rad(loco.liNes[i].angA)) * loco.liNes[i].rdA
		loco.liNes[i].x2 = math.cos(math.rad(loco.liNes[i].angB)) * loco.liNes[i].rdB
		loco.liNes[i].y2 = math.sin(math.rad(loco.liNes[i].angB)) * loco.liNes[i].rdB
		
		if type(colorSet) == "table" then
			loco.liNes[i].color = colorSet[mod(i,#colorSet)]
		else
			loco.liNes[i].color = loco.lineClr
		end
		--loco.liNes[i].color = loco.lsDefClr or "CandyApple"
		if not LineSet[i] then
			LineSet[i] = LineArray:CreateLine("GyreLine_A", "ARTWORK")
		end
		--LineSet[i]:SetColorTexture(math.random(255)/255, math.random(255)/255, math.random(255)/255)
		local r,g,b = hex2rgb(GetHexColor(loco.liNes[i].color or "Shamrock"))
		LineSet[i]:SetColorTexture(r/255, g/255, b/255, 0.77)
		LineSet[i]:SetDrawLayer("ARTWORK", 5)
		LineSet[i]:SetBlendMode("BLEND")
		LineSet[i]:SetStartPoint("CENTER", loco.liNes[i].x1, loco.liNes[i].y1) -- start topleft
		LineSet[i]:SetEndPoint("CENTER", loco.liNes[i].x2, loco.liNes[i].y2)  -- end bottomright
		--LineSet[i]:SetColorTexture(r, g, b)
		LineSet[i]:SetThickness(1)	
		LineSet[i]:Show()
	end

	LunacyGyre.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\"..loco.gyreTex)
	r,g,b = hex2rgb(GetHexColor(loco.gyreVert or "Vixen"))
	LunacyGyre.texture:SetVertexColor(r/255, g/255, b/255)

	loco.lsShown = true
end

local function init_lines()
	if loco.byeLines then
		return
	end
	--initLineSet(num,spin,degInc,rd,rdInc,colorSet,connect,smooth,driftX,driftY)
	local drX,drY = {}, {}
	
	drX.a = -11
	drX.b = 11
	drX.x = 9
	drX.pong = 1
	drX.relax = 0.003
	drX.decay = GetTimePreciseSec() + 60 -- sets effect to decay in 60 seconds
	
	drY.a = -11
	drY.b = 11
	drY.y = 0
	drY.pong = 0.5
	drY.relax = 0.001
	drY.decay = GetTimePreciseSec() + 60 -- sets effect to decay in 60 seconds
	
	initLineSet(loco.spell or "Vixen")
	--initLineSet("Vixen")
	linesUP = true
	--initLineSet(27,18,234,27,nil,"CandyApple")
	--initLineSet(27,66,72,12,nil,"CandyApple",nil,nil,drX,drY)
	
	--initLineSet(27,33,39,12,0.37,{"CandyApple","NeonYellow","White"},nil,true,drX,drY)
end

local function lineset_update()
	if loco.byeLines then
		return
	end
	loco.lsLastUpdate = loco.lsLastUpdate or GetTimePreciseSec()
	if GetTimePreciseSec() - loco.lsLastUpdate < 0.09 then
		return
	end
	local rotmeth
	if loco.lsRotSmooth then
		rotmeth = loco.lsSpinRate
	else
		loco.lsOFFset = loco.lsOFFset + loco.lsSpinRate
		if loco.lsOFFset > 360 then
			loco.lsOFFset = loco.lsOFFset - 360
		elseif loco.lsOFFset < -360 then
			loco.lsOFFset = loco.lsOFFset + 360
		end
		rotmeth = loco.lsOFFset
	end
	if loco.lsSpinOver then
		if loco.lsLastUpdate - loco.overTime > 1.23 then
			loco.lsSpinOver = nil
		else
			rotmeth = rotmeth + loco.lsSpinOver
		end
	end
	if loco.lsShown then
		local rdA,rdB,angA,angB
		local r,g,b
		local locNins = loco.liNes
		for i,v in pairs(locNins) do
			rdA,rdB,angA,angB=v.rdA,v.rdB,v.angA,v.angB
			angA = angA + rotmeth + loco.lsSkew
			if angA > 360 then
				angA = angA - 360
			elseif angA < -360 then
				angA = angA + 360
			end
			loco.liNes[i].angA = angA
			----------------------------
			angB = angB + rotmeth --+ loco.lsSkew
			if angB > 360 then
				angB = angB - 360
			elseif angB < -360 then
				angB = angB + 360
			end
			loco.liNes[i].angB = angB
			--loco.liNes[i].x1 = math.cos(math.rad(loco.liNes[i].angA)) * loco.liNes[i].rdA
			--loco.liNes[i].y1 = math.sin(math.rad(loco.liNes[i].angA)) * loco.liNes[i].rdA
			--loco.liNes[i].x2 = math.cos(math.rad(loco.liNes[i].angB)) * loco.liNes[i].rdB
			--loco.liNes[i].y2 = math.sin(math.rad(loco.liNes[i].angB)) * loco.liNes[i].rdB
			local pls = 1
			if loco.pulse then
				loco.pulse.cnt = loco.pulse.cnt - loco.pulse.amt
				if loco.pulse.cnt < loco.pulse.tgt then
					loco.pulse.cnt = loco.pulse.tgt
					loco.pulse.amt = loco.pulse.amt * -1
				elseif loco.pulse.cnt > 1 then
					loco.pulse.cnt = 1
					loco.pulse.amt = loco.pulse.amt * -1
				end
				pls = loco.pulse.cnt
			end
			
			if loco.drY then
				loco.drY.y = loco.drY.y + loco.drY.pong
				if loco.drY.relax then
					if loco.drY.pong < 0 then
						loco.drY.pong = loco.drY.pong + loco.drY.relax
					elseif loco.drY.pong > 0 then
						loco.drY.pong = loco.drY.pong - loco.drY.relax
					end
				end
				if loco.drY.y < loco.drY.a then
					loco.drY.pong = loco.drY.pong * -1
					loco.drY.y = loco.drY.a
				elseif loco.drY.y > loco.drY.b then
					loco.drY.pong = loco.drY.pong * -1
					loco.drY.y = loco.drY.b
				end
				if loco.rube and 700 then
						loco.liNes[i].y1 = math.sin(loco.liNes[i].angA) * loco.liNes[i].rdA * pls * loco.lsRadAdjY + loco.drY.y
						loco.liNes[i].y2 = math.sin(loco.liNes[i].angB) * loco.liNes[i].rdB * pls * loco.dippY * loco.lsRadAdjY + loco.drY.y
				else
					if grimoire[loco.spell].funcY then
						loco.liNes[i].y1 = grimoire[loco.spell].funcY(loco.liNes[i].angA, loco.liNes[i].rdA, rotmeth, i) * pls * loco.lsRadAdjY + loco.drY.y
						loco.liNes[i].y2 = grimoire[loco.spell].funcY(loco.liNes[i].angB, loco.liNes[i].rdB, rotmeth, i) * pls * loco.dippY * loco.lsRadAdjY + loco.drY.y
					else
						loco.liNes[i].y1 = math.sin(math.rad(loco.liNes[i].angA)) * loco.liNes[i].rdA * pls * loco.lsRadAdjY + loco.drY.y
						loco.liNes[i].y2 = math.sin(math.rad(loco.liNes[i].angB)) * loco.liNes[i].rdB * pls * loco.dippY * loco.lsRadAdjY + loco.drY.y
					end
				end
			else
				if loco.rube and 700 then
					loco.liNes[i].y1 = math.sin(loco.liNes[i].angA) * loco.liNes[i].rdA * pls * loco.lsRadAdjY
					loco.liNes[i].y2 = math.sin(loco.liNes[i].angB) * loco.liNes[i].rdB * pls * loco.dippY * loco.lsRadAdjY
				else
					if grimoire[loco.spell].funcY then
						loco.liNes[i].y1 = grimoire[loco.spell].funcY(loco.liNes[i].angA, loco.liNes[i].rdA, rotmeth, i) * pls * loco.lsRadAdjY
						loco.liNes[i].y2 = grimoire[loco.spell].funcY(loco.liNes[i].angB, loco.liNes[i].rdB, rotmeth, i) * pls * loco.dippY * loco.lsRadAdjY
					else
						loco.liNes[i].y1 = math.sin(math.rad(loco.liNes[i].angA)) * loco.liNes[i].rdA * pls * loco.lsRadAdjY
						loco.liNes[i].y2 = math.sin(math.rad(loco.liNes[i].angB)) * loco.liNes[i].rdB * pls * loco.dippY * loco.lsRadAdjY
					end
				end
			end
			
			if loco.drX then
				loco.drX.x = loco.drX.x + loco.drX.pong
				if loco.drX.relax then
					if loco.drX.pong < 0 then
						loco.drX.pong = loco.drX.pong + loco.drX.relax
					elseif loco.drX.pong > 0 then
						loco.drX.pong = loco.drX.pong - loco.drX.relax
					end
				end
				if loco.drX.x < loco.drX.a then
					loco.drX.pong = loco.drX.pong * -1
					loco.drX.x = loco.drX.a
				elseif loco.drX.x > loco.drX.b then
					loco.drX.pong = loco.drX.pong * -1
					loco.drX.x = loco.drX.b
				end
				if loco.rube and 007 then
					loco.liNes[i].x1 = math.cos(loco.liNes[i].angA) * loco.liNes[i].rdA * pls * loco.lsRadAdjX + loco.drX.x
					loco.liNes[i].x2 = math.cos(loco.liNes[i].angB) * loco.liNes[i].rdB * pls * loco.dippX * loco.lsRadAdjX + loco.drX.x
				else
					if grimoire[loco.spell].funcX then
						loco.liNes[i].x1 = grimoire[loco.spell].funcX(loco.liNes[i].angA, loco.liNes[i].rdA, rotmeth, i) * pls * loco.lsRadAdjX + loco.drX.x
						loco.liNes[i].x2 = grimoire[loco.spell].funcX(loco.liNes[i].angB, loco.liNes[i].rdB, rotmeth, i) * pls * loco.dippX * loco.lsRadAdjX + loco.drX.x
					else
						loco.liNes[i].x1 = math.cos(math.rad(loco.liNes[i].angA)) * loco.liNes[i].rdA * pls * loco.lsRadAdjX + loco.drX.x
						loco.liNes[i].x2 = math.cos(math.rad(loco.liNes[i].angB)) * loco.liNes[i].rdB * pls * loco.dippX * loco.lsRadAdjX + loco.drX.x
					end
				end
			else
				if loco.rube and 007 then
					loco.liNes[i].x1 = math.cos(loco.liNes[i].angA) * loco.liNes[i].rdA * pls * loco.lsRadAdjX
					loco.liNes[i].x2 = math.cos(loco.liNes[i].angB) * loco.liNes[i].rdB * pls * loco.dippX * loco.lsRadAdjX
				else
					if grimoire[loco.spell].funcX then
						loco.liNes[i].x1 = grimoire[loco.spell].funcX(loco.liNes[i].angA, loco.liNes[i].rdA, rotmeth, i) * pls * loco.lsRadAdjX
						loco.liNes[i].x2 = grimoire[loco.spell].funcX(loco.liNes[i].angB, loco.liNes[i].rdB, rotmeth, i) * pls * loco.dippX * loco.lsRadAdjX
					else
						loco.liNes[i].x1 = math.cos(math.rad(loco.liNes[i].angA)) * loco.liNes[i].rdA * pls * loco.lsRadAdjX
						loco.liNes[i].x2 = math.cos(math.rad(loco.liNes[i].angB)) * loco.liNes[i].rdB * pls * loco.dippX * loco.lsRadAdjX
					end
				end
			end
			
			LineSet[i]:SetStartPoint("CENTER", loco.liNes[i].x1, loco.liNes[i].y1) -- start topleft
			LineSet[i]:SetEndPoint("CENTER", loco.liNes[i].x2, loco.liNes[i].y2)  -- end bottomright
			--loco.lineAlpha
			r,g,b = hex2rgb(GetHexColor(loco.liNes[i].color or "Shamrock"))
			LineSet[i]:SetColorTexture(r/255, g/255, b/255, loco.lineAlpha)
		end
		if loco.drY and loco.drY.decay then
			if loco.lsLastUpdate - loco.drY.decay > 0.33 then
				loco.drY = nil
			end
		end
		if loco.drX and loco.drX.decay then
			if loco.lsLastUpdate - loco.drX.decay > 0.33 then
				loco.drX = nil
			end
		end
	end
	loco.lsLastUpdate = GetTimePreciseSec()
end

local function frame_update()
	if loco.idx == 0 then
		loco.lineAlpha = 1.0
		CompArrow:Hide()
		sandy:Hide()
		StripShow()
		Lunadometer:Hide()
		LunacyFrameA:Hide()
		if not loco.bubble then
			LunacyFrameC:Hide()
		end
		LunacyGyre:Show()
	elseif loco.idx == 1 then
		LunacyGyre:Hide()
		loco.lineAlpha = 0.21
		StripShow(true)
		sandy:Show()
		LunacyFrameA.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\CompassG")
		CompArrow.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\ArrowB")
		CompArrow:Show()
		Lunadometer:Show()
		LunacyFrameA:Show()
		if loco.bubble then
			LunacyFrameC:Show()
		end
		--LunacyFrameC:Show()
		ToggleTracking("stop")
	elseif loco.idx == 2 then
		LunacyGyre:Hide()
		loco.lineAlpha = 0.11
		StripShow()
		sandy:Hide()
		LunacyFrameA.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\CompassA")
		CompArrow.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\Arrow")
		LunacyFrameA:Show()
		if loco.bubble then
			LunacyFrameC:Show()
		end
		CompArrow:Show()
	end
	--LunacyGyre:Hide()
	
	if loco.clrGROup and loco.clRDex then
		raInBow(loco.clrGROup, loco.clRDex)
		local r,g,b = hex2rgb(GetHexColor(loco.coLor))
		CompArrow.texture:SetVertexColor(r/255, g/255, b/255, 1)
	end
end

function GyreToggle() --deprecate
	if loco.idx ~= 0 then
		PlaySoundFile("Interface\\Addons\\Lunacy\\Media\\Ping.mp3")
		LunacyGyre:Hide()
		CompArrow:Show()
		Lunadometer:Show()
		LunacyFrameA:Show()
		LunacyFrameC:Show()
		--loco.idx = loco.prevDex or 1
		loco.isTracking = true
		--if loco.idx == 1 then
			
		--else
			
		--end
		frame_update()
	else
		loco.isTracking = true
		--loco.prevDex = loco.idx
		--loco.idx = 0
		LunacyFrameA:Hide()
		Lunadometer:Hide()
		LunacyFrameC:Hide()
		StripShow()
		sandy:Hide()
		CompArrow:Hide()
		LunacyGyre:Show()
		Ramble(colorMe("~Peer into the Gyre if you dare~ ", "CandyApple"), colorMe("[Gyre] ", "Purple"))
	end
end

LunacyFrameB:SetScript("OnMouseDown", function (self, button)
	loco.touchingMe = loco.touchingMe or GetTimePreciseSec()
	--if not loco.touchingMe then
		--loco.touchingMe = GetTimePreciseSec()
	--end
	if button == "LeftButton" and IsLeftShiftKeyDown() then
		loco.idx = loco.idx + 1
		if loco.idx > 2 then
			loco.idx = 0
		end
		frame_update()

		loco.destCheck = nil
		
		PlaySoundFile(sounds[loco.idx+1])
		
		loco.hasTrack = ""
		loco.trackType = trackType[loco.idx+1]
		loco.lock = false
		
		if loco.idx == 0 then
			Ramble(colorMe("Gyre Mode", "Indigo"), colorMe("[Compass]", "Silver"))
			loco.isTracking = true
			--GyreToggle()
		elseif loco.idx == 1 then
			Ramble(colorMe("Odometer Mode", "NeonYellow"), colorMe("[Compass]", "Bronze"))
			--print("|cff00ffffLunacy |cfffffffftracking off.")
			loco.isTracking = true
			ToggleTracking("start")
			UpdateTrack()
		else
			print("|cff00ffffLunacy |cfffffffftracking type changed to |cffff0000"..trackType[loco.idx].."|cffffffff.")
			loco.isTracking = true
			ToggleTracking("start")
			UpdateTrack()
		end
	elseif button == "LeftButton" and IsControlKeyDown() then
		--forceArrival = true
		
		if loco.idx == 0 then
			if not loco.clrLock and loco.coLor then
				colorFeed(loco.coLor, 5)
			end
		elseif loco.murgle and loco.idx == 1 then
			loco.murgle = nil
			if L_DBG >= 1 then
				Ramble(colorMe("Tracking Total Distance", "NeonYellow"),colorMe("[~murgle~] ", "Mulberry"))
			end
		elseif loco.idx == 1 then
			loco.murgle = 0
			if L_DBG >= 1 then
				Ramble(colorMe("Tracking Trip Distance", "NeonYellow"),colorMe("[~murgle~] ", "Mulberry"))
			end
		end
	elseif button == "LeftButton" then
		if loco.coLor and loco.cants then
			--colorFeed(loco.coLor, loco.cants)
			LunacyGyre.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\LunacyE")
			r,g,b = hex2rgb(GetHexColor(loco.coLor))
			LunacyGyre.texture:SetVertexColor(r/255, g/255, b/255)
			--sandy:SetDisplayInfo(26375)
			--colorFeed("SpaceCadet", 2)
			LunacyGyre:Show()
			--loco.flashTime = GetTimePreciseSec() - 0.11
		end
		LunacyMainFrame:StartMoving()
	elseif button == "RightButton" and not IsLeftShiftKeyDown() then
		if loco.wsCnt and loco.wsCnt > 0 and not C_SuperTrack.GetSuperTrackedQuestID() then
			ClearTrack()
			--FlashMe("Vixen")
		else
			PlaySoundFile("Interface\\Addons\\Lunacy\\Media\\Ping.mp3")
			if L_DBG >= 2 then
				Ramble(colorMe(tostring(loco.lucky), "NeonYellow"),colorMe("[~lucky~] ", "Shamrock"))
				Ramble(colorMe(tostring(loco.diSTurbed), "NeonYellow"),colorMe("[~diSTurbed~] ", "Violet"))
			end
			UpdateTrack()
		end
		loco.sandyRot = 0
		--loco.lucky = loco.lucky - 7
		--loco.diSTurbed = loco.diSTurbed + 0.66
		if L_DBG >= 7 then
			local st = colorMe("♠", "Black")..colorMe("♥", "Red")..colorMe("♣", "Black")..colorMe("♦", "Red")
			if loco.lucky/(loco.diSTurbed or 6.9) >= 7 then
				Ramble(st..colorMe(" Magically ", loco.lineClr or "Mulberry")..colorMe(" →", "White")..colorMe(math.floor(loco.lucky), "Shamrock")..colorMe("← ", "White")..colorMe("Delicious! ", "White")..st)
			else
				Ramble(st..colorMe(" Fuck ", "Scarlet")..colorMe(" →", "Chartreuse")..colorMe(math.floor(loco.diSTurbed), "Indigo")..colorMe("← ", "Chartreuse")..colorMe("ÎYouÎ ", "Scarlet")..st)
			end
		end
		initLineSet(loco.spell)
		--FlashMe("Vixen")
		--UpdateTrack()
	end
end)

LunacyFrameB:SetScript("OnMouseUp", function (self, button)
	loco.touchingMe = nil
	loco.pokes = loco.pokes or 0
	loco.pokes = loco.pokes + 1
	local r,g,b
	if button == "LeftButton" and not IsControlKeyDown() then
		LunacyMainFrame:StopMovingOrSizing()
		local tt = GetTimePreciseSec()
		if tt - ddC < 0.25 then
			if LunacyFrameC:IsShown() then
				LunacyFrameC:Hide()
				loco.bubble = nil
			else
				loco.bubble = true
				LunacyFrameC:Show()
			end
			--GyreToggle()
			--Catch Double Click
		end
		loco.sandyRot = loco.sandyRot or 0
		loco.sandyRot = loco.sandyRot + 5
		sandy:SetRotation(math.rad(loco.sandyRot),true)
		local rnd = math.random(111)
		if loco.pokes >= rnd then
			rnd = loco.pokes / 77
			if loco.spell and grimoire[loco.spell] and grimoire[loco.spell].snarks then
				local x = math.floor(#grimoire[loco.spell].snarks * rnd) + 1
				if x > #grimoire[loco.spell].snarks then
					x = #grimoire[loco.spell].snarks
				end
				print(x)
				local pick = select(x,unpack(grimoire[loco.spell].snarks))
				print(pick)
				if pick then
					PlaySoundFile(pick)
				end
			end
			loco.pokes = 0
		end
		if loco.clrLock ~= true then
			loco.coLor,loco.tAg, loco.clrGROup, loco.clRDex = GetNextColor()
			--local clr,tag = GetNextColor()
			if L_DBG >= 1 then
				Ramble(colorMe(loco.coLor, loco.coLor),"|cff00ff00[ColorMe]|r|cffa4ff77 |r")
			end
			loco.dommy = loco.coLor
			r,g,b = hex2rgb(GetHexColor(loco.coLor))
			Lunadometer.texture:SetVertexColor(r/255, g/255, b/255)
			
		elseif loco.idx == 1 then
			loco.dommy = nil
			--Lunadometer.texture:SetVertexColor(0, 0.75, 0.75)
			--loco.dommy = loco.coLor
			--r,g,b = hex2rgb(GetHexColor(loco.coLor))
			--Lunadometer.texture:SetVertexColor(r/255, g/255, b/255)
		end
		if loco.coLor and loco.cants then
			--colorFeed(loco.coLor, loco.cants)
			--LunacyGyre.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\LunacyE")
			--r,g,b = hex2rgb(GetHexColor(loco.coLor))
			--LunacyGyre.texture:SetVertexColor(r/255, g/255, b/255)
			--sandy:SetDisplayInfo(26375)
			--colorFeed("SpaceCadet", 2)
			--LunacyGyre:Show()
			loco.flashTime = GetTimePreciseSec() - 0.66
		end
		r,g,b = hex2rgb(GetHexColor(loco.coLor))
		CompArrow.texture:SetVertexColor(r/255, g/255, b/255, 1)
		ddC = tt
	elseif button == "RightButton" and IsLeftShiftKeyDown() then
		C_UI.Reload()
	end
end)

local function scuffleTime()
	if scuffle then
		if loco.spell == "Scarlet" then
			LunacyGyre.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\LunacyE")
			local r,g,b
			if loco.candyapple then
				r,g,b = hex2rgb(GetHexColor("CandyApple"))
				loco.candyapple = nil
				--print("FlashMe: Scarlet")
				
			else -- ~flip~flop~
				r,g,b = hex2rgb(GetHexColor("Black"))
				loco.candyapple = "CandyApple"
			end
			LunacyGyre.texture:SetVertexColor(r/255, g/255, b/255)
			FlashMe("Scarlet")
		else
			if not loco.candyapple or loco.candyapple ~= "Scarlet" then
				r,g,b = hex2rgb(GetHexColor("CandyApple"))
				LunacyGyre.texture:SetVertexColor(r/255, g/255, b/255)
				loco.candyapple = "Scarlet"
				Ramble(colorMe("Scarlet", "Scarlet"), colorMe("[FlashMe] ","Vixen"))
			end
			--Ramble(colorMe("Scarlet", "Vixen"), colorMe("[FlashMe] ","CandyApple"))
			FlashMe("Scarlet")
		end
		loco.scuffle = true
	elseif loco.scuffle then
		loco.candyapple = nil
		FlashMe("default")
		loco.scuffle = nil
	end
end

local function touching(updTime)
	if loco.touchingMe and (updTime - loco.touchingMe > 7) then
		loco.touchingMe = loco.touchingMe + 3 + math.random() * 11
		PlaySoundFile(568873)
	end
end

local function spindecay()
	loco.lsSpinRate = loco.lsSpinRate * 0.969696
end

function LunacyUpdateController()
	local updTime = GetTimePreciseSec()
	if loco.porting then
		if math.abs(GetTimePreciseSec() - loco.porting) > 3.69 then
			loco.porting = nil
		else
			return
		end
	end
	if LunacyMainFrame:IsShown() then
		SetPlayerFacing()
	end
	loco.pX,loco.pY,loco.pMap,loco.pWX,loco.pWY,loco.mapType,loco.pPntMap = GetPlayerPosition()
	
	if loco.updCnt / 61 == math.floor(loco.updCnt / 61) then
	
	elseif loco.updCnt / 13 == math.floor(loco.updCnt / 13) then
		touching(updTime)
	elseif loco.updCnt / 11 == math.floor(loco.updCnt / 11) then
		scuffleTime()
	elseif loco.updCnt / 9 == math.floor(loco.updCnt / 9) then
		spindecay()
	--elseif loco.updCnt / 3 == math.floor(loco.updCnt / 3) then
		
	end
	if loco.pMap then
		if loco.isTracking then
			Lunacy_Track(updTime)
		end
		lineset_update()
		DistanceRecorder()
	end
end

function Lunacy_Track(updTime)
	--if loco.porting then
		--return
	--end
	local updTime = GetTimePreciseSec()
	if loco.qUpTrk then
		if math.abs(updTime - loco.qUpTrk) > 2 then
			UpdateTrack()
			loco.qUpTrk = nil
		end
	end
	if loco.flashTime then
		if updTime - loco.flashTime > 0.77 then
			loco.flashTime = nil
			FlashMe("default")
			if loco.idx > 0 then
				LunacyGyre:Hide()
			end
		end
	end
	--[[
	loco.scuffleTime = loco.scuffleTime or 0
	if math.abs(updTime - loco.scuffleTime) > 0.39 then
		
		loco.scuffleTime = updTime
	end
	]]--
	
	if loco.spell == "Obsidian" then
		loco.haunted = loco.haunted - 0.000639
		if loco.haunted < 0.000639 then
			loco.haunted = 0.000639
		end
	end
	if math.random(13777) < 11 then
		FlashMe("Vixen")
	end
	loco.actOut = loco.actOut or updTime
	if updTime - loco.actOut > 1.69 then
		loco.active = loco.active - 0.0169
		if loco.active < 1 then
			loco.active = 1
			if loco.lineAlpha > 0.077 then
				loco.lineAlpha = loco.lineAlpha - 0.069
			end
		elseif loco.idx == 0 then
			loco.lineAlpha = 1.0
		elseif loco.idx == 1 then
			loco.lineAlpha = 0.21
		elseif loco.idx == 2 then
			loco.lineAlpha = 0.11
		end
		loco.actOut = updTime
	end
	--loco.pX,loco.pY,loco.pMap,loco.pWX,loco.pWY,loco.mapType,loco.pPntMap = GetPlayerPosition()
	--loco.trStatus = true
	if not loco.pX then
		return --porting or out of bounds in some way
	end
	
	loco.distance = C_Navigation.GetDistance() or 0
	if loco.inQBlob then
		loco.distance = 0
	end
	
	if not loco.distance or loco.distance == 0 then
		loco.distance = HBD:GetWorldDistance(loco.pPntMap, loco.pWX, loco.pWY, loco.trWX, loco.trWY)
	end
	
	if loco.trStatus then
		loco.trWX, loco.trWY = HBD:GetWorldCoordinatesFromZone(loco.trX, loco.trY, loco.trMap)
		if loco.pMap ~= loco.trMap then
			loco.angle = HBD:GetWorldVector(loco.pPntMap, loco.pWX, loco.pWY, loco.trWX, loco.trWY)
			loco.angle = loco.angle or 0
			loco.angle = loco.angle + math.rad(180)
			loco.aMeth = "oranges"
		else
			loco.angle = HBD:GetWorldVector(loco.pPntMap, loco.pWX, loco.pWY, loco.trWX, loco.trWY)
			--loco.angle = HBD:GetWorldVector(loco.pMap, loco.pX, loco.pY, loco.trX, loco.trY)
			--loco.angle = GetAngle(loco.pMap, loco.pX, loco.pY, loco.trX, loco.trY)
			loco.angle = loco.angle or 0
			loco.angle = loco.angle + math.rad(180)
			loco.aMeth = "apples"
		end
	end
	
	if loco.trX then
		--distance = sqrt(C_QuestLog.GetDistanceSqToQuest(stqID))
		loco.pF = GetPlayerFacing()
		if not loco.pF then
			loco.pF = 1
			Lunacy.inInstance = true
		else
			Lunacy.inInstance = false
		end
		
		
		if loco.stqID and qComp[loco.stqID] then
			Lunacy.Text1 = "|cff00ff00"..tostring(loco.objTxt).."|r"
		elseif loco.stqID then
			Lunacy.Text1 = loco.objTxt
		end
		--Lunacy.Text1 = loco.objTxt
		
		if C_SuperTrack.IsSuperTrackingUserWaypoint() and loco.wayDesc then
			--Lunacy.Text3 = loco.wayDesc
		else
			Lunacy.Text3 = loco.tarZone
		end
		
		loco.distance = loco.distance or 0
		loco.distance = floor(loco.distance * 100) / 100
		
		local dis = string.format("%.2f yds", loco.distance)
		
		if loco.pMap ~= loco.trMap then
			if loco.pPntMap ~= loco.trPntMap then
				--Lunacy.Text2 = "|cffff0000 "..tostring(dis).."|r"
				Lunacy.Text2 = colorMe(tostring(dis), "CandyApple")
				Lunacy.Text3 = colorMe(Lunacy.Text3, "CandyApple")
			else
				--Lunacy.Text2 = "|cffffff00 "..tostring(dis).."|r"
				Lunacy.Text2 = colorMe(tostring(dis), "NeonYellow")
				Lunacy.Text3 = colorMe(Lunacy.Text3, "NeonYellow")
			end
		else
			--Lunacy.Text2 = "|cff00ff00 "..tostring(dis).."|r"
			Lunacy.Text2 = colorMe(tostring(dis), "Harlequin")
			Lunacy.Text3 = colorMe(Lunacy.Text3, "Harlequin")
		end
		
		if (loco.distance < destRadius and loco.destCheck == true) or forceArrival then
			loco.destCheck = nil
			if loco.wsCnt > 0 then
				loco.wayStack[loco.wsCnt] = nil
				--loco.wsCnt = loco.wsCnt - 1
				if L_DBG >= 2 or L_DBF["Lunacy_Track"] then
					--[Whereis] X: x Y: y
					Ramble(colorMe("wayStack-: ", "Crimson")..colorMe(tostring(loco.wsCnt), "White"), colorMe("[Lunacy_Track] ", "SignalYellow"))
				end
				ClearTrack()
			else
				forceArival = nil
				loco.urWay = nil
				pWay = nil
				loco.trX = nil
				loco.pinOvr = nil
				loco.destCheck = nil
				C_Map.ClearUserWaypoint()
				C_SuperTrack.SetSuperTrackedUserWaypoint(false)
				print("|cff00ffffclear user waypoint|r")
				if trackType[loco.idx] == "elders" then
					Lunacy[playerKey].elders[loco.elderCont] = Lunacy[playerKey].elders[loco.elderCont] or {}
					Lunacy[playerKey].elders[loco.elderCont][loco.elder] = true
				end
				Lunacy.Text1 = "|cffda1877/.^.\\|r"
				Lunacy.Text2 = "|cff11cc11\\o/|r"
				UpdateTrackerText()
				ClearTrack()
				--UpdateCompass()
			end
		end
		--UpdateTrackerText()
	else
		loco.angle = math.rad(180)
		loco.pF = 0
		
		if dbgLatch then
			print("Nothing is being tracked...")
			dbgLatch = nil
		end
	end
	
	--if loco.idx == 1 then
		--loco.angle = 4.52
	--else
		loco.angle = loco.angle - loco.pF
		loco.angle = loco.angle - math.rad(45)
	--end
	luCky_seVen()
	--loco.angle = 4.52	
	UpdateTrackerText()
	local s,c = math.sin(loco.angle) * math.sqrt(0.5), math.cos(loco.angle) * math.sqrt(0.5)
	if loco.idx > 1 then
		CompArrow.texture:SetTexCoord(0.5-s,0.5+c,0.5+c,0.5+s,0.5-c,0.5-s,0.5+s,0.5-c)
	end
	Reticule.texture:SetTexCoord(0.5-s,0.5+c,0.5+c,0.5+s,0.5-c,0.5-s,0.5+s,0.5-c)
end

local function UpdateHandler(self, elapsed)
	if not Lunacy.loaded then
		return
	end
	if Lunacy.loadDelay > 0 then
		Lunacy.loadDelay = Lunacy.loadDelay - 1
		return
	end
	Lunacy.Timer = Lunacy.Timer + elapsed
	loco.updCnt = loco.updCnt + 1
	if (Lunacy.Timer > .077) then
		if Lunacy.playerStatus ~= "loaded" then
			return
		end
		Lunacy.Timer = 0
		LunacyUpdateController()
	end
end

LunacyMainFrame:SetScript("OnUpdate", UpdateHandler)

LunacyMainFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
LunacyMainFrame:RegisterEvent("QUEST_WATCH_LIST_CHANGED")
LunacyMainFrame:RegisterEvent("VARIABLES_LOADED")
LunacyMainFrame:RegisterEvent("QUEST_TURNED_IN")
LunacyMainFrame:RegisterEvent("QUEST_ACCEPTED")
LunacyMainFrame:RegisterEvent("QUEST_LOG_CRITERIA_UPDATE")
LunacyMainFrame:RegisterEvent("QUEST_LOG_UPDATE")
LunacyMainFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
LunacyMainFrame:RegisterEvent("USER_WAYPOINT_UPDATED")
LunacyMainFrame:RegisterEvent("DYNAMIC_GOSSIP_POI_UPDATED")
LunacyMainFrame:RegisterEvent("SUPER_TRACKING_CHANGED")
LunacyMainFrame:RegisterEvent("WORLD_MAP_OPEN")
LunacyMainFrame:RegisterEvent("QUEST_TURNED_IN")
LunacyMainFrame:RegisterEvent("PLAYER_MONEY")
LunacyMainFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
LunacyMainFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
LunacyMainFrame:RegisterEvent("PLAYER_DEAD")
LunacyMainFrame:RegisterEvent("PLAYER_ALIVE")

LunacyMainFrame:SetScript("OnEvent", function(self, event, ...)
	local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8 = ...
	if (event == "SUPER_TRACKING_CHANGED") then
		loco.urWay = nil
	end
    if (event == "SUPER_TRACKING_CHANGED" or event == "QUEST_LOG_UPDATE" or
		event == "ZONE_CHANGED_NEW_AREA" or event == "QUEST_LOG_CRITERIA_UPDATE" or
		event == "QUEST_LOG_UPDATE") and trackType[loco.idx] == "quests" then
		local tYPe, tYPeID = C_SuperTrack.GetSuperTrackedMapPin()
		if (tYPe or tYPeID) and (L_DBG >= 3 or L_DBF["OnEvent"]) then
			Ramble(colorMe(tostring(tYPe), "Gold"),colorMe("[Event] ", "Purple").."tYPe: ")
			Ramble(colorMe(tostring(tYPeID), "Gold"),colorMe("[Event] ", "Purple").."tYPeID: ")
		end
		if L_DBG >= 3 or L_DBF["OnEvent"] then
			Ramble(colorMe("[Event] ", "Purple").."Tracking Changed A.")
		end
		UpdateTrack()
	elseif event == "SUPER_TRACKING_CHANGED" then
		if L_DBG >= 3 or L_DBF["OnEvent"] then
			Ramble(colorMe("[Event] ", "Purple").."Tracking Changed B.")
		end
		loco.urWay = nil
		UpdateTrack()
	elseif event == "QUEST_ACCEPTED" then
		if arg1 then
			local qLink = GetQuestLink(arg1)
			if L_DBG >= 3 or L_DBF["OnEvent"] then
				Ramble(colorMe("[Event] ", "Purple").."Quest Accepted: "..tostring(qLink))
			end
		end
	elseif event == "QUEST_TURNED_IN" then
		if arg3 and arg3 ~= 0 then
			loco.lucky = loco.lucky + arg3 * 0.000171
			loco.diSTurbed = loco.diSTurbed - arg3 * 0.000037
			FlashMe("SafetyYellow")
			mOOdleVel("SafetyYellow")
		end
	elseif event == "PLAYER_MONEY" then
		local amt = GetMoney()
		local diff = (amt - Lunacy[playerKey].gold)
		
		--loco.balance = loco.balance + diff
		if diff < 0 then
			loco.spent = loco.spent - diff
			loco.balance = loco.balance + diff
			if diff < -10000000 then
				FlashMe("Maroon") -- Luxury
			else
				FlashMe("Bone") -- The Market
			end
			Ramble(GetMoneyString(math.abs(diff)),colorMe("[Bone] ", "Bone"))
		else
			loco.earned = loco.earned + diff
			loco.balance = loco.balance + diff
			if diff > 10000000 then
				FlashMe("Chartreuse") --Avarice
			else
				FlashMe("Gold") --Wealth
			end
			Ramble(GetMoneyString(math.abs(diff)),colorMe("[Gold] ", "Gold"))
		end
		if amt and amt ~= Lunacy[playerKey].gold then
			loco.lucky = loco.lucky + diff * 0.0000177
			if loco.lucky < 7 then
				loco.lucky = 7
				loco.diSTurbed = loco.diSTurbed + 0.7
			end
		end
		loco.active = loco.active + math.abs(diff) * 0.000000711
		mOOdleVel("Gold", amt / 100000)
		Lunacy[playerKey].gold = amt
	elseif event == "USER_WAYPOINT_UPDATED" then
		if L_DBG >= 2 or L_DBF["OnEvent"] then
			Ramble(colorMe("[Event] ", "Purple")..".User Waypoint Updated.")
		end
		if not loco.slntUpd then
			if loco.suwLock then
				if GetTimePreciseSec() - loco.suwLock < 1.2 then
					return
				else
					loco.suwLock = nil
				end
			end
			SetUserWaypoint()
		else
			loco.slntUpd = nil
		end
		--UpdateTrack()
	elseif event == "WORLD_MAP_OPEN" then
		if pokeMap then
			C_Map.CloseWorldMapInteraction()
			pokeMap = nil
		end
	elseif event == "ZONE_CHANGED_NEW_AREA" or event == "QUEST_LOG_CRITERIA_UPDATE" or event == "QUEST_LOG_UPDATE" then
		dbgLatch = true
		UpdateTrack()
		ToggleTracking("start")
	elseif event == "PLAYER_REGEN_DISABLED" then
		scuffle = true
	elseif event == "PLAYER_REGEN_ENABLED" then
		scuffle = nil
	elseif event == "PLAYER_DEAD" then
		loco.dead = true
		loco.dirtnaps = loco.dirtnaps or 0
		loco.haunted = loco.haunted or 1
		loco.dirtnaps = loco.dirtnaps + 1
		loco.haunted = loco.haunted * 1.666
		FlashMe("DeepPurple")
	elseif event == "PLAYER_ALIVE" then
		loco.dead = nil
		if loco.haunted / 2^math.random(11) > 66.6 then
			initLineSet("Obsidian")
		end
	elseif event == "PLAYER_ENTERING_WORLD" then
		loco = {}
		loco.idx = 1
		if Lunacy[playerKey] then
			if Lunacy[playerKey].loco then
				loco = Lunacy[playerKey].loco
			end
		end
		loco.wayStack = loco.wayStack or {}
		loco.wsCnt = loco.wsCnt or 0
		loco.idx = loco.idx or 0
		loco.active = loco.active or 7
		loco.haunted = loco.haunted or 0.00061
		loco.updCnt = 0
		loco.spent = loco.spent or 0
		loco.earned = loco.earned or 0
		loco.balance = loco.balance or 0
		loco.lsLastUpdate = GetTimePreciseSec()
		frame_update()
		--initLineSet(11)
		--initLineSet(num,spin,degInc,rd,rdInc,colorSet,connect,smooth,driftX,driftY)
		if not linesUP then
			init_lines()
		else
			Ramble(colorMe("~Porting?..", "Celeste"), colorMe("[Event] ", "Purple"))
			loco.porting = GetTimePreciseSec()
		end
		loco.urWay = nil
    end
end)

local function GetCenterScreenPoint()
    local centerX, centerY = WorldFrame:GetCenter()
    local scale = UIParent:GetEffectiveScale() or 1
    return centerX / scale, centerY / scale
end

function colorFeed(clr, x)
	local gHc = GetHexColor(clr)
	local r,g,b
	local lolines = {}
	if gHc then
		for i=1, #loco.liNes do
			if i <= x then
				lolines[i] = clr
				--r,g,b = hex2rgb(GetHexColor(loco.liNes[i].color or "Shamrock"))
				--LineSet[i]:SetColorTexture(r/255, g/255, b/255, loco.lineAlpha)
			else
				--print(tostring(i).." :: "..tostring(x))
				lolines[i] = loco.liNes[i-x].color
				--loco.liNes[i].color = 
				--r,g,b = hex2rgb(GetHexColor(loco.liNes[i].color or "Shamrock"))
				--LineSet[i]:SetColorTexture(r/255, g/255, b/255, loco.lineAlpha)
			end
		end
		for i=1, #loco.liNes do
			loco.liNes[i].color = lolines[i]
			r,g,b = hex2rgb(GetHexColor(loco.liNes[i].color))
			LineSet[i]:SetColorTexture(r/255, g/255, b/255, loco.lineAlpha)
		end
	else
		print("color error :: "..tostring(clr))
	end
end

function TrollMe(wITh)
	if wITh then
		wITh = tonumber(wITh)
	end
	sandy:SetDisplayInfo(wITh)
end

function FlashMe(wITh)
	local r,g,b,hand
	hand = DrawCard(wITh)
	if hand then
		if hand.gyretex then
			LunacyGyre.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\"..hand.gyretex)
		end
		if hand.gyreclr then
			r,g,b = hex2rgb(GetHexColor(hand.gyreclr))
			LunacyGyre.texture:SetVertexColor(r/255, g/255, b/255)
		end
		if hand.lineclr then
			colorFeed(hand.lineclr, hand.claps)
		end
		if hand.troll then
			sandy:SetDisplayInfo(hand.troll)
		end
		if hand.pulse then
			if tostring(hand.pulse) == "clear" then
				loco.pulse = nil
			elseif not hand.pulse.cnt then
				loco.pulse = nil
			else
				loco.pulse = hand.pulse
			end
		end
		if hand.flashtime then
			loco.flashTime = GetTimePreciseSec() + hand.flashtime
		end
		if (hand.loco and hand.locoTest and hand.locoTest()) or hand.loco then
			for k,v in pairs(hand.loco) do
				--loco[k] = v
				--print("hand.loco: "..tostring(k).." > "..tostring(v))
				if (k == "drY" or k =="drX") and type(v) == "table" then
					loco[k] = {}
					for sk,sv in pairs(v) do
						if sk == "decay" then
							print(sv)
							loco[k][sk] = GetTimePreciseSec() + sv
							print(loco[k][sk])
						else
							loco[k][sk] = sv
						end
					end
					--local n = GetTimePreciseSec() + v.decay
					--print(n)
					--print(GetTimePreciseSec())
					--loco[k].decay = n
					Ramble(colorMe("hand.", "Alabaster")..colorMe(k, "Shamrock")..colorMe(": ", "Alabaster")..colorMe(tostring(loco[k].decay), "BrightMint"),colorMe("[Gyre] ", "Purple"))
					--print(v.decay)
					--print(v.relax)
				elseif k == "flashTime" then
					loco[k] = GetTimePreciseSec() + v
				else
					loco[k] = v
				end
			end
			
		--elseif hand.loco then
			--for k,v in pairs(hand.loco) do
				--loco[k] = v
			--end
		end
		LunacyGyre:Show()
		if hand.card then
			local key = hand.card.house
			loco[key] = loco[key] or 0
			if hand.card.flip then
				loco[key] = loco[key] + hand.card.flip() or 1
			else
				loco[key] = loco[key] + 1
			end
			if math.random(hand.card.affinity) < loco[key] and loco.spell ~= caPit(key) then
				loco[key] = 0
				local pick = select(math.random(4), unpack(grimoire[caPit(key)].snarks))
				PlaySoundFile(pick)
				if hand.card.avatar then
					sandy:SetDisplayInfo(hand.card.avatar)
				end
				if hand.card.suit then
					initLineSet(hand.card.suit)
				end
				if hand.card.loco then
					for k,v in pairs(hand.card.loco) do
						loco[k] = v
					end
				end
			end
		end
		
		if hand.overTime then
			loco.overTime = GetTimePreciseSec() + hand.overTime
		end
		if hand.active then
			loco.active = loco.active + hand.active
		end
		if hand.sigil then
			loco.sigil = hand.sigil --\ox
		end
		if hand.cast then
			if type(hand.cast) == "table" then
				loco.cast = hand.cast[math.random(#hand.cast)] -- ~gnarly~
			else
				loco.cast = hand.cast
			end
		end
		if hand.diSTurbed then
			--loco.diSTurbed = loco.diSTurbed * (1 - math.random() * 0.00313)
			loco.diSTurbed = hand.diSTurbed(loco.diSTurbed)
		end
		if type(hand.lucky) == "number" then
			loco.lucky = loco.lucky + hand.lucky
		elseif type(hand.lucky) == "function" then
			--loco.diSTurbed = loco.diSTurbed * (1 - math.random() * 0.00313)
			loco.lucky = hand.lucky(loco.lucky)
			if L_DBG >= 4 then
				Ramble(colorMe("~^~] Lucky Doo HooDoo thats Hoooooo~ (", "Alabaster")..colorMe(tostring(loco.lucky), "Chartreuse")..colorMe(")", "Alabaster"), colorMe("[LuckyDoo] ", "Shamrock"))
			end
		end
		--loco.lucky = loco.lucky * (1 + math.random() * 0.00131)
	end
	if wITh == "XXXX" then -- Marl
		--LunacyGyre.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\LunacyB")
		LunacyGyre.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\LunacyE")
		r,g,b = hex2rgb(GetHexColor("SpaceCadet"))
		LunacyGyre.texture:SetVertexColor(r/255, g/255, b/255)
		sandy:SetDisplayInfo(26375) -- Didi the Wrench
		colorFeed("SpaceCadet", 2)
		LunacyGyre:Show()
		loco.flashTime = GetTimePreciseSec() + 7
		loco.active = loco.active + 0.333
	elseif wITh == "Skipper" then
		--sandy:SetDisplayInfo(21723)
		LunacyGyre.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\LunacyE")
		r,g,b = hex2rgb(GetHexColor("Avocado"))
		LunacyGyre.texture:SetVertexColor(r/255, g/255, b/255)
		sandy:SetDisplayInfo(158685)
		colorFeed("Avocado", 3)
		LunacyGyre:Show()
		loco.flashTime = GetTimePreciseSec() + 7
		loco.active = loco.active + 7.77
	--War
	elseif wITh == "Scarlet" then
		--sandy:SetDisplayInfo(21723)
		--LunacyGyre:Show()
		--[[
		if loco.spell ~= "Scarlet" then
			loco.dippX = 0.77
			loco.dippY = 0.77
			loco.drX = nil
			loco.drY = nil
			loco.pulse = {}
			loco.pulse.cnt = 1
			loco.pulse.amt = 0.03
			loco.pulse.tgt = 0.44
			LunacyGyre:Show()
			loco.flashTime = GetTimePreciseSec() + 3
		end
		
		--LunacyGyre:Show()
		if loco.spell ~= "Scarlet" then
			loco.diSTurbed = loco.diSTurbed + 0.169
		end
		
		
		loco.scarlet = loco.scarlet or 0
		loco.scarlet = loco.scarlet + (0.169 + loco.diSTurbed / 961)
		if math.random(3696) < loco.scarlet and loco.spell ~= "Scarlet" then
			loco.scarlet = 0
			local pick = select(math.random(#grimoire.Scarlet.snarks), unpack(grimoire.Scarlet.snarks))
			PlaySoundFile(pick)
			sandy:SetDisplayInfo(68967) --Lunara
			initLineSet("Scarlet")
		end
		
		colorFeed(loco.candyapple or "Black", 1)
		loco.active = loco.active + 0.0169
		
		loco.diSTurbed = loco.diSTurbed * (1 - math.random() * 0.00313)
		loco.lucky = loco.lucky * (1 + math.random() * 0.00131)
		]]--

	elseif wITh == "Maroon" then
		loco.dippX = 0.66
		loco.dippY = 0.33
		loco.drX = nil
		loco.drY = nil
		loco.pulse = {}
		loco.pulse.cnt = 1
		loco.pulse.amt = 0.02
		loco.pulse.tgt = 0.42
		LunacyGyre.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\LunacyE")
		r,g,b = hex2rgb(GetHexColor("Maroon"))
		LunacyGyre.texture:SetVertexColor(r/255, g/255, b/255)
		loco.diSTurbed = loco.diSTurbed * (1 + math.random() * 0.0666)
		loco.lucky = loco.lucky * (1 - math.random() * 0.0777)
		if L_DBG >= 2 then
			local st = colorMe("♠", "Black")..colorMe("♥", "Red")..colorMe("♣", "Black")..colorMe("♦", "Red")
			if loco.lucky/(loco.diSTurbed or 6.9) >= 7 then
				Ramble(st..colorMe(" ÎGood", loco.lineClr or "Mulberry")..colorMe(" →", "White")..colorMe(math.floor(loco.lucky), "Shamrock")..colorMe("← ", "White")..colorMe("JobÎ ", "White")..st,colorMe("[Gyre] ", "Purple"))
			else
				Ramble(st..colorMe(" ÎOuchÎ ", "Scarlet")..colorMe(" →", "Chartreuse")..colorMe(math.floor(loco.diSTurbed), "Indigo")..colorMe("← ", "Chartreuse")..st,colorMe("[Gyre] ", "Purple"))
			end
		end
		colorFeed("Maroon", 1)
		LunacyGyre:Show()
		loco.flashTime = GetTimePreciseSec() + 1
	--Nature
	--[[
	elseif wITh == "Spring" then
		LunacyGyre.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\LunacyE")
		r,g,b = hex2rgb(GetHexColor("Spring"))
		LunacyGyre.texture:SetVertexColor(r/255, g/255, b/255)
		colorFeed("Spring", 3)
		if loco.drY then
			loco.drY.decay = (loco.drY.decay * 1.001) + 5
			loco.drY.relax = (loco.drY.relax * 1.07) + 0.0021
		else
			loco.drY = {}
			loco.drY.a = -9
			loco.drY.b = 9
			loco.drY.y = 9
			loco.drY.pong = 1
			loco.drY.relax = 0.00023
			loco.drY.decay = GetTimePreciseSec() + 23
		end
		
		loco.verdant = loco.verdant or 0
		loco.verdant = loco.verdant + 1
		if math.random(99) < loco.verdant and loco.spell ~= "Verdant" then
			loco.verdant = 0
			local pick = select(math.random(4), unpack(grimoire.Verdant.snarks))
			PlaySoundFile(pick)
			sandy:SetDisplayInfo(37154) --Lunara
			initLineSet("Verdant")
		end
		--if math.random(9) > 6 and loco.spell ~= "Verdant" then
			--initLineSet("Verdant")
		--end
		loco.lucky = loco.lucky + 0.77
		loco.lsRadAdjY = 0.77
		LunacyGyre:Show()
		loco.flashTime = GetTimePreciseSec() + 7
		loco.active = loco.active + 0.81
		--return "~*~"..wITh.." showers, bring lovely flowers ~*~"
	]]--
	
	
	--Earth
	elseif wITh == "Cobalt" then
		--[[
		LunacyGyre.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\LunacyE")
		r,g,b = hex2rgb(GetHexColor("Cobalt"))
		LunacyGyre.texture:SetVertexColor(r/255, g/255, b/255)
		
		colorFeed("Cobalt", 3)
		]]--
		if loco.drX then
			loco.drX.decay = (loco.drX.decay * 1.001) + 9
			loco.drX.relax = (loco.drX.relax * 1.07) + 0.0021
		end
		--[[
		else
			loco.drX = {}
			loco.drX.a = -9
			loco.drX.b = 9
			loco.drX.x = 9
			loco.drX.pong = 1
			loco.drX.relax = 0.00027
			loco.drX.decay = GetTimePreciseSec() + 27
		end
		loco.lsRadAdjX = 0.77
		loco.azure = loco.azure or 0
		loco.azure = loco.azure + 1
		if math.random(411) < loco.azure and loco.spell ~= "Azure" then
			loco.azure = 0
			local pick = select(math.random(4), unpack(grimoire.Azure.snarks))
			PlaySoundFile(pick)
			sandy:SetDisplayInfo(115505) --Brann
			initLineSet("Azure")
		end
		loco.diSTurbed = loco.diSTurbed - 0.39
		loco.lucky = loco.lucky + 1.77
		if loco.diSTurbed <= 0.66 then
			loco.diSTurbed = 0.166
		end
		LunacyGyre:Show()
		loco.flashTime = GetTimePreciseSec() + 7
		loco.active = loco.active + 0.99
	]]--
	elseif wITh == "Feldgrau" then
		LunacyGyre.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\LunacyE")
		r,g,b = hex2rgb(GetHexColor("Feldgrau"))
		LunacyGyre.texture:SetVertexColor(r/255, g/255, b/255)
		colorFeed("Feldgrau", 4)
		LunacyGyre:Show()
		loco.overTime = GetTimePreciseSec() + 7.7
		loco.lsSpinOver = 21
		loco.flashTime = GetTimePreciseSec() + 4.4
		loco.active = loco.active + 0.66
	--Avarice
	elseif wITh == "Chartreuse" then
		--sandy:SetDisplayInfo(21723)
		LunacyGyre.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\LunacyE")
		r,g,b = hex2rgb(GetHexColor("Chartreuse"))
		LunacyGyre.texture:SetVertexColor(r/255, g/255, b/255)
		sandy:SetDisplayInfo(158685)
		colorFeed("Chartreuse", 7)
		LunacyGyre:Show()
		loco.flashTime = GetTimePreciseSec() + 11.11
		loco.diSTurbed = loco.diSTurbed * (1 + math.random() * 0.00666)
		loco.lucky = loco.lucky * (1 - math.random() * 0.00777)
	--Wealth
	elseif wITh == "Gold" then
		--LunacyGyre.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\LunacyE")
		--r,g,b = hex2rgb(GetHexColor("Gold"))
		--LunacyGyre.texture:SetVertexColor(r/255, g/255, b/255)
		--colorFeed("Gold", 4)
		--LunacyGyre:Show()
		--loco.overTime = GetTimePreciseSec() + 7.11
		--loco.lsSpinOver = 71
		--loco.flashTime = GetTimePreciseSec() + 7.11
		loco.diSTurbed = loco.diSTurbed * (1 + math.random() * 0.003666)
		loco.lucky = loco.lucky * (1 + math.random() * 0.003777)
		--loco.gold = loco.gold or 0
		--loco.gold = loco.gold + 1 
			
		--loco.active = loco.active + 0.66
	elseif wITh == "Bone" then
		LunacyGyre.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\LunacyE")
		r,g,b = hex2rgb(GetHexColor("Bone"))
		LunacyGyre.texture:SetVertexColor(r/255, g/255, b/255)
		colorFeed("Bone", 4)
		LunacyGyre:Show()
		loco.overTime = GetTimePreciseSec() + 7.11
		loco.lsSpinOver = 71
		loco.flashTime = GetTimePreciseSec() + 7.11
		loco.diSTurbed = loco.diSTurbed * (1 + math.random() * 0.001666)
		loco.lucky = loco.lucky * (1 - math.random() * 0.001777)
		--loco.active = loco.active + 0.66
	elseif wITh == "SafetyYellow" then
		LunacyGyre.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\LunacyE")
		r,g,b = hex2rgb(GetHexColor("SafetyYellow"))
		LunacyGyre.texture:SetVertexColor(r/255, g/255, b/255)
		colorFeed("SafetyYellow", 4)
		LunacyGyre:Show()
		loco.overTime = GetTimePreciseSec() + 7.11
		loco.lsSpinOver = 71
		loco.flashTime = GetTimePreciseSec() + 7.11
		--loco.active = loco.active + 0.66
	elseif wITh == "Buff" then
		LunacyGyre.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\LunacyE")
		r,g,b = hex2rgb(GetHexColor("Buff"))
		LunacyGyre.texture:SetVertexColor(r/255, g/255, b/255)
		colorFeed("Buff", 2)
		LunacyGyre:Show()
		loco.overTime = GetTimePreciseSec() + 4.4
		loco.lsSpinOver = 44
		loco.flashTime = GetTimePreciseSec() + 3.3
		loco.active = loco.active + 0.44
	elseif wITh == "Vixen" then
		loco.lucky = loco.lucky or 777.77
		loco.diSTurbed = loco.diSTurbed or 0.37
		local rnd = math.random() * (loco.lucky / (loco.diSTurbed + 0.369))
		--print(rnd)
		--loco.lineAlpha = 1.0
		if rnd < 7.7 then
			Ramble(colorMe("Luck ^ ", "Shamrock")..colorMe(loco.lucky, "BrightMint"), colorMe("[Gyre] ", "Purple"))
			Ramble(colorMe("diSTurbed /~\\ ", "Indigo")..colorMe(loco.diSTurbed, "Bumblebee"), colorMe("[Gyre] ", "Purple"))
			Ramble(colorMe("RnD ~^~ ", "Coffee")..colorMe(rnd, "Tomato"), colorMe("[Gyre] ", "Purple"))
			loco.pulse = nil
			--3534100 - How is your day going?
			rnd = select(math.floor(rnd+1), 546621,546627,546631,567134,3089702,3534100,548759,3089702)
			EarThis(rnd)
		end
		
		loco.lsRadAdjY = grimoire[loco.spell].lsRadAdjY or 1.00
		loco.lsRadAdjX = grimoire[loco.spell].lsRadAdjX or 1.00
		loco.dippX = grimoire[loco.spell].dippX or 1.00
		loco.dippY = grimoire[loco.spell].dippY or 1.00
		
		LunacyGyre.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\LunacyE")
		r,g,b = hex2rgb(GetHexColor(loco.gyreVert or "Vixen"))
		LunacyGyre.texture:SetVertexColor(r/255, g/255, b/255)
		colorFeed(loco.lineClr, 6)
		LunacyGyre:Show()
		loco.flashTime = GetTimePreciseSec() + 6.9
	elseif wITh == "Coffee" then
		LunacyGyre.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\LunacyE")
		r,g,b = hex2rgb(GetHexColor("Coffee"))
		LunacyGyre.texture:SetVertexColor(r/255, g/255, b/255)
		colorFeed("Coffee", 3)
		LunacyGyre:Show()
		loco.diSTurbed = loco.diSTurbed - 0.21
		loco.lsSpinRate = (loco.lsSpinRate or 0) + loco.spd * 0.36
		if loco.diSTurbed <= 1.77 then
			loco.diSTurbed = 0.77
		end
		loco.flashTime = GetTimePreciseSec() + 3
		loco.active = loco.active + 0.27
	elseif wITh == "DeepPurple" then
		LunacyGyre.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\LunacyE")
		r,g,b = hex2rgb(GetHexColor("DeepPurple"))
		LunacyGyre.texture:SetVertexColor(r/255, g/255, b/255)
		colorFeed("DeepPurple", 13)
		LunacyGyre:Show()
		loco.flashTime = GetTimePreciseSec() + 13
		loco.active = loco.active - 13
		loco.rube = 707
	elseif wITh == "AdmiralBlue" then
		
	elseif wITh == "AeroBlue" then
		LunacyGyre.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\LunacyE")
		r,g,b = hex2rgb(GetHexColor("AeroBlue"))
		LunacyGyre.texture:SetVertexColor(r/255, g/255, b/255)
		colorFeed("AeroBlue", 3)
		LunacyGyre:Show()
		loco.diSTurbed = loco.diSTurbed - 0.11
		loco.lsSpinRate = (loco.lsSpinRate or 0) - loco.spd * 0.63
		
		if loco.diSTurbed <= 1.11 then
			loco.diSTurbed = 7.77
		elseif loco.diSTurbed > 777 then
			loco.diSTurbed = loco.diSTurbed - 77
		end
		loco.flashTime = GetTimePreciseSec() + 3
		loco.active = loco.active + 0.33
	elseif wITh == "default" then
		if loco.spell and grimoire[loco.spell] and grimoire[loco.spell].gyreTex then
			LunacyGyre.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\"..grimoire[loco.spell].gyreTex)
		else
			LunacyGyre.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\LunacyA")
		end
		if loco.spell and grimoire[loco.spell] and grimoire[loco.spell].gyreVert then
			r,g,b = hex2rgb(GetHexColor(grimoire[loco.spell].gyreVert))
			LunacyGyre.texture:SetVertexColor(r/255, g/255, b/255)
		else
			LunacyGyre.texture:SetVertexColor(0.77,0.77,0.77, 1.0)
		end
	end
	if hand and hand.cast then
		return hand.cast
	end
end

function ColorLock(tf)
	if tf then
		loco.clrLock = tf
	else
		loco.clrLock = not loco.clrLock
	end
end

function SetPlayerFacing()
	local pF = GetPlayerFacing()
	if loco.idx == 0 then
		return
	elseif loco.idx == 1 then
		if LunacyFrameA:IsShown() then
			LunacyFrameA:Hide()
		end
		if not Lunadometer:IsShown() then
			Lunadometer:Show()
		end
		pF = 0
	elseif loco.inQBlob == true then
		if not LunacyFrameA:IsShown() then
			LunacyFrameA:Show()
		end
		if Lunadometer:IsShown() then
			Lunadometer:Hide()
		end
		loco.sPn = loco.sPn or 0
		loco.sPn = loco.sPn + 5
		if loco.sPn > 720 then
			loco.sPn = 0
		end
		pF = loco.sPn
	else
		if not LunacyFrameA:IsShown() then
			LunacyFrameA:Show()
		end
		if Lunadometer:IsShown() then
			Lunadometer:Hide()
		end
	end
	if pF then
		local angle = (rad(135) - pF) / 0.017453
		local s,c = sin(angle) * sqrt(0.5) * 1.0, cos(angle) * sqrt(0.5) * 1.0
		LunacyFrameA.texture:SetTexCoord(0.5-s,0.5+c,0.5+c,0.5+s,0.5-c,0.5-s,0.5+s,0.5-c)
	end
end

function PokeGyre()
	if loco.drX then
		Ramble(colorMe("drX.a: ", "Green")..colorMe(loco.drX.a, "Gold"), colorMe("[Gyre] ", "Purple"))
		Ramble(colorMe("drX.b: ", "Green")..colorMe(loco.drX.b, "Gold"), colorMe("[Gyre] ", "Purple"))
		Ramble(colorMe("drX.x: ", "Green")..colorMe(loco.drX.x, "Gold"), colorMe("[Gyre] ", "Purple"))
		Ramble(colorMe("drX.pong: ", "Green")..colorMe(loco.drX.pong, "Gold"), colorMe("[Gyre] ", "Purple"))
		Ramble(colorMe("drX.relax: ", "Green")..colorMe(loco.drX.relax, "Gold"), colorMe("[Gyre] ", "Purple"))
		Ramble(colorMe("drX.decay: ", "Green")..colorMe(loco.drX.decay, "Gold"), colorMe("[Gyre] ", "Purple"))
	end
	if loco.drY then
		Ramble(colorMe("drY.a: ", "Green")..colorMe(loco.drY.a, "Gold"), colorMe("[Gyre] ", "Purple"))
		Ramble(colorMe("drY.b: ", "Green")..colorMe(loco.drY.b, "Gold"), colorMe("[Gyre] ", "Purple"))
		Ramble(colorMe("drY.y: ", "Green")..colorMe(loco.drY.y, "Gold"), colorMe("[Gyre] ", "Purple"))
		Ramble(colorMe("drY.pong: ", "Green")..colorMe(loco.drY.pong, "Gold"), colorMe("[Gyre] ", "Purple"))
		Ramble(colorMe("drY.relax: ", "Green")..colorMe(loco.drY.relax, "Gold"), colorMe("[Gyre] ", "Purple"))
		Ramble(colorMe("drY.decay: ", "Green")..colorMe(loco.drY.decay, "Gold"), colorMe("[Gyre] ", "Purple"))
	end
	return "~Gotta catch em all!~"
end

function GetLoco(key)
	if not key then
		return
	end
	if loco[key] then
		local farm
		if farmKeys[key] then
			farm = farmKeys[key](loco[key])
		end
		return tostring(loco[key]), farm
	end
	local keys = {}
	kyA,kyB,kyC,kyD = string.split(".", key)
	print(kyA)
	print(kyB)
	print(kyC)
	
	local bark,bite,howl,farm
	repeat
		if kyA and type(loco[kyA]) == "table" then 
			if kyB and type(loco[kyA][kyB]) == "table" then
				if kyC and type(loco[kyA][kyB][kyC]) == "table" then
					if kyD then
						bite = tostring(loco[kyA][kyB][kyC][kyD])--~recursively yours~--
						if farmKeys[kyD] then
							farm = farmKeys[kyD](bite)
						end
					end
				else
					bite = tostring(loco[kyA][kyB][kyC])
					if farmKeys[kyC] then
						farm = farmKeys[kyC](bite)
					end
				end
			else
				bite = tostring(loco[kyA][kyB])
				farm = farmKeys[kyB](bite)
				if farmKeys[kyB] then
					farm = farmKeys[kyB](bite)
				end
			end
		elseif not howl then
			keys = string.split(" ", key)
			howl = true
		else
			bark = select(math.random(4),"~*nope*~", "~surely not~", "~..appears to be empty..~", "~.nil or nan like an empty can.~", "~!you're crazy!~", "~it appears to be empty..~")
		end
	until bite or bark
	return tostring(bark or bite), farm
end

function SetLoco(key,value,keyb,keyc,keyd)
	if value == "nil" then
		value = nil
	elseif value == "{}" then
		value = {}
	elseif value == "true" then
		value = true
	elseif value == "false" then
		value = false
	--elseif keyb and keyb == "keySet" then
		
	end
	if keyd and loco[key] and loco[key][keyb] and loco[key][keyb][keyc] and loco[key][keyb][keyc][keyd] then
		loco[key][keyb][keyc][keyd] = value
		if type(loco[key][keyb][keyc][keyd]) == "number" then
			loco[key][keyb][keyc][keyd] = tonumber(value)
		else
			loco[key][keyb][keyc] = value
		end
	elseif keyd and loco[key] and loco[key][keyb] and loco[key][keyb][keyc] then
		loco[key][keyb][keyc] = value
		if type(loco[key][keyb][keyc]) == "number" then
			loco[key][keyb][keyc] = tonumber(value)
		else
			loco[key][keyb][keyc] = value
		end
	elseif keyd and loco[key] and loco[key][keyb] then
		loco[key][keyb] = value
		if type(loco[key][keyb]) == "number" then
			loco[key][keyb] = tonumber(value)
		else
			loco[key][keyb] = value
		end
	elseif loco[key] then
		if type(loco[key]) == "number" then
			loco[key] = tonumber(value)
		else
			loco[key] = value
		end
	elseif tonumber(value) then
		loco[key] = tonumber(value)
	elseif key and value then
		loco[key] = value
	else
		return "well shit, that didn't seem to work so well!"
	end
	
	return key.." set to "..tostring(value)
end

function GetPlayerPosition()
	local pMap = C_Map.GetBestMapForUnit("player")
	local pX,pY
	if pMap then
		local pos = C_Map.GetPlayerMapPosition(pMap, "player")
		if pos then
			pX, pY = pos:GetXY()
		end
	else
		return
	end
	local pWX,pWY = HBD:GetWorldCoordinatesFromZone(pX,pY,pMap)
	local info = C_Map.GetMapInfo(pMap)
	return pX,pY,pMap,pWX,pWY,info.mapType,info.parentMapID
end

function GetMapCoords()
	return loco.pX, loco.pY, loco.pMap
end

function SetUserWaypoint()
	if loco.suwLock then
		return
	end
	local urWay = C_Map.GetUserWaypoint()
	local hasWay = {}
	local pWay = {}

	if WaypointUIAPI then
		hasWay = WaypointUIAPI.Navigation.GetUserNavigation()
	end
	if hasWay.name and not loco.pinOvr then
		pWay.target = hasWay.name
		pWay.map = hasWay.mapID
		pWay.x = hasWay.x
		pWay.y = hasWay.y
		loco.tracking = "WaypointUI"
		loco.destCheck = true
		loco.urWay = true
		loco.pWay = nil
		loco.objTxt = desc
		loco.trPntMap = ParentMap(pWay.map)
		loco.trWX, loco.trWY = HBD:GetWorldCoordinatesFromZone(pWay.x,pWay.y,pWay.mapID)
		if L_DBG >= 3 or L_DBF["UpdateTrack"] then
			Ramble(colorMe("WP-Set: ", "Liserian")..colorMe(tostring(hasWay.name), "LightGoldenrod"), colorMe("∫SetUserWaypoint∫ ", "Veronica"))
		end
		loco.suwLock = GetTimePreciseSec()
		C_SuperTrack.SetSuperTrackedUserWaypoint(true)
	elseif urWay and loco.pinOvr then
		if L_DBG >= 3 or L_DBF["UpdateTrack"] then
			Ramble(colorMe("waySet: pinOvr", "Liserian"), colorMe("∫SetUserWaypoint∫ ", "Veronica"))
		end
		loco.pinOvr = nil
		pWay = loco.pWay
		pWay.x = urWay.position.x
		pWay.y = urWay.position.y
		loco.pWay = nil
		loco.tracking = "pinOvr"
		loco.suwLock = GetTimePreciseSec()
		C_SuperTrack.SetSuperTrackedUserWaypoint(true)
	elseif urWay then
		pWay = {}
		pWay.target = colorMe("-Map\|Pin-", "FluorescentYellow")
		pWay.map = urWay.uiMapID
		pWay.x = urWay.position.x
		pWay.y = urWay.position.y
		loco.tracking = "MapPin"
		loco.destCheck = true
		loco.urWay = true
		if L_DBG >= 3 or L_DBF["UpdateTrack"] then
			Ramble(colorMe("Set: ", "Turquoise")..colorMe(tostring(loco.urWay), "BrightMint"), colorMe("∫SetUserWaypoint∫ ", "Veronica"))
		end
		loco.suwLock = GetTimePreciseSec()
		C_SuperTrack.SetSuperTrackedUserWaypoint(true)
	elseif loco.urWay and pWay and pWay.map then
		loco.destCheck = true
		loco.urWay = true
		loco.tracking = "XX"
		if L_DBG >= 3 or L_DBF["UpdateTrack"] then
			Ramble(colorMe("Set: ", "Turquoise")..colorMe(tostring(loco.urWay), "BrightMint"), colorMe("∫SetUserWaypoint∫ ", "Veronica"))
		end
		C_SuperTrack.SetSuperTrackedUserWaypoint(true)
	elseif loco.wsCnt > 0 then
		pWay = nil
		if loco.wayStack[loco.wsCnt].map and C_Map.CanSetUserWaypointOnMap(loco.wayStack[loco.wsCnt].map) then
			local pos = CreateVector2D(loco.wayStack[loco.wsCnt].x, loco.wayStack[loco.wsCnt].y)
			local mapPoint = UiMapPoint.CreateFromVector2D(loco.wayStack[loco.wsCnt].map, pos)
			loco.slntUpd = true
			WaypointUIAPI.Navigation.ClearUserNavigation()
			WaypointUIAPI.Navigation.NewUserNavigation(loco.wayStack[loco.wsCnt].name, loco.wayStack[loco.wsCnt].mapID,
				loco.wayStack[loco.wsCnt].x, loco.wayStack[loco.wsCnt].y)
			C_Map.SetUserWaypoint(mapPoint)
		end
		loco.tracking = loco.wayStack[loco.wsCnt].what
		if L_DBG >= 3 or L_DBF["UpdateTrack"] then
			Ramble(colorMe(":xVx: ", "FireBrick")..colorMe(tostring(loco.wsCnt), "Teal"), colorMe("∫SetUserWaypoint\| ", "Veronica"))
			Ramble(colorMe("Fail: @ ", "FireBrick")..colorMe(tostring(loco.tracking), "Teal"), colorMe("∫SetUserWaypoint\| ", "Veronica"))
		end
	else
		loco.tracking = "X^X"
		if L_DBG >= 3 or L_DBF["UpdateTrack"] then
			Ramble(colorMe("Fail: urway: ", "FireBrick")..colorMe(tostring(loco.urWay), "Teal"), colorMe("∫SetUserWaypoint\| ", "Veronica"))
			Ramble(colorMe("Fail: pinOvr: ", "FireBrick")..colorMe(tostring(loco.pinOvr), "Teal"), colorMe("∫SetUserWaypoint\| ", "Veronica"))
		end
		loco.urWay = nil
		loco.pinOvr = nil
		pWay = nil
		C_SuperTrack.SetSuperTrackedUserWaypoint(false)
	end
	if pWay then
		loco.wsCnt = loco.wsCnt + 1
		loco.wayStack[loco.wsCnt] = {}
		loco.wayStack[loco.wsCnt].name = pWay.name or pWay.target
		loco.wayStack[loco.wsCnt].target = pWay.target
		loco.wayStack[loco.wsCnt].map = pWay.map
		loco.wayStack[loco.wsCnt].x = pWay.x
		loco.wayStack[loco.wsCnt].y = pWay.y
		loco.wayStack[loco.wsCnt].thing = pWay.thing
		loco.wayStack[loco.wsCnt].what = loco.tracking
		pWay = nil
		if L_DBG >= 3 or L_DBF["SetUserWaypoint"] then
			Ramble(colorMe("wayStack: Cnt: ", "FireBrick")..colorMe(tostring(loco.wsCnt), "Teal"), colorMe("∫SetUserWaypoint\| ", "Veronica"))
		end
		UpdateTrack()
		--ClearTrack()
	end
end

function ClearTrack()
	if loco.wsCnt > 0 then
		loco.wayStack[loco.wsCnt] = nil
		loco.wsCnt = loco.wsCnt - 1
	end
	loco.isTracking = true
	C_Map.ClearUserWaypoint()
	WaypointUIAPI.Navigation.ClearUserNavigation()
	--pWay = nil
	loco.pinOvr = nil
	loco.optDesc = nil
	UpdateCompass()
	C_SuperTrack.ClearAllSuperTracked()
	ToggleTracking("stop")
	UpdateTrack()
	ToggleTracking("start")
end

function SetTrack(mapID,x,y,desc,optDesc,thing)
	local pWay
	if C_Map.CanSetUserWaypointOnMap(mapID) then
		local pos = CreateVector2D(x / 100, y / 100)
		local mapPoint = UiMapPoint.CreateFromVector2D(mapID, pos)
		loco.pinOvr = true
		loco.objTxt = desc
		pWay = {}
		pWay.name = desc
		pWay.target = desc
		pWay.map = mapID
		pWay.x = x / 100
		pWay.y = y / 100
		pWay.thing = thing
		
		loco.pWay = pWay
		
		if optDesc then
			if L_DBG >= 2 or L_DBF["SetTrack"] then
				Ramble(colorMe(tostring(optDesc), "FluorescentBlue"), colorMe("[WhereIs] ", "SignalYellow")..colorMe("optDesc: ", "Pansy"))
			end
			loco.optDesc = optDesc
		end
		if L_DBG >= 2 or L_DBF["SetTrack"] then
			--[Whereis] X: x Y: y
			Ramble(colorMe("X: ", "Crimson")..colorMe(tostring(x), "White")..colorMe(" Y: ", "Citrine")..colorMe(tostring(y), "White"), colorMe("[WhereIs] ", "SignalYellow"))
		end
		loco.destCheck = true
		loco.urWay = true
		loco.trPntMap = ParentMap(mapID)
		loco.trWX, loco.trWY = HBD:GetWorldCoordinatesFromZone(x,y,mapID)
		C_Map.SetUserWaypoint(mapPoint)
		--C_SuperTrack.SetSuperTrackedUserWaypoint(true)
		--UpdateTrack()
		--local pos = CreateVector2D(elderTable[slct][2], elderTable[slct][3])
		--local mapPoint = UiMapPoint.CreateFromVector2D(elderTable[slct][4], CreateVector2D(elderTable[slct][2], elderTable[slct][3]))
		--C_Map.SetUserWaypoint(mapPoint)
		--local pos = C_Map.GetWorldPosFromMapPos(elderTable[slct][4], CreateVector2D(elderTable[slct][2], elderTable[slct][3]))
		--local mapPoint = UiMapPoint.CreateFromVector2D(elderTable[slct][4], pos)
		--C_Map.SetUserWaypoint(mapPoint)🔑
	else
		print("Cannot set waypoints on this map")
	end
	UpdateTrack()
	--loco.destCheck = true
	--loco.elder = slct
	--loco.elderCont = cont
	--loco.tarZone = zN
	--return elderTable[slct][4], sX, sY, slct, wX, wY, zP
end

function UpdateCompass()
	---HBD_PINS_WORLDMAP_SHOW_WORLD
	PlaySoundFile("Interface\\Addons\\Lunacy\\Media\\Ping.mp3")
	loco.destCheck = nil
	loco.trMap, loco.trX, loco.trY, loco.objTxt, loco.trWX, loco.trWY, loco.trPntMap = nil,nil,nil,nil,nil,nil,nil
end

function UpdateTrackerText()
	LunacyMainFrame.Distance:SetText(Lunacy.Text2)
	LunacyMainFrame.Speed:SetText(Lunacy.Text4)
	LunacyMainFrame.Objective:SetText(Lunacy.Text1)
	LunacyMainFrame.ObjectiveB:SetText(Lunacy.Text3)
	LunacyMainFrame.ObjectiveC:SetText(Lunacy.Text5)
	--LunacyMainFrame.Zone:SetText(Lunacy.Text3)
	--LunacyMainFrame.Misc:SetText(Lunacy.Text6)
end

function ToggleTracking(action)
	if action == "stop" then
		Lunacy.Text1 = ""
		Lunacy.Text2 = ""
		Lunacy.Text3 = ""
		Lunacy.Text4 = ""
		Lunacy.Text5 = ""
		UpdateTrackerText()
	elseif action == "start" then
		UpdateTrackerText()
	end
end

function GetAngle(map, x1, y1, x2, y2)
	if not x1 or not x2 then
		return 0
	end
	local deltaX = x2 - x1
	local deltaY = y2 - y1
    local angle = math.atan2(-deltaX, deltaY)

    if angle > 0 then
        angle = math.pi * 2 - angle
    else
        angle = -angle
    end
	return angle
end

function SaveLoco()
	Lunacy[playerKey].loco = loco
end

function UpdateTrack()
	--if loco.porting then
		--return
	--end
	local hasWay = {}
	if WaypointUIAPI then
		hasWay = WaypointUIAPI.Navigation.GetUserNavigation()
	end
	if hasWay.name and not loco.pinOvr and not loco.suwLock then
		SetUserWaypoint()
		return
	end
	--loco.pX,loco.pY,loco.pMap,loco.pWX,loco.pWY,loco.mapType,loco.pPntMap = GetPlayerPosition()
	if L_DBG >= 2 or L_DBF["UpdateTrack"] then
		Ramble(colorMe("   ~Update Track~", "Tomato"), colorMe("[UpdateTrack] ", "Green"))
	end
	local crTrk
	if loco.wsCnt and loco.wsCnt > 0 then
		crTrk = loco.wayStack[loco.wsCnt]
		if not crTrk then
			Ramble(colorMe("~wayStack Fail~", "Tomato"), colorMe("[UpdateTrack] ", "Green"))
		end
	end

	local stqID = C_SuperTrack.GetSuperTrackedQuestID()
	if stqID and not crTrk and not blkQst[stqID] then
		dbgLatch = true
		loco.trackChange = true
		loco.questLink = GetQuestLink(stqID)
		local inGroup = IsInGroup()
		if inGroup == true then
			if loco.questLink then
				--local msg = "Tracking Quest: "..loco.questLink
				--SendChatMessage("Tracking Quest: "..loco.questLink, "PARTY")
			end
		else
			if loco.questLink then
				loco.questLink = gsub(loco.questLink, "|cff%x+|", "|cff05a9ff|")
				--print("|cffffff00Tracking Quest: "..loco.questLink)
				if L_DBG >= 1 or L_DBF["UpdateTrack"] then
					Ramble(loco.questLink, "|cff00ff00[Quest]|r|cffffffff Tracking: |r")
				end
			end
		end

		local map = C_Map.GetBestMapForUnit("player")
		if L_DBG >= 2 or L_DBF["UpdateTrack"] then
			Ramble(tostring(stqID), colorMe("[Quest]", "Green")..colorMe(" STQ: ", "BrightMint"))
			Ramble(tostring(map), colorMe("[Quest]", "Green")..colorMe(" Map: ", "Buff"))
		end
		loco.objid = C_QuestLog.GetLogIndexForQuestID(stqID)
		Lunacy.GTQshown = nil
		UpdateTrackerText()
		--UpdateTrack()
		ToggleTracking("start")
	elseif not crTrk then
		if L_DBG >= 2 or L_DBF["UpdateTrack"] then
			Ramble(colorMe(".Idle.","Midnight"), colorMe("[Quest]", "Green"))
		end
		--print("STQ: Not Available")
		loco.stqID = nil
		loco.trX = nil
		--print(tostring(arg1).." :: "..tostring(arg2))
		loco.objid = 0
		--UpdateTrack()
		--ToggleTracking("stop")
		--ToggleTracking("start")
	end
	
	local stX, stY, wayDesc
	if loco.pMap then
		stX, stY, wayDesc = C_SuperTrack.GetNextWaypointForMap(loco.pMap)
	end
	if stX then
		loco.stX = stX
		loco.stY = stY
	end
	if wayDesc then
		loco.wayDesc = wayDesc
	end
	
	
	
	loco.trStatus = true
	loco.trackChange = true
	
	if trackType[loco.idx+1] == "gathering" and loco.gather and loco.weed then
		local gTag
		gTag,loco.objTxt,loco.trX,loco.trY = wOOlgAthEr()
		if not gTag then
			loco.destCheck = nil
			loco.objTxt = "Searching"
			loco.trX = 0
			loco.trY = 0
			Lunacy.Text1 = colorMe("/.v.\\", "Shamrock")
			Lunacy.Text2 = colorMe("\\^/", "IndianYellow")
			Lunacy.Text3 = ""
			--loco.trStatus = nil
			UpdateTrackerText()
			if wOOlgAthEr(true) then
				gTag,loco.objTxt,loco.trX,loco.trY = wOOlgAthEr()
				if not gTag then
					Ramble(colorMe("~Gather Track Not Found~", "Red"), colorMe("[UpdateTrack] ", "Green"))
					loco.trStatus = nil
					UpdateTrackerText()
				else
					Ramble(colorMe("~Circle Back~", "LemonChiffon"), colorMe("[UpdateTrack] ", "Green"))
					Lunacy.Text1 = loco.objTxt
					loco.destCheck = true
				end
			else
				Ramble(colorMe("~Well Shit!~", "Brown"), colorMe("[UpdateTrack] ", "Green"))
			end
		else
			Lunacy.Text1 = loco.objTxt
			loco.destCheck = true
		end
		Lunacy.Text5 = loco.weed.pork
		loco.trMap,loco.trPntMap,curObj = loco.weed.map,ParentMap(loco.weed.map),loco.objTxt
		loco.trWX, loco.trWY = HBD:GetWorldCoordinatesFromZone(loco.trX,loco.trY,loco.trMap)
		loco.distance = HBD:GetWorldDistance(loco.trPntMap, loco.pWX, loco.pWY, loco.trWX, loco.trWY) or 0
		loco.distance = math.abs(loco.distance)
		UpdateTrackerText()
		--loco.trStatus = true
		loco.destCheck = true
	elseif crTrk then
		if L_DBG >= 2 or L_DBF["UpdateTrack"] then
			Ramble(colorMe(tostring(crTrk.name), "LemonChiffon"), colorMe("[UpdateTrack] ", "Green")..colorMe("crTrk: ", "Raspberry"))
		end
		Lunacy.Text1 = crTrk.name
		loco.trMap, loco.trX, loco.trY, loco.objTxt = crTrk.map, crTrk.x, crTrk.y, crTrk.name
		loco.destCheck = true
		loco.trPntMap = ParentMap(crTrk.map)
		loco.trWX, loco.trWY = HBD:GetWorldCoordinatesFromZone(crTrk.x,crTrk.y,crTrk.map)
		loco.distance = HBD:GetWorldDistance(loco.trPntMap, loco.pWX, loco.pWY, loco.trWX, loco.trWY) or 0
		loco.distance = math.abs(loco.distance)
		if loco.trMap then
			local info = C_Map.GetMapInfo(loco.trMap)
			loco.tarZone = info.name
			Lunacy.Text3 = loco.tarZone
		else
			Lunacy.Text3 = ""
		end
		loco.stqID = nil
		Lunacy.Text5 = loco.optDesc or ""
		UpdateTrackerText()
		--"gyre", "odometer", "compass"
	elseif trackType[loco.idx+1] == "gyre" or trackType[loco.idx+1] == "odometer" or trackType[loco.idx+1] == "compass" then
		if L_DBG >= 2 or L_DBF["UpdateTrack"] then
			Ramble(colorMe(trackType[loco.idx+1], "Trombone"), colorMe("[Quest] ", "Green")..colorMe("trackType: ", "CarolinaBlue"))
		end
		if loco.trackChange then
			loco.trMap, loco.trX, loco.trY, loco.objTxt, loco.stqID, loco.trPntMap, complete, curObj = Lunacy_GetTrackedQuest()
			if loco.stqID and blkQst[loco.stqID] then
				if L_DBG >= 4 or L_DBF["UpdateTrack"] then
					Ramble(tostring(loco.stqID), colorMe("[Quest]", "Green")..colorMe(" Blocked Quest: ", "BrightMint"))
				end
				loco.stqID = nil
				loco.trX = nil
				wayDesc = nil
				curObj = nil
				loco.objTxt = nil
			end
			loco.trackChange = nil
			if L_DBG >= 3 or L_DBF["UpdateTrack"] then
				Ramble(tostring(wayDesc), colorMe("[Quest]", "Green")..colorMe(" WD: ", "BrightMint"))
			end
			if wayDesc and loco.trX then
				--Ramble(tostring(wayDesc), colorMe("[Quest]", "Green")..colorMe(" WD: ", "BrightMint"))
				--print("WD: wayDesc")
				curObj = wayDesc
			end
		end
		if L_DBG >= 4 or L_DBF["UpdateTrack"] then
			Ramble(colorMe(tostring(loco.stqID), "Saffron"), colorMe("[Quest] ", "Green")..colorMe("stqID: ", "CarolinaBlue"))
			Ramble(colorMe(tostring(loco.urWay), "Shrek"), colorMe("[Quest] ", "Green")..colorMe("urWay: ", "CarolinaBlue"))
		end
		if not loco.stqID and not loco.urWay then
			Lunacy.Text1 = "|cffda1877/.^.\\|r"
			Lunacy.Text2 = "|cff11cc11\\o/|r"
			Lunacy.Text3 = ""
			Lunacy.Text5 = ""
			loco.trStatus = nil
			UpdateTrackerText()
		end
		if loco.stqID then
			loco.inQBlob = C_Minimap.IsInsideQuestBlob(loco.stqID)
			if loco.inQBlob then
				LunacyFrameA.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\CompassD")
			end
		else
			loco.inQBlob = nil
			LunacyFrameA.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\CompassA")
		end
		if not loco.inQBlob then
			LunacyFrameA.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\CompassA")
		end
		if not loco.trMap and dbgLatch then
			if L_DBG >= 2 or L_DBF["UpdateTrack"] then
				Ramble(colorMe("~quest location unknown~", "FluorescentYellow"), colorMe("[Quest]", "Green"))
			end
			dbgLatch = nil
			loco.trStatus = nil
		end
		
		if complete and loco.stqID then
			if not qComp[loco.stqID] then
				PlaySoundFile("Interface\\Addons\\Lunacy\\Media\\Ping.mp3")
				qComp[loco.stqID] = true
			end
		end
		if curObj then
			Lunacy.Text5 = curObj
		else
			Lunacy.Text5 = ""
		end
	elseif trackType[loco.idx+1] == "exploration" and loco.pMap then
		loco.trMap, loco.trX, loco.trY, loco.objTxt = Lunacy_GetNextExplore(loco.pX, loco.pY, loco.pMap)
	elseif trackType[loco.idx+1] == "elders" then
		if not elders[Lunacy_Continents[loco.pPntMap]] then
			if not loco.destCheck then
				loco.trMap, loco.trX, loco.trY, loco.objTxt, loco.trWX, loco.trWY, loco.trPntMap = Lunacy_GetNextElder()
			end
			if C_SuperTrack.IsSuperTrackingUserWaypoint() and wayDesc then
				Lunacy.Text3 = wayDesc
			end
			loco.distance = HBD:GetWorldDistance(loco.pPntMap, loco.pWX, loco.pWY, loco.trWX, loco.trWY) or 0
			loco.distance = math.abs(loco.distance)
		end
		Lunacy.Text5 = ""
	else
		if dbgLatch then
			--"|cffffff00[Lunacy] v1.0 ~Howl at the Moon!~|r"
			--Ramble()
			if L_DBG >= 2 or L_DBF["UpdateTrack"] then
				Ramble(colorMe("~tracker idle~", "FluorescentYellow"), colorMe("[Quest]", "Green"))
			end
			--print("tracker type not set")
			dbgLatch = nil
		end
	end
	Lunacy.Text5 = colorMe(Lunacy.Text5, "Turquoise")
end

function EarThis(sound)
	PlaySoundFile(sound)
end

function luCky_seVen()
	loco.diSTurbed = loco.diSTurbed or 1
	loco.lucky = loco.lucky or 777
	loco.seVen = math.floor(math.abs(loco.angle * (180 / math.pi)))
	if loco.seVen == 37 or loco.seVen == 77 or loco.seVen == 137 or loco.seVen == 177 or loco.seVen == 234 then
		--print(loco.angle)
		local rnd = math.random() * loco.lucky * 7.7
		--print(rnd)
		if rnd < loco.diSTurbed then
			loco.diSTurbed = loco.diSTurbed - (loco.diSTurbed - rnd) * 0.07
			rnd = math.random(7)
			print(rnd)
			if rnd == 7 then
				loco.diSTurbed = math.floor(math.random()*777)/1000
				loco.lucky = loco.lucky + 77.7
				if L_DBG >= 7 then
					Ramble(colorMe("Lucky 7's!", "NeonYellow"), colorMe("[~lucky~]", "Shamrock"))
				end
			elseif rnd == 3 then
				loco.diSTurbed = math.floor(loco.diSTurbed*1333)/1000
			elseif rnd == 1 then
				loco.diSTurbed = math.floor(loco.diSTurbed*1111)/1000
				loco.lucky = loco.lucky - 11.1
			elseif math.random(77) == 37 then
				loco.diSTurbed = loco.diSTurbed + 6.66
				loco.lucky = loco.lucky - 66.6
				if math.floor(loco.lucky*0.137) == 77 then
					loco.lucky = loco.lucky - 666
					if loco.lucky < 77 then
						loco.lucky = 66.6
					end
					loco.diSTurbed = loco.diSTurbed + 0.137 * loco.lucky
					if L_DBG >= 7 then
						Ramble(colorMe("Curses!", "Violet"), colorMe("[~curses~]", "Scarlet"))
					end
				end
				
			end
			--loco.diSTurbed = math.floor(loco.diSTurbed*10000)/10000
			rnd = select(rnd, 546621,546627,546631,567134,3089702,3534100,548759)
			EarThis(rnd)
			--print(tostring(rnd))
		end
	elseif loco.seVen > 133 and loco.seVen < 137 then
		loco.diSTurbed = loco.diSTurbed + 0.00000137
		loco.lucky = loco.lucky - 0.00007
	elseif loco.diSTurbed < (1.37 + loco.lucky * 0.0037) then
		loco.diSTurbed = loco.diSTurbed + 0.037
	end
	if loco.lucky < 1.77 then
		loco.lucky = 1.77
	end
	if loco.diSTurbed < 0.66 then
		loco.diSTurbed = 0.369
	end
end

function ParentMap(map)
	if not map then
		map = C_Map.GetBestMapForUnit("player")
	end
	local pCont = C_Map.GetMapInfo(map)
	return pCont.parentMapID
end

function ClearElders()
	Lunacy[playerKey].elders = {}
	table.wipe(Lunacy[playerKey].elders)
	Lunacy_Continents[loco.pPntMap] = nil
	elders = {}
end

function Lunacy_GetNextElder()
	--local x, y, pMapID = HBD:GetPlayerZonePosition(true)
	--local pCont = C_Map.GetMapInfo(pMapID)
	
	--local x,y = HBD:GetWorldCoordinatesFromZone(x, y, pMapID)
	local disT = 100000
	local dis, adj
	local dX, dY, wX, wY, sX, sY, slct, zP, zN
	--local trCont = C_Map.GetMapInfo(trMap)
	if loco.pPntMap then
		local cont = Lunacy_Continents[loco.pPntMap]
		if not cont then
			--print("|cffff0000No elders located on this continent...|r")
			ToggleTracking("stop")
			return
		end
		local elderTable = Lunacy_Elders[cont]
		Lunacy[playerKey].elders = Lunacy[playerKey].elders or {}
		Lunacy[playerKey].elders[cont] = Lunacy[playerKey].elders[cont] or {}

		for k,v in pairs(elderTable) do
			if not Lunacy[playerKey].elders[cont][k] then
				local znP = C_Map.GetMapInfo(v[4])
				
				dX, dY = HBD:GetWorldCoordinatesFromZone(v[2]/100, v[3]/100, v[4])
				dis = math.abs(HBD:GetWorldDistance(znP.parentMapID, loco.pWX, loco.pWY, dX, dY))
				adj = 0
				if v[4] == loco.pMap then
					adj = 100 -- makes destinations in the current zone more favorable
				end
				if (dis - adj) < disT then
					--print(tostring(dis))
					disT = dis
					slct = k
					wX = dX
					wY = dY
					zP = znP.parentMapID
					zN = znP.name
					sX = v[2]/100
					sY = v[3]/100
				end
			end
		end
		if slct then
			if C_Map.CanSetUserWaypointOnMap(elderTable[slct][4]) then
				local pos = CreateVector2D(elderTable[slct][2] / 100, elderTable[slct][3] / 100)
				local mapPoint = UiMapPoint.CreateFromVector2D(elderTable[slct][4], pos)
				C_Map.SetUserWaypoint(mapPoint)
				C_SuperTrack.SetSuperTrackedUserWaypoint(true)
				--local pos = CreateVector2D(elderTable[slct][2], elderTable[slct][3])
				--local mapPoint = UiMapPoint.CreateFromVector2D(elderTable[slct][4], CreateVector2D(elderTable[slct][2], elderTable[slct][3]))
				--C_Map.SetUserWaypoint(mapPoint)
				--local pos = C_Map.GetWorldPosFromMapPos(elderTable[slct][4], CreateVector2D(elderTable[slct][2], elderTable[slct][3]))
				--local mapPoint = UiMapPoint.CreateFromVector2D(elderTable[slct][4], pos)
				--C_Map.SetUserWaypoint(mapPoint)🔑
			else
				print("Cannot set waypoints on this map")
			end
			loco.destCheck = true
			loco.elder = slct
			loco.elderCont = cont
			loco.tarZone = zN
			return elderTable[slct][4], sX, sY, slct, wX, wY, zP
		else
			elders[Lunacy_Continents[loco.pPntMap]] = true
			print("|cffff00ffElders completed for this continent...|r")
		end
	end
end

function Lunacy_GetTrackedQuest()
	local stqID = C_SuperTrack.GetSuperTrackedQuestID()
	local x, y, mapID
	--print(tostring(stqID))
	if stqID then
		local mapID = GetQuestUiMapID(stqID)
		--mapID, x, y = C_QuestLog.GetNextWaypoint(stqID)
		if not mapID then
			mapID = C_TaskQuest.GetQuestZoneID(stqID)
			loco.mapQMapMeth = "GetQuestZoneID"
		end
		if not mapID then
			mapID = GetQuestUiMapID(stqID)
			loco.mapQMapMeth = "GetQuestUiMapID"
		end
		
		local map = C_Map.GetBestMapForUnit("player")
		if not map then
			map = 42
		end
		
		if mapID == 0 then
			mapID = map
			loco.mapQMapMeth = "map"
		end

		local poiText
		
		if mapID then
			local quests = C_QuestLog.GetQuestsOnMap(mapID)
			if type(quests) == "table" then
				for i,v in pairs(quests) do
					if v.questID == stqID then
						x = v.x
						y = v.y
						mapID = v.mapID
					end
				end
			else --porting?
				return nil, nil, nil, "Porting?", nil
			end
			if dbgLatch then
				if L_DBG >= 5 or L_DBF["Lunacy_GetTrackedQuest"] then
					Ramble(tostring(loco.mapQMapMeth), "|cffffb100<mapQMapMeth>|r ")
				end
				if L_DBG >= 5 or L_DBF["Lunacy_GetTrackedQuest"] then
					Ramble(tostring(x), "|cff0492c2<[DBG-CHK X]>|r ")
				end
				--print("mapQMapMeth: "..tostring(loco.mapQMapMeth))
				--print("DBG-CHK X:: x :: " .. tostring(x))
			end
		end
		
		if not x then
			x, y, poiText = C_SuperTrack.GetNextWaypointForMap(map)
			--mapID, x, y = C_QuestLog.GetNextWaypoint(stqID)
			--print(tostring(x))
			if dbgLatch then
				if L_DBG >= 5 or L_DBF["Lunacy_GetTrackedQuest"] then
					Ramble(tostring(x), "|cff0492c2<[DBG-CHK A]>|r ")
				end
				--print("DBG-CHK A:: x :: " .. tostring(x))
			end
		end
		if not x then
			mapID = C_TaskQuest.GetQuestZoneID(stqID)
			if mapID then
				x, y = C_TaskQuest.GetQuestLocation(stqID, mapID)
			end
			if dbgLatch then
				--print("DBG-CHK B:: x :: " .. tostring(x))
				if L_DBG >= 5 or L_DBF["Lunacy_GetTrackedQuest"] then
					Ramble(tostring(x), "|cff0492c2<[DBG-CHK B]>|r ")
				end
			end
		end
		
		if not x then
			mapID, x, y = C_QuestLog.GetNextWaypoint(stqID)
		end
		
		if dbgLatch then
			if x then
				if L_DBG >= 2 or L_DBF["Lunacy_GetTrackedQuest"] then
					Ramble(tostring(x), "|cff00ff00[Quest]|r|cffff0000 X: |r")
					Ramble(tostring(y), "|cff00ff00[Quest]|r|cffffff00 Y: |r")
					Ramble(tostring(mapID), "|cff00ff00[Quest]|r|cfffdb515 MapID: |r")
				end
				--print("Quest X: "..tostring(x))
				--print("Quest Y: "..tostring(y))
				--print("Map: "..tostring(mapID).." |cffff00ff("..tostring(map)..")|r")
				--print("pMap: "..tostring(map))
			else
				--C_QuestLog.GetNextWaypoint(92443)
				loco.qUpTrk = GetTimePreciseSec()
				print("Quest coords not returned.")
				if mapID then
					print("Map: "..tostring(mapID))
				end
			end
			dbgLatch = nil
		end

		local qIdx = C_QuestLog.GetLogIndexForQuestID(stqID)

		local title
		if qIdx then
			title = C_QuestLog.GetInfo(qIdx).title
		end
		
		if not title then
			title = C_TaskQuest.GetQuestInfoByQuestID(stqID) or C_QuestLog.GetTitleForQuestID(stqID)
			if not title then
				title = "....."
			end
		end
		Lunacy[playerKey].lastTracked = Lunacy[playerKey].lastTracked or {}
		if (not mapID or not x) and Lunacy[playerKey].lastTracked then
			x = Lunacy[playerKey].lastTracked.X
			y = Lunacy[playerKey].lastTracked.Y
			mapID = Lunacy[playerKey].lastTracked.map
		--else
			--lastTracked = {X = x, Y = y, map = mapID}
		end
		Lunacy[playerKey].lastTracked.X = x
		Lunacy[playerKey].lastTracked.Y = y
		Lunacy[playerKey].lastTracked.map = mapID
		local complete = C_QuestLog.IsComplete(stqID)
		local objs = C_QuestLog.GetQuestObjectives(stqID)
		local idx = 0
		local curObj
		if objs then
			for i,v in pairs(objs) do
				if not v.finished and not curObj then
					curObj = v.text
				end
			end
		end
		--print(tostring(mapID))
		local info = C_Map.GetMapInfo(mapID)
		--return pX,pY,pMap,pWX,pWY,info.mapType,info.parentMapID
		loco.tarZone = info.name
		return mapID, x, y, title, stqID, info.parentMapID, complete, curObj
	else
		return nil, nil, nil, "Unknown", nil
	end
end

function shEErThEShEEp(baa,bad)
	if bad then
		loco.weed = bad
	end
	loco.gather = {}
	if baa then
		for mary,lamb in pairs(baa) do
			--print(mary.." - "..lamb)
			loco.gather[mary] = lamb
		end
	end
end

function wOOlgAthEr(yarn)
	if yarn then
		loco.gather = nil
		loco.gather = loco.basket
		loco.basket = nil
		if loco.gather and not loco.basket then
			loco.basket = {}
			return true
		end
	end
	local zoneName = GetZoneText()
	if not loco.weed or not loco.weed.zone then
		--loco.gather = nil
		--loco.basket = nil
		return
	end
	if zoneName ~= loco.weed.zone then
		return
	end
	local pMap = C_Map.GetBestMapForUnit("player")
	local pX,pY,pMap = GetPlayerPosition()
	local info = C_Map.GetMapInfo(pMap)
	
	--print("pX: "..tostring(kx)..", pY: "..tostring(ky))
	local little = 9999
	local things, bling
	local x,y,h,kx,ky,gX,gY
	
	if loco.gather then
		for k,v in pairs(loco.gather) do
			kx, ky = strsplit("-", k, 2)
			--print("kx: "..tostring(kx)..", ky: "..tostring(ky))
			x = math.abs(pX-kx)^2
			y = math.abs(pY-ky)^2
			h = math.sqrt(x+y)
			--print(h)
			if h < little then
				things = k
				little = h
				gX = tonumber(kx)
				gY = tonumber(ky)
				--print(things)
			end
		end
	end
	if things then
		loco.basket = loco.basket or {}
		loco.basket[things] = loco.gather[things]
		bling = loco.gather[things]
		loco.gather[things] = nil
	end
	things = things or "baaaa"
	return things,bling,gX,gY
end

function DistanceRecorder()
	--Lunacy[playerKey].lastPos = Lunacy[playerKey].lastPos or {}
	if loco.pMap ~= Lunacy[playerKey].lastPos.Map then
		Lunacy[playerKey].lastPos.Map = loco.pMap
		Lunacy[playerKey].lastPos.X = loco.pX
		Lunacy[playerKey].lastPos.Y = loco.pY
		loco.lastTime = GetTimePreciseSec()
		return
	end	
	local dX, dY = Lunacy[playerKey].lastPos.X, Lunacy[playerKey].lastPos.Y
	--local dis = HBD:GetWorldCoordinatesFromZone(Lunacy[playerKey].lastPos.X, Lunacy[playerKey].lastPos.Y, Lunacy[playerKey].lastPos.Map)
	--local dis = math.abs(HBD:GetWorldDistance(loco.pPntMap, loco.pWX, loco.pWY, dX, dY))
	local dis = HBD:GetZoneDistance(loco.pMap, loco.pX, loco.pY, loco.pMap, dX, dY)
	if not dis then
		dis = 0
	end
	local diffTime = 0.001
	if loco.lastTime then
		diffTime = math.abs(GetTimePreciseSec() - loco.lastTime)
		if diffTime > 15 or diffTime <= 0 then
			diffTime = 0.001
		end
		--local difDis = math.abs(loco.distance - loco.lastDistance)
	end
	
	table.remove(timeTab,1)
	table.insert(timeTab, diffTime)
	local avg = 0
	for i,v in ipairs(timeTab) do
		avg = avg + v
	end
	diffTime = avg / spdTsz
	
	table.remove(distTab,1)
	table.insert(distTab, dis)
	--avg = 0
	avg = 0
	for i,v in ipairs(distTab) do
		avg = avg + v
		--avg = avg
	end
	dis = avg / spdTsz --smooth jazz
	
	--if dis > 0 then
		--print(dis)
	--end
	
	phPref = Luna.phPref or "kph"
	local spd = 0
	loco.coLor = loco.coLor or "Mulberry"
	local cLr = loco.coLor
	local r,g,b,sex,chex
	if dis then
		dis = dis * 0.77
		loco.lastdis = dis
		if dis >= 0 and dis < 125 then
			spd = (dis/1760)/diffTime*3600
			spd = floor(spd*1000)/1000
			if phPref == "kph" then
				spd = spd * 1.609344
			end
			loco.spd = spd
			if spd == 0 then
				r,g,b = hex2rgb(GetHexColor(loco.coLor))
				--r = r/255
				--g = g/255
				--b = b/255
			else
				r = math.min(spd * 3.6, 255)
				g = math.max(255-spd * 3.6, 0)
				b = 0
			end
			chex = {r,g,b}
			sex = deCHex(chex)
			--if loco.idx > 0 then
				Lunacy.Text4 = "<|cff"..sex..string.format("%.2f "..phPref, spd).."|r>"
				LunacyMainFrame.Speed:SetText(Lunacy.Text4)
			--end
			--Lunacy.Text4 = "<"..tostring(spd)..">"
			Lunacy[playerKey].totalDistance = Lunacy[playerKey].totalDistance + dis
			local tDis = Lunacy[playerKey].totalDistance or 0
			loco.jaunt = loco.jaunt or Lunacy[playerKey].totalDistance
			if tDis - loco.jaunt > 144 then
				loco.jaunt = tDis
				if IsFlying("player") then
					FlashMe("AeroBlue") --Wind
				else
					FlashMe("Coffee") --Earth
				end
			end
			if loco.murgle then
				loco.murgle = loco.murgle + dis
				tDis = loco.murgle / 176
			else
				tDis = Lunacy[playerKey].totalDistance / 176
			end
			if phPref == "kph" then
				tDis = tDis * 1.609344
			end
			
			if Lunadometer:IsShown() then
				local ones, nones, lones = 0, true, tDis - math.floor(tDis)
				for i=1, 6 do
					ones = mod(tDis, 10)
					if ones >= 9 and nones then
						tDis = tDis / 10
						ones = math.floor(ones) + lones
					elseif nones then
						tDis = math.floor(tDis/10)
						ones = math.floor(ones) + lones
						nones = nil
					else
						tDis = math.floor(tDis/10)
						nones = nil
					end
					diSStrip[i-1].texture:SetTexCoord(0, 1, 0.078125 * (0 + ones), 0.078125 * (1 + ones))
				end
				loco.lones = lones
			end
			Lunacy[playerKey].lastPos.X = loco.pWX
			Lunacy[playerKey].lastPos.Y = loco.pWY
			Lunacy[playerKey].lastPos.Map = pMap
		end
		--if dis > 0 and dbgLatch then
			--print(dis)
			--dbgLatch = nil
		--end
	elseif dbgLatch then
		print("distance error")
		dbgLatch = nil
	end
	
	
	
	--if spd > 0 then
		--print(spd)
	--end
	if loco.idx == 1 then
		--print(spd)
		if spd == 0 then
			r,g,b = hex2rgb(GetHexColor(loco.coLor))
			
		--else
			--r = math.min(spd/100,1.0)
			--g = math.abs(1.0-(spd/100))
			--b = 0
		end
		r = r/255
		g = g/255
		b = b/255
		CompArrow.texture:SetVertexColor(r, g, b, 1)
		local angle = 4.52 - math.rad(spd*1.17) 
		local s,c = math.sin(angle) * math.sqrt(0.5), math.cos(angle) * math.sqrt(0.5)
		CompArrow.texture:SetTexCoord(0.5-s,0.5+c,0.5+c,0.5+s,0.5-c,0.5-s,0.5+s,0.5-c)
	end
	
	loco.lastTime = GetTimePreciseSec()
	--loco.lastDistance = dis or 0
	--loco.lastDistance = loco.distance
	
end

function ClearDistance()
	Lunacy[playerKey].totalDistance = 0
end

local function updateExplored(x, y, mapID)
	local exploredAreaIDs = C_MapExplorationInfo.GetExploredAreaIDsAtPosition(mapID, CreateVector2D(x, y));
	exploredMaps[mapID] = exploredMaps[mapID] or {}
	if exploredAreaIDs then
		for i, areaID in ipairs(exploredAreaIDs) do
			exploredMaps[mapID][areaID] = true
		end
	end
end

function Lunacy_GetNextExplore(x, y, mapID)
	updateExplored(x, y, mapID)
	if Lunacy.ExploreData then
	
	end
end

function Lunacy_PacaTracka(x, y, pMapID)
	if loco.hasTrack ~= "alpaca" then
		--get index of closest waypoint
		local mxDis = 10000000
		local tmDis = 0
		local slIdx
		local aDT = Lunacy_Alpaca.waypoints
		local x, y, pMapID = HBD:GetPlayerZonePosition(true)
		
		for i, v in pairs(aDT) do
			tmDis = HBD:GetZoneDistance(pMapID, x, y, v.m, v.x, v.y)
			if tmDis then
				if tmDis < mxDis then
					mxDis = tmDis
					slIdx = i
				end
			end
		end
		
		if slIdx then
			loco.hasTrack = "alpaca"
			Lunacy.tracker.startIdx = slIdx
			Lunacy.tracker.currentIdx = slIdx
		end
	else
		Lunacy.tracker.currentIdx = Lunacy.tracker.currentIdx + 1
		if Lunacy.tracker.currentIdx > #Lunacy_Alpaca.waypoints then
			Lunacy.tracker.currentIdx = 1
		end
	end
	
	local way = Lunacy_Alpaca.waypoints[Lunacy.tracker.currentIdx]
	if not way then
		return 2, 0.5, 0.5, "Wrong Zone"
	end
	-- AddMinimapIconMap(ref, icon, uiMapID, x, y, showInParentZone, floatOnEdge)
	--hbdp:RemoveMinimapIcon("LunacyIcon", Lunacy.destIcon)
	if Lunacy.destIcon and way then
		pins:AddMinimapIconMap("LunacyIcon", Lunacy.destIcon, way.m, way.x, way.y, true, true)
	end
	if destIcon and way then
		pins:AddWorldMapIconMap("LunacyMapIcon", destIcon, way.m, way.x, way.y, true, PIN_FRAME_LEVEL_AREA_POI)
	end
	loco.lock = true
	Lunacy.tracker.lastX = way.x
	Lunacy.tracker.lastY = way.y
	Lunacy.tracker.lastM = way.m
	Lunacy.tracker.lastObj = "Friendly Alpaca"
	loco.destCheck = true
	return way.m, way.x, way.y, "Friendly Alpaca"
	
end

