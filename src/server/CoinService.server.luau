-- CoinService.server.luau
-- Spawns glowing gold coins around the map.
-- Touch a coin → earn points on the leaderboard → coin respawns after a few seconds.

local Players = game:GetService("Players")

-- ── Tune these to make the game easier or harder ─────────────────────────────
local COIN_COUNT    = 20   -- how many coins live in the world at once
local COIN_REWARD   = 1    -- points awarded per coin
local RESPAWN_DELAY = 3    -- seconds before a collected coin reappears
local COIN_RADIUS   = 80   -- how far from the centre coins can spawn (studs)
local COIN_HEIGHT   = 2    -- how high coins float above the ground
-- ─────────────────────────────────────────────────────────────────────────────

-- Set up the leaderboard for every player who joins
local function onPlayerAdded(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local coins = Instance.new("IntValue")
	coins.Name = "Coins"
	coins.Value = 0
	coins.Parent = leaderstats
end

Players.PlayerAdded:Connect(onPlayerAdded)
for _, player in Players:GetPlayers() do
	onPlayerAdded(player)
end

-- Build a single coin Part
local function makeCoin()
	local part = Instance.new("Part")
	part.Name       = "Coin"
	part.Shape      = Enum.PartType.Cylinder
	part.Size       = Vector3.new(0.3, 2, 2)
	part.BrickColor = BrickColor.new("Bright yellow")
	part.Material   = Enum.Material.SmoothPlastic
	part.CanCollide = false
	part.Anchored   = true
	part.CastShadow = false
	-- Tilt so the flat face points upward (coin-like)
	part.CFrame     = CFrame.Angles(0, 0, math.rad(90))

	-- Golden glow
	local light = Instance.new("PointLight")
	light.Brightness = 1.5
	light.Color      = Color3.fromRGB(255, 215, 0)
	light.Range      = 10
	light.Parent     = part

	return part
end

-- Pick a random position on the map
local function randomSpawnPosition()
	local angle  = math.random() * 2 * math.pi
	local radius = math.random(10, COIN_RADIUS)
	return Vector3.new(
		math.cos(angle) * radius,
		COIN_HEIGHT,
		math.sin(angle) * radius
	)
end

-- Spawn one coin, wire up the touch handler, handle respawn
local function spawnCoin()
	local coin = makeCoin()
	coin.Position = randomSpawnPosition()
	coin.Parent   = workspace

	local collected = false

	coin.Touched:Connect(function(hit)
		if collected then return end   -- ignore double-touches

		local character = hit.Parent
		local player    = Players:GetPlayerFromCharacter(character)
		if not player then return end

		-- Award the point
		local stats = player:FindFirstChild("leaderstats")
		if stats and stats:FindFirstChild("Coins") then
			stats.Coins.Value += COIN_REWARD
		end

		-- Remove coin and schedule respawn
		collected     = true
		coin.Parent   = nil
		coin:Destroy()

		task.delay(RESPAWN_DELAY, spawnCoin)
	end)
end

-- Kick everything off
for _ = 1, COIN_COUNT do
	spawnCoin()
end
