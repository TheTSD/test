local mode = 0
--默认模式
local starthand = {}
--配牌
local firstdraw = false
--首章判定
local lasthand = {}
--手牌
local tsumokiri = false
--自摸切判定，初始关闭
local concut = false
--持续切判定，初始关闭

function ondice()
  mode = 0
  --重置模式
  if concut == true then
    mode = 1
    end
  --判定模式
  if mode == 0 then
    concut = true
    end
  --每局开始开启自摸切判定
  if mode == 1 then
    print("妙法般象皆谛")
    end
  --模式1
  firstdraw = true
  --首章判定重置
end

function checkinit()
  if who ~= self or mode ~= 1 then
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
  local threeseven = {"1p","2p","3p","4p","5p","0p","6p","7p","8p","9p","1s","2s","3s","4s","5s","0s","6s","7s","8s","9s","1m","2m","3m","4m","5m","0m","6m","7m","8m","9m","1f","2f","3f","4f","1y","2y","3y"}
  local hand = game:gethand(self)
  local closed = hand:closed()
  if firstdraw == true then
    firstdraw = false
    local count = 1
    for _, t in ipairs(threeseven) do
      starthand[count] = T37.new(t)
      starthand[count+1] = closed:ct(starthand[count])
      count = count + 2
    end
  end
  --找出配牌,特殊密码组

  if tsumokiri == true and not hand:ready() and mode == 0 then
	tsumokiri = false
	ryou(mount, game, who)
	aku(mount, game, who)
  end

  if mode == 1 then
	tsumokiri = false
    for _, t in ipairs(hand:effa()) do
	  mount:lighta(t, 100)
	end
  end

end

function ongameevent()
  if event.type == "barked" or event.type == "drawn" then
    diser = event.args.who
  end
  if event.type == "discarded" then
    cutcare(mount, game, who)
	password(mount, game, who)
  end
end

function cutcare()
  if diser == self then
    local threeseven = {"1p","2p","3p","4p","5p","0p","6p","7p","8p","9p","1s","2s","3s","4s","5s","0s","6s","7s","8s","9s","1m","2m","3m","4m","5m","0m","6m","7m","8m","9m","1f","2f","3f","4f","1y","2y","3y"}
    local thehand = game:gethand(diser)
    local closed = thehand:closed()
    local nowhand = {}
    local count = 1
	local case = 0
    for _, t in ipairs(threeseven) do
      nowhand[count] = T37.new(t)
      nowhand[count+1] = closed:ct(nowhand[count])
      count = count + 2
    end
    --特殊密码组，检验T37的所有牌在手里的数量，持续性检查自摸切
    for i = 1, #nowhand do
      if nowhand[i] ~= lasthand[i] then
        case = 1
		lasthand[i] = nowhand[i]
      end
	end
	if case == 0 then
	  tsumokiri = true
	end  
  end
end

function password()
  local threeseven = {"1p","2p","3p","4p","5p","0p","6p","7p","8p","9p","1s","2s","3s","4s","5s","0s","6s","7s","8s","9s","1m","2m","3m","4m","5m","0m","6m","7m","8m","9m","1f","2f","3f","4f","1y","2y","3y"}
  local thehand = game:gethand(self)
  local closed = thehand:closed()
  local nowhand = {}
  local count = 1
  for _, t in ipairs(threeseven) do
    nowhand[count] = T37.new(t)
    nowhand[count+1] = closed:ct(nowhand[count])
    count = count + 2
    end
  --特殊密码组，持续性检查自摸切
  for i = 1, #starthand do
    if nowhand[i] ~= starthand[i] then
      concut = false
    end
  end
end

function ryou (mount, game, who)
  
  if who ~= self then
    return
  end

  local mk = 400
  local hand = game:gethand(self)
  local closed = hand:closed()
  local dream = Hand.new(hand)
  local allpair = {}
  local allrange = 1
  local cutpair = {}
  local cutrange = 1
  local bestpair = T34.new("1p")
  local bestcut = T34.new("1p")
  local bestcount = 0
  local suits = { "m", "p", "s" }
  local threeseven = {"1p","2p","3p","4p","5p","0p","6p","7p","8p","9p","1s","2s","3s","4s","5s","0s","6s","7s","8s","9s","1m","2m","3m","4m","5m","0m","6m","7m","8m","9m","1f","2f","3f","4f","1y","2y","3y"}

--allpair锁定effa组，cutpair预定是要切的牌，用于梦手，bestpair是最后选出最佳进章，bestcut是对应的切章，bestcount用于记录最后最多的有效种类。


  for _, i in ipairs(threeseven) do
    t = T37.new(i)
    if closed:ct(t) >= 1 then
       cutpair[cutrange] = t
       cutrange = cutrange + 1
    end
  end
--此处遍历T37，找出手里有的牌


  for _, t in ipairs(hand:effa4 ()) do
    allpair[allrange] = T37.new(t:id34())
    allrange = allrange + 1
    if t == T34.new("5p") then
      allpair[allrange] = T37.new("0p")
      allrange = allrange + 1
    end
    if t == T34.new("5s") then
      allpair[allrange] = T37.new("0s")
      allrange = allrange + 1
    end
    if t == T34.new("5m") then
      allpair[allrange] = T37.new("0m")
      allrange = allrange + 1
    end
  end
--此处遍历T37，找出所有effa

  if not hand:ready() then
    for _, t in ipairs(allpair) do
      for _, cut in ipairs(cutpair) do
        if mount:remaina(t) > 0 and cut ~= t then
          dream = Hand.new(hand)
          dream:draw(t)
          dream:swapout(cut)
          if dream:step() < hand:step() then
            local comingcount = 0
            for _, no in ipairs(dream:effa()) do
              comingcount = comingcount + 1
            end
            if comingcount > bestcount then
              bestpair = t
              bestcut = cut
              bestcount = comingcount
            end
          end
        end
       end
    end

--枚举出所有effa下的每一种切章，找出有效的中，effa种类最丰富的
  
    for i = 2,8 do
      for _, suit in ipairs(suits) do
        if hand:step() >= 1 and closed:ct(T34.new(i .. suit)) == 2 and (closed:ct(T34.new(i+1 .. suit)) > 0 and closed:ct(T34.new(i-1 .. suit)) > 0) then
          mount:lighta(T34.new(i .. suit), mk)
          end
      end
    end

--增加数量为2的中章牌的上章可能，加大良型的成率。
      
  mount:lighta(bestpair, mk)
  
  if hand:step() == 1 and bestcount >= 3 then
    mount:lighta(bestpair, mk)
    end
  end
end

function aku (mount, game, who)
  
  if who == self then
    return
  end

  local ehand = game:gethand(who)
  local yaos = {"1p","9p","1s","9s","1m","9m","1f","2f","3f","4f","1y","2y","3y"}

  for _, akuhai in ipairs(yaos) do
	mount:lighta(T34.new(akuhai), 50)
	for _, t in ipairs(ehand:effa()) do
	  if t == T34.new(akuhai) then
		mount:lighta(t, -50)
	  end
	end
  end
end