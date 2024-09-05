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
 
 
Stack.icon = addIcon("Stack",  {item=802, text="Stack"}, macro(200, "Stack", function() 
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

area = macro(100, "NOCAUTE", "numpad0", function()
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


bugMap.macro = macro(200, "THE FLASH", function()
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
                                    tile:setText("PUSH AQUI")
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


setDefaultTab("Pve")

UI.Separator()
UI.Label('-- [UP] --'):setColor('green')

storage.widgetPos = storage.widgetPos or {};

local antiRedTimeWidget = setupUI([[
UIWidget
  background-color: black
  opacity: 0.8
  padding: 0 5
  focusable: true
  phantom: false
  draggable: true
]], g_ui.getRootWidget());

local isMobile = modules._G.g_app.isMobile();
g_keyboard = g_keyboard or modules.corelib.g_keyboard;

local isDragKeyPressed = function()
  return isMobile and g_keyboard.isKeyPressed("F2") or g_keyboard.isCtrlPressed();
end

antiRedTimeWidget.onDragEnter = function(widget, mousePos)
  if (not isDragKeyPressed()) then return; end
  widget:breakAnchors();
  local widgetPos = widget:getPosition();
  widget.movingReference = {x = mousePos.x - widgetPos.x, y = mousePos.y - widgetPos.y};
  return true;
end

antiRedTimeWidget.onDragMove = function(widget, mousePos, moved)
  local parentRect = widget:getParent():getRect();
  local x = math.min(math.max(parentRect.x, mousePos.x - widget.movingReference.x), parentRect.x + parentRect.width - widget:getWidth());
  local y = math.min(math.max(parentRect.y - widget:getParent():getMarginTop(), mousePos.y - widget.movingReference.y), parentRect.y + parentRect.height - widget:getHeight());   
  widget:move(x, y);
  storage.widgetPos.antiRedTime = {x = x, y = y};
  return true;
end

local name = "antiRedTime";
storage.widgetPos[name] = storage.widgetPos[name] or {};
antiRedTimeWidget:setPosition({x = storage.widgetPos[name].x or 50, y = storage.widgetPos[name].y or 50});



local refreshSpells = function()
  castingSpells = {};
  if (storage.comboSpells) then
    local split = storage.comboSpells:split(",");
    for _, spell in ipairs(split) do
      table.insert(castingSpells, spell:trim());
    end
  end
end


addTextEdit("Magias", storage.comboSpells or "magia1, magia2, magia3", function(widget, text)
  storage.comboSpells = text;
  refreshSpells();
end)

refreshSpells();


UI.Label('Area:')
addTextEdit("Area", storage.areaSpell or "Magia de Area", function(widget, text)
  storage.areaSpell = text;
end)

if (not getSpectators or #getSpectators(true) == 0) then
  getSpectators = function()
    local specs = {};
    local tiles = g_map.getTiles(posz());
    for i = 1, #tiles do
      local tile = tiles[i];
      local creatures = tile:getCreatures();
      for _, spec in ipairs(creatures) do
        table.insert(specs, creature);
      end
    end
    return specs;
  end
end

if (not storage.antiRedTime or storage.antiRedTime - 30000 > now) then
  storage.antiRedTime = 0;
end

local addAntiRedTime = function()
  storage.antiRedTime = now + 30000;
end

local toInteger = function(number)
  number = tostring(number);
  number = number:split(".");
  return tonumber(number[1]);
end

antidrop = macro(1, "Anti-Red", function()
  local pos, monstersCount = pos(), 0;
  if (player:getSkull() >= 3) then
    addAntiRedTime();
  end
  local specs = getSpectators(true);
  for _, spec in ipairs(specs) do
    local specPos = spec:getPosition();
    local floorDiff = math.abs(specPos.z - pos.z);
    if (floorDiff > 3) then 
      goto continue;
    end
    if (spec ~= player and spec:isPlayer() and spec:getEmblem() ~= 1 and spec:getShield() < 3) then
      addAntiRedTime();
      break
    elseif (floorDiff == 0 and spec:isMonster() and getDistanceBetween(specPos, pos) == 1) then
      monstersCount = monstersCount + 1;
    end
    ::continue::
  end
  if (storage.antiRedTime >= now) then
    antiRedTimeWidget:show();
    local diff = storage.antiRedTime - now;
    diff = diff / 1000;
    antiRedTimeWidget:setText(tr("Sem Area %ds.", toInteger(diff)));
    antiRedTimeWidget:setColor("red");
  elseif (not antiRedTimeWidget:isHidden()) then
    antiRedTimeWidget:hide();
  end
  if (monstersCount > 1 and storage.antiRedTime < now) then
    return say(storage.areaSpell);
  end
  if (not g_game.isAttacking()) then return; end
     for _, spell in ipairs(castingSpells) do
    say(spell);
  end
end)
addIcon("AntiRed", {item=12616, text="AntiRed"},antidrop)

---------------------------------------------------------

setDefaultTab("RIQUE")

UI.Separator()

if type(storage.manatrainer) ~= "table" then
  storage.manatrainer = {on=false, title="mana%", text="Power Down", min=0, max=90}
end

for _, healingInfos in ipairs({storage.manatrainer}) do
  local healingmacro = macro(20, function()
    local mana = manapercent()
    if healingInfos.max <= mana and mana >= healingInfos.min then
      if TargetBot then 
        TargetBot.saySpell(healingInfos.text) -- sync spell with targetbot if available
      else
        say(healingInfos.text)
      end
    end
  end)
  healingmacro.setOn(healingInfos.on)

  UI.DualScrollPanel(healingInfos, function(widget, newParams) 
    healingInfos = newParams
    healingmacro.setOn(healingInfos.on)
  end)
end 






UI.Separator() 
followName = "autofollow"
if not storage[followName] then storage[followName] = { player = 'name'} end
local toFollowPos = {}







local followChange = macro(1000, "FOLLOW",  function()
local followw= storage[followName].player 
    if g_game.isFollowing() then
        return
    end
    for _, followcreature in ipairs(g_map.getSpectators(pos(), false)) do
        if (followcreature:getName() == followw and getDistanceBetween(pos(), followcreature:getPosition()) <= 8) then
            g_game.follow(followcreature)
        end
    end
end) 

local followMacro = macro(20, "SEGUIR", function()
    local target = getCreatureByName(storage[followName].player)
    if target then
        local tpos = target:getPosition()
        toFollowPos[tpos.z] = tpos
    end
    if player:isWalking() then
        return
    end
    local p = toFollowPos[posz()]
    if not p then
        return
    end
    if autoWalk(p, 20, { ignoreNonPathable = true, precision = 1 }) then
        delay(100)
    end
end)
UI.Separator()
onPlayerPositionChange(function(newPos, oldPos)
  if followChange:isOff() then return end
  if (g_game.isFollowing()) then
    tfollow = g_game.getFollowingCreature()

    if tfollow then
      if tfollow:getName() ~= storage[followName].player then
        followTE:setText(tfollow:getName())
        storage[followName].player = tfollow:getName()
      end
    end
  end
end)

onCreaturePositionChange(function(creature, newPos, oldPos)
    if creature:getName() == storage[followName].player and newPos then
        toFollowPos[newPos.z] = newPos
    end
end) 

followTE = UI.TextEdit(storage[followName].player or "name", function(widget, newText)
    storage[followName].player = newText
end)

UI.Separator()

staminaRefinarEM = tonumber(storage.hora)
idDaStamina = tonumber(storage.id)

macro(50, 'Stamine', function()
    if stamina() <= staminaRefinarEM * 60 then
        useWith(idDaStamina, player)
        return delay(500)
    end
end)
UI.Label('Hora Pra usar')
addTextEdit("hora", storage.hora or "usar em", function(widget, text) 
storage.hora = text
end)
UI.Label('Id Da Stamina')
addTextEdit("id", storage.id or "id stamina", function(widget, text) 
storage.id = text
end)


local checkAol = storage.idDoAol
macro(3000, "Comprar AOL", function()
  if getFinger() and getFinger():getId(checkAol) then return end
  say(storage.buyaol)
end)
UI.Label('id do aol')
addTextEdit("idAOL", storage.idDoAol or "id do aol", function(widget, text) 
storage.idDoAol = text
end)
UI.Label('!bol/!jam')
addTextEdit("buyaol", storage.buyaol or "Comprar", function(widget, text) 
storage.buyaol = text
end)



  UI.Separator()
UI.Label('Magia Stack')

addTextEdit("Magia Stack", storage.stackar or "Magia Stack", function(widget, text) 
storage.stackar = text
end)


  UI.Separator()
UI.Label('%Nocaute Area%')

addTextEdit("Area1", storage.Area1 or "Area25%", function(widget, text) 
storage.Area1 = text
end)

UI.Separator()


---

hotkey("T", "senseTarget", function()
if sense then 
say('sense "' .. sense )
end
end)


macro(1, function() if g_game.isAttacking() and g_game.getAttackingCreature():isPlayer() then sense = g_game.getAttackingCreature():getName() end end)


----

macro(1, 'XSense', function()
  if storage.Sense then
      locatePlayer = getPlayerByName(storage.Sense)
      if not (locatePlayer and locatePlayer:getPosition().z == player:getPosition().z and getDistanceBetween(pos(), locatePlayer:getPosition()) <= 6) then
          say('sense "' .. storage.Sense)
          delay(500)
      end
  end
end)


onTalk(function(name, level, mode, text, channelId, pos)
  if player:getName() == name then
      if string.sub(text, 1, 1) == 'x' then
          local checkMsg = string.sub(text, 2):trim()
          if checkMsg == '0' then
              storage.Sense = false
          else
              storage.Sense = checkMsg
          end
      end
  end
end)



UI.Separator()------------INICIO PAINEL TRAVEL

g_ui.loadUIFromString([[


ViajeWindow < MainWindow
  !text: tr('Travel')
  font: verdana-11px-rounded
  size: 380 310
  padding: 25
  color: green
  @onEscape: self:hide()

  Button
    id: edite
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    text-align: center
    margin-bottom: -5
    margin-right: 115
    font: verdana-11px-rounded
    text: Edite
    color: green
    !tooltip: tr('Editar Travel')

  Label
    id: stoppp
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    text-align: center
    margin-bottom: -20
    margin-right: 110
    font: verdana-11px-rounded
    text: Discord: riquezerah
    color: green


  Label
    id: stopppp
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    text-align: center
    margin-bottom: 20
    margin-right: 80
    font: verdana-11px-rounded
    text: Para abrir aperte-> Shift+V
    color: white 

  Label
    anchors.left: parent.left
    anchors.right: parent.horizontalCenter
    font: verdana-11px-rounded

    anchors.top: parent.top
    text-align: center
    margin-top: 4
    text: Viajar
    color: green

  Label
    anchors.left: parent.horizontalCenter
    anchors.right: parent.right
    anchors.top: parent.top
    text-align: center
    margin-top: 4
    font: verdana-11px-rounded
    text: Viajar
    color: green


  VerticalScrollBar
    id: contentScroll
    anchors.top: prev.bottom
    margin-top: 3
    anchors.right: parent.right
    anchors.bottom: separator.top
    step: 28
    pixels-scroll: true
    margin-right: -10
    margin-top: 18
    margin-bottom: 16

  ScrollablePanel
    id: content
    anchors.top: prev.top
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: separator.top
    vertical-scrollbar: contentScroll
    margin-bottom: 15
      
    Panel
      id: left
      anchors.top: parent.top
      anchors.left: parent.left
      anchors.right: parent.horizontalCenter
      margin-top: 5
      margin-left: 10
      margin-right: 10
      layout:
        type: verticalBox
        fit-children: true
    image-source: /imagens/x_x

    Panel
      id: right
      anchors.top: parent.top
      anchors.left: parent.horizontalCenter
      anchors.right: parent.right
      margin-top: 5
      margin-left: 10
      margin-right: 10
      layout:
        type: verticalBox
        fit-children: true


  HorizontalSeparator
    id: separator
    anchors.right: parent.right
    anchors.left: parent.left
    anchors.bottom: closeButton.top   

  Button
    id: closeButton
    !text: tr('X')
    color: red
    font: verdana-11px-rounded
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    size: 49 21
    margin-top: 16
    margin-right: 5
    margin-bottom: 0
    !tooltip: tr('Fechar')




]])



local panelName = "viaje"
local ui = setupUI([[
Panel

  height: 30

  Button
    id: editMusica
    font: verdana-11px-rounded
    color: green
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: 30
    text: Travel

  ]], parent)
  ui:setId(PanelName)




if not storage[panelName] then
  storage[panelName] = {
}
end

local settings = storage[panelName]


viajeWindow = UI.createWindow('ViajeWindow', rootWidget)
viajeWindow:hide()

viajeWindow.closeButton.onClick = function(widget)
  viajeWindow:hide()
end

modules.game_interface.addMenuHook("category", "Viaje",
  function()
          viajeWindow:show()
  end,
  function(menuPosition, lookThing, useThing, creatureThing)
    if creatureThing and creatureThing == player then
      return true
    end
    return false
  end
)

modules.game_interface.addMenuHook("category", "Painel de Magias",
  function()
          say(storage.magiaatalho)
  end,
  function(menuPosition, lookThing, useThing, creatureThing)
    if creatureThing and creatureThing == player then
      return true
    end
    return false
  end
)

-- available options for dest param
local rightPanel = viajeWindow.content.right
local leftPanel = viajeWindow.content.left

ui.editMusica.onClick = function(widget)
  viajeWindow:show()
  viajeWindow:raise()
  viajeWindow:focus()
end


onKeyPress(function(keys)
if keys == 'Shift+V' then
  viajeWindow:show()
end
end)

UI.Button(storage.cidade1, function()
NPC.say("hi")
schedule(500, function()
NPC.say(storage.cidade1)
end)
schedule(900, function()
NPC.say("yes")
end)
end,leftPanel)

UI.Button(storage.cidade2, function()
NPC.say("hi")
schedule(500, function()
NPC.say(storage.cidade2)
end)
schedule(900, function()
NPC.say("yes")
end)
end,leftPanel)

UI.Button(storage.cidade3, function()
NPC.say("hi")
schedule(500, function()
NPC.say(storage.cidade3)
end)
schedule(900, function()
NPC.say("yes")
end)
end,leftPanel)

UI.Button(storage.cidade4, function()
NPC.say("hi")
schedule(500, function()
NPC.say(storage.cidade4)
end)
schedule(900, function()
NPC.say("yes")
end)
end,leftPanel)

UI.Button(storage.cidade5, function()
NPC.say("hi")
schedule(500, function()
NPC.say(storage.cidade5)
end)
schedule(900, function()
NPC.say("yes")
end)
end,leftPanel)

UI.Button(storage.cidade6, function()
NPC.say("hi")
schedule(500, function()
NPC.say(storage.cidade6)
end)
schedule(900, function()
NPC.say("yes")
end)
end,leftPanel)


UI.Button(storage.cidade7, function()
NPC.say("hi")
schedule(500, function()
NPC.say(storage.cidade7)
end)
schedule(900, function()
NPC.say("yes")
end)
end,leftPanel)

UI.Button(storage.cidade8, function()
NPC.say("hi")
schedule(500, function()
NPC.say(storage.cidade8)
end)
schedule(900, function()
NPC.say("yes")
end)
end,leftPanel)

UI.Button(storage.cidade9, function()
NPC.say("hi")
schedule(500, function()
NPC.say(storage.cidade9)
end)
schedule(900, function()
NPC.say("yes")
end)
end,leftPanel)



UI.Button(storage.cidades1, function()
NPC.say("hi")
schedule(500, function()
NPC.say(storage.cidades1)
end)
schedule(900, function()
NPC.say("yes")
end)
end,rightPanel)

UI.Button(storage.cidades2, function()
NPC.say("hi")
schedule(500, function()
NPC.say(storage.cidades2)
end)
schedule(900, function()
NPC.say("yes")
end)
end,rightPanel)

UI.Button(storage.cidades3, function()
NPC.say("hi")
schedule(500, function()
NPC.say(storage.cidades3)
end)
schedule(900, function()
NPC.say("yes")
end)
end,rightPanel)

UI.Button(storage.cidades4, function()
NPC.say("hi")
schedule(500, function()
NPC.say(storage.cidades4)
end)
schedule(900, function()
NPC.say("yes")
end)
end,rightPanel)

UI.Button(storage.cidades5, function()
NPC.say("hi")
schedule(500, function()
NPC.say(storage.cidades5)
end)
schedule(900, function()
NPC.say("yes")
end)
end,rightPanel)

UI.Button(storage.cidades6, function()
NPC.say("hi")
schedule(500, function()
NPC.say(storage.cidades6)
end)
schedule(900, function()
NPC.say("yes")
end)
end,rightPanel)


UI.Button(storage.cidades7, function()
NPC.say("hi")
schedule(500, function()
NPC.say(storage.cidades7)
end)
schedule(900, function()
NPC.say("yes")
end)
end,rightPanel)

UI.Button(storage.cidades8, function()
NPC.say("hi")
schedule(500, function()
NPC.say(storage.cidades8)
end)
schedule(900, function()
NPC.say("yes")
end)
end,rightPanel)

UI.Button(storage.cidades9, function()
NPC.say("hi")
schedule(500, function()
NPC.say(storage.cidades9)
end)
schedule(900, function()
NPC.say("yes")
end)
end,rightPanel)










g_ui.loadUIFromString([[

CidadesWindow < MainWindow
  !text: tr('Edits Citys')
  font: verdana-11px-rounded
  size: 300 310
  padding: 25
  color: green
  @onEscape: self:hide()


  Label
    id: stoppp
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    text-align: center
    margin-bottom: 0
    margin-right: 115
    font: verdana-11px-rounded
    text: riquezerah
    color: green

  Label
    anchors.left: parent.left
    anchors.right: parent.horizontalCenter
    font: verdana-11px-rounded

    anchors.top: parent.top
    text-align: center
    margin-top: 4
    text: Viajar
    color: green

  Label
    anchors.left: parent.horizontalCenter
    anchors.right: parent.right
    anchors.top: parent.top
    text-align: center
    margin-top: 4
    font: verdana-11px-rounded
    text: Viajar
    color: green


  VerticalScrollBar
    id: contentScroll
    anchors.top: prev.bottom
    margin-top: 3
    anchors.right: parent.right
    anchors.bottom: separator.top
    step: 28
    pixels-scroll: true
    margin-right: -10
    margin-top: 13
    margin-bottom: 16

  ScrollablePanel
    id: content
    anchors.top: prev.top
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: separator.top
    vertical-scrollbar: contentScroll
    margin-bottom: 15
      
    Panel
      id: left
      anchors.top: parent.top
      anchors.left: parent.left
      anchors.right: parent.horizontalCenter
      margin-top: 5
      margin-left: 10
      margin-right: 10
      layout:
        type: verticalBox
        fit-children: true
    image-source: /imagens/x_x3

    Panel
      id: right
      anchors.top: parent.top
      anchors.left: parent.horizontalCenter
      anchors.right: parent.right
      margin-top: 5
      margin-left: 10
      margin-right: 10
      layout:
        type: verticalBox
        fit-children: true


  HorizontalSeparator
    id: separator
    anchors.right: parent.right
    anchors.left: parent.left
    anchors.bottom: closeButton.top   

  Button
    id: closeButton
    !text: tr('X')
    color: red
    font: verdana-11px-rounded
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    size: 49 21
    margin-top: 16
    margin-right: 5
    margin-bottom: 0 
    !tooltip: tr('Fechar')


  ]])



  local panelName = "cidade"
local ui = setupUI([[
Panel



  ]], parent)
  ui:setId(PanelName)

if not storage[panelName] then
  storage[panelName] = {
}
end

local settings = storage[panelName]


cidadesWindow = UI.createWindow('CidadesWindow', rootWidget)
cidadesWindow:hide()

cidadesWindow.closeButton.onClick = function(widget)
  cidadesWindow:hide()
end




-- available options for dest param
local rightPanel = cidadesWindow.content.right
local leftPanel = cidadesWindow.content.left

viajeWindow.edite.onClick = function(widget)
  cidadesWindow:show()
  cidadesWindow:raise()
  cidadesWindow:focus()
end





UI.TextEdit(storage.cidade1 or "Cidade 1", function(widget, text)    
  storage.cidade1 = text
end,leftPanel)

UI.TextEdit(storage.cidade2 or "Cidade 2", function(widget, text)    
  storage.cidade2 = text
end,leftPanel)

UI.TextEdit(storage.cidade3 or "Cidade 3", function(widget, text)    
  storage.cidade3 = text
end,leftPanel)

UI.TextEdit(storage.cidade4 or "Cidade 4", function(widget, text)    
  storage.cidade4 = text
end,leftPanel)

UI.TextEdit(storage.cidade5 or "Cidade 5", function(widget, text)    
  storage.cidade5 = text
end,leftPanel)

UI.TextEdit(storage.cidade6 or "Cidade 6", function(widget, text)    
  storage.cidade6 = text
end,leftPanel)

UI.TextEdit(storage.cidade7 or "Cidade 7", function(widget, text)    
  storage.cidade7 = text
end,leftPanel)

UI.TextEdit(storage.cidade8 or "Cidade 8", function(widget, text)    
  storage.cidade8 = text
end,leftPanel)

UI.TextEdit(storage.cidade9 or "Cidade 9", function(widget, text)    
  storage.cidade9 = text
end,leftPanel)



UI.TextEdit(storage.cidades1 or "Cidade 1", function(widget, text)    
  storage.cidades1 = text
end,rightPanel)

UI.TextEdit(storage.cidades2 or "Cidade 2", function(widget, text)    
  storage.cidades2 = text
end,rightPanel)

UI.TextEdit(storage.cidades3 or "Cidade 3", function(widget, text)    
  storage.cidades3 = text
end,rightPanel)

UI.TextEdit(storage.cidades4 or "Cidade 4", function(widget, text)    
  storage.cidades4 = text
end,rightPanel)

UI.TextEdit(storage.cidades5 or "Cidade 5", function(widget, text)    
  storage.cidades5 = text
end,rightPanel)

UI.TextEdit(storage.cidades6 or "Cidade 6", function(widget, text)    
  storage.cidades6 = text
end,rightPanel)

UI.TextEdit(storage.cidades7 or "Cidade 7", function(widget, text)    
  storage.cidades7 = text
end,rightPanel)

UI.TextEdit(storage.cidades8 or "Cidade 8", function(widget, text)    
  storage.cidades8 = text
end,rightPanel)

UI.TextEdit(storage.cidades9 or "Cidade 9", function(widget, text)    
  storage.cidades9 = text
end,rightPanel)



------------------



UI.Separator()--------------INICIO PAINEL MACROS


local PainelPanelName = "listt"
  local ui = setupUI([[
Panel

  height: 25

  Button
    id: editPainel
    font: verdana-11px-rounded
    color: green
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: 25
    text: Macros
    !tooltip: tr('Abrir Macros')

  ]], parent)
  ui:setId(PaineltroPanelName)

  if not storage[PainelPanelName] then
    storage[PainelPanelName] = { 

    }
  end

rootWidget = g_ui.getRootWidget()
if rootWidget then
    PainelsWindow = UI.createWidget('PainelWindow', rootWidget)
    PainelsWindow:hide()
    TabBar = PainelsWindow.paTabBar
    TabBar:setContentWidget(PainelsWindow.paImagem)
   for v = 1, 1 do





hpPanel = g_ui.createWidget("hpPanel") -- Creates Panel
hpPanel:setId("panelButtons") -- sets ID

hpPanel2 = g_ui.createWidget("hpPanel") -- Creates Panel
hpPanel2:setId("2") -- sets ID

hpPanel3 = g_ui.createWidget("hpPanel") -- Creates Panel
hpPanel:setId("panelButtons") -- sets ID

hpPanel4 = g_ui.createWidget("hpPanel") -- Creates Panel
hpPanel:setId("panelButtons") -- sets ID

hpPanel5 = g_ui.createWidget("hpPanel") -- Creates Panel
hpPanel:setId("panelButtons") -- sets ID

hpPanel6 = g_ui.createWidget("hpPanel") -- Creates Panel
hpPanel:setId("panelButtons") -- sets ID

hpPanel7 = g_ui.createWidget("hpPanel") -- Creates Panel
hpPanel:setId("panelButtons") -- sets ID

TabBar:addTab("HP", hpPanel)
        color= UI.Label()
color:setColor("green")
color= UI.Label("Cura",hpPanel)
color:setColor("green")

if type(storage.heal) ~= "table" then
  storage.heal = {on=false, title="HP%", text="big regeneration", min=0, max=99}
end
if type(storage.heal2) ~= "table" then
  storage.heal2 = {on=false, title="HP%", text="regeneration", min=0, max=99}
end

-- create 2 healing widgets
for _, healingInfo in ipairs({storage.heal, storage.heal2}) do
  local healingmacro = macro(200, function()
    local hp = player:getHealthPercent()
    if healingInfo.max >= hp and hp >= healingInfo.min then
      if TargetBot then 
        TargetBot.saySpell(healingInfo.text) -- sync spell with targetbot if available
      else
        say(healingInfo.text)
      end
    end
  end,hpPanel)
  healingmacro.setOn(healingInfo.on)

  UI.DualScrollPanel(healingInfo, function(widget, newParams) 
    healingInfo = newParams
    healingmacro.setOn(healingInfo.on)
  end,hpPanel)
end

TabBar:addTab("UseIten", hpPanel2)
        color= UI.Label()
color:setColor("green")
        color= UI.Label("UseIten",hpPanel2)
color:setColor("green")
        UI.Separator(hpPanel2)
Panels.HealthItem(hpPanel2)
        UI.Separator(hpPanel2)
Panels.HealthItem(hpPanel2)
        UI.Separator(hpPanel2)
Panels.ManaItem(hpPanel2)

TabBar:addTab("Speed", hpPanel3)
        color= UI.Label()
color:setColor("green")
        color= UI.Label("Relampago Marquinhos",hpPanel3)
color:setColor("green")
 
Panels.Haste(hpPanel3)
Panels.AntiParalyze(hpPanel3)


UI.Label('Mode Barry Allen',hpPanel3):setColor('green')

addTextEdit("hasteSpell", storage.hasteSpell or "Super speed", function(widget, text)
    storage.hasteSpell = text
end,hpPanel3)


macro(1, function()
    local isSealed = storage.sealedTypes and storage.sealedTypes.speed and storage.sealedTypes.speed >= os.time();
    if (not isSealed and not hasHaste() and (hppercent() >= 50)) then
        say(storage.hasteSpell);
    end
end,hpPanel3)

TabBar:addTab("Combo", hpPanel4)
        color= UI.Label()
color:setColor("green")
        color= UI.Label("Combos",hpPanel4)
color:setColor("green")

addTextEdit("30%", storage.Magia1 or "30%", function(widget, text) storage.Magia1 = text
end,hpPanel4)

addTextEdit("Magia1", storage.Magia2 or "Magia1", function(widget, text) storage.Magia2 = text
end,hpPanel4)


addTextEdit("Magia2", storage.Magia3 or "Magia2", function(widget, text) storage.Magia3 = text
end,hpPanel4)


addTextEdit("Magia3", storage.Magia4 or "Magia3", function(widget, text) storage.Magia4 = text
end,hpPanel4)


addTextEdit("Magia4", storage.Magia5 or "Magia4", function(widget, text) storage.Magia5 = text
end,hpPanel4)

addTextEdit("canudo", storage.rique or "canudo", function(widget, text) storage.rique = text
end,hpPanel4)


addIcon("COMBO", {item=671, movable=true, text = "COMBO"}, percent)
end
end




TabBar:addTab("Suport", hpPanel5)
        color= UI.Label()
color:setColor("green")
        color= UI.Label("Suportes",hpPanel5)
color:setColor("green")



local lastManaShield = 0
mysticfull = macro(20, "Mystic Full", function() 
  if hasManaShield() or lastManaShield + 90000 > now then return end
  if TargetBot then 
    TargetBot.saySpell(storage.manaShield) -- sync spell with targetbot if available
  else
    say(storage.manaShield)
  end
end,hpPanel5)
UI.TextEdit(storage.manaShield or "utamo vita", function(widget, newText)
  storage.manaShield = newText
end,hpPanel5)

addIcon("Mystic Full", {item=12685, movable=true, text = "Mystic Full"}, mysticfull)

mystic60 = macro(50, "Defense/kai 60%", function()
    if hppercent() <= 60 and not hasManaShield() then
        say("mystic defense")
    elseif hasManaShield() and (hppercent() >= 100 or manapercent() < 25) then
        say("mystic kai")
    end
end,hpPanel5)

addIcon("Def/kai", {item=672, movable=true, text = "Def/kai"}, mystic60)

reflect = macro(5000, "Reflect", function()
say('reflect')
end,hpPanel5)

addIcon("Reflect", {item=673, movable=true, text = "Reflect"}, reflect)

UI.Label('TargetSay//Reflect',hpPanel5)
UI.TextEdit(storage.saytarget or "Buffs", function(widget, newText)
  storage.saytarget = newText
end,hpPanel5)


UI.TextEdit(storage.reflect or "Buffs", function(widget, newText)
  storage.reflect = newText
end,hpPanel5)


TabBar:addTab("Buffs", hpPanel6)
        color= UI.Label()
color:setColor("green")

UI.Label('Magia Buff',hpPanel6)

UI.TextEdit(storage.buffzmagia or "Buffs", function(widget, newText)
  storage.buffzmagia = newText
end,hpPanel6)

UI.Label('Msg Laranja',hpPanel6)

UI.TextEdit(storage.buffzmsg or "Buffsmsg", function(widget, newText)
  storage.buffzmsg = newText
end,hpPanel6)

UI.Label('Coldown',hpPanel6)

UI.TextEdit(storage.buffzcd or "Buffs", function(widget, newText)
  storage.buffzcd = newText
end,hpPanel6)
 

  PainelsWindow.closeButton.onClick = function(widget)
    PainelsWindow:hide()
  end



  
ui.editPainel.onClick = function(widget)
    PainelsWindow:show()
    PainelsWindow:raise()
    PainelsWindow:focus()
  end

UI.Separator()----------FIM DO PAINEL

checkFrag = macro(100, function()
    say("!frags")
    checkFrag.setOff()
end)
addIcon("Frags", {item =685, text = "Frags"}, checkFrag)

StopOn = macro(500, function()
if CaveBot.isOn() or TargetBot.isOn() then
CaveBot.setOff()
TargetBot.setOff()
StopOn.setOff()
elseif CaveBot.isOff() or TargetBot.isOff() then
CaveBot.setOn()
TargetBot.setOn()
StopOn.setOff()
end
end)

addIcon("On/Off", {item =664, text = "On/Off"}, StopOn)




local cIcon = addIcon("cI",{text="Cave\nBot",switchable=false,moveable=true}, function()
  if CaveBot.isOff() then 
    CaveBot.setOn()
  else 
    CaveBot.setOff()
  end
end)
cIcon:setSize({height=30,width=50})
cIcon.text:setFont('verdana-11px-rounded')

local tIcon = addIcon("tI",{text="Target\nBot",switchable=false,moveable=true}, function()
  if TargetBot.isOff() then 
    TargetBot.setOn()
  else 
    TargetBot.setOff()
  end
end)
tIcon:setSize({height=30,width=50})
tIcon.text:setFont('verdana-11px-rounded')

macro(50,function()
  if CaveBot.isOn() then
    cIcon.text:setColoredText({"Cave\n","white","ON","green"})
  else
    cIcon.text:setColoredText({"Cave\n","white","OFF","red"})
  end
  if TargetBot.isOn() then
    tIcon.text:setColoredText({"Target\n","white","ON","green"})
  else
    tIcon.text:setColoredText({"Target\n","white","OFF","red"})
  end
end)




