require("GGE")--引用头


引擎.创建('Galaxy2D Game Engine',640,480,60,false,false,nil)


背景 = require("gge图像类")('b.jpg')
纹理 = require("gge纹理类")("000034.bmp")
print(纹理.isok)
精灵 = require("gge精灵类")(纹理):置拉伸(0,0,316*0.8,296*0.8)

精灵:置混合(2):置颜色(ARGB(120,255,255,255))
--背景:置混合(0)
function 更新函数(dt,x,y)--帧率,鼠标x,鼠标y



end


function 渲染函数()
	引擎.渲染开始()
	引擎.渲染清除(0xFF5A5A5A)
	背景:显示()
	精灵:显示(0,100)

	精灵:取包围盒():显示(0xFF00FF00)
	引擎.渲染结束()
end
