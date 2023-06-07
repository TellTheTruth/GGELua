--======================================================================--
--该 文件由GGELUA创建
--
--作者：baidwwy  创建日期：2014-05-17 16:26:08
--======================================================================--
local __was = require "glow.was"

local WAS类 = class()


function WAS类:初始化(文件,长度)
	self.was = __was()
	self.was:SetL(__gge.state)
	if self.was:OpenFile(文件,长度 or 0) then
		local head = self.was:GetHeaderInfo()
		self.方向数 = head.Group
		self.x = head.Key_X
		self.y = head.Key_Y
		self.帧数 = head.Frame
		self.宽度 =	head.Width
		self.高度 = head.Height
	else
		print("打开失败->"..文件)
	end

end
function WAS类:置调色板(文件)
	self.was:SetPal(文件)
	return self
end
function WAS类:调色(...)
	self.was:ChangePal(...)
end
function WAS类:取纹理(fid)
	local tex = self.was:GetPic(fid)
	local t = self.was:GetFrameInfo()
	if tex>0 then
	    t.纹理 = require ("gge纹理类")(tex)
	else
		t.纹理 = require ("gge纹理类")():空白纹理()
	end

	return t
end


function WAS类:取精灵(fid)
	local t = self:取纹理(fid)
	local 精灵 = require("gge精灵类").创建(t.纹理)
	t.精灵 = 精灵
	return t
end

return WAS类