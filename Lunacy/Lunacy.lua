--Lunacy
local HBD = LibStub("HereBeDragons-2.0")
--local pins = LibStub("HereBeDragons-Pins-2.0")

--local dragons = LibStub("HereBeDragons-2.0")

local addonName, addon = ...
local prepTag = "|cff9e7bb5[Lunacy]|r "

Lunacy = addon
Lunacy.version = "1.1.43"
L_DBG = 1
L_DBF = {}
playerKey = ""
playerName = ""

local gatherActions = {
	[265837] = "Mining",
	[265819] = "Herb Gathering",
}

local validGatherType = {
	["Metal & Stone"] = true,
	["Herb"] = true,
	["Currency"] = true,
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
EventFrame:RegisterEvent("CHAT_MSG_MONEY")
EventFrame:RegisterEvent("CHAT_MSG_CURRENCY")
EventFrame:RegisterEvent("FACTION_STANDING_CHANGED")
--EventFrame:RegisterEvent("PLAYER_MONEY")

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
	if not msg then
		msg = tostring(msg)
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
	local loco, farm = GetLoco(key)
	if loco then
		if not chn then
			print(loco)
			if farm then
				print(farm)
			end
		else
			if farm then
				SendChatMessage(farm, chn)
				--print(farm)
			else
				SendChatMessage(loco, chn)
			end
			--SendChatMessage(loco, chn)
		end
	end
end

local function lOcOSet(txt,chn)
	local cC = ChattyChop(txt)
	local keyA,keyB,keyC,keyD,val,loco,serf
	if cC[1] then
		keyA = cC[1]
		txt = string.gsub(txt, keyA..".","")
		txt = string.gsub(txt, keyA.." ","")
		
		serf = string.find(txt,"=")
		if serf and cC[2] and string.find(txt, cC[2]) < serf then
			keyB = cC[2]
			txt = string.gsub(txt, keyB..".","")
			txt = string.gsub(txt, keyB.." ","")
			serf = string.find(txt,"=")
		end
		if serf and cC[3] and string.find(txt, cC[3]) < serf then
			keyC = cC[3]
			txt = string.gsub(txt, keyC..".","")
			txt = string.gsub(txt, keyC.." ","")
			serf = string.find(txt,"=")
		end
		if serf and cC[4] and string.find(txt, cC[4]) < serf then
			keyD = cC[4]
			txt = string.gsub(txt, keyD..".","")
			txt = string.gsub(txt, keyD.." ","")
			serf = string.find(txt,"=")
		end
		local spcs = string.match(txt, "(%s+)= ")
		if spcs then
			txt = string.gsub(txt, spcs,"")
		end
		txt = string.gsub(txt, "= ","")
		txt = string.gsub(txt, "=","")
		txt = string.gsub(txt, "\"","")
		val = txt
	else
		print("No Chat")
	end
	loco = SetLoco(keyA,val,keyB,keyC,keyD)
	print(keyA)
	print(keyB)
	print(keyC)
	print(val)
	if loco then
		if not chn then
			print(loco)
		else
			SendChatMessage(loco, chn)
		end
	end
end

local function grimSet(txt)
	if txt == "Lock" then
		lOcOSet("grimLock = true", chn)
	elseif txt == "Unlock" then
		lOcOSet("grimLock = nil", chn)
	elseif grimoire[txt] then
		initLineSet(txt)
	end
end

local function setColor(clr)
	if clr == "lock" then
		ColorLock(true)
	elseif clr == "unlock" then
		ColorLock(false)
	else
		SetColorGroup(clr)
	end
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
	setfenv(func, _G)
	local eval, ret = pcall(func)
	if (not eval) then
		SendChatMessage("error :: " .. ret, chn)
	elseif type(ret) == "table" then
		ret = table_to_string({ret}, " :: ")
	end
	if not chn then
		print("~Mother Moon says:~> " .. tostring(ret))
	else
		SendChatMessage("~Mother Moon says:~> " .. tostring(ret), chn)
	end
end

function ChattyChop(chat)
	--local cHAIn = {}
	
	local salad = {}
	local cnt = 0
	local cm = 0
	local s = string.match(chat, "(%a+)")
	local t = string.match(chat, "([%a][%w']*[%w]+)")
	local u = string.match(chat, "(%a+),")
	if s ~= t then
		if s ~= "a" and s ~= "i" and s ~= "q" then
			s = t
		end
	end
		
	if s == u and s and u then
		cm = 1
	end
	
	cHOPs = cHOPs or 0
	
	local c,pr,fl,fw
	while s and cnt < 377 do
		salad[#salad+1] = s
		cHOPs = cHOPs + 1
		--dbgMsg("ChattyChop:  word :: " .. tostring(s), 1)
		c = string.lower(s)
		pr = nil
		fl = c
		chat = string.gsub(chat, s, "", 1)
		s = string.match(chat, "(%a+)")
		t = string.match(chat, "([%a][%w']*[%w]+)")
		u = string.match(chat, "(%a+), ")
		if s ~= "a" and s ~= "i" and s ~= "q" then
			if s ~= "a" then
				s = t
			end
		end
		
		cm = 0
		if s == u and s and u then
			cm = 1
			--dbgMsg("ChattyChop:  comma✓ :: " .. tostring(s), 1)
		end
		cnt = cnt + 1
	end
	Luna.salad = salad
	--if opt then
		--lockChain = nil
	--end
	--func_time["ChattyChop"].END = os.time()
	--func_track("ChattyChop")
	return salad
end

function tossSalad()
	local s = ""
	if type(Luna.salad) == "table" then
		for i,v in pairs(Luna.salad) do
			print(v)
			s = s..tostring(i)..":"..tostring(v)..", "
		end
	end
	return s
end

local function ChatHandler(txt, chn, sender)
	if string.sub(txt, 1, 9) == "loco set " then
		txt = string.gsub(txt, "loco set ", "")
		lOcOSet(txt, chn)
	elseif string.sub(txt, 1, 5) == "loco " then
		txt = string.gsub(txt, "loco ", "")
		lOcO(txt, chn)
	elseif string.sub(txt,1,5) == "grim " then
		txt = string.gsub(txt, "grim ", "")
		--txt = txt:sub(1,1):upper()..txt:sub(2,#txt) --Capit
		grimSet(caPit(txt))
	elseif string.sub(txt, 1, 4) == "rec " or string.sub(txt, 1, 7) == "record " then
		txt = string.gsub(txt, "record ", "")
		txt = string.gsub(txt, "rec ", "")
		rECORd(txt)
	elseif string.sub(txt, 1, 7) == "gather " then
		txt = string.gsub(txt, "gather ", "")
		gATHEr(txt)
	elseif string.sub(txt, 1, 5) == "luna " then
		txt = string.gsub(txt, "luna ", "")
		lUnA(txt, chn)
	elseif txt == "mph" or sender == "mph" then
		Luna.phPref = "mph"
		Ramble(colorMe("Speed set to mph.)", "FluorescentBlue"))
	elseif txt == "kph" or sender == "kph" then
		Luna.phPref = "kph"
		Ramble(colorMe("Speed set to kph.)", "FluorescentBlue"))
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
		if txt == "fp" or txt == "flight master" or txt == "flight point" then
			print("GetFlightPoints")
			GetFlightMaster()
		else
			WhereIs(txt)
		end
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
	if not validGatherType[itemSubType] then
		if L_DBG >= 4 or L_DBF["Gathers"] then
			Ramble(colorMe("Invalid Gather Type: ", "Red")..colorMe(tostring(itemSubType), "Yellow"), colorMe("[RegisterGather] ", "Chartreuse"))
		end
		--return
	end
	if itemName == "Voidlight Marl" then
		FlashMe("Marl")
	elseif itemName == "Luminous Dust" then
		FlashMe("Skipper")
	elseif itemSubType == "Herb" then
		FlashMe("Spring")
	elseif itemSubType == "Metal & Stone" then
		FlashMe("Cobalt")
	elseif itemName == "Latent Arcana" then
		FlashMe("Feldgrau")
	elseif itemType == "Currency" then --keep at end
		FlashMe("AdmiralBlue")
	elseif itemType == "Tradeskill" then --keep at end
		FlashMe("Buff")
	end
	if L_DBG >= 2 or L_DBF["Gathers"] then
		print(colorMe("........•........•........•........•.", "White")) -- 9*2*((9*4)+1)
		Ramble(colorMe("\|Item\| ", "BrightMint")..colorMe(tostring(itemName), "CarolinaBlue")..colorMe(" x", "Red")..colorMe(tostring(amt or 1), "Lime"), colorMe("[RegisterGather] ", "Chartreuse"))
		Ramble(colorMe("\|Category\| ", "Purple")..colorMe(tostring(itemType), "Lime"), colorMe("[RegisterGather] ", "Chartreuse"))
		Ramble(colorMe("\|*Type*\| ", "Shamrock")..colorMe(tostring(itemSubType), "Yellow"), colorMe("[RegisterGather] ", "Chartreuse"))
	end

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

function mOOdleVel(clr, vex)
	local lvl = 0.37
	if vex then
		lvl = lvl + vex
	end
	local r,g,b = hex2rgb(GetHexColor(clr))
	r = math.min(math.floor((mOOd.r + r) * 0.37), 255)
	g = math.min(math.floor((mOOd.g + g) * 0.37), 255)
	b = math.min(math.floor((mOOd.b + b) * 0.37), 255)

	mOOd.r = r
	mOOd.g = g
	mOOd.b = b
	local vcr, vcg, vcb = CompArrow.texture:GetVertexColor()
	
	--CompArrow.texture:SetVertexColor(r, g, b, 1)
	--CompArrow.texture:SetVertexColor(0.77, 0.77, 0.77, 1)
	CompArrow.texture:SetVertexColor(r/255, g/255, b/255, 1)
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
	elseif event == "FACTION_STANDING_CHANGED" then
		Ramble(colorMe(" Îarg1Î ", "Mulberry")..colorMe(arg1, "Alabaster"), colorMe("[FACTION_STANDING_CHANGED]", "Mustard"))
	elseif event == "PLAYER_LOGOUT" then
		SaveLoco()
		Luna[playerKey] = Lunacy[playerKey]
		Luna[playerKey].DBG = L_DBG
		Luna[playerKey].DBF = L_DBF
		Lunacy[playerKey].mood = mOOd
	elseif event == "UNIT_SPELLCAST_SENT" then
		if arg1 ~= "player" then return end
		if not arg2 then return end
		--local action = gatherActions[arg4]
		--if action then
			--RegisterGather(gatherActions[arg4])
		--end
	elseif event == "CHAT_MSG_MONEY" then
	
	elseif event == "CURRENCY_DISPLAY_UPDATE" then
		print("CURRENCY_DISPLAY_UPDATE")
	elseif event == "CHAT_MSG_CURRENCY" then
		local eT = arg1 or arg2
		--print("CHAT_MSG_CURRENCY")
		--print(#arg1)
		--print(#arg2)
	--	print(#arg3)
		--print(eT)
		--print(type(eT))
		--print(#eT)
		--print(eT:sub(5,8))
		--local itemString = string.match(tmp, "item[%-?%d:]+")
		--You receive currency: [Voidlight Marl]x1
		local cuRRy = eT:sub(1,#eT)
		local amt = string.match(cuRRy, "x(%d+)")
		cuRRy = string.gsub(cuRRy,"You receive currency: ", "")
		cuRRy = string.gsub(cuRRy,"x(%d+)", "")
		local iFo = C_Item.GetItemIDForItemInfo(cuRRy)
		--print(iFo)
		
		if not amt then
			Ramble(colorMe(" ~You got the BOOTY!~ ", "Sunflower"), colorMe("[Booty] ", "Mulberry"))
			--Ramble(eT, colorMe("[Booty] ", "Bronze"))
			--print("CHAT_MSG_LOOT: You got the BOOTY!")
			return
		end 
		--amt = string.match(amt, "x(%d+)")
		print(amt)
		local info = C_CurrencyInfo.GetCurrencyInfoFromLink(cuRRy) or {}
		--local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType = C_Item.GetItemInfo(cuRRy)
		Ramble(colorMe(" ~You got the BOOTY!~ ", "Sunflower"), colorMe("[Booty] ", "Bronze"))
		Ramble(colorMe(info.name, "Yellow"), colorMe("[Booty] ItemName: ", "Bronze"))
		print(cuRRy)
		--if itemSubType == "Herb" then
			--mOOdleVel("Shamrock")
		--elseif itemSubType == "Metal & Stone" then
			--mOOdleVel("Bronze")
		--else
			
		--end
		if info.name then
			RegisterGather("Currency", "Currency", amt, info.name)
		end
	elseif event == "CHAT_MSG_LOOT" or event == "CHAT_MSG_CURRENCY" then
		--print("CHAT_MSG_LOOT: arg1 :: "..tostring(arg1))
		--print("CHAT_MSG_LOOT: arg2 :: "..tostring(arg2))
		--print("CHAT_MSG_LOOT: arg3 :: "..tostring(arg3))
		--print("CHAT_MSG_LOOT: arg4 :: "..tostring(arg4))
		--print("CHAT_MSG_LOOT: arg5 :: "..tostring(arg5))
		if arg5 == playerKey or arg2 == playerKey then
			local tmp = arg1
			--local itemString = string.match(tmp, "item[%-?%d:]+")
			local amt = tostring(tmp)
			if not string.find(tmp, "You receive loot:") and not string.find(tmp, "You receive currency:") then
				Ramble(colorMe(" ~You got the BOOTY!~ ", "Sunflower"), colorMe("[Booty] ", "Mulberry"))
				Ramble(tostring(tmp), colorMe("[Booty] ", "Mulberry"))
				
				--print("CHAT_MSG_LOOT: You got the BOOTY!")
				return
			end 
			amt = string.match(tmp, "x(%d+)")
			local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType = C_Item.GetItemInfo(tmp)
			if itemSubType == "Herb" then
				mOOdleVel("Shamrock")
			elseif itemSubType == "Metal & Stone" then
				mOOdleVel("Bronze")
			else
				
			end
			
			--print("|cffaa00ddType: |r"..tostring(itemType))
			--print("|cff11aa11Type: |r"..tostring(itemSubType))
			--print("|cffddbb33amt: |r"..tostring(amt))
			--itemName = gsub(itemName, " Ore", "")
			--print("|cffddff11Item: |r"..tostring(itemName))
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
			playerKey = pn .. "-" .. rlm:gsub(" ","")
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
			Lunacy[playerKey].gold = GetMoney()
			if not Lunacy[playerKey].mood then
				Lunacy[playerKey].mood = {}
				Lunacy[playerKey].mood.r = 77
				Lunacy[playerKey].mood.g = 77
				Lunacy[playerKey].mood.b = 77
			end
			mOOd = Lunacy[playerKey].mood
			
			L_DBG = Luna[playerKey].DBG or 4
			L_DBF = Luna[playerKey].DBF or {}
			
			Luna.Fine = Luna.Fine or {}
			
			coDex = coDex or {}
	
			print("|cffff00ff[Lunacy]|r |cff00ffffWelcome " .. playerName .. "!" .. "|r")
			Lunacy.playerStatus = "loaded"
		end
    end
end)

SLASH_LUNA1, SLASH_LOCO1, SLASH_MPH1, SLASH_KPH1, SLASH_FIND1, SLASH_DBG1 = "/luna", "/loco", "/mph", "/kph", "/find", "/dbg"
SLASH_GATHER1, SLASH_RECORD1, SLASH_RECORD2, SLASH_COLOR1 = "/gather", "/record", "/rec", "/color"
SLASH_DBG1, SLASH_GRIM1 = "/dbg", "/grim"
local function lashLuna(txt, editBox)
	lUnA(txt)
end
local function lashLoco(txt, editBox)
	if txt:sub(1,4) == "set " then
		txt = string.gsub(txt, "set ", "")
		lOcOSet(txt, chn)
	else
		lOcO(txt)
	end
end
local function lashMph(txt, editBox)
	Luna.phPref = "mph"
	Ramble(colorMe("Speed set to mph.)", "FluorescentBlue"))
end
local function lashKph(txt, editBox)
	Luna.phPref = "kph"
	Ramble(colorMe("Speed set to kph.)", "FluorescentBlue"))
end
local function lashFind(txt, editBox)
	if txt == "fp" or txt == "flight master" or txt == "flight point" then
		print("GetFlightPoints")
		GetFlightMaster()
	else
		WhereIs(txt)
	end
end
local function lashGath(txt, editBox)
	gATHEr(txt)
end
local function lashReco(txt, editBox)
	rECORd(txt)
end
local function lashDBG(txt, editBox)
	setDBG(txt)
end
local function lashGrimSet(txt, editBox)
	grimSet(caPit(txt))
end

local function lashDbg(txt, editBox)
	setDBG(txt)
end

local function lashColor(txt, editBox)
	setColor(txt)
end
SlashCmdList["LUNA"] = lashLuna
SlashCmdList["GATHER"] = lashGath
SlashCmdList["RECORD"] = lashReco
SlashCmdList["LOCO"] = lashLoco
SlashCmdList["MPH"] = lashMph
SlashCmdList["KPH"] = lashKph
SlashCmdList["FIND"] = lashFind
SlashCmdList["DBG"] = lashDbg
SlashCmdList["COLOR"] = lashColor
SlashCmdList["DBG"] = lashDBG
SlashCmdList["GRIM"] = lashGrimSet