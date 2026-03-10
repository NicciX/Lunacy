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
            t[i] = str
            i = i + 1
        end
        
        if (#t < 2) then  return "Not in questing zone" end
        
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
    if (minNode) then
		if C_Map.CanSetUserWaypointOnMap(map) then
			local mapPoint = UiMapPoint.CreateFromVector2D(map, minNode.position)
			C_Map.SetUserWaypoint(mapPoint)
			C_SuperTrack.SetSuperTrackedUserWaypoint(true)
		end
		pWay = {}
		pWay.target = nName
		pWay.map = map
		pWay.x = minNode.position.x
		pWay.y = minNode.position.y
        --return minNode.name
    else 
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