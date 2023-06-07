require("GGE")--引用头


引擎("游戏模版",800,600,60)
文字 = require("gge文字类")()
b1 = require("gge包围盒")(400,300,200,50)

b2 = require("gge包围盒")(0,0,50,200)


s = require("gge精灵类")(0,0,0,200,50)
	:置颜色(0xFFFFFF00)
b3 = s:取包围盒_高级(100,100,math.rad(30))
print(b3)
function 更新函数(dt,x,y)--帧率,鼠标x,鼠标y

	b2:置坐标(x,y)
	状态 = b1:检查盒(b2)
	状态1 = b3:检查点(x,y)
end


function 渲染函数(x,y)--鼠标x,鼠标y
	引擎.渲染开始()
	引擎.渲染清除(0xFF272822)

	b1:显示()
	b2:显示()
	s
		:置旋转(math.rad(30))
		:置缩放(1,1)
		:显示(100,100)
	文字:显示(10,10,string.format("盒状态:%s", 状态 and "碰撞" or "未碰撞"))
	文字:显示(10,30,string.format("精灵状态:%s", 状态1 and "碰撞" or "未碰撞"))
	引擎.渲染结束()
end



local function 退出函数()

	return true
end
引擎.置退出函数(退出函数)