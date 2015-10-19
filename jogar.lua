
local composer = require( "composer" )
local scene = composer.newScene()

local fisica = require("physics")
fisica.start()  

_W = display.contentWidth 
_H = display.contentHeight

function gameover()
  physics.pause()   
  --formas_piloto:removeSelf()
  composer.gotoScene("gameover", transicaoCena)
  print("terminou gameover")
end

function scene:create( event ) 
  local selfGroup = self.view

  local background = display.newImage("images/background2.jpg")
  background.x = _W/2
  background.y = _H/2
  selfGroup:insert(background)

  local ground = display.newImage( "images/ground.png", _W/2, _H+20 )
  ground.myName = "ground"
  physics.addBody( ground, "static", { friction=0.5, bounce=0.3 } )
  selfGroup:insert(ground)

  print("Criou imagens background")
  
  local formas = {"images/triangulovermelho30x30.png", "images/trianguloazul30x30.png","images/trianguloverde30x30.png",
                  "images/circulovermelho30x30.png", "images/circuloazul30x30.png", "images/circuloverde30x30.png",
                  "images/quadradovermelho30x30.png", "images/quadradoazul30x30.png", "images/quadradoverde30x30.png"}

  local forma_piloto = {"images/triangulovermelho30x30.png", "images/trianguloazul30x30.png","images/trianguloverde30x30.png",
                        "images/circulovermelho30x30.png", "images/circuloazul30x30.png", "images/circuloverde30x30.png",
                        "images/quadradovermelho30x30.png", "images/quadradoazul30x30.png", "images/quadradoverde30x30.png"}    

  local formas_selecao = {"images/triangulovermelho8x8.png", "images/trianguloazul8x8.png","images/trianguloverde8x8.png",
                          "images/circulovermelho8x8.png", "images/circuloazul8x8.png", "images/circuloverde8x8.png",
                          "images/quadradovermelho8x8.png", "images/quadradoazul8x8.png", "images/quadradoverde8x8.png"} 

  print("Criou vetores")

  local aux_formaspiloto = 1
  local formas_piloto = display.newImage(forma_piloto[aux_formaspiloto])
  formas_piloto.x = _W/2
  formas_piloto.y = _H-80
  formas_piloto.myName = aux_formaspiloto
  physics.addBody(formas_piloto, "static", { friction=0.5, bounce=0.3 } )

  local pontos = 0
  local vidas = 2
  local display_pontuacao = display.newText(string.format("Pontos: %04d", pontos), 260, -30, native.systemFontCalibri, 20)
  selfGroup:insert(display_pontuacao)
  local display_vidas = display.newText(string.format("Vidas Restantes: %d", vidas), 88, -30, native.systemFontCalibri, 20)  
  selfGroup:insert(display_vidas)

  local numero = 1

  function atualizapontos(operacao, valor)
    if operacao == "-" then
      vidas = vidas - valor
      display_vidas.text = string.format("Vidas Restantes: %d", vidas)

      print("chamou -")
      if (vidas == 0) then  gameover() end 
    end

    if operacao == "+" then
      pontos = pontos + valor
      display_pontuacao.text = string.format("Pontos: %04d", pontos)

      print("chamou +")
      if (vidas == 0) then  gameover() end
    end
  end 

  local function onLocalCollision( self, event )
    if event.phase =="began" then                      
      if formas_piloto.myName == forma.myName then                                            
        timer.performWithDelay(1,move_formas,1)                        
        event.other:removeSelf()  
        print("colidiu correto")
        atualizapontos("+", 10)                      
      end
      else                      
        timer.performWithDelay(1,move_formas,1)                        
        --event.target:removeSelf()                        
        event.other:removeSelf()
        print("colidiu errado")
        atualizapontos("-", 1)  
      end
  end   

  function tocar_formas_piloto(event)    
    if event.phase == "began" then  
      if (aux_formaspiloto == table.maxn(forma_piloto)) then
        aux_formaspiloto = 1
      else
        aux_formaspiloto = aux_formaspiloto + 1
      end

      print("aux_formaspiloto ", aux_formaspiloto)

      formas_piloto:removeEventListener("touch", tocar_formas_piloto)
      formas_piloto:removeEventListener( "collision" )   
      formas_piloto:removeSelf()
      formas_piloto = nil   
      print("exclui")

      formas_piloto = display.newImage(forma_piloto[aux_formaspiloto])
      formas_piloto.x = _W/2
      formas_piloto.y = _H-80
      formas_piloto.myName = aux_formaspiloto
      print("criou")
      selfGroup:insert(formas_piloto)

      formas_piloto:addEventListener("touch", tocar_formas_piloto)
      formas_piloto.collision = onLocalCollision 
      formas_piloto:addEventListener( "collision")
      print("adicinou colisão e toque")

      physics.addBody(formas_piloto, "static", { friction=0.5, bounce=0.3 } ) 
    end
  end

  function move_formas(move_formas)
    local sorteiroforma = math.random(9)

    forma = display.newImage(formas[sorteiroforma])    

    forma:removeSelf()
    forma = nil
    forma = display.newImage(formas[sorteiroforma])
    forma.isSensor = false
    forma.x = _W/2
    forma.y = -100
    forma.myName = sorteiroforma

    physics.addBody(forma, { density=5.0, friction=0.5, bounce=0.3 } ) 
    
    print("adcionou toque e colisao inicial") 
    
  end

  print("iniciou")
  move_formas(formas)
  selfGroup:insert(forma)
  selfGroup:insert(formas_piloto)
  
  formas_piloto:addEventListener("touch", tocar_formas_piloto)
  formas_piloto.collision = onLocalCollision  
  formas_piloto:addEventListener( "collision") 
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