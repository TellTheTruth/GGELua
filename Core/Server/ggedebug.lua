-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-03-29 06:29:00
-- @最后修改来自: baidwwy
-- @Last Modified time: 2016-06-13 18:12:13

local errored--只显示一次
function __gge.traceback(msg)
	if not errored then
	    print(tostring(msg).."..//按F4或双击此行可转到错误代码页。//")

	    print("---------------------------------以下为可能错误的方---------------------------------")
	    print(debug.traceback())
	    errored = true
	end
end
