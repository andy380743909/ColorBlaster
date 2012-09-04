vec2 = class:new()

function vec2:init(x, y)
	self.x = x
	self.y = y
end

function vec2:dist(v)
	return math.sqrt(math.pow(self.x - v.x, 2) + math.pow(self.y - v.y, 2));
end