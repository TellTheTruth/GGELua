require("GGE")--引用头


引擎("游戏模版",800,600,60)
zip = require("ZIP类")()
zip:打开("../res/包.zip")
图像1 = zip:取精灵([[logo/res.jpg]])

text = require("ZIP类")()
text:打开("../res/包.zip")

print(text:取文本([[新建文本文档.txt]]))
print(text:取注释())

zip1 = require("ZIP类")()
zip1:打开("obj.zip","123")

图像 = zip1:取图像([[obj.png]])


function 更新函数(dt,x,y)--帧率,鼠标x,鼠标y



end


function 渲染函数(x,y)--鼠标x,鼠标y
	引擎.渲染开始()
	引擎.渲染清除(0xFF272822)
	图像1:显示()
	图像:显示()
	引擎.渲染结束()
end
