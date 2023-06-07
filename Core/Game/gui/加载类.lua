-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-06-12 12:04:49
-- @最后修改来自: baidwwy
-- @Last Modified time: 2016-05-18 09:38:59
local __ggeGuiLoader = require("__ggeguiloader__")
local GUI加载类 = class()
local ffi = require("ffi")

function GUI加载类:初始化()
	self.load = __ggeGuiLoader()
	self.Create = {}
end
function GUI加载类:添加创建函数(类名,fun)
	self.Create[类名] = fun
	self.load:AddCreateFunc(类名,tonumber(ffi.cast("intptr_t",fun)))
end
function GUI加载类:删除创建函数(类名)
	self.Create[类名] = nil
	self.load:DelCreateFunc(类名)
end
function GUI加载类:删除所有创建函数()
	self.Create = {}
	self.load:DelAllCreateFunc()
end
function GUI加载类:置资源类(res)
	self.load:SetResManager(res:取指针())
end
function GUI加载类:载入文件(文件名)
	return self.load:Load(文件名)
end
function GUI加载类:创建控件(类名)
	local ctrl = require("gui/控件类")(self.load:CreateControl(类名))
	if self.Create[类名] then
	    ctrl = ctrl:取回调()
	end
	return ctrl
end
return GUI加载类