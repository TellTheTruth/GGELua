local 控件类 = require("gui/控件类")
local FuncWnd2 = class(控件类)


function FuncWnd2:子消息处理(msgType,ctrl)
	if msgType == self.常量.按钮点击 then
		if not self.editbox:是否为空() then
			for i=1,10 do
				self.listbox:添加项目("AddItem:"..i)
			end
		    self.listbox:添加项目(self.editbox:取文本())
		    self.editbox:清空()
		    self.slider:置滑块值(0,math.max(0, self.listbox:取项目总数()-self.listbox:取项目显示数()))
		    self.slider:置当前值(self.listbox:取顶端项())
		end
	elseif msgType == self.常量.滑块移动 then
		self.listbox:置顶端项(self.slider:取当前值())
	elseif msgType == self.常量.列表框滚动 or msgType == self.常量.列表框选中改变 then
		 self.slider:置当前值(self.listbox:取顶端项())
	end
end


function FuncWnd2:消息处理(ctrl,msgType,msgData)
	if msgData == "初始化" then
	    self.slider = self:取子控件_按ID(2):取子控件_按ID(2)
	    self.editbox = self:取子控件_按ID(1)
	    self.listbox = self:取子控件_按ID(0)
	end
end



return GUI_创建函数(FuncWnd2)