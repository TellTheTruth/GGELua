require("GGE")--引用头
--为了更美观方便,可以将要引用的代码放在GGE文件中哦.
--当然也可以自己创建个文件

引擎.创建('序列动画测试',800,600,60,false,false,nil)





ani = require("gge动画类")('../res/ani.png',11,10,64,41):播放()

function 更新函数(dt,x,y)--帧率,鼠标x,鼠标y

	ani:更新(dt)
end


function 渲染函数()
	引擎.渲染开始()
	引擎.渲染清除(0x606060)

	ani:显示(100,100)
	引擎.渲染结束()
end
