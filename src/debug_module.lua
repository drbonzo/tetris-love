-- FIXME remove this from production?
DebugModule = {}

function DebugModule:new()

    local debugModule = {}
    setmetatable(debugModule, self)
    self.__index = self

    -- init

    return debugModule
end

-- @param game {Game}
-- @return {Game}
function DebugModule:fillPlayfieldWithGarbage(game)

    local playfield = game.playfield

    playfield.blocks[8][2] = Tetromino.TETROMINO_I
    playfield.blocks[8][3] = Tetromino.TETROMINO_I
    playfield.blocks[8][4] = Tetromino.TETROMINO_I
    playfield.blocks[8][5] = Tetromino.TETROMINO_I

    playfield.blocks[10][5] = Tetromino.TETROMINO_S
    playfield.blocks[10][6] = Tetromino.TETROMINO_S
    playfield.blocks[11][6] = Tetromino.TETROMINO_S
    playfield.blocks[11][7] = Tetromino.TETROMINO_S

    playfield.blocks[12][7] = Tetromino.TETROMINO_Z
    playfield.blocks[12][8] = Tetromino.TETROMINO_Z
    playfield.blocks[13][8] = Tetromino.TETROMINO_Z
    playfield.blocks[13][9] = Tetromino.TETROMINO_Z
end
