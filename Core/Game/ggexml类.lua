-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-01-27 03:51:34
-- @最后修改来自: baidwwy
-- @Last Modified time: 2016-05-23 12:40:20
--======================================================================--
--该 文件由GGELUA创建
--
--作者：baidwwy  创建日期：2014-07-18 15:26:46
--======================================================================--
local __ggexml = require("__ggexml__")

local 节点 = class()


function 节点:初始化(node)
	self.node = node
end
function 节点:是否有效()
	return self.node:IsValid()
end

function 节点:取名称()--节点名
	return self.node:GetName()
end
function 节点:取文本(名称)
	return self.node:GetString(名称)
end
function 节点:取数值(名称)
	return self.node:GetDouble(名称)
end
function 节点:取逻辑(名称)
	return self.node:GetBool(名称)
end
function 节点:取逻辑(名称)
	return self.node:GetBool(名称)
end
function 节点:取首子节点(名称)
	print(名称)
	return 节点(self.node:GetFirstChild(名称))
end
function 节点:取尾子节点(名称)
	return 节点(self.node:GetLastChild(名称))
end
function 节点:下一个节点(名称)
	return 节点(self.node:GetNextNode(名称))
end
function 节点:上一个节点(名称)
	return 节点(self.node:GetPreviousNode(名称))
end

--======================================================================
local XML = class()

function XML:初始化(路径,文本)
	self.xml = __ggexml()
	if 路径 then
	    self.isok = self.xml:LoadFile(路径)
	end
	if 文本 then
	    self.isok = self.xml:Parse(str)
	end
end
function XML:是否成功()
	return self.isok
end
function XML:载入__从文件(str)
	self.isok = self.xml:LoadFile(str)
	return self
end
function XML:载入__从文本(str)
	self.isok = self.xml:Parse(str)
	return self
end

function XML:取根节点()
	if self.isok then
	    return 节点(self.xml:GetRootNode())
	end
end

return XML