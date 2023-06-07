--======================================================================--
--这里可以包含引用所有文件
--若文件需要使用引擎相关函数(如INI),可以在引擎创建完成中引用
--======================================================================--
require("gge函数")
GGE ={}
gge = GGE
gge.纹理 = require("gge纹理类")
gge.精灵 = require("gge精灵类")
gge.图像 = require("gge图像类")
--gge.音效 = require("gge音效类")
--gge.文字 = require("gge文字类")
--gge.zip = require("ggeZIP类")
function ARGB(a,r,g,b)
	return (bit.lshift(a,24) + bit.lshift(r,16) + bit.lshift(g,8) + b)
end

--模块引用
--模块列表
function 引擎创建完成()
	
end