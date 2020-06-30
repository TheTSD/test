function checkinit()
	
  if who ~= self or iter > 50 then
    return true
  end

local sw = game:getselfwind(self)
local rw = game:getroundwind()
local suits = { "m", "p", "s" }
local ssk = 0
local sak = 0
local rp = 0
local ty = 0
local ok = 1
  
    for i=2,7,1 do
		for _, suit in ipairs(suits) do
			if init:ct(T34.new(i-1 .. suit)) >0 then
				ssk = ssk + 1
			end
			if init:ct(T34.new(i .. suit)) >0 then
				ssk = ssk + 1
			end
			if init:ct(T34.new(i+1 .. suit)) >0 then
				ssk = ssk + 1
			end
		end
		if ssk > 6 then
			ok = 0
		end
		if ssk <= 6 then
			ssk = 0
		end
	end
	
	for _, t in ipairs(T34.all) do
        if init:ct(t) > 2 then
	     sak = sak + 3
	    end
        if init:ct(t) == 2 then
	     sak = sak + 1
	    end
    end
	if sak > 5 then
		ok = 0
	end
	if sak <= 5 then
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
		if ty > 9 then
			ok = 0
		end
		if ty <= 9 then
			ty = 0
		end
	end
		
  return ok == 0
end

function ongameevent()
  if event.type == "barked" or event.type == "drawn" then
    diser = event.args.who
  end
  if event.type == "discarded" then
    read(mount, game, who)
  end
end

function ondraw()
  local shand = game:gethand(self)
  local lhand = game:gethand(self:left())
  local chand = game:gethand(self:cross())
  local rhand = game:gethand(self:right())
  local rule = game:getrule()
  local drids = mount:getdrids()
  local diser = nil
  local ctx = game:getformctx(self)
  if ctx.ippatsu then
    return
  end
  
  if who == self then
    local steptarget = 8
    if lhand:step() <= steptarget then
      steptarget = lhand:step() - 1
      end
    if chand:step() <= steptarget then
      steptarget = chand:step() - 1
      end
    if rhand:step() <= steptarget then
      steptarget = rhand:step() - 1
      end
    if steptarget <= shand:step() then
      square(mount,game,who)
    end
    if shand:ready() then
      for _, t in ipairs(shand:effa()) do
	    local ok = 1
	    local river = game:getriver(self)
          for _, i in ipairs(river) do
	        if t == i then
            ok = 0
		  end
        end
	    if ok == 1 then
        mount:lighta(t , 120)
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
              mount:lighta(t, 500)
              end
            end
          end
        if who == self:cross() and chand:ready() then
          for _, none in ipairs(chand:effa()) do
            if none ~= t then
              mount:lighta(t, 500)
              end
            end
          end
        if who == self:right() and rhand:ready() then
          for _, none in ipairs(rhand:effa()) do
            if none ~= t then
              mount:lighta(t, 500)
              end
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
  local shand = game:gethand(self)
  for _, t in ipairs(shand:effa()) do
	local ok = 1
	local river = game:getriver(self)
    for _, i in ipairs(river) do
	    if t == i then
          ok = 0
		end
      end
	if ok == 1 then
        mount:lighta(t , 90)
	  end
    end

end
