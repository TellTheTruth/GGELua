require("GGE")--引用头


引擎("游戏模版",800,600,60)
local ffi = require("ffi")
ffi.cdef[[
	void* 	LoadImageA(int,const char*,int,int,int,int);
	int 	SendMessageA(int,int,int,void*);
]]
local img = ffi.C.LoadImageA(0,'gge.ico',1,32,32,16)--IMAGE_BITMAP,LR_LOADFROMFILE
ffi.C.SendMessageA(引擎.取窗口句柄(),128,0,img)--WM_SETICON

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