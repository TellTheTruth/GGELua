-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-01-27 03:51:34
-- @最后修改来自: baidwwy
-- @Last Modified time: 2017-03-05 10:04:14
local bit = require("bit")
-- function 左移(a,b)
-- 	return bit.lshift(a,b)
-- end
-- function 右移(a,b)
-- 	return bit.rshift(a,b)
-- end
-- function 位取反(a,b)
-- 	return bit.bnot(a,b)
-- end
-- function 位与(a,b)
-- 	return bit.band(a,b)
-- end
-- function 位或(a,b)
-- 	return bit.bor(a,b)
-- end
-- function 位异或(a,b)
-- 	return bit.bxor(a,b)
-- end
function ARGB(a,r,g,b)
	return bit.bor(bit.lshift(a,24) , bit.lshift(r,16) , bit.lshift(g,8) , b)
end
function RGB(r,g,b)
	return ARGB(255,r,g,b)
end
--lua51,Galaxy2d除外
function 置库目录(d)
	package.cpath = package.cpath ..string.format(';%s/?.dll', d)
end
--按分割每个字,添加到表
function 分割字符(str,tv)
	local t = tv or {}
	local i = 1
	local ascii = 0
	while true do
		ascii = string.byte(str, i)
		if ascii then
			if ascii < 127 then
				table.insert(t,string.sub(str, i, i))
				i = i+1
			else
				table.insert(t,string.sub(str, i, i+1))
			    i = i+2
			end
		else
		    break
		end
	end
	return t
end
string.splitchar = 分割字符
--for i,v in pairsi() do
function pairsi(t)
	local i = #t+1
	return function ()
		i=i-1
		if i>=1 then
		    return i,t[i]
		end
	end
end
--表序列化
table.tostring = function (t)
	if t then
		local mark		={}
		local assign	={}
		local function ser_table(tbl,parent)
			mark[tbl]=parent
			local tmp={}
			for k,v in pairs(tbl) do
				local key
				if type(k) == "number" then
				    key = "["..k.."]"
				elseif tonumber(k) ~= nil then
					key = "[".. string.format("%q", k) .."]"
				else
					key = k
				end
				if type(v) == "string" then
					table.insert(tmp, key.."=".. string.format("%q", v))
				elseif type(v) == "number" or type(v) == "boolean" then
					table.insert(tmp, key.."=".. tostring(v))
				elseif type(v)=="table" then
					local dkey = type(k)=="number" and "["..k.."]" or "[".. string.format("%q", k) .."]"
					local dotkey = parent.. dkey
					if mark[v] then
						table.insert(assign,dotkey.."="..mark[v])
					else
						table.insert(tmp, key.."="..ser_table(v,dotkey))
					end
				end
			end
			return "{"..table.concat(tmp,",").."}"
		end
		return ser_table(t,"ret")..table.concat(assign,";")
	end
end
table.itostring = function (t)
	if t then
		for i,v in ipairs(t) do
			if type(v) == 'table' then
			    t[i] = table.itostring(v)
			elseif type(v) ~= "number" then
				t[i] = string.format('%q', v)
			end
		end
		return "{"..table.concat(t,",").."}"
	end
end
--载入序列化表
table.loadstring = function (t)
	if t and type(t) == 'string' then--兼容
		local f = loadstring(t:byte() == 100 and t or ("do local ret="..t.." return ret end"))
		if f then
			setfenv(f, {})
			return f()
		end
	end
end
--表复制
table.copy = function (old_tab)
    local new_tab = {};
    if old_tab and type(old_tab)=='table' then
	    for i,v in pairs(old_tab) do
	        local vtyp = type(v);
	        if (vtyp == "table") then
	            new_tab[i] = table.copy(v);
	        elseif (vtyp == "string" or vtyp == "number" or vtyp == "boolean") then
	            new_tab[i] = v;
	        else
	        	error("不支持复制")
	        end
	    end
    end
    return new_tab;
end
--表打印
table.print = function (root)
	if root then
		local print = print
		local tconcat = table.concat
		local tinsert = table.insert
		local srep = string.rep
		local type = type
		local pairs = pairs
		local tostring = tostring
		local next = next
		local cache = {  [root] = "." }
		local function _dump(t,space,name)
			local temp = {}
			for k,v in pairs(t) do
				local key = tostring(k)
				if cache[v] then
					tinsert(temp,"." .. key .. " {" .. cache[v].."}")
				elseif type(v) == "table" then
					local new_key = name .. "." .. key
					cache[v] = new_key
					tinsert(temp,"." .. key .. _dump(v,space .. (next(t,k) and "|" or " " ).. srep(" ",#key),new_key))
				else
					tinsert(temp,"." .. key .. " [" .. tostring(v).."]")
				end
			end
			return tconcat(temp,"\n"..space)
		end
		print(_dump(root, "",""))
		print('-------------------------------------')
	end
end
--分割文本(文本,分割符)
string.split = function (str, mark)
	if str  then
	    local result = {}
	    if mark == '%' then
	    	mark = "([^"..mark.."%]+)"
	    else
	    	mark = "([^"..mark.."]+)"
	    end
	    for match in str:gmatch(mark) do
	        table.insert(result, match)
	    end
	    return result
	end
	return {}
end
-- string.split = function (s, p)
-- 	if s then
-- 	    local rt= {}
-- 	    string.gsub(s, '[^'..p..']+', function(w) table.insert(rt, w) end )
-- 	    return rt
-- 	end
-- 	return {}
-- end
--只适合小数四舍五入(数值,小数位)
math.round = function (num, idp)
  return tonumber(string.format("%." .. (idp or 0) .. "f", num))
end
--适合小数和整数
math.iround = function (num, idp)
	local mult = 10^(idp or 0)
	return math.floor(num * mult + 0.5) / mult
end

function ip_to_int(ip)--IP地址转整数IP
	local c = string.split(ip,".")
	return bit.bor(bit.lshift(c[1], 24),bit.lshift(c[2], 16),bit.lshift(c[3], 8),c[4])
end
function int_to_ip(int)--整数IP转到文本地址
	local ip = bit.rshift(int, 24) .. "."
	ip = ip..bit.band(bit.rshift(int, 16),255).."."
	ip = ip..bit.band(bit.rshift(int, 8),255).."."
	return ip..bit.band(int,255)
end
function _inc(id,len) --自增
	local id = id or 0
	local len = len or 1
	return function (i)
		id = id + (i or len)
		return id
	end
end
function _dec(id,len) --自减
	local id = id or 0
	local len = len or 1
	return function (i)
		id = id - (i or len)
		return id
	end
end
function inc(id,len) --后自增
	local id = id or 0
	local len = len or 1
	return function (i)
		local oid = id
		id = id + (i or len)
		return oid
	end
end
function dec(id,len) --后自减
	local id = id or 0
	local len = len or 1
	return function (i)
		local oid = id
		id = id - (i or len)
		return oid
	end
end
--整数到4字节
function int_to_byte(v)
	return bit.rshift(v, 24),bit.band(bit.rshift(v, 16),255),bit.band(bit.rshift(v, 8),255),bit.band(v,255)
end
--4字节到整数
function byte_to_int(a,b,c,d)
	a=a or 0
	b=b or 0
	c=c or 0
	d=d or 0
	return bit.bor(bit.lshift(a, 24),bit.lshift(b, 16),bit.lshift(c, 8),d)
end
--整数到2短整数
function int_to_short(v)
	return bit.rshift(v, 16),bit.band(v,65535)
end
--2短整数到整数
function short_to_int(a,b)
	a=a or 0
	b=b or 0
	return bit.bor(bit.lshift(a, 16),b)
end
--"%s*(.-)%s*$"首尾空