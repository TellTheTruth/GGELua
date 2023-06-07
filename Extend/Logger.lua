-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2016-04-17 19:35:04
-- @最后修改来自: baidwwy
-- @Last Modified time: 2016-10-15 15:00:39

local logger = class()
local ffi = require( "ffi" )
ffi.cdef[[
	int 	_access(const char*, int);
	void* 	ILogger_Create();
	int 	ILogger_Init(void*,const char*,int,int);
	void 	ILogger_Log_0(void*,int,const char*);
	int 	ILogger_UnInit(void*);
	void 	ILogger_Destroy(void*);
]]

local Logdll
if ffi.C._access(__gge.runpath.."/lib/Logger.dll",0) == 0 then
    Logdll = ffi.load("./lib/Logger.dll")
else
	Logdll = ffi.load("Logger.dll")
end

function logger:初始化(文件)
	if type(文件) == 'number' then
	    self.log 	= ffi.cast("void*",文件)
	else
		self.log 	= Logdll.ILogger_Create()
		self.isok 	= Logdll.ILogger_Init(self.log,文件 or  "",__gge.isdebug and 1 or 3,1)
	end
end
function logger:销毁()--logger不能自动销毁
	Logdll.ILogger_UnInit(self.log)
	Logdll.ILogger_Destroy(self.log)
end
function logger:取指针()
	return tonumber(ffi.cast("intptr_t",self.log))
end
function logger:log(str,t)--追踪
	Logdll.ILogger_Log_0(self.log,t or 3,tostring(str))
end
function logger:debug(str)--调试(游戏编译后,会无效)
	Logdll.ILogger_Log_0(self.log,1,tostring(str))
end
function logger:trace(str)--追踪(游戏编译后,会无效)
	Logdll.ILogger_Log_0(self.log,2,tostring(str))
end
function logger:info(str)--信息
	Logdll.ILogger_Log_0(self.log,3,tostring(str))
end
function logger:warn(str)--警告
	Logdll.ILogger_Log_0(self.log,4,tostring(str))
end
function logger:error(str)--错误
	Logdll.ILogger_Log_0(self.log,5,tostring(str))
end
function logger:fatal(str)--致命
	Logdll.ILogger_Log_0(self.log,6,tostring(str))
end

return logger