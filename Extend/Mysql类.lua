-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-04-14 10:11:28
-- @最后修改来自: baidwwy
-- @Last Modified time: 2016-09-10 15:43:15
local _查询类 = class()
function _查询类:初始化(cur)
	self.cur = cur
	local t = getmetatable(self)
	t.__tostring = function ()
		return "mysqlcursor"
	end
end
function _查询类:销毁()
	if self.cur then self.cur:close() end
end
function _查询类:关闭()
	self.cur:close()
	self.cur = nil
end
function _查询类:取数据(表,类型)
	self:取名称()
	self:取类型()
	类型 = 类型 or "a"
	local 数据 = self.cur:fetch(表 or {},类型)
	if 数据 then
		if 类型 == "a" then
			for i,v in ipairs(self.名称) do
				if self.类型[i] == "number" then
				    数据[v] = tonumber(数据[v])
				end
			end
		elseif 类型 == "n" then
			for i,v in ipairs(self.名称) do
				if self.类型[i] == "number" then
				    数据[i] = tonumber(数据[i])
				end
			end
		end
	end
	return 数据
end
function _查询类:取名称()
	if not self.名称 then
	    self.名称 = self.cur:getcolnames()
	end
	return self.名称
end
function _查询类:取类型()
	if not self.类型 then
	    self.类型 = self.cur:getcoltypes()
	end
	return  self.类型
end
function _查询类:取数量()
	return self.cur:numrows()
end
--=================================================================

local MYSQL类 = class()


function MYSQL类:初始化(表名,账号,密码,IP,端口)
	local luasql = require "luasql.mysql"
	self.env = luasql.mysql()
	if 表名 then self.conn = self.env:connect(表名,账号,密码,IP,端口) end

	local t = getmetatable(self)
	t.__tostring = function (a,b)
		return "mysql",tostring(self.conn)
	end
end
function MYSQL类:连接(表名,账号,密码,IP,端口)
	self.conn = self.env:connect(表名,账号,密码,IP,端口)
	return self.conn
	--self.conn:execute"SET NAMES GB2312"
end
function MYSQL类:销毁()
	if self.conn then self.conn:close() end
	if self.env then self.env:close() end
end
function MYSQL类:关闭()
	self.conn:close()
	self.env:close()
	self.conn = nil
	self.env = nil
end
function MYSQL类:执行SQL(str)
	local ret,err
	if self.conn then
	    ret,err = self.conn:execute(str)
	end
	if type(ret) == 'number' then
	    return ret --所影响的记录行数
	elseif type(ret) == 'userdata' then
		return _查询类(ret) --查询结果对象
	end
	return err
end
function MYSQL类:取递增ID()
	return self.conn:getlastautoid()
end
function MYSQL类:提交事务()
	return self.conn:commit()
end
function MYSQL类:回滚事务()
	return self.conn:rollback()
end
function MYSQL类:自动事务(boolean)
	return self.conn:setautocommit(boolean)
end
function MYSQL类:取状态()
	return self.conn:getstat()
end
function MYSQL类:是否断开()--断开返回true
	if self.conn then
	    return self.conn:ping()
	end
	return true
end
return MYSQL类