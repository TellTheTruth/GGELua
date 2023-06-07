local g图像 = require "gge图像类"
local ffi = require("ffi")
--require("gge函数")
引擎.创建("ZIP压缩包测试",800,600,60)
引擎.添加资源('../res/包.zip')

local 指针 = 引擎.资源取文件('res.jpg')
图像 = g图像(指针,引擎.资源取大小('res.jpg'))
引擎.资源释放(指针)

local 指针 = 引擎.资源取文件('新建文本文档.txt')
print(ffi.string(ffi.cast("void*",指针),引擎.资源取大小('新建文本文档.txt')))
引擎.资源释放(指针)

function 更新函数()



end


function 渲染函数()
	引擎.渲染开始()
	引擎.渲染清除(0xFF808080)

	图像:显示()
	引擎.渲染结束()

end