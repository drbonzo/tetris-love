Tetromino = {
    blocks = nil,
    TETROMINO_I = 1,
    TETROMINO_J = 2,
    TETROMINO_L = 3,
    TETROMINO_O = 4,
    TETROMINO_S = 5,
    TETROMINO_T = 6,
    TETROMINO_Z = 7
}

function Tetromino:new()

    local tetromino = {}
    setmetatable(tetromino, self)
    self.__index = self

    -- init

    tetromino.blocks = {}
    -- for each rotation of tetromino
    for rot = 1, 4 do
        tetromino.blocks[rot] = {}
        -- build 4x4 matrix of the tetromino
        for r = 1, 4 do
            tetromino.blocks[rot][r] = { Playfield.EMPTY_BLOCK, Playfield.EMPTY_BLOCK, Playfield.EMPTY_BLOCK, Playfield.EMPTY_BLOCK }
        end
    end

    return tetromino
end
