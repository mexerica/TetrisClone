function love.draw()
    if game.scene == "tetris" or game.scene == "ending" then tetris()
    elseif game.scene == "menu" then menu() 
    elseif game.scene == "op" then opening() end
end

function tetris()
    game.my_background = love.graphics.newImage('img/bg.jpg')
    love.audio.play(game.music)
    if terror > 10 and terror < 17 then love.graphics.setColor(0.5, 0.5, 0.5)
    elseif terror > 18 then love.graphics.setColor(0, 0, 0)
    else love.graphics.setColor(1, 1, 1) end
    love.graphics.draw(game.my_background)
    love.graphics.setColor(15/255,56/255,15/255)
    love.graphics.print(game.score, 310, 55, 0, 2)
    love.graphics.print(game.lines, 360, 200, 0, 2)
    love.graphics.print(game.level, 360, 138, 0, 2)
    local function drawBlock(block, x, y)
        if (block ~= ' ') then love.graphics.rectangle('fill', (x - 1) * 20 + 17, (y - 1) * 20 - 94, 19, 19) end
    end

    for y = 1, gridYCount do
        for x = 1, gridXCount do drawBlock(inert[y][x], x + 2, y + 5) end
    end

    for y = 1, pieceYCount do
        for x = 1, pieceXCount do
            local block = pieceStructures[pieceType][pieceRotation][y][x]
            if block ~= ' ' then drawBlock(block, x + pieceX + 2, y + pieceY + 5) end
        end
    end

    for y = 1, pieceYCount do
        for x = 1, pieceXCount do
            local block = pieceStructures[sequence[#sequence]][1][y][x]
            if block ~= ' ' then drawBlock('preview', x + 16, y + 18) end
        end
    end
end

function menu()
    if changecolor then love.graphics.setColor(255, 0, 0) end
    game.my_background = love.graphics.newImage('img/title.png')
    game.pointer = love.graphics.newImage('img/pointer.png')
    love.graphics.draw(game.my_background)
    love.graphics.draw(game.pointer, position, 280)
end

function opening()
    love.audio.play(game.sound)
    game.my_background = love.graphics.newImage('img/op.png')
    love.graphics.draw(game.my_background, 0, position)
    if position < 0 then 
        position = position + 1 
    else 
        game.position = 35
        game.scene = "menu" 
    end
end