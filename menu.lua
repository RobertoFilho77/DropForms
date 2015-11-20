local composer = require( "composer" )
local scene = composer.newScene()

_W = display.contentWidth 
_H = display.contentHeight


function scene:create( event )
  local group = self.view

  --Adiciona o background
  local background = display.newImage("images/background2.png")
  background.x = _W/2
  background.y = _H/2
  group:insert(background)  

  --Adiciona o botão de start
  local start = display.newImage("images/start.png")
  start.x = _W/2 
  start.y = _H/2 + 80
  start.xScale = 0.4
  start.yScale = 0.4	
  group:insert(start) 

  --Adiciona o botão de creditos
  local creditos = display.newImage("images/botao_creditos.png")
  creditos.x = _W/2 
  creditos.y = _H/2 + 180
  creditos.xScale = 0.4
  creditos.yScale = 0.4  
  group:insert(creditos)  

  titulo = display.newImage("images/drop_forms_menu.png")
  titulo.x = _W-160
  titulo.y = _H-352
  titulo.myName = "titulo"
  group:insert(titulo) 

  --local circle = display.newCircle( 50, 50, 100 )
  --circle:setFillColor( 0, 1, 0 )
  --local function moveCircle( event )
  --    circle.x = event.x
  --    circle.y = event.y
  --end
  --Runtime:addEventListener( "touch", moveCircle )  

  local function start_game()
    composer.gotoScene("jogar", transicaoCena)
    composer.removeScene("menu")
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