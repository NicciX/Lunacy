local HBD = LibStub("HereBeDragons-2.0")
--local pins = LibStub("HereBeDragons-Pins-2.0")

local _, Lunacy = ...
local grimoire = Lunacy.grimoire
local DrawCard = Lunacy.DrawCard
local trOlls = Lunacy.trOlls
local wHIspRES = Lunacy.wHIspRES
local Ramble = Lunacy.Ramble
local colorMe = Lunacy.colorMe
local GetNextColor = Lunacy.GetNextColor
local loco = {}

Lunacy.EarThis = function(sound)
	loco.wOi = wHIspRES[sound]
	loco.lastEar = sound
	PlaySoundFile(sound)
	if (L_DBG >= 4 or L_DBF["EarThis"]) then
		local trl,clr = trOlls[sound], "Indigo"
		if trl and trOlls[trl]then
			clr = trOlls[trl].clr or "Indigo"
			loco.kook = trOlls[trl].desc
			loco.bijou = trl
			loco.house = trOlls[trl].house
		end
		local woikey = tostring(loco.wOi)
		if string.find(woikey," ") then
			print(woikey:sub(1,string.find(woikey," ")-1))
		end
		Ramble(colorMe(woikey, clr).." ("..tostring(sound)..")", colorMe("[EarThis] ", "NeonYellow"))
	end
	if loco.wOi then
		loco.earthis = loco.wOi
		loco.lastear = loco.wOi
		return loco.wOi
	end
end

local formatTime = Lunacy.formatTime
local chatStack = {}
local EarThis = Lunacy.EarThis
local DistanceRecorder
local TrollMe = Lunacy.TrollMe

Lunacy.stack_chat = function(chat, chan)
	local ss = #chatStack
	chatStack[ss+1] = {}
	chatStack[ss+1].chat = chat
	chatStack[ss+1].chan = chan
	chatStack[ss+1].choo = GetTimePreciseSec() + (ss+1)
	return
end

Lunacy.DumpTroll = function()
	Ramble(" = "..colorMe(tostring(loco.digroot), "Yellow")..",", colorMe("Skit", "Emerald"))
	Ramble(" = "..colorMe(tostring(loco.trOll), "Yellow")..",", colorMe("[\"id\"]", "Emerald"))
	Ramble(" = "..colorMe(tostring(loco.gizmo), "Yellow")..",", colorMe("[\"gizmo\"]", "Emerald"))
	Ramble(" = "..colorMe(tostring(loco.sandyRot), "Yellow")..",", colorMe("[\"rot\"]", "Emerald"))
	Ramble(" = "..colorMe(tostring(loco.pitch), "Yellow")..",", colorMe("[\"pitch\"]", "Emerald"))
	Ramble(" = "..colorMe(tostring(loco.yaw), "Yellow")..",", colorMe("[\"yaw\"]", "Emerald"))
	Ramble(" = "..colorMe(tostring(loco.xoff), "Yellow")..",", colorMe("[\"xoff\"]", "Emerald"))
	Ramble(" = "..colorMe(tostring(loco.yoff), "Yellow")..",", colorMe("[\"yoff\"]", "Emerald"))
	Ramble(" = "..colorMe(tostring(loco.zoff), "Yellow")..",", colorMe("[\"zoff\"]", "Emerald"))
	Ramble(" = "..colorMe(tostring(loco.camtarX), "Yellow")..",", colorMe("[\"camtarX\"]", "Emerald"))
	Ramble(" = "..colorMe(tostring(loco.camtarY), "Yellow")..",", colorMe("[\"camtarY\"]", "Emerald"))
	Ramble(" = "..colorMe(tostring(loco.camtarZ), "Yellow")..",", colorMe("[\"camtarZ\"]", "Emerald"))
	Ramble(" = "..colorMe(tostring(loco.rotinc), "Yellow")..",", colorMe("[\"rotinc\"]", "Emerald"))
	Ramble(" = "..colorMe(tostring(loco.campulse), "Yellow")..",", colorMe("[\"campulse\"]", "Emerald"))
	Ramble(" = "..colorMe(tostring(loco.camMin), "Yellow")..",", colorMe("[\"camMin\"]", "Emerald"))
	Ramble(" = "..colorMe(tostring(loco.camMax), "Yellow")..",", colorMe("[\"camMax\"]", "Emerald"))
	Ramble(" = "..colorMe(tostring(loco.dance), "Yellow")..",", colorMe("[\"dance\"]", "Emerald"))
end

local farmKeys = {
	["decay"] = function(val)
		if val then
			val = tonumber(val)
		end
		if type(val) ~= "number" then
			print(tostring(val).." > not a number..")
			return val
		end
		local x = floor((val - GetTimePreciseSec()) * 100) / 100
		return tostring(x).." seconds remaining.."
	end
}

Lunacy.GetLoco = function(key)
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
	--print(kyA)
	--print(kyB)
	--print(kyC)
	
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
				--farm = farmKeys[kyB](bite)
				if farmKeys[kyB] then
					farm = farmKeys[kyB](bite)
				end
			end
		elseif not howl then
			keys = string.split(" ", key)
			howl = true
		else
			bark = select(random(4),"~*nope*~", "~surely not~", "~..appears to be empty..~", "~.nil or nan like an empty can.~", "~!you're crazy!~", "~it appears to be empty..~")
		end
	until bite or bark
	return tostring(bark or bite), farm
end

Lunacy.SetLoco = function(key,value,keyb,keyc,keyd)
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
		if tonumber(value) then
			loco[key][keyb][keyc][keyd] = tonumber(value)
		else
			loco[key][keyb][keyc] = value
		end
	elseif keyc and loco[key] and loco[key][keyb] and loco[key][keyb][keyc] then
		loco[key][keyb][keyc] = value
		if tonumber(value) then
			loco[key][keyb][keyc] = tonumber(value)
		else
			loco[key][keyb][keyc] = value
		end
	elseif keyb and loco[key] and loco[key][keyb] then
		loco[key][keyb] = value
		if tonumber(value) then
			loco[key][keyb] = tonumber(value)
		else
			loco[key][keyb] = value
		end
	elseif loco[key] then
		if tonumber(value) then
			loco[key] = tonumber(value)
			print("good news everyone! it's a 'number'")
		else
			loco[key] = value
			print("bad news everyone :( it's not a 'number'")
		end
	elseif tonumber(value) then
		loco[key] = tonumber(value)
		print("good news everyone! it's a 'number'")
	elseif key and value then
		loco[key] = value
		print("bad news everyone :( it's not a 'number'")
	else
		return "well shit, that didn't seem to work so well!"
	end
	
	return key.." set to "..tostring(value)
end

local GetLoco = Lunacy.GetLoco
local SetLoco = Lunacy.SetLoco
local SetColorGroup = Lunacy.SetColorGroup
local GetHexColor = Lunacy.GetHexColor
local caPit = Lunacy.caPit
local deCHex = Lunacy.deCHex
local hex2rgb = Lunacy.hex2rgb
local table_to_string = Lunacy.table_to_string
local factors = Lunacy.factors
local IsPrime = Lunacy.IsPrime
local digRoot = Lunacy.digRoot

local random = math.random
local sin = math.sin
local cos = math.cos
local floor = math.floor
local rad = math.rad

Lunacy.Text1 = "Unknown"
Lunacy.Text2 = "0"

Lunacy.Timer = 0
Lunacy.loadDelay = 0
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

local destRadius = 7

local elders = {}
local qComp = {}

local ddC = 0

loco.idx = 0

local dbgLatch = true

local sounds = {541055,559193,568873}
local compMode = {"gyre", "odometer", "compass"}
local compClr = {"Bronze", "Silver", "Gold"}
local destCheck = {false, false, true}
local stigma = {}
stigma.L = "/(.Y.)\\" -- Mode Select
stigma.UN = "`(.|||.)´" -- Pause
stigma.LAUN = "<(o)o)<" -- Puppeteer
stigma.ANUL = "/~v~\\" --Grimoire 
stigma.ALU = "Xo)O)x" --Settings 
stigma.LUA = "L(\U/)A" --Lua 
stigma.N = "L(o)o)K" --Color Select
--NULA

local shadow = {}
shadow.L = "Veronica"
shadow.UN = "SkyBlue"
shadow.LAUN = "Turquoise"
shadow.ANUL = "Indigo"
shadow.ALU = "Citrine"
shadow.LUA = "Violet"
shadow.N = "Shamrock"
--Main frame for the Compass
local LunacyMainFrame = CreateFrame("Frame", "LunacyMainFrame", UIParent)
LunacyMainFrame:ClearAllPoints()
LunacyMainFrame:SetPoint("CENTER")
LunacyMainFrame:EnableMouse(enable)
LunacyMainFrame:SetMovable(true)
function LunacyMainFrame:Init()
	--self:ClearAllPoints()
	--self:SetPoint("CENTER")
	--self:EnableMouse(enable)
	self:SetWidth(96)
	self:SetHeight(96)
	--self:SetMovable(true)
	self:SetFrameLevel(1)
	self:SetScale(1.0)
end

-- Lunacy Gyre
local LunacyGyre = CreateFrame("Button", "LunacyGyre", LunacyMainFrame)
function LunacyGyre:Init()
	self:SetWidth(96);
	self:SetHeight(96);
	self:EnableMouse(enable)
	self.texture = self:CreateTexture()
	self.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\LunacyA")
	self:SetPoint("CENTER")
	self:SetFrameStrata("LOW")
	self.texture:SetDrawLayer("ARTWORK", 5)
	self.texture:SetBlendMode("BLEND")
	self.texture:SetAllPoints(LunacyMainFrame)
	self.texture:SetVertexColor(1.0, 1.0, 1.0, 1.0)
	self:SetFrameLevel(1)
end

-- Outer Frame X
local LunacyFrameX = CreateFrame("Button", "LunacyFrameX", UIParent)
function LunacyFrameX:Init()
	self:SetWidth(96);
	self:SetHeight(96);
	self:EnableMouse(enable)
	self.texture = self:CreateTexture()
	self.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\Outer-Ring")
	self:SetPoint("CENTER")
	self:SetFrameStrata("MEDIUM")
	self.texture:SetDrawLayer("ARTWORK", 1)
	--LunacyFrameX.texture:SetAllPoints(LunacyMainFrame)
	self.texture:SetPoint("CENTER", LunacyMainFrame)
	self.texture:SetPoint("RIGHT", LunacyMainFrame, "RIGHT", 65, 0)
	self.texture:SetPoint("TOP", LunacyMainFrame, "TOP", 0, 63)
	self.texture:SetVertexColor(0.6, 0.6, 0.6)
	--LunacyFrameX.texture:SetTexCoord(0, 1, 0, 1)
	self:SetFrameLevel(27)
	self:SetScale(0.75)
end

-- Lunacy Dial
local LunacyFrameA = CreateFrame("Button", "LunacyFrameA", LunacyMainFrame)
function LunacyFrameA:Init()
	self:SetWidth(96);
	self:SetHeight(96);
	self:EnableMouse(enable)
	self.texture = self:CreateTexture()
	self.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\Compass")
	self:SetPoint("CENTER")
	self:SetFrameStrata("LOW")
	self.texture:SetDrawLayer("ARTWORK", 1)
	self.texture:SetAllPoints(LunacyMainFrame)
	self.texture:SetVertexColor(0, 0.75, 0.75)
	self:SetFrameLevel(2)
end

-- Lunadometer
local Lunadometer = CreateFrame("Button", "Lunadometer", LunacyMainFrame)
function Lunadometer:Init()
	self:SetWidth(96);
	self:SetHeight(96);
	self:EnableMouse(enable)
	self.texture = self:CreateTexture()
	self.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\CompassH")
	self:SetPoint("CENTER")
	self:SetFrameStrata("LOW")
	self.texture:SetDrawLayer("ARTWORK", 1)
	self.texture:SetAllPoints(LunacyMainFrame)
	self.texture:SetVertexColor(0, 0.75, 0.75)
	self:SetFrameLevel(3)
end

-- Lunacy Outer Ring
local LunacyFrameB = CreateFrame("Button", "LunacyFrameB", LunacyMainFrame)
function LunacyFrameB:Init()
	self:SetWidth(96);
	self:SetHeight(96);
	self:EnableMouse(enable)
	self.texture = self:CreateTexture()
	self.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\CompassB")
	self:SetPoint("CENTER")
	self:SetFrameStrata("MEDIUM")
	self.texture:SetDrawLayer("ARTWORK", 4)
	self.texture:SetBlendMode("BLEND")
	self.texture:SetAllPoints(LunacyMainFrame)
	--LunacyFrameB.texture:SetVertexColor(0.77, 0.77, 0.77, 1)
	self.texture:SetVertexColor(0.77, 0.91, 0.91)
	self:SetFrameLevel(31)
	--LunacyFrameB:SetScript("OnMouseDown", MouseDown(self,button))
	--self:SetScript("OnMouseUp", MouseUp(self,button))
	--print("FrameB:Init()")
end

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

local sandy = CreateFrame("PlayerModel", "Sandy", LunacyFrameB)
function sandy:init()
	self:SetPoint("CENTER")
	--sandy:SetAllPoints(LunacyMainFrame)
	--sandy:SetPoint("TOPLEFT", LunacyFrameB, "TOPLEFT", 15, -8)
	self:SetPoint("TOPLEFT", LunacyFrameB, "TOPLEFT", 4, -4)
	self:SetSize(88, 88)
	self:SetDisplayInfo(21723)
	--sandy:SetDisplayInfo(26375)
	--sandy:SetPortraitZoom(1.5)
	self:SetFrameStrata("MEDIUM")
	self:SetFrameLevel(13)
	self.x = 0
	self.y = 0
	--self.offX = 15
	--self.offY = -8
end

function sandy:SetOrientation(distance, yaw, pitch)
    if self:HasCustomCamera() then
        self.distance, self.yaw, self.pitch = distance, yaw, pitch
        local x = distance * cos(yaw) * cos(pitch)
        local y = distance * sin(-yaw) * cos(pitch)
        local z = distance * sin(-pitch)
        self:SetCameraPosition(x, y, z)
		self:SetPitch(pitch)
		self:SetRoll(yaw)
		--print(x)
		--print(y)
		--print(z)
    end
end

function sandy:Roll()
    local x, y = GetCursorPosition()
    local yaw = self.yaw + (x - self.x) * 0.001
    local pitch = self.pitch + (y - self.y) * 0.001
    if pitch > math.pi/2 then
        pitch = math.pi/2 - 0.05
    elseif pitch < - math.pi/2 then
        pitch = - math.pi/2 + 0.05
    end
    self:SetOrientation(self.distance, yaw, pitch)
    self.x, self.y = x, y
end

--Lunacy Bubble
local LunacyFrameC = CreateFrame("Button", "LunacyFrameC", LunacyMainFrame)
function LunacyFrameC:Init()
	self:SetWidth(96);
	self:SetHeight(96);
	self:EnableMouse(enable)
	self.texture = self:CreateTexture()
	self.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\CompassC")
	self:SetPoint("CENTER")
	self:SetFrameStrata("MEDIUM")
	self.texture:SetDrawLayer("ARTWORK", 5)
	self.texture:SetBlendMode("ADD")
	self.texture:SetAllPoints(LunacyMainFrame)
	self.texture:SetVertexColor(0.85, 0.85, 0.85, 0.45)
	self:SetFrameLevel(23)
end

--Lunacy Arrow
local CompArrow = CreateFrame("Button", "CompArrow", LunacyMainFrame)
function CompArrow:Init()
	self:SetWidth(96);
	self:SetHeight(96);
	self:EnableMouse(enable)
	self.texture = self:CreateTexture()
	self.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\Arrow")
	self:SetPoint("CENTER")
	self:SetFrameStrata("MEDIUM")
	self:SetFrameLevel(14)
	self.texture:SetDrawLayer("ARTWORK", 5)
	self.texture:SetBlendMode("BLEND")
	self.texture:SetAllPoints(LunacyMainFrame)
	self.texture:SetVertexColor(0.0, 0.25, 0.90, 1)
end

local Reticule = CreateFrame("Button", "LunaReticule", LunacyMainFrame)
function Reticule:Init()
	self:SetWidth(96)
	self:SetHeight(96)
	self:EnableMouse(enable)
	self.texture = self:CreateTexture()
	self.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\Reticule")
	self:SetPoint("CENTER")
	self:SetFrameStrata("MEDIUM")
	self:SetFrameLevel(10)
	self.texture:SetDrawLayer("ARTWORK", 5)
	self.texture:SetBlendMode("BLEND")
	self.texture:SetAllPoints(LunacyMainFrame)
	self.texture:SetVertexColor(0.1, 0.7, 0.1)
	self:SetFrameLevel(33)
end

local LineArray = CreateFrame("Button", "LineArray", LunacyMainFrame)
function LineArray:Init()
	self:SetPoint("CENTER")
	self:EnableMouse(enable)
	self:SetWidth(96)
	self:SetHeight(96)
	--Reticule:SetFrameStrata("MEDIUM")
	self:SetFrameLevel(11)
end

CompArrow.visible = true
CompArrow.trackMap = 1
CompArrow.trackX = 0.5
CompArrow.trackY = 0.5

--Distance Text
local Distance = LunacyMainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
function Distance:Init()
	self:SetText(Lunacy.Text2.." yds")
	self:SetPoint("CENTER", LunacyMainFrame)
	self:SetPoint("BOTTOM", LunacyMainFrame, "TOP", 0, 22)
	self:SetTextColor(1,1,1,1)
	self:SetFont(self:GetFont(), 12, "OUTLINE")
end

--Speed Text
local Speed = LunacyMainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
function Speed:Init()
	self:SetText(Lunacy.Text4)
	self:SetPoint("CENTER", LunacyMainFrame)
	self:SetPoint("BOTTOM", LunacyMainFrame, "TOP", 0, 38)
	self:SetTextColor(1,1,1,1)
	self:SetFont(self:GetFont(), 12, "OUTLINE")
end

--Objective Text 
local Objective = LunacyMainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
function Objective:Init()
	self:SetText(Lunacy.Text1)
	self:SetPoint("CENTER", LunacyMainFrame)
	self:SetPoint("TOP", LunacyMainFrame, "BOTTOM", 0, -20)
	self:SetTextColor(1,1,1,1)
	self:SetFont(self:GetFont(), 12, "OUTLINE")
end

--ObjectiveB Text 
local ObjectiveB = LunacyMainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
function ObjectiveB:Init()
	self:SetWordWrap(true)
	self:SetText(Lunacy.Text3)
	self:SetPoint("CENTER", LunacyMainFrame)
	self:SetPoint("TOP", LunacyMainFrame, "BOTTOM", 0, -36)
	self:SetTextColor(1,1,1,1)
	self:SetFont(self:GetFont(), 12, "OUTLINE")
end

--ObjectiveC Text 
local ObjectiveC = LunacyMainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
function ObjectiveC:Init()
	self:SetWidth(175)
	self:SetHeight(40)
	self:SetWordWrap(true)
	self:SetText(Lunacy.Text5)
	self:SetPoint("CENTER", ObjectiveB)
	self:SetPoint("TOP", ObjectiveB, "BOTTOM", 0, -4)
	self:SetTextColor(1,1,1,1)
	self:SetFont(self:GetFont(), 12, "OUTLINE")
	self:SetJustifyV("TOP")
end

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

local function HideLines(a,b)
	for i=a,b do
		if LineSet[i] then
			LineSet[i]:Hide()
		end
	end
end
local function ShowLines(a,b)
	for i=a,b do
		if LineSet[i] then
			LineSet[i]:Show()
		end
	end
end

local Btn = {}
--LUNA Button L
Btn.L = CreateFrame("Button", "BtnL", LunacyMainFrame)
Btn.U = CreateFrame("Button", "BtnU", LunacyMainFrame)
Btn.N = CreateFrame("Button", "BtnN", LunacyMainFrame)
Btn.A = CreateFrame("Button", "BtnA", LunacyMainFrame)

local function BtnInit(btn)
	local r,g,b,a = 70,130,80,0.37
	--Btn[btn]
	Btn[btn]:SetWidth(16)
	Btn[btn]:SetHeight(16)
	Btn[btn]:EnableMouse(enable)
	Btn[btn].texture = Btn[btn]:CreateTexture()
	Btn[btn].texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\Btn"..btn)
	Btn[btn]:SetFrameStrata("MEDIUM")
	Btn[btn].texture:SetDrawLayer("ARTWORK", 4)
	Btn[btn].texture:SetBlendMode("BLEND")
	--Btn[btn].texture:SetPoint("TOP", LunacyMainFrame, "TOP", 0, 15)
	Btn[btn]:SetFrameLevel(42)
	Btn[btn].btn = btn -- I'm not sure how to feel about this..
	if btn == "L" then
		Btn[btn]:SetPoint("TOP", LunacyMainFrame, "TOP", 0, 15)
		Btn[btn].texture:SetPoint("TOP", LunacyMainFrame, "TOP", 0, 15)
	elseif btn == "U" then
		Btn[btn]:SetPoint("RIGHT", LunacyMainFrame, "Right", 15, 0)
		Btn[btn]:SetPoint("TOP", LunacyMainFrame, "TOP", 0, -41)
		Btn[btn].texture:SetPoint("RIGHT", LunacyMainFrame, "Right", 15, 0)
		Btn[btn].texture:SetPoint("TOP", LunacyMainFrame, "TOP", 0, -41)
	elseif btn == "N" then
		Btn[btn]:SetPoint("BOTTOM", LunacyMainFrame, "BOTTOM", 0, -15)
		Btn[btn].texture:SetPoint("BOTTOM", LunacyMainFrame, "BOTTOM", 0, -15)
	elseif btn == "A" then
		Btn[btn]:SetPoint("LEFT", LunacyMainFrame, "LEFT", -15, 0)
		Btn[btn]:SetPoint("TOP", LunacyMainFrame, "TOP", 0, -41)
		Btn[btn].texture:SetPoint("LEFT", LunacyMainFrame, "LEFT", -15, 0)
		Btn[btn].texture:SetPoint("TOP", LunacyMainFrame, "TOP", 0, -41)
	end
	--print(loco.btns)
	if loco.btns and string.find(loco.btns, btn) then
		if shadow[loco.btns] then
			r,g,b = hex2rgb(GetHexColor(shadow[loco.btns]))
		else
			r,g,b = hex2rgb(GetHexColor("CandyApple"))
		end
		a = 1.0
	else
		r,g,b = hex2rgb(GetHexColor("SteelBlue"))
	end
	Btn[btn].texture:SetVertexColor(r/255,g/255,b/255,a)
end

Lunacy.CurrentGyreState = function()
	local locokeys = {
		"cants","lsSpinRate","lsSpinOver","orbit","orbinc","orbrad","degInc","lsOFFset",
		"lsConnect","colorSet","lineClr","drX","drY","sticky","rube","ring","pulse","funcX",
		"funcY","dippX","dippY","lineAlpha","lsRadAdjX","lsRadAdjY","lsSkew","gyreVert",
		"gyreTex","trOll","lsRotSmooth","lsRad","lsRadInc",
	}
	local CgS = {}
	for i,v in pairs(locokeys) do
		CgS[v] = loco[v]
	end
	return CgS
	
end

function initLineSet(spell)
	if not grimoire[spell] or loco.byeLines then
		return
	end
	local num,spin,rd,degInc,rdInc = grimoire[spell].num,grimoire[spell].spin,grimoire[spell].rd,grimoire[spell].degInc,grimoire[spell].rdInc
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
	loco.orbit = grimoire[spell].orbit
	loco.orbinc = grimoire[spell].orbinc
	loco.orbrad = grimoire[spell].orbrad
	loco.degInc = degInc
	loco.overTime = GetTimePreciseSec()
	loco.lsOFFset = loco.lsOFFset or 0
	loco.lsConnect = connect
	loco.colorSet = colorSet or "CandyApple"
	loco.lineClr = grimoire[spell].lineClr
	loco.drX = drX
	loco.drY = drY
	--loco.sticky = grimoire[spell].sticky or 0
	loco.sticky = loco.sticky or 0
	loco.rube = grimoire[spell].rube
	loco.ring = loco.ring or "Platinum"
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
	--loco.degInc = degInc
	loco.lsRad = rd or 11
	loco.lsRadInc = rdInc or 0
	if loco.hidebubble or loco.nobubble or loco.hubblebubble then
		LunacyFrameC:Hide()
	end
	if loco.gyreVert then
		r,g,b = hex2rgb(GetHexColor(loco.gyreVert))
		LunacyGyre.texture:SetVertexColor(r/255, g/255, b/255)
	end
	if grimoire[spell].ring then
		--if loco.ring ~= grimoire[spell].ring then
			loco.ring = grimoire[spell].ring
			--print(loco.ring)
			r,g,b = hex2rgb(GetHexColor(loco.ring))
			LunacyFrameB.texture:SetVertexColor(r/255, g/255, b/255,1)
		--end
	elseif loco.ring ~= "Platinum" then
		loco.ring = "Platinum"
		print(loco.ring)
		r,g,b = hex2rgb(GetHexColor(loco.ring))
		LunacyFrameB.texture:SetVertexColor(r/255, g/255, b/255,1)
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
			--sandy:SetPoint("TOPLEFT", LunacyFrameB, "TOPLEFT", trock.offX, trock.offY)
			if trock.anim and sandy:HasAnimation(trock.anim) then
				sandy:SetAnimation(trock.anim)
				loco.anim = trock.anim
				loco.currentAnim = loco.anim
			end
			sandy:SetDoBlend(true)
			sandy:ZeroCachedCenterXY()
			loco.sandyRot = trock.rot
			sandy:SetRotation(rad(trock.rot))
			loco.camdis = trock.camdis or loco.camdis or 1.0
			if not sandy:HasCustomCamera() then
				sandy:SetCustomCamera(1)
			end
			if sandy:HasCustomCamera() then
				sandy:SetCameraDistance(loco.camdis)
			end
		--[[
		elseif spell == "Scarlet" then
			if sandy:HasAnimation(69) then
				sandy:SetPoint("TOPLEFT", LunacyFrameB, "TOPLEFT", 15, -18)
				sandy:SetAnimation(69)
				sandy:SetRotation(rad(180))
				loco.camdis = 0.88
				--sandy:SetCameraDistance(loco.camdis)
				--sandy:SetCamDistanceScale(0.88)
				sandy:SetCamDistance(0.88)
				sandy:SetDoBlend(true)
				sandy:ZeroCachedCenterXY()
				--sandy:SetPortraitZoom(100)
				--sandy:SetPoint("TOPLEFT", LunacyFrameB, "TOPLEFT", 15, -8)
			end
		]]--
		elseif trOlls[loco.trOll] then
			TrollMe(loco.trOll)
			print("TrollMe")
		--else
			--loco.sandyRot = 0
			--sandy:SetAnimation(0)
			--sandy:SetRotation(0)
			--sandy:SetCameraDistance(loco.camdis)
			--sandy:SetCamDistanceScale(1)
			--sandy:SetPoint("TOPLEFT", LunacyFrameB, "TOPLEFT", 15, -8)
		end
	end
	
	--local rdX
	for i=1,num do
		loco.liNes[i] = loco.liNes[i] or {}
		--loco.liNes[i].x1 = loco.liNes[i].x1 or (random(77) - 37)
		--loco.liNes[i].y1 = loco.liNes[i].y1 or (random(77) - 37)
		--loco.liNes[i].x2 = loco.liNes[i].x2 or (random(77) - 37)
		--loco.liNes[i].y2 = loco.liNes[i].y2 or (random(77) - 37)
		loco.liNes[i].rdA = loco.lsRad + loco.lsRadInc * i
		loco.liNes[i].angA = i * loco.degInc
		loco.liNes[i].rdB = loco.lsRad + loco.lsRadInc * i
		loco.liNes[i].angB = (i + 1) * loco.degInc
		if loco.lsConnect then
			if i > 1 and i < num then
				loco.liNes[i].rdA = loco.liNes[i-1].rdB
				loco.liNes[i].angA = loco.liNes[i-1].angB
				loco.liNes[i].rdB = loco.lsRad + loco.lsRadInc * i
				loco.liNes[i].angB = (i + 1) * loco.degInc
			elseif i == num then
				loco.liNes[i].rdA = loco.liNes[i-1].rdB
				loco.liNes[i].angA = loco.liNes[i-1].angB
				loco.liNes[i].rdB = loco.liNes[1].rdA
				loco.liNes[i].angB = loco.liNes[1].angA
			else
				loco.liNes[i].rdA = loco.lsRad + loco.lsRadInc * i
				loco.liNes[i].angA = (i + 1) * loco.degInc
				loco.liNes[i].rdB = loco.lsRad + loco.lsRadInc * (i+1)
				loco.liNes[i].angB = (i + 2) * loco.degInc
			end
		end
		loco.liNes[i].x1 = cos(rad(loco.liNes[i].angA)) * loco.liNes[i].rdA
		loco.liNes[i].y1 = sin(rad(loco.liNes[i].angA)) * loco.liNes[i].rdA
		loco.liNes[i].x2 = cos(rad(loco.liNes[i].angB)) * loco.liNes[i].rdB
		loco.liNes[i].y2 = sin(rad(loco.liNes[i].angB)) * loco.liNes[i].rdB
		
		if type(colorSet) == "table" then
			loco.liNes[i].color = colorSet[mod(i,#colorSet)]
		else
			loco.liNes[i].color = loco.lineClr
		end
		--loco.liNes[i].color = loco.lsDefClr or "CandyApple"
		if not LineSet[i] then
			LineSet[i] = LineArray:CreateLine("GyreLine_A", "ARTWORK")
		end
		--LineSet[i]:SetColorTexture(random(255)/255, random(255)/255, random(255)/255)
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
		loco.lsSpinRate = mod(loco.lsSpinRate, 360)
		loco.lsOFFset = loco.lsOFFset + loco.lsSpinRate
		loco.lsOFFset = mod(loco.lsOFFset, 360)
		--if loco.lsOFFset > 360 then
			--loco.lsOFFset = loco.lsOFFset - 360
		--elseif loco.lsOFFset < -360 then
			--loco.lsOFFset = loco.lsOFFset + 360
		--end
		rotmeth = loco.lsOFFset
	end
	if loco.lsSpinOver then
		if loco.lsLastUpdate - loco.overTime > 1.23 then
			loco.lsSpinOver = nil
		else
			rotmeth = rotmeth + loco.lsSpinOver
		end
	end
	if loco.idx == 1 then
		if loco.anim ~= loco.currentAnim and sandy:HasAnimation(loco.anim) then
			sandy:SetAnimation(loco.anim)
			loco.currentAnim = loco.anim
		end
	end
	if loco.lsShown then
		local rdA,rdB,angA,angB
		local ox,oy = 0,0
		local r,g,b
		local locNins = loco.liNes
		if loco.orbit then
			loco.orbrad = loco.orbrad or 3
			loco.orbinc = loco.orbinc or 15
			loco.orbit = loco.orbit + loco.orbinc
			loco.orbit = mod(loco.orbit,360)
			ox = sin(rad(loco.orbit)) * loco.orbrad
			oy = cos(rad(loco.orbit)) * loco.orbrad
		end
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
			
			if loco.lsConnect then
				if i > 1 and i < loco.cants then
					loco.liNes[i].rdA = loco.liNes[i-1].rdB
					loco.liNes[i].angA = loco.liNes[i-1].angB
					loco.liNes[i].rdB = loco.lsRad + loco.lsRadInc * i
					loco.liNes[i].angB = (i + 1) * loco.degInc
				elseif i == loco.cants then
					loco.liNes[i].rdA = loco.liNes[i-1].rdB
					loco.liNes[i].angA = loco.liNes[i-1].angB
					loco.liNes[i].rdB = loco.liNes[1].rdA
					loco.liNes[i].angB = loco.liNes[1].angA
				else
					loco.liNes[i].rdA = loco.lsRad + loco.lsRadInc * i
					loco.liNes[i].angA = (i + 1) * loco.degInc
					loco.liNes[i].rdB = loco.lsRad + loco.lsRadInc * (i+1)
					loco.liNes[i].angB = (i + 2) * loco.degInc
				end
			end

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
						loco.liNes[i].y1 = oy + sin(loco.liNes[i].angA) * loco.liNes[i].rdA * pls * loco.lsRadAdjY + loco.drY.y
						loco.liNes[i].y2 = oy + sin(loco.liNes[i].angB) * loco.liNes[i].rdB * pls * loco.dippY * loco.lsRadAdjY + loco.drY.y
				else
					if grimoire[loco.spell].funcY then
						loco.liNes[i].y1 = oy + grimoire[loco.spell].funcY(loco.liNes[i].angA, loco.liNes[i].rdA, rotmeth, i) * pls * loco.lsRadAdjY + loco.drY.y
						loco.liNes[i].y2 = oy + grimoire[loco.spell].funcY(loco.liNes[i].angB, loco.liNes[i].rdB, rotmeth, i) * pls * loco.dippY * loco.lsRadAdjY + loco.drY.y
					else
						loco.liNes[i].y1 = oy + sin(rad(loco.liNes[i].angA)) * loco.liNes[i].rdA * pls * loco.lsRadAdjY + loco.drY.y
						loco.liNes[i].y2 = oy + sin(rad(loco.liNes[i].angB)) * loco.liNes[i].rdB * pls * loco.dippY * loco.lsRadAdjY + loco.drY.y
					end
				end
			else
				if loco.rube and 700 then
					loco.liNes[i].y1 = oy + sin(loco.liNes[i].angA) * loco.liNes[i].rdA * pls * loco.lsRadAdjY
					loco.liNes[i].y2 = oy + sin(loco.liNes[i].angB) * loco.liNes[i].rdB * pls * loco.dippY * loco.lsRadAdjY
				else
					if grimoire[loco.spell].funcY then
						loco.liNes[i].y1 = oy + grimoire[loco.spell].funcY(loco.liNes[i].angA, loco.liNes[i].rdA, rotmeth, i) * pls * loco.lsRadAdjY
						loco.liNes[i].y2 = oy + grimoire[loco.spell].funcY(loco.liNes[i].angB, loco.liNes[i].rdB, rotmeth, i) * pls * loco.dippY * loco.lsRadAdjY
					else
						loco.liNes[i].y1 = oy + sin(rad(loco.liNes[i].angA)) * loco.liNes[i].rdA * pls * loco.lsRadAdjY
						loco.liNes[i].y2 = oy + sin(rad(loco.liNes[i].angB)) * loco.liNes[i].rdB * pls * loco.dippY * loco.lsRadAdjY
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
					loco.liNes[i].x1 = ox + cos(loco.liNes[i].angA) * loco.liNes[i].rdA * pls * loco.lsRadAdjX + loco.drX.x
					loco.liNes[i].x2 = ox + cos(loco.liNes[i].angB) * loco.liNes[i].rdB * pls * loco.dippX * loco.lsRadAdjX + loco.drX.x
				else
					if grimoire[loco.spell].funcX then
						loco.liNes[i].x1 = grimoire[loco.spell].funcX(loco.liNes[i].angA, loco.liNes[i].rdA, rotmeth, i) * pls * loco.lsRadAdjX + loco.drX.x
						loco.liNes[i].x2 = grimoire[loco.spell].funcX(loco.liNes[i].angB, loco.liNes[i].rdB, rotmeth, i) * pls * loco.dippX * loco.lsRadAdjX + loco.drX.x
					else
						loco.liNes[i].x1 = ox + cos(rad(loco.liNes[i].angA)) * loco.liNes[i].rdA * pls * loco.lsRadAdjX + loco.drX.x
						loco.liNes[i].x2 = ox + cos(rad(loco.liNes[i].angB)) * loco.liNes[i].rdB * pls * loco.dippX * loco.lsRadAdjX + loco.drX.x
					end
				end
			else
				if loco.rube and 007 then
					loco.liNes[i].x1 = ox + cos(loco.liNes[i].angA) * loco.liNes[i].rdA * pls * loco.lsRadAdjX
					loco.liNes[i].x2 = ox + cos(loco.liNes[i].angB) * loco.liNes[i].rdB * pls * loco.dippX * loco.lsRadAdjX
				else
					if grimoire[loco.spell].funcX then
						loco.liNes[i].x1 = ox + grimoire[loco.spell].funcX(loco.liNes[i].angA, loco.liNes[i].rdA, rotmeth, i) * pls * loco.lsRadAdjX
						loco.liNes[i].x2 = ox + grimoire[loco.spell].funcX(loco.liNes[i].angB, loco.liNes[i].rdB, rotmeth, i) * pls * loco.dippX * loco.lsRadAdjX
					else
						loco.liNes[i].x1 = ox + cos(rad(loco.liNes[i].angA)) * loco.liNes[i].rdA * pls * loco.lsRadAdjX
						loco.liNes[i].x2 = ox + cos(rad(loco.liNes[i].angB)) * loco.liNes[i].rdB * pls * loco.dippX * loco.lsRadAdjX
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

local function UpdateTrack()
	loco.isTracking = nil
	local hasWay = {}
	if WaypointUIAPI then
		hasWay = WaypointUIAPI.Navigation.GetUserNavigation()
	end
	if hasWay.name and not loco.pinOvr and not loco.suwLock then
		SetUserWaypoint()
		return
	end
	if L_DBG >= 5 or L_DBF["UpdateTrack"] then
		Ramble(colorMe("   ~Update Track~", "Tomato"), colorMe("[UpdateTrack] ", "Green"))
	end
	local crTrk
	if loco.wsCnt and loco.wsCnt > 0 then
		crTrk = loco.wayStack[loco.wsCnt]
		if not crTrk then
			if L_DBG >= 8 or L_DBF["UpdateTrack"] then
				Ramble(colorMe("~wayStack Fail~", "Tomato"), colorMe("[UpdateTrack] ", "Green"))
			end
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
				if L_DBG >= 6 or L_DBF["Quest"] then
					Ramble(colorMe(" Tracking: ", "BrightMint")..loco.questLink, colorMe("[Quest]", "Green"))
					--Ramble(loco.questLink, "|cff00ff00[Quest]|r|cffffffff Tracking: |r")
				end
			end
		end

		local map = C_Map.GetBestMapForUnit("player")
		if L_DBG >= 6 or L_DBF["Quest"] then
			Ramble(tostring(stqID), colorMe("[Quest]", "Green")..colorMe(" STQ: ", "BrightMint"))
			Ramble(tostring(map), colorMe("[Quest]", "Green")..colorMe(" Map: ", "Buff"))
		end
		loco.objid = C_QuestLog.GetLogIndexForQuestID(stqID)
		Lunacy.GTQshown = nil
		UpdateTrackerText()
		--UpdateTrack()
		loco.isTracking = true
		ToggleTracking("start")
	elseif not crTrk then
		if L_DBG >= 5 or L_DBF["Quest"] then
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
	
	if compMode[loco.idx+1] == "gathering" and loco.gather and loco.weed then
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
					if L_DBG >= 4 or L_DBF["UpdateTrack"] then
						Ramble(colorMe("~Gather Track Not Found~", "Red"), colorMe("[UpdateTrack] ", "Green"))
					end
					loco.isTracking = nil
					loco.trStatus = nil
					UpdateTrackerText()
				else
					if L_DBG >= 4 or L_DBF["UpdateTrack"] then
						Ramble(colorMe("~Circle Back~", "LemonChiffon"), colorMe("[UpdateTrack] ", "Green"))
					end
					loco.isTracking = true
					Lunacy.Text1 = loco.objTxt
					loco.destCheck = true
				end
			else
				if L_DBG >= 3 or L_DBF["UpdateTrack"] then
					Ramble(colorMe("~Well Shit!~", "Brown"), colorMe("[UpdateTrack] ", "Green"))
				end
			end
		else
			loco.isTracking = true
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
		if L_DBG >= 5 or L_DBF["UpdateTrack"] then
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
		loco.isTracking = nil
		loco.stqID = nil
		Lunacy.Text5 = loco.optDesc or ""
		UpdateTrackerText()
		--"gyre", "odometer", "compass"
	elseif compMode[loco.idx+1] == "gyre" or compMode[loco.idx+1] == "odometer" or compMode[loco.idx+1] == "compass" then
		if L_DBG >= 5 or L_DBF["UpdateTrack"] then
			Ramble(colorMe(compMode[loco.idx+1], "Trombone"), colorMe("[Quest] ", "Green")..colorMe("compMode: ", "CarolinaBlue"))
		end
		if loco.trackChange then
			loco.trMap, loco.trX, loco.trY, loco.objTxt, loco.stqID, loco.trPntMap, complete, curObj = Lunacy_GetTrackedQuest()
			if loco.stqID and blkQst[loco.stqID] then
				if L_DBG >= 4 or L_DBF["UpdateTrack"] then
					Ramble(tostring(loco.stqID), colorMe("[Quest]", "Green")..colorMe(" Blocked Quest: ", "BrightMint"))
				end
				loco.isTracking = nil
				loco.stqID = nil
				loco.trX = nil
				wayDesc = nil
				curObj = nil
				loco.objTxt = nil
			end
			loco.trackChange = nil
			if L_DBG >= 6 or L_DBF["UpdateTrack"] then
				Ramble(tostring(wayDesc), colorMe("[Quest]", "Green")..colorMe(" WD: ", "BrightMint"))
			end
			if wayDesc and loco.trX then
				--Ramble(tostring(wayDesc), colorMe("[Quest]", "Green")..colorMe(" WD: ", "BrightMint"))
				--print("WD: wayDesc")
				curObj = wayDesc
			end
		end
		if L_DBG >= 6 or L_DBF["UpdateTrack"] then
			Ramble(colorMe(tostring(loco.stqID), "Saffron"), colorMe("[Quest] ", "Green")..colorMe("stqID: ", "CarolinaBlue"))
			Ramble(colorMe(tostring(loco.urWay), "Shrek"), colorMe("[Quest] ", "Green")..colorMe("urWay: ", "CarolinaBlue"))
		end
		if not loco.stqID and not loco.urWay then
			Lunacy.Text1 = colorMe(stigma[loco.btns] or "/.^.\\", shadow[loco.btns] or "Vixen")
			Lunacy.Text2 = "|cff11cc11\\o/|r"
			Lunacy.Text3 = ""
			Lunacy.Text5 = ""
			loco.trStatus = nil
			loco.isTracking = nil
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
			if L_DBG >= 8 or L_DBF["UpdateTrack"] then
				Ramble(colorMe("~quest location unknown~", "FluorescentYellow"), colorMe("[Quest]", "Green"))
			end
			dbgLatch = nil
			loco.trStatus = nil
			loco.isTracking = nil
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
	elseif compMode[loco.idx+1] == "exploration" and loco.pMap then
		loco.trMap, loco.trX, loco.trY, loco.objTxt = Lunacy_GetNextExplore(loco.pX, loco.pY, loco.pMap)
	elseif compMode[loco.idx+1] == "elders" then
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
			if L_DBG >= 6 or L_DBF["UpdateTrack"] then
				Ramble(colorMe("~tracker idle~", "FluorescentYellow"), colorMe("[Quest]", "Green"))
			end
			--print("tracker type not set")
			dbgLatch = nil
		end
	end
	Lunacy.Text5 = colorMe(Lunacy.Text5, "Turquoise")
end

local ClickRouter = {
	["L"] = {
		["LeftButton"] = {
			["Down"] = function()
				loco.idx = loco.idx + 1
				loco.idx = mod(loco.idx,3)
				frame_update()
				loco.destCheck = nil
				EarThis(sounds[loco.idx+1])
				loco.hasTrack = ""
				loco.compMode = compMode[loco.idx+1]
				loco.lock = false
				if loco.idx == 1 then
					if loco.trOll then
						TrollMe(loco.trOll)
					end
				end
				if L_DBG >= 1 then
					Ramble(colorMe(caPit(compMode[loco.idx+1]).." Mode", "NeonYellow"), colorMe("[Compass]", compClr[loco.idx+1]))
				end
				ToggleTracking("start")
				UpdateTrack()
			end,
			["Up"] = function()

			end,
		},
	},
}

local hardAct = {
	["DEX"] = {"<(o)o)<","(zOOm)","(yaw)","(pitch)","(rot)","(camz)","(tarx)","(tary)","(tarz)"},
	["<(o)o)<"] = function(amt)
		loco.digroot = mod(loco.digroot + amt, 9)
		--if loco.digroot < 1 then
			--loco.digroot = 9 + loco.digroot
		--end
	end,
	["(yaw)"] = function(amt)
		loco.yaw = loco.yaw + 0.05 * amt
	end,
	["(pitch)"] = function(amt)
		loco.pitch = loco.pitch + 0.05 * amt
	end,
	["(rot)"] = function(amt)
		loco.sandyRot = loco.sandyRot + amt * 5
	end,
	["(zOOm)"] = function(amt)
		loco.yoff = loco.yoff + 0.1 * amt
	end,
	["(camz)"] = function(amt)
		loco.zoff = loco.zoff + 0.05 * amt
	end,
	["(tarx)"] = function(amt)
		loco.camtarX = loco.camtarX + 0.05 * amt
	end,
	["(tary)"] = function(amt)
		loco.camtarY = loco.camtarY + 0.05 * amt
	end,
	["(tarz)"] = function(amt)
		loco.camtarZ = loco.camtarZ + 0.05 * amt
	end,
}

local function ShadowDance()
	local anul = "LUNA"
	local r,g,b,a
	local shad
	
	for i=1,4 do
		shad = anul:sub(i,i)
		if string.find(loco.btns,shad) then
			a = 1.0
			if shadow[loco.btns] then
				r,g,b = hex2rgb(GetHexColor(shadow[loco.btns]))
			else
				r,g,b = hex2rgb(GetHexColor("CandyApple"))
			end
		else
			r,g,b,a = 70,130,80,0.37
		end
		if not loco.puppet and loco.btns == "LAUN" then
			Btn[shad].texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\Hrt"..shad)
		elseif loco.puppet and loco.btns ~= "LAUN" then
			Btn[shad].texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\Btn"..shad)
		end
		Btn[shad].texture:SetVertexColor(r/255, g/255, b/255, a)
	end
	if loco.btns == "LAUN" then -- Puppeteer
		loco.puppet = true
	elseif loco.btns ~= "LAUN" then -- Puppeteer
		loco.puppet = nil
	end
end

local function sandyDance()
	if not sandy:HasCustomCamera() then
		sandy:SetCustomCamera(1)
	end
	sandy:SetRotation(rad(loco.sandyRot),true)
	if sandy:HasCustomCamera() then
		sandy:SetCameraTarget(loco.camtarX, loco.camtarY, loco.camtarZ) -- point to point camera at; 0,0,1 = midsection of troll, 0,0,0 = troll's feet
		sandy:SetCameraPosition(loco.xoff, loco.yoff, loco.zoff)
		sandy:SetPitch(loco.pitch)
		sandy:SetRoll(loco.yaw)
		sandy:SetAnimation(loco.dance or 0)
	end
end

local function Puppeteer(butt)
	local head = {}
	local case
	head.A = -1
	head.U = 1
	head.L = -1
	head.N = 1
	if butt == "A" or butt == "U" then
		loco.noDex = loco.noDex or 1
		loco.noDex = mod(loco.noDex + head[butt],9)
		if loco.noDex < 1 then  --<(o)o)<
			loco.noDex = 9 + loco.noDex
		end
		stigma.LAUN = hardAct.DEX[loco.noDex]
		--ClearTrack()
		PlaySoundFile(4854693)
		UpdateTrack()
		UpdateTrackerText()
	else
		case = hardAct.DEX[loco.noDex]
		if hardAct[case] then
			hardAct[case](head[butt])
		end
		if loco.noDex == 1 then
			local call = loco.trollUp or loco.trollcall
			loco.trollcall = nil
			TrollMe(call)
		else
			--hardAct[case](head[butt])
			sandyDance()
		end
	end
end
-- Click Handling
function LunacyFrameB.MouseUp(self,button)
	local btns = loco.btns
	loco.touchingMe = nil
	loco.pokes = loco.pokes or 0
	loco.pokes = loco.pokes + 1
	LunacyMainFrame:StopMovingOrSizing()
	if button == "RightButton" and IsLeftShiftKeyDown() then
		C_UI.Reload()
		return
	end

	if loco.coLor and loco.cants then
		loco.flashTime = GetTimePreciseSec() - 0.66
	end
	if ClickRouter[btns] and ClickRouter[btns][button] and ClickRouter[btns][button].Up then
		ClickRouter[btns][button]:Up()
		return
	end
	
	local r,g,b
	if button == "XXXLeftButton" and not IsControlKeyDown() then
		--LunacyMainFrame:StopMovingOrSizing()
		local tt = GetTimePreciseSec()
		if tt - ddC < 0.25 then
			if LunacyFrameC:IsShown() then
				LunacyFrameC:Hide()
				loco.bubble = nil
			else
				loco.bubble = true
				if not loco.hidebubble then
					LunacyFrameC:Show()
				end
			end
			--Catch Double Click
		end
		--loco.sandyRot = loco.sandyRot or 0
		--loco.sandyRot = loco.sandyRot + 5
		--sandy:SetRotation(rad(loco.sandyRot),true)
			
		if not loco.nospin then
			loco.gizmo = (loco.gizmo or 0) + 1
			if loco.gizmo == 1 then
				print("pitch")
			elseif loco.gizmo == 2 then
				print("yaw")
			elseif loco.gizmo == 3 then
				print("rot")
			else
				print("static")
			end
			if loco.gizmo > 3 then
				
				loco.gizmo = nil
			end
		end
		
		local rnd = 6 + random(369)
		if loco.pokes >= rnd then
			rnd = loco.pokes / 69
			local x,train
			if loco.trOll and trOlls[loco.trOll] and trOlls[trOlls[loco.trOll]] and trOlls[trOlls[loco.trOll]].snarks then
				train = trOlls[trOlls[loco.trOll]].snarks
			elseif loco.spell and grimoire[loco.spell] and grimoire[loco.spell].snarks then
				train = grimoire[loco.spell].snarks
				--local x = floor(#grimoire[loco.spell].snarks * rnd) + 1
			end
			if loco.spell and grimoire[loco.spell] and grimoire[loco.spell].snarks then
				--local x = floor(#grimoire[loco.spell].snarks * rnd) + 1
				x = floor(#train * rnd) + 1
				if x > #train then
					x = #train
				end
				--print(x)
				local pick = select(x,unpack(train))
				--print(pick)
				if pick then
					EarThis(pick)
				end
			end
			loco.pokes = 0
		end
		if loco.clrLock ~= true then
			loco.coLor,loco.tAg, loco.clrGROup, loco.clRDex = GetNextColor()
			--local clr,tag = GetNextColor()
			if L_DBG >= 2 then
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
			loco.flashTime = GetTimePreciseSec() - 0.66
		end
		r,g,b = hex2rgb(GetHexColor(loco.coLor))
		CompArrow.texture:SetVertexColor(r/255, g/255, b/255, 1)
		ddC = tt
	--elseif button == "RightButton" and IsLeftShiftKeyDown() then
		--C_UI.Reload()
	end
end

function LunacyFrameB.MouseDown(self,button)
	local btns = loco.btns
	--if btns == "" then
		--btns = "NULL"
	--end
	if button == "RightButton" and IsLeftShiftKeyDown() then
		return
	end
	if ClickRouter[btns] and ClickRouter[btns][button] and ClickRouter[btns][button].Down then
		ClickRouter[btns][button]:Down()
		return
	end
	loco.touchingMe = loco.touchingMe or GetTimePreciseSec()
	if button == "LeftButton" and IsLeftShiftKeyDown() then
		
	elseif button == "XXXLeftButton" and IsControlKeyDown() then
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
	end
	if button == "LeftButton" then
		if loco.coLor and loco.cants then
			LunacyGyre.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\LunacyE")
			r,g,b = hex2rgb(GetHexColor(loco.coLor))
			LunacyGyre.texture:SetVertexColor(r/255, g/255, b/255)
			LunacyGyre:Show()
		end
		LunacyMainFrame:StartMoving()
	elseif button == "RightButton" and not IsLeftShiftKeyDown() then
		if loco.wsCnt and loco.wsCnt > 0 then --and not C_SuperTrack.GetSuperTrackedQuestID() then
			ClearTrack()
		else
			ClearTrack()
			PlaySoundFile("Interface\\Addons\\Lunacy\\Media\\Ping.mp3")
			if L_DBG >= 2 then
				Ramble(colorMe(tostring(loco.lucky), "NeonYellow"),colorMe("[~lucky~] ", "Shamrock"))
				Ramble(colorMe(tostring(loco.diSTurbed), "NeonYellow"),colorMe("[~diSTurbed~] ", "Violet"))
			end
			UpdateTrack()
		end
		if L_DBG >= 7 then
			local st = colorMe("♠", "Black")..colorMe("♥", "Red")..colorMe("♣", "Black")..colorMe("♦", "Red")
			if loco.lucky/(loco.diSTurbed or 6.9) >= 7 then
				Ramble(st..colorMe(" Magically ", loco.lineClr or "Mulberry")..colorMe(" →", "White")..colorMe(floor(loco.lucky), "Shamrock")..colorMe("← ", "White")..colorMe("Delicious! ", "White")..st)
			else
				Ramble(st..colorMe(" Fuck ", "Scarlet")..colorMe(" →", "Chartreuse")..colorMe(floor(loco.diSTurbed), "Indigo")..colorMe("← ", "Chartreuse")..colorMe("ÎYouÎ ", "Scarlet")..st)
			end
		end
		initLineSet(loco.spell)
	end
end

local function BtnItUp(self,button)
	if Btn.pTime == 0 then
		ShadowDance()
		return
	end
	if loco.btns == "LAUN" and button == "LeftButton" then
		Btn.pTime = 0
		Btn.last = ""
		Puppeteer(self.btn)
		ShadowDance()
		return
	end
	local butt = stigma[loco.btns]
	if button == "LeftButton" and not IsControlKeyDown() then
		if (GetTimePreciseSec() - Btn.pTime > 3.5) then
			Btn.pTime = 0
			Btn.last = ""
			ShadowDance()
			return
		end
		if loco.btns and string.find(loco.btns, self.btn) then
			loco.btns = string.gsub(loco.btns,self.btn,"")
			UpdateTrackerText()
		elseif loco.btns and not string.find(loco.btns, self.btn) and (GetTimePreciseSec() - Btn.pTime > 1.5) then
			loco.btns = loco.btns..self.btn
		end
		ShadowDance()
	elseif button == "RightButton" then
		if (GetTimePreciseSec() - Btn.pTime > 3.5) then
			Btn.pTime = 0
			Btn.last = ""
			return
		end
		loco.btns = ""
		UpdateTrackerText()
		ShadowDance()
	end
	if butt ~= stigma[loco.btns] then
		ClearTrack()
	end
	Btn.pTime = 0
	Btn.last = ""
end

local function BrnItDown(self,button)
	local r,g,b
	if button then
		Btn.pTime = GetTimePreciseSec()
		r,g,b = hex2rgb(GetHexColor(loco.coLor))
		Btn[self.btn].texture:SetVertexColor(r/255, g/255, b/255, 1.0)
		Btn.last = self.btn
	end
end

sandy:SetScript("OnShow", function(self)
	if loco.trOll then
		TrollMe(loco.trOll)
	end
end)

local function scuffleTime()
	if scuffle then
		local actor, activity
		--if Details then
			--actor = Details:GetActor("current", DETAILS_ATTRIBUTE_DAMAGE, Details.playername)
			--if actor then
				--activity = actor:Tempo()
				--print(actor.total)
			--end
		--end
		if loco.spell == "Scarlet" then
			LunacyGyre.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\LunacyE")
			local r,g,b
			if loco.candyapple then
				r,g,b = hex2rgb(GetHexColor("Tomato"))
				loco.candyapple = nil
				--print("FlashMe: Scarlet")
				
			else -- ~flip~flop~
				r,g,b = hex2rgb(GetHexColor("Black"))
				loco.candyapple = "CandyApple"
			end
			LunacyFrameB.texture:SetVertexColor(r/255, g/255, b/255)
			FlashMe("Scarlet")
		else
			if not loco.candyapple or loco.candyapple ~= "Scarlet" then
				r,g,b = hex2rgb(GetHexColor("CandyApple"))
				LunacyGyre.texture:SetVertexColor(r/255, g/255, b/255)
				loco.candyapple = "Scarlet"
				if (L_DBG >= 2 or L_DBF["FlashMe"]) then
					Ramble(colorMe("Scarlet", "Scarlet"), colorMe("[FlashMe] ","Vixen"))
					Ramble(colorMe("sticky: ", "CandyApple")..tostring(loco.sticky),colorMe("[FlashMe] ", "Vixen"))
				end
				--r,g,b = hex2rgb(GetHexColor("Black"))
				LunacyFrameB.texture:SetVertexColor(r/522, g/522, b/522)
			end
			--Ramble(colorMe("Scarlet", "Vixen"), colorMe("[FlashMe] ","CandyApple"))
			FlashMe("Scarlet")
		end
		
		loco.scuffle = true
	elseif loco.scuffle then
		loco.candyapple = nil
		FlashMe("default") -- boom
		if (L_DBG >= 2 or L_DBF["FlashMe"]) then
			--Ramble(colorMe("Scarlet", "Scarlet"), colorMe("[FlashMe] ","Vixen"))
			Ramble(colorMe("sticky: ", "Silver")..tostring(loco.sticky),colorMe("[FlashMe] ", "Vixen"))
		end
		r,g,b = hex2rgb(GetHexColor(loco.ring))
		LunacyFrameB.texture:SetVertexColor(r/255, g/255, b/255)
		loco.scuffle = nil
	end
end

local function touching(updTime)
	if loco.touchingMe and (updTime - loco.touchingMe > 7) then
		loco.touchingMe = loco.touchingMe + 3 + random() * 11
		if loco.trOll and trOlls[loco.trOll] and trOlls[trOlls[loco.trOll]] then
			local troll = trOlls[trOlls[loco.trOll]]
			local rnd = random(#troll.snarks+7)
			local pick = select(rnd,unpack(troll.snarks))
			if L_DBG >= 4 or L_DBF["TouchingMe"] and pick then
				Ramble(colorMe(trOlls[loco.trOll].." ", troll.clr or "Wood").. colorMe(troll.desc, "Alabaster").." :: "..colorMe(tostring(pick), "Shamrock"), colorMe("[TouchingMe] ", "CandyApple"))
			end
			if pick then
				EarThis(pick)
			else
				EarThis(550736)
			end
		end
		--EarThis(568873)
	end
end

local function spindecay()
	loco.lsSpinRate = loco.lsSpinRate * 0.999699
	--loco.active = loco.active * 0.999991
	if abs(loco.lsSpinRate) < 0.7 then
		loco.lsSpinRate = loco.lsSpinRate * (1 + random() * 0.07)
	end
	loco.sticky = loco.sticky * 0.99999339
	loco.lucky = loco.lucky * 0.99997
	loco.diSTurbed = loco.diSTurbed * 1.000013
	if loco.lucky > 7777 then
		loco.lucky = loco.lucky - loco.diSTurbed
	end
	if loco.diSTurbed > 666 then
		loco.diSTurbed = loco.diSTurbed - loco.lucky * 0.007
	end
end

local function chat_stack() -- ChatStack Chicken
	local stock = GetTimePreciseSec()
	local stack = #chatStack
	local stick = 1
	local chic,ken,leg
		
	repeat
		if chatStack[stick] and chatStack[stick].choo then
			if stock-chatStack[stick].choo > 0.777 then
				chic = chatStack[stick].chat
				ken = chatStack[stick].chan
				leg = stick
				SendChatMessage(chic, ken)
				stick = stack
			end
		end
		stick = stick + 1
	until stick > stack
	if leg then
		chatStack[leg].chat = nil
		chatStack[leg].chan = nil
		chatStack[leg].choo = nil
		chatStack[leg] = {}
		chatStack[leg] = nil
	end
	if #chatStack > 0 and leg then
		--print(leg)
	elseif #chatStack == 0 and leg then
		chatStack = {}
	end
end

local function aura_check()
	if scuffle then
		return
	end
	local aura
	for i=1,40 do
		aura = C_UnitAuras.GetAuraDataByIndex("player", i)
		if aura then
			if aura.name then
				if string.find(aura.name, "Well Fed") or string.find(aura.name, "Relaxed") then
					loco.wellfed = true
					loco.sticky = loco.sticky + 0.00169
				else
					loco.wellfed = nil
				end
					--print("Well Fed")
				--elseif string.find(aura.name, "Tipsy") then
					--print("Tipsy")
				if string.find(aura.name, "Bloated") then
					--print("Bloated")
				
				end
			end
		end
	end
end

--100 and 001

local function troll_roll()
	if not loco.gizmo then
		return
	end
	loco.pitch = loco.pitch or 0
	loco.yaw = loco.yaw or 0
	local bits = loco.gizmo
	local bobs = mod(bits,2)
	if bobs == 1 then --1
		loco.pitch = loco.pitch + 0.025
	end
	bits = floor(bits/2)
	bobs = mod(bits,2)
	if bobs == 1 then --2
		loco.yaw = loco.yaw + 0.025
	end
	bits = floor(bits/2)
	bobs = mod(bits,2)
	if bobs == 1 then -- 4
		loco.sandyRot = loco.sandyRot + loco.rotinc
		if loco.sandyRot > 360 then
			loco.sandyRot = loco.sandyRot - 360
		elseif loco.sandyRot < -360 then
			loco.sandyRot = loco.sandyRot + 360
		end
	end
	bits = floor(bits/2)
	bobs = mod(bits,2)
	if bobs == 1 then -- 8
		loco.camyoff = loco.camyoff + loco.campulse
		if loco.camyoff > loco.camMax or loco.camyoff < loco.camMin then
			loco.campulse = loco.campulse * -1
		end
		loco.yoff = loco.camyoff
		if sandy:HasCustomCamera() then
			sandy:SetCameraPosition(loco.xoff, loco.yoff, loco.zoff)
		else
			sandy:SetCustomCamera(1)
		end
	end
	--elseif loco.gizmo == 4 then
		--loco.yaw = loco.yaw + 0.01
		--loco.pitch = loco.pitch + 0.01
	--end
	
	sandy:SetPitch(loco.pitch)
	sandy:SetRoll(loco.yaw)
	sandy:SetRotation(rad(loco.sandyRot),true)
end

local function Lunacy_Track(updTime)
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
	if loco.spell == "Obsidian" then
		loco.haunted = loco.haunted - 0.000639
		if loco.haunted < 0.000639 then
			loco.haunted = 0.000639
		end
	end
	if random(13777) < 11 then
		FlashMe("Vixen")
	end
	loco.actOut = loco.actOut or updTime
	if math.abs(updTime - loco.actOut) > 1.69 then
		loco.active = loco.active - 0.0169
		if loco.active < 1 then
			loco.active = 1
			if loco.lineAlpha > 0.177 then -- set min alpha
				loco.lineAlpha = loco.lineAlpha - 0.069
			end
		--elseif loco.active > 3.14 and loco.lineAlpha < 
		elseif loco.idx == 0 then
			if loco.active > 3.14 and loco.lineAlpha < 1.0 then
				loco.lineAlpha = loco.lineAlpha + 0.069
				loco.lineAlpha = math.min(loco.lineAlpha, 1.0)
				loco.active = loco.active - 0.69
			end
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
			loco.angle = loco.angle + rad(180)
			loco.aMeth = "oranges"
		else
			loco.angle = HBD:GetWorldVector(loco.pPntMap, loco.pWX, loco.pWY, loco.trWX, loco.trWY)
			--loco.angle = HBD:GetWorldVector(loco.pMap, loco.pX, loco.pY, loco.trX, loco.trY)
			--loco.angle = GetAngle(loco.pMap, loco.pX, loco.pY, loco.trX, loco.trY)
			loco.angle = loco.angle or 0
			loco.angle = loco.angle + rad(180)
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
				if compMode[loco.idx] == "elders" then
					Lunacy[playerKey].elders[loco.elderCont] = Lunacy[playerKey].elders[loco.elderCont] or {}
					Lunacy[playerKey].elders[loco.elderCont][loco.elder] = true
				end
				Lunacy.Text1 = colorMe(stigma[loco.btns] or "/.^.\\", shadow[loco.btns] or "Vixen")
				Lunacy.Text2 = "|cff11cc11\\o/|r"
				UpdateTrackerText()
				ClearTrack()
				--UpdateCompass()
			end
		end
		--UpdateTrackerText()
	else
		loco.angle = rad(180)
		loco.pF = 0
		
		if dbgLatch or loco.dbgLatch then
			print("Nothing is being tracked...")
			dbgLatch = nil
			loco.dbgLatch = nil
		end
	end
	if loco.dbgLatch then
		print("angle: "..tostring(loco.angle))
		loco.dbgLatch = nil
	end
	--if loco.idx == 1 then
		--loco.angle = 4.52
	--else
		loco.angle = loco.angle - loco.pF
		loco.angle = loco.angle - rad(45)
	--end
	luCky_seVen()
	--loco.angle = 4.52	
	UpdateTrackerText()
	local s,c = sin(loco.angle) * math.sqrt(0.5), cos(loco.angle) * math.sqrt(0.5)
	if loco.idx == 2 then
		CompArrow.texture:SetTexCoord(0.5-s,0.5+c,0.5+c,0.5+s,0.5-c,0.5-s,0.5+s,0.5-c)
	end
	Reticule.texture:SetTexCoord(0.5-s,0.5+c,0.5+c,0.5+s,0.5-c,0.5-s,0.5+s,0.5-c)
end

local function LunacyUpdateController()
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
	
	if loco.updCnt / 61 == floor(loco.updCnt / 61) then
		if not scuffle then
			aura_check()
		end
	elseif loco.updCnt / 13 == floor(loco.updCnt / 13) then
		touching(updTime)
	elseif loco.updCnt / 11 == floor(loco.updCnt / 11) then
		if Btn.last ~= "" and Btn.pTime > 0 and updTime - Btn.pTime > 1.5 then
			local r,g,b = hex2rgb(GetHexColor("Vixen"))
			--loco.btns = loco.btns..Btn.last
			Btn[Btn.last].texture:SetVertexColor(r/255, g/255, b/255, 1.0)
			--Btn.pTime = 0
			--Btn.last = ""
		end
		--chat_stack()
	elseif loco.updCnt / 7 == floor(loco.updCnt / 7) then
		scuffleTime()
	elseif loco.updCnt / 9 == floor(loco.updCnt / 9) then
		spindecay()
	elseif loco.updCnt / 3 == floor(loco.updCnt / 3) then
		chat_stack()
		if loco.gizmo and not loco.nospin then
			troll_roll()
		end
	elseif loco.updCnt / 5 == floor(loco.updCnt / 5) then
		if loco.trollpoll and loco.trollpoll == loco.trOll then
			loco.trollpoll = nil
			TrollMe(loco.trOll)
		end
	end
	if loco.pMap then
		--if loco.isTracking then
		Lunacy_Track(updTime)
		--end
		lineset_update()
		DistanceRecorder()
	end
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
	if (Lunacy.Timer > .01177) then
		if Lunacy.playerStatus ~= "loaded" then
			return
		end
		Lunacy.Timer = 0
		LunacyUpdateController()
	end
end

local function InitFrames()
	LunacyMainFrame:Init()
	LunacyGyre:Init()
	LunacyFrameX:Init()
	LunacyFrameA:Init()
	Lunadometer:Init()
	LunacyFrameB:Init()
	LunacyFrameB:SetScript("OnMouseUp", LunacyFrameB.MouseUp)
	LunacyFrameB:SetScript("OnMouseDown", LunacyFrameB.MouseDown)
	sandy:init()
	LunacyFrameC:Init()
	CompArrow:Init()
	Reticule:Init()
	LineArray:Init()
	Distance:Init()
	Speed:Init()
	Objective:Init()
	ObjectiveB:Init()
	ObjectiveC:Init()
	BtnInit("L")
	BtnInit("U")
	BtnInit("N")
	BtnInit("A")
	Btn.pTime = 0
	Btn.last = ""
	Btn.L:SetScript("OnMouseUp", BtnItUp)
	Btn.L:SetScript("OnMouseDown", BrnItDown)
	Btn.U:SetScript("OnMouseUp", BtnItUp)
	Btn.U:SetScript("OnMouseDown", BrnItDown)
	Btn.N:SetScript("OnMouseUp", BtnItUp)
	Btn.N:SetScript("OnMouseDown", BrnItDown)
	Btn.A:SetScript("OnMouseUp", BtnItUp)
	Btn.A:SetScript("OnMouseDown", BrnItDown)
	--Btn.N.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\HrtA")
end

local function LocoLoad()
	if linesUP then
		Ramble(colorMe("~Porting?..", "Celeste"), colorMe("[Event] ", "Purple"))
		loco.porting = GetTimePreciseSec()
	else
		--DistanceRecorder = Lunacy.DistanceRecorder
	end
	loco = {}
	loco.idx = 1
	if Lunacy[playerKey] then
		if Lunacy[playerKey].loco then
			loco = Lunacy[playerKey].loco
		end
	end
	if loco.makebig then
		LunacyMainFrame:SetScale(1.5)
		LunacyFrameX:SetScale(1.125)
	end
	
	--grimoire = Lunacy.grimoire
	--DrawCard = Lunacy.DrawCard
	--trOlls = Lunacy.trOlls
	--wHIspRES = Lunacy.wHIspRES
	GetNextColor = Lunacy.GetNextColor
	TrollMe = Lunacy.TrollMe
	loco.wayStack = loco.wayStack or {}
	loco.wsCnt = loco.wsCnt or 0
	loco.idx = loco.idx or 0
	loco.active = loco.active or 7
	loco.haunted = loco.haunted or 0.00061
	loco.updCnt = 0
	loco.spent = loco.spent or 0
	loco.earned = loco.earned or 0
	loco.balance = loco.balance or 0
	loco.sticky = loco.sticky or 0
	loco.gizmo = 0
	loco.urWay = nil
	loco.suwLock = nil
	loco.digroot = loco.digroot or 0
	loco.flashes = loco.flashes or 0
	loco.trollcall = nil
	loco.btns = loco.btns or ""
	loco.puppet = nil
	
	--BtnInit("L")
	--BtnInit("U")
	--BtnInit("N")
	--BtnInit("A")
	
	C_Map.ClearUserWaypoint()
	
	loco.lsLastUpdate = GetTimePreciseSec()
	Lunacy.loco = loco
	--DistanceRecorder = Lunacy.DistanceRecorder
	
end

LunacyMainFrame:SetScript("OnUpdate", UpdateHandler)

LunacyMainFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
LunacyMainFrame:RegisterEvent("QUEST_WATCH_LIST_CHANGED")
LunacyMainFrame:RegisterEvent("ADDON_LOADED")
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
LunacyMainFrame:RegisterEvent("CHAT_MSG_SKILL")
LunacyMainFrame:RegisterEvent("CHAT_MSG_EMOTE")
LunacyMainFrame:RegisterEvent("CHAT_MSG_SYSTEM")
--LunacyMainFrame:RegisterEvent("COMBAT_LOG_EVENT")

LunacyMainFrame:SetScript("OnEvent", function(self, event, ...)
	local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8 = ...
	if (event == "SUPER_TRACKING_CHANGED") then
		loco.urWay = nil
	end
	local XoX = nil
	--if (event == "SUPER_TRACKING_CHANGED" or event == "QUEST_LOG_UPDATE" or
		--event == "ZONE_CHANGED_NEW_AREA" or event == "QUEST_LOG_CRITERIA_UPDATE" or
		--event == "QUEST_LOG_UPDATE") and compMode[loco.idx] == "quests" then
    if (event == "SUPER_TRACKING_CHANGED" or event == "QUEST_LOG_UPDATE" or
		event == "ZONE_CHANGED_NEW_AREA") and XoX then
		--print(arg1)
		--print(arg2)
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
		UpdateTrack()
		loco.urWay = nil
	elseif event == "QUEST_ACCEPTED" then
		if arg1 then
			local qLink = GetQuestLink(arg1)
			if L_DBG >= 3 or L_DBF["OnEvent"] then
				Ramble(colorMe("[Event] ", "Purple").."Quest Accepted: "..tostring(qLink))
			end
		end
	--Duty
	elseif event == "QUEST_TURNED_IN" then
		if arg3 and arg3 ~= 0 then
			loco.lucky = loco.lucky + arg3 * 0.000171
			loco.diSTurbed = loco.diSTurbed - arg3 * 0.000037
			FlashMe("SafetyYellow") -- Duty
			--mOOdleVel("SafetyYellow")
		end
	elseif event == "CHAT_MSG_EMOTE" then
		if PlayerIsInCombat() then
			if itype ~= "interior" and itype ~= "neighborhood" and itype ~= "scenario" then
				return
			end
		end
		print("CHAT_MSG_EMOTE")
		print(arg1)
	elseif event == "CHAT_MSG_SYSTEM" then
		if PlayerIsInCombat() then
			if itype ~= "interior" and itype ~= "neighborhood" and itype ~= "scenario" then
				print("InCombat")
				return
			end
		end
		if string.find(arg1, "tipsy") or string.find(arg1, "drunk") then
			Ramble(colorMe("Drunk? ", "Teal")..tostring(arg1), colorMe("[CHAT_MSG_SYSTEM]", "Laguna"))
			--print(arg1)
		end
	elseif event == "PLAYER_MONEY" then
		local amt = GetMoney()
		local diff = (amt - Lunacy[playerKey].gold)
		
		--loco.balance = loco.balance + diff
		if diff < 0 then
			loco.spent = loco.spent - diff
			loco.balance = loco.balance + diff
			if diff < -177717771 then
				FlashMe("Maroon") -- Luxury
			else
				loco.sticky = max(loco.sticky+diff*0.000003666, -66)
				Ramble(colorMe("sticky: ", "Honey")..tostring(loco.sticky),colorMe("[Bone] ", "Bone"))
				FlashMe("Bone") -- The Market
			end
			Ramble(GetMoneyString(math.abs(diff)),colorMe("[Bone] ", "Bone"))
		else
			loco.earned = loco.earned + diff
			loco.balance = loco.balance + diff
			if diff > 177717771 then
				FlashMe("Chartreuse") --Avarice
			else
				if loco.spell == "Gold" then
					loco.sticky = loco.sticky+diff*0.00001777
					Ramble(colorMe("sticky: ↑", "Honey")..tostring(loco.sticky),colorMe("[Gold] ", "Gold"))
				else
					--loco.sticky = loco.sticky+diff*0.000000777
					loco.gold = (loco.gold or 0)+diff*0.000003777
					--Ramble(colorMe("sticky: ↑", "Honey")..tostring(loco.sticky),colorMe("[Gold] ", "Gold"))
				end
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
		--mOOdleVel("Gold", amt / 100000)
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
	--elseif event == "COMBAT_LOG_EVENT" then
		
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
		initLineSet("DeepPurple")
		--FlashMe("DeepPurple")
	elseif event == "PLAYER_ALIVE" then
		loco.dead = nil
		if loco.haunted / 2^random(11) > 66.6 then
			initLineSet("Obsidian")
		end
	elseif event == "ADDON_LOADED" and arg1 == "Lunacy" then
		--InitFrames()
	elseif event == "PLAYER_ENTERING_WORLD" then
		LocoLoad()
		InitFrames()
		frame_update()
		init_lines()
		ShadowDance()
    end
	loco.event = event
end)

Lunacy.InitCompass = function()
	loco.suwLock = nil
	Lunacy.loco = loco
	--initLineSet(11)
	--initLineSet(num,spin,degInc,rd,rdInc,colorSet,connect,smooth,driftX,driftY)
	--if not linesUP then
		--init_lines()
	--end
	
end

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

-- Params; id,xoff,yoff,zoff,camtarX,camtarY,camtarZ,pitch,yaw,gizmo,
-- 		   rotinc,dance,camdis,sandyRot,campulse,camMin,camMax,nospin
Lunacy.TrollMe = function(wITh)
	if tonumber(wITh) then
		wITh = tonumber(wITh)
	end
	if type(wITh) == "string" and trOlls[wITh] then
		wITh = trOlls[wITh].id
	end
	--sandy:SetAnimation(trock.anim)
	if not wITh then
		wITh = 777
	end
	sandy:ClearModel()
	if not sandy:HasCustomCamera() then
		sandy:SetCustomCamera(1)
	end
	if not trOlls[wITh] then
		sandy:SetDisplayInfo(wITh)
	end
	local twit
	if trOlls[wITh] then
		if wITh ~= loco.trollcall then
			loco.trollcall = wITh
			loco.xoff = 0
			loco.yoff = 1
			loco.zoff = 1
			loco.camtarX = 0
			loco.camtarY = 0
			loco.camtarZ = 1
			loco.pitch = 0
			loco.yaw = 0
			loco.trollUp = wITh
		--end
		
			if trOlls[trOlls[wITh]] and trOlls[trOlls[wITh]].id then
				sandy:SetDisplayInfo(trOlls[trOlls[wITh]].id)
				loco.trOll = trOlls[trOlls[wITh]].id
				twit = trOlls[wITh]
			end
			if trOlls[twit] then
				local skit
				if trOlls[twit].skits and loco.digroot then
					local n = #trOlls[twit].skits
					--dig = loco.digroot
					if loco.digroot > n then
						loco.digroot = 1
					elseif loco.digroot < 1 then
						loco.digroot = n
					end
					if L_DBG >= 6 or L_DBF["TrollMe"] then
						Ramble(colorMe("×", "SuppleOrange")..colorMe("~Skit~", "Desire")..colorMe("× ", "SuppleOrange")..tostring(loco.digroot), colorMe("[TrollMe] ", "Green"))
					end
					skit = trOlls[twit].skits[loco.digroot]
				else
					if L_DBG >= 6 or L_DBF["TrollMe"] then
						Ramble(colorMe("×", "SuppleOrange")..colorMe("~Refresh Troll~", "ElectricBlue")..colorMe("× ", "SuppleOrange"), colorMe("[TrollMe] ", "Green"))
					end
					skit = trOlls[twit]
				end
				--print("Twit")
				loco.sandyRot = skit.rot or 0
				--print(loco.camdis)
				--loco.camdis = loco.camdis or 1.0
				--if trOlls[twit].camdis then
					--loco.camdis = trOlls[twit].camdis
					--print("TrollsWith : "..trOlls[wITh])
					--print("TrollsWith : "..trOlls[trOlls[wITh]].camdis)
				--end
				if skit.dance then
					loco.dance = skit.dance
				else
					loco.dance = nil
				end
				--loco.camdis = trOlls[trOlls[wITh]].camdis or loco.camdis or 1.0
				--print(loco.camdis)
				loco.needle = skit.needle or trOlls[twit].needle
				loco.xoff = skit.xoff or loco.xoff or 0
				loco.yoff = skit.yoff or loco.yoff or 1
				loco.zoff = skit.zoff or loco.zoff or 1
				loco.camtarX = skit.camtarX or loco.camtarX or 0
				loco.camtarY = skit.camtarY or loco.camtarY or 0
				loco.camtarZ = skit.camtarZ or loco.camtarZ or 1
				loco.camyoff = skit.camyoff or loco.yoff
				loco.rotinc = skit.rotinc or 5
				loco.campulse = skit.campulse or 0.15
				loco.camMax = skit.camMax or 3.77
				loco.camMin = skit.camMin or 0.37
				loco.gizmo = skit.gizmo or 0
				loco.yaw = skit.yaw or loco.yaw or 0
				loco.pitch = skit.pitch or loco.pitch or 0
				loco.nospin = skit.nospin
				loco.trollUp = skit.id or wITh
			end
		end
		
		sandy:SetDisplayInfo(loco.trollUp)
		--[[
		if not sandy:HasCustomCamera() then
			sandy:SetCustomCamera(1)
		end
			
		sandy:SetRotation(rad(loco.sandyRot),true)
		
		if sandy:HasCustomCamera() then
			--loco.trollpass = nil
			--print("HasCustomCamera")
			--sandy:SetCameraDistance(loco.camdis)
			
			sandy:SetCameraTarget(loco.camtarX, loco.camtarY, loco.camtarZ) -- point to point camera at; 0,0,1 = midsection of troll, 0,0,0 = troll's feet
			
			sandy:SetCameraPosition(loco.xoff, loco.yoff, loco.zoff)
			
			--sandy:SetGlow(3.0)
			sandy:SetPitch(loco.pitch)
			sandy:SetRoll(loco.yaw)
		end
		]]--
		sandyDance()
		if twit then
			loco.trollpoll = wITh
		end
		
		--if loco.dance then
			--sandy:SetAnimation(loco.dance)
			--return trOlls[wITh].." "..tostring(trOlls[trOlls[wITh]].desc).." `dancin the "..tostring(trOlls[trOlls[wITh]].dance).."~ "..trOlls[wITh]
		--end
		return trOlls[wITh].." "..tostring(trOlls[trOlls[wITh]].desc).." "..trOlls[wITh] -- 
	else
		sandy:SetDisplayInfo(wITh)
	end
end

function Artisanship(tap,crest)
	local ham = 3 + random(4)
	local st
	loco.artisan = (loco.artisan or 0) + 1
	loco[tap] = (loco[artisan] or 0) + 1
	st = tostring(loco.artisan).." = "..table_to_string(factors(loco.artisan), "♦")
	if L_DBG >= 4 or L_DBF["Artisanship"] then
		Ramble(colorMe("Factors • ", "Gold")..colorMe(st, crest), colorMe("[Artisanship] ", "Wood"))
		Ramble(colorMe(crest, crest)..colorMe(" → ", "Alabaster")..colorMe(loco.artisan, "Alabaster")..colorMe(" <.> ", "Alabaster")..colorMe(ham, "Silver"),colorMe("[Artisanship] ", "Wood"))
	end
	if loco.artisan / 343 == floor(loco.artisan / 343) then --~~Lucky Do's and Ropes~~ 7♦7♦7 = 343
		local icky = loco.sticky
		loco.sticky = loco.sticky * 0.23
		if L_DBG >= 4 or L_DBF["Artisanship"] then
			--Ramble(colorMe("Factors • ", "Gold")..colorMe("♦", "CandyApple")..colorMe(crest, crest)..colorMe("♦", "CandyApple"), colorMe("[FlashMe] ","CandyApple"))
			Ramble(colorMe("~~Lucky Do's and Ropes~~ 7♦7♦7", "Gold"), colorMe("[Artisanship] ", "Wood"))
			Ramble(colorMe("Draw • ", "CandyApple")..colorMe("♦", "Shamrock")..colorMe(crest, crest)..colorMe("♦", "Shamrock"), colorMe("[Artisanship] ", "Wood"))
			--Ramble(colorMe("FlashMe, crest)..colorMe(" ..> ", "Alabaster")..colorMe(ham, "Silver"),colorMe("[Artisanship] ", "Wood"))
			Ramble(colorMe("sticky bone: ", "Bone")..colorMe("♣", "Shamrock")..tostring(icky),colorMe("[Artisanship] ", "Wood"))
			Ramble(colorMe("sticky bone: ", "Bone")..colorMe("↓", "Bone")..tostring(st),colorMe("[Artisanship] ", "Wood"))
			Ramble(colorMe("sticky bone: ", "Bone")..colorMe("♦", "Red")..tostring(loco.sticky),colorMe("[Artisanship] ", "Wood"))
		end
		FlashMe(crest)
	elseif loco.artisan / ham == floor(loco.artisan / ham) then
		if L_DBG >= 4 or L_DBF["Artisanship"] then
			--Ramble(colorMe("Factors • ", "Gold")..colorMe("♦", "CandyApple")..colorMe(crest, crest)..colorMe("♦", "CandyApple"), colorMe("[FlashMe] ","CandyApple"))
			Ramble(colorMe("Draw • ", "Wood")..colorMe("♦", "CandyApple")..colorMe(crest, crest)..colorMe("♦", "CandyApple"), colorMe("[Artisanship] ", "Wood"))
			--Ramble(colorMe("FlashMe, crest)..colorMe(" ..> ", "Alabaster")..colorMe(ham, "Silver"),colorMe("[Artisanship] ", "Wood"))
		end
		FlashMe(crest)
	elseif IsPrime(loco.artisan) then
		if not loco.prima then
			loco.artisan = 1
			loco.prima =  0
		elseif loco.charm and loco.artisan > loco.charm then
			loco.artisan = 1
		end
		loco.prima = loco.prima + 1
		if not loco.charm and random(7777) == 7777 then
			loco.charm = loco.artisan
			EarThis(550736)
			if L_DBG >= 1 or L_DBF["Artisanship"] then
				Ramble(colorMe("ώ", "Shamrock")..colorMe("~Charmed~", "NeonYellow")..colorMe("ώ ", "Shamrock")..tostring(loco.charm), colorMe("[Artisanship] ", "Wood"))
			end
		end
		if L_DBG >= 4 or L_DBF["Artisanship"] then
			--local st = tostring(loco.artisan).." = "..table_to_string(factors(loco.artisan), "*")
			Ramble(colorMe("♦", "CandyApple")..colorMe("Prime Draw", "Gold")..colorMe("♦", "CandyApple"), colorMe("[Artisanship] ", "Wood"))
			--Ramble(colorMe(st, "Gold"), colorMe("[FlashMe] ","CandyApple"))
			--Ramble(colorMe("FlashMe, crest)..colorMe(" ..> ", "Alabaster")..colorMe(ham, "Silver"),colorMe("[Artisanship] ", "Wood"))
		end
		FlashMe(crest)
	end
end

function FlashMe(wITh)
	local r,g,b,hand
	hand = DrawCard(wITh)
	
	if hand then
		loco.lastFlash = wITh
		
		if wITh ~= "Scarlet" then
			loco.flashes = loco.flashes + 1
			if loco.charm and loco.flashes > loco.charm then
				loco.flashes = 1
			end
			if not loco.charm and IsPrime(loco.flashes) then
				if random(7777) == 7777 then
					loco.charm = loco.flashes
					EarThis(550736)
					if L_DBG >= 1 or L_DBF["FlashMe"] then
						Ramble(colorMe("ώ", "SuppleOrange")..colorMe("~Charmed~", "NeonGreen")..colorMe("ώ ", "SuppleOrange")..tostring(loco.charm), colorMe("[FlashMe] ", "Veronica"))
					end
				end
				loco.digroot = digRoot(loco.flashes)
				loco.trollcall = nil
				if L_DBG >= 5 or L_DBF["FlashMe"] then
					Ramble(colorMe("DigRoot: √", "NeonGreen")..tostring(loco.flashes)..colorMe(" = ","NeonGreen")..tostring(loco.digroot), colorMe("[FlashMe] ", "Veronica"))
				end
				if trOlls[loco.trOll] and trOlls[trOlls[loco.trOll]] and trOlls[trOlls[loco.trOll]].skits then
					TrollMe(loco.trOll)
				end
			end
		end
		if hand.ring then
			loco.ring = hand.ring
			--print(loco.ring)
			r,g,b = hex2rgb(GetHexColor(loco.ring))
			LunacyFrameB.texture:SetVertexColor(r/255, g/255, b/255,1)
		end
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
		if hand.connect and hand.connect == false then
			loco.lsConnect = nil
		elseif hand.connect then
			loco.lsConnect = hand.connect
		end
		--[[
		if hand.troll and not loco.trOllOck and hand.card and hand.card.house then
			local house = hand.card.house
			local amt = loco[house]
			if amt and random(177) < amt then
				if trOlls[hand.troll] then
					TrollMe(hand.troll)
				else
					loco.sandyRot = 0
					sandy:SetDisplayInfo(hand.troll)
					--sandy:SetCamDistanceScale(1.0)
					loco.camdis = 1.0
					sandy:SetCameraDistance(loco.camdis)
					sandy:SetPoint("TOPLEFT", LunacyFrameB, "TOPLEFT", 15, -8)
				end
			end
		end
		]]--
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
							--print(sv)
							loco[k][sk] = GetTimePreciseSec() + sv
							--print(loco[k][sk])
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
			local key = hand.card.suit
			loco[key] = loco[key] or 0
			loco[key] = loco[key] + floor((loco.digroot or 1) / 9) * 7.77
			if hand.card.flip then
				loco[key] = loco[key] + hand.card.flip() or 1
			else
				loco[key] = loco[key] + 1
			end
			local rnd = random(hand.card.affinity)
			if (L_DBG >= 4 or L_DBF["FlashMe"]) and key ~= "Scarlet" then
				Ramble(colorMe("rnd • ", "Desire")..colorMe(tostring(rnd), "Shamrock"), colorMe("[FlashMe] ","CandyApple"))
				Ramble(colorMe("key • ", "Wood")..colorMe(key, key), colorMe("[FlashMe] ","CandyApple"))
				Ramble(colorMe("loco • ", "Purple")..colorMe(tostring(loco[key]), "Yellow"), colorMe("[FlashMe] ","CandyApple"))
				--Ramble(colorMe("FlashMe, crest)..colorMe(" ..> ", "Alabaster")..colorMe(ham, "Silver"),colorMe("[Artisanship] ", "Wood"))
			end
			loco.sticky = loco.sticky + (loco[key]/rnd) * 0.00777
			--print("rnd: "..tostring(rnd))
			--print("key: "..tostring(key))
			--print("loco: "..tostring(loco[key]))
			if rnd + loco.sticky < loco[key] and loco.spell ~= key then
				loco[key] = 0
				loco.sticky = 0
				local pick
				if grimoire[key] and grimoire[key].snarks then
					pick = select(random(#grimoire[key].snarks), unpack(grimoire[key].snarks))
					EarThis(pick)
				end
				
				--if hand.card.avatar then
					--sandy:SetDisplayInfo(hand.card.avatar)
				--end
				if hand.card.suit then
					initLineSet(hand.card.suit)
				end
				if hand.card.loco then
					for k,v in pairs(hand.card.loco) do
						loco[k] = v
					end
				end
			elseif hand.card.suit == loco.spell then
				local st = loco.sticky
				loco.sticky = min(abs(loco.sticky*1.0001777), 777)
				if (L_DBG >= 2 or L_DBF["FlashMe"]) and hand.card.suit ~= "Scarlet" then
					Ramble(colorMe("sticky: ", "Honey")..colorMe("↑", "Green")..tostring(st),colorMe("[FlashMe] ", "CandyApple"))
					Ramble(colorMe("sticky: ", "Honey")..colorMe("♠", "Black")..tostring(loco.sticky),colorMe("[FlashMe] ", "CandyApple"))
				end
			elseif hand.card.suit ~= loco.spell then
				local st = loco.sticky
				loco.sticky = max(loco.sticky*0.934, -66)
				if (L_DBG >= 2 or L_DBF["FlashMe"]) and hand.card.suit ~= "Scarlet" then
					Ramble(colorMe("sticky bone: ", "Bone")..colorMe("↓", "Red")..tostring(st),colorMe("[FlashMe] ", "CandyApple"))
					Ramble(colorMe("sticky bone: ", "Bone")..colorMe("♦", "Red")..tostring(loco.sticky),colorMe("[FlashMe] ", "CandyApple"))
				end
			end
		end
		--if loco.sticky < 0 then
			--loco.sticky = 0
		--end
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
				loco.cast = hand.cast[random(#hand.cast)] -- ~gnarly~
			else
				loco.cast = hand.cast
			end
		end
		--if hand.diSTurbed then
			--loco.diSTurbed = loco.diSTurbed * (1 - random() * 0.00313)
			--loco.diSTurbed = hand.diSTurbed(loco.diSTurbed)
		--end
		if type(hand.diSTurbed) == "number" then
			loco.diSTurbed = loco.diSTurbed + hand.diSTurbed
		elseif type(hand.diSTurbed) == "function" then
			--loco.diSTurbed = loco.diSTurbed * (1 - random() * 0.00313)
			loco.diSTurbed = hand.diSTurbed(loco.diSTurbed)
			if L_DBG >= 7 then
				Ramble(colorMe("~Stay away from the VooDoo mon~ (", "Alabaster")..colorMe(tostring(loco.diSTurbed), "Ingigo")..colorMe(")", "Alabaster"), colorMe("[LuckyDoo] ", "Shamrock"))
			end
		end
		if type(hand.lucky) == "number" then
			loco.lucky = loco.lucky + hand.lucky
		elseif type(hand.lucky) == "function" then
			--loco.diSTurbed = loco.diSTurbed * (1 - random() * 0.00313)
			loco.lucky = hand.lucky(loco.lucky)
			if L_DBG >= 7 then
				Ramble(colorMe("[~7~] Lucky Doo HooDoo thats Hoooooo~ (", "Alabaster")..colorMe(tostring(loco.lucky), "Chartreuse")..colorMe(")", "Alabaster"), colorMe("[LuckyDoo] ", "Shamrock"))
			end
		end
		--loco.lucky = loco.lucky * (1 + random() * 0.00131)
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
	--Spirit
	elseif wITh == "Skipper" then --butterflies
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
		if loco.spell == "Scarlet" then
			LunacyGyre:Show()
			loco.flashTime = GetTimePreciseSec() + 1
			colorFeed(loco.candyapple or "Black", 1)
			if not loco.candyapple then
				LunacyGyre.texture:SetVertexColor(0, 0, 0)
			end
		end
	
	elseif wITh == "XXXX" then
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
		loco.diSTurbed = loco.diSTurbed * (1 + random() * 0.0666)
		loco.lucky = loco.lucky * (1 - random() * 0.0777)
		if L_DBG >= 2 then
			local st = colorMe("♠", "Black")..colorMe("♥", "Red")..colorMe("♣", "Black")..colorMe("♦", "Red")
			if loco.lucky/(loco.diSTurbed or 6.9) >= 7 then
				Ramble(st..colorMe(" ÎGood", loco.lineClr or "Mulberry")..colorMe(" →", "White")..colorMe(floor(loco.lucky), "Shamrock")..colorMe("← ", "White")..colorMe("JobÎ ", "White")..st,colorMe("[Gyre] ", "Purple"))
			else
				Ramble(st..colorMe(" ÎOuchÎ ", "Scarlet")..colorMe(" →", "Chartreuse")..colorMe(floor(loco.diSTurbed), "Indigo")..colorMe("← ", "Chartreuse")..st,colorMe("[Gyre] ", "Purple"))
			end
		end
		colorFeed("Maroon", 1)
		LunacyGyre:Show()
		loco.flashTime = GetTimePreciseSec() + 1
	
	--Earth
	elseif wITh == "Cobalt" then
		if loco.drX then
			loco.drX.decay = (loco.drX.decay * 1.001) + 9
			loco.drX.relax = (loco.drX.relax * 1.07) + 0.0021
		end
	elseif wITh == "XXoXX" then
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
		loco.diSTurbed = loco.diSTurbed * (1 + random() * 0.00666)
		loco.lucky = loco.lucky * (1 - random() * 0.00777)
	elseif wITh == "Bone" then
		LunacyGyre.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\LunacyE")
		r,g,b = hex2rgb(GetHexColor("Bone"))
		LunacyGyre.texture:SetVertexColor(r/255, g/255, b/255)
		colorFeed("Bone", 4)
		LunacyGyre:Show()
		loco.overTime = GetTimePreciseSec() + 7.11
		loco.lsSpinOver = 71
		loco.flashTime = GetTimePreciseSec() + 7.11
		loco.diSTurbed = loco.diSTurbed * (1 + random() * 0.001666)
		loco.lucky = loco.lucky * (1 - random() * 0.001777)
		loco.sticky = loco.sticky * 0.993
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
		local rnd = random() * (loco.lucky / (loco.diSTurbed * 0.169))
		--print(rnd)
		--loco.lineAlpha = 1.0
		if rnd < 7.7 then
			Ramble(colorMe("Luck ^ ", "Shamrock")..colorMe(loco.lucky, "BrightMint"), colorMe("[Gyre] ", "Purple"))
			Ramble(colorMe("diSTurbed /~\\ ", "Indigo")..colorMe(loco.diSTurbed, "Bumblebee"), colorMe("[Gyre] ", "Purple"))
			Ramble(colorMe("RnD ~^~ ", "Coffee")..colorMe(rnd, "Tomato"), colorMe("[Gyre] ", "Purple"))
			loco.pulse = nil
			--3534100 - How is your day going?
			rnd = select(floor(rnd+1), 546621,546627,546631,567134,3089702,3534100,548759,3089702)
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
		loco.diSTurbed = loco.diSTurbed - 0.13
		loco.lsSpinRate = (loco.lsSpinRate or 0) + loco.spd * 0.13
		if loco.diSTurbed <= 1.77 then
			loco.diSTurbed = 0.77
		end
		loco.flashTime = GetTimePreciseSec() + 1
		loco.active = loco.active + 0.77
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
		colorFeed("AeroBlue", 2)
		LunacyGyre:Show()
		loco.diSTurbed = loco.diSTurbed - 0.169
		loco.lsSpinRate = (loco.lsSpinRate or 0) - loco.spd * 0.169
		
		if loco.diSTurbed <= 1.11 then
			loco.diSTurbed = 7.77
		elseif loco.diSTurbed > 777 then
			loco.diSTurbed = loco.diSTurbed - 77
		end
		loco.flashTime = GetTimePreciseSec() + 0.44
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
		if type(hand.cast) == "table" then
			local r = select(random(#hand.cast), unpack(hand.cast))
			return r
		elseif type(hand.cast) == "string" then
			return hand.cast
		else
			return "The Gyre churns in response to your sacrifice.."
		end
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
	loco.facing = pF
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
	loco.face = pF
	if pF then
		--local angle = (rad(135) - pF) / 0.017453
		local angle = (rad(135) - pF)
		--local s,c = sin(angle) * sqrt(0.5) * 1.0, cos(angle) * sqrt(0.5) * 1.0
		local s,c = sin(angle) * sqrt(0.5), cos(angle) * sqrt(0.5)
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
	print("SetUserWaypoint")
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
		if L_DBG >= 3 or L_DBF["SetUserWaypoint"] then
			Ramble(colorMe("WP-Set: ", "Liserian")..colorMe(tostring(hasWay.name), "LightGoldenrod"), colorMe("∫SetUserWaypoint∫ ", "Veronica"))
		end
		loco.suwLock = GetTimePreciseSec()
		C_SuperTrack.SetSuperTrackedUserWaypoint(true)
	elseif urWay and loco.pinOvr then
		if L_DBG >= 3 or L_DBF["SetUserWaypoint"] then
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
	loco.isTracking = nil
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
	Distance:SetText(Lunacy.Text2)
	Speed:SetText(Lunacy.Text4)
	Objective:SetText(Lunacy.Text1)
	ObjectiveB:SetText(Lunacy.Text3)
	ObjectiveC:SetText(Lunacy.Text5)
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

Lunacy.beckon = function(troll)
	return TrollMe(troll)
end

function luCky_seVen()
	loco.diSTurbed = loco.diSTurbed or 1
	loco.lucky = loco.lucky or 777
	loco.seVen = floor(math.abs(loco.angle * (180 / math.pi)))
	if loco.seVen == 37 or loco.seVen == 77 or loco.seVen == 137 or loco.seVen == 177 or loco.seVen == 234 then
		--print(loco.angle)
		local rnd = random() * loco.lucky * 7.7
		--print(rnd)
		if rnd < loco.diSTurbed then
			loco.diSTurbed = loco.diSTurbed - (loco.diSTurbed - rnd) * 0.07
			rnd = random(7)
			print(rnd)
			if rnd == 7 then
				loco.diSTurbed = floor(random()*777)/1000
				loco.lucky = loco.lucky + 77.7
				if L_DBG >= 7 then
					Ramble(colorMe("Lucky 7's!", "NeonYellow"), colorMe("[~lucky~]", "Shamrock"))
				end
			elseif rnd == 3 then
				loco.diSTurbed = floor(loco.diSTurbed*1333)/1000
			elseif rnd == 1 then
				loco.diSTurbed = floor(loco.diSTurbed*1111)/1000
				loco.lucky = loco.lucky - 11.1
			elseif random(77) == 37 then
				loco.diSTurbed = loco.diSTurbed + 6.66
				loco.lucky = loco.lucky - 66.6
				if floor(loco.lucky*0.137) == 77 then
					loco.lucky = loco.lucky - 666
					if loco.lucky < 77 then
						loco.lucky = 66.6
					end
					loco.diSTurbed = loco.diSTurbed + 0.137 * loco.lucky
					if L_DBG >= 4 then
						Ramble(colorMe("Curses!", "Violet"), colorMe("[~curses~]", "Scarlet"))
					end
				end
				
			end
			--loco.diSTurbed = floor(loco.diSTurbed*10000)/10000
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
				if L_DBG >= 5 or L_DBF["Quest"] then
					Ramble(colorMe(".Idle.","MorningBlue"), colorMe("[Quest]", "Green"))
				end
				if L_DBG >= 5 or L_DBF["Quest"] then
					Ramble(colorMe("<mapQMapMeth> : ","Midnight")..tostring(loco.mapQMapMeth), colorMe("[Quest] ", "Green"))
					--Ramble(tostring(loco.mapQMapMeth), "|cffffb100<mapQMapMeth>|r ")
				end
				if L_DBG >= 5 or L_DBF["Quest"] then
					Ramble(colorMe("[DBG-CHK X] : ","CandyApple")..tostring(stqID), colorMe("[Quest] ", "Green"))
					--Ramble(tostring(x), "|cff0492c2<[DBG-CHK X]>|r ")
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
				if L_DBG >= 5 or L_DBF["Quest"] then
					Ramble(colorMe("[DBG-CHK A] : ","Raspberry")..tostring(x), colorMe("[Quest] ", "Green"))
					--Ramble(tostring(x), "|cff0492c2<[DBG-CHK A]>|r ")
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
				if L_DBG >= 5 or L_DBF["Quest"] then
					Ramble(colorMe("[DBG-CHK B] : ","SuppleOrange")..tostring(x), colorMe("[Quest] ", "Green"))
					--Ramble(tostring(x), "|cff0492c2<[DBG-CHK B]>|r ")
				end
			end
		end
		
		if not x then
			mapID, x, y = C_QuestLog.GetNextWaypoint(stqID)
		end
		
		if dbgLatch then
			if x then
				if L_DBG >= 5 or L_DBF["Quest"] then
					Ramble(colorMe("X: ","CandyApple")..tostring(x), colorMe("[Quest] ", "Green"))
					Ramble(colorMe("Y: ","NeonYellow")..tostring(y), colorMe("[Quest] ", "Green"))
					Ramble(colorMe("MapID: ","IndianYellow")..tostring(mapID), colorMe("[Quest] ", "Green"))
					Ramble(colorMe("stqID: ","Chateau")..tostring(stqID), colorMe("[Quest] ", "Green"))
				end
				--print("Quest X: "..tostring(x))
				--print("Quest Y: "..tostring(y))
				--print("Map: "..tostring(mapID).." |cffff00ff("..tostring(map)..")|r")
				--print("pMap: "..tostring(map))
			else
				--C_QuestLog.GetNextWaypoint(92443)
				loco.qUpTrk = GetTimePreciseSec()
				if L_DBG >= 5 or L_DBF["Quest"] then
					Ramble(colorMe("Quest coords not returned...","Beige"), colorMe("[Quest] ", "Green"))
					--print("Quest coords not returned.")
				end
				if mapID then
					if L_DBG >= 5 or L_DBF["Quest"] then
						Ramble(colorMe("MapID: ","Midnight")..tostring(mapID), colorMe("[Quest] ", "Green"))
					end
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
		local info = {}
		if mapID then
			info = C_Map.GetMapInfo(mapID)
		end
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

Lunacy.DistanceRecorder = function()
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
	avg = 0
	for i,v in ipairs(distTab) do
		avg = avg + v
	end
	dis = avg / spdTsz --smooth jazz
	
	phPref = Luna.phPref or "kph"
	local spd = 0
	loco.coLor = loco.coLor or "Mulberry"
	local cLr = loco.coLor
	local r,g,b,sex,chex
	if dis then
		dis = dis * 0.77
		if dis >= 0 and dis < 125 then
			loco.lastdis = dis
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
				Speed:SetText(Lunacy.Text4)
			--end
			--Lunacy.Text4 = "<"..tostring(spd)..">"
			Lunacy[playerKey].totalDistance = Lunacy[playerKey].totalDistance + dis
			local tDis = Lunacy[playerKey].totalDistance or 0
			loco.jaunt = loco.jaunt or Lunacy[playerKey].totalDistance
			if tDis - loco.jaunt > 36 then
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
				local ones, nones, lones = 0, true, tDis - floor(tDis)
				for i=1, 6 do
					ones = mod(tDis, 10)
					if ones >= 9 and nones then
						tDis = tDis / 10
						ones = floor(ones) + lones
					elseif nones then
						tDis = floor(tDis/10)
						ones = floor(ones) + lones
						nones = nil
					else
						tDis = floor(tDis/10)
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
	if loco.idx == 1 then
		if spd == 0 then
			r,g,b = hex2rgb(GetHexColor(loco.needle or loco.coLor))
		end
		r,g,b = r/255,g/255,b/255
		CompArrow.texture:SetVertexColor(r, g, b, 1)
		local angle = 4.52 - rad(spd*1.17)
		local s,c = sin(angle) * math.sqrt(0.5), cos(angle) * math.sqrt(0.5)
		CompArrow.texture:SetTexCoord(0.5-s,0.5+c,0.5+c,0.5+s,0.5-c,0.5-s,0.5+s,0.5-c)
	elseif loco.idx == 2 then
		if loco.isTracking and loco.compcol ~= "Green" then
			loco.compcol = "Green"
			CompArrow.texture:SetVertexColor(0, 1, 0, 1)
		elseif loco.needle and loco.needle ~= loco.comcol and not loco.isTracking then
			loco.compcol = loco.needle
			r,g,b = hex2rgb(GetHexColor(loco.compcol))
			r,g,b = r/255,g/255,b/255
			CompArrow.texture:SetVertexColor(r, g, b, 1)
		elseif loco.lineClr and loco.lineClr ~= loco.comcol and not loco.isTracking then
			loco.compcol = loco.lineClr
			r,g,b = hex2rgb(GetHexColor(loco.compcol))
			r,g,b = r/255,g/255,b/255
			CompArrow.texture:SetVertexColor(r, g, b, 1)
		elseif loco.compcol ~= "FireBrick" and not loco.isTracking then
			loco.compcol = "FireBrick"
			r,g,b = hex2rgb(GetHexColor(loco.compcol))
			r,g,b = r/255,g/255,b/255
			CompArrow.texture:SetVertexColor(r, g, b, 1)
		end
	end
	
	loco.lastTime = GetTimePreciseSec()
end

DistanceRecorder = Lunacy.DistanceRecorder

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


