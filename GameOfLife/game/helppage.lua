require "utils"
require "constants"

Help = {}

function Help:setup()
    local screenWidth = lg.getWidth()
    local screenHeight = lg.getHeight()

    self.drawHelp = false
    self.textTotalHeight = #lines(helptext) * fontSize
    self.helpX = screenWidth/2 - longestLineWidth(helptext)/2
    self.helpY = 100
end

function Help:draw ()
    lg.setColor(unpack(Colors.white))
    lg.print(helptext, self.helpX, self.helpY)
end

function Help:keypressed(key)
    self.drawHelp = not self.drawHelp
end

function Help:activated()
    return self.drawHelp
end