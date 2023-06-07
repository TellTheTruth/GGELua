require("GGE")--引用头


引擎("游戏模版",800,600,60)

bass = require("BASS类")("小苹果.mp3"):播放()
--bass:置音量(0.5)
print(bass:取音量(),bass:取状态())
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