-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2016-06-03 20:04:00
-- @最后修改来自: baidwwy
-- @Last Modified time: 2016-10-30 15:36:00

local ggeobj = class()


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
		self._isok = self._obj:Release()
	end
end

return ggeobj