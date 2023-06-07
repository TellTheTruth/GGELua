--======================================================================--
--该 文件由GGELUA创建
--
--作者：baidwwy  创建日期：2014-07-13 19:35:10
--======================================================================--
local __wzl = require("mir.wzl")
local wzl = class()


function wzl:初始化(文件)
	self.wzl = __wzl()
	self.num = self.wzl:OpenFile(文件)

	if self.num == -1 then
	    print('打开wzx失败!'..文件)
	elseif self.num == -2 then
		print('打开wzl失败!'..文件)
	end
end


function wzl:取纹理(i,o)
	if i>=0 and i<self.num then
		local t = self.wzl:GetInfo(i)
	    return  require("gge纹理类")(self.wzl:GetPic(i,not o))
	end
end


function wzl:取精灵(i,o)
	local wl = self:取纹理(i,o)

	if wl then
		local t = self.wzl:GetInfo(i)
		t.精灵 = require("gge精灵类")(wl)
	    return  t
	end
end

return wzl