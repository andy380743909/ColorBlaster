require("class")
require("vec2")
require("StreamingLines")
require("Enemy")
require("PlayerCircle")
require("ColorBlaster")
require("highscore")

function love.load()
	if not love.filesystem.exists("highscore.txt") then
		highscore_new("highscore.txt", 1, "", 100)
	end
	highscore_load("highscore.txt")
	love.window.setMode(1024, 768, {fullscreen=false, vsync=1, msaa=4})
	love.graphics.setBackgroundColor(0, 0, 0)
	
	tinyFont = love.graphics.newFont(15)
	smallFont = love.graphics.newFont(30)
	mediumFont = love.graphics.newFont(50)
	largeFont = love.graphics.newFont(100)
	hugeFont = love.graphics.newFont(150)
	state = "loaded"
	cb = ColorBlaster:new()
	
	state = "loaded"
	cb:start()
    bglines = StreamingLines:new()
end

function love.update(dt)
	if state == "running" then
		cb:update(dt)
	end
    bglines:update()
end

function love.draw()
    bglines:draw()
	cb:draw()
	if state == "ended" or state == "paused" or state == "loaded" then
		love.graphics.setColor(0/255.0, 0/255.0, 0/255.0, 200/255.0)
		love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
	end
	if state == "ended" then
		--drawEndScreen
		love.graphics.setColor(255/255.0, 255/255.0, 255/255.0)
		love.graphics.setFont(hugeFont)
		love.graphics.printf(score, 0, 100, love.graphics.getWidth(), 'center')
		love.graphics.setFont(largeFont)
		love.graphics.printf("Game Over", 0, 300, love.graphics.getWidth(), 'center')
		love.graphics.setFont(mediumFont)
		love.graphics.print("Press r / B to restart", 300, 500)
		love.graphics.print("Press q / A to quit", 300, 550)
		printControls()
		printCredits()
	elseif state == "paused" then
		--drawPauseScreen
		love.graphics.setColor(255/255.0, 255/255.0, 255/255.0)
		love.graphics.setFont(largeFont)
		love.graphics.printf("Paused", 0, 200, love.graphics.getWidth(), 'center')
		love.graphics.setFont(mediumFont)
		love.graphics.print("Press esc / B to unpause", 300, 400)
		love.graphics.print("Press r / START to restart", 300, 450)
		love.graphics.print("Press q / A to quit", 300, 500)
		printControls()
		printCredits()
	elseif state == "loaded" then
		--drawMainScreen
		love.graphics.setColor(255/255.0, 255/255.0, 255/255.0)
		love.graphics.setFont(hugeFont)
		love.graphics.printf("ColorBlaster", 0, 100, love.graphics.getWidth(), 'center')
		love.graphics.setFont(mediumFont)
		love.graphics.print("Press space / B to start", 300, 400)
		love.graphics.print("Press q / A to quit", 300, 500)
		printControls()
		printCredits()
	end
	printHighScore()
end

function printControls()
	love.graphics.setColor(255/255.0, 255/255.0, 255/255.0)
	love.graphics.setFont(tinyFont)
	love.graphics.printf("controls", 25, 700, love.graphics.getWidth(), 'left')
	love.graphics.printf("w,a,s,d - red cirle", 25, 715, love.graphics.getWidth(), 'left')
	love.graphics.printf("arrow keys - blue circle", 25, 730, love.graphics.getWidth(), 'left')
end

function printCredits()
	love.graphics.setColor(255/255.0, 255/255.0, 255/255.0)
	love.graphics.setFont(tinyFont)
	love.graphics.printf("Built by Scott Moore (oberonix)", -25, 710, love.graphics.getWidth(), 'right')
	love.graphics.printf("BuffBit.com", -25, 730, love.graphics.getWidth(), 'right')
end

function printHighScore()
	love.graphics.setColor(255/255.0, 255/255.0, 255/255.0)
	love.graphics.setFont(smallFont)
	love.graphics.printf("High Score: "..highscore[1], -25, 25, love.graphics.getWidth(), 'right')
end

function love.focus(f)
	if state == "running" and not f then
		state = "paused"
	end
end

function endRun()
	commitHighScore(score)
	state = "ended"
end

function getHighScore()
	return highscore[1]
end

function commitHighScore(score)
print(score..highscore[1])
	if score > highscore[1] then
		highscore_add(score, "");
		highscore_write("highscore.txt");
	end
	print(score..highscore[1])
end

function love.keypressed(k)
	if state == "paused" then
		if k == 'q' then
			love.event.push('quit')
		elseif k == 'escape' then
			state = "running"
		elseif k == 'r' then
			state = "running"
			cb:start()
		end
	elseif state == "running" then
		if k == 'escape' then
			state = "paused"
		end
	elseif state == "loaded" then
		if k == 'space' then
			state = "running"
		elseif k == 'q' then
			love.event.push('quit')
		end
	elseif state == "ended" then
		if k == 'q' then
			love.event.push('quit')
		elseif k == 'r' then
			state = "running"
			cb:start()
		end
	end
end

function love.gamepadpressed(joystick, button)
	if state == "paused" then
		if button == 'a' then
			love.event.push('quit')
		elseif button == 'b' then
			state = "running"
		elseif button == 'start' then
			state = "running"
			cb:start()
		end
	elseif state == "running" then
		if button == 'back' then
			state = "paused"
		end
	elseif state == "loaded" then
		if button == 'b' then
			state = "running"
		elseif button == 'a' then
			love.event.push('quit')
		end
	elseif state == "ended" then
		if button == 'a' then
			love.event.push('quit')
		elseif button == 'b' then
			state = "running"
			cb:start()
		end
	end
end