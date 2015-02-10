require 'tetromino'
require 'tetrominos'
require 'current_tetromino'
require 'playfield'
require 'game'
require 'application'
require 'game_displayer'

function love.load()

    application = buildApplication()
    application:showMenu()

    love.graphics.setBackgroundColor(39, 40, 34) --set the background color to a nice blue
    love.window.setMode(650, 650) --set the window dimensions to 650 by 650

    gameDisplayer = GameDisplayer:new()
end

function love.update(dt)

    if application.game then
        application.game:update(dt)
    end
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
        playfield.blocks[8][1] = Tetromino.TETROMINO_I
        playfield.blocks[8][2] = Tetromino.TETROMINO_I
        playfield.blocks[8][3] = Tetromino.TETROMINO_I
        playfield.blocks[8][4] = Tetromino.TETROMINO_I

        playfield.blocks[10][5] = Tetromino.TETROMINO_S
        playfield.blocks[10][6] = Tetromino.TETROMINO_S
        playfield.blocks[11][6] = Tetromino.TETROMINO_S
        playfield.blocks[11][7] = Tetromino.TETROMINO_S

        playfield.blocks[12][7] = Tetromino.TETROMINO_Z
        playfield.blocks[12][8] = Tetromino.TETROMINO_Z
        playfield.blocks[13][8] = Tetromino.TETROMINO_Z
        playfield.blocks[13][9] = Tetromino.TETROMINO_Z

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
    -- local game = application.game
    -- FIXME

    if key == 'p' then
        application:pauseGame()
    end
end



function love.draw()

    local game = application.game

    if application.state == ApplicationState.MENU then
        
        drawMainMenu()

    elseif application.state == ApplicationState.PLAYING then

        drawGame(game)

    elseif application.state == ApplicationState.PAUSED then
        
        drawPauseMenu()

    elseif application.state == ApplicationState.TERMINATED then
        -- nothing
    end
end

function drawMainMenu()

    love.graphics.setColor(255, 255, 255)
    love.graphics.print("TETRIS", 10, 40)
    love.graphics.print("[S]tart", 10, 60)
    love.graphics.print("[Q]uit", 10, 80)
end

function drawPauseMenu()

    love.graphics.setColor(255, 255, 255)
    love.graphics.print("(PAUSED)", 10, 40)
    love.graphics.print("un[P]ause", 10, 60)
    love.graphics.print("[Q]uit to Menu", 10, 80)
end

function drawGame(game)

    gameDisplayer:displayGame(game)

end

function buildGame(speed, level)

    local game = Game:new(speed, level)

    local playfield = Playfield:new(10, 22)
    game.playfield = playfield

    return game

end
