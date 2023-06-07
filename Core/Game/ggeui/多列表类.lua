--=========================================================================
local 引擎 	 		= require("gge引擎")
local GUI列表类 	= require("ggeui/列表类")
local GUI多列表类 	= class(require("ggeui/基类"))
--=========================================================================
function GUI多列表类:初始化(标记,x,y,宽度,高度)
	self._px 		= x or 0
	self._py 		= y or 0
	self._宽度 		= 宽度 or 200
	self._高度 		= 高度 or 200
	self._列宽 		= 0
	self._列项 		= {}
	self._列数 		= 0
end
function GUI多列表类:置选中精灵(vv,i)
	if i and self._列项[i] then
	    self._列项[i]:置选中精灵(vv)
	    return true
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
function GUI多列表类:_子消息(...)
	if self._父列表.消息事件 then return self._父列表:消息事件(...) end
end
function GUI多列表类:添加列(宽度,名称,子显示)
	local 列表 = GUI列表类.创建(名称,self._列宽+self._px,self._py,宽度,self._高度)
	列表._父列表 	= self
	列表.发送消息 	= self._子消息
	列表.子显示 	= 子显示 and self._子显示 or nil

	table.insert(self._列项,列表)
	self._列宽 	= self._列宽 + 宽度
	self._列数 	= #self._列项
end
function GUI多列表类:添加行(...)
	for i,v in ipairs({...}) do
		if self._列项[i] then
		    self._列项[i]:添加(v)
		end
	end
end
function GUI多列表类:删除行(id)
	for i,v in ipairs(self._列项) do
		v:删除(id)
	end
end
function GUI多列表类:取行数()
	return self._列项[1]:取行数()
end
function GUI多列表类:取内容(h,l)
	return self._列项[l]:取内容(h)
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
function GUI多列表类:清空()
	for i,v in ipairs(self._列项) do
		v:清空()
	end
end
function GUI多列表类:_子显示(...)
	if self._父列表.子显示 then self._父列表:子显示(...) end
end
function GUI多列表类:_显示()
	for i,v in ipairs(self._列项) do
		if self._调试 then v._包围盒:显示() end
		v:_显示()
	end
end
function GUI多列表类:_消息事件(...)
	for i,v in ipairs(self._列项) do
		local r = v:_消息事件(...)
		if v:检查点(引擎.取鼠标坐标()) then
		    for ii,vv in ipairs(self._列项) do
		    	vv:_置同步信息(v:_取同步信息())
		    end
		    return true
		elseif r then
			return true
		end
	end
end

return GUI多列表类