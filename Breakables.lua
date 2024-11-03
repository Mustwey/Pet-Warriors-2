-- Breakables.lua
local Breakables = {}
local ws = game:GetService("Workspace")
local Zones = require(script.Parent.Zones)

function Breakables.getBreakables(hrpPosition, allowedZones, radius)
    local breakables = {}
    local currentZone = Zones.getZone(hrpPosition)

    for _, breakable in ipairs(ws:WaitForChild("Breakables"):GetChildren()) do
        local hitbox = breakable:FindFirstChild("Hitbox")
        if hitbox then
            local breakableZone = Zones.getZone(hitbox.Position)
            local distance = (hitbox.Position - hrpPosition).Magnitude

            if (not allowedZones or table.find(allowedZones, breakableZone)) and 
               (not radius or distance <= radius) and 
               (breakableZone == currentZone or not allowedZones) then
                table.insert(breakables, { breakable = breakable, distance = distance })
            end
        end
    end

    return breakables
end

return Breakables
