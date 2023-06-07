
local 控件类 = require("gui/控件类")
local SliderWnd = class(控件类)


function SliderWnd:子消息处理(msgType,ctrl)
	if msgType == self.常量.按钮点击 then
		local id = ctrl:取ID()
		if id == 0 then
			local 滑块 = self:取子控件_按ID(2)
			滑块:置当前值(滑块:取当前值()-1)
			self:通知父控件(self.常量.滑块移动)
		elseif id == 1 then
			local 滑块 = self:取子控件_按ID(2)
			滑块:置当前值(滑块:取当前值()+1)
			self:通知父控件(self.常量.滑块移动)
		end
	elseif msgType == self.常量.滑块移动 then
		self:取父控件():子消息处理(msgType,ctrl)
	elseif msgType == self.常量.滑块改变 then
		self:取父控件():子消息处理(msgType,ctrl)
	end
	return false
end



return GUI_创建函数(SliderWnd)