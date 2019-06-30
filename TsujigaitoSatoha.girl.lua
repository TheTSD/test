function ondraw()
  local shand = game:gethand(self)
  local lhand = game:gethand(self:left())
  local chand = game:gethand(self:cross())
  local rhand = game:gethand(self:right())
  local diser = nil
  
  if who == self then
    local steptarget = 8
    if lhand:step() < steptarget then
      steptarget = lhand:step()
      end
    if chand:step() < steptarget then
      steptarget = chand:step()
      end
    if rhand:step() < steptarget then
      steptarget = rhand:step()
      end
    if steptarget < shand:step() then
      square(mount,game,who)
    end
    if shand:ready() then
      if lhand:step() >= 1 and chand:step() >= 1 and rhand:step() >= 1 then
        for _, t in ipairs(shand:effa()) do
          mount:lighta(t, 100)
          end
        end
      end
  end
  
  if who ~= self then
    if shand:ready() then
      for _, t in ipairs(shand:effa()) do
        if who == self:left() and lhand:ready() then
          for _, none in ipairs(shand:effa()) do
            if none ~= t then
              mount:lighta(t, 150)
              end
            end
          end
        if who == self:cross() and chand:ready() then
          for _, none in ipairs(chand:effa()) do
            if none ~= t then
              mount:lighta(t, 150)
              end
            end
          end
        if who == self:right() and rhand:ready() then
          for _, none in ipairs(rhand:effa()) do
            if none ~= t then
              mount:lighta(t, 150)
              end
            end
          end
        end
      end
    end
  

function ongameevent()
  if event.type == "barked" or event.type == "drawn" then
    diser = event.args.who
  end
  if event.type == "discarded" then
    read(mount, game, who)
  end
end

function read(mount, game, who)
  local thehand = game:gethand(diser)
  if diser ~= self then
      if diser == self:right() then
      print("下家", thehand:step(),"向听")
      end
      if diser == self:cross() then
      print("对家",thehand:step(),"向听")
      end
      if diser == self:left() then
      print("上家",thehand:step(),"向听")
      end
  end
end 

function square(moumt,game,who)
  if who ~= self or rinshan then
    return
  end
  
  local mk = 400
  local hand = game:gethand(self)
  local step7 = hand:step7()
  local closed = game:gethand(self):closed()
  local sskpoint = 0
  local ytsupoint = 0
  local ypkpoint = 0
  local sskmaxpoint = 0
  local sakopoint = 0
  local ytsumaxpoint = 0
  local ypkmaxpoint = 0
  local sskmaxdpai = 0
  local ypkmaxdpai = 0
  local sakomaxpoint = 0
  local sakolimit = 0
  local ytsumaxdcolour = { "f" }
  local ypkmaxdcolour = { "f" }
  local suits = { "m", "p", "s" }

  for i=2,7,1 do
    sskpoint = 0
      for _, suit in ipairs(suits) do
        if hand:ct(T34.new((i-1) .. suit)) > 0 then
          sskpoint = sskpoint + 1
        end
        if hand:ct(T34.new(i .. suit)) > 0 then
          sskpoint = sskpoint + 1
        end
        if hand:ct(T34.new((i+1) .. suit)) > 0 then
          sskpoint = sskpoint + 1
        end
      end
        if sskpoint >= sskmaxpoint then
        sskmaxpoint = sskpoint
        sskmaxdpai = i
      end
        if sskpoint == 9 then
          for _, t in ipairs(hand:effa4()) do
            mount:lighta(t, mk)
          end
        end
      end





     for _, suit in ipairs(suits) do
      ytsupoint = 0
        for i=1,9,1 do
        if hand:ct(T34.new(i .. suit)) > 0 then
          ytsupoint = ytsupoint + 1
        end
      end
        if ytsupoint >= ytsumaxpoint then
        ytsumaxpoint = ytsupoint
        ytsumaxdcolour = suit
      end
        if ytsupoint == 9 then
          for _, t in ipairs(hand:effa4()) do
            mount:lighta(t, mk)
          end
        end
      end


        if sskmaxpoint >= 5  and sskmaxpoint >= ytsumaxpoint then
      for _, suit in ipairs(suits) do
        if hand:ct(T34.new((sskmaxdpai-1) .. suit)) < 1 then
          mount:lighta(T34.new((sskmaxdpai-1) .. suit), mk)
        end
        if hand:ct(T34.new(sskmaxdpai .. suit)) < 1 then
          mount:lighta(T34.new(sskmaxdpai .. suit), mk)
        end
        if hand:ct(T34.new((sskmaxdpai+1) .. suit)) < 1 then
          mount:lighta(T34.new((sskmaxdpai+1) .. suit), mk)
        end
        end
      end

  


        if ytsumaxpoint >= 5 and ytsumaxpoint >= sskmaxpoint then
      for i=1,9,1 do
        if hand:ct(T34.new(i .. ytsumaxdcolour)) < 1 then
          mount:lighta(T34.new(i .. ytsumaxdcolour), mk)
        end
      end
      end




     for _, suit in ipairs(suits) do
        for i=2,7,1 do
        if hand:ct(T34.new((i-1) .. suit)) > 0 then
          ypkpoint = ypkpoint + 1
        end
        if hand:ct(T34.new((i-1) .. suit)) > 1 then
          ypkpoint = ypkpoint + 1
        end
        if hand:ct(T34.new(i .. suit)) > 0 then
          ypkpoint = ypkpoint + 1
        end
        if hand:ct(T34.new(i .. suit)) > 1 then
          ypkpoint = ypkpoint + 1
        end
        if hand:ct(T34.new((i+1) .. suit)) > 0 then
          ypkpoint = ypkpoint + 1
        end
        if hand:ct(T34.new((i+1) .. suit)) > 1 then
          ypkpoint = ypkpoint + 1
        end
        if ypkpoint >= ypkmaxpoint then
        ypkmaxpoint = ypkpoint
        ypkmaxdcolour = suit
        ypkmaxdpai = i
      end
      ypkpoint = 0
      end
        if ypkmaxpoint == 6 then
          for _, t in ipairs(hand:effa4()) do
            mount:lighta(t, mk)
          end
        end
      end
	if ypkmaxpoint >= 4 then
        if hand:ct(T34.new((ypkmaxdpai-1) .. ypkmaxdcolour)) < 2 then
          mount:lighta(T34.new((ypkmaxdpai-1) .. ypkmaxdcolour), mk)
      end
        if hand:ct(T34.new(ypkmaxdpai .. ypkmaxdcolour)) < 2 then
          mount:lighta(T34.new(ypkmaxdpai .. ypkmaxdcolour), mk)
      end
        if hand:ct(T34.new((ypkmaxdpai+1) .. ypkmaxdcolour)) < 2 then
          mount:lighta(T34.new((ypkmaxdpai+1) .. ypkmaxdcolour), mk)
      end
      end



	for _, t in ipairs(T34.all) do
        if hand:ct(t) > 2 then
	sakopoint = sakopoint + 1
      end
      end
    if hand:ismenzen() then 
    sakolimit = 3
    end
    if not hand:ismenzen() then
    sakolimit = 4
    end
    
	if sakopoint < sakolimit and sakopoint > 0 then
	 for _, t in ipairs(T34.all) do
	   if hand:ct(t) == 1 then
	   mount:lighta(t, 100)
      end
	   if hand:ct(t) == 2 then
	   mount:lighta(t, mk)
      end
      end
      end
	if sakopoint == sakolimit and hand:ready() then
    	for _, t in ipairs(hand:effa4()) do
     	 mount:lighta(t, mk)
      end
      end



  	if step7 <=2 then
    	for _, t in ipairs(hand:effa4()) do
     	 mount:lighta(t, mk)
   	 end
	end
	
	


    end

end
