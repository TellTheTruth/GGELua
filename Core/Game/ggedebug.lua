-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-04-04 16:55:06
-- @最后修改来自: baidwwy
-- @Last Modified time: 2017-05-02 21:31:41

--游戏出错时会调用 __gge.traceback ,如果想让游戏继续运行,请删除__gge.traceback函数
__gge.safecall = function (func,...)
    local args = { ... };
	local ret = {xpcall(function() return func(unpack(args,1,table.maxn(args))) end, __gge.traceback)}

	if ret[1] then
	    return unpack(ret, 2,table.maxn(ret))
	end
	return false
end
local _print = print
function print( ... )
	local args = { ... };
	for i=1,table.maxn(args) do
		if type(args[i])=='string' and #args[i]%2 ~= 0 then
		    args[i] = args[i]..' '
		end
	end
	_print(unpack(args, 1, table.maxn(args)))
end

local errored--只显示一次
local function tracebackex()
	local ret = ""
	local level = 3
	ret = ret .. "stack traceback:\n"
	while true do
		--get stack info
		local info = debug.getinfo(level, "Sln")
		if not info then break end
		if info.what == "C" then                -- C function
			ret = ret .. string.format("\t[C]: in function '%s'\n", info.name or "")
		else           -- Lua function
			ret = ret .. string.format("\t%s:%d: in function '%s'\n", info.short_src, info.currentline, info.name or "")
		end
		--get local vars
		local i = 1
		while true do
			local name, value = debug.getlocal(level, i)
			if not name then break end
			if name~='self' and name~='(*temporary)' then
				value =  tostring(value)
				if #value >100 then
						value = value:sub(1,100).." ……"
				end
					ret = ret .. string.format("\t\t%s\t= %s\n", name,value)
			end

			i = i + 1
		end
		level = level + 1
	end
	return ret
end

if __gge.isdebug and #__gge.command >0 then
	__gge.traceback = function (msg)
		if not errored then
			print("-----------------------------------------------------------------")
			if msg then
					print(tostring(msg) .. "--按F4或双击此行可转到错误代码页--")
				print(">>>>>>>>>>>>>>>>>>>>>>>>>以下为错误跟踪<<<<<<<<<<<<<<<<<<<<<<<<<<")
			end
			-- print(debug.traceback('',2))
			-- print("-----------------------------------------------------------------")
			print(tracebackex())
			引擎.更新函数,引擎.渲染函数 = nil,nil
			if 引擎 then 引擎.关闭() end
			errored = true
		end
	end
else
	__gge.traceback = function (msg)
		if not errored then
			if 引擎.是否运行 and 引擎.是否运行() then
					local 脚本 = [[
					文字 = require("gge文字类")("C:/Windows/Fonts/simsun.ttc",16)
					文字:置行宽(%d)
					文字2 = require("gge文字类")("C:/Windows/Fonts/simsun.ttc",150,false,false,true)
					文字2:置颜色(0x30000000)
					更新函数 = nil
					function 渲染函数()
						引擎.渲染开始()
						引擎.渲染清除(0xFF808080)
							文字2:显示(%d,%d,"GGELUA")--恳请保留
							文字:显示(10,10,"游戏崩溃了,请截图报告作者;并详细说明崩溃前的操作过程。\n")
							文字:显示(10,30,错误信息)
						引擎.渲染结束()
					end
				]]
				错误信息 = debug.traceback(msg,2)
				loadstring(string.format(脚本, 引擎.宽度-20,(引擎.宽度-450)/2,引擎.高度-300))()
			else
				__gge.messagebox(tostring(msg),"致命的错误",16)
				引擎.更新函数,引擎.渲染函数 = nil,nil
				if 引擎 then 引擎.关闭() end
			end
			errored = true
		end
	end
end
--运行一个函数,如果函数内有错误,游戏也不崩溃
__gge.pcall = function (fun,...)
	local ret = {pcall(fun,...)}
	if ret[1] and ret[2] then
		return unpack(ret, 2)
	end
end
