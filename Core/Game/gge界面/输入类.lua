-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2016-04-23 08:46:06
-- @最后修改来自: baidwwy
-- @Last Modified time: 2017-01-21 08:55:32
--=====================================================================================
local 引擎 	 = require("gge引擎")
local F函数  = require("ffi函数")
local GUI输入类 = class(require("gge界面/基类"))
rawset(GUI输入类, '列表', {})

--=====================================================================================
local function splitstr(str)
	local i = 0
	local ascii = 0
	return function ()
		i = i+1
		ascii = string.byte(str, i)
		if ascii then
			if ascii < 127 then
				return 1,string.sub(str, i, i)
			else
			    i = i+1
			    return 2,string.sub(str, i-1, i)
			end
		else
		    return nil
		end
	end
end
--泛型分割文本
-- for i,v in splitstr("table_name测试") do
-- 	print(i,v)
-- end
function GUI输入类:初始化(标记,x,y,宽度,高度)
	self._px 		= x or 0
	self._py 		= y or 0
	self._宽度 		= 宽度 or 200
	self._高度 		= 高度 or 16
	self._类型 		= '输入'
	self._文字 		= require("gge文字类")()
	self._文字大小 	= self._文字:取大小()--中文
	self._字符大小 	= math.ceil(self._文字大小/2)--英文
	self._光标 		= require("gge精灵类")(0,0,0,2,self._高度):置颜色(0xFFFF0000)
	self._选中精灵 	= require("gge精灵类")(0,0,0,0,self._高度):置颜色(0xFF0000FF)
	self._选中 		= false --是否选中文本
	self._按下偏移 	= 0
	self._按下位置 	= 0
	self._闪烁间隔 	= 0.6
	self._闪烁计时 	= 0

	self._光标可视 	= false
	self._内容 		= {}--记录字符
	self._内容长度 	= {}--记录字符长度
	self._字符总数 	= 0 --记录限制字数
	--self._最大字符数 = math.floor(self._宽度/(self._文字大小/2))
	self._长度 		= 0 --光标偏移
	self._限制字数 	= 150

	self._光标偏移 	= 0
	self._光标位置 	= 1
	self._起始位置 	= 1--超过框宽度
	self._结束位置  = 1
	self._显示内容 	= ""

	self._颜色 		= 0xFFFFFFFF
	self._输入模式 	= 0
	self._焦点 		= false
	self._密码符号 	= "*"
	self._输入列表 	= GUI输入类.列表
end
function GUI输入类:取文字()
	return self._文字
end
function GUI输入类:置文字(v)
	self._文字 = v
	self._文字大小 	= self._文字:取大小()
	self._字符大小 	= math.ceil(self._文字大小/2)
	return self
end
function GUI输入类:取光标位置()
	return self._光标位置
end
function GUI输入类:取字符总数()
	return #self._内容
end
function GUI输入类:置光标位置(i)
	if not i or i>#self._内容+1 then
	    i = #self._内容+1
	end
	self._光标位置 	= i
	self._光标偏移 	= self:_生成偏移()
	return self
end
function GUI输入类:取光标偏移()
	return self._光标偏移
end
function GUI输入类:取光标精灵()
	return self._光标
end
function GUI输入类:置光标精灵(v)
	self._光标 = v
	return self
end
function GUI输入类:取选中精灵()
	return self._选中精灵
end
function GUI输入类:置选中精灵(v)
	self._选中精灵 = v
	return self
end
function GUI输入类:置正常模式()
	self._输入模式 = 0
	return self
end
function GUI输入类:置密码模式(v)
	self._输入模式 = bit.bxor(self._输入模式,1)
	self._密码符号 = v or "*"
	return self
end
function GUI输入类:置数字模式()
	self._输入模式 = bit.bxor(self._输入模式,2)
	return self
end
function GUI输入类:置英文模式()
	self._输入模式 = bit.bxor(self._输入模式,4)
	return self
end
function GUI输入类:置小数模式()
	self._输入模式 = bit.bxor(self._输入模式,2)
	self._输入模式 = bit.bxor(self._输入模式,8)
	return self
end
function GUI输入类:置限制字数(v)
	self._限制字数 = v
	return self
end
-----------------------------------------------------------
function GUI输入类:置焦点(v)
	self._焦点 	= v
	if v then
		for i,v in pairs(self._输入列表) do
			if v~=self then
			    v:置焦点(false)
			end
		end
		self._光标可视 	= true
		self:_子消息事件('获得焦点')
	else
		self._光标可视 	= false
		self._选中 		= false
		self._选中精灵:置区域(0,0,0,self._高度)
		self:_子消息事件('失去焦点')
	end
	return self
end
function GUI输入类:添加文本(str,p)
	if (self._字符总数 + #str) < self._限制字数  then
		for i,v in splitstr(str) do
			table.insert(self._内容,self._光标位置,v)
			table.insert(self._内容长度 ,self._光标位置,self._字符大小*i)
			self._光标位置 = self._光标位置+1
		end
		self:_生成文本()
	end
end

function GUI输入类:置文本(v)
	if v then
		self._内容 = {}
		self._内容长度 = {}
		self._选中 		= false
		self._选中精灵:置区域(0,0,0,0)
		self._起始位置 = 1
		self._光标位置 = 1
		self._字符总数 = 0
		self:添加文本(tostring(v))
	end
	return self
end
function GUI输入类:取文本()
	return table.concat(self._内容)
end
function GUI输入类:取选中文本()
	if self._按下位置 > self._光标位置 then
	    self._按下位置,self._光标位置 = self._光标位置,self._按下位置
	end
	return table.concat(self._内容,nil,self._按下位置,self._光标位置-1)
end
function GUI输入类:取左边文本()
	return table.concat(self._内容,nil,1,self._光标位置-1)
end
function GUI输入类:取右边文本()
	return table.concat(self._内容,nil,self._光标位置)
end
function GUI输入类:选中左边()
	self._按下偏移 = self._光标偏移
	self._按下位置 = self._光标位置
	self:_更新位置(-1)
	self._选中精灵:置区域(0,0,self._光标偏移-self._按下偏移,self._高度)--精灵区域可以负数
	self._选中 =true
end
function GUI输入类:选中右边()
	self._按下偏移 = self._光标偏移
	self._按下位置 = self._光标位置
	self:_更新位置(self._宽度+1)
	self._选中精灵:置区域(0,0,self._光标偏移-self._按下偏移,self._高度)--精灵区域可以负数
	self._选中 =true
end
function GUI输入类:选中全部()
	self._光标偏移 = 0
	self._光标位置 = 1
	self._按下偏移 = self._光标偏移
	self._按下位置 = self._光标位置
	self:选中右边()
	self._选中 =true
end

function GUI输入类:_更新(dt,x,y)
	if not self._禁止 then
		if self._焦点 then--光标闪烁计算
			self._闪烁计时 = self._闪烁计时 +dt
			if self._闪烁计时 >= self._闪烁间隔 then
				self._闪烁计时  = 0
			    self._光标可视 = not self._光标可视
			end
		end
	end
end
function GUI输入类:_显示(x,y)
	self._选中精灵:显示(self._x+self._按下偏移,self._y)

	self._文字:置颜色(self._颜色):显示(self._x,self._y,self._显示内容)
	if self._调试 then self._包围盒:显示() end
	if self._光标可视 then
	    self._光标:显示(self._x+self._光标偏移,self._y)
	end
end
function GUI输入类:_生成偏移()--光标偏移宽度
	local 长度 = 0
    for i=self._起始位置,self._光标位置-1 do
    	长度 = 长度 + self._内容长度[i]
    end
    return 长度
end
function GUI输入类:_生成显示(文本)
    if bit.band(self._输入模式,1) == 1 then--密码模式
    	return string.rep(self._密码符号, #文本)
    end
    return 文本
end
function GUI输入类:_生成右边()--计算从尾部倒显
	local 长度 = 0
	for i=#self._内容,1,-1 do
		长度 = 长度 +self._内容长度[i]
    	if 长度>self._宽度 then
    		self._起始位置 	= i+1
    		self._结束位置 	= #self._内容
    		self._显示内容 	= self:_生成显示(table.concat(self._内容,nil,self._起始位置,self._结束位置))
    		self._长度 		= self._文字:取宽度(self._显示内容)
    		self._光标偏移 	= self:_生成偏移()
    	    break
    	end
	end
end
function GUI输入类:_生成文本() -- 生成用于显示的文本
    self._显示内容  = self:_生成显示(table.concat(self._内容))
    self._长度 		= self._文字:取宽度(self._显示内容)
    self._字符总数 	= #self._显示内容 -- self._长度/(self._文字大小/2)

    if self._起始位置 > self._光标位置 then--头部删除
    	if self._起始位置 >6 then
    	    self._起始位置 = self._起始位置 -6
    	else
    		self._起始位置 = 1
    	end
    end
    self._结束位置 	= #self._内容
    if self._长度 > self._宽度 then -- 当内容超过控件宽度时
		local 长度 = self:_生成偏移()
    	if 长度>self._宽度 then--显示位置 左边变动
    		self:_生成右边()
    	else
    		长度 = 0
	        for i=self._起始位置,#self._内容 do--显示位置 右边变动(输入或删除)
	        	长度 = 长度 +self._内容长度[i]
	        	if 长度>self._宽度 then
	        		self._结束位置 	= i-1
	        		self._显示内容 	= self:_生成显示(table.concat(self._内容,nil,self._起始位置,self._结束位置))
	        		self._长度 		= self._文字:取宽度(self._显示内容)
	        		self._光标偏移 	= self:_生成偏移()
	        	    return
	        	end
	        end
	        if 长度<self._宽度 then--尾部显示到底(向左变动)
	        	self:_生成右边()
	        end
    	end
    else
        self._起始位置 = 1
        self._光标偏移 	= self:_生成偏移()
    end
end
function GUI输入类:_更新位置(目标长度)--更新鼠标当前位置
	local 长度 	= 0
	if 目标长度< 0 and self._起始位置 >1  then--向左到底拖动(内容超过编辑框)
		for i=1,self._起始位置-1 do
			长度 = 长度 + self._内容长度[i]
		end
		self._按下偏移 = self._按下偏移 + 长度
		if self._按下偏移 > self._宽度 then--如果选中区域过大
		    self._按下偏移 = self._宽度
		end
		self._起始位置 = 1
		self._光标位置 = 1
		self:_生成文本()
	elseif 目标长度 > self._宽度 and self._结束位置 < #self._内容 then--向右到底拖动(内容超过编辑框)
		for i=self._结束位置,#self._内容 do
			长度 = 长度 + self._内容长度[i]
		end
		self._按下偏移 = self._按下偏移 - 长度
		if self._按下偏移 < 0 then--如果选中区域过大
		    self._按下偏移 = 0
		end
		self._起始位置 = #self._内容
		self._光标位置 = #self._内容+1
		self:_生成文本()
	elseif 目标长度<=4 then--正常最左
	    self._光标偏移 = 0
	    self._光标位置 = self._起始位置
	else
		local n 	= 0
		for i=self._起始位置,#self._内容 do--循环记录表，查看位置
			local v = self._内容长度[i]
			长度 	= 长度 + v
			n 		= n+1
			if 长度+v/2 >= 目标长度 then
			    self._光标偏移 = 长度
			    self._光标位置 = n+self._起始位置
			    return
			end
		end
		self._光标偏移 = self._长度
		self._光标位置 = #self._内容+1
	end
end
function GUI输入类:删除选中()--删除拖选中的文本
	if self._选中 then
		local 数量 		= math.abs(self._光标位置 - self._按下位置)
		if self._光标位置 > self._按下位置 then--如果是从左向右拖选
			self._光标位置 = self._按下位置
			--self._光标偏移 = self._按下偏移
		end
		for i=1,数量 do
		    table.remove(self._内容,self._光标位置)
		    table.remove(self._内容长度,self._光标位置)
		end
		self._选中 = false
		self._选中精灵:置区域(0,0,0,self._高度)
		self:_生成文本()
	end
end

function GUI输入类:_模式限制(c)
	--输入数字，并且不是普通模式，并且没有启动数字模式
	if c >=48 and c<=57  and bit.band(self._输入模式,2) == 2 then -- 数字模式
	    return true
	elseif c==46 and bit.band(self._输入模式,8) == 8 then--46=小数点
		return true
	elseif c >=32 and c<=126 and bit.band(self._输入模式,4) == 4 then -- 英文模式(全键盘)
	    return true
	elseif self._输入模式 <2 then--1是密码
		return true
	end
	return false
end
function GUI输入类:_消息事件(类型,参数)
	local b,c = unpack(参数)
	local x,y = b,c

	if 类型 == '输入字符' then
		if self._焦点 then
			if 引擎.按键按住(KEY.CTRL) then
				--print(c)
				if c == 1 then -- 全选
					self:选中全部()
				elseif c == 3 then -- 复制
					if bit.band(self._输入模式,1) ~= 1 then--密码模式
						F函数.置剪贴板(self:取选中文本())
					end
				elseif c == 22 then --粘贴
					self:删除选中()
					self:添加文本(F函数.取剪贴板())
				elseif c == 24 then --剪贴
					if bit.band(self._输入模式,1) ~= 1 then--密码模式
						F函数.置剪贴板(self:取选中文本())
						self:删除选中()
					end
				elseif c == 26 then--撤销
				end
			elseif c == 8 then--退格
				if self._选中 then
				    self:删除选中()
				elseif self._光标位置 > 1 then
				    table.remove(self._内容,self._光标位置-1)
				    table.remove(self._内容长度,self._光标位置-1)
				    self._光标位置 = self._光标位置 -1
				    self:_生成文本()
				    self._光标可视 = true
				end
			elseif c == 13 or c ==10 then--enter
			elseif c <= 28 then --特殊
			elseif self:_模式限制(c) then
				self:删除选中()
				self:添加文本(b)
			end
			return self:发送消息(类型,x,y)
		end
	elseif 类型 == '输入中文' then
		if self._焦点 and self:_模式限制(c)then
			self:删除选中()
			self:添加文本(b)
			self:发送消息(类型,x,y)
		end
	elseif 类型 == '按键按下' then
		if self._焦点 then
			if b == KEY.LEFT then
				if self._光标位置 >1 then
					self._光标位置 = self._光标位置 -1
					self._光标偏移 = self:_生成偏移()
					if self._光标位置<self._起始位置 then
					    self:_生成文本()
					end
					self._光标可视 = true
				end
			elseif  b == KEY.RIGHT then
				if self._光标位置 <= #self._内容 then
					self._光标位置 = self._光标位置 +1
					self._光标偏移 = self:_生成偏移()
					if self._光标偏移 > self._长度 then
						self._起始位置 = self._起始位置+1
					    self:_生成文本()
					end
					self._光标可视 = true
				end
			elseif KEY.PGUP then
			elseif KEY.PGDN then
			elseif KEY.HOME then
			elseif KEY.END then
			elseif KEY.INSERT then
			elseif KEY.DELETE then
			end
			self:发送消息(类型,b)
		end
	elseif 类型 == '按键弹起' then
		if self._焦点 then
			self:发送消息(类型,b)
		end
	elseif 类型 == '按键按住' then
		-- if self._焦点 then
		-- 	if b == KEY.LEFT then
		-- 		self:_消息事件('按键按下',b,c)
		-- 	elseif KEY.RIGHT then
		-- 		self:_消息事件('按键按下',b,c)
		-- 	end
		-- end
	elseif 类型 == '鼠标移动' then
		if self:检查点(x,y) then
			if not self._已碰撞 then
			    self._已碰撞 = true
			    self:发送消息('碰撞事件')
			end
		elseif self._已碰撞 then
			self._已碰撞 = false
			self:发送消息('取消碰撞')
		end
		if self._鼠标按下 then
			self:_更新位置(x - self._x)
			self._选中精灵:置区域(0,0,self._光标偏移-self._按下偏移,self._高度)--精灵区域可以负数
		end
		if self:检查点(x,y) then self:发送消息(类型,x,y);return true end
	elseif 类型 == '左键按下' then
		if self:检查点(x,y) then
			self:_更新位置(x - self._x)
			self._鼠标按下 = true
			self._按下偏移 = self._光标偏移
			self._按下位置 = self._光标位置
			self._选中精灵:置区域(0,0,0,self._高度)
			self:置焦点(true)
			self:_子消息事件(类型,x,y)
			self:发送消息(类型,x,y)
			return true
		end
	elseif 类型 == '左键弹起' then
		if self._鼠标按下 then
			self._鼠标按下 = false
			self._选中 = (self._光标位置-self._按下位置 ~= 0)
		end
		if self:检查点(x,y) then self:发送消息(类型,x,y);return true end
	elseif 类型 == '窗口移动' then
		self._x,self._y = x+self._px,y+self._py
		self._包围盒:置坐标(self._x,self._y)
		self:发送消息(类型,x,y)
	elseif 类型 == '右键按下' or 类型 == '右键弹起'  then
		if self:检查点(x,y) then
		    return true
		end
	elseif 类型 == '释放' then
		GUI输入类.列表[self] = nil
	else
		self:发送消息(类型,x,y)
	end

end


return GUI输入类