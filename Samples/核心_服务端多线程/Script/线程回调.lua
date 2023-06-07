-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2016-05-10 22:32:58
-- @最后修改来自: baidwwy
-- @Last Modified time: 2017-05-12 01:10:02
local 线程 	= require("ggethread")("Script/线程循环")
local ffi = require("ffi")
local 数据数量 = ffi.new("int[1]")
local 发送数据 = {}

function 线程:消息返回(...)--线程数据
	if ... == "取数量指针" then
	    return tonumber(ffi.cast("intptr_t",数据数量))
	elseif ... == "取数据" then
		local r = 发送数据[1]
		table.remove(发送数据, 1)
		return unpack(r)
	else
		print("线程返回",...)
	end

end
function 线程:发送(...)--这里是不定数据,如果是固定的,可以参考客户的多线程 纹理
	数据数量[0] = 数据数量[0]+1
	table.insert(发送数据, {...})
end
return 线程