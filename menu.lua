-- Requisita o storyboard e cria uma nova cena
local storyboard = require("storyboard")
local scene = storyboard.newScene()
local start

_W = display.contentWidth 
_H = display.contentHeight


function scene:createScene( event )
  local group = self.view

  --Adiciona o background
  local background = display.newImage("images/background2.jpg")
    background.x = _W/2
    background.y = _H/2
    group:insert(background)  

  --Adiciona o botão de start
  start = display.newImage("images/start.png")
	  start.x = _W/2 
	  start.y = _H/2 + 220
	  start.xScale = 0.4
	  start.yScale = 0.4	
    group:insert(start)

  local function start_game()
    storyboard.gotoScene("jogar", transicaoCena)
  end


  function scene:enterScene( event )
    start:addEventListener("tap", start_game)
    storyboard.removeScene("jogar")
  end

end

-- Recebe os metodos criados
scene:addEventListener( "createScene", scene )

scene:addEventListener( "enterScene", scene )

return scene	