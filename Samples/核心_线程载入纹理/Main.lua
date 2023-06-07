require("GGE")--引用头


引擎("游戏模版",800,600,60)
文字 = require("gge文字类")()

线程 = require("Script/线程回调")
线程:启动()
线程:发送(100,"Data/test.jpg")

进度=1



function 更新函数(dt,x,y)--帧率,鼠标x,鼠标y


end


function 渲染函数(x,y)--鼠标x,鼠标y
	引擎.渲染开始()
	引擎.渲染清除(0xFF272822)

	if 线程完成 then
	    线程完成:显示()
	    文字:显示(10,10,"载入完成.")
	else
		文字:显示(10,10,string.format("正在载入第%d张", 进度))
	end

	引擎.渲染结束()
end


local function 退出函数()
	线程:停止()
	return true
end
引擎.置退出函数(退出函数)