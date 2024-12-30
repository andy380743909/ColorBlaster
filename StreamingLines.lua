-- This class draws the lines streaming past in the background
-- of the game. We spawn and delete them in the self.lines table

----------------------------------------------
-- Single line
----------------------------------------------
StreamLine = class:new()
function StreamLine:init(pos, vel)
    self.position = pos
    self.velocity = vel
end

function StreamLine:update()
    self.position.y = self.position.y + self.velocity
end

function StreamLine:draw()
    p = self.position
    love.graphics.line(p.x, p.y, p.x, p.y + self.velocity)
end

function StreamLine:shouldCull()
    -- Check if off the bottom of the screen
    if (self.position.y + self.velocity) > love.graphics.getHeight() then
        return true
    end 

    return false
end

----------------------------------------------
-- All lines
----------------------------------------------
StreamingLines = class:new()

function StreamingLines:init()
    self.minSpeed = 5
    self.speed = 30
    self.spawnRate = 2
    self.lines = {}
end

function StreamingLines:updateAndCull()
    toCull = {}
    for i,v in ipairs(self.lines) do
        if v:shouldCull() then
            table.remove( self.lines, i )
        else
            v:update()
        end
    end
end

function StreamingLines:update()
    -- Create spawnRate lines per update
    for i = 1,self.spawnRate do
        -- Generate random spawn location
        vel = math.random(self.minSpeed, self.speed)
        spawn = vec2:new(math.random(love.graphics.getWidth()), 0)

        table.insert(self.lines, StreamLine:new(spawn, vel))
    end

    -- Update and cull offscreen lines
    self:updateAndCull()
end

function StreamingLines:draw()
    love.graphics.setColor(179/255.0, 153/255.0, 180/255.0, 173/255.0)
    for i,v in ipairs(self.lines) do
        v:draw()
    end
end
