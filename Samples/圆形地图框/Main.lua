require("GGE")--引用头


引擎("游戏模版",800,600,60)


渲染区 = require("gge纹理类")():渲染目标(111,111)
渲染精灵 = require("gge精灵类")(渲染区)
精灵A = require("gge精灵类")("Data/A.png")


地图框 = require("gge精灵类")("Data/地图框.png")
小地图 = require("gge精灵类")("Data/镇魔谷.jpg"):置区域(180,180,111,111)

function 更新函数(dt,x,y)--帧率,鼠标x,鼠标y

	引擎.渲染开始(渲染区)--将小地图和蒙板显示在一个渲染纹理里
	引擎.渲染清除(0xFF272822)
	小地图:显示()
	精灵A:显示()
	引擎.渲染结束()
end


function 渲染函数(x,y)--鼠标x,鼠标y
	引擎.渲染开始()
	引擎.渲染清除(0xFF272822)
	地图框:显示()

	渲染精灵
		:置混合(2)--将渲染纹理混合_alpha加 就会去掉黑色,注释此行看效果
		:显示(19,37)

	小地图:显示(200,37)
	引擎.渲染结束()
end



local function 退出函数()

	return true
end
引擎.置退出函数(退出函数)