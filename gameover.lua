-- Requisita o composer e cria uma nova cena
local composer = require( "composer" )
local scene = composer.newScene()

_W = display.contentWidth 
_H = display.contentHeight


function fechar_tela(event)
	display.remove(background)
	composer.gotoScene("menu")
end

function scene:create( event )
	local group = self.view

	--Adiciona o background
	local background = display.newImage("images/gameover3.png")
	background.x = _W/2
	background.y = _H/2
	group:insert(background) 

	background:addEventListener("touch", fechar_tela)    
end

function scene:show(event)
  local group = self.view;
  composer.removeScene("jogar")  
end

-- Recebe os metodos criados
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )

return scene	