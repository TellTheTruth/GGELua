-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2016-05-05 19:13:38
-- @最后修改来自: baidwwy
-- @Last Modified time: 2016-05-31 22:33:18
local __ggeThread = require("__ggethread__")

local 线程类 = class()

function 线程类:初始化(脚本)
	assert(脚本, '请设置线程初始脚本文件.')
	self.obj = __ggeThread(脚本,self)
end

function 线程类:启动(延迟)
	return self.obj:Start(延迟 or 10)
end

function 线程类:停止()
	self.obj:Stop()
end

function 线程类:置延迟(v)
	self.obj:SetSleep(v)
end
function 线程类:OnMsg(...)
	if self.消息返回 then
	    return __gge.safecall(self.消息返回,self,...)
	end
end


return 线程类