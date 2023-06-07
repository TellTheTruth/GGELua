--======================================================================--
--该 文件由GGELUA创建
--
--作者：baidwwy  创建日期：2014-07-15 13:23:37
--======================================================================--
local function table_read_only(t,t1)
	local 源表 = t
	local 验证表 = t1
	local temp=  {}
	local mt = {
	__index = 源表,
	__newindex = function(t, k, v)
		if 源表[k] == bit.bxor(验证表[k],9527) then
		   源表[k] = v
		   验证表[k] = bit.bxor(v,9527)
		else
			__gge.messagebox("你作弊了!")
		end

	end
	}
	setmetatable(temp, mt)
	return temp
end

local 属性 = {}
属性.等级 = 39
属性.经验 = 100

local 验证 = {}
for i,v in pairs(属性) do
	验证[i] = bit.bxor(v,9527)
end

return table_read_only(属性,验证)