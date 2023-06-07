require("GGE")--引用头


--引擎.创建('Galaxy2D Game Engine',800,600,60,false,false,nil)

xml = require("ggeXML类")('test.xml')
节点 = xml:取根节点()
print(节点:取名称(),节点:取文本('width'))

节点 = 节点:取首子节点()
print(节点:取名称(),节点:取文本('name'))
子节点 = 节点:取首子节点()
print(子节点:取名称(),子节点:取文本('source'))

节点 = 节点:下一个节点()
print(节点:取名称(),节点:取文本('name'))
子节点 = 节点:取首子节点()
print(子节点:取名称(),子节点:取文本('source'))


节点 = 节点:下一个节点()
print(节点:取名称(),节点:取文本('name'))
子节点 = 节点:取首子节点()
print(子节点:取名称(),子节点:取文本('source'))



--乱码的话,用__gge.utf8toansi(文本,长度) 转换
-- function 更新函数(dt,x,y)--帧率,鼠标x,鼠标y



-- end


-- function 渲染函数()
-- 	引擎.渲染开始()
-- 	引擎.渲染清除(0x606060)


-- 	引擎.渲染结束()
-- end
