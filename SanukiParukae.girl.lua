function checkinit()
  if who ~= self or iter > 16 then
    return true
  end
local sw = game:getselfwind(self)
local rw = game:getroundwind()
  return init:ct(T34.new(sw+27)) >= 2 or  init:ct(T34.new(rw+27)) >= 2 or init:ct(T34.new("1y")) >= 2 or init:ct(T34.new("2y")) >= 2 or init:ct(T34.new("3y")) >= 2
end

function ondraw()
  local shand = game:gethand(self)
  local lhand = game:gethand(self:left())
  local chand = game:gethand(self:cross())
  local rhand = game:gethand(self:right())
  local thehand = game:gethand(who)
  local rule = game:getrule()
  local drids = mount:getdrids()

  
  if who == self then
    local sight = 0
    for _, t in ipairs(shand:effa4()) do
      sight = sight + mount:remaina(t) + (lhand:closed()):ct(t) + (chand:closed()):ct(t) + (rhand:closed()):ct(t) 
      end 
    for _, t in ipairs(shand:effa4()) do
      mount:lighta(t , 5*sight)
    end
	if not shand:ismenzen() then
		for _, t in ipairs(shand:effa()) do
			for _, d in ipairs(drids) do
				if t == d then
					mount:lighta(t , 60)
				end
			end
		end
	end
	if lhand:ready() then
		for _, t in ipairs(lhand:effa()) do
			mount:lighta(t , -20)
			for _, no in ipairs(shand:effa()) do
				if t == no then
					mount:lighta(t , 20)
				end
			end
		end
	end
	if chand:ready() then
		for _, t in ipairs(chand:effa()) do
			mount:lighta(t , -20)
			for _, no in ipairs(shand:effa()) do
				if t == no then
					mount:lighta(t , 20)
				end
			end
		end
	end
	if rhand:ready() then
		for _, t in ipairs(rhand:effa()) do
			mount:lighta(t , -20)
			for _, no in ipairs(shand:effa()) do
				if t == no then
					mount:lighta(t , 20)
				end
			end
		end
	end
  end


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
end
