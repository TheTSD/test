local chance = 1
local moon = 0
local count = 70

function ondice()
  chance = 1
  count = 70
  moon = rand:gen(36)
  if moon == 34 then
	moon = "0p"
end
  if moon == 35 then
	moon = "0s"
end
  if moon == 36 then
	moon = "0m"
end
  print(T37.new(moon))
end

function checkinit()
  local m1 = 0
  local m2 = 0
  local m3 = 0
  local m4 = 0

  if who == self then
	m1 = init:ct(T37.new(moon))
  end
  if who == self:right() then
	m2 = init:ct(T37.new(moon))
  end
  if who == self:cross() then
	m3 = init:ct(T37.new(moon))
  end
  if who == self:left() then
	m4 = init:ct(T37.new(moon))
  end

  if moon ~= "0p" and moon ~= "0s" and moon ~= "0m" then
    return m1 + m2 + m3 + m4 <= 3
	end
  if moon == "0p" or moon or "0s" and moon or "0m" then
	return m1 + m2 + m3 + m4 == 0
    end
end


function ondraw()

  local hand = game:gethand(self)
  local rhand = game:gethand(self:right())
  local chand = game:gethand(self:cross())
  local lhand = game:gethand(self:left())
  local thehand = game:gethand(who)
  local dream = Hand.new(hand)
  local themoon = false
  dream:draw(T37.new(moon))
--


  if who ~=self then
	if thehand:step() >= 1 then
		if who == self:left() then
			for _, t in ipairs(chand:effa()) do
				mount:lighta(t , 30)
				for _, no in ipairs(lhand:effa()) do
					if t == no then
						mount:lighta(t , -30)
					end
				end
			end
			for _, t in ipairs(rhand:effa()) do
				mount:lighta(t , 30)
				for _, no in ipairs(lhand:effa()) do
					if t == no then
						mount:lighta(t , -30)
					end
				end
			end
		end
		if who == self:cross() then
			for _, t in ipairs(lhand:effa()) do
				mount:lighta(t , 30)
				for _, no in ipairs(chand:effa()) do
					if t == no then
						mount:lighta(t , -30)
					end
				end
			end
			for _, t in ipairs(rhand:effa()) do
				mount:lighta(t , 30)
				for _, no in ipairs(chand:effa()) do
					if t == no then
						mount:lighta(t , -30)
					end
				end
			end
		end
		if who == self:right() then
			for _, t in ipairs(chand:effa()) do
				mount:lighta(t , 30)
				for _, no in ipairs(rhand:effa()) do
					if t == no then
						mount:lighta(t , -30)
					end
				end
			end
			for _, t in ipairs(lhand:effa()) do
				mount:lighta(t , 30)
				for _, no in ipairs(rhand:effa()) do
					if t == no then
						mount:lighta(t , -30)
					end
				end
			end
		end
end
end

--
  count = count - 1
  if chance == 1 then
    mount:loadb(T37.new(moon), 1)
  end

  if count == 0 then
	mount:lightb(T37.new(moon), 2000)
  end

  if who == self:right() then
    for n=1,17 do
      if n*4 == count then
        for _, t in ipairs(hand:closed()) do
          if hand:closed():ct(t) >= 2 then
            mount:lighta(t,200)
            for _, no in ipairs(rhand:effa()) do
              if t == no then
                mount:lighta(t,-200)
              end
            end
          end
        end
      end
    end
  end

  if who == self:cross() then
    for n=1,17 do
      if n*4 == count then
        for _, t in ipairs(hand:closed()) do
          if hand:closed():ct(t) >= 2 then
            mount:lighta(t,200)
            for _, no in ipairs(chand:effa()) do
              if t == no then
                mount:lighta(t,-200)
              end
            end
          end
        end
      end
    end
  end

  if who == self:left() then
    for n=1,17 do
      if n*4 == count then
        for _, t in ipairs(hand:closed()) do
          if hand:closed():ct(t) >= 2 then
            mount:lighta(t,200)
            for _, no in ipairs(lhand:effa()) do
              if t == no then
                mount:lighta(t,-200)
              end
            end
          end
        end
      end
    end
  end
          


  if hand:ready() then
	for _, t in ipairs(hand:effa()) do
      if t == T37.new(moon) then
	    themoon = true
	    end
      end
	  if themoon == false then
		if who == self then
		  for _, t in ipairs(hand:effa()) do
            mount:lighta(t,200)
          end
		end
	  end
	  if themoon == true then
		if who == self then
		  for _, t in ipairs(hand:effa()) do
            mount:lighta(t,-200)
          end
		end
		if who == self:right() then
		  for _, t in ipairs(rhand:effa()) do
            mount:lighta(t,-200)
          end
		end
		if who == self:cross() then
		  for _, t in ipairs(chand:effa()) do
            mount:lighta(t,-200)
          end
		end
		if who == self:left() then
		  for _, t in ipairs(lhand:effa()) do
            mount:lighta(t,-200)
          end
		end
	  end
    end


  if who == self then
    if not hand:ready() then
      for _, t in ipairs(dream:effa4()) do
        mount:lighta(t,160)
      end
    end
  end


end