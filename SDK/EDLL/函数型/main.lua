require("gge函数")
--此处引用常用类，注意如果使用引擎相关函数，要在引擎创建后再引用。
加法 = package.loadlib("E.dll", "加法")
取时间 = package.loadlib("E.dll", "取时间")
--//以下方法适用于WonderWall支持库
--加法 = package.loadlib("E.dll", "_cdecl加法")
--取时间 = package.loadlib("E.dll", "_cdecl取时间")
引擎.创建("Galaxy2D Game Engine",800,600,60)

print(加法(1,2))
调试输出(取时间())
function 更新函数(dt)


	
end


function 渲染函数()
	引擎.渲染开始()
	引擎.渲染清除(0xFF808080)


	引擎.渲染结束()
end
