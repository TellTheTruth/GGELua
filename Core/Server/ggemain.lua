-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-03-29 06:28:13
-- @最后修改来自: baidwwy
-- @Last Modified time: 2016-05-10 15:21:48

__连接数 	= 0
__连接信息 	= {}
__服务 		= require("ggeserver")("默认")
function __服务:启动成功()
	print("等待连接...")
	return 0
end
function __服务:连接进入(cid,ip,port)
	if __连接数 < 1000 then
		self:输出(string.format('连接进入(%s):%s:%s\n',cid, ip,port))
		__连接数 = __连接数+1
		__连接信息[cid] = {
			ip = ip,
			port = port
		}
	else
		self:断开连接(cid)
	end
end
function __服务:连接退出(cid)
	if __连接信息[cid] then
	    self:输出(string.format('连接退出(%s):%s:%s\n', cid,__连接信息[cid].ip,__连接信息[cid].port))
	end
end
function __服务:数据到达(cid,...)
	local arg = {...}
	if __连接信息[cid] then
		self:输出(string.format('连接消息(%s):%s:%s,%s\n', cid,__连接信息[cid].ip,__连接信息[cid].port,table.concat( arg, "|")))
	end
end
function __服务:错误事件(cid,so,ec)
	if __连接信息[cid] then
	    self:输出(string.format('错误处理(%s):%s,%s:%s\n', cid,__SO[so] or so,__连接信息[cid].ip,__连接信息[cid].port))
	end
end
function 循环函数()

end
function 输入函数(t)
	print("输入:"..t)
end
__服务:启动("127.0.0.1",9527)



