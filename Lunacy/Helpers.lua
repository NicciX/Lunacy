local _,Lunacy = ...
local Ramble = Lunacy.Ramble
local GetFlightMaster = Lunacy.GetFlightMaster
local tCopy = Lunacy.tCopy
local caPit = Lunacy.caPit
local remspc = Lunacy.remspc
local deCHex = Lunacy.deCHex
local hex2rgb = Lunacy.hex2rgb
local table_to_string = Lunacy.table_to_string
local factors = Lunacy.factors
local IsPrime = Lunacy.IsPrime
local prepTag = "|cff9e7bb5[Lunacy]|r "
local colorMe = Lunacy.colorMe
local GetLoco = Lunacy.GetLoco
local SetLoco = Lunacy.SetLoco
local loco = Lunacy.loco
local cHOPs

Lunacy.ChattyChop = function(chat)
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
	
	cHOPs = Lunacy.loco.cHOPs or 0
	
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
	Lunacy.loco.cHOPs = cHOPs
	--if opt then
		--lockChain = nil
	--end
	--func_time["ChattyChop"].END = os.time()
	--func_track("ChattyChop")
	return salad
end

Lunacy.tossSalad = function()
	local s = ""
	if type(Luna.salad) == "table" then
		for i,v in pairs(Luna.salad) do
			print(v)
			s = s..tostring(i)..":"..tostring(v)..", "
		end
	end
	return s
end

Lunacy.Ramble = function(msg,tag)
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

Lunacy.GetFlightMaster = function()
    local map = C_Map.GetBestMapForUnit("player")
    local nodes = C_TaxiMap.GetTaxiNodesForMap(map)
    
    local mp = C_Map.GetPlayerMapPosition(map, "player")
    local pX = floor(mp.x * 10000) / 100
    local pY = floor(mp.y * 10000) / 100
    
    local faction = UnitFactionGroup("player")
    local factionCode
    if (faction == "Horde") then
        factionCode = 1
    else
        factionCode = 2
    end
    
    local minNode
	local nName
    local minDistance
    
    for key,node in pairs(nodes) do 
        --print(tostring(node.name))
        local t={} ; i=1
        for str in string.gmatch(node.name, "([^,]+)") do
			--print(str)
            t[i] = str
            i = i + 1
        end
        --print(tostring(#t))
        if (#t > 1) then
			local nodeZoneName = strsub(t[2], 2)      
			local mapInfo = C_Map.GetMapInfo(map)
			--print(tostring(factionCode))
			--print(tostring(node.faction))
			if ((factionCode == node.faction or node.faction == 0)
			and mapInfo.name == nodeZoneName) then
				--print(tostring(nodeZoneName))
				local x = floor(node.position.x * 10000) / 100
				local y = floor(node.position.y * 10000) / 100
				
				local distance = ((pX - x)^2 + (pY - y)^2)^0.5
				
				if (not minDistance or minDistance > distance) then
					minDistance = distance
					minNode = node
					nName = t[1]
				end
			end
		end
    end
    if (minNode) then
		if C_Map.CanSetUserWaypointOnMap(map) then
			C_Map.OpenWorldMap(map)
			SetTrack(map,minNode.position.x*100,minNode.position.y*100,
				colorMe("Flight Master @ ", "Champagne")..colorMe(tostring(nName), "Chartreuse")
			)
			
			pokeMap = true
			--WorldMapFrame:SetShown(false)
			--)
			--local mapPoint = UiMapPoint.CreateFromVector2D(map, minNode.position)
			--C_Map.SetUserWaypoint(mapPoint)
			--C_SuperTrack.SetSuperTrackedUserWaypoint(true)
		end
		--pWay = {}
		--pWay.target = nName
		--pWay.map = map
		--pWay.x = minNode.position.x
		--pWay.y = minNode.position.y
        return minNode.name
    else 
		print("no flight points on this map")
        return "No flight point on this UIMap" 
    end
end

Lunacy.digRoot = function(root)
	if root < 10 then
		return root
	end
	local dig,nit,wit,it=root,0,0,0
	repeat
		wit=0
		while dig > 9 do
			nit=mod(dig,10)
			--print(nit)
			wit=nit+wit
			dig=floor(dig/10)
		end
		wit=wit+dig
		it=it+1
		dig=wit
	until wit < 10 or it > 5
	return wit,it
end

Lunacy.tCopy = function(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[tcopy(orig_key)] = tCopy(orig_value)
        end
        setmetatable(copy, tCopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

Lunacy.caPit = function(str)
	if not str then
		return str
	end
	return str:lower():gsub("^%l", string.upper)
end

Lunacy.remspc = function(str)
	while string.find(str, "%s+") do
		str = string.gsub(str, "(%s+)", "") 
	end
	return str
end

Lunacy.deCHex = function(rgb) -- Converts RGB colors to HEX
	local hex = ""
	for k, v in pairs(rgb) do
		local sex = ""

		while(v > 0)do
			local idex = math.fmod(v, 16) + 1
			v = math.floor(v / 16)
			sex = string.sub("0123456789ABCDEF", idex, idex)..sex			
		end

		if string.len(sex) == 0 then
			sex = "00"
		elseif string.len(sex) == 1 then
			sex = "0"..sex
		end
		hex = hex..sex
	end
	return hex
end

Lunacy.hex2rgb = function(hex)
	if not hex then
		hex = "#ffffff"
	end
	hex = hex:gsub("#","")
	return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
end

Lunacy.table_to_string = function(tbl, del)
	if not del then
		del = ","
	end
	local str = ""
	local c = 1
	for k,v in pairs(tbl) do
		if type(k) == "string" then
			str = str .. tostring(k) .. tostring(del)
		elseif type(v) == "table" then
			str = str .. tostring(k) .. tostring(del)
		else
			str = str .. tostring(v) .. tostring(del)
		end
		--if c < #tbl then
		--str = str .. tostring(del)
		--end
		c = c + 1
	end
	if string.sub(str, #str, #str) == "," then
		str = string.sub(str,1, #str-1)
	end
	return str
end

Lunacy.factors = function(n)
	local i = 2
	local fcts = {}
	--dbgMsg("ƒfactorsƒ :: n : " .. tostring(n), 1)
	while (i <= n) do
		if n % i == 0 then
			fcts[#fcts+1] = i
			n = (n / i)
		else
			i = i + 1
		end
	end
	if n > 1 then
		fcts[#fcts+1] = i
	end
	return fcts
end

Lunacy.IsPrime = function(n)
	if n/2 == math.floor(n/2) then
		if n > 2 then
			return false
		else
			return true
		end
	elseif n/3 == math.floor(n/3) then
		if n > 3 then
			return false
		else
			return true
		end
	elseif n/5 == math.floor(n/5) then
		if n > 5 then
			return false
		else
			return true
		end
	end
	local fc = factors(n)
	if #fc == 1 then
		return true
	end
	return false
end

Lunacy.formatTime = function(tm, opt)
	local tZone = 5*3600 -- Timezone adjust -- CST
	local t = tonumber(tm)
	local H
	if opt then
		tm = date(opt, t)
	elseif tm == 0 then
		t = GetTimePreciseSec() -- - tZone
		--tm = math.floor(t - math.floor(t)*100)/100
		tm = t - math.floor(t)
		tm = math.floor(tm * 1000)
		tm = "" .. date("%H:%M:%S", t) .. " ¦ " .. tostring(tm) .. ""
	elseif t > 43200 then
		H = math.floor(t / 3600)
		tm = tostring(H) .. date(":%M:%S", t)
	elseif t > 3 then
		tm = date("%H:%M:%S", t)
	elseif t < 0.0013 then
		tm = tostring(math.floor(tm*100000000) / 100) .. "μS"
	else
		tm = tostring(math.floor(tm*100000) / 100) .. "mS"
	end
	return tm
end

Lunacy.ClearGathersZone = function()
	Gathers = Gathers or {}
	local zoneName = GetZoneText()
	
	if Gathers[zoneName] then
		Gathers[zoneName] = nil
		return "Gathers cleared for "..tostring(zoneName).."."
	end
end

Lunacy.InitHelpers = function()
	GetFlightMaster = Lunacy.GetFlightMaster
	tCopy = Lunacy.tCopy
	caPit = Lunacy.caPit
	remspc = Lunacy.remspc
	deCHex = Lunacy.deCHex
	hex2rgb = Lunacy.hex2rgb
	table_to_string = Lunacy.table_to_string
	factors = Lunacy.factors
	IsPrime = Lunacy.IsPrime
	Ramble = Lunacy.Ramble
	colorMe = Lunacy.colorMe
end





--[[

function GetFlightMaster()
    local map = C_Map.GetBestMapForUnit("player")
    local nodes = C_TaxiMap.GetTaxiNodesForMap(map)
    
    local mp = C_Map.GetPlayerMapPosition(map, "player")
    local pX = floor(mp.x * 10000) / 100
    local pY = floor(mp.y * 10000) / 100
    
    local faction = UnitFactionGroup("player")
    local factionCode
    if (faction == "Horde") then
        factionCode = 1
    else
        factionCode = 2
    end
    
    local minNode
	local nName
    local minDistance
    
    for key,node in pairs(nodes) do 
        --print(tostring(node.name))
        local t={} ; i=1
        for str in string.gmatch(node.name, "([^,]+)") do
			--print(str)
            t[i] = str
            i = i + 1
        end
        --print(tostring(#t))
        if (#t > 1) then
			local nodeZoneName = strsub(t[2], 2)      
			local mapInfo = C_Map.GetMapInfo(map)
			--print(tostring(factionCode))
			--print(tostring(node.faction))
			if ((factionCode == node.faction or node.faction == 0)
			and mapInfo.name == nodeZoneName) then
				--print(tostring(nodeZoneName))
				local x = floor(node.position.x * 10000) / 100
				local y = floor(node.position.y * 10000) / 100
				
				local distance = ((pX - x)^2 + (pY - y)^2)^0.5
				
				if (not minDistance or minDistance > distance) then
					minDistance = distance
					minNode = node
					nName = t[1]
				end
			end
		end
    end
    if (minNode) then
		if C_Map.CanSetUserWaypointOnMap(map) then
			C_Map.OpenWorldMap(map)
			SetTrack(map,minNode.position.x*100,minNode.position.y*100,
				colorMe("Flight Master @ ", "Champagne")..colorMe(tostring(nName), "Chartreuse")
			)
			
			pokeMap = true
			--WorldMapFrame:SetShown(false)
			--)
			--local mapPoint = UiMapPoint.CreateFromVector2D(map, minNode.position)
			--C_Map.SetUserWaypoint(mapPoint)
			--C_SuperTrack.SetSuperTrackedUserWaypoint(true)
		end
		--pWay = {}
		--pWay.target = nName
		--pWay.map = map
		--pWay.x = minNode.position.x
		--pWay.y = minNode.position.y
        return minNode.name
    else 
		print("no flight points on this map")
        return "No flight point on this UIMap" 
    end
end

function tCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[tcopy(orig_key)] = tCopy(orig_value)
        end
        setmetatable(copy, tCopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function caPit(str)
	if not str then
		return str
	end
	return str:lower():gsub("^%l", string.upper)
end

function remspc(str)
	while string.find(str, "%s+") do
		str = string.gsub(str, "(%s+)", "") 
	end
	return str
end

function deCHex(rgb) -- Converts RGB colors to HEX
	local hex = ""
	for k, v in pairs(rgb) do
		local sex = ""

		while(v > 0)do
			local idex = math.fmod(v, 16) + 1
			v = math.floor(v / 16)
			sex = string.sub("0123456789ABCDEF", idex, idex)..sex			
		end

		if string.len(sex) == 0 then
			sex = "00"
		elseif string.len(sex) == 1 then
			sex = "0"..sex
		end
		hex = hex..sex
	end
	return hex
end

function hex2rgb(hex)
	if not hex then
		hex = "#ffffff"
	end
	hex = hex:gsub("#","")
	return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
end

function table_to_string(tbl, del)
	if not del then
		del = ","
	end
	local str = ""
	local c = 1
	for k,v in pairs(tbl) do
		if type(k) == "string" then
			str = str .. tostring(k) .. tostring(del)
		elseif type(v) == "table" then
			str = str .. tostring(k) .. tostring(del)
		else
			str = str .. tostring(v) .. tostring(del)
		end
		--if c < #tbl then
		--str = str .. tostring(del)
		--end
		c = c + 1
	end
	if string.sub(str, #str, #str) == "," then
		str = string.sub(str,1, #str-1)
	end
	return str
end

function factors(n)
	local i = 2
	local fcts = {}
	--dbgMsg("ƒfactorsƒ :: n : " .. tostring(n), 1)
	while (i <= n) do
		if n % i == 0 then
			fcts[#fcts+1] = i
			n = (n / i)
		else
			i = i + 1
		end
	end
	if n > 1 then
		fcts[#fcts+1] = i
	end
	return fcts
end

function IsPrime(n)
	if n/2 == math.floor(n/2) then
		if n > 2 then
			return false
		else
			return true
		end
	elseif n/3 == math.floor(n/3) then
		if n > 3 then
			return false
		else
			return true
		end
	elseif n/5 == math.floor(n/5) then
		if n > 5 then
			return false
		else
			return true
		end
	end
	local fc = factors(n)
	if #fc == 1 then
		return true
	end
	return false
end

]]--