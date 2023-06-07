-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2016-10-27 23:34:22
-- @最后修改来自: baidwwy
-- @Last Modified time: 2017-01-27 06:00:57
local F函数  = require("ffi函数")
local GUI输入类 	= require("gge界面/输入类")
local GUI多输入类 = class(require("gge界面/基类"))
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
function GUI多输入类:初始化(标记,x,y,宽度,高度)
	self._px 		= x or 0
	self._py 		= y or 0
	self._宽度 		= 宽度 or 200
	self._高度 		= 高度 or 200
	self._类型 		= '多输入'
	self._文字 		= require("gge文字类")()
	self._文字:置行宽(self._宽度)
	self._行距 		= 2
	self._行高 		= 16
	self._行数 		= math.floor(self._高度/16)
	self._行字数 	= math.floor(self._宽度/7)
	self._限制字数 	= self._行字数*self._行数
	self._输入 		= {}
	self._内容 		= {}--记录字符
	self._光标位置 	= 1
	self._字符总数 	= 0
	self._焦点 		= false
	self._输入列表 	= GUI输入类.列表
	self:_插入行(1,"")
end
function GUI多输入类:_插入行(位置,内容)
	local v = GUI输入类.创建(位置,self._px,self._py+(位置-1)*self._行高,self._宽度,self._行高)
	v.行号 = 位置
	v:置文本(内容)
	v:置坐标(self._x,self._y+(位置-1)*self._行高)
	v._输入列表 = self._输入
	v._子消息事件 = function (this, a,b,c)
		if a == "左键按下" then
			local 位置 = 0
			for i=1,this.行号-1 do
				位置=位置+self._输入[i]:取字符总数()
			end
		    self._光标位置 	= 位置+this:取光标位置()
		    --print(self._光标位置,this.行号,位置,this:取光标位置())
		end
	end
	table.insert(self._输入,位置,v)
end

function GUI多输入类:_更新(dt)
	if self._焦点 then
		for i,v in ipairs(self._输入) do
			v:_更新(dt)
		end
	end
end

function GUI多输入类:_显示(x,y)
	if self._调试 then self._包围盒:显示() end
	for i,v in ipairs(self._输入) do
		--if self._调试 then v._包围盒:显示() end
		v:_显示()
	end
end
function GUI多输入类:置焦点(v)
	self._焦点 	= v
	if v then
		for i,v in pairs(self._输入列表) do
			if v~=self then
			    v:置焦点(false)
			end
		end
		self._输入[#self._输入]:置光标位置():置焦点(true)
		self._光标位置 = #self._内容+1
	else
		for i,v in ipairs(self._输入) do
			v:置焦点(false)
		end
	end
	return self
end
function GUI多输入类:_子消息事件(a,b,c)
end

function GUI多输入类:取文本()
	return table.concat(self._内容)
end
function GUI多输入类:_生成文本()
	self._输入 		= {}
	self._字符总数 	= 0
	local 位置,长度,行数 = 1,0,1
	local 焦点行,光标位置 = 1,1
	for i,v in ipairs(self._内容) do
		self._字符总数 = self._字符总数+#v
		if 长度+#v == self._行字数 then
			self:_插入行(行数,table.concat(self._内容,"",位置,i))
			行数 = 行数 +1
			位置 = i+1
			长度 = 0
		elseif 长度+#v > self._行字数 then--中文
			self:_插入行(行数,table.concat(self._内容,"",位置,i-1))
			行数 = 行数 +1
			位置 = i
			长度 = #v
		else
			长度 = 长度 + #v
		end
		if i == self._光标位置-1 then
			焦点行 = 行数
		    光标位置 = i-位置+2
		end
	end
	self:_插入行(行数,table.concat(self._内容,"",位置))
	self._输入[焦点行]
		:置焦点(true)
		:置光标位置(光标位置)
end
function GUI多输入类:添加文本(str)
	if (self._字符总数 + #str) < self._限制字数  then
		for i,v in splitstr(str) do
			table.insert(self._内容,self._光标位置,v)
			self._光标位置 = self._光标位置+1
		end
		self:_生成文本()
	end
end
function GUI多输入类:置文本(v)
	if v then
		self._内容 		= {}--记录字符
		self._光标位置 	= 1
		self._字符总数 	= 0
		self:添加文本(tostring(v))
	end
	return self
end
function GUI多输入类:_消息事件(类型,参数)
	local b,c = unpack(参数)
	local x,y = b,c
	if 类型 == '输入字符' then
		if self._焦点 then
			if 引擎.按键按住(KEY.CTRL) then
				if c == 1 then -- 全选
					--self:选中全部()
				elseif c == 3 then -- 复制
					--F函数.置剪贴板(self:取选中文本())
				elseif c == 22 then --粘贴
					--self:删除选中()
					self:添加文本(F函数.取剪贴板())
				elseif c == 24 then --剪贴
					--F函数.置剪贴板(self:取选中文本())
					--self:删除选中()
				elseif c == 26 then--撤销
				end
			elseif c == 8 then--退格
				if self._选中 then
				    --self:删除选中()
				elseif self._光标位置 > 1 then
				    table.remove(self._内容,self._光标位置-1)
				    self._光标位置 = self._光标位置 -1
				    self:_生成文本()
				end
			elseif c == 13 or c ==10 then--enter
			elseif c <= 28 then --特殊
			else
				--self:删除选中()
				self:添加文本(b)
			end
			return self:发送消息(类型,b,c)
		end
		return
	elseif 类型 == '输入中文' then
		if self._焦点 then
			--self:删除选中()
			self:添加文本(b)
			self:发送消息(类型,b,c)
		end
		return
	elseif 类型 == '窗口移动' then
		self._x,self._y = x+self._px,y+self._py
		self._包围盒:置坐标(self._x,self._y)
		self:发送消息(类型,x,y)
		--return
	elseif 类型 == '左键按下' then
		if self:检查点(b,c) then
			self:置焦点(true)
		end
	elseif 类型 == '释放' then
		GUI输入类.列表[v] = nil
	end
	for i=#self._输入,1,-1 do--不能用ipairs
		if self._输入[i]:_消息事件(类型,参数) then
			return true
		end
	end
end
return GUI多输入类