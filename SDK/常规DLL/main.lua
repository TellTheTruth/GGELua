require("gge函数")
--此处引用常用类，注意如果使用引擎相关函数，要在引擎创建后再引用。

引擎.创建("Galaxy2D Game Engine",800,600,60)

function 取现行时间()
	local ffi = require("ffi")
	ffi.cdef[[
		const char* dll取现行时间();
	]]
	local dll = ffi.load("effi")
	local text = dll.dll取现行时间()
	return ffi.string(text)
end
print(取现行时间())


function 文件是否存在(file)
	local ffi = require("ffi")
	ffi.cdef[[
		int dll文件是否存在(const char *file);
	]]
	local dll = ffi.load("effi")
	local res = dll.dll文件是否存在(file)
	return res == 1
end
print(文件是否存在("main.lua"))

	local ffi = require("ffi")
	ffi.cdef[[
		void dlltest(int*);
	]]
	local dll = ffi.load("effi")
	a = ffi.new('int[1]')
	local res = dll.dlltest(a)
print(a[0])
require("123")
function 更新函数(dt)


	
end


function 渲染函数()
	引擎.渲染开始()
	引擎.渲染清除(0xFF808080)


	引擎.渲染结束()
end
