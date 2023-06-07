-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2016-05-22 20:51:34
-- @最后修改来自: baidwwy
-- @Last Modified time: 2016-05-28 08:40:26
local _tostring = function (t) return "ggeShader",tostring(t._obj) end
local __new__ = require("__ggeshader__")
local ggeobj = class()


function ggeobj:初始化()
	self._obj = __new__()
end
-- @brief 载入Shader文件
-- @param filename 文件名
-- @param function 入口函数名
-- @param psVersion PixelShader版本
-- @return 成功返回ggeShader*，失败返回0
function ggeobj:载入__从文本(filename,func,psVersion)
	local r = self._obj:Shader_Create(filename,func,psVersion or 5)
	self._ptr = self._obj:GetP()--指针
	return r
end
-- @brief 从字符串创建Shader
-- @param shaderstr shader字符串
-- @param function 入口函数名
-- @param psVersion PixelShader版本
-- @return 成功返回ggeShader指针，失败返回0
function ggeobj:载入__从文件(shaderstr,func,psVersion)
	local r = self._obj:Shader_Load(shaderstr,func,psVersion)
	self._ptr = self._obj:GetP()--指针
	return r
end
-- @brief 设置纹理，必须先调用Shader_SetCurrentShader()函数设置当前Shader
-- @param name 纹理名
-- @param tex 纹理
-- @param bFilter 是否开启纹理过滤
-- @param texAddres 纹理寻址模式
-- @param borderColor 边框颜色寻址所用的边框颜色
-- @return 成功返回true，失败返回false
		-- TEXADDRESS_WRAP = 1,	///< 重叠映射寻址
		-- TEXADDRESS_MIRROR = 2,	///< 镜像纹理寻址
		-- TEXADDRESS_CLAMP = 3,	///< 夹取纹理寻址
		-- TEXADDRESS_BORDER = 4,	///< 边框颜色寻址
function ggeobj:置纹理(name,tex,bFilter,texAddres,borderColor)
	self._obj:SetTexture(name,tex:取指针(),bFilter,texAddres or 1,borderColor or 0)
	return self
end
-- @brief 设置float类型值，必须先调用Shader_SetCurrentShader()函数设置当前Shader
-- @param name 变量名
-- @param f 变量值
-- @return 成功返回true，失败返回false
function ggeobj:置变量(name,f)

end
----------------------------------------------------------------
function ggeobj:取指针()
	return self._ptr
end
function ggeobj:置指针(v)--注意释放
	self._obj:SetP(v)
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