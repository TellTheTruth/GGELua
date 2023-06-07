-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-01-27 03:51:34
-- @最后修改来自: baidwwy
-- @Last Modified time: 2016-05-27 17:11:27
--======================================================================--
--
--======================================================================--
local rect = class()
local _tostring = function (t) return "ggeRect" end

function rect:初始化(x,y,w,h,c)
	self.x = x or 0
	self.y = y or 0
	self.w = w or 0
	self.h = h or 0
	self.x2 = self.x+self.w
	self.y2 = self.y+self.h
	self.颜色 = c or -1
	self.中心x = 0
	self.中心y = 0
	getmetatable(self).__tostring = _tostring
end
function rect:检查盒(b)
	if self:检查点(b.x,b.y) then
	    return 1
	elseif self:检查点(b.x+b.w,b.y) then
	    return 2
	elseif self:检查点(b.x,b.y+b.h) then
	    return 3
	elseif self:检查点(b.x+b.w,b.y+b.h) then
	    return 4
	elseif (b.x > self.x or b.x2 > self.x) and b.x <= self.x2 and self.y > b.y and self.y <= b.y2 then
		return 0
	end
	return false
end

function rect:检查点(x,y)
	if type(x) == 'table' then
	    y,x = x.y,x.x
	end
	if x>=self.x and x<=self.x+self.w then
	    if y>=self.y and y<=self.y+self.h then
	    	return true
		end
	end
	return false
end
function rect:置中心(x,y)
	self.中心x = x
	self.中心y = y
	self.x = self.x -self.中心x
	self.y = self.y -self.中心y
	return self
end
function rect:置坐标(x,y)
	if type(x) == 'table' then
	    y,x = x.y,x.x
	end
	self.x = x -self.中心x
	self.y = y -self.中心y
	return self
end
function rect:置宽高(x,y)
	self.w = x
	self.h = y
	return self
end
function rect:置坐标宽高(x,y,w,h)
	self.x = x
	self.y = y
	if w then
		self.w = w
		self.h = h
	end
end
function rect:取坐标()
	return self.x,self.y
end
function rect:取中心()
	return self.中心x,self.中心y
end

return rect