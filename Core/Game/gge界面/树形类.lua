local 引擎 	 = require("gge引擎")
--===========================================================================
local super = require("gge界面/列表类")
local GUI树形类 = class(super)
--===========================================================================
function GUI树形类:初始化(标记,x,y,宽度,高度)
	self._类型 		= '树形'
	self._节点内容  = {}
	self._精灵 		= require("gge精灵类")()
	self:置行距(3)
	self._层次偏移 	= 20
	self._文本偏移 	= 20
end
function GUI树形类:置层次偏移(v)
	self._层次偏移 	= v
	return self
end
function GUI树形类:置文本偏移(v)
	self._文本偏移 	= v
	return self
end
--------------------------------------------
local function 递归层数(内容,id,层数)
	if 内容[id].父索引 ~= 0 then
	    层数 = 层数 +1
	   	return 递归层数(内容,内容[id].父索引,层数)
	end
	return 层数
end
--------------------------------------------
function GUI树形类:添加(父索引,内容,颜色,附加,纹理,展开纹理)
	local t = {}
	t.颜色 		= 颜色 or 0xFFFFFFFF
	t.父索引 	= 父索引 or 0
	t.内容 		= 内容
	t.附加 		= 附加
	t.宽度 		= self._文字:取宽度(内容)
	t.纹理 		= 纹理
	t.展开纹理  = 展开纹理
	t.当前纹理 	= 纹理
	t.展开 		= false
	table.insert(self._节点内容,t)
	t.索引 		= #self._节点内容
	t.tx 		= 递归层数(self._节点内容,t.索引,0)*self._层次偏移
	t.x 		= t.tx+self._文本偏移
	t.y 		= 0
	t.列表  	= "true"
	self:_更新列表()
	return t.索引
end
function GUI树形类:置展开(id,a)
	if type(id) == 'number' then
		if self._节点内容[id] then
		    self._节点内容[id].展开 = a
		    self._节点内容[id].当前纹理 = a and self._节点内容[id].展开纹理 or self._节点内容[id].纹理
		end
	else
	    for i,v in ipairs(self._节点内容) do
	    	if v.内容 == id then
	    	    v.展开 = a
	    	    v.当前纹理 = a and v.展开纹理 or v.纹理
	    	    break
	    	end
	    end
	end

	self:_更新列表()
end
-- function GUI树形类:_取层数(id)--计算层数来计算x显示偏移
-- 	local	递归函数
-- 	local 	层数 = 0
-- 	递归函数 = function (id)
-- 		if self._节点内容[id].父索引 ~= 0 then
-- 		    层数 = 层数 +1
-- 		   	递归函数(self._节点内容[id].父索引)
-- 		end
-- 	end
-- 	递归函数(id)
-- 	return 层数
-- end
--------------------------------------------
local function 递归展开(内容,id)
	if not 内容[id].展开 then
	    return false
	elseif 内容[id].父索引 ~= 0 then
	   	return 递归展开(内容,内容[id].父索引)
	end
	return true
end
--------------------------------------------
function GUI树形类:_是否展开(id)--判断所有父层是否展开
	return 递归展开(self._节点内容,id)
end
function GUI树形类:清空()
	self._节点内容  = {}
	self:_更新列表()
end
function GUI树形类:_更新列表()
	self[super]:清空()
	local 已展开 = {}--缓存一下
	for i,v in ipairs(self._节点内容) do
		if v.父索引 == 0 or 已展开[v.父索引] or  self:_是否展开(v.父索引) then
		    已展开[v.父索引] = true
		    self:添加内容(v)
		end
	end
	self._显示数 = #self._内容
	if self._显示数 > self._可显示数 then self._显示数 = self._可显示数 end
    if self._起始显示 + self._可显示数 > #self._内容 then
        self._起始显示 = #self._内容 - self._可显示数+1
    end
    if self._起始显示 <1 then self._起始显示 = 1 end

end
function GUI树形类:_显示(x,y)
	self[super]:_显示()
	--if self._调试 then self._包围盒:显示() end
	for i=self._起始显示,self._起始显示+self._显示数-1 do
	    self._精灵:置纹理(self._内容[i].当前纹理)--:置区域(0,0,20,20)
	    self._精灵:显示(self._x+self._内容[i].tx,self._y +(i-self._起始显示)*self._行高度)
	    if  self._鼠标按下 and self._精灵:检查点(x,y) and 引擎.鼠标弹起(KEY.LBUTTON) and self._内容[i].展开纹理 then
	        self._内容[i].展开 = not self._内容[i].展开
	        self._内容[i].当前纹理 = self._内容[i].展开 and self._内容[i].展开纹理 or self._内容[i].纹理
	        if i == self._起始显示+self._显示数-1 then
	            self._起始显示 = i
	        end
	        self:_更新列表()
	        self._鼠标按下 	= false
	        break
	    end
	end
end
function GUI树形类:_子消息事件(a,b,c)
	if a=='碰撞事件' then
		local 内容 = self._内容[b]
	    self._焦点精灵:置中心(-内容.x):置区域(0,0,内容.宽度)
	elseif a=='选中项目' then
		local 内容 = self._内容[b]
	    self._选中精灵:置中心(-内容.x):置区域(0,0,内容.宽度)
	end
end
function GUI树形类:_消息事件(类型,参数)
	local x,y,滚动值 = unpack(参数)

	local ret = self[super]:_消息事件(类型,参数)
	if 类型 ==  '左键按下'and self:检查点(x,y) then
		self._鼠标按下 	= true
		return true
	elseif 类型 ==  '右键按下' or 类型 ==  '右键弹起' then
		return self:检查点(x,y)
	end
	return ret
end

return GUI树形类