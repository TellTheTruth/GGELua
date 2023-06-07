-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-11-13 10:12:10
-- @最后修改来自: baidwwy
-- @Last Modified time: 2016-11-16 06:21:24

local __ggethread = require("__ggethread__")

local thread = class()

function thread:初始化(main)
	print(type(main));
	assert(main, '请设置线程初始脚本文件.')
	print(main);
	self.obj = __ggethread(main,self)
end

function thread:启动(延迟)
	print(延迟)
	self.dwThread = self.obj:Start(延迟 or 10)
	return self
end

function thread:停止()
	self.obj:Stop()
end

function thread:置延迟(v)
	self.obj:SetSleep(v)
end

function thread:OnMsg(...)
	if self.消息返回 then
		return __gge.safecall(self.消息返回,self,...)
	end
end
return thread