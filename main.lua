--local clock = os.clock
--function sleep(n)  -- seconds
  --local t0 = clock()
  --while clock() - t0 <= n do end
--end

--local runtime = 0
 
--local function getDeltaTime()
    --local temp = system.getTimer()  -- Get current game time in ms
    --local dt = (temp-runtime) / (1000/60)  -- 60 fps or 30 fps as base
    --runtime = temp  -- Store game time
    --return dt
--end

-- dodanie/deklaracja silnika fizycznego
--wlaczenie silnika fizycznego
--zastosowanie grawitacji
--dodanie opcji moultitouch 

local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 4.9 )
system.activate( "multitouch" )
 
 
-- sprawdzanie promienia 
 
-- physics.setDrawMode("hybrid")



--ukrycie gornego paska(zasieg, siec, stan bateri itp)
display.setStatusBar( display.MiddenStatusBar )



--dodanie tla

local background = display.newImage("tlo2.png")




-- dodanie i deklarowanie balonow 
-- umiejscowienie balonow os x,y
-- ustawienie fizycznosci balonow :sila odbicia,promien do ustawienia odbijania sie balonu, 
--> tarcie zeby nie krecil sie bez zatrzymania i bez oporu czyli nadanie balonom fizycznego ciala

local ballon = display.newImage("balon.png")
ballon.x = display.contentWidth/2
ballon.y = display.contentHeight/7
physics.addBody(ballon, { bounce = 0.5, radius = 38, friction = 1.0 })
ballon.dyingTime = 1000

local ballon2 = display.newImage("balon1.png")
ballon2.x = ballon.x - 105
ballon2.y = display.contentHeight/7
physics.addBody(ballon2, { bounce=0.4, radius = 38, friction = 1.0 })


local ballon3 = display.newImage("balon2.png")
ballon3.x = ballon.x + 105
ballon3.y = display.contentHeight/7
physics.addBody(ballon3, { bounce=0.3, radius = 38, friction = 1.0 })




-- deklaracja scian oraz dopasowanie do ekranu tak aby koniec ekranu aplikacji byl sciana

local leftWall = display.newRect( 12, 0, 21, 961.5 )
local rightWall = display.newRect(display.contentWidth/1.046, 12, 20, 960 )
local ceiling = display.newRect(1, -1, 960, 1 )

-- nadanie statycznosci scianom ustawienie sily odbicia  
physics.addBody(leftWall, "static", {bounce = 0.1, friction = 3.0  } )
physics.addBody(rightWall, "static", {bounce = 0.1, friction = 3.0 } )
physics.addBody(ceiling, "static", {bounce = 0.1, friction = 3.0 } )


-- deklaracja podlogi/pietra
-- umiejscowienie podlogi pietra 
-- nadanie statycznosci, ustawienie odbijalnosci oraz tarcia
local floor = display.newImage("floor.png")
floor.y = display.contentHeight - floor.stageHeight/2 + 90
floor.x = 120
physics.addBody(floor, "static", { bounce = 0.0, friction = 2.0 }) 


-- definiowanie funcji dotyku  dla balonow
-- ustawienie kierunku poruszania sie balonow
function moveBallon(event)
	local ballon = event.target
	ballon:applyLinearImpulse( 0, -0.1, event.x, event.y )
	--ballon:removeSelf()
	--ballon = nil
--	ballon.dyingTime = 0
end
	
--function pieprzniecieWSciane(event)
--	local ballon = event.target
----	if ballon.y>display.contentHeight - floor.stageHeight/2 then
----		ballon:removeSelf
		--ballon = nil
----	end
----end
	
	
	
	
--	local onCollision = function(event)
--        if event.phase == "began" then
--			event.target:removeSelf();
--            event.target= nil;
--        end
--end
--Runtime:addEventListener("collision",onCollision);
	
local function onLocalCollision( self, event )
 
    if event.phase == "began" then
		--if event.other == floor then
		event.other:removeSelf();
		event.other=nil
		--end
    --elseif ( event.phase == "ended" ) then
        
    end
end
 
--ballon.collision = onLocalCollision
--ballon:addEventListener( "collision" )	
--ballon2.collision = onLocalCollision
--ballon2:addEventListener( "collision" )	
--ballon3.collision = onLocalCollision
--ballon3:addEventListener( "collision" )	
floor.collision = onLocalCollision
floor:addEventListener( "collision" )	
	
	

--function frameUpdate(frameTime)
--	if ballon ~= nil then
--        ballon.dyingTime = ballon.dyingTime - frameTime
--        if ballon.dyingTime < 0 then
--            ballon:removeSelf()
--            ballon = nil
--        end
--    end
--end

--local function frameUpdate()
 
   -- Delta Time value
  -- local dt = getDeltaTime()
	--if ballon ~= nil then
      --  ballon.dyingTime = ballon.dyingTime - dt
        --if ballon.dyingTime < 0 then
          --  ballon:removeSelf()
            --ballon = nil
        --end
   -- end

 
--end
 
-- Frame update listener
--Runtime:addEventListener( "enterFrame", frameUpdate )



--Runtime:addEventListener( "enterFrame", frameUpdate )

	
ballon:addEventListener("touch", moveBallon)	
ballon2:addEventListener("touch", moveBallon)	
ballon3:addEventListener("touch", moveBallon)	