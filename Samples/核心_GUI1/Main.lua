require("GGE")--引用头
require("gge函数")

引擎("游戏模版",640,480,60)
MenuBar 	= require("Script/MenuBar")--菜单栏
MenuWnd 	= require("Script/MenuWnd")--菜单弹出
MessageBox 	= require("Script/MessageBox")--消息框
TabBar 		= require("Script/TabBar")--选择夹
DragArea 	= require("Script/DragArea")--消息框拖动
SliderWnd   = require("Script/SliderWnd")
FuncWnd2 	= require("Script/FuncWnd2")

res = require("gge资源类")()
gui = require("gui/加载类")()

gui:置资源类(res)

gui:添加创建函数('MessageBox',MessageBox)
gui:添加创建函数('DragArea',DragArea)
gui:添加创建函数('MenuBar',MenuBar)
gui:添加创建函数('TabBar',TabBar)
gui:添加创建函数('MenuWnd',MenuWnd)
gui:添加创建函数('SliderWnd',SliderWnd)
gui:添加创建函数('FuncWnd2',FuncWnd2)

gui:载入文件("newgui.gui")
主控件 = gui:创建控件("MainWnd")
主控件:发送子消息(0,'初始化',true)

gui管理 = require("gui/管理器")()
gui管理:置主控件(主控件)

local tooltip = gui:创建控件("ToolTip")
gui管理:置提示控件(tooltip)

function 更新函数(dt,x,y)--帧率,鼠标x,鼠标y
	gui管理:更新(dt)
end


function 渲染函数(x,y)--鼠标x,鼠标y
	引擎.渲染开始()
	引擎.渲染清除(0xFF232323)
	gui管理:显示()

	引擎.渲染结束()
end



local function 退出函数()
	return true
end
引擎.置退出函数(退出函数)