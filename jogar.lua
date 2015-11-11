
local composer = require( "composer" )
local scene = composer.newScene()

local fisica = require("physics")
fisica.start()  
physics.setGravity( 0, 4 )

local aux_formaspilotoLinha = 2
local Aux_FormasPilotoColuna = 2
local gravidade = 1

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
  background:addEventListener("touch", swipe)

  local ground = display.newImage( "images/ground.png", _W/2, _H+20 )
  ground.myName = "ground"
  fisica.addBody( ground, "static", { friction=0.5, bounce=0.3 } )
  selfGroup:insert(ground)

  local formas = {}
  formas[1] = {"images/circulovermelho30x30.png", "images/circuloazul30x30.png", "images/circuloverde30x30.png"}  
  formas[2] = {"images/quadradovermelho30x30.png", "images/quadradoazul30x30.png", "images/quadradoverde30x30.png"}   
  formas[3] = {"images/triangulovermelho30x30.png", "images/trianguloazul30x30.png","images/trianguloverde30x30.png"}             

  local forma_piloto = {}
  forma_piloto[1] = {"images/circulovermelho30x30.png", "images/circuloazul30x30.png", "images/circuloverde30x30.png"}  
  forma_piloto[2] = {"images/quadradovermelho30x30.png", "images/quadradoazul30x30.png", "images/quadradoverde30x30.png"}   
  forma_piloto[3] = {"images/triangulovermelho30x30.png", "images/trianguloazul30x30.png","images/trianguloverde30x30.png"}  

  local formas_selecao = {}
  formas_selecao[1] = {"images/circulovermelho8x8.png", "images/circuloazul8x8.png", "images/circuloverde8x8.png"}
  formas_selecao[2] = {"images/quadradovermelho8x8.png", "images/quadradoazul8x8.png", "images/quadradoverde8x8.png"} 
  formas_selecao[3] = {"images/triangulovermelho8x8.png", "images/trianguloazul8x8.png","images/trianguloverde8x8.png"}

  formas_piloto = display.newImage(forma_piloto[aux_formaspilotoLinha][Aux_FormasPilotoColuna])
  formas_piloto.x = _W/2
  formas_piloto.y = _H-80
  formas_piloto.myName = forma_piloto[aux_formaspilotoLinha][Aux_FormasPilotoColuna]
  fisica.addBody(formas_piloto, "static", { friction=0.5, bounce=0.3 } )

  --[[formas_piloto_proximo = display.newImage(formas_selecao[aux_formaspilotoLinha][Aux_FormasPilotoColuna + 1])
  formas_piloto_proximo.x = _W-70
  formas_piloto_proximo.y = _H-70
  formas_piloto_proximo.myName = formas_selecao[aux_formaspilotoLinha][Aux_FormasPilotoColuna + 1]
  selfGroup:insert(formas_piloto_proximo)

  formas_piloto_anterior = display.newImage(formas_selecao[aux_formaspilotoLinha][Aux_FormasPilotoColuna - 1])
  formas_piloto_anterior.x = _W-260
  formas_piloto_anterior.y = _H-70
  formas_piloto_anterior.myName = formas_selecao[aux_formaspilotoLinha][Aux_FormasPilotoColuna - 1]
  selfGroup:insert(formas_piloto_anterior)  ]]

  local pontos = 0
  local vidas = 50
  local display_pontuacao = display.newText(string.format("Pontos: %04d", pontos), 260, -30, native.systemFontCalibri, 20)
  selfGroup:insert(display_pontuacao)
  local display_vidas = display.newText(string.format("Vidas Restantes: %d", vidas), 92, -30, native.systemFontCalibri, 20)  
  selfGroup:insert(display_vidas)

  function onLocalCollision( self, event )
    if event.phase =="began" then                      
      if formas_piloto.myName == forma.myName then                                                                
        event.other:removeSelf()  
        print("colidiu correto")
        gravidade = gravidade + 0.5
        atualizapontos("+", 10)                      
      end
    else                                          
      event.other:removeSelf()
      print("colidiu errado")
      gravidade = gravidade + 0.8
      atualizapontos("-", 1)  
    end
  end   

  function tocar_formas_piloto(event)    
    if event.phase == "ended" then       
      --[[if (aux_formaspiloto == table.maxn(forma_piloto)) then
        --aux_formaspiloto = 1
        --print("Aux_FormasPiloto - tocar_formas_piloto")
      end]]

      formas_piloto:removeEventListener( "collision" )   
      formas_piloto:removeSelf()
      formas_piloto = nil   
      print("exclui")

      formas_piloto = display.newImage(forma_piloto[aux_formaspilotoLinha][Aux_FormasPilotoColuna])
      formas_piloto.x = _W/2
      formas_piloto.y = _H-80
      formas_piloto.myName = forma_piloto[aux_formaspilotoLinha][Aux_FormasPilotoColuna]
      print("criou")
      selfGroup:insert(formas_piloto)

      --[[formas_piloto_proximo:removeSelf()
      formas_piloto_proximo = nil
      
      if (Aux_FormasPilotoColuna == table.maxn(forma_piloto)) then
        formas_piloto_proximo = display.newImage(formas_selecao[aux_formaspilotoLinha][1])
        formas_piloto_proximo.myName = formas_selecao[aux_formaspilotoLinha][1]
      else
        formas_piloto_proximo = display.newImage(formas_selecao[aux_formaspilotoLinha][Aux_FormasPilotoColuna + 1])
        formas_piloto_proximo.myName = formas_selecao[aux_formaspilotoLinha][Aux_FormasPilotoColuna + 1]
      end

      formas_piloto_proximo.x = _W-70
      formas_piloto_proximo.y = _H-70
      selfGroup:insert(formas_piloto_proximo)]]

      --[[formas_piloto_anterior:removeSelf()
      formas_piloto_anterior = nil
      
      if (Aux_FormasPilotoColuna == 1) then
        formas_piloto_anterior = display.newImage(formas_selecao[aux_formaspilotoLinha][3])
        formas_piloto_anterior.myName = formas_selecao[aux_formaspilotoLinha][3]
      else
        formas_piloto_anterior = display.newImage(formas_selecao[aux_formaspilotoLinha][Aux_FormasPilotoColuna - 1])
        formas_piloto_anterior.myName = formas_selecao[aux_formaspilotoLinha][Aux_FormasPilotoColuna - 1]
      end

      formas_piloto_anterior.x = _W-260
      formas_piloto_anterior.y = _H-70
      selfGroup:insert(formas_piloto_anterior)]]
      
      formas_piloto.collision = onLocalCollision 
      formas_piloto:addEventListener( "collision")
      print("adicinou colisão e toque")

      fisica.addBody(formas_piloto, "static", { friction=1, bounce=0.3 } ) 
    end
  end  

  function move_formas(move_formas)
    
    local sorteiroformacoluna = math.random(3)
    local sorteiroformalinha = math.random(3)

    LinhaForma = sorteiroformalinha
    ColunaForma = sorteiroformacoluna

    forma = display.newImage(formas[LinhaForma][ColunaForma])    

    forma:removeSelf()
    forma = nil
    forma = display.newImage(formas[LinhaForma][ColunaForma])
    forma.isSensor = false
    forma.x = _W/2
    forma.y = -100
    forma.myName = formas[LinhaForma][ColunaForma]

    print("Nome forma sorteada:", forma.myName)

    fisica.addBody(forma, { density=5.0, friction=0.5, bounce=0.3 } )    
    physics.setGravity( 0, gravidade ) 
    
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
  
  formas_piloto.collision = onLocalCollision  
  formas_piloto:addEventListener( "collision") 
end

function checkSwipeDirection(event)
    local distancex =  endSwipeX - beginSwipeX
    local distancey =  endSwipeY - beginSwipeY

    print("X: ", distancex)
    print("Y: ", distancey)    
    
    if (distancex > 0) and ((distancey > -20) and (distancey < 20)) then
        if Aux_FormasPilotoColuna == 1 then
          Aux_FormasPilotoColuna = 3
        else
          Aux_FormasPilotoColuna = Aux_FormasPilotoColuna - 1
        end
        tocar_formas_piloto(event)
        print("Esquerda")
    elseif (distancex < 0) and ((distancey > -20) and (distancey < 20)) then
        if Aux_FormasPilotoColuna == 3 then
          Aux_FormasPilotoColuna = 1
        else
          Aux_FormasPilotoColuna = Aux_FormasPilotoColuna + 1
        end
        tocar_formas_piloto(event)
        print("Direita")
    elseif (distancey < 0) and ((distancex > -20) and (distancex < 20)) then
        if aux_formaspilotoLinha == 3 then
          aux_formaspilotoLinha = 3
        else
          aux_formaspilotoLinha = aux_formaspilotoLinha + 1
        end
        tocar_formas_piloto(event)
        print("Para Baixo")
    elseif (distancey > 0) and ((distancex > -20) and (distancex < 20)) then
        if aux_formaspilotoLinha == 1 then
          aux_formaspilotoLinha = 1
        else
          aux_formaspilotoLinha = aux_formaspilotoLinha - 1
        end
        tocar_formas_piloto(event)
        print("Para Cima")
    else
        print("Apenas Toque")
        distancey = 0
        distancex = 0
    end

    distancex = 0
    distancey = 0
end

function swipe (event)
    if event.phase == "began" then
        beginSwipeX = event.x
        beginSwipeY = event.y
    end
    if event.phase == "ended" then
        endSwipeX = event.x
        endSwipeY = event.y
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