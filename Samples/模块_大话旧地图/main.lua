require("gge函数")
local ffi = require("ffi")
_内存长度 = 10485760
_全局内存 = ffi.new('char[?]',_内存长度)
_内存地址 = tonumber(ffi.cast("intptr_t",_全局内存))

地图类=require("Script/地图类")
引擎.创建("Galaxy2D Game Engine",800,600,60)
引擎.宽度 = 800
引擎.高度 = 600
引擎.宽度2 	= 引擎.宽度/2
引擎.高度2 	= 引擎.高度/2
地图 = require("glow/MAP类")('G:/素材客户端/大话西游/scene/1236.map',_内存地址,_内存长度)
print(地图.宽度,地图.高度,地图.行数,地图.列数,地图.数量,地图.遮罩数量)
--精灵 = 地图:取精灵(0)
当前 = 0
时间 = 0
--
-- table.print(地图:取遮罩ID(100))
--精灵 = require ("gge精灵类")('I:/Desktop/1.bmp')
map  = 地图类.创建("G:/素材客户端/大话西游/scene/1236.map")
主角坐标 = require("gge坐标类")(300,300)

屏幕坐标 = 主角坐标:取屏幕坐标 (map.宽度,map.高度)
-- 地图 = {}
function 更新函数(dt,x,y)
	-- 时间 = 时间+dt
	-- if 当前 < 地图.遮罩数量 and 时间 > 0.1 then
	-- 	print(当前,地图.遮罩数量,math.floor(当前/地图.遮罩数量*100))
	-- 	table.print(地图:取遮罩信息(当前))
	-- 	精灵 = 地图:取遮罩(当前)
	-- 	当前 = 当前+1
	-- 	时间 = 0
	-- end

	map:更新(主角坐标)
	if 引擎.鼠标按下(KEY.LBUTTON) then
		按下 = require("gge坐标类")(x,y)
	elseif 引擎.鼠标弹起(KEY.LBUTTON) then
		按下 = nil
	elseif 按下 then
		偏移 = require("gge坐标类")(x,y)-按下
		主角坐标=主角坐标-偏移
		屏幕坐标 = 主角坐标:取屏幕坐标 (map.宽度,map.高度)
	end

end


function 渲染函数()
	引擎.渲染开始()
	引擎.渲染清除(0xFF808080)
	map:显示(屏幕坐标)
	--精灵:显示(0,0)
	引擎.渲染结束()
end
