-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-01-27 03:51:34
-- @最后修改来自: baidwwy
-- @Last Modified time: 2016-07-07 11:33:07
--<<=========================================================================================>>--
--图像类
local ffi 	= require("ffi")
local _tostring = function (t) return "ggeImage",tostring(t._obj) end
--<<=========================================================================================>>--
local ggeobj = class()
rawset(ggeobj, '__new__', require("__ggeimage__"))
function ggeobj:初始化(...)
	local arg = {...}
	local lt = type(arg[1])
	self._obj = ggeobj.__new__()

	if(lt == "string")then
		if type(arg[2])  == "number" and #arg[1] > 256 then--2为指针长度
			local ptr 	= tonumber(ffi.cast("intptr_t",arg[1]))
			assert(self._obj:Image_LoadMem(ptr,arg[2],arg[3] or 0), "载入失败.")
		else--2为透明颜色
			assert(self._obj:Image_LoadFile(arg[1],arg[2] or 0), string.format('载入失败:"%s"', arg[1]))
		end
	elseif(lt == "number")then
		if type(arg[2])  == "number" then--2为指针长度
			assert(self._obj:Image_LoadMem(arg[1],arg[2],arg[3] or 0), "载入失败.")
		else
			self._obj:SetP(arg[1]) --gge图像指针
		end
	elseif(lt == "cdata")then
		local ptr 	= tonumber(ffi.cast("intptr_t",arg[1]))
		assert(self._obj:Image_LoadMem(ptr,arg[2],arg[3] or 0), "载入失败.")
	end
	self._obj:SetL(__gge.state)
	self._ptr = self._obj:GetP()--指针
	self._isok = self._ptr >0

	self.包围盒 = require ("gge包围盒")(0,0,self:取宽度(),self:取高度())
	--getmetatable(self).__tostring = _tostring
end

function ggeobj:取包围盒()
	return self.包围盒
end
function ggeobj:检查点(...)
	return self.包围盒:检查点(...)
end
function ggeobj:显示(x,y)
	if type(x) == 'table' then
	    y,x = x.y,x.x
	end
	if(self._isok)then
		self.x,self.y = x or 0,y or 0
		self.包围盒:置坐标(self.x,self.y)
		self._obj:Render(self.x,self.y)
	end
end

function ggeobj:锁定(v)
	if(self._isok)then
		self.islock = self._obj:Lock(v)
		return self.islock
	end
end
function ggeobj:解锁()
	if(self._isok)then
		self.islock = false
		self._obj:Unlock() end
end
function ggeobj:取像素(x,y)
	if type(x) == 'table' then
	    y,x = x.y,x.x
	end
	if(self._isok)then
		if(not self.islock)then self:锁定(true) end
		if self:检查点(x,y) then
			if self.x then
			    return self._obj:GetPixel(x-self.x,y-self.y)
			end
		end
	end
	return 0
end
function ggeobj:置像素(x,y,v)
	if(self._isok and self.islock)then  self._obj:SetPixel(x,y,v) end
end
function ggeobj:置区域(x,y,w,h)
	if(self._isok)then  self._obj:SetRect(x,y,w,h) end
	return self
end
function ggeobj:置颜色(v)
	if(self._isok)then  self._obj:SetColor(v) end
end
function ggeobj:置Z轴(v)
	if(self._isok)then  self._obj:SetZ(v) end
end
function ggeobj:置混合(v)
	if(self._isok)then  self._obj:SetBlendMode(v) end
end
function ggeobj:置过滤(v)
	if(self._isok)then  self._obj:SetTextureFilter(v) end
end
function ggeobj:置翻转(x,y)
	if(self._isok)then  self._obj:SetFlip(x,y) end
end
function ggeobj:取颜色()
	if(self._isok)then return self._obj:GetColor() end
end
function ggeobj:取Z轴()
	if(self._isok)then return self._obj:GetZ() end
end
function ggeobj:取混合()
	if(self._isok)then return self._obj:GetBlendMode() end
end
function ggeobj:是否过滤()
	if(self._isok)then return self._obj:IsTextureFilter() end
end
function ggeobj:是否翻转()
	if(self._isok)then return unpack(self._obj:GetFlip()) end
end

function ggeobj:取宽度()
	if(self._isok)then return self._obj:GetWidth() end
	return 0
end
function ggeobj:取高度()
	if(self._isok)then return self._obj:GetHeight() end
	return 0
end

function ggeobj:取指针()
	return self._ptr
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