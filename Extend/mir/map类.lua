-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-05-28 03:51:56
-- @最后修改来自: baidwwy
-- @Last Modified time: 2015-05-28 14:36:24

local __map = require("mir.map")
local map = class()


function map:初始化(文件)
	self.map = __map()
	self.num = self.map:OpenFile(文件)

	if self.num == -1 then
	    error('打开map失败!'..文件)
	else

		self.head = self.map:GetHead()
	end
end


function map:取信息(i)
	return  self.map:GetInfo(i)
end



return map