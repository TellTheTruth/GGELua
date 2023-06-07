--======================================================================--
--该 文件由GGELUA创建
--
--作者：baidwwy  创建日期：2014-07-09 23:45:57
--======================================================================--
local __wil = require("mir.wil")
local wil = class()


function wil:初始化(文件)
	self.wil = __wil()
	self.num = self.wil:OpenFile(文件)
	self.cache ={}
	if self.num == -1 then
	    print('打开wix失败!'..文件)
	elseif self.num == -2 then
		print('打开wil失败!'..文件)
	end
end


function wil:取纹理(i,o)
	if self.cache[i] then
	    return self.cache[i]
	end
	if i>=0 and i<self.num then
		self.cache[i] = require("gge纹理类")(self.wil:GetPic(i,not o))
	    return  self.cache[i]
	end
	return  require("gge纹理类")()
end
function wil:取信息(i)
	return self.wil:GetInfo(i)
end

function wil:取精灵(i,o)
	return  require("gge精灵类")(self:取纹理(i,o))
end

return wil