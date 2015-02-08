GameDisplayer = {
	colors = {},
	blockSize = 20
}

function GameDisplayer:new()

    local gameDisplayer = {}
    setmetatable(gameDisplayer, self)
    self.__index = self

    -- init

    gameDisplayer.colors[Playfield.TETROMINO_I] = { 0, 254, 254 }
    gameDisplayer.colors[Playfield.TETROMINO_J] = { 10, 60, 245 }
    gameDisplayer.colors[Playfield.TETROMINO_L] = { 255, 145, 51 }
    gameDisplayer.colors[Playfield.TETROMINO_O] = { 255, 250, 85 }
    gameDisplayer.colors[Playfield.TETROMINO_S] = { 0, 248, 80 }
    gameDisplayer.colors[Playfield.TETROMINO_T] = { 152, 35, 140 }
    gameDisplayer.colors[Playfield.TETROMINO_Z] = { 255, 31, 26 }

    return gameDisplayer

end

function GameDisplayer:displayGame(game)

    love.graphics.setLineStyle('smooth')

    local playfield = game.playfield

    local offsetX = self.blockSize
    local offsetY = self.blockSize
    local block = 0
    local color = nil


    local rows = playfield.heightWithVanishZone - 1;
    local cols = playfield.width - 1

    -- border
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle( 'line', offsetX - 1 , offsetY - 1, cols * self.blockSize + 1, rows * self.blockSize + 1 )
    
    -- blocks
    for r = 0, rows do
        for c = 0, cols do

            block = playfield.blocks[r][c]
            if ( not ( block == Playfield.EMPTY_BLOCK ) ) then
                color = self.colors[block]
                love.graphics.setColor(color[1], color[2], color[3])
                love.graphics.rectangle( 'fill', offsetX + c * self.blockSize, offsetY + r * self.blockSize, self.blockSize, self.blockSize )
            end
        end
    end
    -- love.graphics.print(text, 10, 40)

end
