require("gge函数")
--此处引用常用类，注意如果使用引擎相关函数，要在引擎创建后再引用。

require("Script/资源类")
引擎.创建("Galaxy2D Game Engine",800,600,60)

资源类:打开('music')



FMOD类2	= require("FMOD类")
music = FMOD类2.创建("G:/素材客户端/梦幻西游/music.wdf",nil,资源类:取偏移('music',0x7F60CE12)+128,2565224)
music:播放()

function 更新函数(dt)



end


function 渲染函数()
	引擎.渲染开始()
	引擎.渲染清除(0xFF808080)


	引擎.渲染结束()
end
