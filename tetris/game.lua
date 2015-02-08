Game = { speed = 1, level = 0 }

function Game:new(speed, level)
    local game = {}
    setmetatable(game, self)
    self.__index = self

    game.speed = speed
    game.level = level

    return game
end

-- function Game:showMenu()
--     self.state = gamelicationState.MENU
-- end
--

function buildGame()

    local game = Game:new()

    local playfield = Playfield:new(10, 22)
    game.playfield = playfield

    return game

end
