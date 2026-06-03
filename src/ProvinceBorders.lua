-- ServerScriptService/ProvinceBorders

local ProvinceBorders = {}

local CELL_SIZE = 1
local YIELD_EVERY = 1000

local function cellKey(x, z)
	return tostring(x) .. "," .. tostring(z)
end

local function getPartAABB(part)
	local cf = part.CFrame
	local halfSize = part.Size / 2

	local right = cf.RightVector
	local up = cf.UpVector
	local look = cf.LookVector

	local halfX =
		math.abs(right.X) * halfSize.X +
		math.abs(up.X) * halfSize.Y +
		math.abs(look.X) * halfSize.Z

	local halfY =
		math.abs(right.Y) * halfSize.X +
		math.abs(up.Y) * halfSize.Y +
		math.abs(look.Y) * halfSize.Z

	local halfZ =
		math.abs(right.Z) * halfSize.X +
		math.abs(up.Z) * halfSize.Y +
		math.abs(look.Z) * halfSize.Z

	local pos = cf.Position

	return
		Vector3.new(pos.X - halfX, pos.Y - halfY, pos.Z - halfZ),
	Vector3.new(pos.X + halfX, pos.Y + halfY, pos.Z + halfZ)
end

local function collectProvinceParts(provincesFolder)
	local provinces = {}
	local queryParts = {}
	local partToProvince = {}

	for _, province in ipairs(provincesFolder:GetChildren()) do
		if province:IsA("BasePart") then
			table.insert(provinces, province)
			table.insert(queryParts, province)

			partToProvince[province] = province
			province.CanQuery = true
		else
			local hasPart = false

			for _, descendant in ipairs(province:GetDescendants()) do
				if descendant:IsA("BasePart") then
					hasPart = true

					table.insert(queryParts, descendant)
					partToProvince[descendant] = province

					descendant.CanQuery = true
				end
			end

			if hasPart then
				table.insert(provinces, province)
			end
		end
	end

	return provinces, queryParts, partToProvince
end

local function precomputeBorders(index)
	local directions = {
		{ x = 1, z = 0 },
		{ x = -1, z = 0 },
		{ x = 0, z = 1 },
		{ x = 0, z = -1 },
	}

	local neighborSets = {}
	local provinceNeighbors = {}
	local borderCells = {}

	for province in pairs(index.provinceToCells) do
		neighborSets[province] = {}
		provinceNeighbors[province] = {}
		borderCells[province] = {}
	end

	for _, cell in ipairs(index.occupiedCells) do
		local province = cell.province

		for _, direction in ipairs(directions) do
			local neighborKey = cellKey(
				cell.x + direction.x,
				cell.z + direction.z
			)

			local neighborProvince = index.cellToProvince[neighborKey]

			if neighborProvince and neighborProvince ~= province then
				if not neighborSets[province][neighborProvince] then
					neighborSets[province][neighborProvince] = true
					table.insert(provinceNeighbors[province], neighborProvince)
				end

				borderCells[province][neighborProvince] =
					borderCells[province][neighborProvince] or {}

				table.insert(borderCells[province][neighborProvince], {
					x = cell.x,
					z = cell.z,
					dx = direction.x,
					dz = direction.z,
				})
			end
		end
	end

	index.provinceNeighbors = provinceNeighbors
	index.borderCells = borderCells
end

function ProvinceBorders.BuildIndex(provincesFolder)
	local startTime = os.clock()

	local provinces, queryParts, partToProvince =
		collectProvinceParts(provincesFolder)

	if #queryParts == 0 then
		warn("No province parts found.")
		return nil
	end

	local minX = math.huge
	local minY = math.huge
	local minZ = math.huge

	local maxX = -math.huge
	local maxY = -math.huge
	local maxZ = -math.huge

	for _, part in ipairs(queryParts) do
		local partMin, partMax = getPartAABB(part)

		minX = math.min(minX, partMin.X)
		minY = math.min(minY, partMin.Y)
		minZ = math.min(minZ, partMin.Z)

		maxX = math.max(maxX, partMax.X)
		maxY = math.max(maxY, partMax.Y)
		maxZ = math.max(maxZ, partMax.Z)
	end

	local cellsX = math.ceil((maxX - minX) / CELL_SIZE)
	local cellsZ = math.ceil((maxZ - minZ) / CELL_SIZE)

	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Include
	raycastParams.FilterDescendantsInstances = queryParts

	local rayOriginY = maxY + 50
	local rayDistance = (maxY - minY) + 100

	local cellToProvince = {}
	local provinceToCells = {}
	local occupiedCells = {}

	for _, province in ipairs(provinces) do
		provinceToCells[province] = {}
	end

	local checked = 0

	for xIndex = 0, cellsX - 1 do
		for zIndex = 0, cellsZ - 1 do
			local worldX = minX + CELL_SIZE / 2 + xIndex * CELL_SIZE
			local worldZ = minZ + CELL_SIZE / 2 + zIndex * CELL_SIZE

			local origin = Vector3.new(worldX, rayOriginY, worldZ)
			local direction = Vector3.new(0, -rayDistance, 0)

			local result = workspace:Raycast(origin, direction, raycastParams)

			if result then
				local province = partToProvince[result.Instance]

				if province then
					local key = cellKey(xIndex, zIndex)

					cellToProvince[key] = province

					local cell = {
						x = xIndex,
						z = zIndex,
						province = province,
					}

					table.insert(provinceToCells[province], cell)
					table.insert(occupiedCells, cell)
				end
			end

			checked += 1

			if checked % YIELD_EVERY == 0 then
				task.wait()
			end
		end
	end

	local index = {
		cellToProvince = cellToProvince,
		provinceToCells = provinceToCells,
		occupiedCells = occupiedCells,

		minX = minX,
		minZ = minZ,
		maxY = maxY,
		cellSize = CELL_SIZE,
	}

	precomputeBorders(index)

	--print("Province index built.")
	print("Provinces:", #provinces)
	--print("Occupied cells:", #occupiedCells)
	print("Time:", math.round((os.clock() - startTime) * 100) / 100, "seconds")

	return index
end

function ProvinceBorders.GetBorderingProvinces(province, index)
	if not index.provinceNeighbors then
		warn("Index does not have cached province neighbors.")
		return {}
	end

	return index.provinceNeighbors[province] or {}
end

function ProvinceBorders.GetBorderCells(mainProvince, neighborProvince, index)
	if not index.borderCells then
		return {}
	end

	if not index.borderCells[mainProvince] then
		return {}
	end

	return index.borderCells[mainProvince][neighborProvince] or {}
end

return ProvinceBorders
