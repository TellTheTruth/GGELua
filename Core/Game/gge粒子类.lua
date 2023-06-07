-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2016-04-17 19:35:04
-- @最后修改来自: baidwwy
-- @Last Modified time: 2016-05-26 23:17:07

local __ggeParticle = require "__ggeparticle__"

local _tostring = function (t) return "ggeParticle",tostring(t._obj) end
local ggeobj = class()


function ggeobj:初始化(info)
	self._obj = __ggeParticle()
	-- self.p = self._obj:GetP()--指针
	-- self._isok = self.p >0
end

function ggeobj:更新(dt)
	if self._isok then self._obj:Update(dt) end
end
function ggeobj:显示(x,y)
	if self._isok then self:置坐标(x,y);self._obj:Render() end
end
function ggeobj:置坐标(x,y)
	if self._isok then self._obj:FireAt(x,y) end
end
function ggeobj:启动()
	if self._isok then self._obj:Fire() end
end
function ggeobj:停止(b)
	if self._isok then self._obj:Stop(b) end
end
function ggeobj:移动到(x,y,b)
	if self._isok then self._obj:MoveTo(x,y,b) end
end
function ggeobj:置缩放(v)
	if self._isok then self._obj:SetScale(v) end
end
function ggeobj:置位移(x,y)
	if self._isok then self._obj:Transpose(x,y) end
end
function ggeobj:置跟踪(b)
	if self._isok then self._obj:TrackBoundingBox(b) end
end
function ggeobj:置精灵(v)
	if self._isok then self._obj:SetSprite(v:取指针()) end
end
function ggeobj:取总数()
	if self._isok then return self._obj:GetParticleCount() end
end
function ggeobj:取活动数()
	if self._isok then return self._obj:GetParticlesAlive() end
end
function ggeobj:取时间()
	if self._isok then return self._obj:GetAge() end
end
function ggeobj:取缩放()
	if self._isok then return self._obj:GetScale() end
end
-----------------------------------------------------------------
function ggeobj:取指针()
	return self.p
end
function ggeobj:置指针(p)
	self._obj:SetP(p)
	self._isok = true
	return self
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