Playfield = {
    width = 0,
    height = 0,
    blocks = nil,

    EMPTY_BLOCK = 0,

    -- FIXME move to Tetromino?
    TETROMINO_I = 1,
    TETROMINO_J = 2,
    TETROMINO_L = 3,
    TETROMINO_O = 4,
    TETROMINO_S = 5,
    TETROMINO_T = 6,
    TETROMINO_Z = 7,
}

function Playfield:new(width, height)

    local playfield = {}
    setmetatable(playfield, self)
    self.__index = self

    playfield.width = width
    playfield.height = height
    playfield.heightWithVanishZone = height + 2

    playfield.blocks = {}

    for r = 1, (playfield.heightWithVanishZone) do
        -- row
        playfield.blocks[r] = {}
        for c = 1, width do
            -- cols
            playfield.blocks[r][c] = Playfield.EMPTY_BLOCK
        end
    end

    return playfield
end
