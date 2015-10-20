
local composer = require( "composer" )
local scene = composer.newScene()

local fisica = require("physics")
fisica.start()  

local aux_formaspiloto = 2

_W = display.contentWidth 
_H = display.contentHeight

function gameover()
  fisica.pause()  
  composer.removeScene( "jogar" )
  composer.gotoScene("gameover", transicaoCena)
  print("terminou gameover")
end

function scene:create( event ) 
  selfGroup = self.view

  local background = display.newImage("images/background2.jpg")
  background.x = _W/2
  background.y = _H/2
  selfGroup:insert(background)

  local ground = display.newImage( "images/ground.png", _W/2, _H+20 )
  ground.myName = "ground"
  fisica.addBody( ground, "static", { friction=0.5, bounce=0.3 } )
  selfGroup:insert(ground)

  --[[local diretorios = {"triangulo", "circulo", "quadrado"}

  local cores {"vermelho", "azul", "verde"}
  
  local formas = "30x30.png"]]

  local formas = {"images/triangulovermelho30x30.png", "images/trianguloazul30x30.png","images/trianguloverde30x30.png",
                  "images/circulovermelho30x30.png", "images/circuloazul30x30.png", "images/circuloverde30x30.png",
                  "images/quadradovermelho30x30.png", "images/quadradoazul30x30.png", "images/quadradoverde30x30.png"}

  local forma_piloto = {"images/triangulovermelho30x30.png", "images/trianguloazul30x30.png","images/trianguloverde30x30.png",
                        "images/circulovermelho30x30.png", "images/circuloazul30x30.png", "images/circuloverde30x30.png",
                        "images/quadradovermelho30x30.png", "images/quadradoazul30x30.png", "images/quadradoverde30x30.png"}    

  local formas_selecao = {"images/triangulovermelho8x8.png", "images/trianguloazul8x8.png","images/trianguloverde8x8.png",
                          "images/circulovermelho8x8.png", "images/circuloazul8x8.png", "images/circuloverde8x8.png",
                          "images/quadradovermelho8x8.png", "images/quadradoazul8x8.png", "images/quadradoverde8x8.png"} 

  formas_piloto = display.newImage(forma_piloto[aux_formaspiloto])
  formas_piloto.x = _W/2
  formas_piloto.y = _H-80
  formas_piloto.myName = aux_formaspiloto
  fisica.addBody(formas_piloto, "static", { friction=0.5, bounce=0.3 } )

  formas_piloto_proximo = display.newImage(formas_selecao[aux_formaspiloto + 1])
  formas_piloto_proximo.x = _W/2
  formas_piloto_proximo.y = _H-80
  formas_piloto_proximo.myName = aux_formaspiloto
  selfGroup:insert(formas_piloto_proximo)

  formas_piloto_anterior = display.newImage(formas_selecao[aux_formaspiloto - 1])
  formas_piloto_anterior.x = _W/2
  formas_piloto_anterior.y = _H-80
  formas_piloto_anterior.myName = aux_formaspiloto
  selfGroup:insert(formas_piloto_anterior)  

  local pontos = 0
  local vidas = 5
  local display_pontuacao = display.newText(string.format("Pontos: %04d", pontos), 260, -30, native.systemFontCalibri, 20)
  selfGroup:insert(display_pontuacao)
  local display_vidas = display.newText(string.format("Vidas Restantes: %d", vidas), 88, -30, native.systemFontCalibri, 20)  
  selfGroup:insert(display_vidas)

  local numero = 1

  function onLocalCollision( self, event )
    if event.phase =="began" then                      
      if formas_piloto.myName == forma.myName then                                                                
        event.other:removeSelf()  
        print("colidiu correto")
        atualizapontos("+", 10)                      
      end
    else                                          
      event.other:removeSelf()
      print("colidiu errado")
      atualizapontos("-", 1)  
    end
  end   

  function tocar_formas_piloto(event)    
    if event.phase == "ended" then       
      if (aux_formaspiloto == table.maxn(forma_piloto)) then
        aux_formaspiloto = 1
      end

      print("aux_formaspiloto ", aux_formaspiloto)

      formas_piloto:removeEventListener("touch", swipe)
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

      formas_piloto_proximo:removeSelf()
      formas_piloto_proximo = nil
      
      if (aux_formaspiloto == table.maxn(forma_piloto)) then
        formas_piloto_proximo = display.newImage(formas_selecao[1])
      else
        formas_piloto_proximo = display.newImage(formas_selecao[aux_formaspiloto + 1])
      end

      formas_piloto_proximo.x = _W/2
      formas_piloto_proximo.y = _H-55
      formas_piloto_proximo.myName = aux_formaspiloto
      selfGroup:insert(formas_piloto_proximo)

      formas_piloto_anterior:removeSelf()
      formas_piloto_anterior = nil
      
      if (aux_formaspiloto == 1) then
        formas_piloto_anterior = display.newImage(formas_selecao[table.maxn(forma_piloto)])
      else
        formas_piloto_anterior = display.newImage(formas_selecao[aux_formaspiloto - 1])
      end

      formas_piloto_anterior.x = _W/2
      formas_piloto_anterior.y = _H-85
      formas_piloto_anterior.myName = aux_formaspiloto
      selfGroup:insert(formas_piloto_anterior)

      formas_piloto:addEventListener("touch", swipe)
      formas_piloto.collision = onLocalCollision 
      formas_piloto:addEventListener( "collision")
      print("adicinou colisão e toque")

      fisica.addBody(formas_piloto, "static", { friction=0.5, bounce=0.3 } ) 
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

    fisica.addBody(forma, { density=5.0, friction=0.5, bounce=0.3 } ) 
    
    print("adcionou toque e colisao inicial")    
  end

  function atualizapontos(operacao, valor)
    if operacao == "-" then
      vidas = vidas - valor
      display_vidas.text = string.format("Vidas Restantes: %d", vidas)

      print("chamou -")
      if (vidas == 0) then  gameover() else timer.performWithDelay(1,move_formas,1) end 
    end

    if operacao == "+" then
      pontos = pontos + valor
      display_pontuacao.text = string.format("Pontos: %04d", pontos)

      print("chamou +")
      if (vidas == 0) then  gameover() else timer.performWithDelay(1,move_formas,1) end
    end
  end   

  print("iniciou")
  move_formas(formas)
  selfGroup:insert(forma)
  selfGroup:insert(formas_piloto)
  
  formas_piloto:addEventListener("touch", swipe)
  formas_piloto.collision = onLocalCollision  
  formas_piloto:addEventListener( "collision") 
end

function checkSwipeDirection(event)
    local distance =  endSwipeX - beginSwipeX
    if distance < -2 then
        if aux_formaspiloto == 1 then
          aux_formaspiloto = 6--table.maxn(forma_piloto)
        else
          aux_formaspiloto = aux_formaspiloto - 1
        end
        tocar_formas_piloto(event)
        print("Esquerda")
    elseif distance > 2 then
        aux_formaspiloto = aux_formaspiloto + 1
        tocar_formas_piloto(event)
        print("Direita")
    else
        print("Apenas Toque")
        distance = 0
    end

    distance = 0
end

function swipe (event)
    if event.phase == "began" then
        beginSwipeX = event.x
    end
    if event.phase == "ended" then
        endSwipeX = event.x
        checkSwipeDirection(event)
    end
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