game = {
    score = 0,
    lines = 0,
    level = 0,
    my_background = nil,
    pointer = nil,
    sound = love.audio.newSource("snd/startup.mp3", "static"),
    music = love.audio.newSource("snd/cursed.mp3", "static"),
    scene = "op",
    bg_color = {255, 0, 0}
}

gridXCount = 10
gridYCount = 18
pieceXCount = 4
pieceYCount = 4
timerLimit = 0.5
position = -250
terror = 0
changecolor = false

require('tetris')
require('bg')
require('move')