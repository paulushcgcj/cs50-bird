Class = require 'class'
require 'states/BaseState'

TitleState = Class{__includes = BaseState}

function TitleState:init(screenWidth)
    self.screenWidth = screenWidth
end

function TitleState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function TitleState:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Filphy Bird', 0, 64, self.screenWidth, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press Enter', 0, 100, self.screenWidth, 'center')
end