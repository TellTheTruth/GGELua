require("GGE")--引用头


引擎("游戏模版",800,600,60)

目标纹理 = require("gge纹理类")():渲染目标(800,600)

引擎.截图到纹理(目标纹理)
print(目标纹理:是否可用())
精灵 = require("gge精灵类")(目标纹理)


function 更新函数(dt,x,y)--帧率,鼠标x,鼠标y




end


function 渲染函数(x,y)--鼠标x,鼠标y
	引擎.渲染开始()
	引擎.渲染清除(0xFF272822)


	精灵:显示()
	引擎.渲染结束()
end



local function 退出函数()

	return true
end
引擎.置退出函数(退出函数)