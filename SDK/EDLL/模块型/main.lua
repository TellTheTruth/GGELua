require("gge函数")
--此处引用常用类，注意如果使用引擎相关函数，要在引擎创建后再引用。
这也行 = require "e"
引擎.创建("Galaxy2D Game Engine",800,600,60)

print(__e.加法(1,2))
print(__e.取时间())

print(这也行.取时间())

function 更新函数(dt)


	
end


function 渲染函数()
	引擎.渲染开始()
	引擎.渲染清除(0xFF808080)


	引擎.渲染结束()
end
