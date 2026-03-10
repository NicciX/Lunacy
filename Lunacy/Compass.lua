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

--local distTab = table.create(spdTsz)
--local timeTab = table.create(spdTsz)

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
local pWay = nil

local ddC = 0

loco.idx = 1


local dbgLatch = true

--trackType[1] = "none"
--trackType[2] = "quests"
local sounds = {559193,568873,541055}
local trackType = {"idle", "quests", "elders"}
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

--Lunacy Dial
local LunacyFrameA = CreateFrame("Button", "LunacyFrameA", LunacyMainFrame)
LunacyFrameA:SetWidth(96);
LunacyFrameA:SetHeight(96);
LunacyFrameA:EnableMouse(enable)
LunacyFrameA.texture = LunacyFrameA:CreateTexture()
LunacyFrameA.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\CompassA")
LunacyFrameA:SetPoint("CENTER")
LunacyFrameA:SetFrameStrata("LOW")
LunacyFrameA.texture:SetDrawLayer("ARTWORK", 1)
LunacyFrameA.texture:SetAllPoints(LunacyMainFrame)
LunacyFrameA.texture:SetVertexColor(0, 0.75, 0.75)

--Lunacy Bubble
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
LunacyFrameB.texture:SetVertexColor(0.44, 0.22, 0)

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

--Lunacy Arrow
local CompArrow = CreateFrame("Button", "CompArrow", LunacyMainFrame)
CompArrow:SetWidth(96);
CompArrow:SetHeight(96);
CompArrow:EnableMouse(enable)
CompArrow.texture = CompArrow:CreateTexture()
CompArrow.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\Arrow")
CompArrow:SetPoint("CENTER")
CompArrow:SetFrameStrata("MEDIUM")
CompArrow.texture:SetDrawLayer("ARTWORK", 5)
CompArrow.texture:SetBlendMode("BLEND")
CompArrow.texture:SetAllPoints(LunacyMainFrame)
CompArrow.texture:SetVertexColor(0.65, 0.25, 0.15, 1)

CompArrow.visible = true
--loco.isTracking = nil
CompArrow.trackMap = 1
CompArrow.trackX = 0.5
CompArrow.trackY = 0.5

--Minimap Arrow -- POI
Lunacy.destIcon = CreateFrame("Button", "LunacyDestIcon", Minimap)
Lunacy.destIcon.texture = Lunacy.destIcon:CreateTexture(nil, "ARTWORK")
Lunacy.destIcon.texture:SetTexture("Interface\\Addons\\Lunacy\\Media\\MinimapArrow")
Lunacy.destIcon:SetWidth(32)
Lunacy.destIcon:SetHeight(32)
Lunacy.destIcon.texture:SetPoint("CENTER")
Lunacy.destIcon.texture:SetVertexColor(0, 1, 0)

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
--LunacyMainFrame.ObjectiveB:SetWidth(125)
--LunacyMainFrame.ObjectiveB:SetHeight(25)
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

local destIcon = CreateFrame("Button", "LunacyDestIcon", minimapParent)
destIcon:SetHeight(20)
destIcon:SetWidth(20)
destIcon.icon = destIcon:CreateTexture(nil,"OVERLAY")
destIcon.icon:SetPoint("CENTER", 0, 0)
destIcon.icon:SetBlendMode("BLEND")
destIcon.icon:SetTexture("Interface\\Addons\\Lunacy\\Media\\Alpaca32")

LunacyFrameB:SetScript("OnMouseDown", function (self, button)
	if button == "LeftButton" and IsLeftShiftKeyDown() then
		loco.idx = loco.idx + 1
		if loco.idx > 3 then
			loco.idx = 1
		end
		loco.destCheck = nil
		
		PlaySoundFile(sounds[loco.idx])
		
		loco.hasTrack = ""
		loco.trackType = trackType[loco.idx]
		loco.lock = false
		
		if loco.idx == 1 then
			print("|cff00ffffLunacy |cfffffffftracking off.")
			loco.isTracking = nil
			ToggleTracking("stop")
		else
			print("|cff00ffffLunacy |cfffffffftracking type changed to |cffff0000"..trackType[loco.idx].."|cffffffff.")
			loco.isTracking = true
			ToggleTracking("start")
		end
	elseif button == "LeftButton" and IsControlKeyDown() then
		forceArrival = true
	elseif button == "LeftButton" then	
		LunacyMainFrame:StartMoving()
	elseif button == "RightButton" and not IsLeftShiftKeyDown() then
		loco.isTracking = true
		C_Map.ClearUserWaypoint()
		WaypointUIAPI.Navigation.ClearUserNavigation()
		pWay = nil
		loco.pinOvr = nil
		loco.optDesc = nil
		UpdateCompass()
		ToggleTracking("stop")
		ToggleTracking("start")
		UpdateTrack()
	end
end)

LunacyFrameB:SetScript("OnMouseUp", function (self, button)
	if button == "LeftButton" then
		LunacyMainFrame:StopMovingOrSizing()
		local tt = GetTimePreciseSec()
		if tt - ddC < 0.25 then
			
		end
		local clr,tag = GetNextColor()
		if L_DBG >= 1 or L_DBF["UpdateTrack"] then
			Ramble(colorMe(clr, clr),"|cff00ff00[ColorMe]|r|cffa4ff77 |r")
		end
		ddC = tt
	elseif button == "RightButton" and IsLeftShiftKeyDown() then
		C_UI.Reload()
	end
end)

function LunacyUpdateController()
	if LunacyMainFrame:IsShown() then
		SetPlayerFacing()
	end
	if loco.isTracking then
		Lunacy_Track()
	end
	DistanceRecorder()
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
	if (Lunacy.Timer > .05) then
		if Lunacy.playerStatus ~= "loaded" then
			return
		end
		Lunacy.Timer = 0
		LunacyUpdateController()
	end
end

local function PokeMap()
	local mapID = C_Map.GetBestMapForUnit("player")
	C_Map.OpenWorldMap(mapID)
	pokeMap = mapID
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

LunacyMainFrame:SetScript("OnEvent", function(self, event, ...)
	local arg1, arg2 = ...

	if (event == "SUPER_TRACKING_CHANGED") then
		loco.urWay = nil
	end
    if (event == "SUPER_TRACKING_CHANGED" or event == "QUEST_LOG_UPDATE" or
		event == "ZONE_CHANGED_NEW_AREA" or event == "QUEST_LOG_CRITERIA_UPDATE" or
		event == "QUEST_LOG_UPDATE") and trackType[loco.idx] == "quests" then
		if L_DBG >= 2 or L_DBF["UpdateTrack"] then
			Ramble("Tracking Changed.")
		end

		UpdateTrack()
	elseif event == "SUPER_TRACKING_CHANGED" then
		loco.urWay = nil
		UpdateTrack()
		print("sTChanged: "..tostring(arg1).." :: "..tostring(arg2))
	elseif event == "QUEST_ACCEPTED" then
		if arg1 then
			local qLink = GetQuestLink(arg1)
			print("Quest Accepted: "..qLink)
		end
	elseif event == "USER_WAYPOINT_UPDATED" then
		print("wpUpdate: "..tostring(arg1).." :: "..tostring(arg2))
		--if not loco.pinOvr then
			--loco.urWay = nil
			SetUserWaypoint()
			UpdateTrack()
		--else
			----loco.pinOvr = nil
		--end
	elseif event == "WORLD_MAP_OPEN" then
		if pokeMap then
			WorldMapFrame:SetShown(false)
			pokeMap = nil
		end
	elseif event == "ZONE_CHANGED_NEW_AREA" or event == "QUEST_LOG_CRITERIA_UPDATE" or event == "QUEST_LOG_UPDATE" then
		dbgLatch = true
		UpdateTrack()
		ToggleTracking("start")
	elseif event == "PLAYER_ENTERING_WORLD" then
		loco = {}
		loco.idx = 1
		if Lunacy[playerKey] then
			if Lunacy[playerKey].loco then
				loco = Lunacy[playerKey].loco
			end
		end
		loco.idx = loco.idx or 1
		loco.urWay = nil
		PokeMap()
    end
end)

local function GetCenterScreenPoint()
    local centerX, centerY = WorldFrame:GetCenter()
    local scale = UIParent:GetEffectiveScale() or 1
    return centerX / scale, centerY / scale
end

--[[

function GetNavXY()
    if not Lunacy.NavFrame then return false end

    local navX, navY = Lunacy.NavFrame:GetCenter()
	local centerScreenX, centerScreenY = GetCenterScreenPoint()
    local posX = navX - centerScreenX
    local posY = navY - centerScreenY
    local denominator = sqrt(self.savedMajorAxisSquared * posY * posY + self.savedMinorAxisSquared * posX * posX)

    if denominator == 0 then return false end

    local ratio = self.savedAxesMultiplied / denominator
    self.targetPositionX = posX * ratio
    self.targetPositionY = posY * ratio

    -- Initialize position on first run to prevent origin snap
    if self.currentPositionX == 0 and self.currentPositionY == 0 then
        self.currentPositionX = self.targetPositionX
        self.currentPositionY = self.targetPositionY
    else
        -- Interpolate
        self.currentPositionX = self.currentPositionX + (self.targetPositionX - self.currentPositionX) / 2
        self.currentPositionY = self.currentPositionY + (self.targetPositionY - self.currentPositionY) / 2
    end

    self:ClearAllPoints()
    self:SetPoint("CENTER", WorldFrame, "CENTER", self.currentPositionX, self.currentPositionY)

    local deltaX = self.targetPositionX - self.currentPositionX
    local deltaY = self.targetPositionY - self.currentPositionY
    return (abs(deltaX) > POSITION_THRESHOLD) or (abs(deltaY) > POSITION_THRESHOLD)
end

]]--

function SetPlayerFacing()
	local pF = GetPlayerFacing()
	if loco.inQBlob == true then
		loco.sPn = loco.sPn or 0
		loco.sPn = loco.sPn + 5
		if loco.sPn > 720 then
			loco.sPn = 0
		end
		pF = loco.sPn
	end
	if pF then
		local angle = (rad(135) - pF) / 0.017453
		local s,c = sin(angle) * sqrt(0.5) * 1.0, cos(angle) * sqrt(0.5) * 1.0
		LunacyFrameA.texture:SetTexCoord(0.5-s,0.5+c,0.5+c,0.5+s,0.5-c,0.5-s,0.5+s,0.5-c)
	end
end

function GetLoco(key)
	return tostring(loco[key])
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
	local urWay = C_Map.GetUserWaypoint()
	local hasWay = {}
	
	if WaypointUIAPI then
		hasWay = WaypointUIAPI.Navigation.GetUserNavigation()
	end
	if hasWay.name then
		pWay = {}
		pWay.target = hasWay.name
		pWay.map = hasWay.mapID
		pWay.x = hasWay.x
		pWay.y = hasWay.y
		loco.destCheck = true
		loco.urWay = true
		if L_DBG >= 3 or L_DBF["UpdateTrack"] then
			Ramble(colorMe("WP-Set: ", "Liserian")..colorMe(tostring(loco.urWay), "LightGoldenrod"), colorMe("[Waypoint] ", "Veronica"))
		end
		C_SuperTrack.SetSuperTrackedUserWaypoint(true)
	elseif urWay and loco.pinOvr then
		loco.pinOvr = nil
		pWay.x = urWay.position.x
		pWay.y = urWay.position.y
		C_SuperTrack.SetSuperTrackedUserWaypoint(true)
	elseif urWay then
		pWay = {}
		pWay.target = "<Map^Pin>"
		pWay.map = urWay.uiMapID
		pWay.x = urWay.position.x
		pWay.y = urWay.position.y
		loco.destCheck = true
		loco.urWay = true
		if L_DBG >= 3 or L_DBF["UpdateTrack"] then
			Ramble(colorMe("Set: ", "Turquoise")..colorMe(tostring(loco.urWay), "BrightMint"), colorMe("[Waypoint] ", "Veronica"))
		end
		C_SuperTrack.SetSuperTrackedUserWaypoint(true)
	else
		loco.urWay = nil
		loco.pinOvr = nil
		if L_DBG >= 3 or L_DBF["UpdateTrack"] then
			Ramble(colorMe("Fail: ", "BrickRed")..colorMe(tostring(loco.urWay), "Teal"), colorMe("[Waypoint] ", "Veronica"))
		end
		C_SuperTrack.SetSuperTrackedUserWaypoint(false)
	end
end

function SetTrack(mapID,x,y,desc,optDesc)
	if C_Map.CanSetUserWaypointOnMap(mapID) then
		local pos = CreateVector2D(x / 100, y / 100)
		local mapPoint = UiMapPoint.CreateFromVector2D(mapID, pos)
		loco.pinOvr = true
		loco.objTxt = desc
		pWay = {}
		pWay.target = desc
		pWay.map = mapID
		pWay.x = x
		pWay.y = y
		if optDesc then
			if L_DBG >= 2 or L_DBF["SetTrack"] then
				Ramble(colorMe(tostring(optDesc), "FluorescentBlue"), colorMe("[WhereIs] ", "SignalYellow")..colorMe("optDesc: ", "Pansy"))
			end
			loco.optDesc = optDesc
		end
		if L_DBG >= 2 or L_DBF["SetTrack"] then
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
	loco.trMap, loco.trX, loco.trY, loco.objTxt, loco.trWX, loco.trWY, loco.trPntMap = 0,0,0,0,0,0,0
	if Lunacy.destIcon then
		--pins:RemoveMinimapIcon("LunacyIcon", Lunacy.destIcon)
		--pins:RemoveWorldMapIcon("LunacyMapIcon", destIcon)
	end
	if trackType[loco.idx] == "alpaca" then
		loco.lock = false
	end
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
	loco.pX,loco.pY,loco.pMap,loco.pWX,loco.pWY,loco.mapType,loco.pPntMap = GetPlayerPosition()
	if L_DBG >= 2 or L_DBF["UpdateTrack"] then
		Ramble(colorMe("   ~Update Track~", "Tomato"), colorMe("[Quest] ", "Green"))
	end
	--ToggleWorldMap()
	--ToggleWorldMap()
	
	if not C_Map.GetUserWaypoint() and pWay then
		if pWay.x then
			if L_DBG >= 2 or L_DBF["UpdateTrack"] then
				Ramble("|cffff0000Clear User Waypoint.|r")
			end
			--print("|cffff0000Clear User Waypoint.|r")
			loco.destCheck = nil
			forceArival = nil
			loco.urWay = nil
			loco.optDesc = nil
			pWay = nil
			--WPUI = nil
			--trX = nil
			C_Map.ClearUserWaypoint()
			UpdateCompass()
			--UpdateTrack()
		end
	end
	local stqID = C_SuperTrack.GetSuperTrackedQuestID()
	if stqID and not pWay then
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
	elseif not pWay then
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
	
	if pWay then
		if L_DBG >= 2 or L_DBF["UpdateTrack"] then
			Ramble(colorMe("true", "LemonChiffon"), colorMe("[Quest] ", "Green")..colorMe("pWay: ", "Raspberry"))
		end
		Lunacy.Text1 = pWay.target
		loco.trMap, loco.trX, loco.trY, loco.objTxt = pWay.map, pWay.x, pWay.y, pWay.target
		loco.trPntMap = ParentMap(pWay.map)
		loco.distance = HBD:GetWorldDistance(loco.pPntMap, loco.pWX, loco.pWY, loco.trWX, loco.trWY) or 0
		loco.distance = math.abs(loco.distance)
		if loco.trMap then
			local info = C_Map.GetMapInfo(loco.trMap)
			loco.tarZone = info.name
			Lunacy.Text3 = loco.tarZone
		else
			Lunacy.Text3 = ""
		end
		Lunacy.Text5 = loco.optDesc or ""
		UpdateTrackerText()
	elseif trackType[loco.idx] == "quests" then
		if L_DBG >= 2 or L_DBF["UpdateTrack"] then
			Ramble(colorMe("quests", "Trombone"), colorMe("[Quest] ", "Green")..colorMe("trackType: ", "CarolinaBlue"))
		end
		if loco.trackChange then
			loco.trMap, loco.trX, loco.trY, loco.objTxt, loco.stqID, loco.trPntMap, complete, curObj = Lunacy_GetTrackedQuest()
			loco.trackChange = nil
			if L_DBG >= 3 or L_DBF["UpdateTrack"] then
				Ramble(tostring(wayDesc), colorMe("[Quest]", "Green")..colorMe(" WD: ", "BrightMint"))
			end
			if wayDesc then
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
	elseif trackType[loco.idx] == "exploration" and loco.pMap then
		loco.trMap, loco.trX, loco.trY, loco.objTxt = Lunacy_GetNextExplore(loco.pX, loco.pY, loco.pMap)
	elseif trackType[loco.idx] == "elders" then
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
end

function Lunacy_Track()
	if loco.qUpTrk then
		if math.abs(GetTimePreciseSec() - loco.qUpTrk) > 2 then
			UpdateTrack()
			loco.qUpTrk = nil
		end
	end
	loco.pX,loco.pY,loco.pMap,loco.pWX,loco.pWY,loco.mapType,loco.pPntMap = GetPlayerPosition()
	--loco.trStatus = true
	if not loco.pX then
		return --porting or out of bounds in some way
	end
	
	loco.distance = C_Navigation.GetDistance() or 0
	if loco.inQBlob then
		loco.distance = 0
	end
	
	if not loco.distance then
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
				Lunacy.Text2 = "|cffff0000 "..tostring(dis).."|r"
			else
				Lunacy.Text2 = "|cffffff00 "..tostring(dis).."|r"
			end
		else
			Lunacy.Text2 = "|cff00ff00 "..tostring(dis).."|r"
		end
		
		if (loco.distance < destRadius and loco.destCheck == true) or forceArrival then
			loco.destCheck = nil
			forceArival = nil
			loco.urWay = nil
			pWay = nil
			loco.trX = nil
			loco.pinOvr = nil
			C_Map.ClearUserWaypoint()
			C_SuperTrack.SetSuperTrackedUserWaypoint(false)
			print("|cff00ffffclear user waypoint|r")
			if trackType[loco.idx] == "elders" then
				Lunacy[playerKey].elders[loco.elderCont] = Lunacy[playerKey].elders[loco.elderCont] or {}
				Lunacy[playerKey].elders[loco.elderCont][loco.elder] = true
			end
			UpdateCompass()
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

	loco.angle = loco.angle - loco.pF
	loco.angle = loco.angle - math.rad(45)
	UpdateTrackerText()
	local s,c = math.sin(loco.angle) * math.sqrt(0.5), math.cos(loco.angle) * math.sqrt(0.5)
	CompArrow.texture:SetTexCoord(0.5-s,0.5+c,0.5+c,0.5+s,0.5-c,0.5-s,0.5+s,0.5-c)
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

		local title = "......"
		if qIdx then
			title = C_QuestLog.GetInfo(qIdx).title
		end
		
		if not title then
			title = C_TaskQuest.GetQuestInfoByQuestID(stqID)
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
	avg = 0
	for i,v in ipairs(distTab) do
		avg = avg + v
	end
	dis = avg / spdTsz
	
	
	
	if dis then
		dis = dis * 0.39
		if dis >= 0 and dis < 125 then
			local mph = (dis/1760)/diffTime*3600
			mph = floor(mph*1000)/1000
			if mph < 1 then
				Lunacy.Text4 = "<|cff123456"..string.format("%.2f mph", mph).."|r>"
			elseif mph < 3 then
				Lunacy.Text4 = "<|cff116611"..string.format("%.2f mph", mph).."|r>"
			elseif mph < 7 then
				Lunacy.Text4 = "<|cff690033"..string.format("%.2f mph", mph).."|r>"
			elseif mph < 19 then
				Lunacy.Text4 = "<|cffaaaaaa"..string.format("%.2f mph", mph).."|r>"
			elseif mph < 29 then
				Lunacy.Text4 = "<|cff33cc33"..string.format("%.2f mph", mph).."|r>"
			elseif mph < 44 then
				Lunacy.Text4 = "<|cffcccc00"..string.format("%.2f mph", mph).."|r>"
			elseif mph < 57 then
				Lunacy.Text4 = "<|cffcc5500"..string.format("%.2f mph", mph).."|r>"
			else
				Lunacy.Text4 = "<|cffff0000"..string.format("%.2f mph", mph).."|r>"
			end
			--Lunacy.Text4 = "<"..tostring(mph)..">"
			Lunacy[playerKey].totalDistance = Lunacy[playerKey].totalDistance + dis
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

