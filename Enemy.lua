Enemy = class:new()

function Enemy:init(x, y, color)
    self.position = vec2:new(x, y)
    self.speed = math.random(1, 5)
    self.color = color
    self.glowSize = 0
    self.glowing = true
end

function Enemy:draw()
    self:setColor(false)
    love.graphics.circle("fill", self.position.x, self.position.y, 12, 12)
    self:setColor(true)
    love.graphics.circle("fill", self.position.x, self.position.y, self.glowSize/2, self.glowSize/2)
end

function Enemy:setColor(glow)
    if (glow and not self.glowing) or (not glow and self.glowing) then
        if self.color == 0 then
            love.graphics.setColor(194, 23, 29, 255)
        else
            love.graphics.setColor(17, 41, 194, 255)
        end
    else
        if self.color == 0 then
            love.graphics.setColor(235, 66, 66, 255)
        else
            love.graphics.setColor(60, 62, 237, 255)
        end
    end
end

function Enemy:update()
    self.position.y = self.position.y + self.speed
    self.glowSize = self.glowSize + 5
    if self.glowSize > 25 then
        self.glowSize = 0
        self.glowing = not self.glowing
    end
end