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

function GameDisplayer:displayGame(game)

    love.graphics.setLineStyle('smooth')

    local playfield = game.playfield
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
    love.graphics.rectangle('line', offsetX - 1, offsetY - 1, cols * self.blockSize + 1, rows * self.blockSize + 1)

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

    -- current block

    local currentTetromino = game.currentTetromino
    local brickX
    local brickY
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

    -- print score
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("Score: " .. game.scoring:getScore(), (cols + 2) * self.blockSize + 10, self.blockSize)
end


--
-- @param brickY int - Y position of the block, first column has value 1
-- @param brickX int - X position of the block, first column has value 1
-- @param red int
-- @param green int
-- @param blue int
function GameDisplayer:displayBlock(blockY, blockX, red, green, blue)

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
    love.graphics.rectangle('fill', x, y, self.blockSize, self.blockSize)
end
