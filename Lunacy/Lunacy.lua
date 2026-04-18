--Lunacy
local HBD = LibStub("HereBeDragons-2.0")

local _, Lunacy = ...


--local Lunacy = addon
Lunacy.version = "1.1.67" -- 67

L_DBG = 1
--DBG 0 - 2: General Information; 0 - User intiated feedback, 1 - Important events, 2 - General alerts
--DBG 3 - 4: Alerts; 3 - Basic, 4 - Specific
--DBG 5 - 6: Tracking sticks..
--BDG 7	7 7: Lucky Do's and Ropes...
--DBG .	8 .: Boring Shit
--DBG 9 - 11: The Weird Zone

L_DBF = {}
--DBF[TAG] -- Subscribe/Unsubscribe to a specific TAG | ex: [FlashMe] Scarlet ; FlashMe is the tag.
--Multiple channels cand be subscibed to at a time

playerKey = ""
playerName = ""

local GetFlightMaster = Lunacy.GetFlightMaster
local tCopy = Lunacy.tCopy
local caPit = Lunacy.caPit
local remspc = Lunacy.remspc
local deCHex = Lunacy.deCHex
local hex2rgb = Lunacy.hex2rgb
local table_to_string = Lunacy.table_to_string
local factors = Lunacy.factors
local IsPrime = Lunacy.IsPrime
local beckon = Lunacy.beckon
local grimoire = Lunacy.grimoire
local DrawCard = Lunacy.DrawCard
local trOlls = Lunacy.trOlls
local wHIspRES = Lunacy.wHIspRES
local SetColorGroup = Lunacy.SetColorGroup
local formatTime = Lunacy.formatTime
local Ramble = Lunacy.Ramble
local colorMe = Lunacy.colorMe
local loco = Lunacy.loco
local GetLoco = Lunacy.GetLoco
local SetLoco = Lunacy.SetLoco
local ChattyChop = Lunacy.ChattyChop
local WhereIs = Lunacy.WhereIs
local stack_chat = Lunacy.stack_chat
local GetHexColor = Lunacy.GetHexColor
local digRoot = Lunacy.digRoot

local gatherActions = {
	[265837] = "Mining",
	[265819] = "Herb Gathering",
}

local validGatherType = {
	["Metal & Stone"] = true,
	["Herb"] = true,
	["Enchanting"] = true,
	["Currency"] = true,
}

local hat = {
	["alchemy"] = "alchemist",
	["alchemist's"] = "alchemist",
	["health"] = "alchemist",
	["potion"] = "alchemist",
	["entropic"] = "alchemist",
	["extract"] = "alchemist",
	["tonic"] = "alchemist",
	["flask"] = "alchemist",
	["derivate"] = "alchemist",
	["serum"] = "alchemsist",
	["powder"] = "scribe",
	["pigment"] = "scribe",
	["scribe's"] = "scribe",
	["inscription"] = "scribe",
	["ink"] = "scribe",
	["dust"] = "enchantress",
	["shard"] = "enchantress",
	["enchanting"] = "enchantress",
	["enchanter's"] = "enchantress",
	["enchant"] = "enchantress",
	["dust"] = "enchantress",
	["dust"] = "enchantress",
	["robes"] = "tailor",
	["courtly"] = "tailor",
	["slippers"] = "tailor",
	["tailoring"] = "tailor",
	["tailor"] = "tailor",
	["linen"] = "tailor",
	["wool"] = "tailor",
	["cloth"] = "tailor",
	["cooking"] = "chef",
	["skewers"] = "chef",
	["filet"] = "chef",
	["food"] = "chef",
	["biscuits"] = "chef",
	["feast"] = "chef",
	["meal"] = "chef",
	["hearty"] = "chef",
	["snack"] = "chef",
	["herbalist"] = "herbalist",
	["herbalist's"] = "herbalist",
	["herb"] = "herbalist",
	["herbalism"] = "herbalist",
	["mulch"] = "herbalist",
	["ore"] = "miner",
	["miner's"] = "miner",
	["mining"] = "miner",
	["bar"] = "miner",
	["ingot"] = "miner",
	["fishing"] = "fishing",
	["angler's"] = "fishing",
	["angler"] = "fishing",
	["fisher"] = "fishing",
	["fish"] = "fishing",
	["trout"] = "fishing",
	["adventurer"] = "arcana",
	["mote"] = "arcana",
	["wild"] = "arcana",
	["magic"] = "arcana",
	["arcana"] = "arcana",
	["marl"] = "void",
	["darkmoon"] = "darkmoon",
	["noblegarden"] = "chef",
	["trophy"] = "duty",
	["coffer"] = "market",
	["anomaly"] = "void",
	["demonic"] = "void",
	["blood"] = "war",
	["dynamite"] = "engineer",
	["engineer"] = "engineer",
	["engineering"] = "engineer",
	["blasting"] = "engineer",
	["tube"] = "engineer",
	["rocket"] = "engineer",
	["grenade"] = "engineer",
	["bomb"] = "engineer",
	["mortar"] = "engineer",
	["explosive"] = "engineer",
	["cables"] = "engineer",
	["bolts"] = "engineer",
	["wrench"] = "engineer",
	["spanner"] = "engineer",
	["bot"] = "engineer",
}

local artisan = {
	["scribe"] = "Napoli",
	["alchemist"] = "Palatinate",
	["enchanter"] = "PrussianBlue",
	["enchantress"] = "PrussianBlue",
	["tailor"] = "Flax",
	["jewelcrafter"] = "Turquoise",
	["leatherworker"] = "Leather",
	["skinner"] = "Hazel",
	["engineer"] = "ElectricBlue",
	["blacksmith"] = "SteelBlue",
	["chef"] = "Chocolate",
	["cook"] = "Chocolate",
	["herbalist"] = "Spring",
	["miner"] = "Cobalt",
	["fisher"] = "AhoyBlue",
	["darkmoon"] = "Shamrock",
	["luxury"] = "Maroon",
	["duty"] = "Parchment",
	["market"] = "Bone",
	["void"] = "Obsidian",
	["fishing"] = "FluorescentBlue",
	["arcana"] = "Feldgrau",
	["war"] = "Scarlet",
	["engineer"] = "Bronze",
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
EventFrame:RegisterEvent("CHAT_MSG_CURRENCY")
EventFrame:RegisterEvent("FACTION_STANDING_CHANGED")
EventFrame:RegisterEvent("CHAT_MSG_SKILL")
EventFrame:RegisterEvent("CHAT_MSG_EMOTE")

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
	--print(keyA)
	--print(keyB)
	--print(keyC)
	--print(val)
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
	elseif txt:sub(1,3) == "fav" then
		
	elseif grimoire[txt] then
		initLineSet(txt)
	else
		local key
		for k,v in pairs(grimoire) do
			if string.lower(k) == string.lower(txt) then
				key = k
			end
		end
		if key and grimoire[key] then
			initLineSet(key)
		end
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
	if not val or val == "" then
		Ramble(colorMe("∫DBG∫", "FluorescentBlue").." = "..colorMe(L_DBG, "Trombone"), colorMe("[DBG] ", "CandyApple"))
		for k,v in pairs(L_DBF) do
			Ramble(colorMe("∫FuncTrack∫  ", "FluorescentBlue").." → "..colorMe(k, "Trombone"), colorMe("[DBG] ", "CandyApple"))
		end
		return
	end
	if not tonumber(val) then
		L_DBF[val] = not L_DBF[val]
		if L_DBF[val] then
			Ramble(colorMe("∫FuncTrack∫  ", "FluorescentBlue").."Now tracking →"..colorMe(val, "Trombone"), colorMe("[DBG] ", "CandyApple"))
		else
			Ramble(colorMe("∫FuncTrack∫  ", "FluorescentBlue").."No longer tracking →"..colorMe(val, "Trombone"), colorMe("[DBG] ", "CandyApple"))
		end
	end
	val = tonumber(val)
	if val and val > -2 and val < 11 then 
		Luna[playerKey].DBG = val
		L_DBG = val
		Ramble(colorMe("DBG set to level ", "FluorescentBlue")..colorMe(tostring(L_DBG),
		dbgLvls[tostring(L_DBG)])..colorMe(".", "FluorescentBlue"), colorMe("[DBG] ", "CandyApple"))
	end
end

local function lUnA(txt, chn)
	local eval, ret, func, _ENV
	if string.match(txt, "%[(%a+)%]") then
		local ass = string.match(txt, "%[(%a+)%]") -- unfinished capture my ASS:P
		local half = string.gsub(txt, "%["..ass.."%]", "")
		if #half > 0 then
			if string.find(half,"nil") then
				half = nil
			elseif string.find(half,"true") then
				half = true
			elseif string.find(half,"false") then
				half = false
			end
			--print(ass)
			--print(half)
			Luna[ass] = half
			ret = tostring(Luna[ass]).." assigned to global save value '"..ass.."'."
		else
			--print(Luna[ass])
			ret = Luna[ass]
		end
	else
		func = assert(loadstring("return " .. txt))
		_ENV = {loon = Lunacy, goon = _G, loco = Lunacy.loco, trOlls = Lunacy.trOlls, grimoire = Lunacy.grimoire, whispers = Lunacy.wHIspRES}
		--setfenv(func, _ENV)
		setfenv(func, _ENV)
		eval, ret = pcall(func)
		if (not eval) then
			SendChatMessage("error :: " .. ret, chn)
		elseif type(ret) == "table" then
			ret = table_to_string({ret}, " :: ")
		end
	end
	
	if not chn then
		print("~Mother Moon says:~> " .. tostring(ret))
	else
		--trOlls["°)ω(°"].desc
		local trAin = GetLoco("trOll") -- >>ω♥∩>
		trAin = trOlls[trAin] or trOlls[tonumber(trAin)] or 777 -- •~7~7~7~(•Y•)>
		--SendChatMessage(tostring(ret), chn) -- qUIRk ~ appears in chat before the SendChatMessage()'s below as expected..
		if trOlls[trAin] and trOlls[trAin].desc then -- it's trOlls .. all  .. the way ... ↓down↓
			SendChatMessage(trAin.." "..trOlls[trAin].desc.." says:~> ", chn) -- ~>It's! The trOll trAin ~~cho`o>~cho`o>
			stack_chat(tostring(ret), chn)
			--SendChatMessage(tostring(ret), chn)
		else
			SendChatMessage("~Mother Moon says:~> ", chn)
			stack_chat(tostring(ret), chn) -- in Compass.lua
			--SendChatMessage(tostring(ret), chn)
		end
		--SendChatMessage(tostring(ret), chn) -- qUIRk ~ also appears in chat before the SendChatMessage()'s above, not as expected.
	end
end

local function shuFFle(dat)
	local cat = ChattyChop(dat)
	local sprat = {}
	local bat = 0
	local pat
	for i,v in pairs(cat) do
		if hat[v:lower()] then
			sprat[hat[v:lower()]] = (sprat[hat[v:lower()]] or 0) + 1
		end
	end
	for k,v in pairs(sprat) do
		if v > bat then
			bat = v
			pat = k
		end
	end
	if L_DBG >= 4 or L_DBF["shuFFle"] then
		Ramble(colorMe(caPit(pat), "Silver"),colorMe("[shuFFle] ", "Teal"))
	end
	--if pat == "arcana" then
		--FlashMe("Shamrock")
	--end
	if artisan[pat] then
		Artisanship(pat,artisan[pat])
	end
	--print(pat)
end

local function ChatHandler(txt, chn, sender)
	if loco.scuffle then
		return
	end
	if string.sub(txt, 1, 9) == "loco set " then
		txt = string.gsub(txt, "loco set ", "")
		lOcOSet(txt, chn)
	elseif string.sub(txt, 1, 5) == "loco " then
		txt = string.gsub(txt, "loco ", "")
		if txt == "dump troll" then
			DumpTroll()
			return
		end
		lOcO(txt, chn)
	elseif string.sub(txt,1,5) == "grim " then
		txt = string.gsub(txt, "grim ", "")
		--txt = txt:sub(1,1):upper()..txt:sub(2,#txt) --Capit
		grimSet(txt)
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
	elseif string.sub(txt, 1, 3) == "dbg" then
		txt = string.gsub(txt, "dbg ", "")
		txt = string.gsub(txt, "dbg", "")
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

local function mOOdleVel(clr, vex)
	--local dep = true
	--if dep then
		--return
	--end
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
	--local vcr, vcg, vcb = CompArrow.texture:GetVertexColor()
	
	--CompArrow.texture:SetVertexColor(r, g, b, 1)
	--CompArrow.texture:SetVertexColor(0.77, 0.77, 0.77, 1)
	--CompArrow.texture:SetVertexColor(r/255, g/255, b/255, 1)
end

local function RegisterGather(itemType, itemSubType, amt, itemName)
	if not validGatherType[itemSubType] then
		if L_DBG >= 6 or L_DBF["RegisterGather"] then
			Ramble(colorMe("Invalid Gather Type: ", "Red")..colorMe(tostring(itemSubType), "Yellow"), colorMe("[RegisterGather] ", "Chartreuse"))
		end
		--return
	end
	if itemName == "Voidlight Marl" then
		FlashMe("Marl")
	elseif itemName == "Brightly Colored Egg" then
		FlashMe("Maroon")
	elseif itemName == "Grisly Trophy" then
		FlashMe("Parchment")
	elseif itemName == "Luminous Dust" then
		FlashMe("PrussianBlue")
	elseif itemSubType == "Herb" then
		shuFFle("herb")
		--FlashMe("Spring")
	elseif itemSubType == "Metal & Stone" then
		shuFFle("ore")
	elseif itemSubType == "Cooking" then
		shuFFle("fish")
	--elseif itemName == "Blood Hunter" then
		--FlashMe("Scarlet")
		--FlashMe("Cobalt")
	elseif itemType == "Enchanting" then
		FlashMe("PrussianBlue")
		print("Enchanting")
	elseif itemType == "Key" then
		shuFFle("darkmoon")
	elseif itemType == "Currency" then --keep at end
		FlashMe("AdmiralBlue")
	elseif itemType == "Tradeskill" then --keep at end
		FlashMe("Buff")
	elseif itemType == "Tradeskill" then --keep at end
		FlashMe("Buff")
	else
		shuFFle(itemName)
	end
	if L_DBG >= 9 or L_DBF["RegisterGather"] then
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

local function player_load()
	local pn, rlm = UnitName("player")
	if not rlm then
		rlm = GetRealmName()
	end
	Ramble = Lunacy.Ramble
	trOlls = Lunacy.trOlls
	grimoire = Lunacy.grimoire
	DrawCard = Lunacy.DrawCard
	wHIspRES = Lunacy.wHIspRES
	DumpTroll = Lunacy.DumpTroll
	digRoot = Lunacy.digRoot
	if pn then
		playerKey = pn .. "-" .. rlm:gsub(" ","")
		playerName = pn
		Luna = Luna or {}
		Luna[playerKey] = Luna[playerKey] or {}
		Lunacy[playerKey] = Luna[playerKey] or {}
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
		
		Luna.Find = Luna.Find or {}
		
		Lunacy.InitHelpers()
		Lunacy.InitCompass()
		loco = Lunacy.loco
		GetLoco = Lunacy.GetLoco
		SetLoco = Lunacy.SetLoco
		stack_chat = Lunacy.stack_chat
		WhereIs = Lunacy.WhereIs
		colorMe = Lunacy.colorMe
		
		coDex = coDex or {}
		Ramble(colorMe("Welcome ", "Yellow")..colorMe(playerName, "ElectricBlue")..colorMe("!", "Vixen"), colorMe("[Lunacy] ", "Vixen"))
		Lunacy.playerStatus = "loaded"
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
		Lunacy.popClrTbl()
	elseif event == "CHAT_MSG_EMOTE" then
		if L_DBG >= 6 or L_DBF["CHAT_MSG_EMOTE"] then
			Ramble(colorMe(" †arg1† ", "Mulberry")..colorMe(arg1, "Alabaster"), colorMe("[CHAT_MSG_EMOTE]", "Mustard"))
		end
		FlashMe("Vixen")
	elseif event == "CHAT_MSG_SKILL" then
		print(":CHAT_MSG_SKILL:")
		print(arg1)
		shuFFle(arg1)
	elseif event == "FACTION_STANDING_CHANGED" then
		if L_DBG >= 6 or L_DBF["FACTION_STANDING_CHANGED"] then
			Ramble(colorMe(" †arg1† ", "Mulberry")..colorMe(arg1, "Alabaster"), colorMe("[FACTION_STANDING_CHANGED]", "Mustard"))
		end
		FlashMe("Parchment")
	elseif event == "PLAYER_LOGOUT" then
		SaveLoco()
		Luna[playerKey] = Lunacy[playerKey]
		Luna[playerKey].DBG = L_DBG
		Luna[playerKey].DBF = L_DBF
		Lunacy[playerKey].mood = mOOd
	elseif event == "CURRENCY_DISPLAY_UPDATE" then
		print("CURRENCY_DISPLAY_UPDATE")
	elseif event == "CHAT_MSG_CURRENCY" then
		local eT = arg1 or arg2
		local cuRRy = eT:sub(1,#eT)
		local amt = string.match(cuRRy, "x(%d+)")
		cuRRy = string.gsub(cuRRy,"You receive currency: ", "")
		cuRRy = string.gsub(cuRRy,"x(%d+)", "")
		local iFo = C_Item.GetItemIDForItemInfo(cuRRy)
		if not amt then
			if L_DBG >= 7 or L_DBF["Booty"] then
				Ramble(colorMe(" ~You got the BOOTY!~ ", "Sunflower"), colorMe("[Booty] ", "Mulberry"))
			end
			return
		end 
		local info = C_CurrencyInfo.GetCurrencyInfoFromLink(cuRRy) or {}
		if L_DBG >= 7 or L_DBF["Booty"] then
			Ramble(colorMe(" ~You got the BOOTY!~ ", "Sunflower"), colorMe("[Booty] ", "Bronze"))
			Ramble(colorMe(info.name, "Yellow"), colorMe("[Booty] ItemName: ", "Bronze"))
		end
		if itemSubType == "Herb" then
			mOOdleVel("Shamrock")
		elseif itemSubType == "Metal & Stone" then
			mOOdleVel("Bronze")
		elseif itemSubType == "Food & Drink" then
			shuFFle("food")
		elseif itemSubType == "Enchanting" then
			shuFFle("dust")
		elseif info.name then
			shuFFle(info.name)
		end
		if info.name then
			RegisterGather("Currency", "Currency", amt, info.name)
		end
	elseif event == "CHAT_MSG_LOOT" or event == "CHAT_MSG_CURRENCY" then
		local is,itype = IsInInstance()
		if PlayerIsInCombat() and is then
			if itype ~= "interior" and itype ~= "neighborhood" and itype ~= "scenario" then
				return
			end
		end
		if L_DBG >= 6 or L_DBF["Event"] then
			Ramble(colorMe("CHAT_MSG_LOOT: arg1 :: ", "Sunflower")..tostring(arg1), colorMe("[Events] ", "Celeste"))
		end
		--print("CHAT_MSG_LOOT: arg2 :: "..tostring(arg2))
		--print("CHAT_MSG_LOOT: arg3 :: "..tostring(arg3))
		--print("CHAT_MSG_LOOT: arg4 :: "..tostring(arg4))
		--print("CHAT_MSG_LOOT: arg5 :: "..tostring(arg5))
		if arg5 == playerKey or arg2 == playerKey then
			local tmp = arg1
			--local itemString = string.match(tmp, "item[%-?%d:]+")
			local amt = tostring(tmp)
			local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType = C_Item.GetItemInfo(tmp)
			if not string.find(tmp, "You receive loot:") and not string.find(tmp, "You receive currency:") then
				if string.find(tmp, "You create:") and itemSubType == "Food & Drink" then
					shuFFle("food")
				elseif string.find(tmp, "You create:") then
					local str = string.gsub(tmp, "You create:", "")
					if string.find(str,".") > 2 then
						str = str:sub(1,#str-1)
					end
					--print(tostring(str))
					itemName = C_Item.GetItemInfo(str) --C_Item.GetItemInfo("Enchant Ring - Thalassian Haste")
					--print(tostring(itemName))
					if itemName then
						shuFFle(itemName)
					end
				elseif string.find(tmp, "You receive item:") then
					local str = string.gsub(tmp, "You receive item:", "")
					itemName = C_Item.GetItemInfo(str)
					if itemName then
						shuFFle(itemName)
					end
				end
				--Ramble(colorMe(" ~You got the BOOTY!~ ", "Sunflower"), colorMe("[Booty] ", "Mulberry"))
				if L_DBG >= 6 or L_DBF["Booty"] then
					Ramble(tostring(tmp), colorMe("[Booty] ", "Mulberry"))
				end
				--FlashMe("Shamrock")
				--print("CHAT_MSG_LOOT: You got the BOOTY!")
				return
			
			end
			amt = string.match(tmp, "x(%d+)")
			--local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType = C_Item.GetItemInfo(tmp)
			if itemSubType == "Herb" then
				mOOdleVel("Shamrock")
			elseif itemSubType == "Metal & Stone" then
				mOOdleVel("Bronze")
			elseif itemSubType == "Enchanting" then
				shuFFle("dust")
			--elseif itemSubType == "Food & Drink" then
				--mOOdleVel("Bronze")	
				--shuFFle("food")
			end
			
			print("|cffaa00ddType: |r"..tostring(itemType))
			print("|cff11aa11SubType: |r"..tostring(itemSubType))
			--print("|cffddbb33amt: |r"..tostring(amt))
			--itemName = gsub(itemName, " Ore", "")
			--print("|cffddff11Item: |r"..tostring(itemName))
			RegisterGather(itemType, itemSubType, amt, itemName)
		end
	elseif event == "UI_INFO_MESSAGE" then
		if L_DBG >= 8 or L_DBF["UI_INFO_MESSAGE"] then
			Ramble(colorMe("Code: ","Teal")..tostring(arg1), colorMe("[UI_INFO_MESSAGE] ", "CyberYellow"))
			Ramble(colorMe("Msg: ","ArcticBlue")..tostring(arg2), colorMe("[UI_INFO_MESSAGE] ", "CyberYellow"))
			--print(tostring(arg1))
		end
		--288 criteria update (loot?)
		--289 criteria update
		--286 objective complete
		--372 discovered area
		--print(arg1)
		--print(arg2)
		--print("-----------")
		if arg1 == 408 then --378 then
			--Lunacy_RecordExplore(arg2)
			if L_DBG >= 4 or L_DBF["Exploration"] then
				Ramble(colorMe(tostring(arg2),"EarthYellow")..tostring(arg1), colorMe("[Exploration] ", "CarolinaBlue"))
				--print("Exploration: " .. tostring(arg2))
			end
		end
	elseif event == "VARIABLES_LOADED" then	
		Lunacy.loaded = true
	elseif event == "PLAYER_ENTERING_WORLD" then
		player_load()
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
	elseif txt == "dump troll" then
			DumpTroll()
			return
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
SlashCmdList["GRIM"] = lashGrimSet