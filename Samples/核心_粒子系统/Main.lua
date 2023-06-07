require("GGE")--引用头


引擎("粒子测试",800,600,60)
资源 = require("gge资源类")()
资源:载入文件('res.res')
par = 资源:创建粒子('par')
par2 = 资源:创建粒子('par2')
function 更新函数(dt,x,y)--帧率,鼠标x,鼠标y

	par:更新(dt)
	par2:更新(dt)
end


function 渲染函数(x,y)--鼠标x,鼠标y
	引擎.渲染开始()
	引擎.渲染清除(0xFF272822)

	par:显示(x,y)
	par2:显示(x,y)
	引擎.渲染结束()
end



local function 退出函数()

	return true
end
引擎.置退出函数(退出函数)