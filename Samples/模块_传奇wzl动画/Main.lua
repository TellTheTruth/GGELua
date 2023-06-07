require("GGE")--引用头


引擎("左边优化的影子",800,600,60)

hum = require("mir/wzl类")('G:/素材客户端/传奇归来国际版/data/npc3')
jl = hum:取精灵(975).精灵
jl1 = hum:取精灵(975,true).精灵
function 更新函数(dt,x,y)--帧率,鼠标x,鼠标y



end


function 渲染函数(x,y)--鼠标x,鼠标y
	引擎.渲染开始()
	引擎.渲染清除(0xFF797C82)
	jl:显示(50,50)
	jl1:显示(400,50)

	引擎.渲染结束()
end



function 退出函数()

	return true
end
引擎.置退出函数(退出函数)