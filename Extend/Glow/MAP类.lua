-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-04-14 10:11:28
-- @最后修改来自: baidwwy
-- @Last Modified time: 2017-05-20 20:33:15

local __map = require "glow.map"
local MAP类 = class()


function MAP类:初始化(文件,指针,长度)
	self.map = __map()
	self.map:SetL(__gge.state)
	self.p = 指针
	if self.map:OpenFile(文件,指针,长度) then
		local h  = self.map:GetHeaderInfo()
		self.宽度 = h.Width
		self.高度 = h.Height
		self.行数 = h.MapRowNum
		self.列数 = h.MapColNum
		self.数量 = h.MapNum
		self.遮罩数量 = h.MaskNum
	else
		error("打开失败->"..文件)
	end
	self.纹理 = {}
	self.遮罩 = {}
end

function MAP类:取纹理(id)
	assert(id>=0 and id<self.数量, "地图id错误")
	if not self.纹理[id] then
		--assert(self.map:GetPic(id), os.clock().."取地图纹理错误id"..id)
	    self.纹理[id] =  require ("gge纹理类")(self.map:GetPic(id))
	end
	return self.纹理[id]
end
function MAP类:取精灵(id)
	local 纹理 =  self:取纹理(id)
	local 精灵 = require("gge精灵类")(纹理)
	return 精灵
end
function MAP类:取遮罩ID(id)--取地表附加的遮罩ID
	return self.map:GetMaskID(id)
end
function MAP类:取遮罩(id)
	assert(id>=0 and id<self.遮罩数量, "遮罩id错误")
	if not self.遮罩[id] then
	    self.遮罩[id] =  require ("gge纹理类")(self.map:GetMask(id))
	end
	local 精灵 = require("gge精灵类")(self.遮罩[id])
	return 精灵
end
function MAP类:取障碍()
	return self.p,self.map:GetCell()
end
function MAP类:取遮罩信息(id)
	return self.map:GetMaskInfo(id)
end
return MAP类