

require "gge函数"

引擎("Galaxy2D Game Engine 0.99",800,600,200)
	.垂直同步(true)
logo = require("gge精灵类")(require("gge纹理类")("logo.png"))
	:置中心(300,300)
	:置过滤(true)
f = require("FMOD类")("River Flows In You.mp3",2)
	:播放()

font = require("gge文字类")("c:/windows/fonts/simkai.ttf",20,false,true,true)
	:置描边颜色(0xFF313131)
rad 	= 0
r,g,b	= 0,0,0
循环 	= true
内容 	= [[
GGE相对于EM有什么优势?
    01.比HGE更好的引擎(Galaxy2D)
    02.比Bass更好的音效(Fmod)
    03.比官方lua更好的脚本(luajit)
    04.比EM更好的编辑器(Sublime text3)
    05.比EM更好的服务端(HPSocket)
    06.比EM更好的地图编辑器(Tiled)
    07.比EM更好的代码管理(随意require,核心代码需要才加载)
    08.比EM更好的资源管理(只管载入,自动释放)
    09.支持所有国外lua模块(LUA5.1)
    10.支持易语言静态编译的DLL(不一定得黑月)
    11.除编译器外,所有源码开源.
    12.还有更多的功能,请您探索.

首次运行:
    运行GGEMain.exe(xp以上系统,需要管理员权限)
    文件菜单->设置
    进行相关的关联(项目关联是必须的)
]]
function 渲染函数()
	引擎.渲染开始()
	引擎.渲染清除(0xFF616161)
	rad =rad+0.2
	if rad>360 then rad=0 end

	if 循环 then
		r,g,b = r+1,g+1,b+1
		if r>250 then 循环 = false;r=250 end
	else
		r,g,b = r-1,g-1,b-1
		if r<0 then 循环 = true;r=0 end
	end
	--font:显示(10,10,string.format("垂直同步 FPS:%d",引擎.取FPS()))

	logo
		:置颜色(RGB(r,g,b))
		:置旋转(math.rad(rad))
		:置缩放(1,1)
		:显示(800,300)
	font:显示(10,10,内容)
	引擎.渲染结束()
end

