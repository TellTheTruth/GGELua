-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2016-06-03 20:07:58
-- @最后修改来自: baidwwy
-- @Last Modified time: 2016-10-30 15:43:10

local ggeobj = class()


function ggeobj:检查点(...)
	if self.包围盒 then
	    return self.包围盒:检查点(...)
	end
end
function ggeobj:置Z轴(v,i)
	if(self._isok)then self._obj:SetZ(v,i or -1) end
end
function ggeobj:置混合(v)
	if(self._isok)then self._obj:SetBlendMode(v or 0) end
	return self
end
function ggeobj:取Z轴(i)
	if(self._isok)then return self._obj:GetZ(i or 0) end
end
function ggeobj:取混合()
	if(self._isok)then return self._obj:GetBlendMode() end
end
function ggeobj:取宽度()
	if(self._isok)then return self._obj:GetWidth() end
	return 0
end
function ggeobj:取高度()
	if(self._isok)then return self._obj:GetHeight() end
	return 0
end
return ggeobj