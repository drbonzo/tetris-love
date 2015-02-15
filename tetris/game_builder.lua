GameBuilder = {
    MIN_SPEED = 1,
    MAX_SPEED = 10,
    MIN_LEVEL = 0,
    MAX_LEVEL = 15,
}

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

    speed = self:checkSpeed(speed)
    level = self:checkLevel(level)

    if level > GameBuilder.MIN_LEVEL then
        -- generating `level` levels of
        for l = 1, level do

            local blocksAddedInLine = 0
            for c = 1, width do

                -- prevent from filling full rows with garbage blocks
                -- last column will statistically have less garbage - when all previous columns are filled, then last column is left empty
                if blocksAddedInLine < width - 1 then
                    if math.random(1, 10) > 6 then -- 70% for block present
                        -- map virtual position to array position
                        x = c + 1
                        y = height + 3 - l
                        playfield.blocks[y][x] = Playfield.GARBAGE_BLOCK
                        blocksAddedInLine = blocksAddedInLine + 1
                    end
                end
            end
        end
    end

    local tetrominoGenerator = TetrominoGenerator:new()
    local tetrominos = Tetrominos:buildTetrominos()
    local game = Game:new(playfield, tetrominoGenerator, tetrominos, speed, level)

    return game
end

function GameBuilder:checkSpeed(speed)

    if speed < GameBuilder.MIN_SPEED then
        speed = GameBuilder.MIN_SPEED
    end

    if speed > GameBuilder.MAX_SPEED then
        speed = GameBuilder.MAX_SPEED
    end

    return speed
end


function GameBuilder:checkLevel(level)

    if level < GameBuilder.MIN_LEVEL then
        level = GameBuilder.MIN_LEVEL
    end

    if level > GameBuilder.MAX_LEVEL then
        level = GameBuilder.MAX_LEVEL
    end

    return level
end