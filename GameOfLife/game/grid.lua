require "constants"

Grid = {}

function Grid:new (o, xOffset, yOffset, cellDrawCallback)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self

    o.xOffset = xOffset or 0
    o.yOffset = yOffset or 0

    o.lines = Colors.green
    o.cellWidth = 40
    o.cellHeight = 40
    o.size = 13
    o.xPos = 0
    o.yPos = 0
    o.contents = {}
    assert(cellDrawCallback, 'Callback required, don\'t know how to draw objects in my grid')
    o.cellDrawCallback = cellDrawCallback

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

function Grid:fill(callback)
    for x=1,self.size do
        local row = {}

        for y=1,self.size do
            row[y] = callback(x, y)
        end

        self.contents[x] = row
    end    
end

function Grid:seed(callback)

    for x=1,self.size do
        for y=1,self.size do
            object = self.contents[x][y]
            callback(object)
        end
    end

end

function Grid:draw()
    for x, row in pairs(self.contents) do
        for y, cell in pairs(row) do
            self.cellDrawCallback(cell, self.cellWidth, self.cellHeight)
        end
    end
end

function Grid:mousepressed(x, y)
    local cellX, cellY = self:mouseCoordsToGridCoords(x, y)
    local cell = self.contents[cellX][cellY]

    cell:mousepressed(self.cellWidth, self.cellHeight)
end


function Grid:mouseCoordsToGridCoords(mouseX, mouseY)
    xPosOnGrid = math.floor( ((mouseX + self.xOffset) / self.cellWidth) )
    yPosOnGrid = math.floor( ((mouseY + self.yOffset) / self.cellHeight) )

 
    if xPosOnGrid > self.size then
        xPosOnGrid = self.size        
    elseif xPosOnGrid < 1 then
        xPosOnGrid = 1
    end

    if yPosOnGrid > self.size then
        yPosOnGrid = self.size
    elseif yPosOnGrid < 1 then
        yPosOnGrid = 1
    end

    return xPosOnGrid, yPosOnGrid
end