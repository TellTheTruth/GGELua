--require("gge函数")
--此处引用常用类，注意如果使用引擎相关函数，要在引擎创建后再引用。

引擎.创建("A星寻路测试",1024,768,60)
画线  = 引擎.画线
障碍数量 = 10000
格子大小 = 5
local 精灵类 = require("gge精灵类")
障碍精灵 = 精灵类(0,0,0,格子大小,格子大小):置颜色(0xFFAF7352)
主角精灵 = 精灵类(0,0,0,格子大小,格子大小):置颜色(0xFFFFFF00)
路径精灵 = 精灵类(0,0,0,格子大小,格子大小):置颜色(0xFF00FF00)

格子x = 205
格子y = 154
寻路 = require("Astart类").创建(格子x,格子y)

local 计数 = 0

math.randomseed(os.time())
repeat--设置障碍
	local x,y = math.random(0, 格子x-1),math.random(0, 格子y-1)
	if 寻路:检查点(x,y) then
		寻路:置状态(x,y,false)
	    计数 = 计数+1
	end
until 计数==障碍数量

repeat--寻找可以落脚的地方。。。
	x,y = math.random(0, 1),math.random(0, 格子y-1)
	print(x,y)
until 寻路:检查点(x,y)
路径组 = {}
function 更新函数(dt,鼠标x,鼠标y)

	local 格子x,格子y = math.floor(鼠标x/格子大小),math.floor(鼠标y/格子大小)

	if 引擎.鼠标弹起(KEY.LBUTTON) and 寻路:检查点(格子x,格子y)then

		路径组=寻路:取路径(x,y,格子x,格子y)

	end

end


function 渲染函数()
	引擎.渲染开始()
	引擎.渲染清除(0xFF808080)
	for x=0,格子x do
		画线(x*格子大小,0,x*格子大小,768,0xFFA7A596)
	end
	for y=0,格子y do
		画线(0,y*格子大小,1024,y*格子大小,0xFFA7A596)
	end
	for y=0,格子y-1 do
		for x=0,格子x-1 do
			if not 寻路:检查点(x,y) then
			   障碍精灵:显示(x*格子大小,y*格子大小)
			end
		end
	end
	主角精灵:显示(x*格子大小,y*格子大小)
	for i=1,#路径组 do
		路径精灵:显示(路径组[i].x*格子大小,路径组[i].y*格子大小)
	end
	引擎.渲染结束()
end
