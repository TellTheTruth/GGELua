-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2016-06-15 01:30:20
-- @最后修改来自: baidwwy
-- @Last Modified time: 2016-10-17 06:13:57


local function __FrameLoop(t, ... )
	if t then
		if t == 'msg' and 消息函数 then
			return __gge.safecall(消息函数,...)
		elseif t == 'close' and 退出函数 then
			__gge.safecall(退出函数)
		elseif t ~= '' and 输入函数 then
			__gge.safecall(输入函数,t)
		end
	elseif 循环函数 then
		__gge.safecall(循环函数)
	end
end
local gge = {}

function gge.创建(标题,日志)
	if 标题 then gge.置标题(标题) end
	if 日志 then gge.log = require("logger")(日志) end
end
function gge.输出(文本,颜色)
	__gge.print(true,颜色 or __颜色.深白,文本.."\n")
end
function gge.日志(文本,类型)
	if gge.log then
	    gge.log:log(文本,类型)
	end
end
function gge.置标题(str)
	ffi.C.SetConsoleTitleA(str)
end
function gge.置延迟()

end
function gge.文件是否存在(str)
	return __gge.fileexist(str)
end

function gge.关闭()

end
setmetatable(gge,{__call = function (t, ... )
	return t.创建(...)
end
})
return gge