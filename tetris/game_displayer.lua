GameDisplayer = {
    colors = {},
    blockSize = 20
}

function GameDisplayer:new()

    local gameDisplayer = {}
    setmetatable(gameDisplayer, self)
    self.__index = self

    -- init

    gameDisplayer.colors[Tetromino.TETROMINO_I] = { 0, 254, 254 }
    gameDisplayer.colors[Tetromino.TETROMINO_J] = { 10, 60, 245 }
    gameDisplayer.colors[Tetromino.TETROMINO_L] = { 255, 145, 51 }
    gameDisplayer.colors[Tetromino.TETROMINO_O] = { 255, 250, 85 }
    gameDisplayer.colors[Tetromino.TETROMINO_S] = { 0, 248, 80 }
    gameDisplayer.colors[Tetromino.TETROMINO_T] = { 152, 35, 140 }
    gameDisplayer.colors[Tetromino.TETROMINO_Z] = { 255, 31, 26 }
    gameDisplayer.colors[Playfield.GARBAGE_BLOCK] = { 128, 128, 128 }
    gameDisplayer.colors[Playfield.WALL] = { 240, 240, 240 }

    return gameDisplayer
end

-- @param game {Game}
function GameDisplayer:displayGame(game)
    self:displayPlayfield(game.playfield)
    self:displayCurrentTetromino(game.currentTetromino)
    self:displayScore(game)
    self:displayNextTetromino(game.nextTetrominoBlocks)
end

function GameDisplayer:displayPlayfield(playfield)

    love.graphics.setLineStyle('smooth')

    local playfieldHeight = playfield.height
    local playfieldWidth = playfield.width

    local offsetX = self.blockSize
    local offsetY = self.blockSize
    local block
    local color


    local rows = playfieldHeight + 2 + 1 -- TODO DRY
    local cols = playfieldWidth + 2 -- TODO DRY
    -- FIXME drawing new playfield
    -- border
    love.graphics.setColor(255, 255, 255)
    -- skip 2 top rows
    love.graphics.rectangle('line', offsetX - 1, offsetY - 1, cols * self.blockSize + 1, (rows - 2) * self.blockSize + 1)

    -- blocks
    -- all these '- 1' because we have all indexes from 1, not from 0

    for r = 1, rows do
        for c = 1, cols do

            block = playfield.blocks[r][c]
            if (block ~= Playfield.EMPTY_BLOCK) then
                color = self.colors[block]
                -- FIXME row 0 is at the bottom! change this

                self:displayBlock(r, c, color[1], color[2], color[3])
            end
        end
    end
end

function GameDisplayer:displayCurrentTetromino(currentTetromino)

    -- current block

    local brickX
    local brickY
    local block
    local color
    for r = 1, 4 do
        for c = 1, 4 do

            block = currentTetromino.blocks[r][c] -- TODO kolor brany jest z bloku a nie z ID tetromino, też działa :)
            if (block ~= Playfield.EMPTY_BLOCK) then
                color = self.colors[block]
                -- FIXME row 0 is at the bottom! change this
                -- currentTetromino.x is counted from 1, not from 0
                -- c is counted from 1, not 0
                -- example: currentTetromino is at [1, 5], and we are examining row and col at [1, 2]
                -- this means that X is at 1: (x + (col - 1)) = (1 + (1 - 1)) = 1 - this is first column
                -- and Y is at 6: (y + (row - 1)) = (5 + (2 - 1)) = 5 + 1 = 6
                brickY = currentTetromino.y + (r - 1)
                brickX = currentTetromino.x + (c - 1)

                self:displayBlock(brickY, brickX, color[1], color[2], color[3])
            end
        end
    end
end

function GameDisplayer:displayScore(game)
    -- print score
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("Score: " .. game.scoring:getScore(), 300, self.blockSize)
end

function GameDisplayer:displayNextTetromino(nextTetrominoBlocks)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("Next: ", 300, 40)
    love.graphics.rectangle('line', 300, 60, 4 * self.blockSize, 4 * self.blockSize)

    local block
    local color
    local blockOffsetX = 300
    local blockOffsetY = 60

    for r = 1, 4 do
        for c = 1, 4 do
            block = nextTetrominoBlocks[r][c]

            if block ~= Playfield.EMPTY_BLOCK then
                color = self.colors[block]
                love.graphics.setColor(color[1], color[2], color[3])

                local x = blockOffsetX + ((c - 1) * self.blockSize)
                local y = blockOffsetY + ((r - 1) * self.blockSize)
                love.graphics.rectangle('fill', x, y, self.blockSize, self.blockSize) -- TODO DRY block
            end
        end
    end
end

--
-- @param brickY int - Y position of the block, first column has value 1
-- @param brickX int - X position of the block, first column has value 1
-- @param red int
-- @param green int
-- @param blue int
function GameDisplayer:displayBlock(blockY, blockX, red, green, blue)

    -- dont display blocks in vanishing zone
    if blockY < 3 then
        return
    end

    -- shift all graphics 2 blocks upwards
    blockY = blockY - 2

    -- FIXME drawing playfield
    -- c and r are counted from 1, not 0
    local blockOffsetX = 1 + (blockX - 1)
    -- row number 1 is at the bottom of the screen, last row is at the top of the screen
    -- top of the screen has lower pixel number
    -- "+1" for wall row - so the playfield is a little bit higher
    local blockOffsetY = 1 + (blockY - 1)


    love.graphics.setColor(red, green, blue)
    local x = blockOffsetX * self.blockSize
    local y = blockOffsetY * self.blockSize
    love.graphics.rectangle('fill', x, y, self.blockSize, self.blockSize) -- TODO DRY block
end

-- @param game {Game}
function GameDisplayer:displayGameOverScreen(game)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("GAME\nOVER\n\nScore: " .. game.scoring:getScore(), 300, self.blockSize)
end