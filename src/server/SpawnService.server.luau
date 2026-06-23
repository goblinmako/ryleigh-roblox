-- SpawnService.server.luau
-- Teleports each player to their team's spawn point on character load.
-- Place SpawnLocation objects named "CT_Spawn" (or CT_Spawn_1, CT_Spawn_2…)
-- and "T_Spawn" (or T_Spawn_1, T_Spawn_2…) anywhere in Workspace.

local Players = game:GetService("Players")
local Config  = require(game.ReplicatedStorage.Shared.Config)

-- Collect all SpawnLocations whose names start with the given prefix
local function getSpawns(prefix: string): {SpawnLocation}
    local spawns = {}
    for _, obj in workspace:GetDescendants() do
        if obj:IsA("SpawnLocation") and obj.Name:sub(1, #prefix) == prefix then
            table.insert(spawns, obj)
        end
    end
    return spawns
end

local function pickRandom(spawns: {SpawnLocation}): SpawnLocation?
    if #spawns == 0 then return nil end
    return spawns[math.random(1, #spawns)]
end

local function teleportToSpawn(character: Model, spawn: SpawnLocation)
    local root = character:WaitForChild("HumanoidRootPart", 5)
    if root then
        root.CFrame = spawn.CFrame + Vector3.new(0, 3, 0)
    end
end

Players.PlayerAdded:Connect(function(player: Player)
    player.CharacterAdded:Connect(function(character: Model)
        task.wait(0.1) -- let physics settle

        local team = player.Team
        if not team then return end

        local prefix = (team.Name == Config.TEAMS.CT) and "CT_Spawn" or "T_Spawn"
        local spawns = getSpawns(prefix)
        local spawn  = pickRandom(spawns)

        if spawn then
            teleportToSpawn(character, spawn)
        else
            warn(("[SpawnService] No spawns found with prefix '%s' — add SpawnLocations to Workspace"):format(prefix))
        end
    end)
end)
