PlayerCircle = class:new()

function PlayerCircle:init(x, y, color)
    self.position = vec2:new(x, y)
    self.color = color
    self.touching = 0
	self.moveSpeed = 10
end

function PlayerCircle:draw()
	love.graphics.setLineWidth(5)
    if self.color == 0 then
        love.graphics.setColor(204/255.0, 43/255.0, 43/255.0, 255/255.0)
    else
        love.graphics.setColor(69/255.0, 78/255.0, 204/255.0, 255/255.0)
    end
	love.graphics.circle("fill", self.position.x, self.position.y, 50, 50)
end

function PlayerCircle:touched(touch)
    if self.position:dist(vec2(touch.x, touch.y)) < 50 then
        self.position.x = math.min(love.graphics.getWidth() - 50, math.max(50, touch.x))
        self.position.y = math.min(love.graphics.getHeight() - 50, math.max(50, touch.y))
        self.touching = 10
        return true
    end
    return false
end

function PlayerCircle:move(dir)
	if dir == 0 then
		self.position.y = math.min(love.graphics.getHeight() - 50, math.max(50, self.position.y - self.moveSpeed))
	end
	if dir == 1 then
		self.position.x = math.min(love.graphics.getWidth() - 50, math.max(50, self.position.x + self.moveSpeed))
	end
	if dir == 2 then
		self.position.y = math.min(love.graphics.getHeight() - 50, math.max(50, self.position.y + self.moveSpeed))
	end
	if dir == 3 then
		self.position.x = math.min(love.graphics.getWidth() - 50, math.max(50, self.position.x - self.moveSpeed))
	end
	self.touching = 10
end