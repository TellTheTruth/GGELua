-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-04-14 10:11:29
-- @最后修改来自: baidwwy
-- @Last Modified time: 2016-05-23 13:19:12

require("gge函数")

引擎("Galaxy2D Game Engine",800,600,60)

聊天窗口 = require('聊天窗口')(引擎.取窗口句柄(),引擎.高度)
聊天窗口.消息函数 = function (类型,a,b,c)
	-- body
end
句柄 = 聊天窗口.打开()
文字 = 聊天窗口.创建文字()
背景 = 聊天窗口.创建精灵("02760.png",0,0,800,600)

聊天文本 = require("丰富文本类")(250,600)
聊天文本
	:置文字(文字)
	:置画线(聊天窗口.画线)
	:置背景(聊天窗口.创建精灵())
	:添加元素("W",0xFFFFFFFF)
	:添加元素("H",0xFF000000)
	:添加元素("Y",0xFFFFFF00)
	:添加元素("L",0xFF6060FF)
	:添加元素("R",0xFFFF0000)
	:添加元素("G",0xFF00FF00)
	:添加元素("1",聊天窗口.创建精灵("1.jpg"))
	:添加元素("2",聊天窗口.创建精灵("2.jpg"))
聊天文本:添加文本("[当前][SB导师]".."#R/红色文字#Y/黄色文字#G/bj|H/黑底绿字#1")
聊天文本:添加文本("[当前][无名氏]".."收购导师!#2收购导师!#2收购导师!#2收购导师!#2收购导师!#2收购导师!#2收购导师!#2收购导师!#2收购导师!#2收购导师!#2")
聊天文本:添加文本("[当前][精英怪]".."刷BOSSQ1++++++++++!#2刷BOSSQ1++++++++++!#2刷BOSSQ1++++++++++!#2刷BOSSQ1++++++++++!#2刷BOSSQ1++++++++++!#2刷BOSSQ1++++++++++!#2刷BOSSQ1++++++++++!#2刷BOSSQ1++++++++++!#2刷BOSSQ1++++++++++!#2刷BOSSQ1++++++++++!#2")

精灵 = require("gge精灵类")("screenshot.jpg")

function 更新函数()
	-- if 引擎.按键弹起(KEY.F1) then
	--     if 聊天窗口.是否打开() then
	--     	聊天窗口.关闭()
	--     else
	--     	聊天窗口.打开()
	--     	文字 = 聊天窗口.创建文字()
	--     	背景 = 聊天窗口.创建精灵("02760.png",0,0,800,600)
	--     end
	-- end
	if 聊天窗口.渲染开始(0xFF808080) then
		背景:显示()

		聊天文本:显示(0,0)
		聊天窗口.渲染结束()
	end

end


function 渲染函数()

	引擎.渲染开始() --所有引擎函数都是使用点"."调用,不是冒号":"
	引擎.渲染清除(0xFF808080)--快捷键 Ctrl+Shift+C可以快速插入颜色哦
	精灵:显示()
	引擎.渲染结束()
end
function 退出函数()
	--聊天窗口.关闭()
	return true
end
引擎.置退出函数(退出函数)