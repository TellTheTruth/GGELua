
local 资源类 = class()

function 资源类:初始化()
	self.目录 = 'data/ui/'
	self.缓存表 = {}
end

function 资源类:取纹理(文件)
	if self.缓存表[文件] then
	    return self.缓存表[文件]
	end
	if 引擎.文件是否存在(self.目录..文件) then
		local TE = require("gge纹理类")(self.目录..文件)
		print(文件)
		self.缓存表[文件] = TE
		return TE
	else
		print("文件不存在"..self.目录..文件)
	end
end
function 资源类:取精灵(文件)
	return require("gge精灵类")(self:取纹理(文件))
end

return 资源类