-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-06-12 12:14:43
-- @最后修改来自: baidwwy
-- @Last Modified time: 2016-05-18 01:04:14
local __ggeGuiManager = require("__ggeguimanager__")
local GUI管理器 = {}


function GUI管理器:初始化()
	if not self.mgr then
	    self.mgr = __ggeGuiManager()
	end
	return self
end
function GUI管理器:置主控件(控件)
	self.mgr:SetRootWindow(控件:取指针())
end
function GUI管理器:取主控件()
	return require("gui控件类")(self.mgr:GetRootWindow())
end
function GUI管理器:置焦点控件(控件)
	self.mgr:SetFocusCtrl(控件:取指针())
end
function GUI管理器:取焦点控件()
	return require("gui控件类")(self.mgr:GetFocusCtrl())
end
function GUI管理器:置提示控件(控件)
	self.mgr:SetToolTipCtrl(控件:取指针())
end
function GUI管理器:取提示控件()
	return self.mgr:GetToolTipCtrl()
end
function GUI管理器:置提示时间(秒)
	self.mgr:SetToolTipDelay(秒)
end
function GUI管理器:取提示时间()
	return self.mgr:GetToolTipDelay()
end
function GUI管理器:添加模态控件(控件)
	self.mgr:AddModalWnd(控件:取指针())
end
function GUI管理器:删除模态控件(控件)
	self.mgr:RemoveModalWnd(控件:取指针())
end
function GUI管理器:删除所有模态控件()
	self.mgr:RemoveAllModalWnd()
end
function GUI管理器:更新(dt)
	self.mgr:Update(dt)
end
function GUI管理器:显示()
	self.mgr:Render()
end
return function ()
	return GUI管理器:初始化()
end