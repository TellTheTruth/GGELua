--======================================================================--
--此文件不是必须的
--这里可以包含引用所有文件
--若文件需要使用引擎相关函数(如INI),可以在引擎创建完成中引用
--======================================================================--
require("gge函数")

_GUI 	= require("gge界面/加载类")()
_资源 	= require("Script/资源类")()



--模块引用
--模块列表
function 引擎创建完成()
	require("Script/登陆界面")
	 _GUI:取控件('登陆界面'):置可视(true,true)
	require("Script/主界面")
end