require "utils"

--[[
	0,0 |  1,0  | 2,0
	0,1 |  1,1* | 2,1
	0,2 |  1,2  | 2,2
	
	Every cell interacts with its eight neighbours, which are the cells that 
	are horizontally, vertically, or diagonally **adjacent**.
]]--
coordinateNeighourhoodOverlay = {
	topLeft = {-1, -1},
	top = {0, -1},
	topRight = {1, -1},

	left = {-1, 0},
	right = {1, 0},
	
	bottomLeft = {-1, 1},
	bottom = {0, 1},
	bottomRight = {1, 1}
}

--[[
    Any live cell with fewer than two live neighbours dies, as if caused by under-population.
    Any live cell with two or three live neighbours lives on to the next generation.
    Any live cell with more than three live neighbours dies, as if by overcrowding.
    Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
]]--
function analysisNeighbours(cell, grid)
	local currentCell = table.deepCopy(cell)
	
	local liveCells = collectLiveNeighbours(cell, grid)

	if currentCell:isAlive() then
		if #liveCells == 2 or #liveCells == 3 then
			-- currentCell:setAlive()
			currentCell:theBloodLineContinues()
		else
			currentCell:setDead()
			currentCell:bloodLineHasEnded()
		end
	else
		if #liveCells == 3 then
			currentCell:setAlive()
		else
			-- continue to be dead son.
			currentCell:setDead()
		end
	end

	return currentCell
end

function collectLiveNeighbours(cell, grid)
	local neighbourhood = collectAllNeighbours(cell, grid)

	-- Collect all live neighbours
	local liveCells = {}
	for k,cell in pairs(neighbourhood) do
		if cell:isAlive() then
			liveCells[#liveCells + 1] = cell
		end
	end
	
	return liveCells
end

function collectAllNeighbours(cell, grid)
	local neighbourhood = {}

	for k,v in pairs(coordinateNeighourhoodOverlay) do
		if cell.xPos + v[1] > 0 and cell.yPos + v[2] > 0 
			and cell.xPos + v[1] < 10 and cell.yPos + v[2] < 10
			then

			local neighbour = grid.contents[cell.xPos + v[1]][cell.yPos + v[2]]
			neighbourhood[#neighbourhood + 1] = neighbour
		end
	end

	return neighbourhood
end
