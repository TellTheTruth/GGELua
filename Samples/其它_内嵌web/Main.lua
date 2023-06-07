require("GGE")--引用头


引擎("游戏模版",1024,768,60)

local ffi = require("ffi")
ffi.cdef[[
	void 	wkeInit();
	void* 	wkeCreateWebView();
	void 	wkeResize(void* webView, int w, int h);
	void 	wkeLoadURL(void* webView, const char* url);
	void 	wkePaint(void* webView, int bits, int pitch);
	bool 	wkeKeyDown(void* webView, unsigned int virtualKeyCode, unsigned int flags, bool systemKey);
	bool 	wkeMouseEvent(void* webView, unsigned int message, int x, int y, unsigned int flags);
	bool 	wkeMouseWheel(void* webView, int x, int y,int delta, unsigned int flags);
]]
wke = ffi.load('wke.dll')
wke.wkeInit();
web = wke.wkeCreateWebView();
wke.wkeResize(web,800,600);
wke.wkeLoadURL(web,'baidu.com')

纹理 = require("gge纹理类")():空白纹理(800,600)
精灵 = require("gge精灵类")(纹理)
function 鼠标消息(msg)
	local x,y = 引擎.取鼠标坐标()
	wke.wkeMouseEvent(web,msg,x-100,y-70,0)
end
引擎.置鼠标函数(鼠标消息)
function 更新函数(dt,x,y)--帧率,鼠标x,鼠标y
	wke.wkeMouseWheel(web,x-100,y-70,引擎.取鼠标滚轮()*120,0)
	wke.wkePaint(web,纹理:锁定(),0)
	纹理:解锁()



	-- if 引擎.鼠标按下(KEY.LBUTTON) then
	--     wke.wkeMouseEvent(web,513,x,y,0)
	-- end
	-- if 引擎.鼠标弹起(KEY.LBUTTON) then
	--     wke.wkeMouseEvent(web,514,x,y,0)
	-- end
end


function 渲染函数(x,y)--鼠标x,鼠标y
	引擎.渲染开始()
	引擎.渲染清除(0xFF272822)
	精灵:显示(100,70)

	引擎.渲染结束()
end



local function 退出函数()

	return true
end
引擎.置退出函数(退出函数)