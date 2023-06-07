--=========================================================================
local super = require("丰富文本类")
local GUI丰富文本 = class(require("ggeui/基类"),super)
--=========================================================================
function GUI丰富文本:初始化(标记,x,y,宽度,高度)
	self._px = x or 0
	self._py = y or 0
	--self.行间距 = 15
end
function GUI丰富文本:更新()--重载
end
function GUI丰富文本:显示()--重载
end
function GUI丰富文本:_更新(dt,x,y)
	--self.鼠标x,self.鼠标y = x,y
end
function GUI丰富文本:_显示()
	self:运行父函数(super,'显示',self._x,self._y)
	--self._包围盒:显示()
end

function GUI丰富文本:_消息事件(消息,x,y)
	--print(消息,x,y)
	if 消息 == '窗口移动' then
		self._x,self._y = x+self._px,y+self._py
		self._包围盒:置坐标(self._x,self._y)
	elseif 消息 == '鼠标移动' then
		self._回调标识 = nil
		self:运行父函数(super,'更新',0,x,y)
	elseif 消息 == '回调标识' then
		self._回调标识 = (x=='' or not x) and y or x
		self:发送消息("回调碰撞",self._回调标识,y)
	elseif 消息 == '左键按下' and self._回调标识 then
		self.鼠标按下 = true
		self._按下标识 = self._回调标识
		self:发送消息("回调按下",self._回调标识)
		return true
	elseif 消息 == '左键弹起' then
		self.鼠标按下 = false
		if self._按下标识 and self._回调标识 == self._按下标识 then
		    self:发送消息("回调弹起",self._回调标识)
		    return true
		end
	end
end

return GUI丰富文本