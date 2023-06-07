-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-01-27 03:51:34
-- @最后修改来自: baidwwy
-- @Last Modified time: 2016-07-07 11:34:26
--<<=========================================================================================>>--
local __ggeSound = require "__ggesound__"
local _tostring = function (t) return "ggeSound",tostring(t._obj) end
--<<=========================================================================================>>--

local ggeobj = class()

function ggeobj:初始化(文件,大小,流)
	if type(文件) == "userdata" then
	    self._obj = 文件
	else
		self._obj = __ggeSound(文件,流 and true or false,大小 or 0)
	end

	self._ptr = self._obj:GetP()--指针
	self._isok = self._ptr >0
	--getmetatable(self).__tostring = _tostring
end

function ggeobj:播放(重复)
	if(self._isok and not self:是否播放())then return self._obj:Play(重复 or false) end
	return false
end
function ggeobj:播放_高级(音量,声道,频率,重复)
	if(self._isok)then return self._obj:PlayEx(音量 or 100,声道 or 0,频率 or 1,重复 or false) end
	return false
end
function ggeobj:是否播放()
	if(self._isok)then return self._obj:IsPlaying() end
	return false
end
function ggeobj:暂停()
	if(self._isok)then  self._obj:Pause() end
end
function ggeobj:停止()
	if(self._isok)then  self._obj:Stop() end
end
function ggeobj:恢复()
	if(self._isok)then  self._obj:Resume() end
end
function ggeobj:声道(v)
	if(self._isok)then  self._obj:SetPan(v or 0) end
end
function ggeobj:置音量(v)
	if(self._isok)then  self._obj:SetVolume(v or 100) end
end
function ggeobj:取音量()
	if(self._isok)then  return self._obj:GetVolume() end
end
function ggeobj:置频率(v)
	if(self._isok)then  self._obj:SetPitch(1) end
end
function ggeobj:取频率()
	if(self._isok)then  return self._obj:GetPitch() end
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