-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-09-18 23:33:02
-- @最后修改来自: baidwwy
-- @Last Modified time: 2016-10-08 03:09:36
local __hpclient = require("__ggehpclient__")

--==========================================================================================

local hpclient = class()

function hpclient:初始化(t)
	self._hp 		= __hpclient(__gge.cs,__gge.state)
	self._hp:Create_TcpPullClient(self)
	self._sendbuf 	= require("ggebuf")()
	self._recbuf 	= require("ggebuf")()
	self._title 	= t or ''
	__gge.print(false,7,"-------------------------------------------------------------------------\n")
	__gge.print(true,7,string.format("创建%s客户端-->", self._title))
	__gge.print(false,10,"成功！\n")
end
-- function hpclient:置接收BUF(v)
-- 	self._recbuf = v
-- 	return self
-- end
-- function hpclient:置发送BUF(v)
-- 	self._sendbuf = v
-- 	return self
-- end
function hpclient:置收发BUF(a,b)
	self._sendbuf = b
	self._recbuf = a
	return self
end
function hpclient:置标题(str)
	local ffi = require("ffi")
	ffi.C.SetConsoleTitleA(str)
	return self
end
function hpclient:连接(ip,port,async)--地址，端口，异步
	self._info = {
		ishead 	= true,
		len 	= self._recbuf:取头长()
	}
	__gge.print(false,7,"-------------------------------------------------------------------------\n")
	__gge.print(true,7,string.format('连接%s"%s:%s"-->', self._title,ip,port))
	if self._hp:Start(ip,port or 9527,async and 1 or 0) ==0 then
	    __gge.print(false,12,"失败！\n")
	    return false
	end
	return true
end
function hpclient:发送(...)
	self._sendbuf:添加数据(...)
	return self._hp:Send(self._sendbuf:取指针(),self._sendbuf:取长度()) == 1
end
function hpclient:发送_指针(dwConnID,pBuffer,iLength,iOffset)
	self._hp:Send(dwConnID,pBuffer,iLength,iOffset or 0)
end
function hpclient:断开()
	return self._hp:Stop() == 1
end
function hpclient:取连接ID()
	return self._hp:GetConnectionID()
end
function hpclient:OnConnect()
	__gge.print(false,10,"成功！\n")
	if self.连接成功 then
	    return __gge.safecall(self.连接成功,self)
	end
	return 0
end
function hpclient:OnSend(pData,iLength)
	if self.发送事件 then
	    return __gge.safecall(self.发送事件,self)
	end
	return 0
end
function hpclient:OnReceivePull(iLength)
	local required 	= self._info.len
	local remain 	= iLength
	while remain >= required do
		remain = remain -required --剩余数据长度
		local FR_OK = self._hp:Fetch(self._recbuf:取指针(),required)
		if FR_OK == 0 then
			if self._info.ishead then--是否是包头
				required = self._recbuf:校验头() --获取包体长度
				if required == 0 then --非法数据
				    self:断开()
				    break
				end
			else
				if self.数据到达 then
				    __gge.safecall(self.数据到达,self,unpack(self._recbuf:取数据()))
				end
				required = self._recbuf:取头长()--获取包头长度
			end
			self._info.ishead 	= not self._info.ishead
			self._info.len 		= required
		else
			break
		end
	end
	return 0
end
function hpclient:OnClose(so,ec)
	if so == 2 then
	    __gge.print(false,12,"失败！\n")
	end
	if self.连接断开 then
	    return __gge.safecall(self.连接断开,self,so,ec)
	end
	return 0
end

function hpclient:置缓冲区大小(v)
	self._hp:SetSocketBufferSize(v)
end
function hpclient:置心跳检查次数(v)
	self._hp:SetKeepAliveTime(v)
end
function hpclient:置心跳检查间隔(v)
	self._hp:SetKeepAliveInterval(v)
end
function hpclient:取缓冲区大小()
	return self._hp:GetSocketBufferSize()
end
function hpclient:取心跳检查次数()
	return self._hp:GetKeepAliveTime()
end
function hpclient:取心跳检查间隔()
	return self._hp:GetKeepAliveInterval()
end
function hpclient:是否连接()
	return self._hp:HasStarted() ==1
end
function hpclient:取状态()
	return self._hp:GetState()
end
function hpclient:取错误代码()
	return self._hp:GetLastError()
end
function hpclient:取错误描述()
	return self._hp:GetLastErrorDesc()
end
function hpclient:取未发出数据长度()
	return self._hp:GetPendingDataLength()
end
function hpclient:置缓存池大小()
	self._hp:SetFreeBufferPoolSize()
end
function hpclient:置缓存池回收阀值()
	self._hp:SetFreeBufferPoolHold()
end
function hpclient:取缓存池大小()
	return self._hp:GetFreeBufferPoolSize()
end
function hpclient:取缓存池回收阀值()
	return self._hp:GetFreeBufferPoolHold()
end
return hpclient