local keypair = null
local firstdraw = false

function checkinit()
  if who ~= self then
    return true
  end
local sw = game:getselfwind(self)
local rw = game:getroundwind()
local suits = { "m", "p", "s" }
local ssk = 0
local sak = 0
local itsu = 0
local rp = 0
local ty = 0
local ok = 1

    for i=2,7,1 do
		for _, suit in ipairs(suits) do
			if init:ct(T34.new(i-1 .. suit)) >0 and ok == 1 then
				ssk = ssk + 1
			elseif ok == 1 then
				keypair = T34.new(i-1 .. suit)
			end
			if init:ct(T34.new(i .. suit)) >0 and ok == 1 then
				ssk = ssk + 1
			elseif ok == 1 then
				keypair = T34.new(i .. suit)
			end
			if init:ct(T34.new(i+1 .. suit)) >0 and ok == 1 then
				ssk = ssk + 1
			elseif ok == 1 then
				keypair = T34.new(i+1 .. suit)
			end
		end
		if ssk > 7 then
			ok = 0
            firstdraw = true
		end
		if ssk <= 7 then
			ssk = 0
		end
	end
	
	
    for _, suit in ipairs(suits) do
		for i=1,9,1 do
			if init:ct(T34.new(i .. suit)) >0 then
				itsu = itsu + 1
			elseif ok == 1 then
				keypair = T34.new(i .. suit)
			end
		end
		if itsu > 7 then
			ok = 0
            firstdraw = true
		end
		if itsu <= 7 then
			itsu = 0
		end
	end
	
	for _, t in ipairs(T34.all) do
        if init:ct(t) > 2 then
	     sak = sak + 3
	    end
        if init:ct(t) == 2 and ok == 1 then
	     sak = sak + 1
		 keypair = t
	    end
    end
	if sak > 6 then
		ok = 0
        firstdraw = true
	end
	if sak <= 6 then
		sak = 0
	end
	
	for _, suit in ipairs(suits) do
        for i=2,7,1 do
        if init:ct(T34.new((i-1) .. suit)) > 1 and init:ct(T34.new((i) .. suit)) > 1 and init:ct(T34.new((i+1) .. suit)) > 1 then
			ok = 0
		end
	end
	end
	
	
    if init:closed():ct("p") > 9 or init:closed():ct("s") > 9 or init:closed():ct("m") > 9 then
    	ok = 0
    end
	
    for i=0,3,1 do
		for _, suit in ipairs(suits) do
			ty = ty + init:ct(T34.new(5-i .. suit))
		end
		if ty > 10 and init:step() <= 2 then
			ok = 0
		end
		if ty <= 10 or init:step() > 2 then
			ty = 0
		end
	end
		
	
  return ok == 0
end


function ondraw()
  local shand = game:gethand(self)
  
  if who == self then
	if firstdraw == true then
		for _, t in ipairs(T34.all) do
			if t ~= keypair then
			    mount:lighta(t, -100)
			end
		    firstdraw = false
		end
	  end
	end

  if who == self then
      square(mount,game,who)
    end
    end

function square(moumt,game,who)
  if who ~= self or rinshan then
    return
  end
  
  local mk = 500
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
