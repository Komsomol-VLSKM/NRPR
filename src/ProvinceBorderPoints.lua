-- ServerScriptService/ProvinceBorderPoints

local ProvinceBorderPoints = {}

-- Keeps the point safely on the main province instead of exactly between provinces.
-- 0 would be the exact mathematical border, but it can sometimes raycast weirdly on unions.
local BORDER_INSET = 0.08

local function cellKey(x, z)
	return tostring(x) .. "," .. tostring(z)
end

local function getCellWorldCenter(index, cell)
	local cellSize = index.cellSize or 1

	local worldX = index.minX + cellSize / 2 + cell.x * cellSize
	local worldZ = index.minZ + cellSize / 2 + cell.z * cellSize

	return worldX, worldZ
end

function ProvinceBorderPoints.GetBorderPoint(mainProvince, neighborProvince, index)
	local mainCells = index.provinceToCells[mainProvince]

	if not mainCells then
		warn("Main province not found in index:", mainProvince.Name)
		return nil
	end

	local cellSize = index.cellSize or 1

	local directions = {
		{ x = 1, z = 0 },
		{ x = -1, z = 0 },
		{ x = 0, z = 1 },
		{ x = 0, z = -1 },
	}

	local candidates = {}

	for _, cell in ipairs(mainCells) do
		for _, direction in ipairs(directions) do
			local neighborKey = cellKey(
				cell.x + direction.x,
				cell.z + direction.z
			)

			local foundProvince = index.cellToProvince[neighborKey]

			if foundProvince == neighborProvince then
				local centerX, centerZ = getCellWorldCenter(index, cell)

				local borderX = centerX + direction.x * ((cellSize / 2) - BORDER_INSET)
				local borderZ = centerZ + direction.z * ((cellSize / 2) - BORDER_INSET)

				table.insert(candidates, {
					x = borderX,
					z = borderZ,
				})
			end
		end
	end

	if #candidates == 0 then
		warn(mainProvince.Name .. " does not border " .. neighborProvince.Name)
		return nil
	end

	-- Find a nice central border point, but still use a real border candidate.
	local averageX = 0
	local averageZ = 0

	for _, candidate in ipairs(candidates) do
		averageX += candidate.x
		averageZ += candidate.z
	end

	averageX /= #candidates
	averageZ /= #candidates

	local bestCandidate = candidates[1]
	local bestDistance = math.huge

	for _, candidate in ipairs(candidates) do
		local dx = candidate.x - averageX
		local dz = candidate.z - averageZ
		local distance = dx * dx + dz * dz

		if distance < bestDistance then
			bestDistance = distance
			bestCandidate = candidate
		end
	end

	return Vector3.new(bestCandidate.x, 1, bestCandidate.z)
end

return ProvinceBorderPoints
