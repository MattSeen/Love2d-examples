require "constants"

Cell = {}

function Cell:new (o, xPos, yPos)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self

    o.alive = false
    o.generation = 0
    o.color = Colors.black
    o.xPos = xPos
    o.yPos = yPos
    o.numTimesKilled = 0

    return o
end

function Cell:isAlive()
    return self.alive 
end

function Cell:setAlive()
    if not self.alive then 
        self.generation = 1 -- The beginning of a new bloodline
    end

    self.alive = true
    self.color = Colors.white 
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
    self.numTimesKilled = self.numTimesKilled + 1
end

function Cell:draw(cellWidth, cellHeight)
    local lg = love.graphics

    lg.setColor(unpack(self.color))
    lg.rectangle("fill", self.xPos * cellWidth, self.yPos * cellHeight, cellWidth, cellHeight)

    lg.setColor(unpack(Colors.red))
    -- lg.print(self.xPos .. " " .. self.yPos, self.xPos * cellWidth, self.yPos * cellHeight)
    lg.print(self.generation .. " " .. self.numTimesKilled, self.xPos * cellWidth, self.yPos * cellHeight)
end

function Cell:mousepressed()
    print "I've been clicked on me!"

    if self:isAlive() then
        self:setDead() 
    else 
        self:setAlive() 
    end
end

