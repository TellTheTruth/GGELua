local 控件类 = require("gui/控件类")

local 登陆界面 = class(控件类)


function 登陆界面:消息处理(ctrl,msgType,msgData)
	if msgData == '初始化' then
	    self.账号输入框 = self:取子控件_按名称('账号输入框')
	    self.密码输入框 = self:取子控件_按名称('密码输入框')
	    self.选择角色界面 = 主界面:取子控件_按名称('选择角色界面')
	    self.登陆界面 = self:取父控件()
	end
	return false
end


function 登陆界面:子消息处理(msgType,ctrl)

	if msgType == self.常量.按钮点击 then
		self.登陆界面:置可见(false)
		self.选择角色界面:置可见(true)
		return true
	end
	return false
end

return GUI_创建函数(登陆界面)