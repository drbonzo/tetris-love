GameBuilder = {}

function GameBuilder:new()

    local gameBuilder = {}
    setmetatable(gameBuilder, self)
    self.__index = self

    -- init

    return gameBuilder
end

-- @return {Game}
function GameBuilder:buildGame(width, height, speed, level)

    local playfield = Playfield:new(width, height)
    local game = Game:new(playfield, speed, level)

    return game
end