require("GGE")--引用头


引擎("游戏模版",800,600,60)
print(引擎.添加资源("data.gpk","ggelua"))
t = require("gge图像类")(引擎.资源取文件("Data/test.jpg"),引擎.资源取大小("Data/test.jpg"))


function 更新函数(dt,x,y)--帧率,鼠标x,鼠标y



end


function 渲染函数(x,y)--鼠标x,鼠标y
	引擎.渲染开始()
	引擎.渲染清除(0xFF272822)

	t:显示()
	引擎.渲染结束()
end



local function 退出函数()

	return true
end
引擎.置退出函数(退出函数)