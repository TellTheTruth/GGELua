local 控件类 = require("gui/控件类")

local DragArea = class(控件类)
--拖动区域
function DragArea:鼠标左键消息(bDown,x,y)
	self.bDown = bDown
	self.x = x
	self.y = y
end


function DragArea:鼠标移动消息(x,y)
	local 父控件 = self:取父控件()
	if self.bDown and 父控件:是否可用() then
	    local fx,fy = 父控件:取坐标()
	    父控件:置坐标(fx+(x-self.x),fy+(y-self.y))
		self.x = x
		self.y = y
	end
end


return GUI_创建函数(DragArea)