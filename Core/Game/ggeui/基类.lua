local GUI基类 = class()

function GUI基类:初始化(标记,x,y,宽度,高度)
	self._id 		= -1
	self._标记 		= 标记
	self._名称 		= 标记
	self._x 		= x or 0
	self._y 		= y or 0
	self._px 		= x or 0--偏移
	self._py 		= y or 0--当控件移动，偏移就有用
	self._宽度 		= 宽度 or 0
	self._高度 		= 高度 or 0
	self._类型 		= '控件'
	self._焦点 		= false
	self._鼠标按下 	= false
	self._可视 		= true
	self._禁止 		= false
	self._层次 		= 0
	self._加载 		= false --是否已经加载
	self._调试 		= false
	self._包围盒 	= require("gge包围盒")(self._x,self._y,self._宽度,self._高度)
end
function GUI基类:置调试模式(v)
	self._调试 =v
end
function GUI基类:置坐标(x,y)
	self._x = x
	self._y = y

	if self._fx then--是否有父窗口
		self._x,self._y = self._fx+x,self._fy+y
		self._px = x
		self._py = y
	end
	self:_消息事件('窗口移动',self._x,self._y)--告诉子控件
	self._包围盒:置坐标(self._x,self._y)
end
function GUI基类:取坐标()
	return self._x,self._y
end
function GUI基类:取坐标表()
	return require("gge坐标类")(self._x,self._y)
end
function GUI基类:置宽高(w,h)
	self._宽度 		= w
	self._高度 		= h
	self._包围盒:置宽高(w,h)
end
function GUI基类:取名称()
	return self._标记
end
function GUI基类:取类型()
	return self._类型
end
function GUI基类:置类型(v)
	self._类型 = v
end
function GUI基类:取父控件()
	return self._父控件
end
function GUI基类:取祖控件()
	if self:取父控件() then
		local 祖控件 	= self:取父控件()
		local 当前 		= self:取父控件()
	    while 当前 do
	    	当前 = 当前:取父控件()
	    	if 当前 then
	    	    祖控件 = 当前
	    	end
	    end
	    return 祖控件
	end
	return self
end
function GUI基类:是否窗口()
	if self._类型 == '窗口' then
	    return self
	end

	local 当前 		= self:取父控件()
    while 当前 do
    	if 当前._类型 == '窗口' then
    	    return 当前
    	end
    	当前 = 当前:取父控件()
    end
    return false
end
function GUI基类:置包围盒(v)
	self._包围盒 	= v
end
function GUI基类:取包围盒()
	return self._包围盒
end
function GUI基类:检查点(x,y)
	return self._包围盒:检查点(x,y)
end
function GUI基类:取层次()
	return self._层次
end
function GUI基类:置层次(v)
	self._层次 	= v
end
function GUI基类:_初始化()
	if not self._加载 then
		self._加载 	= true
		if self.初始化 then self:初始化()end
	end
end
function GUI基类:置可视(v,sub)
	if v then
		self:_初始化(sub)
	end
	if self._可视 ~= v then
		self._可视 = v
		self:_消息事件('可视事件',self._可视,self)
	end
	return self
end
function GUI基类:置禁止(v)
	-- self._焦点 		= false
	-- self._鼠标按下 	= false
	self._禁止 		= v
	self:_消息事件('禁止事件',v)
	return self
end
function GUI基类:是否禁止()
	return self._禁止
end
function GUI基类:是否可视()
	return self._可视
end
function GUI基类:是否加载()
	return self._加载
end
function GUI基类:发送消息(...)
	if self._初始化 then
		if self.消息事件 then
		    return self:消息事件(...)
		end
	end
	return false
end

return GUI基类