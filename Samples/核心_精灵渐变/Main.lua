require("GGE")--引用头


引擎("游戏模版",800,600,60)

精灵 = require("gge精灵类")(0,0,0,800,600)
	:置颜色(0xFF0024FF,-1)
	:置颜色(0xFF6EFB9E,3)
	:置颜色(0xFF6EFB9E,2)


function 更新函数(dt,x,y)--帧率,鼠标x,鼠标y



end


function 渲染函数(x,y)--鼠标x,鼠标y
	引擎.渲染开始()
	引擎.渲染清除(0xFF272822)
	精灵:显示()

	引擎.渲染结束()
end



function 退出函数()

	return true
end
引擎.置退出函数(退出函数)