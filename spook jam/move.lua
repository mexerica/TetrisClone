pressed = false

function love.update(dt)
    if game.scene == "tetris" then piece(dt)
    elseif game.scene == "menu" then pointer() end
end

function love.keypressed(key)
    if game.scene == "tetris" then
        if key == 'x' then
            local testRotation = pieceRotation + 1
            if testRotation > #pieceStructures[pieceType] then testRotation = 1 end
            if canPieceMove(pieceX, pieceY, testRotation) then pieceRotation = testRotation end

        elseif key == 'z' then
            local testRotation = pieceRotation - 1
            if testRotation < 1 then testRotation = #pieceStructures[pieceType] end
            if canPieceMove(pieceX, pieceY, testRotation) then pieceRotation = testRotation end

        elseif key == 'left' then
            local testX = pieceX - 1
            if canPieceMove(testX, pieceY, pieceRotation) then pieceX = testX end

        elseif key == 'right' then
            local testX = pieceX + 1
            if canPieceMove(testX, pieceY, pieceRotation) then pieceX = testX end

        elseif key == 'space' then
            while canPieceMove(pieceX, pieceY + 1, pieceRotation) do
                pieceY = pieceY + 1
                timer = timerLimit
            end
        end
    else
        if key == 'left' or  key == 'right' then
            if position == 35 then position = 235
            else position = 35 end
        else 
            pressed = true 
        end
    end
end

function piece(dt)
    timer = timer + dt
    if timer >= timerLimit then
        timer = 0

        local testY = pieceY + 1
        if canPieceMove(pieceX, testY, pieceRotation) then
            pieceY = testY
        else
            for y = 1, pieceYCount do
                for x = 1, pieceXCount do
                    local block = pieceStructures[pieceType][pieceRotation][y][x]
                    if block ~= ' ' then inert[pieceY + y][pieceX + x] = block end
                end
            end
            findCompleteRows()
            newPiece()
            if not canPieceMove(pieceX, pieceY, pieceRotation) then reset() end
        end
    end
end

function pointer()
    if position ~= 35 and position ~= 235 then position = 35 end
    if pressed then
        if position == 35 then game.scene = "tetris"
        else pressed = false end
    end
end
