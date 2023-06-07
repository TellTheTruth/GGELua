
local gge文字 = require("gge文字类")--local 意思是声明临时变量
引擎.创建("ttf,ttc文字测试",800,600,0)


投影文字 = gge文字("C:/Windows/Fonts/simsun.ttc",20)
	:置阴影颜色(0xFF000000)
描边文字 = gge文字("C:/Windows/Fonts/simsun.ttc",20,false,true,true)
	:置描边颜色(0xFF000000)
普通文字 = require("gge文字类")()

娃娃文字 = gge文字("../res/简娃娃篆.ttf",20,false,false,true)




function 更新函数()



end


function 渲染函数()

	引擎.渲染开始()
	引擎.渲染清除(0xFF979797)


	投影文字:显示(10,40,"投影文字")
	普通文字:显示(100,40,"普通文字")

	描边文字:显示(10,70,"描边文字")
	娃娃文字:显示(10,10,"娃娃字体文字........FPS:"..string.format("%d", 引擎.取FPS()))


	引擎.渲染结束()

end