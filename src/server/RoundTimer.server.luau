-- RoundTimer.server.luau
-- Drives the round loop: Warmup → Buy Phase → Round → Round End → repeat.
-- Broadcasts phase + seconds remaining via RemoteEvent for a client HUD.

local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Config            = require(game.ReplicatedStorage.Shared.Config)

-- RemoteEvent the client HUD will listen to
local timerEvent        = Instance.new("RemoteEvent")
timerEvent.Name         = "RoundTimerUpdate"
timerEvent.Parent       = ReplicatedStorage

local function broadcast(phase: string, seconds: number)
    timerEvent:FireAllClients(phase, seconds)
    print(("[RoundTimer] %s — %ds"):format(phase, seconds))
end

local function countdown(phase: string, duration: number)
    for remaining = duration, 0, -1 do
        broadcast(phase, remaining)
        task.wait(1)
    end
end

local function runGame()
    countdown("WARMUP", Config.WARMUP_TIME)

    while true do
        countdown("BUY",       Config.BUY_TIME)
        countdown("ROUND",     Config.ROUND_TIME)
        broadcast("ROUND_END", 5)
        task.wait(5)
    end
end

-- Wait for at least one player before starting
task.spawn(function()
    if #Players:GetPlayers() == 0 then
        Players.PlayerAdded:Wait()
    end
    runGame()
end)
