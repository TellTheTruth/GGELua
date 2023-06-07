require("gwnd")
local 纹理类 = __gge.loadscript("gge纹理类")
纹理类.__new__ = require("g2dtexture")
local 精灵类 = __gge.loadscript("gge精灵类")
精灵类.__new__ = require("g2dsprite")
local 文字类 = __gge.loadscript("gge文字类")
文字类.__new__ = require("g2dfont")



local bit = require("bit")


local 渲染宽度 = 250
local 渲染高度 = 600
local 引擎句柄 = 0
local 鼠标按下 = {false,false}
local 鼠标弹起 = {false,false}
local 鼠标中键 = {false,false}
local 滚轮值 	= 0
local 鼠标x,鼠标y=0,0
local LOWORD = function (l) return bit.band(l,0xffff); end
local HIWORD = function (l) local r = bit.band(bit.rshift(l, 16),0xffff); return r>32768 and (r-65536) or r; end

local function __Message(HWND,UMSG,WPARAM,LPARAM)
	if UMSG == 0x0203  or UMSG == 0x0206  or UMSG == 0x0209 or UMSG == 0x0207 or UMSG == 0x0208 then
		print("鼠标消息:",UMSG,HIWORD(WPARAM),LOWORD(WPARAM),HIWORD(LPARAM),LOWORD(LPARAM))
	elseif UMSG == 512 then
		鼠标x,鼠标y = LOWORD(LPARAM),HIWORD(LPARAM)
	elseif UMSG == 513 then
	    鼠标按下[0] = true
	elseif UMSG == 514 then
		鼠标弹起[0] = true
	elseif UMSG == 516 then
		鼠标按下[1] = true
	elseif UMSG == 517 then
		鼠标弹起[1] = true
	elseif UMSG == 522 then
		滚轮值 	= HIWORD(WPARAM)/120
	end
	if UMSG == 5 then--窗口大小改变
		渲染宽度 = LOWORD(LPARAM)
	end
end
--=================================================================================================
local 聊天窗口 	= {}
local _isopen 	= false
local _creattable 	= {}
local _base 	= require("g2dbase")()

function 聊天窗口.打开(标题,帧率)
	_isopen = true
	if _base:Engine_Create() then
		_base:System_SetStateInt(1,帧率 or 20)
		_base:System_SetStateInt(2,800)
		_base:System_SetStateInt(3,渲染高度)
		_base:System_SetStateBool(8,1)
		_base:System_SetStateFun(4,__Message)
		return _base:System_Initiate(引擎句柄,__gge.cs)
	end
end
function 聊天窗口.关闭()
	if _isopen then
		for i,v in ipairs(_creattable) do
			v:释放()
		end
		_base:Engine_Release()
		_isopen = false
	end
end
function 聊天窗口.更新()
	鼠标按下 = {false,false}
	鼠标弹起 = {false,false}
	鼠标中键 = {false,false}
	滚轮值 	= 0
	if _isopen then _base:Engine_Update() end
end
function 聊天窗口.是否打开()
	return _isopen
end
function 聊天窗口.鼠标按下(v)
	return 鼠标按下[v]
end
function 聊天窗口.鼠标弹起(v)
	return 鼠标弹起[v]
end
function 聊天窗口.取鼠标滚轮()
	return 滚轮值
end
function 聊天窗口.取鼠标坐标()
	return 鼠标x,鼠标y
end
function 聊天窗口.画线(x1,y1,x2,y2,color,z)
	_base:Graph_RenderLine(x1,y1,x2,y2,color or 0xFFFF0000,z)
end
function 聊天窗口.创建文字(...)
	local r = 文字类(...)
	table.insert(_creattable, r)
	return r
end
function 聊天窗口.创建纹理(...)
	local r = 纹理类(...)
	table.insert(_creattable, r)
	return r
end
function 聊天窗口.创建精灵(t,...)
	if type(t) == 'string' then
	    t = 聊天窗口.创建纹理(t)
	end
	local r = 精灵类(t,...)
	table.insert(_creattable, r)
	return r
end
function 聊天窗口.渲染开始(c)
	if _isopen then return _base:Graph_BeginScene(c) end
end
function 聊天窗口.渲染结束()
	_base:Graph_EndScene(0,0,渲染宽度,渲染高度)
	聊天窗口.更新()
end
setmetatable(聊天窗口,{__call = function (t, ... )
	引擎句柄,渲染高度 = ...
	return t
end
})
return 聊天窗口