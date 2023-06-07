require("GGE")--引用头


引擎.创建('Galaxy2D Game Engine',800,600,60,false,false,nil)

属性 = require("Script/属性")
属性.等级 = 100

print(属性.等级)


T = require("gge文字类")()


function 更新函数(dt,x,y)--帧率,鼠标x,鼠标y

	if 引擎.按键弹起(KEY.F1) then
	    属性.等级 = 属性.等级+1
	end
	if 引擎.按键弹起(KEY.F2) then
	    属性.等级 = 属性.等级-1
	end
end


function 渲染函数()
	引擎.渲染开始()
	引擎.渲染清除(0x606060)

	T:显示(10,10,string.format('请用修改软件修改当前数值:%d\n按下F1增加,修改后再按F1测试写入.',属性.等级))
	引擎.渲染结束()
end
