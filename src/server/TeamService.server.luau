-- TeamService.server.luau
-- Assigns players to CT or T teams, balanced by headcount

local Players = game:GetService("Players")
local Teams   = game:GetService("Teams")
local Config  = require(game.ReplicatedStorage.Shared.Config)

-- Create a team if it doesn't already exist
local function getOrCreateTeam(name: string, color: BrickColor): Team
    local existing = Teams:FindFirstChild(name)
    if existing then return existing end

    local team = Instance.new("Team")
    team.Name           = name
    team.TeamColor      = color
    team.AutoAssignable = false
    team.Parent         = Teams
    return team
end

local ctTeam = getOrCreateTeam(Config.TEAMS.CT, BrickColor.new("Bright blue"))
local tTeam  = getOrCreateTeam(Config.TEAMS.T,  BrickColor.new("Bright red"))

-- Put the player on whichever side has fewer members
local function assignTeam(player: Player)
    local ctCount = #ctTeam:GetPlayers()
    local tCount  = #tTeam:GetPlayers()

    if ctCount <= tCount then
        player.Team      = ctTeam
        player.TeamColor = ctTeam.TeamColor
    else
        player.Team      = tTeam
        player.TeamColor = tTeam.TeamColor
    end

    print(("[TeamService] %s → %s"):format(player.Name, player.Team.Name))
end

Players.PlayerAdded:Connect(assignTeam)

-- Handle players already present (Studio play-test)
for _, player in Players:GetPlayers() do
    assignTeam(player)
end
