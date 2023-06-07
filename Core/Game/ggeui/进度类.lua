--=========================================================================
local GUI进度类 = class(require("ggeui/基类"))
--=========================================================================
function GUI进度类:初始化(标记,x,y,宽度,高度)
	self._px 		= x or 0
	self._py 		= y or 0
	self._宽度 		= 宽度 or 200
	self._高度 		= 高度 or 20
	self._最大值 	= 100
	self._最小值 	= 1
	self._精灵 		= require("gge精灵类")(0,0,0,self._宽度,self._高度)
end
function GUI进度类:置纹理(v)
	self._精灵:置纹理(v)
end
function GUI进度类:置颜色(v)
	self._精灵:置颜色(v)
end
function GUI进度类:取位置()
	return  self._位置
end
function GUI进度类:置位置(v)
	self._位置 = math.floor(v)
	self._精灵:置区域(0,0,v/self._最大值*self._宽度,self._高度)
end
function GUI进度类:_显示()
	self._精灵:显示(self._x,self._y)
end
function GUI进度类:_消息事件(a,b,c)
	--print(a,b,c)
	if a == '窗口移动' then
		self._x,self._y = b+self._px,c+self._py
		self._包围盒:置坐标(self._x,self._y)
	elseif a == '右键按下' or a == '右键弹起'  then
		return self:检查点(b,c)
	end
end
return GUI进度类