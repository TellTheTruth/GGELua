local 控件类 = require("gui/控件类")

local MenuWnd = class(控件类)
--//菜单窗口
function MenuWnd:子消息处理(msgType,ctrl)
	if msgType == self.常量.按钮点击 then
	    if ctrl:取父控件() == self.FileMenuWnd then
	        local id = ctrl:取ID()
	        if id == 0 then
	        	__创建消息框('#p1选中“文件”菜单！')
	        elseif id ==1 then
	        	__创建消息框('#p1选中“保存”菜单！')
	        elseif id ==2 then
	        	__创建消息框('#p1选中“另存为”菜单！')
	        elseif id ==3 then
	        	__创建消息框('#p1确定要退出吗？',true,self,ctrl)
	        end
	    elseif ctrl:取父控件() == self.HelpMenuWnd then
	    	__创建消息框('#p1Galaxy2D Game Engine For LUA\nGUI演示程序')
	    end
	    self:置可见(false)
	    return true
	end
end
function MenuWnd:消息处理(ctrl,msgType,msgData)
	if msgData == '初始化' then
	    self.FileMenuWnd = self:取子控件_按名称('FileMenuWnd')
	    self.HelpMenuWnd = self:取子控件_按名称('HelpMenuWnd')
	    self.FileMenuWnd:置可见(false)
	    self.HelpMenuWnd:置可见(false)
	elseif msgType == 3 then
		if msgData == "文件菜单" then
		    self.FileMenuWnd:置可见(true)
		    self.HelpMenuWnd:置可见(false)
		elseif msgData == "帮助菜单" then
			self.FileMenuWnd:置可见(false)
			self.HelpMenuWnd:置可见(true)
		end
		self:置可见(true)
	elseif msgData == '确定消息' then
		if ctrl:取父控件() == self.FileMenuWnd and ctrl:取ID() == 3 then
			引擎.关闭()
		end
		return true
	end
	return false
end
function MenuWnd:鼠标左键消息(bDown,x,y)
	self:置可见(false)
end

return GUI_创建函数(MenuWnd)
