ColorBlaster = class:new()

function ColorBlaster:start()
    circles = {}
    table.insert(circles, PlayerCircle:new(love.graphics.getWidth() / 3, love.graphics.getHeight() - 100, 0))
    table.insert(circles, PlayerCircle:new(love.graphics.getWidth() * 2 / 3, love.graphics.getHeight() - 100, 1))
    score = 0
    enemies = {}
    self:spawnEnemies(0, 3)
    self:spawnEnemies(1, 3)
    phase = 1
	countDown = 60
end

function ColorBlaster:update(dt)
	countDown = countDown - dt
	
	if countDown <= 0 then
		endRun()
		return
	end
	
	if love.keyboard.isDown("up") then
		circles[2]:move(0)
	end
	if love.keyboard.isDown("down") then
		circles[2]:move(2)
	end
	if love.keyboard.isDown("left") then
		circles[2]:move(3)
	end
	if love.keyboard.isDown("right") then
		circles[2]:move(1)
	end   

	if love.keyboard.isDown("w") then
		circles[1]:move(0)
	end
	if love.keyboard.isDown("s") then
		circles[1]:move(2)
	end
	if love.keyboard.isDown("a") then
		circles[1]:move(3)
	end
	if love.keyboard.isDown("d") then
		circles[1]:move(1)
	end
    
    if (60 - countDown) / 5 > phase then
        phase = phase + 1
        self:spawnEnemies(0, 1)
        self:spawnEnemies(1, 1)
    end
    
    for i,v in ipairs(enemies) do
        v:update()
        if v.position.y > love.graphics.getHeight() + 25 then
            table.remove(enemies, i)
            self:spawnEnemy(v.color)
            score = score - 5
        end
        for k, c in ipairs(circles) do
            if c.position:dist(v.position) < 57 then
                table.remove(enemies, i)
                if c.color == v.color then
                    score = score + 10
                else
                    score = score - 10
                end
                self:spawnEnemy(v.color)
            end
        end
    end
end

function ColorBlaster:draw()
    for i,v in ipairs(enemies) do
        v:draw()
    end
    
    for i, c in ipairs(circles) do
        c:draw()
    end
	
	love.graphics.setColor(255, 255, 255)
	love.graphics.setFont(smallFont)
	love.graphics.print("score: "..score.." time: "..string.format("%u", countDown), 20, 20)
end

function ColorBlaster:spawnEnemy(color)
    self:spawnEnemies(color, 1)
end

function ColorBlaster:spawnEnemies(color, count)
    for i = 1, count do
        local newX = math.random(25, love.graphics.getWidth() - 25)
        local newY = 0
        table.insert(enemies, Enemy:new(newX, newY, color))
    end
end