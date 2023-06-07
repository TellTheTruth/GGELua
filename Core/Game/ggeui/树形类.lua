local 引擎 	 = require("gge引擎")
--===========================================================================
local super = require("ggeui/列表类")
local GUI树形类 = class(super)
--===========================================================================
function GUI树形类:初始化(标记,x,y,宽度,高度)
	self._节点内容  = {}
	self._精灵 		= require("gge精灵类")()
	self:置行距(3)
end
function GUI树形类:添加(父索引,内容,纹理,展开纹理)
	local t = {}
	t.颜色 		= 0xFFFFFFFF
	t.父索引 	= 父索引 or 0
	t.内容 		= 内容
	t.纹理 		= 纹理
	t.展开纹理  = 展开纹理
	t.当前纹理 	= 纹理
	t.展开 		= false
	table.insert(self._节点内容,t)
	t.索引 		= #self._节点内容
	t.tx 		= self:_取层数(t.索引)*20
	t.x 		= 20 +t.tx
	t.y 		= 0
	self:_更新列表()
	return t.索引
end
function GUI树形类:_取层数(id)--计算层数来计算x显示偏移
	local	递归函数
	local 	层数 = 0
	递归函数 = function (id)
		if self._节点内容[id].父索引 ~= 0 then
		    层数 = 层数 +1
		   	递归函数(self._节点内容[id].父索引)
		end
	end
	递归函数(id)
	return 层数
end
function GUI树形类:_是否展开(id)--判断所有父层是否展开
	local 递归函数
	local 是否展开 = true
	递归函数 = function (id)
		if not self._节点内容[id].展开 then
		    是否展开 =  false
		end
		if 是否展开 and self._节点内容[id].父索引 ~= 0 then
		   	递归函数(self._节点内容[id].父索引)
		end
	end
	递归函数(id)
	return 是否展开
end
function GUI树形类:_更新列表()
	self._显示数 = 0
	self._内容 = {}
	for i,v in ipairs(self._节点内容) do
		if v.父索引 == 0 or self:_是否展开(v.父索引) then
		    table.insert(self._内容,v)
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
	self:运行父函数(super,'_显示')
	--self._包围盒:显示()
	for i=self._起始显示,self._起始显示+self._显示数-1 do
	    self._精灵:置纹理(self._内容[i].当前纹理):置区域(0,0,20,20)
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
function GUI树形类:_消息事件(a,x,y,滚动值)
	local ret = self:运行父函数(super,'_消息事件',a,x,y,滚动值)
	if a ==  '左键按下'and self:检查点(x,y) then
		self._鼠标按下 	= true
		return true
	elseif a ==  '右键按下' or a ==  '右键弹起' then
		return self:检查点(x,y)
	end
	return ret
end

return GUI树形类