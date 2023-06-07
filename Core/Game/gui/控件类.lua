-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-06-12 12:31:00
-- @最后修改来自: baidwwy
-- @Last Modified time: 2016-05-18 21:15:10
local __ggeGuiWindow = require("__ggeguiwindow__")--套壳
local __ggeGuiControl = require("__ggeguicontrol__")--回调
local 子消息常量 = {
	鼠标碰撞 		= 0,
	鼠标取消碰撞 	= 1,
	鼠标位置移动 	= 2,
	鼠标左键按下	= 3,
	鼠标左键弹起	= 4,
	鼠标右键按下 	= 5,
	鼠标右键弹起 	= 6,
	鼠标滚轮滚动 	= 7,
	字符输入		= 8,

	获得焦点		= 9,
	失去焦点		= 10,
	按钮点击		= 11,
	选择按钮改变	= 12,
	编辑框改变		= 13,
	滑块改变 		= 14,
	滑块移动 		= 15,
	列表框点击		= 16,
	列表框选中改变	= 17,
	列表框顶部改变	= 18,
	列表框滚动		= 19,
	超链接点击		= 20,

	窗口	=0,
	按钮 	=1,
	选择按钮=2,
	滑块条	=3,
	列表框 	=4,
	编辑框 	=5,
	文本框	=6,
}
------------------------------------------------------------------
--全局
------------------------------------------------------------------
local ffi = require("ffi")
function GUI_创建函数(类)
	local 回调类 = 类
	local cfun = ffi.cast('unsigned(*)(unsigned)',function (info)
		local 对象 = 回调类()
		local 控件 = __ggeGuiControl(对象)--回调消息
		对象:置指针(控件:GetP())._ctrlprt = 控件
		return 控件:Create(info)
	end)
	ffi.gc(cfun,function (p) p:free()end)
	return cfun
end
------------------------------------------------------------------
local GUI控件类 = class()
------------------------------------------------------------------
local _eq 		= function (a,b) return a:取指针()==b:取指针() end
local _tostring = function (a,b) return "ggeGuiControl",tostring(a.wnd) end
------------------------------------------------------------------
function GUI控件类:初始化(p)
	self.常量 = 子消息常量
	self._wnd = __ggeGuiWindow()

	if p and p~=0  then
		self._p = p
	    self._wnd:SetP(p)
	end
	self._isok = p and p~=0 or false
	local t = getmetatable(self)
	t.__eq 			= _eq
	t.__tostring 	= _tostring
end
function GUI控件类:取指针()
	return self._p or self._wnd:GetP()
end
function GUI控件类:置指针(p)
	self._p = p
	self._wnd:SetP(p)
	self._isok = p~=0
	return self
end
function GUI控件类:取回调()
	return self._wnd:GetCallBack()
end
function GUI控件类:释放()
	self._p = nil
	self._isok = false
	self._ctrlprt = nil--GUI_创建函数
	self._wnd:Release()
	collectgarbage()--即时回收
end
function GUI控件类:取引用总数()
	return self._isok and self._wnd:GetRefCount() or 0
end
function GUI控件类:是否可用()
	return self:取指针()~=0
end
--------------------------------------------------
function GUI控件类:OnRender()

end
function GUI控件类:OnUpdate(dt)

end
function GUI控件类:OnFocus(bFocused)

end
function GUI控件类:OnMouseOver(bOver)

end
function GUI控件类:OnMouseMove(x,y)
	if self.鼠标移动消息 then
	    return __gge.safecall(self.鼠标移动消息,self,x,y)
	end
end
function GUI控件类:OnMouseLButton(bDown,x,y)
	if self.鼠标左键消息 then
	    return __gge.safecall(self.鼠标左键消息,self,bDown,x,y)
	end
end
function GUI控件类:OnMouseRButton(bDown,x,y)
	if self.鼠标右键消息 then
	    return __gge.safecall(self.鼠标右键消息,self,bDown,x,y)
	end
end
function GUI控件类:OnMouseWheel(notches)
	if self.鼠标滚轮消息 then
	    return __gge.safecall(self.鼠标滚轮消息,self,notches)
	end
end
function GUI控件类:OnKeyClick(key,str)

end
--local 控件壳 = GUI控件类(0)
function GUI控件类:OnMessage(ctrl,msgType,msgData)
	return __gge.safecall(self.消息处理,self,GUI控件类(ctrl),msgType,msgData,true)
end
function GUI控件类:OnChildMsg(msgType,ctrl)
	return __gge.safecall(self.子消息处理,self,msgType,GUI控件类(ctrl),true)
end
--/// 设置控件ID
function GUI控件类:置ID(id)
	if self._isok then self._wnd:SetID(id) end
	return self
end
--/// 返回控件ID
function GUI控件类:取ID()
	return self._isok and self._wnd:GetID() or 0
end
--/// 设置控件名字
function GUI控件类:置名称(n)
	if self._isok then self._wnd:SetName(n) end
	return self
end
--/// 返回控件名字
function GUI控件类:取名称()
	return self._isok and self._wnd:GetName() or 0
end
--/// 设置控件ToolTip
function GUI控件类:置提示(n)
	if self._isok then self._wnd:SetToolTip(n) end
	return self
end
--/// 返回控件ToolTip
function GUI控件类:取提示()
	return self._isok and self._wnd:GetToolTip() or 0
end
--/// 设置ToolTip宽度，默认为0，为0时自适应设置的ToolTip字符宽度
function GUI控件类:置提示宽度(n)
	if self._isok then self._wnd:SetToolTipWidth(n) end
	return self
end
--/// 返回ToolTip宽度
function GUI控件类:取提示宽度()
	return self._isok and self._wnd:GetToolTipWidth() or 0
end
--/// 设置坐标
function GUI控件类:置坐标(x,y,b)--是否移动子控件
	if self._isok then self._wnd:SetPos(x,y,b == nil and true or b) end
	return self
end
function GUI控件类:取坐标()
	return self._isok and self._wnd:GetPosX(),self._wnd:GetPosY() or 0,0
end
--/// 返回x坐标
function GUI控件类:取坐标X()
	return self._isok and self._wnd:GetPosX() or 0
end
--/// 返回y坐标
function GUI控件类:取坐标Y()
	return self._isok and self._wnd:GetPosY() or 0
end
--/// 设置宽度
function GUI控件类:置宽度(n)
	if self._isok then self._wnd:SetWidth(n) end
	return self
end
--/// 返回宽度
function GUI控件类:取宽度()
	return self._isok and self._wnd:GetWidth() or 0
end
--/// 设置高度
function GUI控件类:置高度(n)
	if self._isok then self._wnd:SetHeight(n) end
	return self
end
--/// 返回高度
function GUI控件类:取高度()
	return self._wnd:GetHeight()
end
--/// 设置控件矩形坐标
function GUI控件类:置矩形( ... )
	-- body
end
--/// 返回控件矩形坐标
function GUI控件类:取矩形( ... )
	-- body
end
--/// 设置收到键盘鼠标消息时是否先通知父控件，如果父控件未接收才发送到本控件处理，默认为false
function GUI控件类:置通知父控件(b)
	if self._isok then self._wnd:SetNotifyParent(b) end
	return self
end
--/// 返回收到键盘鼠标消息时是否先通知父控件
function GUI控件类:是否通知父控件()
	return self._isok and self._wnd:IsNotifyParent() or false
end
--/// 设置剪裁
function GUI控件类:置剪裁(b)--置区域
	if self._isok then self._wnd:SetClipping(b) end
	return self
end
--/// 是否剪裁
function GUI控件类:是否剪裁()
	return self._isok and self._wnd:IsClipping() or false
end
--/// 设为静态控件，静态控件不会接收键盘鼠标消息，不能设置焦点，默认为false
function GUI控件类:置静态(b)
	if self._isok then self._wnd:SetStatic(b) end
	return self
end
--/// 是否是静态控件
function GUI控件类:是否静态()
	return self._isok and self._wnd:IsStatic() or false
end
--/// 设置是否可见，如果控件不可见，不会接收键盘鼠标消息，不能设置焦点，也不会渲染，默认为true
function GUI控件类:置可见(b)
	if self._isok then self._wnd:SetVisible(b) end
	return self
end
--/// 是否可见
function GUI控件类:是否可见()
	return self._isok and self._wnd:IsVisible() or false
end
--/// 设置是否有效，如果控件无效不会接收键盘鼠标消息，不能设置焦点，也不会刷新，默认为true
function GUI控件类:置禁止(b)
	if self._isok then self._wnd:SetEnabled(b) end
	return self
end
--/// 是否有效
function GUI控件类:是否禁止()
	return self._isok and self._wnd:IsEnabled() or false
end
--/// 设置文本
function GUI控件类:置文本(t)
	if self._isok then self._wnd:SetText(tostring(t)) end
	return self
end
--/// 返回文本
function GUI控件类:取文本()
	return self._isok and self._wnd:GetText() or ""
end
-- enum FONT_ALIGN
-- {
-- 	TEXT_LEFT,		///< 左对齐
-- 	TEXT_CENTER,	///< 居中对齐
-- 	TEXT_RIGHT,		///< 右对齐
-- 	TEXT_FORCE32BIT = 0x7FFFFFFF,
-- };
--/// 设置对齐模式，默认为 TEXT_LEFT @see FONT_ALIGN
function GUI控件类:置对齐模式(t)
	if self._isok then self._wnd:SetAlignMode(t) end
end
--/// 返回对齐模式
function GUI控件类:取对齐模式()
	return self._isok and self._wnd:GetAlignMode() or 1
end
--/// 设置是否自动换行，默认为false
function GUI控件类:置自动换行(b)
	if self._isok then self._wnd:SetTextWarp(b) end
end
--/// 返回是否自动换行
function GUI控件类:是否自动换行()
	return self._isok and self._wnd:IsTextWarp() or false
end
--/// 设置行间距
function GUI控件类:置行间距(t)
	if self._isok then self._wnd:SetLineSpace(t) end
	return self
end
--/// 返回行间距
function GUI控件类:取行间距()
	return self._isok and self._wnd:GetLineSpace() or 0
end
--/// 设置字间距
function GUI控件类:置字间距(t)
	if self._isok then self._wnd:SetCharSpace(t) end
	return self
end
--/// 返回字间距
function GUI控件类:取字间距()
	return self._isok and self._wnd:GetCharSpace() or 0
end
--/// 获得第一个子控件
function GUI控件类:取起始子控件()
	return self._isok and GUI控件类(self._wnd:GetFirstChildCtrl()) or GUI控件类()
end
--/// 获得最后一个子控件
function GUI控件类:取末尾子控件()
	return self._isok and GUI控件类(self._wnd:GetLastChildCtrl()) or GUI控件类()
end
--/// 返回前一个控件
function GUI控件类:取上一个子控件()
	return self._isok and GUI控件类(self._wnd:GetPrevCtrl()) or GUI控件类()
end
--/// 返回后一个控件
function GUI控件类:取下一个子控件()
	return self._isok and GUI控件类(self._wnd:GetNextCtrl()) or GUI控件类()
end
function GUI控件类:取父控件()
	return self._isok and GUI控件类(self._wnd:GetParent()) or GUI控件类()
end
--/// 设置为顶层控件
function GUI控件类:置顶层()
	if self._isok then self._wnd:SetTop() end
	return self
end
--/// 设置为焦点控件
function GUI控件类:置焦点()
	if self._isok then self._wnd:SetFocus() end
	return self
end
-- /**
-- @brief 添加一个控件，添加失败返回false
-- @param ctrl 要添加的控件
-- @param resetPos 重置相对父控件坐标
-- @return 成功返回true，失败返回false
-- */
function GUI控件类:添加控件(ctrl,b)
	return self._isok and self._wnd:AddCtrl(ctrl:取指针(),b or false) or false
end
--/// 移除控件
function GUI控件类:删除控件(ctrl)
	if self._isok then self._wnd:RemoveCtrl(ctrl:取指针()) end
end
--/// 移除所有控件
function GUI控件类:删除所有控件()
	if self._isok then self._wnd:RemoveAllCtrl() end
end
--/// 查找第一个指定ID的控件，bTraversal指定是否遍历所有子控件
function GUI控件类:取子控件_按ID(id,遍历)
	return self._isok and GUI控件类(self._wnd:FindCtrl_ID(id,遍历 or false)) or GUI控件类()
end
--/// 查找第一个指定名字的控件，bTraversal指定是否遍历所有子控件
function GUI控件类:取子控件_按名称(名称,遍历)
	return self._isok and GUI控件类(self._wnd:FindCtrl_Name(名称,遍历 or false)) or GUI控件类()
end
--/// 查找指定位置第一个可见控件
function GUI控件类:取子控件_按坐标(x,y)
	return self._isok and GUI控件类(self._wnd:FindCtrlFromPoint(x,y)) or GUI控件类()
end
--/// 控件是否是该窗口的子控件，bTraversal指定是否遍历所有子控件
function GUI控件类:是否子控件(ctrl,b)
	return self._isok and self._wnd:IsChild(ctrl:取指针(),b) or false
end
--/// 该窗口是否是控件的子控件
function GUI控件类:是否父控件(ctrl)
	return self._isok and self._wnd:IsParent(ctrl:取指针()) or false
end
-- /**
-- @brief 发送消息给子控件
-- @param msgType 消息类型
-- @param msgData 消息数据
-- @param bTraversal 如果为false，只发送消息给第一层子控件，如果为true，则发送消息给所有子控件
-- */
function GUI控件类:发送子消息(类型,数据,遍历)
	return self._isok and self._wnd:SendChildMsg(类型,数据 or 0,遍历 or false) or false
end
-- /**
-- @brief 发送消息给父控件
-- @param msgType 消息类型
-- @param msgData 消息数据
-- */
function GUI控件类:发送父消息(类型,数据)
	return self._isok and self._wnd:SendParentMsg(类型,数据 or 0) or false
end
-- /**
-- @brief 通知父控件
-- @param msgType 消息类型 @see CHILD_MESSAGE_TYPE
-- */
function GUI控件类:通知父控件(msg)--子消息常量
	return self._isok and self._wnd:NotifyParent(msg) or false
end
function GUI控件类:置字体(f)
	if self._isok then self._wnd:SetFont(f:取指针()) end
end
function GUI控件类:取字体()
	return self._isok and self._wnd:GetFont() or 0
end
---------------------------------------------------------------------------
function GUI控件类:消息处理(ctrl,msgType,msgData,p)--p防止死循环
	if p == nil then
	    return self._wnd:OnMessage(tostring(ctrl) == "ggeGuiControl" and ctrl:取指针() or 0,msgType,msgData)
	end
end
function GUI控件类:子消息处理(msgType,ctrl,p)
	if p == nil then
		return self._wnd:OnChildMsg(msgType,tostring(ctrl) == "ggeGuiControl" and ctrl:取指针() or 0)
	end
end
---------------------------------------------------------------------------
-- --/// 返回控件类型 @see GGE_GUI_TYPE
-- 	enum GGE_GUI_TYPE
-- 	{
-- 		GGT_Window,		///< Window
-- 		GGT_Button,		///< Button
-- 		GGT_CheckButton,///< CheckButton
-- 		GGT_Slider,		///< Slider
-- 		GGT_ListBox,	///< ListBox
-- 		GGT_EditBox,	///< EditBox
-- 		GGT_RichText,	///< RichText
-- 		GGT_Last,
-- 		GGT_FORCE32BIT = 0x7FFFFFFF,
-- 	};
function GUI控件类:取类型()
	return self._isok and self._wnd:GetType() or -1
end
--============================================================================
--/// CheckButton  选择按钮控件
--============================================================================
--/// 设置选中状态
function GUI控件类:置选中(b)
	self._wnd:SetChecked(b)
	return self
end
--/// 返回选中状态
function GUI控件类:是否选中()
	return self._isok and self._wnd:IsChecked() or false
end
--============================================================================
--/// EditBox 编辑控件
--============================================================================
--EditBox/ListBox
function GUI控件类:清空()
	if self._isok then self._wnd:Clear() end
end
--/// 输入框是否为空
function GUI控件类:是否为空()
	return (not self._isok) and true or self._wnd:IsEmpty()
end
--/// 输入框文本长度
function GUI控件类:取长度()
	return self._isok and self._wnd:GetTextLength() or 0
end
--/// 设置最大字符数
function GUI控件类:置限制字数(c)
	if self._isok then self._wnd:SetMaxCharNum(c) end
end
--/// 返回最大字符数
function GUI控件类:取限制字数()
	return self._isok and self._wnd:GetMaxCharNum() or 0
end
--/// 设置光标颜色
function GUI控件类:置光标颜色(c)
	if self._isok then self._wnd:SetCursorColor(c) end
end
--/// 返回光标颜色
function GUI控件类:取光标颜色()
	return self._isok and self._wnd:GetCursorColor() or 0
end
--/// 设置密码输入模式
function GUI控件类:置密码模式(c)
	if self._isok then self._wnd:SetPasswordMode(c) end
end
--/// 是否密码输入模式
function GUI控件类:是否密码模式()
	return self._isok and self._wnd:IsPasswordMode() or false
end
--============================================================================
--/// ListBox 控件
--============================================================================
--/// 添加一个项目并返回项目索引，项目索引从0开始
function GUI控件类:添加项目(t,p)
	return self._isok and self._wnd:AddItem(t,p) or false
end
--/// 删除一个项目
function GUI控件类:删除项目(n)
	return self._isok and self._wnd:DeleteItem(n) or false
end
--/// 获得当前选中的项目的项目索引，未选中任何项返回-1
function GUI控件类:取选中项()
	return self._isok and self._wnd:GetSelectedItem() or 0
end
--/// 设置当前选中的项目的项目索引
function GUI控件类:置选中项(n)
	if self._isok then self._wnd:SetSelectedItem(n) end
end
--/// 得到顶部项目索引
function GUI控件类:取顶端项()
	return self._isok and self._wnd:GetTopItem() or 0
end
--/// 设置顶部项目索引
function GUI控件类:置顶端项(n)
	if self._isok then self._wnd:SetTopItem(n) end
end
--/// 返回项目上下文
function GUI控件类:取关联内容(n)
	return self._isok and self._wnd:GetContext(n) or nil
end
--/// 设置项目上下文
function GUI控件类:置关联内容(n,p)
	if self._isok then self._wnd:SetContext(n,p) end
end
--/// 获得项目文本
function GUI控件类:取项目文本(n)
	return self._wnd:GetItemText(n)
end
--/// 设置项目文本
function GUI控件类:置项目文本(n,p)
	if self._isok then self._wnd:SetItemText(n,p) end
end
--/// 获得项目总数
function GUI控件类:取项目总数()
	return self._isok and self._wnd:GetNumItems(n) or 0
end
--/// 获得显示的项目数
function GUI控件类:取项目显示数()
	return self._isok and  self._wnd:GetNumRows(n) or 0
end
--/// 返回项目高度
function GUI控件类:取项目高度()
	return self._isok and self._wnd:GetItemHeight(n) or 0
end
--============================================================================
--/// RichText 控件
-- /**
-- @brief 设置文本
-- @note 命令列表：\n
-- \##: "#"符号\n
-- \#c: 设置文字颜色，如："#cFF0000FF蓝色的字"\n
-- \#d: 设置阴影颜色\n
-- \#b: 设置边框颜色\n
-- \#u: 切换文字是否加下划线\n
-- \#p: 对齐方式( 0:左对齐 / 1:居中对齐 / 2:右对齐 )\n
-- \#s: 插入Sprite，如："在中间显示#s1图标"\n
-- \#a: 插入Animation，如："在中间显示#a1图标"\n
-- \#f: 插入特殊文字字体( 0:恢复默认字体 / >0:设置特殊字体 )，如："普通文字#f1大号文字#f0普通文字"\n
-- \#h: 插入超链接，格式为："#h超链接ID,超链接高亮颜色,超链接内容#h"，如"#h100,FFFF0000,超链接#h"，点击超链接时会发送CMT_RICH_TEXT_HYPER_LINK消息到父窗口，可用GetHyperLinkID()函数获取当前点击的超链接ID\n
-- */
--============================================================================
--/// 设置最大文字宽度，超过该宽度自动换行，设为0则不自动换行，默认为0
function GUI控件类:置换行字数(w)
	if self._isok then self._wnd:SetMaxTextWidth(w) end
	return self
end
--/// 返回最大文字宽度
function GUI控件类:取换行字数()
	return self._isok and self._wnd:GetMaxTextWidth() or 0
end
--/// 返回文本宽度
function GUI控件类:取文本宽度()
	return self._isok and self._wnd:GetCurTextWidth() or 0
end
--/// 返回文本高度
function GUI控件类:取文本高度()
	return self._isok and self._wnd:GetCurTextHeigth() or 0
end
--/// 插入Sprite
function GUI控件类:添加精灵(id,spr)
	if self._isok then self._wnd:InsertSprite(id,spr:取指针()) end
	return self
end
--/// 移除Sprite
function GUI控件类:删除精灵(id)
	if self._isok then self._wnd:RemoveSprite(id) end
	return self
end
--/// 插入Animation
function GUI控件类:添加动画(id,spr)
	if self._isok then self._wnd:InsertAnimation(id,spr:取指针()) end
	return self
end
--/// 移除Animation
function GUI控件类:删除动画(id)
	if self._isok then self._wnd:RemoveAnimation(id) end
	return self
end
--/// 插入Font
function GUI控件类:添加文字(id,spr)
	if self._isok then self._wnd:InsertFont(id,spr:取指针()) end
	return self
end
--/// 移除Font
function GUI控件类:删除文字(id)
	if self._isok then self._wnd:RemoveFont(id) end
	return self
end
--/// 返回超链接ID
function GUI控件类:取超链接ID()
	return self._isok and self._wnd:GetHyperLinkID() or -1
end
--============================================================================
--/// Slider 控件
--============================================================================
--/// 设置是否垂直放置
function GUI控件类:置垂直(b)
	if self._isok then self._wnd:SetVertical(b) end
	return self
end
--/// 是否垂直放置
function GUI控件类:是否垂直()
	return self._isok and self._wnd:IsVertical() or false
end
--/// 设置滑块尺寸
function GUI控件类:置滑块大小(b)
	if self._isok then self._wnd:SetBarSize(b) end
	return self
end
--/// 返回滑块尺寸
function GUI控件类:取滑块大小()
	return self._isok and self._wnd:GetBarSize() or 0
end
--/// 设置最大值和最小值
function GUI控件类:置滑块值(a,b)
	if self._isok then self._wnd:SetRange(a,b) end
	return self
end
--/// 返回最小值
function GUI控件类:取最小值()
	return self._isok and self._wnd:GetMinVal() or 0
end
--/// 返回最大值
function GUI控件类:取最大值()
	return self._isok and self._wnd:GetMaxVal() or 0
end
--/// 设置当前值
function GUI控件类:置当前值(v)
	if self._isok then self._wnd:SetValue(v) end
	return self
end
--/// 获得当前值
function GUI控件类:取当前值()
	return self._isok and self._wnd:GetValue() or 0
end
function GUI控件类:置当前值(v)
	if self._isok then self._wnd:SetValue(v) end
	return self
end
return GUI控件类