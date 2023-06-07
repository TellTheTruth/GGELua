--======================================================================--
local __astart = require "astart"

--======================================================================--
local Astart = class()

--@参数 坐标宽度,坐标高度,文件路径(可空),文件大小(如果文件参数为指针)
function Astart:初始化(宽度,高度,文件,大小)
	self.宽度 	= 宽度
	self.高度 	= 高度
	--print(宽度,高度,文件,大小)
	self.as 	= __astart(宽度,高度,文件 or "",大小 or 0)

	local t = getmetatable(self)
	t.__tostring = function (a,b)
		return "Astart"
	end
end
--@返回 返回指定坐标的状态
function Astart:检查点(x,y)
	if x >= self.宽度 or x <=0 then
	    return false
	end
	if y >= self.高度 or y <=0  then
	    return false
	end
	return self.as:CheckPoint(x,y)
end
--@说明 设置指定坐标的状态
function Astart:置状态(x,y,v)
	if x>0 and x<=self.宽度 and y>0 and y<=self.高度 then
	    self.as:SetPoint(x,y,v)
	end
end
--@参数 当前XY,目标XY
--@返回 返回查找到的路径表(2层为{x=xx,y=xx})
function Astart:取路径(x,y,x1,y1)
	return self.as:GetPath(x,y,x1,y1)
end


return Astart