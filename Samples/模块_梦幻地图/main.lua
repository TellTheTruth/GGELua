require("gge函数")
--此处引用常用类，注意如果使用引擎相关函数，要在引擎创建后再引用。
地图类=require("Script/地图类")
引擎.创建("Galaxy2D Game Engine",640,480,60)

map  = 地图类.创建("G:/games/梦幻西游/scene/1501.map")
主角坐标 = require("gge坐标类")(200,300)
屏幕坐标 = 主角坐标:取屏幕坐标(map.宽度,map.高度)
地图 = {}
function 更新函数(dt)

	map:更新(主角坐标)
	-- if 引擎.按键弹起(KEY.F1) then
	-- 	--table.insert(地图, 地图类.创建("F:/梦幻西游/scene/1501.map"))
	--     map  = 地图类.创建("F:/梦幻西游/scene/1501.map")
	-- end
end


function 渲染函数()
	引擎.渲染开始()
	引擎.渲染清除(0xFF808080)
	map:显示(屏幕坐标)

	引擎.渲染结束()
end
