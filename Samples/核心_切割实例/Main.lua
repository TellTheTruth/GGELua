local g精灵 = require "gge精灵类"
local g纹理 = require "gge纹理类"

引擎.创建("切割测试",800,600,0)
local 纹理

纹理 = g纹理("8D580095.PNG")

纹理1 = 纹理:复制区域(30,30,30,30)
精灵 = g精灵(纹理1)

function 更新函数(dt,x,y)--帧率,鼠标x,鼠标y



end


function 渲染函数(x,y)--鼠标x,鼠标y
	引擎.渲染开始()
	引擎.渲染清除(0xFF272822)

	精灵:显示(10,10)
	引擎.渲染结束()
end


