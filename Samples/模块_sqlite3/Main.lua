require("GGE")--引用头


引擎("游戏模版",800,600,60)

sqlite3 = require("sqlite3类")('dat.db','123')

cur = sqlite3:执行SQL("select * from user;")
print(cur)
print(cur:取数量())
row = cur:取数据()

while row do
	print(string.format("账号:%s 密码:%s 年龄:%0.2f",row.account,row.password,row.age))
	row = cur:取数据(row)
end

cur = sqlite3:执行SQL("select * from map limit 1;")
row = cur:取数据()

图像 = require("gge图像类")(row.obj,#row.obj)

function 更新函数(dt,x,y)--帧率,鼠标x,鼠标y



end


function 渲染函数(x,y)--鼠标x,鼠标y
	引擎.渲染开始()
	引擎.渲染清除(0xFF272822)

	图像:显示()
	引擎.渲染结束()
end



local function 退出函数()

	return true
end
引擎.置退出函数(退出函数)