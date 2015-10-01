  --Requisita o storyboard e cria uma nova cena
local storyboard = require("storyboard")
local scene = storyboard.newScene()

--Adiciona física e gravidade
local fisica = require("physics")
fisica.start()
--physics.setGravity( 0, 15 )

_W = display.contentWidth 
_H = display.contentHeight

local formas = {"images/triangulovermelho30x30.png", "images/trianguloazul30x30.png","images/trianguloverde30x30.png",
                    "images/circulovermelho30x30.png", "images/circuloazul30x30.png", "images/circuloverde30x30.png",
                    "images/quadradovermelho30x30.png", "images/quadradoazul30x30.png", "images/quadradoverde30x30.png"}

local forma_piloto = {"images/triangulovermelho30x30.png", "images/trianguloazul30x30.png","images/trianguloverde30x30.png",
                    "images/circulovermelho30x30.png", "images/circuloazul30x30.png", "images/circuloverde30x30.png",
                    "images/quadradovermelho30x30.png", "images/quadradoazul30x30.png", "images/quadradoverde30x30.png"}                    


--Adiciona o background
local background = display.newImage("images/background2.jpg")
background.x = _W/2
background.y = _H/2

local ground = display.newImage( "images/ground.png", _W/2, _H+20 )
ground.myName = "ground"
physics.addBody( ground, "static", { friction=0.5, bounce=0.3 } )


local aux_formaspiloto = 1
local formas_piloto = display.newImage(forma_piloto[aux_formaspiloto])
formas_piloto.x = _W/2
formas_piloto.y = _H-80
formas_piloto.myName = aux_formaspiloto
physics.addBody(formas_piloto, "static", { friction=0.5, bounce=0.3 } )  

local pontos = 0
local vidas = 5
local display_pontuacao = display.newText(string.format("Pontos: %04d", pontos), 260, -30, native.systemFontCalibri, 20)
local display_vidas = display.newText(string.format("Vidas Restantes: %d", vidas), 88, -30, native.systemFontCalibri, 20)


function scene:createScene(event)
  local group = self.view

  local numero = 1

  function atualizapontos(operacao, valor)
    if operacao == "-" then
      vidas = vidas - valor
      display_vidas.text = string.format("Vidas Restantes: %d", vidas)

      if (vidas == 0) then  gameover() end 
    end

    if operacao == "+" then
      pontos = pontos + valor
      display_pontuacao.text = string.format("Pontos: %04d", pontos)

      if (vidas == 0) then  gameover() end
    end
  end

  function move_formas(move_formas)
    
    local sorteiroforma = math.random(9)

    forma = nil
    forma = display.newImage(formas[sorteiroforma])
    forma.isSensor = false
    forma.x = _W/2
    forma.y = -100
    forma.myName = sorteiroforma

    physics.addBody(forma, { density=5.0, friction=0.5, bounce=0.3 } )  
  end  

  local function onLocalCollision( self, event )
    if event.phase =="began" then                      
      if formas_piloto.myName == forma.myName then                                            
        timer.performWithDelay(5,move_formas,1)                        
        event.other:removeSelf()  
        atualizapontos("+", 10)                      
      end
      else                      
        timer.performWithDelay(5,move_formas,1)                        
        --event.target:removeSelf()                        
        event.other:removeSelf()
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

      formas_piloto:removeEventListener("touch", tocar_formas_piloto)
      formas_piloto:removeEventListener( "collision" )   
      formas_piloto.x = _W * aux_formaspiloto
      formas_piloto.y = _H* aux_formaspiloto 
      formas_piloto:removeSelf()
      formas_piloto = nil   
      print("exclui")

      formas_piloto = display.newImage(forma_piloto[aux_formaspiloto])
      formas_piloto.x = _W/2
      formas_piloto.y = _H-80
      formas_piloto.myName = aux_formaspiloto
      print("criou")

      formas_piloto:addEventListener("touch", tocar_formas_piloto)
      formas_piloto.collision = onLocalCollision 
      formas_piloto:addEventListener( "collision")
      print("adicinou colisão e toque")

      physics.addBody(formas_piloto, "static", { friction=0.5, bounce=0.3 } ) 
    end
  end
  formas_piloto:addEventListener("touch", tocar_formas_piloto)
  formas_piloto.collision = onLocalCollision  
  formas_piloto:addEventListener( "collision")

  print("iniciou")
  move_formas( formas )
end

function goto_gameover()
  formas_piloto:removeEventListener("touch", tocar_formas_piloto)
  formas_piloto:removeEventListener( "collision") 
  display.remove(fisica)
  display.remove(formas)
  display.remove(forma_piloto)
  display.remove(background)
  display.remove(ground)
  display.remove(formas_piloto)
  display.remove(display_pontuacao)
  display.remove(display_vidas)
  display.remove(forma) 
  display.remove(sorteioformas_piloto_posterior)
  storyboard.gotoScene("gameover")
end 

function gameover()
  physics.pause()   
  goto_gameover()
end


--Recebe os metodos criados
scene:addEventListener("createScene", scene)
scene:addEventListener("goto_gameover", scene)
scene:addEventListener("gameover", scene)
return scene

