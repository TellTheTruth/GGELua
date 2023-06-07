local 控件类 = require("gui/控件类")
local 选择事件 = class(控件类)


function 选择事件:消息处理(ctrl,msgType,msgData)
	if msgData == '初始化' then
	    self.登陆界面 = 主界面:取子控件_按名称('登陆界面')
	    self.选择角色界面 = self:取父控件()
	end
	return false
end


function 选择事件:子消息处理(msgType,ctrl)
	if msgType == self.常量.按钮点击 then
		if ctrl:取名称() == '返回' then
			self.登陆界面:置可见(true)
			self.选择角色界面:置可见(false)
		end
	end
end



return GUI_创建函数(选择事件)