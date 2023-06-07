require("GGE")--引用头
fun  = require("ffi函数")

引擎("用户界面",1024,768,60)

文字 = require("gge文字类")():置颜色(0xFF050202)

--[[
UI框架说明
界面大概分为5层
	1层是地表，这一层收到消息则移动人物
	2层是用户界面，显示人物血量信息或常用按钮
	3层是窗口界面
	4层是系统窗口界面，此层显示的情况下，底下的层都不会有消息到达
	5层是提示层，显示焦点提示或装备信息显示

	UI对象 	创建方法是 require("ggeui")()
	层对象 	创建方法是 UI对象:创建控件('xxx')
	控件	创建方法是 	使用层对象创建

	XXX:创建控件('xxx',x,y,宽度,高度)
	XXX:创建窗口('xxx',x,y,宽度,高度)
	XXX:创建输入('xxx',x,y,宽度,高度)
	XXX:创建按钮('xxx',x,y,宽度,高度)
	XXX:创建复选按钮('xxx',x,y,宽度,高度)
	XXX:创建单选按钮('xxx',x,y,宽度,高度)
	XXX:创建丰富文本('xxx',x,y,宽度,高度)
	XXX:创建列表('xxx',x,y,宽度,高度)
	XXX:创建多列表('xxx',x,y,宽度,高度)
	XXX:创建竖形滑块('xxx',x,y,宽度,高度)
	XXX:创建横形滑块('xxx',x,y,宽度,高度)
	XXX:创建进度('xxx',x,y,宽度,高度)
	XXX:创建树形('xxx',x,y,宽度,高度)
	XXX:创建网格('xxx',x,y,宽度,高度)
	XXX:创建自适应('xxx',x,y,宽度,高度)
]]
function 更新函数(dt,x,y)--帧率,鼠标x,鼠标y

	_GUI:更新(dt,x,y)
end


function 渲染函数(x,y)--鼠标x,鼠标y
	引擎.渲染开始()
	引擎.渲染清除(0xFFB9B9B9)

	_GUI:显示(x,y)
	文字:显示(10,10,string.format('%d,%d',x,y))
	引擎.渲染结束()
end



function 退出函数()

	return true
end
引擎.置退出函数(退出函数)