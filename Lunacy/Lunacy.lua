--Lunacy
local HBD = LibStub("HereBeDragons-2.0")
--local pins = LibStub("HereBeDragons-Pins-2.0")

--local dragons = LibStub("HereBeDragons-2.0")

local addonName, addon = ...
local prepTag = "|cff9e7bb5[Lunacy]|r "

Lunacy = addon
Lunacy.version = "1.0.11"
L_DBG = 1
L_DBF = {}
playerKey = ""
playerName = ""

local gatherActions = {
	[265837] = "Mining",
	[265819] = "Herb Gathering",
}

local EventFrame = CreateFrame("Frame", "EventFrame")
EventFrame:RegisterEvent("PLAYER_LOGIN")
EventFrame:RegisterEvent("CHAT_MSG_GUILD")
EventFrame:RegisterEvent("CHAT_MSG_PARTY")
EventFrame:RegisterEvent("ADDON_LOADED")
EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
EventFrame:RegisterEvent("PLAYER_LOGOUT")
EventFrame:RegisterEvent("VARIABLES_LOADED")
EventFrame:RegisterEvent("UI_INFO_MESSAGE")
EventFrame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
EventFrame:RegisterEvent("UNIT_SPELLCAST_SENT")
EventFrame:RegisterEvent("CHAT_MSG_LOOT")

local function myChatFilter(self, event, msg, author, ...)
  if msg == "reload" then
		return false, gsub(msg, "reload", "/reload"), author, ...
	else
		return false, msg, author, ...
  end
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", myChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", myChatFilter)

function colorMe(msg,clr)
	local coLor = Color(clr)
	if not coLor then
		coLor = "ffffff"
	end
	coLor = coLor..msg.."|r"
	return coLor
end

function Ramble(msg,tag)
	if tag == false then
		--no tag
	elseif not tag then
		msg = prepTag..msg
	elseif type(tag) == "string" and type(msg) == "string" then
		msg = tag..msg
	else
		--print(tostring(msg))
	end
	print(msg)
end

local function DumpCurrency(txt, chn)
	local link, info, msg
	for i=1, C_CurrencyInfo.GetCurrencyListSize() do
		link = C_CurrencyInfo.GetCurrencyListLink(i)
		if link then
			info = C_CurrencyInfo.GetCurrencyInfoFromLink(link)
			if string.match(string.lower(info.name), string.lower(txt)) then
				msg = link .. " |cffffffffX" .. tostring(info.quantity) .. "|r"
				msg = link .. " X" .. tostring(info.quantity) .. "."
				SendChatMessage(msg, chn)
			end
		end
	end
end

local function lOcO(key,chn)
	local loco = GetLoco(key)
	if loco then
		SendChatMessage(loco, chn)
	end
end

local function setColor(clr)
	SetColorGroup(clr)
end

local dbgLvls = {
	["-1"] = "Smoke",
	["0"] = "Shamrock",
	["1"] = "Chartreuse", -- Reuse the Chart
	["2"] = "Green",
	["3"] = "SulfurYellow",
	["4"] = "NeonYellow",
	["5"] = "LemonYellow",
	["6"] = "SuppleOrange",
	["7"] = "Tomato",
	["8"] = "Scarlet",
	["9"] = "CandyApple",
	["10"] = "Black",
}

local function setDBG(val)
	val = tonumber(val)
	if val and val > -2 and val < 11 then 
		Luna[playerKey].DBG = val
		L_DBG = val
		Ramble(colorMe("DBG set to level ", "FluorescentBlue")..colorMe(tostring(L_DBG),
		dbgLvls[tostring(L_DBG)])..colorMe(".", "FluorescentBlue"), colorMe("[DBG] ", "CandyApple"))
	end
end

local function lUnA(txt, chn)
	local func = assert(loadstring("return " .. txt))
	--local env = {emo=emo, string=string, tostring=tostring, tonumber=tonumber, playerName=playerName}
	--setfenv(func, env)
	setfenv(func, _G)
	local eval, ret = pcall(func)
	if (not eval) then
		SendChatMessage("error :: " .. ret, chn)
	elseif type(ret) == "table" then
		ret = table_to_string({ret}, " :: ")
		SendChatMessage("~Mother Moon says:~> " .. tostring(ret), chn)
	else
		SendChatMessage("~Mother Moon says:~> " .. tostring(ret), chn)
	end
end

local function ChatHandler(txt, chn, sender)
	if string.sub(txt, 1, 5) == "loco " then
		txt = string.gsub(txt, "loco ", "")
		lOcO(txt, chn)
	elseif string.sub(txt, 1, 5) == "luna " then
		txt = string.gsub(txt, "luna ", "")
		lUnA(txt, chn)
	elseif string.sub(txt, 1, 6) == "color " then
		txt = string.gsub(txt, "color ", "")
		setColor(txt)
	elseif string.sub(txt, 1, 4) == "dbg " then
		txt = string.gsub(txt, "dbg ", "")
		setDBG(txt)
	elseif string.sub(txt, 1, 5) == "find " or string.sub(txt, 1, 8) == "whereis " or
			string.sub(txt, 1, 9) == "where is " or string.sub(txt, 1, 7) == "locate " then
		txt = string.gsub(txt, "where is ", "")
		txt = string.gsub(txt, "whereis ", "")
		txt = string.gsub(txt, "find ", "")
		txt = string.gsub(txt, "locate ", "")
		WhereIs(txt)
	elseif txt == "map" or txt == "coords" then
		local x,y,map = GetMapCoords()
		local loCat = C_Map.GetMapInfo(map)
		loCat = loCat.name or ""
		
		if x then
			x=floor(x*10000)/100
			y=floor(y*10000)/100
		end
		
		if loCat then
			SendChatMessage("["..loCat.."]", chn)
		end
		SendChatMessage(tostring(x)..", "..tostring(y).." ("..tostring(map)..")", chn)
		
	end
end

function ClearGathersZone()
	Gathers = Gathers or {}
	local zoneName = GetZoneText()
	
	if Gathers[zoneName] then
		Gathers[zoneName] = nil
		return "Gathers cleared for "..tostring(zoneName).."."
	end
end

local function RegisterGather(itemType, itemSubType, amt, itemName)
	print("|cffaa00ddType: |r"..tostring(itemType))
	print("|cff11aa11Type: |r"..tostring(itemSubType))
	print("|cffddbb33amt: |r"..tostring(amt))
	--itemName = gsub(itemName, " Ore", "")
	print("|cffddff11Item: |r"..tostring(itemName))
	--print("|cff117711Gather Type: |r"..tostring(gatherType))
	local pX,pY,pMap = GetPlayerPosition()
	pX = pX or 0
	pY = pY or 0
	pX = math.floor(pX * 10000) / 10000
	pY = math.floor(pY * 10000) / 10000
	pX = string.format("%.4f", pX)
	pY = string.format("%.4f", pY)
	local locStr = tostring(pX).."-"..tostring(pY)
	amt = amt or 1
	
	local zoneName = GetZoneText()
	Gathers = Gathers or {}
	Gathers[zoneName] = Gathers[zoneName] or {}
	Gathers[zoneName][itemSubType] = Gathers[zoneName][itemSubType] or {}
	Gathers[zoneName][itemSubType][itemName] = Gathers[zoneName][itemSubType][itemName] or {}
	Gathers[zoneName][itemSubType][itemName][locStr] = Gathers[zoneName][itemSubType][itemName][locStr] or 0
	Gathers[zoneName][itemSubType][itemName][locStr] = Gathers[zoneName][itemSubType][itemName][locStr] + tonumber(amt)
end

local function Lunacy_RecordExplore(arg2)
	local str = string.gsub(arg2, "Discovered: ", "", 1)
	str = remspc(str)
	local x, y, pMapID = GetPlayerPosition()
	x, y = HBD:GetPlayerZonePosition(true)
	if pMapID and x and y then
		Lunacy[playerKey].explored = Lunacy[playerKey].explored or {}
		Lunacy[playerKey].explored[pMapID] = Lunacy[playerKey].explored[pMapID] or {}
		Lunacy[playerKey].explored[pMapID][str] = {x, y}
	end
end

EventFrame:SetScript("OnEvent", function(self, event, ...)
	local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8 = ...
    if event == "PLAYER_LOGIN" then
		Ramble(colorMe("(v"..Lunacy.version..") ~Sun shakes your shadows~", "Sunflower"))
        self:UnregisterEvent("PLAYER_LOGIN")
	elseif event == "CHAT_MSG_GUILD" then
		local text, sender = ...
		ChatHandler(text, "GUILD", sender)
	elseif event == "CHAT_MSG_PARTY" then
		local text, sender = ...
		ChatHandler(text, "PARTY", sender)
	elseif event == "ADDON_LOADED" and arg1 == "Lunacy" then
		Luna = Luna or {}
		Gathers = Gathers or {}
		popClrTbl()
	elseif event == "PLAYER_LOGOUT" then
		SaveLoco()
		Luna[playerKey] = Lunacy[playerKey]
		Luna[playerKey].DBG = L_DBG
		Luna[playerKey].DBF = L_DBF
	elseif event == "UNIT_SPELLCAST_SENT" then
		if arg1 ~= "player" then return end
		if not arg2 then return end
		--local action = gatherActions[arg4]
		--if action then
			--RegisterGather(gatherActions[arg4])
		--end
	elseif event == "CHAT_MSG_LOOT" then
		if arg5 == playerKey or arg2 == playerKey then
			local tmp = arg1
			--local itemString = string.match(tmp, "item[%-?%d:]+")
			local amt = tostring(tmp)
			if not string.find(tmp, "You receive loot:") then return; end 
			amt = string.match(tmp, "x(%d+)")
			local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType = GetItemInfo(tmp)
			print("|cffaa00ddType: |r"..tostring(itemType))
			print("|cff11aa11Type: |r"..tostring(itemSubType))
			print("|cffddbb33amt: |r"..tostring(amt))
			--itemName = gsub(itemName, " Ore", "")
			print("|cffddff11Item: |r"..tostring(itemName))
			RegisterGather(itemType, itemSubType, amt, itemName)
		end
	elseif event == "UI_INFO_MESSAGE" then
		print(tostring(arg1))
		--288 criteria update (loot?)
		--289 criteria update
		--286 objective complete
		--372 discovered area
		--print(arg1)
		--print(arg2)
		--print("-----------")
		if arg1 == 408 then --378 then
			--LunacyDB[Lunacy.playerKey]["exploration"]
			Lunacy_RecordExplore(arg2)
			print("Explored: " .. tostring(arg2))
		end
	elseif event == "VARIABLES_LOADED" then	
		Lunacy.loaded = true
	elseif event == "PLAYER_ENTERING_WORLD" then
		local pn, rlm = UnitName("player")
		if not rlm then
			rlm = GetRealmName()
		end
		if pn then
			playerKey = pn .. "-" .. rlm
			playerName = pn
			Luna = Luna or {}
			Luna[playerKey] = Luna[playerKey] or {}
			Lunacy[playerKey] = Luna[playerKey] or {}
			Lunacy[playerKey].pirate = Luna[playerKey].pirate or false
			Lunacy[playerKey].totalDistance = Lunacy[playerKey].totalDistance or 0
			Lunacy[playerKey].lastPos = Lunacy[playerKey].lastPos or {}
			Lunacy[playerKey].lastPos.X = Lunacy[playerKey].lastPos.X or 0
			Lunacy[playerKey].lastPos.Y = Lunacy[playerKey].lastPos.Y or 0
			Lunacy[playerKey].lastPos.Map = Lunacy[playerKey].lastPos.Map or 0
			
			L_DBG = Luna[playerKey].DBG or 4
			L_DBF = Luna[playerKey].DBF or {}
			
			coDex = coDex or {}
	
			print("|cffff00ff[Lunacy]|r |cff00ffffWelcome " .. playerName .. "!" .. "|r")
			Lunacy.playerStatus = "loaded"
		end
    end
end)

