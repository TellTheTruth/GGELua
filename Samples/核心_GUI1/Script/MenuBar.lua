local 控件类 = require("gui/控件类")
local MenuBar = class(控件类)
--菜单栏

function MenuBar:子消息处理(msgType,ctrl)
	if msgType == self.常量.鼠标碰撞 then
		--//如果正在显示子菜单，根据当前控件设置要显示的子菜单
	    if self.MenuWnd:是否可见() then
	        if self.FileMenuBtn == ctrl then
	        	self.MenuWnd:消息处理(0,3,'文件菜单')
	        elseif self.HelpMenuBtn == ctrl then
	        	self.MenuWnd:消息处理(0,3,'帮助菜单')
	        end
	    end
	elseif msgType == self.常量.按钮点击 then
	    if not self.MenuWnd:是否可见() then
	        if self.FileMenuBtn == ctrl then
	        	self.MenuWnd:消息处理(0,3,'文件菜单')
	        elseif self.HelpMenuBtn == ctrl then
	        	self.MenuWnd:消息处理(0,3,'帮助菜单')
	        end
	    end
	end
	return false
end
function MenuBar:消息处理(ctrl,msgType,msgData)
	if msgData == '初始化' then--初始化
	    self.FileMenuBtn = self:取子控件_按名称('FileMenuBtn')
	    self.HelpMenuBtn = self:取子控件_按名称('HelpMenuBtn')
	    self.MenuWnd = self:取父控件():取子控件_按名称('MenuWnd')
	    self.MenuWnd:置可见(false)
	end
	return false
end
--如果没点击到任何按钮则关闭菜单
function MenuBar:鼠标左键消息(bDown,x,y)
	self.MenuWnd:置可见(false)
end


return  GUI_创建函数(MenuBar)
