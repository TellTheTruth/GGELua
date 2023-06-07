require("GGE")--引用头


引擎("游戏模版",800,600,60)

动画 = require("Script/动画类")('G:/素材客户端/Legend of Mir/Data/hum')
文字 = require("gge文字类")()
function 更新函数(dt,x,y)--帧率,鼠标x,鼠标y

	动画:更新(dt,x,y)

end


function 渲染函数(x,y)--鼠标x,鼠标y
	引擎.渲染开始()
	引擎.渲染清除(0xFF898989)
	文字:显示(10,10,"按F1改变")
	动画:显示(400,300)
	引擎.渲染结束()
end



function 退出函数()

	return true
end
引擎.置退出函数(退出函数)