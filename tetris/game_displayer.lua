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

    return gameDisplayer

end

function GameDisplayer:displayGame(game)

    love.graphics.setLineStyle('smooth')

    local playfield = game.playfield

    local offsetX = self.blockSize
    local offsetY = self.blockSize
    local block = 0
    local color = nil


    local rows = playfield.heightWithVanishZone;
    local cols = playfield.width

    -- border
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle( 'line', offsetX - 1 , offsetY - 1, cols * self.blockSize + 1, rows * self.blockSize + 1 )
    
    -- blocks
    -- all these '- 1' because we have all indexes from 1, not from 0
    local ctx = 0
    local cty = 0

    for r = 1, rows do
        for c = 1, cols do

            block = playfield.blocks[r][c]
            if ( not ( block == Playfield.EMPTY_BLOCK ) ) then
                color = self.colors[block]
                -- FIXME row 0 is at the bottom! change this
                love.graphics.setColor(color[1], color[2], color[3])
                -- c is counted from 1, not 0
                ctx = offsetX + (c - 1) * self.blockSize
                cty = offsetY + (r - 1) * self.blockSize
                love.graphics.rectangle( 'fill', ctx, cty, self.blockSize, self.blockSize )
            end
        end
    end

    -- current block

    local currentTetromino = game.currentTetromino
    for r = 1, 4 do
        for c = 1, 4 do

            block = currentTetromino.blocks[r][c] -- TODO kolor brany jest z bloku a nie z ID tetromino, też działa :)
            if ( not ( block == Playfield.EMPTY_BLOCK ) ) then
                color = self.colors[block]
                -- FIXME row 0 is at the bottom! change this
                love.graphics.setColor(color[1], color[2], color[3])
                -- currentTetromino.x is counted from 1, not from 0
                -- c is counted from 1, not 0
                ctx = offsetX + ( currentTetromino.x - 1 + c - 1 ) * self.blockSize
                cty = offsetY + ( currentTetromino.y - 1 + r - 1 ) * self.blockSize
                love.graphics.rectangle( 'fill', ctx, cty, self.blockSize, self.blockSize )
            end
        end
    end
    -- love.graphics.print(text, 10, 40)

end
