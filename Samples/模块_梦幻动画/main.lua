require("gge函数")
require("Script/资源类")

--此处引用常用类，注意如果使用引擎相关函数，要在引擎创建后再引用。

引擎.创建("Galaxy2D Game Engine",800,600,60)

资源类:打开('shape')


动画 = require("Script/动画类")(资源类:取文件('shape',0xA008B525))


function 更新函数(dt)

	动画:更新(dt)

end


function 渲染函数()
	引擎.渲染开始()
	引擎.渲染清除(0xFF808080)
	动画:显示(400,300)

	引擎.渲染结束()
end
