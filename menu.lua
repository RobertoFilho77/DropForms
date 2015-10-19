local composer = require( "composer" )
local scene = composer.newScene()

_W = display.contentWidth 
_H = display.contentHeight


function scene:create( event )
  local group = self.view

  --Adiciona o background
  local background = display.newImage("images/background2.jpg")
  background.x = _W/2
  background.y = _H/2
  group:insert(background)  

  --Adiciona o botão de start
  local start = display.newImage("images/start.png")
  start.x = _W/2 
  start.y = _H/2 + 220
  start.xScale = 0.4
  start.yScale = 0.4	
  group:insert(start)

  local function start_game()
    composer.gotoScene("jogar", transicaoCena)
  end

  start:addEventListener("tap", start_game)

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