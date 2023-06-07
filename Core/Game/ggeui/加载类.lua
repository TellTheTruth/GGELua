-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-04-24 12:51:44
-- @最后修改来自: baidwwy
-- @Last Modified time: 2018-08-30 16:53:46
local GUI控件类 	= require("ggeui/控件类")
local 引擎 	 = require("gge引擎")

--=========================================================================
local 注册输入事件 = {}
-- local 鼠标事件 = {}
-- local function 鼠标事件(msg)
-- 	for i,v in ipairs(注册鼠标事件) do
-- 		v:消息事件(msg)
-- 	end
-- end
local function 输入事件(msg,char,wparam)
	for i,v in ipairs(注册输入事件) do
		v:消息事件(msg,char,wparam)
	end
end
local 消息常量 = {
	[512] = '鼠标移动',
	[513] = '左键按下',
	[514] = '左键弹起',
	[515] = '左键双击',
	[516] = '右键按下',
	[517] = '右键弹起',
	[518] = '右键双击',
	[519] = '中键按下',
	[520] = '中键弹起',
	[521] = '中键双击',
	[522] = '鼠标滚动',
	[646] = '输入中文',
	[258] = '输入字符',
	[256] = '按键按下',
	[257] = '按键弹起',
	[265] = '按键按住'
}

引擎.置输入函数(输入事件)
--引擎.置鼠标函数(鼠标事件)

local GGEGUI = class()

function GGEGUI:初始化()
	self._子控件 		= {}
	table.insert(注册输入事件, self)
	--table.insert(注册鼠标事件, self)
	self._x = 0
	self._y = 0
	self._wheel = 0

	self._鼠标 = {}
	--self._默认鼠标
	--self._当前鼠标
	self._上次鼠标 = {}
end
local 按键常量 = {0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x2D,0x2E,0x70,0x71,0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B}
function GGEGUI:更新(dt,x,y)
	if self._x ~= x or self._y ~= y then
		self._x = x
		self._y = y
		--print(x,y)
		self:消息事件(512,x,y)--鼠标移动
	end
	if self._wheel ~= 引擎.取鼠标滚轮() then
	    self._wheel = 引擎.取鼠标滚轮()
	    self:消息事件(522,x,y,self._wheel)
	end
	for i=0,2 do--GGEK_LBUTTON
		if 引擎.鼠标按下(i) then
			self:消息事件(513+i*3,x,y)
		end
		if 引擎.鼠标弹起(i) then
			self:消息事件(514+i*3,x,y)
		end
	end
	for i,v in ipairs(按键常量) do
		if 引擎.按键按下(v) then
			self:消息事件(256,v)
		end
		if 引擎.按键弹起(v) then
			self:消息事件(257,v)
		end
		if 引擎.按键按住(v) then
		    self:消息事件(265,v)
		end
	end
	for i,v in ipairs(self._子控件) do
		if v:是否加载() and v:是否可视() then
			if v.更新 then v:更新(dt,x,y)end
			if v._更新 then v:_更新(dt,x,y)end
		end
	end
end
function GGEGUI:显示(x,y)
	for i,v in ipairs(self._子控件) do
		if v:是否加载() and v:是否可视() then
			if v.显示 then v:显示(x,y)end
			if v._显示 then v:_显示(x,y)end
		end
	end
end
function GGEGUI:消息事件(id,...)
	--print(...)
	--for i,v in ipairs(self._子控件) do
	for i=#self._子控件,1,-1 do
		local v = self._子控件[i]
		if v:是否加载() and v:是否可视() and not v:是否禁止() then
			if v:_消息事件(消息常量[id],{...}) then
			    break
			end
		end
	end
end
function GGEGUI:创建控件(名称)
	if self._子控件[名称] then error('控件已存在->'..名称)end
	local 对象 			= GUI控件类.创建(名称)
	self._子控件[名称] 	= 对象
	table.insert(self._子控件, 对象)
	return 对象
end
function GGEGUI:取控件(名称)
	return self._子控件[名称]
end
--====================================================
function GGEGUI:添加鼠标(名称,动画)
	self._鼠标[名称] = 动画
end
function GGEGUI:取鼠标(名称)
	return self._鼠标[名称]
end
function GGEGUI:置鼠标(名称,...)
	if self._鼠标[名称] then
		table.insert(self._上次鼠标, self._当前鼠标)
		self:消息事件('切换鼠标前',self._当前鼠标.名称,unpack(self._当前鼠标.参数))
		self._当前鼠标 = {名称=名称,参数 = {...}}
		self:消息事件('切换鼠标后',self._当前鼠标.名称,unpack(self._当前鼠标.参数))
	end
end
function GGEGUI:置默认鼠标(名称)
	self._当前鼠标 = 名称
end
function GGEGUI:置上次鼠标(名称)
	if #self._上次鼠标 > 0 then
		self:消息事件('上次鼠标前',self._当前鼠标.名称,unpack(self._当前鼠标.参数))
	    self._当前鼠标 = self._上次鼠标[#self._上次鼠标]
	    self:消息事件('上次鼠标后',self._当前鼠标.名称,unpack(self._当前鼠标.参数))
	    table.remove(self._上次鼠标)
	    return true
	end
	return false
end
return GGEGUI