require("GGE")--引用头
require("gge函数")

引擎("游戏模版",1024,768,60)
登陆事件 = require("登陆界面")
选择事件 = require("选择界面")

res = require("gge资源类")()
UI加载 = require("gui/加载类")()

UI加载:置资源类(res)
UI加载:添加创建函数('登陆事件',登陆事件)
UI加载:添加创建函数('选择事件',选择事件)

UI加载:载入文件("登陆.gui")
主界面 = UI加载:创建控件("主界面")
主界面:发送子消息(0,'初始化',true)

UI管理 = require("gui/管理器")()
UI管理:置主控件(主界面)


function 更新函数(dt,x,y)--帧率,鼠标x,鼠标y

	UI管理:更新(dt)
end


function 渲染函数(x,y)--鼠标x,鼠标y
	引擎.渲染开始()
	引擎.渲染清除(0xFF272822)
	UI管理:显示()

	引擎.渲染结束()
end



local function 退出函数()

	return true
end
引擎.置退出函数(退出函数)