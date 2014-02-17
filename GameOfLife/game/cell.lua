require "constants"
require "utils"

Cell = {}

function Cell:new (o, xPos, yPos, width, height)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self

    o.alive = false
    o.generation = 0
    o.color = table.deepCopy(Colors.black)
    o.xPos = xPos
    o.yPos = yPos
    o.width = width
    o.height = height
    o.numTimesKilled = 0

    return o
end

function Cell:isAlive()
    return self.alive 
end

function Cell:setAlive()
    if not self.alive then 
        self.generation = 1 -- The beginning of a new bloodline
        tween(0.35, self.color, Colors.white, tween.easing.linear)
    end

    self.alive = true
end

function Cell:setDead()
    if self.alive then
        local black = table.deepCopy(Colors.black)
        tween(0.35, self.color, black, tween.easing.linear)
    end

    self.alive = false
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

function Cell:update(dt)
    if self.generation == 1 then

    end
end

function Cell:draw()
    local lg = love.graphics

    lg.setColor(unpack(self.color))
    lg.rectangle("fill", self.xPos * self.width, self.yPos * self.height, self.width, self.height)

    lg.setColor(unpack(Colors.red))
    -- lg.print(self.xPos .. " " .. self.yPos, self.xPos * self.width, self.yPos * self.height)
    lg.print(self.generation .. " " .. self.numTimesKilled, self.xPos * self.width, self.yPos * self.height)
end

function Cell:mousepressed()
    print "I've been clicked on me!"

    if self:isAlive() then
        self:setDead() 
    else 
        self:setAlive()
    end
end

