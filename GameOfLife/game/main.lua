--[[
	Game Name: Convey's the Game of life
	Game Author: Matthew Cunningham
	Reference: http://en.wikipedia.org/wiki/Conway%27s_Game_of_Life
	
	----
	Controls:
			 Quit the game	: esc
					 Pause 	: p
				 ResetGrid 	: r
   		Randomly seed grid 	: s

   		When paused use the mouse to create or kill cells.

	Interesting ideas:
	https://love2d.org/wiki/Tutorial:Gridlocked_Player
	http://www.gamedev.net/page/resources/_/technical/game-programming/coordinates-in-hexagon-based-tile-maps-r1800
--]]

require "cell"
require "grid"
require "timer"
require "conwaysrules"
require "constants"
pp = require "lua-pretty-print.PrettyPrint"

local lg = love.graphics
local lm = love.mouse

function love.load()
	currentGeneration = 0
	generationHalfLife = 1

	timer = Timer:new()
	timer.resetInterval = generationHalfLife
	timer.callback = nextGeneration

	grid = Grid:new({}, 0, 0)
	grid:fill(Cell)
end

function love.update(dt)
	timer:tick(dt)
end

function love.draw()
	grid:draw()
	drawInfoToScreen()	
end

function drawInfoToScreen()
	lg.setColor(unpack(Colors.white))
	lg.print("Current Generation: " .. currentGeneration, 10, 10)
	lg.print("Timer active: " .. tostring(timer.active), 10, 24)
	lg.print("Timer active: " .. tostring(timer.active), 10, 24)
	
	lg.print("Cursor: " .. lm.getX() .. ", " .. lm.getY(), lg.getWidth() - 200, lg.getHeight() - 30)
end

function love.mousepressed(x, y, button)
	if not timer.active then
		grid:mousepressed(x,y)
	end
end

function love.keypressed(key)
	if key == "escape" then
		love.event.push("quit")
	end

	if key == "p" then
		timer.active = not timer.active
	end

	if key == "s" then
		seedGrid()
	end

	if key == "r" then
		clearGrid()
	end
end


function nextGeneration()
	print "Welcome to the next generation"
	currentGeneration = currentGeneration + 1

	-- print("Before", pp(grid.contents))

	local newGrid = Grid:new({}, 0, 0)
	for k,v in pairs(newGrid.contents) do
		print("before I fill new grid", k,v)
	end

	for x, cellCollection in pairs(grid.contents) do
		for y, cell in pairs(cellCollection) do
			local newCell = analysisNeighbours(cell, grid)
			newGrid:addToGrid(x, y, newCell)
		end
	end
	
	-- print("NewGrid", pp(newGrid))
	-- print("newGrid contains", #newGrid.contents, "elements")

	grid:replaceWith(newGrid)
end


-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
--  /$$   /$$  /$$    /$$/$$         
-- | $$  | $$ | $$   |__| $$         
-- | $$  | $$/$$$$$$  /$| $$ /$$$$$$$
-- | $$  | $|_  $$_/ | $| $$/$$_____/
-- | $$  | $$ | $$   | $| $|  $$$$$$ 
-- | $$  | $$ | $$ /$| $| $$\____  $$
-- |  $$$$$$/ |  $$$$| $| $$/$$$$$$$/
--  \______/   \___/ |__|__|_______/
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function seedGrid()
	print "Preparing to seed grid"

	-- for kCollection,collection in pairs(grid.contents) do
	-- 	for kCell,cell in pairs(collection) do
	-- 		local rnd = math.random(0, 1)
			
	-- 		if rnd == 0 then
	-- 			cell:setAlive()
	-- 		end
	-- 	end
	-- end

	grid:seed()

	print "Seeded son"
end

function clearGrid()
	print "about to clear the grid"

	-- for kCollection,collection in pairs(grid.contents) do
	-- 	for kCell,cell in pairs(collection) do
	-- 		cell:setDead()
	-- 	end
	-- end

	grid:fill(Cell)
end
