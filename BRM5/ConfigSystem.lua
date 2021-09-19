local ConfigSystem = {}

local HttpService = game:GetService("HttpService")

local function Color3ToTable(Color3)
	return {
		["R"] = Color3.R,
		["G"] = Color3.G,
		["B"] = Color3.B
	}
end

local function TableToColor3(Table)
	return Color3.fromRGB(Table["R"] * 255,Table["G"] * 255,Table["B"] * 255)
end

function shallowcopy(orig) -- I hate this fucking function very much
	local orig_type = type(orig)
	local copy
	if orig_type == 'table' then
		copy = {}
		for orig_key, orig_value in pairs(orig) do
			copy[orig_key] = orig_value
		end
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end


function ConfigSystem.WriteJSON(Table)
    local TableCopy = shallowcopy(Table)
	for Index,Element in pairs(TableCopy) do
		if typeof(Element) == "Color3" then
			TableCopy[Index] = Color3ToTable(Element)
		end
	end
	return HttpService:JSONEncode(TableCopy)
end

function ConfigSystem.ReadJSON(JSON)
	local Table = HttpService:JSONDecode(JSON)
	for Index,Element in pairs(Table) do
		if typeof(Element) == "table" and (Element["R"] and Element["G"] and Element["B"]) then
			Table[Index] = TableToColor3(Element)
		end
	end
	return Table
end

return ConfigSystem
