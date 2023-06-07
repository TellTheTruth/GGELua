-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2016-05-10 22:32:58
-- @最后修改来自: baidwwy
-- @Last Modified time: 2016-06-01 05:21:42
local ffi = require("ffi")
ffi.cdef[[
	typedef struct {
		int state;
		int ok;
		int type;
		int len;
		const char* data;
	}ggethread;
]]
local _线程 	= require("gge线程类")("Script/线程循环")

local 交互数据 = ffi.new("ggethread[?]",100)
local 发送数据 = {}
function _线程:消息返回(i,p)--线程数据
	if i == "取交互指针" then
	    return tonumber(ffi.cast("intptr_t",交互数据))
	else
		进度=i
		if i==50 then
		    线程完成 = require("gge精灵类")(require("gge纹理类")(p))
		end
	end
end
function _线程:发送(...)
	local t = {...}
	for i=0,99 do
		if 交互数据[i].state == 0 then
		    发送数据[i] = t--保存一份,防止出错
		    交互数据[i].state = 1
		    交互数据[i].type = t[1]
		    交互数据[i].data = t[2]
		    交互数据[i].len = #t[2]
		    交互数据[i].ok = 1--防止出错
		    break
		end
	end
end
return _线程