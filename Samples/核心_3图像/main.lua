

引擎("图像测试",800,600,60,false,true)
--[[
	一行方式
	图像 = require("gge图像类")("../res/test.jpg")
]]

--两行方式
local g图像 = require("gge图像类") --lua函数只有一个参数时,可以省略括号哦!

图像 = g图像 "../res/test.jpg" --也要看情况使用哦,不然自己都会看晕哦,像这样!


print(图像)
--图像 = require("gge图像类")("../res/test.jpg")--还可以这样


function 更新函数()

end


function 渲染函数()
	引擎.渲染开始()
	引擎.渲染清除(0xFF808080)


	图像:显示()


	引擎.渲染结束()

end