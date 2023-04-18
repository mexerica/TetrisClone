function love.draw()
    if game.scene == "tetris" then tetris()
    else menu() end
end

function tetris()
    game.my_background = love.graphics.newImage('img/bg.jpg')
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(game.my_background)
    love.graphics.setColor(15/255,56/255,15/255)
    love.graphics.print(game.score, 310, 55, 0, 2)
    love.graphics.print(game.lines, 360, 200, 0, 2)
    love.graphics.print(game.level, 360, 138, 0, 2)
    local function drawBlock(block, x, y)
        if (block ~= ' ') then  love.graphics.rectangle('fill', (x - 1) * 20 + 17, (y - 1) * 20 - 94, 19, 19) end
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
    game.my_background = love.graphics.newImage('img/title.png')
    game.pointer = love.graphics.newImage('img/pointer.png')
    love.graphics.draw(game.my_background)
    love.graphics.draw(game.pointer, position, 280)
end