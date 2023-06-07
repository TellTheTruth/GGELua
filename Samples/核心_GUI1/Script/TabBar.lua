
local 控件类 = require("gui/控件类")

local TabBar = class(控件类)

function TabBar:子消息处理(msgType,ctrl)
	if msgType == self.常量.按钮点击 then
		if ctrl:取父控件() == self and ctrl:取类型() == self.常量.选择按钮 then
		    for i=0,1 do
		    	local id = ctrl:取ID()
		    	if i ~= id then
		    	    local 按钮 = self:取子控件_按ID(i)
		    	    	:置选中(false)
		    	    local 窗口 = self:取子控件_按ID(i+1000)
		    	    	:置可见(false)
		    	end
	    	    local 窗口 = self:取子控件_按ID(id+1000)
	    	    	:置可见(true)
		    end
		else
			if ctrl:取名称() == 'ModalWndText' then
			    local 消息框1,消息框2,消息框3
			    消息框1 = __创建消息框('模态对话框1',true,self,ctrl)
			    消息框2 = __创建消息框('模态对话框2',true,self,ctrl)
			    消息框3 = __创建消息框('模态对话框3',true,self,ctrl)
				消息框2:置坐标(消息框2:取坐标X()+16,消息框2:取坐标Y()+16)
				消息框3:置坐标(消息框3:取坐标X()+32,消息框3:取坐标Y()+32)
			end
		end
	elseif msgType == self.常量.鼠标左键按下 or msgType == self.常量.鼠标左键弹起 then
		if ctrl:是否选中() then
		    return true
		end
	elseif msgType == self.常量.滑块改变 then
		ctrl:取父控件()
			:取子控件_按名称("SliderText")
			:置文本(math.floor(ctrl:取当前值()))

	elseif msgType == self.常量.超链接点击 then
		local id = ctrl:取超链接ID()
		if id == 100 then
			引擎.运行("http://www.163.com")
		elseif id == 200 then
			引擎.运行("http://www.sohu.com")
		end
	end
end
function TabBar:消息处理(ctrl,msgType,msgData)
	if msgData == '初始化' then
		local 纹理 = require("gge纹理类")("guiicon.png")
		self:取子控件_按名称("RichText",true)
			:添加精灵(1,require("gge精灵类")(纹理,0,0,20,20))
			:添加动画(1,require("gge动画类")(纹理,15,5,20,20))
			:添加文字(1,require("gge文字类")("DejaVuSans.ttf", 14,false,true,true))
	end
end

return GUI_创建函数(TabBar)