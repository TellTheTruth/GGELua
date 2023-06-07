
local fmod = require "Fmod类"

引擎.创建("fmod音效测试",800,600,60)


f = fmod("../res/Music01002.mp3",2)--2是循环
	:播放()

function 更新函数()



end


function 渲染函数()
	引擎.渲染开始()
	引擎.渲染清除(0xFF272822)


	引擎.渲染结束()
end
