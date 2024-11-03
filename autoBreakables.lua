local rs = game:GetService("RunService")
local players = game:GetService("Players")
local rf = require(game:GetService("ReplicatedStorage"):WaitForChild("RobloxianFramework"))
local Breakables = loadstreing("yada")
local lp = players.LocalPlayer

while not rf.Loaded do
    rs.Heartbeat:Wait()
end

local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")

getgenv().flags = getgenv().flags or {}
getgenv().flags.autoBreakables = true
getgenv().coroutines = getgenv().coroutines or {}

local radius = 50
local method = "closest"

local function autoBreakables(method, radius)
    while getgenv().flags.autoBreakables do
        hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")

        if hrp then
            local breakables = Breakables.getBreakables(hrp.Position, nil, radius)

            if method == "closest" then
                table.sort(breakables, function(a, b) return a.distance < b.distance end)
            elseif method == "furthest" then
                table.sort(breakables, function(a, b) return a.distance > b.distance end)
            elseif method == "random" then
                for i = #breakables, 2, -1 do
                    local j = math.random(i)
                    breakables[i], breakables[j] = breakables[j], breakables[i]
                end
            end

            for _, info in ipairs(breakables) do
                local breakable = info.breakable
                pcall(function() rf.Network.Fire("ClickedBreakable", breakable.Name) end)

                while workspace:WaitForChild("Breakables"):FindFirstChild(breakable.Name) do
                    task.wait(0.5)
                end
            end
        end

        task.wait(1)
    end
end

getgenv().coroutines.autoBreakables = coroutine.create(function()
    autoBreakables(method, radius)
end)
coroutine.resume(getgenv().coroutines.autoBreakables)
