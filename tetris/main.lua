require 'application'
require 'game'

function love.load()

    application = buildApplication()
    application:showMenu()

    love.graphics.setBackgroundColor(39, 40, 34) --set the background color to a nice blue
    love.window.setMode(650, 650) --set the window dimensions to 650 by 650
end

function love.update(dt)

    print(application.state)

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
        game = buildGame(1,0)
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
-- love.graphics.setColor(72, 160, 14) -- set the drawing color to green for the ground
-- love.graphics.print(text, 10, 40)
end
