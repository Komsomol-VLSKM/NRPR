local Players = game:GetService("Players")
print("running")
local ProvinceBorders = loadstring(game:HttpGet("https://raw.githubusercontent.com/Komsomol-VLSKM/NRPR/refs/heads/main/src/ProvinceBorders.lua"))()
print("1")
local ProvinceBorderPoints = loadstring(game:HttpGet("https://raw.githubusercontent.com/Komsomol-VLSKM/NRPR/refs/heads/main/src/ProvinceBorderPoints.lua"))()
print("2")
local RemoteCalls = loadstring(game:HttpGet("https://raw.githubusercontent.com/Komsomol-VLSKM/NRPR/refs/heads/main/src/RemoteCalls.lua"))()
print("3")
local RunService = game:GetService("RunService")

local Unit = loadstring(game:HttpGet("https://raw.githubusercontent.com/Komsomol-VLSKM/NRPR/refs/heads/main/src/class/Unit.lua"))()

local provincesFolder = workspace.Map

local player = Players.LocalPlayer

--player.CharacterAdded:Wait()

--wait(3)
print("loading map")

local index = ProvinceBorders.BuildIndex(provincesFolder)
print("map loaded")

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

local function spawnTroop()
	local args = {
		workspace:WaitForChild("Map"):WaitForChild("Province"),
		vector.create(-21.56826400756836, -58.49993896484375, 86.84256744384766),
		"Troop"
	}
	game:GetService("ReplicatedStorage"):WaitForChild("SpawnTroop"):FireServer(unpack(args))
	
end

mouse.Button1Down:Connect(function()
	local target = mouse.Target
	if not target then return end
	if target.Parent ~= provincesFolder then return end
	
	local bordering = ProvinceBorders.GetBorderingProvinces(target, index)
	
	local borderPoints = {}
	
	for _, neighbor in ipairs(bordering) do
		table.insert(borderPoints, {ProvinceBorderPoints.GetBorderPoint(target, neighbor, index, nil, 1)})
	end
	
	for _, borderPoint in ipairs(borderPoints) do
		local pointY = -58.5
		if RunService:IsStudio() then
			pointY = 1
		end
		
		local point = borderPoint[1]
		
		local unit = Unit.new("Troop", Vector3.new(point.x, pointY, point.z), target)
		
		local point = borderPoint[2]
		
		unit:move(Vector3.new(point.x, pointY, point.z))
	end
end)
