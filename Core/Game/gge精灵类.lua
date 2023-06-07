-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-01-27 03:51:34
-- @最后修改来自: baidwwy
-- @Last Modified time: 2017-05-07 10:22:43
--<<=========================================================================================>>--
local _tostring = function (t) return "ggeSprite",tostring(t._obj) end
--<<=========================================================================================>>--
local 引用基类 	= require("gge基类/引用")
local 通用基类 	= require("gge基类/通用")
local __new 	= require("__ggesprite__")
local ggeobj 	= class(引用基类,通用基类)
rawset(ggeobj, '__setnew', function (v)
	__new = v
end)

function ggeobj:初始化(纹理,x,y,宽度,高度)
	if tostring(纹理) == "ggeTexture" then
	    self.纹理 	= 纹理
	    self._obj 	= __new(self.纹理:取指针(),x or 0 ,y or 0,宽度 or 0,高度 or 0)
	elseif type(纹理) == "string" then
		self.纹理 	= require("gge纹理类")(纹理)
		self._obj 	= __new(self.纹理:取指针(),x or 0 ,y or 0,宽度 or 0,高度 or 0)
	elseif type(纹理) == "number" and 纹理 ~= 0 then
		self._obj 	= __new(-1)
		self._obj:置指针(纹理)
	else
		self._obj 	= __new(0,x or 0 ,y or 0,宽度 or 0,高度 or 0)
	end
	self._obj:SetL(__gge.state)
	self._ptr 		= self._obj:GetP()--指针
	self._isok 		= self._ptr >0
	self.宽度 		= self:取宽度()
	self.高度 		= self:取高度()
	self.包围盒 	= require ("gge包围盒")(0,0,self.宽度,self.高度)
	self.高亮 		= false
	self.高亮颜色 	= 0xffffffff
	self.颜色 		= 0xffffffff
	self.中心x 		= 0
	self.中心y 		= 0
	self.翻转x 		= false
	self.翻转y 		= false
	self.区域x 		= 0
	self.区域y 		= 0
	self.区域w 		= self.宽度
	self.区域h 		= self.高度
	self.x 			= 0
	self.y 			= 0
	self.旋转弧度 	= 0
	self.水平缩放 	= 0
	self.垂直缩放 	= 0
	self.拉伸宽度 	= 0
	self.拉伸高度 	= 0
	getmetatable(self).__tostring = _tostring
end

function ggeobj:取像素(x,y)
	if type(x) == 'table' then x,y=x.x or 0,x.y or 0 end
	if self.纹理 and x and y and self:检查点(x,y) then
		return self.纹理:取像素(x-self.x+self.中心x,y-self.y+self.中心y)
	end
	return 0
end
function ggeobj:灰度级()
	if self.纹理 then
	    self.纹理:灰度级()
	end
	return self
end
function ggeobj:置高亮(v,c)
	self.高亮 = v
	self.高亮颜色 = c or self.高亮颜色
	return self
end
function ggeobj:取高亮()
	return self.高亮
end
function ggeobj:置旋转(弧度)--默认0
	self.旋转弧度 	= 弧度
	return self
end
function ggeobj:置缩放(水平,垂直)--默认1
	self.水平缩放 	= 水平
	self.垂直缩放 	= 垂直
	return self
end
function ggeobj:置拉伸(宽度,高度)--默认0
	self.拉伸宽度 	= 宽度
	self.拉伸高度 	= 高度
	return self
end
----------------------------------------------------------------------------
function ggeobj:克隆()
	if(self._isok)then
		return ggeobj(self._obj:Clone())
	end
end
function ggeobj:显示(x,y)
	if(self._isok)then
		if type(x) == 'table' then x,y=x.x or 0,x.y or 0 end
		if self.拉伸宽度>0 or self.拉伸高度>0 then
			self._obj:SetPositionStretch(x,y,x+self.拉伸宽度,y+self.拉伸高度);
		elseif self.旋转弧度>0 or self.水平缩放>0 or self.垂直缩放>0 then
			self._obj:SetPositionEx(x,y,self.旋转弧度,self.水平缩放,self.垂直缩放)
		elseif not self._userpos then
			self:置坐标(x,y)
			self._userpos = false
		end
		self._obj:Render()
		if self.高亮 then
			self._obj:SetBlendMode(2)
			self._obj:SetColor(self.高亮颜色,-1)
			self._obj:Render()
		    self._obj:SetBlendMode(0)
		    self._obj:SetColor(self.颜色,-1)
		end

	end
	return self
end
function ggeobj:置坐标(x,y)
	if(self._isok)then
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
-- function ggeobj:置坐标_高级(x,y,弧度,缩放x,缩放y)
-- 	if(self._isok)then
-- 		self.x,self.y = x or 0,y or 0
-- 		self._obj:SetPositionEx(x,y,弧度 or 0,缩放x or 1,缩放y or 1)
-- 		self._userpos = true
-- 	end
-- 	return self
-- end
--左上,右下
-- function ggeobj:置拉伸(x,y,x1,y1)
-- 	if(self._isok)then
-- 		if type(x)=='table' then
-- 		    x,y=x.x or 0,x.y or 0
-- 		end
-- 		if type(y)=='table' then
-- 		    x1,y1=y.x or 0,y.y or 0
-- 		end
-- 		self._obj:SetPositionStretch(x,y,x1,y1);
-- 		self._userpos = true
-- 		return self
-- 	end
-- end
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
function ggeobj:置纹理(纹理)
	if not 纹理 then
	   return self
	end
	self.纹理 = 纹理
	self.宽度 = self.纹理:取宽度()
	self.高度 = self.纹理:取高度()
	self.区域w 		= self.宽度
	self.区域h 		= self.高度
	self.包围盒:置宽高(self.宽度,self.高度)
	if(self._isok)then self._obj:SetTexture(纹理:取指针()) end
	return self
end
function ggeobj:置区域(x,y,w,h)
	self.区域w 		= w or self.区域w
	self.区域h 		= h or self.区域h
	self.包围盒:置宽高(self.区域w,self.区域h)
	if(self._isok)then self._obj:SetTextureRect(x,y,self.区域w,self.区域h); end
	return self
end
function ggeobj:置过滤(v)
	if(self._isok)then self._obj:SetTextureFilter(v) end
	return self
end
function ggeobj:置颜色(v,i)
	if(self._isok)then
		self.颜色 = v
		self._obj:SetColor(v,i or -1)
	end
	return self
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
-- @brief 设置纹理翻转属性
-- @param bX 水平翻转
-- @param bY 垂直翻转
-- @param bHotSpot 是否翻转原点
function ggeobj:置翻转(x,y,h)
	if(self._isok)then self._obj:SetFlip(x,y,h) end
end

function ggeobj:取纹理()
	if(self._isok)then return self.纹理 end
end
-- function ggeobj:取区域()
-- 	-- body
-- end
function ggeobj:是否过滤()
	if(self._isok)then return self._obj:IsTextureFilter() end
end
function ggeobj:取颜色(i)
	if(self._isok)then return self._obj:GetColor(i or 0) end
end
function ggeobj:取中心()--GetHotSpot
	return self.中心x,self.中心y
end
function ggeobj:取翻转()--GetFlip
	return self.翻转x,self.翻转y
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
	if self._isok  then
		local b = require("gge包围盒")(1,1,1,1,true)
		self._obj:GetBoundingBoxEx(b:取指针(),x,y,弧度 or 0,缩放x or 1,缩放y or 1)
		return b
	end
end

-----------------------------------------------------------------

function ggeobj:释放(tex)
	if self.纹理 and tex then
	    self.纹理:释放()
	end
	if(self._isok)then
		self._isok = self._obj:Release()
	end
end

return ggeobj