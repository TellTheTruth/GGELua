local GUI基类  		= require("gge界面/基类")
local GUI按钮类  	= require("gge界面/按钮类")
local GUI列表类 	= require("gge界面/列表类")
local GUI多列表类 	= require("gge界面/多列表类")
local GUI滑块类 	= require("gge界面/滑块类")
local GUI进度类		= require("gge界面/进度类")
local GUI丰富文本 	= require("gge界面/丰富文本")
local GUI树形类 	= require("gge界面/树形类")
local GUI自适应类 	= require("gge界面/自适应类")
local GUI网格类 	= require("gge界面/网格类")
local GUI输入类 	= require("gge界面/输入类")
local GUI多输入类 	= require("gge界面/多输入类")

local GUI控件类

--======================================================================--
local GUI创建基类 = class()

function GUI创建基类:初始化()
	self._子控件 		= {}
end
function GUI创建基类:取子控件(名称)
	return self._子控件[名称]
end
function GUI创建基类:取子控件列表()
	return self._子控件
end
function GUI创建基类:取底层控件()
	return self._子控件[1]
end
function GUI创建基类:取顶层控件()
	return self._子控件[#self._子控件]
end
function GUI创建基类:排序()
	table.sort(self._子控件,function (a,b)
		return a._层次 < b._层次
	end)
end
function GUI创建基类:创建按钮(名称,...)
	if self._子控件[名称] then error(名称..":此按钮已存在，不能重复创建.")end
	local 对象 				= GUI按钮类.创建(名称,...)--基类
	对象._根控件 			= self._根控件
	对象._父控件 			= self
	对象._层次 				= #self._子控件
	self._子控件[名称] 		= 对象
	table.insert(self._子控件, 对象)
	return 对象
end
function GUI创建基类:创建复选按钮(名称,...)
	local 对象 		= self:创建按钮(名称,...)
	对象._类型 		= '复选按钮'
	return 对象
end
function GUI创建基类:创建单选按钮(名称,...)
	local 对象 		= self:创建按钮(名称,...)
	对象._类型 		= '单选按钮'
	return 对象
end
function GUI创建基类:创建控件(名称,...)
	if self._子控件[名称] then error(名称..":此控件已存在，不能重复创建.")end
	local 对象 				= GUI控件类.创建(名称,...)
	对象._根控件 			= self._根控件
	对象._父控件 			= self
	对象._层次 				= #self._子控件
	self._子控件[名称] 		= 对象
    table.insert(self._子控件, 对象)
	return 对象
end
function GUI创建基类:创建窗口(名称,...)
	local 对象 		= self:创建控件(名称,...)
	对象._类型 		= '窗口'
	return 对象
end
function GUI创建基类:创建输入(名称,...)
	if self._子控件[名称] then error(名称..":此输入已存在，不能重复创建.")end
	local 对象 				= GUI输入类.创建(名称,...)
	对象._根控件 			= self._根控件
	对象._父控件 			= self
	对象._层次 				= #self._子控件
	self._子控件[名称] 		= 对象
	GUI输入类.列表[对象] 	= 对象
    table.insert(self._子控件, 对象)
	return 对象
end
function GUI创建基类:创建多输入(名称,...)
	if self._子控件[名称] then error(名称..":此输入已存在，不能重复创建.")end
	local 对象 				= GUI多输入类.创建(名称,...)
	对象._根控件 			= self._根控件
	对象._父控件 			= self
	对象._层次 				= #self._子控件
	self._子控件[名称] 		= 对象
	GUI输入类.列表[对象] 	= 对象
	--table.insert(GUI输入类.列表, 对象)
    table.insert(self._子控件, 对象)
	return 对象
end
function GUI创建基类:创建丰富文本(名称,...)
	if self._子控件[名称] then error(名称..":此丰富文本已存在，不能重复创建.")end
	local 对象 				= GUI丰富文本.创建(名称,...)
	对象._根控件 			= self._根控件
	对象._父控件 			= self
	对象._层次 				= #self._子控件
	self._子控件[名称] 		= 对象
    table.insert(self._子控件, 对象)
	return 对象
end
function GUI创建基类:创建竖形滑块(名称,...)
	if self._子控件[名称] then error(名称..":此滑块已存在，不能重复创建.")end
	local 对象 				= GUI滑块类.创建(名称,...)
	对象._根控件 			= self._根控件
	对象._父控件 			= self
	对象._层次 				= #self._子控件
	self._子控件[名称] 		= 对象
    table.insert(self._子控件, 对象)
	return 对象
end
function GUI创建基类:创建横形滑块(名称,...)
	local 对象 				= self:创建竖形滑块(名称,...)
	对象._类型 				= '横形滑块'
	return 对象
end
function GUI创建基类:创建列表(名称,...)
	if self._子控件[名称] then error(名称..":此列表已存在，不能重复创建.")end
	local 对象 				= GUI列表类.创建(名称,...)
	对象._根控件 			= self._根控件
	对象._父控件 			= self
	对象._层次 				= #self._子控件
	self._子控件[名称] 		= 对象
    table.insert(self._子控件, 对象)
	return 对象
end
function GUI创建基类:创建多列表(名称,...)
	if self._子控件[名称] then error(名称..":此多列表已存在，不能重复创建.")end
	local 对象 				= GUI多列表类.创建(名称,...)
	对象._根控件 			= self._根控件
	对象._父控件 			= self
	对象._层次 				= #self._子控件
	self._子控件[名称] 		= 对象
    table.insert(self._子控件, 对象)
	return 对象
end
function GUI创建基类:创建进度(名称,...)
	if self._子控件[名称] then error(名称..":此进度已存在，不能重复创建.")end
	local 对象 				= GUI进度类.创建(名称,...)
	对象._根控件 			= self._根控件
	对象._父控件 			= self
	对象._层次 				= #self._子控件
	self._子控件[名称] 		= 对象
    table.insert(self._子控件, 对象)
	return 对象
end
function GUI创建基类:创建树形(名称,...)
	if self._子控件[名称] then error(名称..":此树形已存在，不能重复创建.")end
	local 对象 				= GUI树形类.创建(名称,...)
	对象._根控件 			= self._根控件
	对象._父控件 			= self
	对象._层次 				= #self._子控件
	self._子控件[名称] 		= 对象
    table.insert(self._子控件, 对象)
	return 对象
end
function GUI创建基类:创建自适应(名称,...)
	if self._子控件[名称] then error(名称..":此自适应已存在，不能重复创建.")end
	local 对象 				= GUI自适应类.创建(名称,...)
	对象._根控件 			= self._根控件
	对象._父控件 			= self
	对象._层次 				= #self._子控件
	self._子控件[名称] 		= 对象
    table.insert(self._子控件, 对象)
	return 对象
end
function GUI创建基类:创建网格(名称,...)
	if self._子控件[名称] then error(名称..":此网格已存在，不能重复创建.")end
	local 对象 				= GUI网格类.创建(名称,...)
	对象._根控件 			= self._根控件
	对象._父控件 			= self
	对象._层次 				= #self._子控件
	self._子控件[名称] 		= 对象
    table.insert(self._子控件, 对象)
	return 对象
end
--======================================================================--
--======================================================================--
--======================================================================--
--======================================================================--
GUI控件类 = class(GUI基类,GUI创建基类)

function GUI控件类:初始化(标记,x,y)
	self._px 		= x or 0
	self._py 		= y or 0
	self._精灵 		= require("gge精灵类")()
end
function GUI控件类:_更新(dt,x,y)
	--if self.更新 then  self:更新(dt,x,y)end
	if self:是否加载() and self:是否可视() then
		if self._鼠标按下 and 引擎.鼠标弹起(KEY.LBUTTON) then
		    self._鼠标按下 = false
		end
		for i,v in ipairs(self._子控件) do
			if v:是否加载() and v:是否可视() then
				if v._更新 then v:_更新(dt,x,y) end
				if v.更新 then v:更新(dt,x,y) end
			end
		end
	end
end
function GUI控件类:置纹理(v)
	if tostring(v)=='ggeTexture' then
		self._精灵:置纹理(v)
	else
	    self._精灵 = v
	end
	self._包围盒 = self._精灵:取包围盒()
end
function GUI控件类:检查像素(x,y)
	return self._精灵:取像素(x,y) ~= 0
end
function GUI控件类:取精灵()
	return self._精灵
end
function GUI控件类:_显示(x,y)
	if self:是否加载() and self:是否可视() then
		self._精灵:显示(self._x,self._y)
		for k,v in ipairs(self._子控件) do
			if v:是否加载() and v:是否可视() then
				if v.底显示 then v:底显示(v._x,v._y,x,y)end
			    if v._显示 	then v:_显示(x,y) end
			    if v.显示 	then v:显示(v._x,v._y,x,y)  end
			end
		end
		if self._调试 then self._包围盒:显示() end
	end
end
function GUI控件类:_初始化(sub)
	self[GUI基类]:_初始化()
	if sub then--初始化所有子控件
		for k,v in ipairs(self._子控件) do
			v:_初始化(sub)
		end
	end
end
function GUI控件类:置可视(v,sub)
	self[GUI基类]:置可视(v,sub)
	if self:是否可视() then
		if self._类型 == '窗口' then
			self:_消息事件('窗口移动',{self._x,self._y})--让子控件移位
			--self:_消息事件('鼠标移动',引擎.取鼠标坐标())
		end
		if self._类型 == '窗口' then--打开置顶
			self._层次 = os.clock() + 1000
			self:取父控件():排序()--告诉父控件
		end
	-- else
	-- 	self:_消息事件('鼠标移动',0,0)
	end
	return self
end
function GUI控件类:_消息事件(类型,参数)
	local x,y = unpack(参数)

	if self:是否加载() or 类型 == '窗口移动' or 类型 == '释放' then
		--父先收消息,以便拦截
		if self:是否可视() then
			--=====================点击子控件,让窗口置顶======================
			local 控件 = self:是否窗口()
			if 控件 and 类型 == '左键按下' and 控件:检查像素(x,y) then
				控件._层次 = os.clock() + 1000
				控件:取父控件():排序()--窗口的上层
			end
		end
		if (self:是否可视() or 类型 == '可视事件')  and self:发送消息(类型,x,y,参数) then
			return true--用户消息事件 拦截
		end

		for i=#self._子控件,1,-1 do
			local v = self._子控件[i]
			if 类型 == '窗口移动' then
				if v._类型 == '窗口' then
					--v:_消息事件('父窗口移动',x,y)
				elseif v:_消息事件(类型,参数) then
					return true
				end
			elseif (v:是否可视() or 类型 == '可视事件' or 类型 == '释放') and v:_消息事件(类型,参数) and 类型 ~= '释放' then
				return true--子控件 拦截
			end
		end
		if 类型 == '窗口移动' then--置坐标发出
	    	if x~=self._x or y ~= self._y then
	    	    self._x,self._y = self._px+x,self._py+y
	    	    self._fx,self._fy = x,y--记录父坐标
	    	    self._包围盒:置坐标(self._x,self._y)
	    	    --if self._类型 == '窗口' then self:_消息事件('窗口移动',self._x,self._y) end--告诉子窗口的子控件
	    	end
	    end
		if self:是否可视() or 类型 == '可视事件' then
			--===============================================================
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
			end
			if self._类型 == '窗口' then
			    if 类型 == '左键按下' and self:检查像素(x,y) then
			        self._鼠标按下 = true
			        self._cx,self._cy = x-self._x,y-self._y
			        self._层次 = os.clock() + 1000
			        self:取父控件():排序()--告诉父控件
			        return true
			    elseif 类型 == '鼠标移动' then
			    	if self._鼠标按下 then
						self._x,self._y = x-self._cx,y-self._cy
			    		self:_消息事件('窗口移动',{self._x,self._y})--告诉子控件
			    		return true
			    	elseif self:检查像素(x,y) then
			    		参数.碰撞 = true
			    	end
			    elseif 类型 == '左键弹起' or 类型 == '可视事件' then
			    	self._鼠标按下 = false
			    elseif 类型 == '右键按下' and self:检查像素(x,y) then
			    	self._鼠标按下 = false
			    	self:置可视(false)
			    	return true
			  	elseif self:取父控件():取顶层控件() == self and (类型 == '按键按下' or 类型 == '按键弹起' or 类型 == '按键按住') then
			  		return true--焦点窗口才有按键
			    end
			end


		    if self:发送消息('消息结束') then--拦截的呢消息
		    	return true
			elseif not self:是否禁止() and (类型 == '左键按下' or 类型 == '右键按下' or 类型 == '鼠标滚动') then
				return self:检查像素(x,y)
			end
		end
	end
	return false
end

return GUI控件类