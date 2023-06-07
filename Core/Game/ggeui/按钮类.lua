
--=====================================================================================
local GUI按钮类 = class(require("ggeui/基类"))
--=====================================================================================
function GUI按钮类:初始化(标记,x,y)
	self._px 		= x or 0
	self._py 		= y or 0
	self._选中 		= false
	self._状态 		= 0
	self._类型 		= '普通按钮'
	self._精灵 		= require("gge精灵类")()
end
function GUI按钮类:取精灵()
	return self._精灵
end
function GUI按钮类:置选中(v)
	if self:取类型() == '复选按钮' then
		self:_置选中(v)
	elseif self:取类型() == '单选按钮' and v and not self:是否选中() then
	    local 子控件 = self:取父控件():取子控件列表()
	    for i,v in ipairs(子控件) do
	    	if v:取类型() == '单选按钮' and v:是否选中() then
	    		v:_置选中(false);
	    		break
	    	end
	    end
	    self:_置选中(true)
	end
end
function GUI按钮类:_置选中(v)
	if self._选中 ~= v then
		self._选中 = v
		self._状态 = 0
		self:_置纹理(v and self._选中正常纹理 or self._正常纹理)
		self:发送消息('选中事件',v,self)
	end
end
function GUI按钮类:是否选中()
	return self._选中
end
function GUI按钮类:置禁止(v)
	if self._禁止 ~= v then
		self._禁止 		= v
		self._状态 		= v and -1 or 0
		self:_更新纹理()
	end
end
function GUI按钮类:置正常纹理(v)
	self._正常纹理 = v
	if tostring(v) == 'ggeSprite' then
		self._精灵 = v
	else
	    self._精灵:置纹理(v)
	end
end
function GUI按钮类:置按下纹理(v)
	self._按下纹理 = v
end
function GUI按钮类:置经过纹理(v)
	self._经过纹理 = v
end
function GUI按钮类:置禁止纹理(v)
	self._禁止纹理 = v
end
function GUI按钮类:置选中正常纹理(v)
	self._选中正常纹理 = v
end
function GUI按钮类:置选中按下纹理(v)
	self._选中按下纹理 = v
end
function GUI按钮类:置选中经过纹理(v)
	self._选中经过纹理 = v
end
function GUI按钮类:置选中禁止纹理(v)
	self._选中禁止纹理 = v
end
function GUI按钮类:_显示()
	self._精灵:显示(self._x,self._y)
	if self._调试 then self._精灵:取包围盒():显示() end
end
function GUI按钮类:检查点(x,y)
	return self._精灵:检查点(x,y)
end
function GUI按钮类:检查像素(x,y)
	return self._精灵:取像素(x,y) ~= 0
end
function GUI按钮类:_置纹理(v)
	if v then
		if tostring(v) == 'ggeSprite' then
			self._精灵 = v
		else
			self._精灵:置纹理(v)
		end
	end
end
function GUI按钮类:_更新纹理()
	local 纹理,选中纹理
	if self._状态 == 0 then
		纹理,选中纹理 = self._正常纹理,self._选中正常纹理
    elseif self._状态 == 1 then
    	纹理,选中纹理 = self._经过纹理,self._选中经过纹理
    elseif self._状态 == 2 then
    	纹理,选中纹理 = self._按下纹理,self._选中按下纹理
    elseif self._状态 == -1 then
    	纹理,选中纹理 = self._禁止纹理,self._选中禁止纹理
	end
	if self:取类型() ~= '普通按钮' and self._选中 then
		self:_置纹理(选中纹理)
	else
		self:_置纹理(纹理)
	end
end
function GUI按钮类:_消息事件(类型,x,y)
	if 类型 == '鼠标移动' then
		if self:检查点(x,y) then
			if not self._已碰撞 then
			    self._已碰撞 = true
			    self:发送消息('碰撞事件')
			end
		elseif self._已碰撞 then
			self._已碰撞 = false
			self:发送消息('取消碰撞')
		end
		if not self:是否禁止() and (not self:是否选中() or self:取类型() == '复选按钮') then
		    if self._状态 == 0 and self:检查像素(x,y) then
		        self._状态 = 1
		        self:_更新纹理()
		        self:发送消息(类型,x,y)
		        return true
		    elseif self._状态 == 1 and not self:检查像素(x,y) then
		    	self._状态 = 0
		    	self:_更新纹理()
		    end
		end
	elseif 类型 == '左键按下' then
		if self:取类型() ~= '复选按钮' and (self:是否禁止() or self:是否选中()) and self:检查像素(x,y) then
			return true
		elseif self._状态 == 1 then
			self._状态 = 2
			self:_更新纹理()
			self:发送消息(类型,x,y)
			return true
		end
	elseif 类型 == '左键弹起' then
		if self._状态 == 2 then
			self._状态 = 0
			self:_更新纹理()
			if self:检查像素(x,y) then--是否还在按钮上
				if self:取类型() == '复选按钮' then --复选型
					self:_置选中(not self:是否选中())
					self._状态 = 1
				elseif self:取类型() == '单选按钮' then --单选型
					self:置选中(true)
				else-- self:取类型() == '普通按钮' then
				    self:_置纹理(self._经过纹理)
				    self._状态 = 1
				end
				self:发送消息(类型,x,y)
				self:取祖控件():发送消息('按钮弹起',self)
			end
			return true
		end
	elseif 类型 == '窗口移动' then
		self._x,self._y = x+self._px,y+self._py
		self:发送消息(类型,x,y)
	elseif 类型 == '右键按下' or 类型 == '右键弹起' then
		if self:检查像素(x,y) then
			self:发送消息(类型,x,y)
		    return true
		end
	else
		self:发送消息(类型,x,y)
	end
	return false
end

return GUI按钮类