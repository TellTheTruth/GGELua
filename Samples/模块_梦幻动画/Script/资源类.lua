
资源类 = {}
local ffi = require("ffi")

function 资源类:初始化()
	self.wdf = {}
	self.char = ffi.new('char[10485760]')
	self.p = tonumber(ffi.cast("intptr_t",self.char))
end


function 资源类:打开(file)
	self.wdf[file] = require("Glow/WDF类")(string.format("G:/素材客户端/梦幻西游/%s.wdf", file),self.p,10485760 )
end


function 资源类:取文件(file,id)
	return self.wdf[file]:取文件(id)
end

资源类:初始化()