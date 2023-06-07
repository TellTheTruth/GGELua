require("GGE")--引用头
fun  = require("ffi函数")
mysql = require("mysql类")

引擎("游戏模版",800,600,60)
m = mysql('ultrax','root','','127.0.0.1',3306)
--7.2 版本的表是 cdb_uc_members
local r = m:执行SQL("select * from pre_ucenter_members where username = ".."'baidwwy'")
local t = r:取数据()
print(t.password,t.salt)

print(fun.取MD5(fun.取MD5('123123')..t.salt))



function 更新函数(dt,x,y)--帧率,鼠标x,鼠标y



end


function 渲染函数(x,y)--鼠标x,鼠标y
	引擎.渲染开始()
	引擎.渲染清除(0xFF272822)


	引擎.渲染结束()
end



function 退出函数()

	return true
end
引擎.置退出函数(退出函数)