-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-01-27 03:51:34
-- @最后修改来自: baidwwy
-- @Last Modified time: 2017-03-11 13:55:49

table.tostring = function (t)
	if t then
		local mark		={}
		local assign	={}
		local function ser_table(tbl,parent)
			mark[tbl]=parent
			local tmp={}
			for k,v in pairs(tbl) do
				--local key= type(k)=="number" and "["..k.."]" or "[".. string.format("%q", k) .."]"
				local key
				if type(k) == "number" then
				    key = "["..k.."]"
				elseif tonumber(k) ~= nil then
					key = "[".. string.format("%q", k) .."]"--"['"..k.."']"
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
table.loadstring = function (t)
	if t and type(t)=='string' then--兼容
		local f = loadstring("do local ret="..t.." return ret end")
		if f then
			setfenv(f, {})
			local t = f()
			return type(t)=='table' and t or {}
		end
	end
	return {}
end

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

table.print = function (root)
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
end
string.split = function (str, mark)
	if str  then
	    local result = {}
	    str = str..mark
	    if mark == "(" or mark == ")" or mark == "." or mark == "%" or mark == "+" or mark == "-" or mark == "*" or mark == "?" or mark == "[" or mark == "^" or mark == "$" then
	        mark = "(.-)".."%"..mark
	    else
	    	mark = "(.-)"..mark
	    end
	    for match in str:gmatch(mark) do
	        table.insert(result, match)
	    end
	    return result
	end
	return {}
end

function checkemail( str)
	return str:match("[%d%a]+@%a+.%a+")==str
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