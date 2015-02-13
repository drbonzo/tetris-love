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
    local x
    local y

    if level > 0 then
        -- generating `level` levels of
        for l = 1, level do
            for c = 1, width do

                if math.random(1, 10) > 6 then -- 70% for block present
                    x = c + 1
                    y = height + 3 - l
                    playfield.blocks[y][x] = Playfield.GARBAGE_BLOCK
                end
            end
        end
    end

    local game = Game:new(playfield, speed, level)


    return game
end