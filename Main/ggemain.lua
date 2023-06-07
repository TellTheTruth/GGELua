-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-04-04 17:07:08
-- @最后修改来自: baidwwy
-- @Last Modified time: 2016-05-21 16:23:11
引擎.创建("Galaxy2D Game Engine For Lua 0.99",800,600,60)
local g文字 = require("gge文字类")
文字2 = g文字("C:/Windows/Fonts/simsun.ttc",20,false,true,true)
文字2:置描边颜色(0xFF000000)
内容 = [[
GGE相对于EM有什么优势?
    01.比HGE更好的引擎(Galaxy2D)
    02.比Bass更好的音效(Fmod)
    03.比官方lua更好的脚本(luajit)
    04.比EM更好的编辑器(Sublime text3)
    05.比EM更好的服务端(HPSocket)
    06.比EM更好的地图编辑器(Tiled)
    07.比EM更好的代码管理(随意require,核心代码需要才加载)
    08.比EM更好的资源管理(只管载入,自动释放)
    09.支持所有国外lua模块
    10.支持易语言静态编译的DLL(不一定得黑月)
    11.除编译器和代码载入外,所有源码开源.


首次运行:
    运行GGEMain.exe(xp以上系统,需要管理员权限)
    文件菜单->设置
    进行相关的关联(项目关联是必须的)
]]

function 渲染函数()
	引擎.渲染开始()
	引擎.渲染清除(0xFF808080)

	文字2:显示(10,10,内容)
	引擎.渲染结束()
end