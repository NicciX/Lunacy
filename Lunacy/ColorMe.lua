--ColorMe!

local curDex = 0
local currentGroup = "blue"
curClr = "Blue"

local ColorTable = {
	["DEX"] = {
		["blue"] = {},
		["green"] = {},
		["yellow"] = {},
		["red"] = {},
		["purple"] = {},
		["pink"] = {},
		["brown"] = {},
		["white"] = {},
		["black"] = {},
	},
	--Blue
	["Blue"] = {"3944BC", "blue"},
	["Midnight"] = {"03045E", "blue"},
	["Turquoise"] = {"00FFEF", "blue"},
	["Celeste"] = {"B2FFFF", "blue"},
	["PowderBlue"] = {"B0E0E6", "blue"},
	["SkyBlue"] = {"ADD8E6", "blue"},
	["ElectricBlue"] = {"7DF9FF", "blue"},
	["BeauBlue"] = {"BCD4E6", "blue"},
	["SteelBlue"] = {"4682B4", "blue"},
	["CarolinaBlue"] = {"4B9CD3", "blue"},
	["MayaBlue"] = {"73C2FB", "blue"},
	["Teal"] = {"008080", "blue"},
	["IndependentBlue"] = {"4682B4", "blue"},
	["Azure"] = {"007FFF", "blue"},
	["PrussianBlue"] = {"003153", "blue"},
	["Cobalt"] = {"0047AB", "blue"},
	["SpaceCadet"] = {"1D2951", "blue"},
	["QueenBlue"] = {"436B95", "blue"},
	["Periwinkle"] = {"CCCCFF", "blue"},
	["MorningBlue"] = {"8DA399", "blue"},
	["FluorescentBlue"] = {"15F4EE", "blue"},
	["AdmiralBlue"] = {"2C3863", "blue"},
	["AeroBlue"] = {"C9FFE5", "blue"},
	["AliceBlue"] = {"F0F8FF", "blue"},
	["ArcticBlue"] = {"C6E6FB", "blue"},
	["AhoyBlue"] = {"0082A1", "blue"},
	--Yellow
	["Yellow"] = {"FEDF00", "yellow"},
	["SunshineYellow"] = {"FFFD37", "yellow"},
	["CanaryYellow"] = {"FFEF00", "yellow"},
	["LemonYellow"] = {"FDFF00", "yellow"},
	["Goldenrod"] = {"DAA520", "yellow"},
	["Saffron"] = {"F4C430", "yellow"},
	["Citrine"] = {"E4D00A", "yellow"},
	["Trombone"] = {"D2B55B", "yellow"},
	["LightYellow"] = {"FFFFE0", "yellow"},
	["LemonChiffon"] = {"FFFACD", "yellow"},
	["Flax"] = {"EEDC82", "yellow"},
	["LightGoldenrod"] = {"FAFAD2", "yellow"},
	["Gold"] = {"FFD700", "yellow"},
	["SafetyYellow"] = {"EED202", "yellow"},
	["LemonYellow"] = {"FDFF00", "yellow"},
	["Cream"] = {"FFFFCC", "yellow"},
	["Laguna"] = {"F8E473", "yellow"},
	["SuppleOrange"] = {"E8AC41", "yellow"},
	["NeonYellow"] = {"CFFF04", "yellow"},
	["Sand"] = {"E2CA76", "yellow"},
	["Sunflower"] = {"FFDA03", "yellow"},
	["Bumblebee"] = {"FCE205", "yellow"},
	["Butter"] = {"FFFD74", "yellow"},
	["YellowTan"] = {"FFE36E", "yellow"},
	["CyberYellow"] = {"FFD300", "yellow"},
	["Banana"] = {"FFE135", "yellow"},
	["Honey"] = {"FFC30B", "yellow"},
	["Dijon"] = {"C49102", "yellow"},
	["Amber"] = {"FFBF00", "yellow"},
	["Beige"] = {"F5F5DC", "yellow"},
	["Mustard"] = {"FEDC56", "yellow"},
	["Moccasin"] = {"FFE4B5", "yellow"},
	["Orange"] = {"FFAD01", "yellow"},
	["TaxiYellow"] = {"FDB813", "yellow"},
	["FluorescentYellow"] = {"CCFF00", "yellow"},
	["IndianYellow"] = {"E3A857", "yellow"},
	["EarthYellow"] = {"E1A95F", "yellow"},
	["Bronze"] = {"737000", "yellow"},
	["SulfurYellow"] = {"E8DE35", "yellow"},
	["Dust"] = {"D4CC9A", "yellow"},
	["Buff"] = {"F1BF70", "yellow"},
	["SignalYellow"] = {"F2A900", "yellow"},
	["LemonLime"] = {"DFE69F", "yellow"},
	["OldYellow"] = {"C8AF55", "yellow"},
	["Turmeric"] = {"F0CA28", "yellow"},
	["Napoli"] = {"FFCF99", "yellow"},
	--Green
	["Green"] = {"00ff00", "green"},
	["Olive"] = {"708238", "green"},
	["HunterGreen"] = {"3F704D", "green"},
	["Artichoke"] = {"8F9779", "green"},
	["Verdant"] = {"12674a", "green"},
	["MyrtleGreen"] = {"317873", "green"},
	["Emerald"] = {"50C878", "green"},
	["Pine"] = {"A4FF77", "green"},
	["NeonGreen"] = {"39FF14", "green"},
	["SacramentoGreen"] = {"043927", "green"},
	["SeaGreen"] = {"2E8B57", "green"},
	["Sage"] = {"9DC183", "green"},
	["Lime"] = {"C7EA46", "green"},
	["Jade"] = {"00A86B", "green"},
	["Fern"] = {"4F7942", "green"},
	["Laurel"] = {"A9BA9D", "green"},
	["Mint"] = {"98FB98", "green"},
	["ArmyGreen"] = {"4B5320", "green"},
	["KellyGreen"] = {"4CBB17", "green"},
	["ParisGreen"] = {"50C878", "green"},
	["MidnightGreen"] = {"004953", "green"},
	["IndiaGreen"] = {"138808", "green"},
	["Celadon"] = {"ACE1AF", "green"},
	["Avocado"] = {"568203", "green"},
	["Harlequin"] = {"3FFF00", "green"},
	["Spring"] = {"00F0A8", "green"},
	["Chateau"] = {"48A860", "green"},
	["Viridian"] = {"609078", "green"},
	["Chetwode"] = {"F0FFF0", "green"},
	["Shamrock"] = {"009E60", "green"},
	["BrightMint"] = {"4FFFB0", "green"},
	["BottleGreen"] = {"006A4E", "green"},
	["CamoGreen"] = {"78866B", "green"},
	["Caribbean"] = {"00CC99", "green"},
	["Feldgrau"] = {"4D5D53", "green"},
	["Malachite"] = {"0BDA51", "green"},
	["Chartreuse"] = {"7FFF00", "green"}, -- reuse the chart!
	["Shrek"] = {"C4D300", "green"},
	--Purple
	["Purple"] = {"A32CC4", "purple"},
	["Thistle"] = {"D8BFD8", "purple"},
	["Plum"] = {"DDA0DD", "purple"},
	["Violet"] = {"8F00FF", "purple"},
	["Orchid"] = {"DA70D6", "purple"},
	["Fuchsia"] = {"FF00FF", "purple"},
	["MediumPurple"] = {"9370DB", "purple"},
	["Indigo"] = {"4B0082", "purple"},
	["Veronica"] = {"A020F0", "purple"},
	["Mauve"] = {"E0B0FF", "purple"},
	["Heliotrope"] = {"DF73FF", "purple"},
	["Phlox"] = {"DF00FF", "{purple"},
	["Liserian"] = {"DE6FA1", "purple"},
	["Mulberry"] = {"C54B8C", "purple"},
	["Pansy"] = {"78184A", "purple"},
	["Palatinate"] = {"72246C", "purple"},
	["DeepPurple"] = {"301934", "purple"},
	["AfricanViolet"] = {"B284BE", "purple"},
	--Brown
	["Chocolate"] = {"2B1700", "brown"},
	["Umber"] = {"362312", "brown"},
	["Mocha"] = {"3B270C", "brown"},
	["Hickory"] = {"351E10", "brown"},
	["Coffee"] = {"4B3619", "brown"},
	["Brown"] = {"48260D", "brown"}, --Pecan
	["Wood"] = {"402F1D", "brown"},
	--Red
	["Red"] = {"D0312D", "red"},
	["ImperialRed"] = {"ED2939", "red"},
	["Scarlet"] = {"FF2400", "red"},
	["IndianRed"] = {"CD5C5C", "red"},
	["Barn"] = {"7C0A02", "red"},
	["Chili"] = {"C21807", "red"},
	["Maroon"] = {"800000", "red"},
	["FireBrick"] = {"B22222", "red"},
	["Redwood"] = {"A45A52", "red"},
	["Carmine"] = {"960018", "red"},
	["Desire"] = {"EA3C53", "red"},
	["Vermillion"] = {"7E191B", "red"},
	["Raspberry"] = {"D21F3C", "red"},
	["CandyApple"] = {"FF0800", "red"},
	["Persian"] = {"CA3433", "red"},
	["Hibiscus"] = {"B43757", "red"},
	["Sangria"] = {"5E1914", "red"},
	["Mahogany"] = {"420D09", "red"},
	["Burgandy"] = {"8D021F", "red"},
	["Crimson"] = {"B80F0A", "red"},
	["Rust"] = {"933A16", "red"},
	["Salmon"] = {"FA8072", "red"},
	["Tomato"] = {"FF6347", "red"},
	["BloodRed"] = {"660000", "red"},
	["Vixen"] = {"97131A", "red"}, -- Vermillion Scarlet
	--White
	["White"] = {"FFFFFF", "white"},
	["Smoke"] = {"F5F5F5", "white"},
	["BabyPowder"] = {"FEFEFA", "white"},
	["Snow"] = {"F5FEFD", "white"},
	["Silver"] = {"777781", "white"},
	["Ivory"] = {"FFFFF0", "white"},
	["Seashell"] = {"FFF5EE", "white"},
	["Cornsilk"] = {"FFF8DC", "white"},
	["OldLace"] = {"FDF5E6", "white"},
	["Parchment"] = {"F1E9D2", "white"},
	["AntiqueWhite"] = {"FAEBD7", "white"},
	["Champagne"] = {"F7E7CE", "white"},
	["Eggshell"] = {"F0EAD6", "white"},
	["Bone"] = {"E3DAC9", "white"},
	["Alabaster"] = {"EDEAE0", "white"},
	
	--Black
	["Black"] = {"000000", "black"},
	["Abbey"] = {"494F55", "black"},
	["Ash"] = {"666362", "black"},
	["Asphalt"] = {"0C0404", "black"},
	["BlackCat"] = {"413839", "black"},
	["BlackCow"] = {"4C4646", "black"},
	["Charcoal"] = {"36454F", "black"},
	["Ebony"] = {"555D50", "black"},
	["Granite"] = {"676767", "black"},
	["Gray"] = {"808080", "black"},
	["Gunmetal"] = {"2C3539", "black"},
	["Iridium"] = {"3D3C3A", "black"},
	["Jet"] = {"343434", "black"},
	["Obsidian"] = {"0D031B", "black"},
	["Licorice"] = {"1A1110", "black"},
	["Oil"] = {"3B3131", "black"},
}

function Color(name)
	local pre = "|cff"
	if ColorTable[name] then
		return pre..ColorTable[name][1]
	end
end



function GetHexColor(clr)
	if ColorTable[clr] and ColorTable[clr][1] then
		return ColorTable[clr][1]
	end
end

function SetColorGroup(group)
	if ColorTable.DEX[group] then
		currentGroup = group
		curDex = 0
		group = caPit(group)
		Ramble("color group set to "..colorMe(group,group)..".", colorMe("[ColorMe] ", "Pine"))
	elseif group and ColorTable[caPit(group)] then
		group = caPit(group)
		currentGroup = ColorTable[group][2]
		curDex = 0
		local brk
		local tbl = ColorTable.DEX[currentGroup]
		repeat
			curDex = curDex + 1
			if curDex > #tbl then
				brk = "shit:"
				curDex = 0
			elseif tbl[curDex] == group then
				brk = true
				--curDex = curDex - 1
			end
		until brk
		if L_DBG >= 1 then
			Ramble(colorMe(group, group),colorMe("[ColorMe] ", "Pine"))
		end
		SetLoco("coLor",group)
	else
		Ramble("~invalid color group~", 1, "|cff00ff00[ColorMe]|r|cffa4ff77 |r")
	end
end

function raInBow(cG, cD)
	currentGroup = cG
	curDex = cD
	if curDex > #ColorTable.DEX[currentGroup] then
		curDex = 1
	end
end

function GetNextColor(tag)
	if tag and ColorTable.DEX[tag] then
		currentGroup = tag
	end
	
	if currentGroup and curDex then
		curDex = curDex + 1
		if curDex > #ColorTable.DEX[currentGroup] then
			curDex = 1
		end
		curClr = ColorTable.DEX[currentGroup][curDex]
	end
	return curClr, Color(curClr), currentGroup, curDex
end

function popClrTbl()
	local tbl = ColorTable.DEX
	for k,v in pairs(tbl) do
		for c,d in pairs(ColorTable) do
			if c ~= "DEX" then
				if d[2] == k then
					table.insert(ColorTable.DEX[k], c)
				end
			end
		end
	end
end


