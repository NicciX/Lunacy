local HBD = LibStub("HereBeDragons-2.0")

local Find = {
	["Portal"] = {
		["Stormwind City"] = {
			["Uldum"] = {},
		},
		["Silvermoon City"] = {
			["Stormwind City"] = {
				["mapID"] = 2393,
				["x"] = 52.77,
				["y"] = 64.77,
			},
			["Harandar"] = {
				["mapID"] = 2393,
				["x"] = 36.66,
				["y"] = 68.76,
			},
			["Voidstorm"] = {
				["mapID"] = 2393,
				["x"] = 35.15,
				["y"] = 65.67,
			},
		},
		["The Den"] = { -- Harandar
			["Silvermoon City"] = {
				["mapID"] = 2576,
				["x"] = 63.82,
				["y"] = 70.36,
				["opt"] = "Portal is inside cave.",
			},
		},
		["Harandar"] = { -- Harandar
			["Silvermoon City"] = {
				["mapID"] = 2576,
				["x"] = 63.82,
				["y"] = 70.36,
				["opt"] = "Portal is inside cave.",
			},
		},
	},
	["Mailbox"] = {
		["Silvermoon City"] = {
			["Dawning Lane"] = {
				["mapID"] = 2393,
				["x"] = 28.66,
				["y"] = 66.91,
			},
			["Falconwing Square"] = {
				["mapID"] = 2393,
				["x"] = 34.32,
				["y"] = 80.23,
			},
			["The Bazaar SE"] = {
				["mapID"] = 2393,
				["x"] = 49.49,
				["y"] = 75.53,
			},
			["The Bazaar N"] = {
				["mapID"] = 2393,
				["x"] = 45.09,
				["y"] = 56.58,
			},
		},
	}
}

local matchSticks = {
	["portal"] = "Portal",
	["port"] = "Portal",
	["mailbox"] = "Mailbox",
	["mail"] = "Mailbox",
	["bank"] = "Bank",
	["auction house"] = "AuctionHouse",
	["auctionhouse"] = "AuctionHouse",
	["auction"] = "AuctionHouse",
	["ah"] = "AuctionHouse",
	["auctionhouse"] = "AuctionHouse",
	["trainer"] = "Trainer",
	["qm"] = "Quartermaster",
	["quartermaster"] = "Quartermaster",
}

local destinations = {
	["stormwind"] = "Stormwind City",
	["sw"] = "Stormwind City",
	["uldum"] = "Uldum",
	["harandar"] = "Harandar",
	["haradar"] = "Harandar",
	["harandir"] = "Harandar",
	["haran"] = "Harandar",
	["hara"] = "Harandar",
	["smc"] = "Silvermoon City",
	
}

local function GetDis(pX,pY,dX,dY,tMap)
	dX, dY = HBD:GetWorldCoordinatesFromZone(dX/100, dY/100, tMap)
	return math.abs(HBD:GetWorldDistance(tMap, pX, pY, dX, dY))
end

local function FindPortal(txt)
	local map = C_Map.GetBestMapForUnit("player")
	local loCat = C_Map.GetMapInfo(map)
	loCat = loCat.name
	if loCat then
		if destinations[txt] and Find.Portal[loCat] then
			if Find.Portal[loCat][destinations[txt]] then
				if Find.Portal[loCat][destinations[txt]].mapID then
					Ramble(colorMe("Portal for ", "Champagne")..colorMe(destinations[txt], "Chartreuse")..colorMe(" set.", "Champagne"), colorMe("[WhereIs] ", "SignalYellow"))
					SetTrack(Find.Portal[loCat][destinations[txt]].mapID,
						Find.Portal[loCat][destinations[txt]].x,
						Find.Portal[loCat][destinations[txt]].y,
						colorMe("Portal to ", "Champagne")..colorMe(destinations[txt], "Chartreuse"),
						Find.Portal[loCat][destinations[txt]].opt
					)
				end
			end
		elseif Find.Portal[loCat] then
			local dis = 9999
			local pX,pY,pMap,pWX,pWY,mapType,pntMap = GetPlayerPosition()
			local dX, dY
			local dISS, kEY
			for k,v in pairs(Find.Portal[loCat]) do
				dISS = GetDis(pWX,pWY,v.x,v.y,v.mapID)
				if dISS < dis then
					dis = dISS
					kEY = k
				end
			end
			if kEY then
				Ramble(colorMe("Portal for ", "Champagne")..colorMe(kEY, "Chartreuse")..colorMe(" set.", "Champagne"), colorMe("[WhereIs] ", "SignalYellow"))
				SetTrack(Find.Portal[loCat][kEY].mapID,
					Find.Portal[loCat][kEY].x,
					Find.Portal[loCat][kEY].y,
					colorMe("Portal to ", "Champagne")..colorMe(kEY, "Chartreuse"),
					Find.Portal[loCat][kEY].opt
				)
			else
				Ramble(colorMe("~No portals located for ", "CandyApple")..colorMe(loCat, "Chartreuse")..colorMe("~", "CandyApple"),
					colorMe("[WhereIs]", "SignalYellow"))
			end
		else
			Ramble(colorMe("~No valid data for [", "CandyApple")..colorMe(loCat, "Chartreuse")..colorMe("]~", "CandyApple"),
					colorMe("[WhereIs]", "SignalYellow"))
		end
	else
		Ramble(colorMe("~Unknown Location~", "CandyApple"), colorMe("[WhereIs]", "SignalYellow"))
	end
end

local function FindThing(thing)
	local map = C_Map.GetBestMapForUnit("player")
	local loCat = C_Map.GetMapInfo(map)
	loCat = loCat.name
	if loCat and Find[thing] then
		if Find[thing][loCat] then
			local dis = 9999
			local pX,pY,pMap,pWX,pWY,mapType,pntMap = GetPlayerPosition()
			local dX, dY
			local dISS, kEY
			for k,v in pairs(Find[thing][loCat]) do
				dISS = GetDis(pWX,pWY,v.x,v.y,v.mapID)
				if dISS < dis then
					dis = dISS
					kEY = k
				end
			end
			if kEY then
				Ramble(colorMe(thing.." found at ", "Champagne")..colorMe(kEY, "Chartreuse")..colorMe(" set.", "Champagne"), colorMe("[WhereIs] ", "SignalYellow"))
				SetTrack(Find[thing][loCat][kEY].mapID,
					Find[thing][loCat][kEY].x,
					Find[thing][loCat][kEY].y,
					colorMe(thing.." @ ", "Champagne")..colorMe(kEY, "Chartreuse"),
					Find[thing][loCat][kEY].opt
				)
			else
				Ramble(colorMe("~No "..things.." located in ", "CandyApple")..colorMe(loCat, "Chartreuse")..colorMe("~", "CandyApple"),
					colorMe("[WhereIs]", "SignalYellow"))
			end
		else
			Ramble(colorMe("~No valid data for [", "CandyApple")..colorMe(loCat, "Chartreuse")..colorMe("]~", "CandyApple"),
					colorMe("[WhereIs]", "SignalYellow"))
		end
	else
		Ramble(colorMe("~Unknown Thing~", "CandyApple"), colorMe("[WhereIs]", "SignalYellow"))
	end
end

function WhereIs(txt)
	if string.sub(txt, 1, 7) == "portal " or string.sub(txt, 1, 5) == "port " or txt == "port" or txt == "portal" then
		txt = string.gsub(txt, "portal ", "")
		txt = string.gsub(txt, "port ", "")
		txt = string.gsub(txt, "portal", "")
		txt = string.gsub(txt, "port", "")
		FindPortal(txt)
	elseif txt == "mailbox" or txt == "mail" or txt == "box" then
		FindThing("Mailbox")
	end
end