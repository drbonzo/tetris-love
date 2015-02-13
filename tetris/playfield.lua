Playfield = {
    width = 0,
    height = 0,
    blocks = nil,
    EMPTY_BLOCK = 0,
    WALL = 99
}

function Playfield:new(width, height)

    local playfield = {}
    setmetatable(playfield, self)
    self.__index = self

    playfield.width = width
    playfield.height = height
    playfield.heightWithVanishZone = height + 2

    playfield.blocks = {}

    -- W..........W - 1
    -- W..........W - 2
    -- W..........W - 3
    -- W..........W ...
    -- W..........W
    -- WWWWWWWWWWWW - h+1
    -- ^^^        ^
    -- 123.......(w+2)
    --
    -- where:
    -- W - wall
    -- . - empty space, where tetrominos can be placed
    --
    -- Having walls simplifies checking whether brick can be placed there

    local w = width + 2 -- TODO DRY
    local h = playfield.heightWithVanishZone + 1 -- TODO DRY

    for r = 1, h do
        -- row
        playfield.blocks[r] = {}
        for c = 1, w do
            -- cols

            if (r == h) then

                -- bottom wall
                playfield.blocks[r][c] = Playfield.WALL

            elseif (c == 1 or c == w) then

                -- left and right wall
                playfield.blocks[r][c] = Playfield.WALL

            else

                playfield.blocks[r][c] = Playfield.EMPTY_BLOCK
            end
        end
    end

    return playfield
end


-- @param currentTetromino {CurrentTetromino}
function Playfield:absorbTetromino(currentTetromino)

    print("Absorbing")
    local block_x
    local block_y
    for r = 1, 4 do
        for c = 1, 4 do
            block_x = currentTetromino.x + c - 1
            block_y = currentTetromino.y + r - 1

            if (not currentTetromino.blocks[r][c] == self.EMPTY_BLOCK) then
                self.blocks[block_y][block_x] = currentTetromino.blocks[r][c]
            end
        end
    end
end
