-- main. last modify by Maxim

-- инициализация SSK2
require "ssk2.loadSSK"
_G.ssk.init()
--
--инициализация физики
local physics = require "physics"
physics.start()
physics.setGravity(0,0)
--
-- инициализация ponytiled
local tiled = require "ponytiled"
--
-- подгружаем карту 
local mapData = require "maps.map" -- load from lua export
local dir = "maps.objects"
local map = tiled.new(mapData, "") --аргумент dir не воспринимается как должно, работает по дефолту
--
--привязываем к переменной объект hero
local player = map:findObject("hero")
player.x = display.contentCenterX
player.y = display.contentCenterY
player:toFront()
--

----------------------------------------MOVEMENT WITH JOYSTICK------------------------------------------
-- инициализация джойстика
local joystick = ssk.easyInputs.oneStick.create( group, { debugEn = true, joyParams = { doNorm = true, eventName = "onJoystick", stickOnRight = true } }) 
--

--функции реализующие движение в любом из 8 направлений
function player.doNorth( self ) 
	player.y = player.y - 2
end

function player.doNorthEast( self ) 
   player.y = player.y - 1
   player.x = player.x + 1
end

function player.doEast( self ) 
   player.x = player.x + 2
end

function player.doSouthEast( self ) 
   player.x = player.x + 1
   player.y = player.y + 1
end

function player.doSouth( self ) 
   player.y = player.y + 2
end

function player.doSouthWest( self ) 
   player.x = player.x - 1
   player.y = player.y + 1
end

function player.doWest( self ) 
   player.x = player.x -2
end

function player.doNorthWest( self ) 
   player.x = player.x - 1
   player.y = player.y - 1
end
--


function player.onJoystick( self, event )
   local angle = event.angle
   local offset = 22.5

   if( angle <= offset  ) then --
      self:doNorth()

   elseif( angle > offset and angle <= 45 + offset ) then
      self:doNorthEast()

   elseif( angle > 45 + offset and angle <= 90 + offset ) then
      self:doEast()

   elseif( angle > 90 + offset and angle <= 135 + offset ) then
      self:doSouthEast()

   elseif( angle > 135 + offset and angle <= 180 + offset ) then
      self:doSouth()

   elseif( angle > 180 + offset and angle <= 225 + offset ) then
      self:doSouthWest()

   elseif( angle > 225 + offset and angle <= 270 + offset ) then
      self:doWest()

   elseif( angle > 270 + offset and angle <= 315 + offset ) then
      self:doNorthWest()

   elseif( angle > 315 + offset ) then
      self:doNorth()
   end
end; listen( "onJoystick", player )

--------------------------------------------------------------------------------------------------------