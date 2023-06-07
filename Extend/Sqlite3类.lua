-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-07-16 14:42:00
-- @最后修改来自: baidwwy
-- @Last Modified time: 2016-10-23 21:59:34

local _查询类 = class()
function _查询类:初始化(cur)
	self.cur = cur
	local t = getmetatable(self)
	t.__tostring = function ()
		return "sqlite3cursor"
	end
end
-- function _查询类:销毁()
-- 	if self.cur then self.cur:close() end
-- end
function _查询类:关闭()
	self.cur:close()
	self.cur = nil
end
function _查询类:取数据(表,类型)
	self:取列类型()
	local t = self.cur:fetch(表 or {},类型 or "a")
	if t then
		local r = {}
		if r then
			for k,v in pairs(t) do
				k = type(k) == 'string' and __gge.utf8toansi(k) or k
				if type(v) == 'string' and self.列类型[k] ~= "BLOB" then
				    r[k] = __gge.utf8toansi(v)
				else
					r[k] = v
				end
			end
		end
		return r
	end
end
function _查询类:取名称()
	local t = self.cur:getcolnames()
	local r = {}
	for k,v in pairs(t) do
		r[k] = __gge.utf8toansi(v)
	end
	return r
end
function _查询类:取类型()
	return self.cur:getcoltypes()
end
function _查询类:取列类型()
	if not self.列类型 then
		local 名称 = self:取名称()
		local 类型 = self.cur:getcoltypes()
		self.列类型  = {}
		for i,v in ipairs(名称) do
			self.列类型[v] = 类型[i]
		end
	end
	return self.列类型
end
function _查询类:取数量()
	return self.cur:numrows()
end
--=================================================================
local luasql = require "luasql.sqlite3"
local SQLITE3类 = class()


function SQLITE3类:初始化(数据库,密码)
	self.env = luasql.sqlite3()
	self.conn = self.env:connect(__gge.ansitoutf8(数据库),密码 or '')
	if not self.conn then
	    error(string.format("打开[%s]失败!", 数据库))
	end
	local t = getmetatable(self)
	t.__tostring = function (a,b)
		return "sqlite3",tostring(self.conn)
	end
end
-- function SQLITE3类:销毁()
-- 	if self.conn then self.conn:close() end
-- 	if self.env then self.env:close() end
-- end
-- function SQLITE3类:连接(数据库,密码)
-- 	self.conn = self.env:connect(__gge.ansitoutf8(数据库),密码)
-- end
function SQLITE3类:关闭()
	self.conn:close()
	self.env:close()
	self.conn = nil
	self.env = nil
end

function SQLITE3类:执行SQL(str,data,len)
	local ret,err = self.conn:execute(__gge.ansitoutf8(str),data)
	if type(ret) == 'number' then
	    return ret --所影响的记录行数
	elseif type(ret) == 'userdata' then
		return _查询类(ret) --查询结果对象
	end
	return  err
end

function SQLITE3类:提交事务()
	return self.conn:commit()
end

function SQLITE3类:回滚事务()
	return self.conn:rollback()
end

function SQLITE3类:自动事务(boolean)
	return self.conn:setautocommit(boolean)
end
function SQLITE3类:取递增ID()
	return self.conn:getlastautoid()
end
function SQLITE3类:压缩()--清理
	self:执行SQL("VACUUM;")
end

return SQLITE3类