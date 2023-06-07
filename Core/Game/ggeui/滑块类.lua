--=====================================================================================
local super = require("ggeui/按钮类")
local GUI滑块类 = class(super)
--=====================================================================================
function GUI滑块类:初始化(标记,x,y,宽度,高度)
	self._类型 		= '竖形滑块'
	self._位置 		= 1
	self._px 		= x or 0
	self._py 		= y or 0
	self._宽度 		= 宽度 or 10
	self._高度 		= 高度 or 10
	self._滑块高度 	= 0
	self._滑块宽度 	= 0
	self._最大值 	= 100
	self._最小值 	= 1
	self._包围盒:置中心(-self._px,-self._py)
	self._包围盒:置宽高(self._宽度,self._高度)
end
function GUI滑块类:取位置()
	return  self._位置
end
function GUI滑块类:置位置(v)
	self:_更新位置(self._位置/self._最大值*self._宽度,self._位置/self._最大值*self._高度)
	self._位置 = v
end
function GUI滑块类:置滑块高度(v)
	self._滑块高度 = v
end
function GUI滑块类:置滑块宽度(v)
	self._滑块宽度 = v
end
function GUI滑块类:_更新位置(x,y)
	if self._类型 == '竖形滑块' then
		self._位置 = math.floor(y/self._高度*self._最大值)
		if y < 0 then y = 0;self._位置 = self._最小值 end
	    if y > self._高度-self._滑块高度 then y = self._高度-self._滑块高度;self._位置 = self._最大值 end
	    self._精灵:置中心(0,-y)
	else
		self._位置 = math.floor(x/self._宽度*self._最大值)
		if x <0 then x = 0;self._位置 = self._最小值 end
	    if x > self._宽度-self._滑块宽度 then x = self._宽度-self._滑块宽度;self._位置 = self._最大值 end
	    self._精灵:置中心(-x,0)
	end
	self:发送消息('位置改变',self._位置)
end
function GUI滑块类:_消息事件(类型,x,y)
	local ret = self:运行父函数(super,'_消息事件',类型,x,y)
	if 类型 == '鼠标移动' then
		if self._状态 == 2 then
			local py = y-self._y-self._滑块高度/2--鼠标坐标-滑块坐标-滑块大小
			local px = x-self._x-self._滑块宽度/2
			self:_更新位置(px,py)
			--self:发送消息(类型,x,y)
		end
	elseif 类型 == '左键按下' then
		if self._包围盒:检查点(x,y) then
			local py = y-self._y-self._滑块高度/2
			local px = x-self._x-self._滑块宽度/2
			self:_更新位置(px,py)
			return true
		end
	elseif 类型 == '窗口移动' then
		self._包围盒:置坐标(x,y)
	elseif 类型 == '右键按下' or 类型 == '右键弹起'  then
		return self._包围盒:检查点(x,y)
	end
	return ret
end

return GUI滑块类