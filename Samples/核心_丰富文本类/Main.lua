require("GGE")--引用头
require("gge函数")

引擎("游戏模版",800,600,60)
function 打开网站()
	print(1231230)
end

丰富文本 = require("丰富文本类")(400,200)
	--
	:添加元素("W",0xFFFFFFFF)
	:添加元素("H",0xFF000000)
	:添加元素("Y",0xFFFFFF00)
	:添加元素("L",0xFF6060FF)
	:添加元素("R",0xFFFF0000)
	:添加元素("G",0xFF00FF00)
for i=1,52 do
	丰富文本:添加元素(i,require("gge精灵类")(string.format('Data/表情 (%d).png', i)))
end
t=os.clock ()
丰富文本:添加文本(string.rep('按#R/F1#W/添加文本。#1', 1))
丰富文本:置回调函数(打开网站)
print(os.clock ()-t)

测试文本 = {
	'左边文本#G/djy/右边文本',
	'#W/jz/居中文本#2',
	'#W/jy/居右文本#1',
	'#11#Y/xx/下划线',
	'#12#H/sx/删除线',
	'#13#Y/bj|H/背景颜色',
	'#14#L/pz|H/碰撞颜色',
	'#15#R/xx/ht|打开网站/回调事件www.baidu.com',
	'#16#G/xx/sx/删除线和下划线组合',
	'表情#1#2#4#6#8',
	'自动折行自动折行自动折行自动折行自动折行自动折行自动折行自动折行自动折行自动折行自动折行自动折行自动折行自动折行自动折行自动折行自动折行'
}
print(string.match('ht|打开网站', '([a-z]*)'))
print(丰富文本:取回调包围盒())
-- print(string.match('ht|打开网站', '[a-z]*|(.*)'))
背景精灵 = require("gge精灵类")(0,0,0,400,200):置颜色(ARGB(128,0,0,0))
function 更新函数(dt,x,y)--帧率,鼠标x,鼠标y

	if 引擎.按键弹起(KEY.F1) then
	    丰富文本:添加文本(测试文本[math.random(1, #测试文本)])
	end
	丰富文本:更新(dt,x,y)
end


function 渲染函数(x,y)--鼠标x,鼠标y
	引擎.渲染开始()
	引擎.渲染清除(0xFF272822)
	背景精灵:显示(0,400)
	丰富文本:显示(0,400)
	引擎.渲染结束()
end



local function 退出函数()

	return true
end
引擎.置退出函数(退出函数)