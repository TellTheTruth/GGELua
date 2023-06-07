
local 控件类 = require("gui/控件类")

local MessageBox = class(控件类)

function MessageBox:初始化信息(内容,取消按钮,回调控件,来源控件)
	self:取子控件_按ID(3):置文本(内容)
	if 取消按钮 then
	    self:取子控件_按ID(0):置可见(false)
	else
		self:取子控件_按ID(1):置可见(false)
		self:取子控件_按ID(2):置可见(false)
	end
	self.回调控件 = 回调控件
	self.来源控件 = 来源控件
end
function MessageBox:子消息处理(msgType,ctrl)
	if msgType == self.常量.按钮点击 then
		if self.回调控件 then
		    local id = ctrl:取ID()
		    if id == 0 or id == 1 then
		        self.回调控件:消息处理(self.来源控件,1,'确定消息')
		    elseif id == 2 then
		    	self.回调控件:消息处理(self.来源控件,2,'取消消息')
		    end
		end

		self:释放()--手动创建的控件才要释放
		return true
	end
	return false
end
function __创建消息框(内容,取消按钮,回调控件,来源控件)
	local msgbox = gui:创建控件("MessageBox")--手动创建
	msgbox:初始化信息(内容,取消按钮,回调控件,来源控件)
	gui管理:添加模态控件(msgbox)
	return msgbox
end


return GUI_创建函数(MessageBox)