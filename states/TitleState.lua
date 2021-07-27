Class = require 'class'
require 'states/BaseState'

TitleState = Class{__includes = BaseState}

function TitleState:init(screenWidth)
    self.screenWidth = screenWidth
    self.mediumFont = love.graphics.newFont('assets/PressStart2P-Regular.ttf',14)
    self.flappyFont = love.graphics.newFont('assets/PressStart2P-Regular.ttf',28)
    love.graphics.setFont(self.flappyFont)
end

function TitleState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end

function TitleState:render()
    love.graphics.setFont(self.flappyFont)
    love.graphics.printf('Filphy Bird', 0, 64, self.screenWidth, 'center')

    love.graphics.setFont(self.mediumFont)
    love.graphics.printf('Press Enter', 0, 100, self.screenWidth, 'center')
end