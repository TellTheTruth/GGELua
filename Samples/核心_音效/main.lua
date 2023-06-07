
local g音效 = require "gge音效类"

引擎.创建("OGG音效测试",800,600,60)


--gge音效是核心音效,,不支持mp3
音效 = g音效("../res/scene17000.ogg",false)

print(音效:播放())

function 更新函数()



end


function 渲染函数()
	引擎.渲染开始()
	引擎.渲染清除(0xFF808080)


	引擎.渲染结束()

end