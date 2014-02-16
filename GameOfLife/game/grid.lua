require "constants"

Grid = {}

function Grid:new (o, xOffset, yOffeset)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self

    o.xOffset = xOffset or 0
    o.yOffset = yOffset or 0

    o.lines = Colors.green
    o.cellWidth = 50
    o.cellHeight = 50
    o.size = 10
    o.xPos = 0
    o.yPos = 0
    o.contents = {}

    return o
end

function Grid:addToGrid(x, y, object)
    self.contents[x] = self.contents[x] or {}
    self.contents[x][y] = self.contents[x][y] or {}

    self.contents[x][y] = object
end

function Grid:replaceWith(altGrid)
    self.contents = altGrid.contents    
end

function Grid:fill(fillObject)
    for i=1,self.size do
        local row = {}
        for j=1,self.size do
            -- TODO Refactor: Grid shouldn't know anything about the interface of the fill object...
            row[j] = fillObject:new({}, i, j)
        end
        self.contents[i] = row
    end    
end

function Grid:seed()
    
    for kCollection,collection in pairs(self.contents) do
        for kCell,cell in pairs(collection) do
            local rnd = math.random(0, 1)
            
            if rnd == 0 then
                -- TODO Refactor: the grid should know very little about the object it holds
                cell:setAlive()
            end
        end
    end

end

function Grid:draw()
    for iCollection, collection in pairs(self.contents) do
        for iCell, cell in pairs(collection) do
            cell:draw(self.cellWidth, self.cellHeight)
        end
    end
end

function Grid:mousepressed(x, y)

    -- local cellX, cellY = Grid:mouseCoordsToGridCoords(x, y)
    -- grid.contents[cellX][cellY]:mousepressed()

    for kCollection,collection in pairs(self.contents) do
        for kCell,cell in pairs(collection) do
            cell:mousepressed(x, y, self.cellWidth, self.cellHeight)
            -- cell:mousepressed(cellX, cellY, self.cellWidth, self.cellHeight)
        end
    end
end


--[[
    How do I do this?
]]--
function Grid:mouseCoordsToGridCoords(x, y)
    -- ansx = x - xOffset
    -- ansy = y - yOffset

    -- 
end