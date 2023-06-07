-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2016-04-17 19:35:04
-- @最后修改来自: baidwwy
-- @Last Modified time: 2016-05-28 22:27:21

local __ggeResManager = require("__ggeresmanager__")
local GGE资源管理 = class()


function GGE资源管理:初始化()
	self.res = __ggeResManager()
end
function GGE资源管理:取指针()
	if not self.p then
	    self.p = self.res:GetP()
	end
	return self.p
end
function GGE资源管理:载入文件(文件名)
	return self.res:LoadResFile(文件名)
end
function GGE资源管理:预缓存所有资源()
	self.res:PrepareCache()
end
function GGE资源管理:清除所有资源()
	self.res:Clear()
end
function GGE资源管理:开始载入资源()--返回资源总数
	return self.res:BeginLoadRes()
end
function GGE资源管理:载入下个资源()
	return self.res:LoadNextRes()
end
function GGE资源管理:置垃圾回收时间()
	self.res:SetGarbageCollectTime()
end
function GGE资源管理:枚举资源()
	self.res:EnumRes()
end
function GGE资源管理:创建纹理(名称)
	return self.res:CreateTexture(名称)
end
function GGE资源管理:创建纹理_从文件(名称,文件名,颜色)
	return self.res:CreateTextureFromFile(名称,文件名,颜色 or 0)
end
function GGE资源管理:创建音效(名称)
	return self.res:CreateSound(名称)
end
function GGE资源管理:创建音效_从文件(名称,文件名,流)
	return self.res:CreateSoundFromFile(名称,文件名,流)
end
function GGE资源管理:创建精灵(名称)
	return self.res:CreateSprite(名称)
end
function GGE资源管理:创建动画(名称)
	return self.res:CreateAnimation(名称)
end
function GGE资源管理:创建字体(名称)
	return self.res:CreateFont(名称)
end
function GGE资源管理:创建字体_从文件(名称,文件名,大小,模式)
	return self.res:CreateCustomFontFromImage(名称,文件名,大小 or 16,模式 or 0)
end
function GGE资源管理:创建字体_从图像(名称,文件名)
	return self.res:CreateCustomFontFromImage(名称,文件名)
end
function GGE资源管理:创建粒子(名称)
	local ret = require("gge粒子类")()
	return ret:置指针(self.res:CreateParticle(名称))
end
-- function GGE资源管理:创建网格(名称)
-- 	return self.res:CreateMesh(名称)
-- end
function GGE资源管理:创建图像(名称)
	return self.res:CreateImage(名称)
end
function GGE资源管理:创建图像_从文件(名称,文件名,颜色)
	return self.res:CreateImageFromFile(名称,文件名,颜色 or 0)
end
function GGE资源管理:取文本(名称)
	return self.res:GetString(名称)
end
return GGE资源管理