-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-01-27 03:51:34
-- @最后修改来自: baidwwy
-- @Last Modified time: 2016-05-29 23:32:13
--======================================================================--
local _tostring = function (t) return "ggeAnimation",tostring(t._obj) end
--======================================================================--

local ggeobj = class()
rawset(ggeobj, '__new__', require("__ggeanimation__"))

function ggeobj:初始化(纹理,帧数,帧率,宽度,高度,起始x,起始y)
	if tostring(纹理) == "ggeTexture" then
		self.纹理 	= 纹理
		self.宽度 = 宽度
		self.高度 = 高度
		self._obj = ggeobj.__new__(self.纹理:取指针(),帧数,帧率,宽度,高度,起始x or 0,起始y or 0)
		self.包围盒 = require ("gge包围盒")(0,0,宽度,高度)
	elseif type(纹理) == "string" then
		self.纹理 	= require("gge纹理类")(纹理)
		self.宽度 = 宽度
		self.高度 = 高度
		self._obj = ggeobj.__new__(self.纹理:取指针(),帧数,帧率,宽度,高度,起始x or 0,起始y or 0)
		self.包围盒 = require ("gge包围盒")(0,0,宽度,高度)
	elseif type(纹理) == "number" then
		self._obj:SetP(纹理)
	end
	self._obj:SetL(__gge.state)
	self._ptr = self._obj:GetP()--指针
	self._isok = self._ptr >0
	getmetatable(self).__tostring = _tostring
end

function ggeobj:取包围盒()
	return self.包围盒
end
function ggeobj:检查点(...)
	return self.包围盒:检查点(...)
end
function ggeobj:复制()
end
function ggeobj:克隆()
	if self._isok then return ggeobj(self._obj:Clone())end
end
function ggeobj:播放()
	if(self._isok)then self._obj:Play() end
	return self
end
function ggeobj:停止()
	if(self._isok)then self._obj:Stop() end
	return self
end
function ggeobj:继续()
	if(self._isok)then self._obj:Resume() end
	return self
end
function ggeobj:更新(dt)
	if(self._isok)then self._obj:Update(dt) end
	return self
end
function ggeobj:是否播放()
	if(self._isok)then return self._obj:IsPlaying() end
end
-- /// 播放模式
-- enum ANIMATION_MODE
-- {
-- 	ANI_FORWARD		= 0,	///< 向前播放
-- 	ANI_REVERSAL	= 1,	///< 向后播放
-- 	ANI_REPEAT	 	= 2,	///< 往返播放
-- 	ANI_NOREPEAT	= 0,	///< 不往返播放
-- 	ANI_LOOP		= 4,	///< 循环播放
-- 	ANI_NOLOOP		= 0,	///< 不循环
-- 	ANI_FORCE32BIT = 0x7FFFFFFF,
-- };
function ggeobj:置模式(v)
	if(self._isok)then self._obj:SetMode(v) end
	return self
end
function ggeobj:置帧率(v)
	if(self._isok)then self._obj:SetSpeed(v) end
	return self
end
function ggeobj:置当前帧(v)
	if(self._isok)then self._obj:SetFrame(v) end
	return self
end
function ggeobj:置帧数(v)
	if(self._isok)then self._obj:SetFrameNum(v) end
	return self
end
function ggeobj:取模式()
	if(self._isok)then return self._obj:GetMode() end
end
function ggeobj:取帧率()
	if(self._isok)then return self._obj:GetSpeed() end
end
function ggeobj:取当前帧()
	if(self._isok)then return self._obj:GetFrame() end
end
function ggeobj:取帧数()
	if(self._isok)then return self._obj:GetFrameNum() end
end

function ggeobj:显示(...)
	if(self._isok)then
		if not self._userpos then self:置坐标(...) end
		self._userpos = false
		self._obj:Render()
	end
	return self
end
function ggeobj:置坐标(x,y)
	if(self._isok)then
		if type(x) == 'table' then x,y=x.x or 0,x.y or 0 end
		self.x,self.y = x or 0,y or 0
		self.包围盒:置坐标(self.x,self.y)
		self._userpos = true
		self._obj:SetPosition(self.x,self.y)
		return self
	end
end
-- @param x x坐标
-- @param y y坐标
-- @param rotation 旋转弧度数
-- @param hscale 水平缩放系数
-- @param vscale 垂直缩放系数，若该值为0.0f，则取hscale
function ggeobj:置坐标_高级(x,...)
	if(self._isok)then
		local y,弧度,缩放x,缩放y
		if type(x)=='table' then
		    x,y=x.x,x.y
		    弧度,缩放x,缩放y = unpack({...})
		else
			y,弧度,缩放x,缩放y = unpack({...})
		end
		self.x,self.y = x or 0,y or 0
		self._obj:SetPositionEx(x,y,弧度 or 0,缩放x or 1,缩放y or 1)
		self._userpos = true
	end
	return self
end
--左上,右下
function ggeobj:置拉伸(x,y,x1,y1)
	if(self._isok)then
		if type(x)=='table' then
		    x,y=x.x or 0,x.y or 0
		end
		if type(y)=='table' then
		    x1,y1=y.x or 0,y.y or 0
		end
		self._obj:SetPositionStretch(x,y,x1,y1);
		self._userpos = true
		return self
	end
end
--左上,右上,左下,右下
function ggeobj:置顶点(...)
	local arg = {...}
	if(self._isok)then
		local x,y,x1,y1,x2,y2,x3,y3
		if type(arg[1] == 'table') then
		    x,y,x1,y1,x2,y2,x3,y3=arg[1].x,arg[1].y,arg[2].x,arg[2].y,arg[3].x,arg[3].y,arg[4].x,arg[4].y
		else
			x,y,x1,y1,x2,y2,x3,y3 = unpack(arg)
		end
		self._obj:SetPosition4V(x,y,x1,y1,x2,y2,x3,y3)
		self._userpos = true
	end
	return self
end
function ggeobj:置纹理(v)
	if(self._isok)then self._obj:SetTexture(v:取指针()) end
end
function ggeobj:置区域(x,y,w,h)
	self.包围盒:置宽高(w,h)
	if(self._isok)then self._obj:SetTextureRect(x,y,w,h);return self end
end
function ggeobj:置颜色(v)
	if(self._isok)then self._obj:SetColor(v,-1) end
end
function ggeobj:置Z轴(v,i)
	if(self._isok)then self._obj:SetZ(v,i or -1) end
end
function ggeobj:置混合(v)
	if(self._isok)then self._obj:SetBlendMode(v) end
end
function ggeobj:置过滤(v)
	if(self._isok)then self._obj:SetTextureFilter(v) end
end
function ggeobj:置中心(x,y)
	if(self._isok)then
		self.中心x = x or self.中心x
		self.中心y = y or self.中心y
		self._obj:SetHotSpot(self.中心x,self.中心y);
		self.包围盒:置中心(self.中心x,self.中心y)
	end
	return self
end
function ggeobj:置翻转(x,y,h)
	if(self._isok)then self._obj:SetFlip(x,y,h) end
end
-----------------------------------------------------------------
function ggeobj:取精灵()
	if(self._isok)then return require("gge精灵类")(self._obj:GetSprite()) end
	return 0
end
-- function ggeobj:取纹理()
-- 	if(self._isok)then return self.纹理 end
-- end
-- function ggeobj:取区域()
-- 	-- body
-- end
function ggeobj:是否过滤()
	if(self._isok)then return self._obj:IsTextureFilter() end
end
function ggeobj:取颜色(i)
	if(self._isok)then return self._obj:GetColor(i or 0) end
end
function ggeobj:取Z轴(i)
	if(self._isok)then return self._obj:GetZ(i or 0) end
end
function ggeobj:取混合()
	if(self._isok)then return self._obj:GetBlendMode() end
end
function ggeobj:取中心()--GetHotSpot
	return self.中心x,self.中心y
end
function ggeobj:取翻转()--GetFlip
	return self.翻转x,self.翻转y
end
function ggeobj:取宽度()
	if(self._isok)then return self.宽度 end
	return 0
end
function ggeobj:取高度()
	if(self._isok)then return self.高度 end
	return 0
end
function ggeobj:取包围盒(gge)
	if self._isok and gge then
		local b = require("gge包围盒")(1,1,1,1,true)
		self._obj:GetBoundingBox(b:取指针(),0,0)
		return b
	end
	return self.包围盒
end
function ggeobj:取包围盒_高级(x,y,弧度,缩放x,缩放y)
	if self._isok and gge then
		local b = require("gge包围盒")(1,1,1,1,true)
		self._obj:GetBoundingBoxEx(b:取指针(),x,y,弧度 or 0,缩放x or 1,缩放y or 1)
		return b
	end
end
-----------------------------------------------------------------
function ggeobj:取指针()
	return self._ptr
end
function ggeobj:置指针(p)
	self._ptr = p
	self._obj:SetP(p)
end
function ggeobj:取引用总数()
	if(self._isok)then  return self._obj:GetRefCount() end
end
function ggeobj:加引用()
	if(self._isok)then  self._obj:AddRef();return self end
end
function ggeobj:释放()
	if(self._isok)then
		self._obj:Release()
		self._isok = self._obj:GetRefCount()>0
	end
end
return ggeobj