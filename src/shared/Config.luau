-- Config.luau
-- Shared game constants — tweak these to change how the game feels

local Config = {}

Config.ROUND_TIME  = 90   -- seconds per round
Config.BUY_TIME    = 15   -- seconds at round start where buying is allowed
Config.WARMUP_TIME = 10   -- seconds before the first round
Config.MAX_ROUNDS  = 15   -- first team to (MAX_ROUNDS/2 + 1) wins the match

Config.TEAMS = {
    CT = "Counter-Terrorists",
    T  = "Terrorists",
}

return Config
