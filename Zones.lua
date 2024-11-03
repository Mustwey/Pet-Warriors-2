local Zones = {}
local ws = game:GetService("Workspace")

--  check if a point is within a specified part
local function isPointInPart(point, part)
    local relativePosition = part.CFrame:pointToObjectSpace(point)
    local halfSize = part.Size / 2
    return math.abs(relativePosition.X) <= halfSize.X and
           math.abs(relativePosition.Y) <= halfSize.Y and
           math.abs(relativePosition.Z) <= halfSize.Z
end

-- get the zone name for a given position
-- use this to get what zone the user is in and also what zone the breakable is in
function Zones.getZone(position)
    for _, zone in ipairs(ws:WaitForChild("BreakableAreas"):GetChildren()) do
        local zonePart = zone:FindFirstChild("Part")
        if zonePart and isPointInPart(position, zonePart) then
            return zone.Name
        end
    end
    return nil
end

return Zones
