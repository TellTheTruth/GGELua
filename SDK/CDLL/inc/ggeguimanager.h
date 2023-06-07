/*
**  =======================================================
**              Galaxy2D Game Engine       
**                                
**       ��Ȩ����(c) 2005 ����. ��������Ȩ��.
**    ��ҳ��ַ: http://www.cppblog.com/jianguhan/
**			 ��������: jianguhan@126.com
**  =======================================================
*/

/** \file
\brief GUI������
*/

#pragma once
#include "ggecommon.h"

namespace gge
{
	class ggeGuiWindow;

	/// GUI������
	class ggeGuiManager
	{
	public:
		/**
		@brief ���ö��㴰��
		@param wnd ���㴰��
		*/
		virtual void			SetRootWindow(ggeGuiWindow *wnd) = 0;
		/**
		@brief ���ض��㴰��
		@return ���㴰��
		*/
		virtual ggeGuiWindow*	GetRootWindow() = 0;
		/**
		@brief �Ƿ�������꣬Ĭ������
		*/
		virtual void			EnableMouse(bool b) = 0;
		/**
		@brief ���ý���ؼ������Ϊ0�������ǰ����ؼ��Ľ���״̬
		*/
		virtual void			SetFocusCtrl(ggeGuiWindow *ctrl = 0) = 0;
		/**
		@brief ���ص�ǰ����ؼ�
		*/
		virtual ggeGuiWindow*	GetFocusCtrl() = 0;
		/**
		@brief ����������ʾToolTip�Ŀؼ����ÿؼ������и�����
		*/
		virtual void			SetToolTipCtrl(ggeGuiRichText *ctrl) = 0;
		/**
		@brief ����������ʾToolTip�Ŀؼ�
		*/
		virtual ggeGuiRichText* GetToolTipCtrl() = 0;
		/**
		@brief ������ʾToolTip��ʱ����λ����
		*/
		virtual void			SetToolTipDelay(float t) = 0;
		/**
		@brief ������ʾToolTip��ʱ
		*/
		virtual float			GetToolTipDelay() = 0;

		/**
		@brief ���ģ̬����(ע�⣺ģ̬���ڲ����и����ڣ����ڹر�ʱ��Ҫ����RemoveModalWnd()�����Ƴ��ô���)
		*/
		virtual void			AddModalWnd(ggeGuiWindow *wnd) = 0;
		/**
		@brief �Ƴ�ģ̬����
		*/
		virtual void			RemoveModalWnd(ggeGuiWindow *wnd) = 0;
		/**
		@brief �Ƴ�����ģ̬����
		*/
		virtual void			RemoveAllModalWnd() = 0;

		/**
		@brief ˢ��GUIϵͳ
		@param dt ��һ֡����ʱ�䣬����Timer_GetDelta()���
		*/
		virtual void			Update(float dt) = 0;
		/**
		@brief ��ȾGUIϵͳ
		*/
		virtual void			Render() = 0;

	protected:
		ggeGuiManager() {}
		virtual ~ggeGuiManager() {}
		ggeGuiManager(const ggeGuiManager &val);
		ggeGuiManager& operator = (const ggeGuiManager &val);
	};

	/// ����ȫ��GUI������
	GGE_EXPORT ggeGuiManager*	GGE_CALL GUI_GetGuiManager();
}