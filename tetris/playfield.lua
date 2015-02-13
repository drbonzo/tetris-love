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
