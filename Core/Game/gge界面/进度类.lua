--=========================================================================
local GUI进度类 = class(require("gge界面/基类"))
--=========================================================================
function GUI进度类:初始化(标记,x,y,宽度,高度)
	self._px 		= x or 0
	self._py 		= y or 0
	self._宽度 		= 宽度 or 200
	self._高度 		= 高度 or 20
	self._类型 		= '进度'
	self._最大值 	= 100
	self._最小值 	= 1
	self._精灵 		= require("gge精灵类")(0,0,0,self._宽度,self._高度)
	self._位置 		= 0

end
function GUI进度类:置纹理(v)
	self._精灵:置纹理(v)
	self._精灵:置区域(0,0,self._位置/self._最大值*self._宽度,self._高度)
end
function GUI进度类:置颜色(v)
	self._精灵:置颜色(v)
end
function GUI进度类:取位置()
	return  self._位置
end
function GUI进度类:置位置(v)
	self._位置 = v>self._最大值 and self._最大值 or math.floor(v)
	self._位置 = v<self._最小值 and self._最小值 or self._位置
	self._精灵:置区域(0,0,self._位置/self._最大值*self._宽度,self._高度)
end
function GUI进度类:_显示()
	self._精灵:显示(self._x,self._y)
	--self._包围盒:显示()
end
function GUI进度类:_消息事件(类型,参数)
	local x,y = unpack(参数)

	if 类型 == '鼠标移动' then
		if self:检查点(x,y) then
			if not self._已碰撞 then
			    self._已碰撞 = true
			    self:发送消息('碰撞事件',x,y)
			end
		elseif self._已碰撞 then
			self._已碰撞 = false
			self:发送消息('取消碰撞',x,y)
		end
	elseif 类型 == '窗口移动' then
		self._x,self._y = x+self._px,y+self._py
		self._包围盒:置坐标(self._x,self._y)
	elseif 类型 == '右键按下' or 类型 == '右键弹起'  then
		if self:检查点(x,y) then
			self:发送消息(类型)
		    return true
		end
	end
end
return GUI进度类