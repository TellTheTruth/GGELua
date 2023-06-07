
__S服务 = require("ggeserver")("测试")

aaaaaaa = function()print(4444)end
线程 = require("定时器")(1000,"Script/线程循环")
print(aaaaaaa)
print(线程:发送(aaaaaaa))
local __N连接数 	= 0
local __C客户信息 	= {}

function __S服务:启动成功()
	return 0
end
function __S服务:连接进入(ID,IP,PORT)
	if __N连接数 < 1000 then
		__S服务:输出(string.format('客户进入(%s):%s:%s',ID, IP,PORT))
		__N连接数 = __N连接数+1
		__C客户信息[ID] = {
			IP = IP,
			PORT = PORT
		}
	else
		__S服务:断开连接(ID)
	end
end
function __S服务:连接退出(ID)
	if __C客户信息[ID] then
	    __S服务:输出(string.format('客户退出(%s):%s:%s', ID,__C客户信息[ID].IP,__C客户信息[ID].PORT))
	else
		__S服务:输出("连接不存在(连接退出)。")
	end
end
function __S服务:数据到达(ID,...)
	local arg = {...}
	if __C客户信息[ID] then
		__S服务:输出(string.format('客户消息(%s):%s:%s,%s', ID,__C客户信息[ID].IP,__C客户信息[ID].PORT,table.concat( arg, "|")))
	else
		__S服务:输出("连接不存在(数据到达)。")
	end
end
function __S服务:错误事件(ID,EO,IE)
	if __C客户信息[ID] then
	    __S服务:输出(string.format('错误事件(%s):%s,%s:%s', ID,__错误[EO] or EO,__C客户信息[ID].IP,__C客户信息[ID].PORT))
	else
		__S服务:输出("连接不存在(错误事件)。")
	end
end
function 循环函数()

end
function 输入函数(t)

end
function 退出函数()
end
__S服务:启动("127.0.0.1",9527)