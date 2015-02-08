require 'playfield'
require 'game'
require 'application'

function love.load()

    application = buildApplication()
    application:showMenu()

    love.graphics.setBackgroundColor(39, 40, 34) --set the background color to a nice blue
    love.window.setMode(650, 650) --set the window dimensions to 650 by 650
end

function love.update(dt)

    -- print(application.state)

end

function love.keypressed(key, isrepeat)

    if application.state == ApplicationState.MENU then
        processMainMenu(key)
    elseif application.state == ApplicationState.PLAYING then
        processGame(key)
    elseif application.state == ApplicationState.PAUSED then
        processPauseMenu(key)
    elseif application.state == ApplicationState.TERMINATED then
        -- nothing
    end


    -- TODO process game
end

function love.quit()
    print("Thanks for playing :)")

    -- false = do quit
    -- true = do not quit
    return false
end

function processMainMenu(key)

    if key == 'q' then
        application:terminate()
        love.event.quit()
    elseif key == 's' then
        local game = buildGame(1,0)

        local playfield = game.playfield

        -- FIXME remove just test code
        playfield.blocks[0][0] = Playfield.TETROMINO_I
        playfield.blocks[0][1] = Playfield.TETROMINO_I
        playfield.blocks[0][2] = Playfield.TETROMINO_I
        playfield.blocks[0][3] = Playfield.TETROMINO_I

        playfield.blocks[10][5] = Playfield.TETROMINO_S
        playfield.blocks[10][6] = Playfield.TETROMINO_S
        playfield.blocks[11][6] = Playfield.TETROMINO_S
        playfield.blocks[11][7] = Playfield.TETROMINO_S

        application:playGame(game)
    end
end

function processPauseMenu(key)

    if key == 'q' then
        application:endGame()
    elseif key == 'p' then
        application:resumeGame()
    end
end

function processGame(key)
    local game = application.game
    -- FIXME

    if key == 'p' then
        application:pauseGame()
    end
end



function love.draw()

    local game = application.game

    if application.state == ApplicationState.MENU then
        -- drawMainMenu(key)
    elseif application.state == ApplicationState.PLAYING then
        drawPlayfield(game)
    elseif application.state == ApplicationState.PAUSED then
        -- drawauseMenu(key)
    elseif application.state == ApplicationState.TERMINATED then
        -- nothing
    end
end


function drawPlayfield(game)

    -- FIXME extract to PlayfieldDrawer

    local playfield = game.playfield

    local colors = {}
    colors[Playfield.TETROMINO_I] = { 0, 254, 254 }
    colors[Playfield.TETROMINO_J] = { 10, 60, 245 }
    colors[Playfield.TETROMINO_L] = { 255, 145, 51 }
    colors[Playfield.TETROMINO_O] = { 255, 250, 85 }
    colors[Playfield.TETROMINO_S] = { 0, 248, 80 }
    colors[Playfield.TETROMINO_T] = { 152, 35, 140 }
    colors[Playfield.TETROMINO_Z] = { 255, 31, 26 }


    local blockSize = 20
    local offsetX = blockSize
    local offsetY = blockSize
    local block = 0
    local color = nil

    for r = 0, (playfield.heightWithVanishZone - 1) do
        for c = 0, playfield.width - 1 do

            block = playfield.blocks[r][c]
            if ( not ( block == Playfield.EMPTY_BLOCK ) ) then
                color = colors[block]
                love.graphics.setColor(color[1], color[2], color[3])
                love.graphics.rectangle( 'fill', offsetX + c * blockSize, offsetY + r * blockSize, blockSize, blockSize )
            end
        end
    end
    -- love.graphics.print(text, 10, 40)

end
