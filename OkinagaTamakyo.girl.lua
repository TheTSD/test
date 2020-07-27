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
  local lhand = game:gethand(self:left())
  local leftdream = Hand.new(game:gethand(self:left()))
  local chand = game:gethand(self:cross())
  local crossdream = Hand.new(game:gethand(self:cross()))
  local rhand = game:gethand(self:right())
  local rightdream = Hand.new(game:gethand(self:right()))

  if who == self then
	if firstdraw == true then
		for _, t in ipairs(T34.all) do
			if t ~= keypair then
			    mount:lighta(t, -100)
			end
		    firstdraw = false
		end
	end
		
    local river = game:getriver(self)
      for _, t in ipairs(river) do
      mount:lighta(t, -80)
      end
    end

    if who==self:left() and shand:ready() and lhand:step() < 3 then
      for _, res in ipairs(shand:effa()) do
		if lhand:ct(res) > 0 then
			if res == T34.new("5p") then
			   if lhand:ct(T37.new("5p")) < 1 then
				  res = T37.new("0p")
			   end
			end
			leftdream = Hand.new(lhand)
			for _, t in ipairs(lhand:effa()) do
				if t ~= res then
					leftdream:swapout(res)
				    if leftdream:step() < lhand:step() then
					mount:lighta(t,500)
					break
				    end
                    if rightdream:step() > rhand:step() then
					mount:lighta(res,50)
				    end
				leftdream = Hand.new(lhand)
			    end
		    end
		end
	  end
	end

    if who==self:cross() and shand:ready() and chand:step() < 3 then
      for _, res in ipairs(shand:effa()) do
		if chand:ct(res) > 0 then
			if res == T34.new("5p") then
			   if chand:ct(T37.new("5p")) < 1 then
				  res = T37.new("0p")
			   end
			end
			crossdream = Hand.new(chand)
			for _, t in ipairs(chand:effa()) do
				if t ~= res then
					crossdream:swapout(res)
				    if crossdream:step() < chand:step() then
					mount:lighta(t,500)
					break
				    end
                    if rightdream:step() > rhand:step() then
					mount:lighta(res,50)
				    end
				crossdream = Hand.new(chand)
			    end
		    end
		end
	  end
	end

    if who==self:right() and shand:ready() and rhand:step() < 3 then
      for _, res in ipairs(shand:effa()) do
		if rhand:ct(res) > 0 then
			if res == T34.new("5p") then
			   if rhand:ct(T37.new("5p")) < 1 then
				  res = T37.new("0p")
			   end
			end
			rightdream = Hand.new(rhand)
			for _, t in ipairs(rhand:effa()) do
				if t ~= res then
					rightdream:swapout(res)
				    if rightdream:step() < rhand:step() then
					mount:lighta(t,500)
					break
				    end
                    if rightdream:step() > rhand:step() then
					mount:lighta(res,50)
				    end
				rightdream = Hand.new(rhand)
			    end
		    end
		end
	  end
	end

end
