-- Zones.lua
local Zones = {}
local ws = game:GetService("Workspace")

local function isPointInPart(point, part)
    local relativePosition = part.CFrame:pointToObjectSpace(point)
    local halfSize = part.Size / 2
    return math.abs(relativePosition.X) <= halfSize.X and
           math.abs(relativePosition.Y) <= halfSize.Y and
           math.abs(relativePosition.Z) <= halfSize.Z
end

function Zones.getCurrentZone(hrpPosition)
    for _, zone in ipairs(ws:WaitForChild("BreakableAreas"):GetChildren()) do
        local zonePart = zone:FindFirstChild("Part")
        if zonePart and isPointInPart(hrpPosition, zonePart) then
            return zone.Name
        end
    end
    return nil
end

function Zones.getBreakableZone(hitboxPosition)
    for _, zone in ipairs(ws:WaitForChild("BreakableAreas"):GetChildren()) do
        local zonePart = zone:FindFirstChild("Part")
        if zonePart and isPointInPart(hitboxPosition, zonePart) then
            return zone.Name
        end
    end
    return nil
end

return Zones
