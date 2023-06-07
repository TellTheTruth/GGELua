local __zip = require("minizip")
local ffi = require("ffi")
local zip = class()

function zip:初始化(len)
	self.z = __zip()
	self.len = len or 10485760
	self.char = ffi.new('char[?]',self.len) --10M
	self.p = tonumber(ffi.cast("intptr_t",self.char))
end

function zip:打开(path,password)

	self.isok 	= self.z:Open(path) ~=0

	self.psd 	= password
	return self
end
function zip:取指针()
	return self.p
end
function zip:取全局信息()
	return self.z:GetGlobalInfo()
end
function zip:取注释()
	local t = self.z:GetGlobalInfo()
	self.z:GetGlobalComment(self.p,t.size_comment)
	return ffi.string(self.char,t.size_comment)
end
function zip:到首文件()
	return self.z:GoToFirstFile()
end
function zip:到下一文件()
	return self.z:GoToNextFile()
end
function zip:到指定文件(path)
	return self.z:LocateFile(path,0) ==0
end
function zip:打开文件()
	if self.psd then
		return self.z:OpenCurrentFilePassword(self.psd)
	else
		return self.z:OpenCurrentFile()
	end
end
function zip:关闭文件()
	return self.z:CloseCurrentFile()
end
function zip:读取文件()
	return self.z:ReadCurrentFile(self.p,self.len)
end
function zip:取文件信息(path)
	self.z:LocateFile(path,0)
	return self.z:GetCurrentFileInfo()
end
function zip:取数据(path)
	self.z:GoToFirstFile()
	if self.z:LocateFile(path,0) then
		self:打开文件()
		local len = self.z:ReadCurrentFile(self.p,self.len)
		self.z:CloseCurrentFile()
		return len
	end
	return 0
end
function zip:取图像(path)
	local len = self:取数据(path)
	if len > 0 then
		return require("gge图像类")(self.p,len)
	else
	    return require("gge图像类")()
	end
end
function zip:取纹理(path)
	local len = self:取数据(path)
	if len > 0 then
		return require("gge纹理类")(self.p,len)
	else
	    return require("gge纹理类")()
	end
end
function zip:取精灵(path)
	return require("gge精灵类")(self:取纹理(path))
end
function zip:取文本(path)
	local len = self:取数据(path)
	if len > 0 then
		return ffi.string(self.char,len)
	else
	    return ""
	end
end
return  zip