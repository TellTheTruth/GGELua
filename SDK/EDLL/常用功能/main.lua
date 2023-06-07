require("gge函数")
--此处引用常用类，注意如果使用引擎相关函数，要在引擎创建后再引用。
这也行 = require "eall"
引擎.创建("Galaxy2D Game Engine",800,600,60)
_T = require("gdi文字类").创建("宋体",16)

function 拖放回调(...)
	local arg = {...}
	print(#arg)
	
end

__eall.注册拖放("拖放回调",引擎.取窗口句柄())
function 更新函数(dt)


	
end


function 渲染函数()
	引擎.渲染开始()
	引擎.渲染清除(0xFF808080)
	_T:显示(10,10,string.format("内存使用量:%dKB", __eall.取内存使用()))

	引擎.渲染结束()
end
