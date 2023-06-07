--=========================================================================
local super = require("丰富文本类")
local GUI丰富文本 = class(require("gge界面/基类"),super)
--=========================================================================
function GUI丰富文本:初始化(标记,x,y,宽度,高度)
	self._px = x or 0
	self._py = y or 0
	--self.行间距 = 15
end
function GUI丰富文本:更新()end--覆盖
function GUI丰富文本:显示()end--覆盖
function GUI丰富文本:_更新(dt,x,y)end


function GUI丰富文本:_显示()
	self[super]:显示(self._x,self._y)
	if self._调试 then self._包围盒:显示() end
end

function GUI丰富文本:_消息事件(消息,参数)
	local x,y = unpack(参数)
	if 消息 == '窗口移动' then
		self._x,self._y = x+self._px,y+self._py
		self._包围盒:置坐标(self._x,self._y)
	elseif 消息 == '鼠标移动' then
		self[super]:更新(x,y)
	elseif 消息 == '回调碰撞' then
		self._回调标识 = (x=='' or not x) and y or x
		self:发送消息("回调碰撞",self._回调标识,y)
	elseif 消息 == '左键按下'  and x and y then
		--self.左键按下 = self:检查按钮(x,y)
		return self.左键按下 and true
	elseif 消息 == '左键弹起' and self.左键按下 then
		--if self:检查按钮(x,y)==self.左键按下 then
		--	self:发送消息("回调弹起",self.左键按下)
		--end
		self.左键按下 = nil
	end
end

return GUI丰富文本