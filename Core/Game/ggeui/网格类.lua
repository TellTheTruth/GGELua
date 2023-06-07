--=========================================================================
local GUI网格类 = class(require("ggeui/基类"))
--=========================================================================
function GUI网格类:初始化(标记,x,y,宽度,高度)
	self._px 		= x or 0
	self._py 		= y or 0
	self._行距 		= 1
	self._列距 		= 1
	self._格子宽 	= 32
	self._格子高 	= 32
	self._行数 		= 1
	self._列数 		= 1
	self._内容  		= {}
	self._精灵 		= require("gge精灵类")()
	self._格子 		= {}
	self._包围盒:置中心(-self._px,-self._py)
end
function GUI网格类:置格子宽高(a,b)
	self._格子宽 	= a
	self._格子高 	= b
end
function GUI网格类:置行列间距(a,b)
	self._行距 		= a
	self._列距 		= b
end
function GUI网格类:置行列数(a,b)
	self._行数 		= a
	self._列数 		= b
	for h=1,self._行数 do
		for l=1,self._列数 do
			local b = require("gge包围盒")(0,0,self._格子宽,self._格子高)
			b:置中心(-((l-1)*(self._格子宽+self._列距)+self._px), -((h-1)*(self._格子高+self._行距)+self._py))
			table.insert(self._格子, b)
		end
	end
end
function GUI网格类:置内容(i,t)
	self._内容[i] 	= t
end
function GUI网格类:取格子坐标(id)
	return self._格子[id]:取坐标()
end
function GUI网格类:清空()
	self._内容 	= {}
end
function GUI网格类:_显示(a,b)

	for i,v in ipairs(self._格子) do
		if self._调试 then v:显示() end
		if self._内容[i]  then
			if tostring(self._内容[i]) == 'ggeTexture' then
			    self._精灵:置纹理(self._内容[i])
			    self._精灵:显示(v:取坐标())
			elseif self._内容[i].显示 then
			    self._内容[i]:显示(v:取坐标())
			end
			if self.子显示 then self:子显示(i,v:取坐标()) end
		end
	end
	if self._调试 then self._包围盒:显示() end
end
function GUI网格类:_消息事件(类型,x,y)

	if 类型 == '窗口移动' then
		self._x,self._y = x,y
		self._包围盒:置坐标(x,y)
		for i,v in ipairs(self._格子) do
			v:置坐标(self._x,self._y)
		end
	elseif 类型 == '鼠标移动' then
		if self:检查点(x,y) then
			self:发送消息(类型,x,y)
			for i,v in ipairs(self._格子) do
				if v:检查点(x,y) then
					if self._当前格子 ~= i then
						if self._当前格子 then self:发送消息('格子取消碰撞',self._当前格子) end
						self._当前格子 = i
					    self:发送消息('格子碰撞',i)
					end
				    return true
				end
			end
		end
		if self._当前格子 then self:发送消息('格子取消碰撞',self._当前格子);self._当前格子=nil end
	elseif 类型 == '左键按下' then
		if self:检查点(x,y) then
			self._鼠标按下 = true
			self:发送消息(类型,x,y)
			return true
		end
	elseif 类型 == '左键弹起' then
		if self._鼠标按下 then
			self._鼠标按下 = false
			self:发送消息(类型,x,y)
		end
	elseif 类型 == '右键按下' or 类型 == '右键弹起' then
		if self:检查点(x,y) then
			self:发送消息(类型,x,y)
			return true
		end
	else
		self:发送消息(类型,x,y)
	end
end
return GUI网格类