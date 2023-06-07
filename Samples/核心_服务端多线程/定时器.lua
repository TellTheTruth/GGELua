local ffi = require("ffi")
local 数据数量 = ffi.new("int[1]")
local 发送数据 = {}

local 定时器 = class()

function 定时器:初始化(v,循环文件)
	self.线程 = require("ggethread")(循环文件)
	self.线程.消息返回 = function(self,...)
		if ... == "取数量指针" then
		    return tonumber(ffi.cast("intptr_t",数据数量))
		elseif ... == "取数据" then
			local r = 发送数据[1]
			table.remove(发送数据, 1)
			--print(unpack(r))
			return unpack(r)
		else
			print("线程返回",...)
		end
	end
	self:启动(v)
end



function 定时器:启动(v)
	self.线程:启动(v)
	self.线程:置延迟(v)
end

function 定时器:发送(...)--这里是不定数据,如果是固定的,可以参考客户的多线程 纹理
	数据数量[0] = 数据数量[0]+1
	table.insert(发送数据,{...})
end

return 定时器