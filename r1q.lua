setDefaultTab("Main")

local version = " CUSTOM"
local nick = "RIQUE".. version
local Nome = UI.Label(nick)

modules.game_textmessage.displayGameMessage("["..nick.."] Bem A Custom RIQUE!")

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


local riquescripts = addLabel("[P] [V] [P]", "[P] [V] [P]")
riquescripts:setColor("orange")

Turn = {}

Turn.maxDistance = {x = 7, y = 7}
Turn.minDistance = 1
Turn.macro = macro(1, 'ENCARADA', function()
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
 
 
Stack.icon = addIcon("Stack",  {item=802, text="Stack"}, macro(1, "Stack", function() 
    local furthestMonster = nil;
    local pattern = nil;
    if (modules.corelib.g_keyboard.areKeysPressed("Plus+W")) then
        pattern = Stack.northPattern;
    elseif (modules.corelib.g_keyboard.areKeysPressed("Plus+S")) then
        pattern = Stack.southPattern;
    elseif (modules.corelib.g_keyboard.areKeysPressed("Plus+A")) then
        pattern = Stack.westPattern;
    elseif (modules.corelib.g_keyboard.areKeysPressed("Plus+D")) then
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






percent = macro(200, "Combo%", "numpad0", function()
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

area = macro(50, "NOCAUTE", "numpad0", function()
if not g_game.isAttacking() then return end
 if g_game.getAttackingCreature():getHealthPercent() <= 20 then
stopCombo = now + 500;
say(storage.Area1, 1600)
    end
end)


addIcon("Area", {item=674, text="Area"},area)






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


bugMap.macro = macro(1, "THE FLASH", function()
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

hotkey("numpad5", function()
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
    --Made By VivoDibra#1182 
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

UI.Separator()

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
