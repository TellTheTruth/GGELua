--=========================================================================
local 引擎 	 		= require("gge引擎")
local GUI列表类 	= require("gge界面/列表类")
local GUI多列表类 	= class(require("gge界面/基类"))
--=========================================================================
function GUI多列表类:初始化(标记,x,y,宽度,高度)
	self._px 		= x or 0
	self._py 		= y or 0
	self._宽度 		= 宽度 or 200
	self._高度 		= 高度 or 200
	self._类型 		= '多列表'
	self._列宽 		= 0
	self._列项 		= {}
	self._列数 		= 0
end
function GUI多列表类:置选中精灵(vv,i)
	if i then
		if self._列项[i] then
		    self._列项[i]:置选中精灵(vv)
		    return true
		end
	else
		for i,v in ipairs(self._列项) do
			v:置选中精灵(vv)
		end
	end
end
function GUI多列表类:置焦点精灵(...)
	for i,v in ipairs(self._列项) do
		v:置焦点精灵(...)
	end
end
function GUI多列表类:置偏移(...)
	for i,v in ipairs(self._列项) do
		v:置偏移(...)
	end
end
function GUI多列表类:添加列(宽度,名称,子显示)
	local 列表 = GUI列表类.创建(名称,self._列宽+self._px,self._py,宽度,self._高度)
	列表.发送消息 	= function (_,t,... )
		if self.消息事件 then
			if t == '碰撞事件' or t == '选中项目' or t == '双击项目' then
			    return self:消息事件(t,...)
			elseif 列表._列位置 == 1 then
				return self:消息事件(t,...)
			end
		end
	end
	if 子显示 then
	    列表.子显示 = function (i, ... )
	    	if self.子显示 then self:子显示(...) end
	    end
	end
	table.insert(self._列项,列表)
	self._列宽 	= self._列宽 + 宽度
	self._列数 	= #self._列项
	列表._列位置 = self._列数
end
function GUI多列表类:添加行(...)
	local id,t = 0,{...}
	for i=1,#t do
		if self._列项[i] then
			if type(t[i]) == 'table' then
				id = self._列项[i]:添加(unpack(t[i]))
			else
				id = self._列项[i]:添加(t[i])
			end
		end
	end
	return id
end
function GUI多列表类:删除行(id)
	for i,v in ipairs(self._列项) do
		v:删除(id)
	end
end
function GUI多列表类:取行数()
	if self._列项[1] then
	    return self._列项[1]:取行数()
	end
	return 0
end
function GUI多列表类:取文本(h,l)
	return self._列项[l]:取文本(h)
end
function GUI多列表类:置文本(h,l,t)
	self._列项[l]:置文本(h,t)
end
function GUI多列表类:取选中行()
	return self._列项[1]:取选中行()
end
function GUI多列表类:置行距(...)
	for i,v in ipairs(self._列项) do
		v:置行距(...)
	end
end
function GUI多列表类:置颜色(...)
	for i,v in ipairs(self._列项) do
		v:置颜色(...)
	end
end
function GUI多列表类:置偏移(...)
	for i,v in ipairs(self._列项) do
		v:置偏移(...)
	end
end
function GUI多列表类:置选中行(...)
	for i,v in ipairs(self._列项) do
		v:置选中行(...)
	end
end
function GUI多列表类:清空()
	for i,v in ipairs(self._列项) do
		v:清空()
	end
end
function GUI多列表类:滚动百分比(vv)
	local r
	for i,v in ipairs(self._列项) do
		r = v:滚动百分比(vv)
	end
	return r
end
function GUI多列表类:关联滑块(v)
	v:置关联(self)
	self._关联 = v
end
-- function GUI多列表类:_子显示(...)
-- 	if self.子显示 then self:子显示(...) end
-- end
function GUI多列表类:_显示()
	for i,v in ipairs(self._列项) do
		if self._调试 then v._包围盒:显示() end
		v:_显示()
	end
end
function GUI多列表类:_消息事件(...)
	local r
	for i,v in ipairs(self._列项) do
		r = v:_消息事件(...)
		if v:检查点(引擎.取鼠标坐标()) then
		    for ii,vv in ipairs(self._列项) do
		    	vv:_置同步(v)
		    end
		    break
		elseif r then
			return true
		end
	end
	return r
end

return GUI多列表类