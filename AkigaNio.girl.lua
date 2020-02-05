local first = true
local time = 0

function ondice()
  first = true
  time = 0
end

function checkinit()
  if who ~= self then
    return true
  end

local suits = { "m", "p", "s" }
local prime0 = { 0, 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199 }
local pp = 0
local ps = 0
local pm = 0
local clockp = false
local clocks = false
local clockm = false

  
  for _, suit in ipairs(suits) do
    for i=1,9,1 do
      if suit == "p" then
        pp = pp + (init:ct(T34.new(i .. suit))*i)
        end
      if suit == "s" then
        ps = ps + (init:ct(T34.new(i .. suit))*i)
        end
      if suit == "m" then
        pm = pm + (init:ct(T34.new(i .. suit))*i)
      end
    end
  end
	
  for _, t in ipairs(prime0) do
    if t == pp then
      clockp = true
      end
    if t == ps then
      clocks = true
      end
    if t == pm then
      clockm = true
    end
  end
  return clockp == true and clocks == true and clockm == true
	
end

function ondraw()
  time = time + 1
	
  local suits = { "m", "p", "s" }
  local hand = game:gethand(self)
  local prime0 = { 0, 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199 }
  local primetime = { 0, 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67 }
  local primepai = { "2m", "3m", "5m", "7m", "2p", "3p", "5p", "7p", "2s", "3s", "5s", "7s" }
  local primeMK = 0
  for _, i in ipairs(primepai) do
	local t = T34.new(i)
	primeMK = primeMK + (hand:ct(t) * 5)
  end

  if who == self and (first == true or hand:ready()) then
	local pp = 0
    local ps = 0
    local pm = 0
	for _, suit in ipairs(suits) do
      for i=1,9,1 do
        if suit == "p" then
          pp = pp + (hand:ct(T34.new(i .. suit))*i)
          end
        if suit == "s" then
          ps = ps + (hand:ct(T34.new(i .. suit))*i)
          end
        if suit == "m" then
          pm = pm + (hand:ct(T34.new(i .. suit))*i)
        end
      end
    end
    for _, t in ipairs(hand:effa()) do
	  local suitt = t:suit()
	  local valt = t:val()
	  local turn = false
	  for _, ptest in ipairs(prime0) do
        if suit == "p" then
          if ptest == valt + ps then
		    mount:lighta(t, 400)
            end
		  end
        if suit == "s" then
          if ptest == valt + ps then
		    mount:lighta(t, 400)
            end
		  end
        if suit == "m" then
          if ptest == valt + ps then
		    mount:lighta(t, 400)
            end
		  end
		end
      end
	first = false
    end
	
	if who == self and first == false then
      for _, t in ipairs(hand:effa()) do
		mount:lighta(t, primeMK)
	  end
	end
	
	if who == self and hand:ready() then
	  local primeCT = 0
	  for _, i in ipairs(primepai) do
	    local t = T34.new(i)
		primeCT = primeCT + hand:ct(t)
      end
      if primeCT >= 8 then
        for _, t in ipairs(hand:effa()) do
		  mount:lighta(t, 200)
		end
	  end
	end
	
	if who ~= self then
	  local specialhand = game:gethand(who)
	  for _, i in ipairs(primetime) do
		if i == primetime then
		  for _, t in ipairs(primetime) do
			for _, off in ipairs(specialhand:effa()) do
			  if off ~= t then
				mount:lighta(t, primeMK)
			  end
			end
		  end
		end
	  end
	end
	
end