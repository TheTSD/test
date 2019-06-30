function onmonkey()
  local selfwind = game:getselfwind(self)
  local roundwind = game:getextraround()
  local existself = exists[self:index()]
  local existl = exists[self:left():index()]
  local existc = exists[self:cross():index()]
  local existr = exists[self:right():index()]

  -- 常驻的低字牌配牌率
    existself:incmk(T34.new("1f"), -20)
    existself:incmk(T34.new("2f"), -20)
    existself:incmk(T34.new("3f"), -20)
    existself:incmk(T34.new("4f"), -20)
    existself:incmk(T34.new("1y"), -20)
    existself:incmk(T34.new("2y"), -20)
    existself:incmk(T34.new("3y"), -20)


  -- 优化配牌自风算法
  -- 自家400mk，他家-30，助推checkinit
    if selfwind == 1 then
    existself:incmk(T34.new("1f"), 420)
    existl:incmk(T34.new("1f"), -30)
    existc:incmk(T34.new("1f"), -30)
    existr:incmk(T34.new("1f"), -30)
    end
    if selfwind == 2 then
    existself:incmk(T34.new("2f"), 420)
    existl:incmk(T34.new("2f"), -30)
    existc:incmk(T34.new("2f"), -30)
    existr:incmk(T34.new("2f"), -30)
    end
    if selfwind == 3 then
    existself:incmk(T34.new("3f"), 420)
    existl:incmk(T34.new("3f"), -30)
    existc:incmk(T34.new("3f"), -30)
    existr:incmk(T34.new("3f"), -30)
    end
    if selfwind == 4 then
    existself:incmk(T34.new("4f"), 420)
    existl:incmk(T34.new("4f"), -30)
    existc:incmk(T34.new("4f"), -30)
    existr:incmk(T34.new("4f"), -30)
    end

  -- 优化南场南风算法
  -- 自家100mk，他家-30，助推checkinit
  local rw = game:getroundwind()
  if rw == 2 then
    existself:incmk(T34.new("2f"), 120)
    existl:incmk(T34.new("2f"), -30)
    existc:incmk(T34.new("2f"), -30)
    existr:incmk(T34.new("2f"), -30)
    end

end

function checkinit()
  -- 确保配牌3张自风
  local selfwind = game:getselfwind(self)
  local roundwind = game:getroundwind()

  if who == self and roundwind ==1 then
    if selfwind == 1 then
       return init:ct(T34.new("1f")) == 3
    end
    if selfwind == 2 then
       return init:ct(T34.new("2f")) == 3
    end
    if selfwind == 3 then
       return init:ct(T34.new("3f")) == 3
    end
    if selfwind == 4 then
       return init:ct(T34.new("4f")) == 3
    end
  end

  if who == self and roundwind ==2 then
    if selfwind == 1 then
       return init:ct(T34.new("1f")) == 3 and init:ct(T34.new("2f"))  == 1
    end
    if selfwind == 2 then
       return init:ct(T34.new("2f")) == 3
    end
    if selfwind == 3 then
       return init:ct(T34.new("3f")) == 3 and init:ct(T34.new("2f")) == 1
    end
    if selfwind == 4 then
       return init:ct(T34.new("4f")) == 3 and init:ct(T34.new("2f"))== 1
    end
  end

  if who ~= self and roundwind == 1 then
    return true
end

  if who ~= self and roundwind ==2 then
     return init:ct(T34.new("2f"))  <= 1
 end
end

function ondraw()
  local selfwind = game:getselfwind(self)
  local roundwind = game:getroundwind()
  local closed = game:gethand(self):closed()
  local hand = game:gethand(self)

  if rinshan then
    return
  end

  if who ~= self then
if roundwind == 2 and selfwind ~= 2 and mount:remainpii()==70 then
mount:loadb(T37.new("2f"), 2)
else
return
end
end


 -- 常驻的低字牌上手率
 -- 无法入手第四张字牌
  if who == self then
    mount:lighta(T34.new("1f"), -20)
    mount:lighta(T34.new("2f"), -20)
    mount:lighta(T34.new("3f"), -20)
    mount:lighta(T34.new("4f"), -20)
    mount:lighta(T34.new("1y"), -20)
    mount:lighta(T34.new("2y"), -20)
    mount:lighta(T34.new("3y"), -20)
if selfwind == 1 then
      mount:lighta(T34.new("1f"), -100)
end
if selfwind == 2 then
      mount:lighta(T34.new("2f"), -100)
end
if selfwind == 3 then
      mount:lighta(T34.new("3f"), -100)
end
if selfwind == 4 then
      mount:lighta(T34.new("4f"), -100)
end
if roundwind == 2 then
      mount:lighta(T34.new("2f"), -100)
      mount:lightb(T34.new("2f"),100)
end
if roundwind == 2 and selfwind ~= 2 and mount:remainpii()==70 then
mount:loadb(T37.new("2f"), 2)
end
  end

  if hand:step() >= 1 then
  for _, t in ipairs(T34.all) do
    if closed:ct(t) > 0 then
mount:lighta(t,10)
  end
 end
end
  if hand:ready() then
  for _, t in ipairs(hand:effa()) do
    if closed:ct(t) > 0 then
mount:lighta(t,50)
  end
 end
end

end