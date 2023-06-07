/*
**  =======================================================
**              Galaxy2D Game Engine       
**                                
**       版权所有(c) 2005 沈明. 保留所有权利.
**    主页地址: http://www.cppblog.com/jianguhan/
**			 电子邮箱: jianguhan@126.com
**  =======================================================
*/

/** \file
\brief GUI管理器
*/

#pragma once
#include "ggecommon.h"

namespace gge
{
	class ggeGuiWindow;

	/// GUI管理器
	class ggeGuiManager
	{
	public:
		/**
		@brief 设置顶层窗口
		@param wnd 顶层窗口
		*/
		virtual void			SetRootWindow(ggeGuiWindow *wnd) = 0;
		/**
		@brief 返回顶层窗口
		@return 顶层窗口
		*/
		virtual ggeGuiWindow*	GetRootWindow() = 0;
		/**
		@brief 是否启用鼠标，默认启用
		*/
		virtual void			EnableMouse(bool b) = 0;
		/**
		@brief 设置焦点控件，如果为0则清除当前焦点控件的焦点状态
		*/
		virtual void			SetFocusCtrl(ggeGuiWindow *ctrl = 0) = 0;
		/**
		@brief 返回当前焦点控件
		*/
		virtual ggeGuiWindow*	GetFocusCtrl() = 0;
		/**
		@brief 设置用于显示ToolTip的控件，该控件不能有父窗口
		*/
		virtual void			SetToolTipCtrl(ggeGuiRichText *ctrl) = 0;
		/**
		@brief 返回用于显示ToolTip的控件
		*/
		virtual ggeGuiRichText* GetToolTipCtrl() = 0;
		/**
		@brief 设置显示ToolTip延时，单位：秒
		*/
		virtual void			SetToolTipDelay(float t) = 0;
		/**
		@brief 返回显示ToolTip延时
		*/
		virtual float			GetToolTipDelay() = 0;

		/**
		@brief 添加模态窗口(注意：模态窗口不能有父窗口，窗口关闭时需要调用RemoveModalWnd()函数移除该窗口)
		*/
		virtual void			AddModalWnd(ggeGuiWindow *wnd) = 0;
		/**
		@brief 移除模态窗口
		*/
		virtual void			RemoveModalWnd(ggeGuiWindow *wnd) = 0;
		/**
		@brief 移除所有模态窗口
		*/
		virtual void			RemoveAllModalWnd() = 0;

		/**
		@brief 刷新GUI系统
		@param dt 上一帧所用时间，可用Timer_GetDelta()获得
		*/
		virtual void			Update(float dt) = 0;
		/**
		@brief 渲染GUI系统
		*/
		virtual void			Render() = 0;

	protected:
		ggeGuiManager() {}
		virtual ~ggeGuiManager() {}
		ggeGuiManager(const ggeGuiManager &val);
		ggeGuiManager& operator = (const ggeGuiManager &val);
	};

	/// 返回全局GUI管理器
	GGE_EXPORT ggeGuiManager*	GGE_CALL GUI_GetGuiManager();
}