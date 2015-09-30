-- Requisita o storyboard e cria uma nova cena
local storyboard = require("storyboard")
local scene = storyboard.newScene()
local start

_W = display.contentWidth 
_H = display.contentHeight


function fechar_tela(event)
	display.remove(background)
	storyboard.gotoScene("menu")
end

function scene:createScene( event )
	local group = self.view

	--Adiciona o background
	local background = display.newImage("images/gameover3.png")
    background.x = _W/2
    background.y = _H/2
    group:insert(background) 

	background:addEventListener("touch", fechar_tela)    
end

function scene:enterScene(event)
  local group = self.view;
  storyboard.removeScene("jogar")  
end

-- Recebe os metodos criados
scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )

return scene	