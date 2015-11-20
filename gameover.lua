-- Requisita o composer e cria uma nova cena
local composer = require( "composer" )
local scene = composer.newScene()

_W = display.contentWidth 
_H = display.contentHeight


function fechar_tela(event)
	display.remove(texto)
	display.remove(continue)
	composer.gotoScene("menu", transicaoCena)
	composer.removeScene( "gameover" )
end

function scene:create( event )
	local group = self.view

  --Adiciona o background
  local background = display.newImage("images/background_gameover.png")
  background.x = _W/2
  background.y = _H/2
  group:insert(background)  

	--background:addEventListener("touch", fechar_tela)


  --Adiciona o background
  local background = display.newImage("images/gameover.png")
  background.x = _W-160
  background.y = _H-270
  group:insert(background)  

    --Adiciona o touch to continue
  local touch_continue = display.newImage("images/touch_continue.png")
  touch_continue.x = _W-160
  touch_continue.y = _H-200
  touch_continue:addEventListener("touch", fechar_tela) 
  group:insert(touch_continue)  
end

function scene:show( event )
  local sceneGroup = self.view
  local phase = event.phase
  
  if phase == "will" then
  elseif phase == "did" then
  end 
end

function scene:hide( event )
  local sceneGroup = self.view
  local phase = event.phase
  
  if event.phase == "will" then
  elseif phase == "did" then
  end 
end

function scene:destroy( event )
  local sceneGroup = self.view
  
  if myImage then
    myImage:removeSelf()
    myImage = nil
  end
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene	