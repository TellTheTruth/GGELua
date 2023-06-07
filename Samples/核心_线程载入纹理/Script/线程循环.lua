-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2016-05-10 22:34:27
-- @最后修改来自: baidwwy
-- @Last Modified time: 2016-06-01 05:22:31
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
i=1

状态 = "等待启动"
function 循环函数()
	if 状态 == "等待启动" then
		local 指针 = 返回消息("取交互指针")--获取共享内存指针
		交互数据 = ffi.cast("ggethread*",指针)
	    状态 = "启动中"
	elseif 状态 == "启动中" then
		for i=0,99 do
			if 交互数据[i].state ~= 0 and 交互数据[i].ok ~= 0 then
				交互数据[i].state = 0
				交互数据[i].ok = 0
				路径 = ffi.string(交互数据[i].data,交互数据[i].len)
				数量 = 交互数据[i].type
			end
		end
	end
	if 路径 and i<=数量 then
	    返回消息(i,require("gge纹理类")(路径):加引用():取指针())
	    i=i+1
	end
end
