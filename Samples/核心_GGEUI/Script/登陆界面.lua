-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-05-05 11:14:27
-- @最后修改来自: baidwwy
-- @Last Modified time: 2017-05-07 15:32:33

local 游戏界面 = _GUI:创建根控件('游戏界面')
function 游戏界面:初始化()
end
function 游戏界面:消息事件(a,b)
	--print(a,b)
end


local 登陆界面 = _GUI:创建根控件('登陆界面')
function 登陆界面:初始化()
	self.精灵 	= _资源:取精灵('02503.png')
	self.精灵1 	= _资源:取精灵('04758.png')
	self.精灵1:置中心(-250,-200)

end
function 登陆界面:显示(x,y)
	--print(x,y)
	self.精灵:显示()
	self.精灵1:显示()
end

--======================================================================--
local 单选控件 = 登陆界面:创建控件('单选控件')
--======================================================================--
local 单选按钮2 = 单选控件:创建单选按钮("单选按钮2",400,100)

function 单选按钮2:初始化()
	self:置正常纹理(_资源:取纹理('05957.png'))
	self:置选中正常纹理(_资源:取纹理('05958.png'))
	self.文字 = require("gge文字类")():置颜色(0xFF000000)
end
function 单选按钮2:显示(a,b)
	self.文字:显示(420,103,'此单选按钮和下面两个父控件不同，所以不影响选择。')
end
function 单选按钮2:消息事件(a,b)
	if a=='左键弹起' then
	    print(4444)
	end
	return false
end

--======================================================================--
local 账号输入 = 登陆界面:创建输入("账号输入",410,255,190,16)
function 账号输入:初始化()
	self:置文本('普通模式')
end
--======================================================================--
local 密码输入 = 登陆界面:创建输入("密码输入",410,295,190,16)
function 密码输入:初始化()
	self:置密码模式()
	self:置英文模式()
	self:置数字模式()
end
--======================================================================--

local 按钮 = 登陆界面:创建按钮("进入游戏",650,300)

function 按钮:初始化()
	self:置正常纹理(_资源:取纹理('06901.png'))
	self:置按下纹理(_资源:取纹理('06902.png'))
	self:置经过纹理(_资源:取纹理('06903.png'))

end
function 按钮:消息事件(a,b)
	if a=='左键弹起' then
	    登陆界面:置可视(false)
	   _GUI:取控件('主界面'):置可视(true,true)
	    _GUI:取控件('信息层'):置可视(true,true)
	    --信息层:置可视(true,true)
	end
	return false
end
--======================================================================--
local 复选按钮 = 登陆界面:创建复选按钮("复选按钮",620,250)

function 复选按钮:初始化()
	self:置正常纹理(_资源:取纹理('04774.png'))
	self:置选中正常纹理(_资源:取纹理('04775.png'))
end
function 复选按钮:消息事件(a,b)
	if a=='左键弹起' then
	    print('记住账号')
	end
	return false
end
--======================================================================--
local 单选按钮 = 登陆界面:创建单选按钮("单选按钮",400,330)


function 单选按钮:初始化()
	self:置正常纹理(_资源:取纹理('05957.png'))
	self:置选中正常纹理(_资源:取纹理('05958.png'))

end
function 单选按钮:消息事件(a,b)
	if a=='左键弹起' then
	    print(4444)
	end
	return false
end
--======================================================================--
local 单选按钮1 = 登陆界面:创建单选按钮("单选按钮1",480,330)

function 单选按钮1:初始化()
	self:置正常纹理(_资源:取纹理('05957.png'))
	self:置选中正常纹理(_资源:取纹理('05958.png'))

end
function 单选按钮1:消息事件(a,b)
	if a=='左键弹起' then
	    print(4444)
	end
	return false
end
table.print(登陆界面)
return 登陆界面
