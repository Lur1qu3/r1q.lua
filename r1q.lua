setDefaultTab("Main")
UI.Separator()
local version = " CUSTOM"
local nick = "RIQUE".. version
local Nome = UI.Label(nick)

modules.game_textmessage.displayGameMessage("["..nick.."] Bem Vindo A Custom RIQUE!")

local cores = {"green", "red", "black", "green", "orange"}
local cores2 = 0
macro(50, function()
  cores2 = cores2==#cores and 0 or cores2+1 -- s2 <3
  Nome:setColor(cores[cores2]) -- s2 <3
end)


UI.Separator()

marcar = macro(500, function()
  for i, spec in ipairs(getSpectators()) do
    if spec then
      spec:setText("\n" .. "\n" .. "\n" .. "\n" .. "\n" .. spec:getHealthPercent().."%")
    end
  end
end)

addIcon("Views%", {item=814, text="Views%"},marcar)


local loadPanelName = "Restart"
local cores = {"pink", "white", "green", "red", "blue"}
local cores2 = 0

local ui = setupUI([[
Panel
  height: 20

  Button
    id: editLoad
    color: yellow
    font: verdana-11px-rounded
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: 23
    text: Restart
    tooltip: Clique Para Recarregar

]], parent)

ui.editLoad.onClick = function(widget)
    reload()
end

macro(250, function()
    cores2 = cores2 == #cores and 1 or cores2 + 1
    ui.editLoad:setColor(cores[cores2])
end)




UI.Separator()


local riquescripts = addLabel("[P] [V] [P]", "[P] [V] [P]")
riquescripts:setColor("orange")

Turn = {}

Turn.maxDistance = {x = 7, y = 7}
Turn.minDistance = 1
Turn.macro = macro(100, 'ENCARADA', function()
    local target = g_game.getAttackingCreature()
    if target then
        local targetPos = target:getPosition()
        if targetPos then
            local pos = pos()
            local targetDistance = {x = math.abs(pos.x - targetPos.x), y = math.abs(pos.y - targetPos.y)}
            if not (targetDistance.x > Turn.minDistance and targetDistance.y > Turn.minDistance) then
                if targetDistance.x <= Turn.maxDistance.x and targetDistance.y <= Turn.maxDistance.y then
                    local playerDir = player:getDirection()
                    if targetDistance.y >= targetDistance.x then
                        if targetPos.y > pos.y then
                            return playerDir ~= 2 and turn(2)
                        else
                            return playerDir ~= 0 and turn(0)
                        end
                    else
                        if targetPos.x > pos.x then
                            return playerDir ~= 1 and turn(1)
                        else
                            return playerDir ~= 3 and turn(3)
                        end
                    end
                end
            end
        end
    end
end)





local Stack = {};
 
Stack.northPattern = [[
    11111
    11111
    11111
    11111
    11111
    11111
    11111
    11111
    00000
    00000
    00000
    00000
    00000
    00000
    00000
    00000
    00000
]];
 
Stack.southPattern = [[
    00000
    00000
    00000
    00000
    00000
    00000
    00000
    00000
    00000
    11111
    11111
    11111
    11111
    11111
    11111
    11111
    11111
]];
 
Stack.westPattern = [[
    1111111110000000000
    1111111110000000000
    1111111110000000000
    1111111110000000000
    1111111110000000000
]];
 
Stack.eastPattern = [[
    0000000000111111111
    0000000000111111111
    0000000000111111111
    0000000000111111111
    0000000000111111111
]];
 
local spell = storage.stackar;
local maxDistance = 7;
 
 
Stack.icon = addIcon("Stack",  {item=802, text="Stack"}, macro(100, "Stack", function() 
    local furthestMonster = nil;
    local pattern = nil;
    if (modules.corelib.g_keyboard.areKeysPressed("b+W")) then
        pattern = Stack.northPattern;
    elseif (modules.corelib.g_keyboard.areKeysPressed("b+S")) then
        pattern = Stack.southPattern;
    elseif (modules.corelib.g_keyboard.areKeysPressed("b+A")) then
        pattern = Stack.westPattern;
    elseif (modules.corelib.g_keyboard.areKeysPressed("b+D")) then
        pattern = Stack.eastPattern;
    end
 
    if (not pattern) then return; end
 
    local playerPos = pos();
    for _, creature in pairs(getSpectators(playerPos, pattern)) do
        if (not creature:isNpc()) then
            local monsterDistance = getDistanceBetween(playerPos, creature:getPosition())
            if (monsterDistance <= maxDistance and
                (
                    furthestMonster == nil or
                    monsterDistance > getDistanceBetween(playerPos, furthestMonster:getPosition())
                )
            ) then
                furthestMonster = creature;
            end
        end
    end
 
    if (not furthestMonster) then return; end
 
    g_game.stop();
    g_game.attack(furthestMonster);
 
    say(spell);
 
    schedule(600, function()
        g_game.cancelAttack();
    end);
end));






percent = macro(200, "COMBO", function()
 if not g_game.isAttacking() then return end
 if g_game.getAttackingCreature():getHealthPercent() <= 30 then
say(storage.Magia1, 1600)
 end
  local distanciaa = 1
  combodistancia = g_game.getAttackingCreature()
  if getDistanceBetween(pos(),combodistancia:getPosition()) == distanciaa then
  say(storage.rique, 1600)
end
 if g_game.isAttacking() then
 say(storage.Magia2, 1600)
 say(storage.Magia3, 1600)
 say(storage.Magia4, 1600)
 say(storage.Magia5, 1600)
 end
end)

area = macro(100, "NOCAUTE", function()
if not g_game.isAttacking() then return end
 if g_game.getAttackingCreature():getHealthPercent() <= 20 then
stopCombo = now + 500;
say(storage.Area1, 1600)
    end
end)


addIcon("Nocaute", {item=674, text="Nocaute"},area)






macro(200, "T A R G E T", nil, function()
  if g_game.isAttacking() 
then
 oldTarget = g_game.getAttackingCreature()
  end
  if (oldTarget and oldTarget:getPosition()) 
then
 if (not g_game.isAttacking() and getDistanceBetween(pos(), oldTarget:getPosition()) <= 8) then

if (oldTarget:getPosition().z == posz()) then
        g_game.attack(oldTarget)
      end
    end
  end
end)

onKeyDown(function(keys)
 
if keys == "Escape" then
    oldTarget = nil
g_game.cancelAttack()
  end
end)




panel = mainTab;

local bugMap = {};


bugMap.macro = macro(100, "THE FLASH", function()
if not read or modules.game_console:isChatEnabled() then return end
    local pos = pos();
    for key, config in pairs(bugMap.directions) do
        if (bugMap.isKeyPressed(key)) then
            if (storage.bugMapCheck or config.direction) then
                if (config.direction) then
                    turn(config.direction);
                end
                local tile = g_map.getTile({x = pos.x + config.x, y = pos.y + config.y, z = pos.z});
                if (tile) then
                    return g_game.use(tile:getTopUseThing());
                end
            end
        end
    end
end)

read = true


bugMap.checkBox = setupUI([[
CheckBox
  id: checkBox
  font: cipsoftFont
  text: Diagonais
  !tooltip: tr('Usar Diagonais')
]]);


bugMap.checkBox.onCheckChange = function(widget, checked)
    storage.bugMapCheck = checked;
end

if storage.bugMapCheck == nil then
    storage.bugMapCheck = true;
end

bugMap.checkBox:setChecked(storage.bugMapCheck);

bugMap.isKeyPressed = modules.corelib.g_keyboard.isKeyPressed;

bugMap.directions = {
    ["W"] = {x = 0, y = -5, direction = 0},
    ["E"] = {x = 3, y = -3},
    ["D"] = {x = 5, y = 0, direction = 1},
    ["C"] = {x = 3, y = 3},
    ["S"] = {x = 0, y = 5, direction = 2},
    ["Z"] = {x = -3, y = 3},
    ["A"] = {x = -5, y = 0, direction = 3},
    ["Q"] = {x = -3, y = -3}
};








Stairs = {}

excludeIds = {}

stairsIds = {
    1666,
    6207,
    1948,
    435,
    11661,
    7771,
    5542,
    8657,
    6264,
    1646,
    1648,
    1678,
    5291,
    1680,
    6905,
    6262,
    1664,
    13296,
    1067,
    13861,
    11931,
    1949,
    6896,
    6205,
    13926,
    1947,
    1968,
    5111,
    5102,
    7725,
    7727
}

lastWalk = 0
onCreaturePositionChange(
    function(creature, newPos, oldPos)
        if creature == player then
            lastWalk = now
        end
    end
)

standingTime = function()
    return now - lastWalk
end

actualTarget = function()
    local target = g_game.getAttackingCreature or g_game.getAttackinggCreature
    return target()
end



doDistance = function(tPos)
    local pos = pos()
    if getDistanceBetween(pos, tPos) > 1 then
        return
    end
    if pos.x > tPos.x then
        pos.x = pos.x + 2
    elseif pos.x < tPos.x then
        pos.x = pos.x - 2
    elseif pos.y < tPos.y then
        pos.y = pos.y - 2
    elseif pos.y > tPos.y then
        pos.y = pos.y + 2
    end
    local tile = g_map.getTile(pos)
    if tile then
        return g_game.use(tile:getTopThing())
    end
end

checkTile = function(tile)
    if not tile then
        return false
    end

    local topId = tile:getTopUseThing():getId()

    for _, x in ipairs(tile:getItems()) do
        if excludeIds[tostring(x:getId())] then
            return false
        end
    end

    if stairsIds[tostring(topId)] then
        return true
    end

    local cor = g_map.getMinimapColor(tile:getPosition())
    if cor >= 210 and cor <= 213 and not tile:isPathable() and tile:isWalkable() then
        return true
    else
        return false
    end
end

if type(getNearTiles) ~= "function" then
    getNearTiles = function(position)
        local tiles = {}
        for x = -1, 1 do
            for y = -1, 1 do
                local tile = g_map.getTile({x = position.x + x, y = position.y + y, z = position.z})
                if tile then
          table.insert(tiles, tile)
                end
            end
        end
        return tiles
    end
end

getPreciseDistance = function(p1, p2)
    if type(p1) ~= "table" or type(p2) ~= "table" then
        return
    end
    return math.abs(p1.x - p2.x) + math.abs(p1.y - p2.y)
end

hotkey("g", function()
    if not read or modules.game_console:isChatEnabled() then return end
    local standTime = standingTime()
        if player:isAutoWalking() then
      if standTime > 100 then
        return player:stopAutoWalk()
      end
        end
    if standTime <= 50 then
      return
    end
        local target = actualTarget()
        if target and target:isPlayer() then
            local pos = pos()
            local targetPos = target:getPosition()
            local hasStair = nil
            if targetPos and targetPos.z == pos.z then
                for x = -1, 1 do
                    for y = -1, 1 do
                        local tile = g_map.getTile({x = targetPos.x + x, y = targetPos.y + y, z = targetPos.z})
                        if checkTile(tile) then
                            hasStair = tile:getPosition()
                            break
                        end
                    end
                end
                if hasStair then
                    movePos = targetPos
                    local moveTo
                    if getDistanceBetween(targetPos, pos) > 1 then
                        if hasStair.z == pos.z then
                            local tiles = getNearTiles(targetPos)
                            local startPos
                            for _, tile in ipairs(tiles) do
                                local tilePos = tile:getPosition()
                                if tile:isWalkable() and tile:isPathable() then
                                    if
                                        not startPos or
                                            getPreciseDistance(tilePos, pos) < getPreciseDistance(startPos, pos)
                                     then
                                        startPos = tilePos
                                    end
                                end
                            end
                            if startPos then
                                for x = -1, 1 do
                                    for y = -1, 1 do
                                        local tile = g_map.getTile({x = targetPos.x + x, y = targetPos.y + y, z = targetPos.z})
                                        if tile then
                                            if not checkTile(tile) then
                                                if tile:isWalkable() then
                                                    if tile:isPathable() then
                                                        local tilePos = tile:getPosition()
                                                        if not table.equals(tilePos, startPos) then
                                                            if
                                                                not moveTo or
                                                                    getPreciseDistance(hasStair, tilePos) >
                                                                        getPreciseDistance(hasStair, moveTo)
                                                             then
                                                                moveTo = tilePos
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                            if moveTo then
                                local tile = g_map.getTile(moveTo)
                                local topThing = g_map.getTile(targetPos):getTopUseThing()
                                hasStair = nil
                                if tile then
                                    tile:setText("AQUI")
                                    schedule(
                                        500,
                                        function()
                                            return tile:setText("")
                                        end
                                    )
                                    g_game.move(topThing, moveTo, topThing:getCount())
                                    return delay(200)
                                end
                            end
                        end
                    else
                        return doDistance(targetPos)
                    end
                else
                    if movePos and movePos ~= 1 then
                        player:autoWalk(movePos)
                        return delay(400)
                    end
                end
            end
        end
    end
)
read = true

local riquescripts2 = addLabel("UTILIDADES", "UTILIDADES")
riquescripts2:setColor("orange")







local table_sem_nome = {
    {storage.saytarget, storage.reflect},
};


getTargetName = function()
    if (not g_game.isAttacking()) then return; end
    local target = g_game.getAttackingCreature();
    if (not target:isPlayer()) then return; end
    return target:getName();
end

onTalk(function(name, level, mode, text, channelId, pos)
    if name ~= getTargetName() then return; end
    text = text:lower();

    for _, config in ipairs(table_sem_nome) do
        local toFilter = config[1]:lower():trim();
        local toSay = config[2]:lower():trim();
        if text == toFilter then
       stopCombo = now + 50;
            say(toSay)
            break;
        end
    end
end);

local stName = "PushIcons"
storage[stName] = storage[stName] or {
  sEx = 1100,
  sIPX = 500,
  sIPY = 450,
  sRune = 3188
}

local config = storage[stName]

-- UI
local main = setupUI([[
Panel
  height: 19

  Button
    id: edit
    anchors.top: parent.top
    anchors.left: parent.left
    text-align: center
    margin-top: 1
    width: 176
    height: 17
    !text: tr('Push Automatic')
    !tooltip: tr('Empurre Automatico La ele')
    font: verdana-11px-rounded
    color: green
]])

local edit = setupUI([[
PushIconsBox < CheckBox
  font: verdana-11px-rounded
  margin-top: 5
  margin-left: 5
  anchors.top: prev.bottom
  anchors.left: parent.left
  anchors.right: parent.right
  color: lightGray

PushIconsText < BotTextEdit
  width: 80
  anchors.top: prev.bottom
  anchors.right: parent.right
  font: verdana-11px-rounded
  margin-top: 5

PushIconsLabel < Label
  font: verdana-11px-rounded
  anchors.left: parent.left
  margin-left: 5
  anchors.verticalCenter: prev.verticalCenter
  
Panel
  height: 123

  PushIconsText
    id: sIPX
    anchors.top: parent.top

  PushIconsLabel
    text: Icon Position X:

  PushIconsText
    id: sIPY

  PushIconsLabel
    text: Icon Position Y:

  PushIconsText
    id: sEx

  PushIconsLabel
    text: Push Delay:

  PushIconsText
    id: sRune

  PushIconsLabel
    text: Fire Field ID:
]])
edit:hide()


local showEdit = false
main.edit.onClick = function()
  showEdit = not showEdit
  if showEdit then edit:show()
  else edit:hide()
  end
end

edit.sIPX:setText(config.sIPX)
edit.sIPX.onTextChange = function(widget, text)
  config.sIPX = text
end
edit.sIPX:setTooltip("Need Restart to Change.")

edit.sIPY:setText(config.sIPY)
edit.sIPY.onTextChange = function(widget, text)
  config.sIPY = text
end
edit.sIPY:setTooltip("Need Restart to Change.")

edit.sEx:setText(config.sEx)
edit.sEx.onTextChange = function(widget, text)
  config.sEx = text
end

edit.sRune:setText(config.sRune)
edit.sRune.onTextChange = function(widget, text)
  config.sRune = text
end



local x,y = config.sIPX, config.sIPY

local iConf = {
  step = 43, 
  itemOn = 3548,
  itemOff = 3547,
}


local offsetDirections = {
  [North]      = {x =  0, y = -1, enabled = false, icon = nil},
  [East]       = {x =  1, y =  0, enabled = false, icon = nil},
  [South]      = {x =  0, y =  1, enabled = false, icon = nil},
  [West]       = {x = -1, y =  0, enabled = false, icon = nil},
  [NorthEast]  = {x =  1, y = -1, enabled = false, icon = nil},
  [SouthEast]  = {x =  1, y =  1, enabled = false, icon = nil},
  [SouthWest]  = {x = -1, y =  1, enabled = false, icon = nil},
  [NorthWest]  = {x = -1, y = -1, enabled = false, icon = nil},
}


for e, entry in pairs(offsetDirections) do
  entry.icon = addIcon("icon"..e,{item=iConf.itemOff, movable=false, text=""}, function(w,on)
    w.item:setItemId(on and iConf.itemOn or iConf.itemOff)
    for o, off in pairs(offsetDirections) do
      if o ~= e then
        if off.enabled then off.icon:onClick() end
      end
    end
    entry.enabled = on
  end)
  
  entry.icon:breakAnchors()
  entry.icon:move(x+(entry.x * iConf.step), y+(entry.y * iConf.step))
  entry.icon:hide()
  entry.icon:setSize({height=iConf.step,width=iConf.step})
end


local hidden = true
local pushTarget = macro(50,function(m)
  if hidden then
    hidden = false
    main.edit:setColor("green")
    for e, entry in pairs(offsetDirections) do
      entry.icon:show()
    end
  else
    schedule(49,function()
      if m:isOn() then return end
      hidden = true
      main.edit:setColor("red")
      for e, entry in pairs(offsetDirections) do
        entry.icon:hide()
      end
    end)
  end
  local target = g_game.getAttackingCreature() or g_game.getFollowingCreature()
  if not target then return end
  for e, entry in pairs(offsetDirections) do
    if entry.enabled then
      local pos = target:getPosition()
      local tile = g_map.getTile(pos)
      if tile then
        local top = tile:getTopUseThing()
        if top and not top:isNotMoveable() then
          useWith(config.sRune,top)
        end
      end
      pos.x, pos.y = pos.x + entry.x, pos.y + entry.y
      if g_map.getTile(pos):isWalkable() then
        g_game.move(target,pos)
        return delay(config.sEx)
      end
    end
  end
end)


local mainIcon = addIcon("MainIcon",{movable=false, text="Push\nTarget"}, pushTarget)
mainIcon:breakAnchors()
mainIcon:move(x, y-10)
mainIcon:setSize({height=iConf.step,width=iConf.step})
mainIcon.text:setFont('verdana-11px-rounded')




local configBuff = {
    spell = storage.buffzmagia;
    orangeMessage = storage.buffzmsg;
    cooldown = storage.buffzcd;
}

buffz = macro(100, "B U F F", function()
    if isInPz() then
        return;
    end
    if (not configBuff.cooldownBuff or (configBuff.cooldownBuff <= os.time())) then
        say(configBuff.spell);
    end
end);
local findTextBuff = configBuff.orangeMessage:lower();
onTalk(function(name, level, mode, text, channelId, pos)
    if (name ~= player:getName()) then
        return;
    end
    text = text:lower();
    if (text == findTextBuff) then
        configBuff.cooldownBuff = os.time() + configBuff.cooldown;
    end
end);

addIcon("Buff", {item=12617, text="Buff"},buffz)






ceta = macro(50, "Dash De Bahiano", "*", function(m)
    local tile = getTileUnderCursor()
    if not tile then return end
    if tile:getTopThing() == g_game.getLocalPlayer() then
        return m.setOff()
    end
    g_game.use(tile:getTopUseThing())
end)

addIcon("SETA", {item=815, text="SETA"},ceta)


macro(250, "Follow", "*", function()
   if g_game.isOnline() and g_game.isAttacking() then
         g_game.setChaseMode(1)
           end
           end)


followTarget = {}

-- Cache para tiles já verificados
local tileCache = {}
local cacheTimeout = 3000 -- Cache expira em 3 segundos

-- Função para verificar se o cache está válido
local function isCacheValid(tilePos)
    local cache = tileCache[followTarget.postostring(tilePos)]
    return cache and (now - cache.time < cacheTimeout) and cache.result
end

followTarget.postostring = function(pos)
    return (pos.x .. "," .. pos.y .. "," .. pos.z)
end

function followTarget.accurateDistance(a, b)
    if type(a) == "userdata" then
        a = a:getPosition()
    end
    if not b then
        b = pos()
    end
    if a then
        return math.abs(b.x - a.x) + math.abs(a.y - b.y)
    end
end

followTarget.targetPos = {}
actualPosition = function()
    return followTarget.targetPos[pos().z]
end

-- Converte os ids de storage.stairsIds e storage.excludeIds para string
stairsIds = {}
if storage.stairsIds then
    for index, id in ipairs(storage.stairsIds) do
        stairsIds[tostring(id)] = true
    end
end

excludeIds = {}
if storage.excludeIds then
    for index, id in ipairs(storage.excludeIds) do
        excludeIds[tostring(id)] = true
    end
end

-- Função otimizada que verifica escadas com base no storage.stairsIds com cache
followTarget.checkTile = function(tile)
    if not tile then return false end

    local tilePos = tile:getPosition()

    -- Verifica o cache
    if isCacheValid(tilePos) then
        return tileCache[followTarget.postostring(tilePos)].result
    end

    local topThing = tile:getTopUseThing()
    if not topThing then return false end
    local topId = topThing:getId()

    for _, x in ipairs(tile:getItems()) do
        if excludeIds[tostring(x:getId())] then
            return false
        end
    end

    local result
    if stairsIds[tostring(topId)] then
        result = true
    else
        local cor = g_map.getMinimapColor(tilePos)
        result = (cor >= 210 and cor <= 213 and not tile:isPathable() and tile:isWalkable())
    end

    -- Armazenando resultado no cache
    tileCache[followTarget.postostring(tilePos)] = {time = now, result = result}
    
    return result
end

followTarget.isRightDistance = function(p1, p2)
    local pPos = player:getPosition()
    if p1.x > pPos.x and p2.x > pPos.x then
        if p1.y > pPos.y and p2.y > pPos.y then
            return true
        elseif p1.y < pPos.y and p2.y < pPos.y then
            return true
        elseif p1.y == pPos.y and p2.y == pPos.y then
            return true
        end
    elseif p1.x < pPos.x and p2.x < pPos.x then
        if p1.y > pPos.y and p2.y > pPos.y then
            return true
        elseif p1.y < pPos.y and p2.y < pPos.y then
            return true
        elseif p1.y == pPos.y and p2.y == pPos.y then
            return true
        end
    elseif p1.x == pPos.x and p2.x == pPos.x then
        if p1.y > pPos.y and p2.y > pPos.y then
            return true
        elseif p1.y < pPos.y and p2.y < pPos.y then
            return true
        end
    end
    return false
end

followTarget.goUse = function(pos, distance)
    local pPos = player:getPosition()
    local tile
    if distance <= 3 then
        tile = g_map.getTile(pos)
        return tile and g_game.use(tile:getTopUseThing())
    else
        local path = findEveryPath(pos, 20, {ignoreNonPathable = true})
        for key, value in pairs(path) do
            key = key:split(",")
            local position = {x = tonumber(key[1]), y = tonumber(key[2]), z = tonumber(key[3])}
            local dist = getDistanceBetween(pPos, position)
            if dist == 3 and followTarget.isRightDistance(pos, position) then
                local checkTile = g_map.getTile(position)
                if checkTile and checkTile:canShoot() then
                    if not tile or tileDistance > followTarget.accurateDistance(pPos, position) then
                        tile = g_map.getTile(position)
                        tileDistance = followTarget.accurateDistance(tile:getPosition(), pPos)
                    end
                end
            end
        end
        if tile then
            return g_game.use(tile:getTopUseThing())
        end
    end
end

-- Função otimizada para verificar tiles ao redor com base em cache
followTarget.checkAll = function(n)
    if n > 9 then
        return
    end
    local pos = actualPosition()
    local tiles = {}
    for x = -n, n do
        for y = -n, n do
            local tilePos = {x = pos.x + x, y = pos.y + y, z = pos.z}
            local tile = g_map.getTile(tilePos)
            if followTarget.checkTile(tile) and (findPath(tilePos, pos) or findPath(pos, tilePos)) then
                table.insert(tiles, {tile = tile, distance = followTarget.accurateDistance(tilePos, pos)})
            end
        end
    end
    if #tiles == 0 then
        return followTarget.checkAll(n + 1)
    end
    table.sort(tiles, function(a, b) return a.distance < b.distance end)
    return tiles[1].tile
end

macroCheck =
    macro(
    1,
    "Caça",
    function()
        local checkPos = actualPosition()
        if followTarget.tryWalk or not checkPos or not checkPlayer then
            return
        end
    if not lookForTarget or now - lookForTarget[2] > 500 then
      local check = getCreatureById(checkPlayer:getId())
      lookForTarget = check and {check, now}
    end
    if followTarget.lastPosition == followTarget.postostring(checkPos) then
      if followTarget.See then
        if not lookForTarget then
          local pos = pos()
          followTarget.distance = getDistanceBetween(checkPos, pos)
          followTarget.See:setText("AQUI", "green")
          if followTarget.See:isWalkable() then
            if not followTarget.See:isPathable() then
              if autoWalk(followTarget.See:getPosition(), 1) then
                followTarget.tryWalk = true
                return
              end
            end
            followTarget.goUse(followTarget.See:getPosition(), followTarget.distance)
          end
        else
          local lookForTargetPos = lookForTarget[1]:getPosition()
          if lookForTargetPos then
            followTarget.targetPos[lookForTargetPos.z] = lookForTargetPos
          end
          followTarget.See:setText("AQUI", "red")
        end
      end
      return
    end
    if followTarget.See then
        followTarget.See:setText("")
    end
    followTarget.See = followTarget.checkAll(0)
    followTarget.lastPosition = followTarget.postostring(checkPos)
    end
)

macro(
    1,
    function()
        if macroCheck.isOff() then
            return
        end
        if modules.corelib.g_keyboard.isKeyPressed("escape") then
            target = nil
            checkPlayer = nil
            return g_game.cancelAttack()
        end
        local target = actualTarget()
        if target and target:isPlayer() then
            local targetPos = target:getPosition()
            if targetPos then
                checkPlayer = target
                followTarget.targetPos[targetPos.z] = targetPos
            end
        end
        local targetPos = checkPlayer and checkPlayer:getPosition()
        if targetPos and targetPos.z == pos().z and not g_game.isAttacking() then
            modules.game_interface.processMouseAction(nil, 2, pos(), nil, checkPlayer, checkPlayer)
            delay(1000)
            return
        end
    end
)

onCreaturePositionChange(
    function(creature, newPos, oldPos)
        if not newPos or not oldPos then
            return
        end
        if creature == player then
            if followTarget.targetPos[oldPos.z] and followTarget.See and table.equals(newPos, followTarget.See:getPosition()) and followTarget.tryWalk then
                followTarget.tryWalk = nil
                followTarget.See = nil
                followTarget.targetPos[oldPos.z] = nil
            end
        elseif creature == checkPlayer then
            followTarget.targetPos[newPos.z] = newPos
        end
    end
)






stairMacro =
    macro(
    1,
    "Escadinhas",
    function()
        if Stairs.walk.isOn() then
            return
        end
        local pos = Stairs.postostring(pos())
        if pos ~= Stairs.lastPos then
            markOnThing(Stairs.bestTile, "")
            Stairs.bestTile = Stairs.checkAll()
            Stairs.pos = Stairs.bestTile and Stairs.bestTile:getPosition()
            markOnThing(Stairs.bestTile, "#FF0000")
            Stairs.lastPos = pos
        end
        if
            modules.corelib.g_keyboard.isKeyPressed("Space") and Stairs.bestTile and
                not modules.game_console:isChatEnabled()
         then
            Stairs.walk.setOn()
            return
        else
            return markOnThing(Stairs.bestTile, "#FF0000")
        end
    end
)

addIcon("Escada", {item = 1958, text = "Escadas"}, stairMacro)

Stairs = {}

excludeIds = {}

if type(storage.stairsIds) ~= "table" then
  storage.stairsIds = {
    1666, 6207, 1948, 435, 11661, 7771, 5542, 8657, 6264, 1646, 1648, 1678, 
    5291, 1680, 6905, 6262, 1664, 13296, 1067, 13861, 11931, 1949, 6896, 6205, 
    13926, 1947, 1968, 5111, 5102, 7725, 7727
  }
end

if type(storage.excludeIds) ~= "table" then
  storage.excludeIds = {} -- Inicializando a lista de IDs excluídos
end


stairsIds = {}
for index, id in ipairs(storage.stairsIds) do
    stairsIds[tostring(id)] = true
end

excludeIds = {}
for index, id in ipairs(storage.excludeIds) do
    excludeIds[tostring(id)] = true
end


local stairsContainer = UI.Container(function(widget, items)
  storage.stairsIds = {}
  for _, item in ipairs(items) do
    table.insert(storage.stairsIds, item.id)
    stairsIds[tostring(item.id)] = true
  end
end, true)
stairsContainer:setHeight(35)
stairsContainer:setItems(storage.stairsIds)


local excludeContainer = UI.Container(function(widget, items)
  storage.excludeIds = {}
  for _, item in ipairs(items) do
    table.insert(storage.excludeIds, item.id)
    excludeIds[tostring(item.id)] = true
  end
end, true)
excludeContainer:setHeight(35)
excludeContainer:setItems(storage.excludeIds)


Stairs.saveStatus = {}

Stairs.checkTile = function(tile)
    if not tile then
        return false
    end

    local tilePos = tile:getPosition()

    if not tilePos then
        return
    end

    local onString = Stairs.postostring(tilePos)

    local checkStatus = Stairs.saveStatus[onString]

    local itemsOnTile = tile:getItems()

    if checkStatus and ((type(checkStatus[1]) == "number" and #itemsOnTile == checkStatus[1]) or checkStatus[1] == true) then
        return checkStatus[2]
    end

    local topThing = tile:getTopUseThing()

    if not topThing then
        return false
    end

    for _, x in ipairs(itemsOnTile) do
        if excludeIds[tostring(x:getId())] then
            Stairs.saveStatus[onString] = {#itemsOnTile, false}
            return false
        end
    end

    if stairsIds[tostring(topThing:getId())] then
        Stairs.saveStatus[onString] = {true, true}
        return true
    end

    local cor = g_map.getMinimapColor(tile:getPosition())
    if cor >= 210 and cor <= 213 and not tile:isPathable() and tile:isWalkable() then
        Stairs.saveStatus[onString] = {true, true}
        return true
    else
        Stairs.saveStatus[onString] = {#itemsOnTile, false}
        return false
    end
end

Stairs.postostring = function(pos)
    return pos.x .. "," .. pos.y .. "," .. pos.z
end

function Stairs.accurateDistance(p1, p2)
    if type(p1) == "userdata" then
        p1 = p1:getPosition()
    end
    if type(p2) ~= "table" then
        p2 = pos()
    end
    return math.abs(p1.x - p2.x) + math.abs(p1.y - p2.y)
end

Stairs.getPosition = function(pos, dir)
    if dir == 0 then
        pos.y = pos.y - 1
    elseif dir == 1 then
        pos.x = pos.x + 1
    elseif dir == 2 then
        pos.y = pos.y + 1
    else
        pos.x = pos.x - 1
    end

    return pos
end

function table.reverse(t)
  local newTable = {}
  local j = 0
  for i = #t, 1, -1 do
    j = j + 1
    newTable[j] = t[i]
  end
  return newTable
end

function reverseDirection(dir)
  if dir == 0 then
    return 2
  elseif dir == 1 then
    return 3
  elseif dir == 2 then
    return 0
  elseif dir == 3 then
    return 1
  end
end

Stairs.goUse = function(pos)
    local playerPos = player:getPosition()
    local path = findPath(pos, playerPos)
    if not path then
        return
    end
    path = table.reverse(path)
    for i, v in ipairs(path) do
        if i > 5 then
            break
        end
        playerPos = Stairs.getPosition(playerPos, reverseDirection(v))
    end
    local tile = g_map.getTile(playerPos)
    local topThing = tile and tile:getTopUseThing()
    if topThing then
        g_game.use(topThing)
        if table.equals(tile:getPosition(), pos) then
            return delay(300)
        end
    end
end

Stairs.checkAll = function(n)
    n = n and n + 1 or 1
    if n > 9 then
        return
    end
    local pos = pos()
    local tiles = {}
    for x = -n, n do
        for y = -n, n do
            local stairPos = {x = pos.x + x, y = pos.y + y, z = pos.z}
            local tile = g_map.getTile(stairPos)
            if Stairs.checkTile(tile) and findPath(stairPos, pos) then
                table.insert(tiles, {tile = tile, distance = Stairs.accurateDistance(pos, stairPos)})
            end
        end
    end
    if #tiles == 0 then
        return Stairs.checkAll(n)
    end
    table.sort(
        tiles,
        function(a, b)
            return a.distance < b.distance
        end
    )
    return tiles[1].tile
end

stand = now
onPlayerPositionChange(
    function(newPos, oldPos)
        stand = now
        tryWalk = nil
        if newPos.z ~= oldPos.z or getDistanceBetween(oldPos, newPos) > 1 or table.equals(Stairs.pos, newPos) then
            Stairs.walk.setOff()
        end
        if Stairs.walk.isOff() then
            checked = nil
        end
    end
)

timeInPos = function()
    return now - stand
end

onAddThing(
    function(tile, thing)
        if type(Stairs.pos) == "table" then
            if table.equals(tile:getPosition(), Stairs.pos) then
                Stairs.bestTile = tile
            end
        end
    end
)

markOnThing = function(thing, color)
    if thing then
        if thing:getPosition() then
            local useThing = thing:getTopUseThing()
            if color == "#00FF00" then
                thing:setText("AQUI", "green")
            elseif color == "#FF0000" then
                thing:setText("AQUI", "red")
            else
                thing:setText("")
            end
            return true
        end
    end
    return false
end

Stairs.walk =
    macro(
    1,
    function()
        if modules.corelib.g_keyboard.isKeyPressed("Escape") then
            return Stairs.walk.setOff()
        end
        player:lockWalk(300)
        if tryWalk then
            return
        end
        markOnThing(Stairs.bestTile, "#00FF00")
        if Stairs.bestTile:isWalkable() then
            if not Stairs.bestTile:isPathable() then
                if autoWalk(Stairs.pos, 1) then
                    tryWalk = true
                    return
                end
            end
        end
        return Stairs.goUse(Stairs.pos)
    end
)
Stairs.walk.setOff()












if player:getBlessings() == 0 then
    say("!bless")
    schedule(2000, function()
        if player:getBlessings() == 0 then
            error("Bless Verificada!")
        end
    end)
end



onTextMessage(function(mode, text)
        if not text:lower():find('2 golds') then return; end
       say("VOCÊ ESTÁ SEM DINHEIRO PARA BOL FDP")
    end)


onTextMessage(function(mode, text)
        if not text:lower():find('de 5') then return; end
       say("VOCê ESTÁ SEM DINHEIRO PARA BLESS FDP, LISO")
    end)


