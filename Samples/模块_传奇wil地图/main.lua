
游戏目录 = 'G:/素材客户端/Legend of Mir/'
require("GGE")--引用头


引擎.创建('WIL和MAP测试',1024,768,60,false,false,nil)


T = require("gge文字类")(nil,12)
测试 = require("地图")(游戏目录 .. 'Map/3.map')

wil = require("mir/wil类")(游戏目录..'Data/Objects')

--jl = wil:取精灵(1406)
function 更新函数(dt,x,y)--帧率,鼠标x,鼠标y


	测试:更新(dt,x,y)
end


function 渲染函数()
	引擎.渲染开始()
	引擎.渲染清除(0xFF939393)
	测试:显示()
	--jl:显示(50,0)
	引擎.渲染结束()
end
