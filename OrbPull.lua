local ws = game:GetService("Workspace")
local lp = game.Players.LocalPlayer
local hrp = lp.Character:WaitForChild("HumanoidRootPart")

getgenv().flags = getgenv().flags or {}
getgenv().flags.orbPull = true
getgenv().coroutines = getgenv().coroutines or {}

local radius = nil -- Set to a number (e.g., 50) for a specific distance or nil for no restriction

local function pullOrbs(orbType, radius)
    while getgenv().flags.orbPull do
        for _, orb in ipairs(ws.Orbs:GetChildren()) do
            local distance = (orb.Position - hrp.Position).Magnitude
            if (not orbType or orb.Name == orbType) and (not radius or distance <= radius) then
                orb.CFrame = hrp.CFrame
            end
        end
        wait(1)
    end
end

getgenv().coroutines.orbPull = coroutine.create(function()
    pullOrbs(nil, radius)
end)

coroutine.resume(getgenv().coroutines.orbPull)
