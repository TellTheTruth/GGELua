require("GGE")--引用头


引擎("游戏模版",800,600,60)

ffun = require("ffi函数")

file = io.open(__gge.runpath.."/Lua51.dll", "rb")
data = file:read("*all")
file:close()
print(ffun.取MD5(data))

function 更新函数(dt,x,y)--帧率,鼠标x,鼠标y



end


function 渲染函数(x,y)--鼠标x,鼠标y
	引擎.渲染开始()
	引擎.渲染清除(0xFF272822)


	引擎.渲染结束()
end



local function 退出函数()

	return true
end
引擎.置退出函数(退出函数)