require "constants"

Cell = {
    alive = false,
    generation = 0,
    color = Colors.black,
    xPos = 0,
    yPos = 0
}

function Cell:new (o, xPos, yPos)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self

    o.xPos = xPos
    o.yPos = yPos

    return o
end

function Cell:isAlive()
    return self.alive 
end

function Cell:setAlive()
    self.alive = true
    self.color = Colors.white 
    self.generation = 1 -- The beginning of a new bloodline
end

function Cell:setDead()
    self.alive = false
    self.color = Colors.black
end

function Cell:getGenerationsLived()
    return self.generation
end

function Cell:theBloodLineContinues()
    self.generation = self.generation + 1
end

function Cell:bloodLineHasEnded()
    self.generation = 0
end

function Cell:draw(cellWidth, cellHeight)
    local lg = love.graphics

    local r,g,b,a = unpack(self.color)
    lg.setColor(r,g,b,a)

    lg.rectangle("fill", self.xPos * cellWidth, self.yPos * cellHeight, cellWidth, cellHeight)

    lg.setColor(unpack(Colors.red))
    lg.print(self.xPos .. " " .. self.yPos, self.xPos * cellWidth, self.yPos * cellHeight)
    -- lg.print(self.generation, self.xPos * cellWidth, self.yPos * cellHeight)
end

function Cell:mousepressed(cellWidth, cellHeight)
    print "I've been clicked on me!"

    if self:isAlive() then
        self:setDead() 
    else 
        self:setAlive() 
    end
end

