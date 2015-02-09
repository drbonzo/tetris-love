Game = { 
    speed = 1,
    level = 0,
    playfield = nil,
    timeSinceStart = 0,
    tickDuration = 0
}

function Game:new(speed, level)
    local game = {}
    setmetatable(game, self)
    self.__index = self

    game.speed = speed
    game.level = level
    game.tickDuration = 1.0 / game.speed 

    return game
end

function Game:initialize()
    self.timeSinceStart = 0
end

function Game:update(dt)
    self.timeSinceStart = self.timeSinceStart + dt

    -- speed 1 => tickDuration = 1s
    -- spped 5 => tickDuration = 1/5 = 0.2s

    if self.timeSinceStart > self.tickDuration then
        self:processGravity()
        self.timeSinceStart = self.timeSinceStart - self.tickDuration
    end
end


function Game:processGravity()
    print("Processing")
end