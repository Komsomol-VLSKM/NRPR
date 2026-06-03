local Players = game:GetService("Players")
local ProvinceBorders = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Komsomol-VLSKM/NRPR/refs/heads/main/src/ProvinceBorders.lua"))--require(game.ReplicatedStorage.ProvinceBorders)
local ProvinceBorderPoints = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Komsomol-VLSKM/NRPR/refs/heads/main/src/ProvinceBorderPoints.lua"))--require(game.ReplicatedStorage.ProvinceBorderPoints)

local provincesFolder = workspace.Germany

local player = Players.LocalPlayer

player.CharacterAdded:Wait()

wait(3)
print("loading map")

local index = ProvinceBorders.BuildIndex(provincesFolder)
print("map loaded")

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

mouse.Button1Down:Connect(function()
	local target = mouse.Target
	if not target then return end
	if target.Parent ~= provincesFolder then return end
	
	target.Color = Color3.new(1, 0, 0)
	local bordering = ProvinceBorders.GetBorderingProvinces(target, index)
	
	local borderPoints = {}
	
	for _, neighbor in ipairs(bordering) do
		table.insert(borderPoints, ProvinceBorderPoints.GetBorderPoint(target, neighbor, index))
	end
	
	for _, point in ipairs(borderPoints) do
		local part = Instance.new("Part")
		part.Size = Vector3.new(1, 1, 1)
		part.Position = Vector3.new(point.x, 1, point.z)
		part.Anchored = true
		part.Parent = workspace
		part.BrickColor = BrickColor.new("Bright red")
	end
end)
