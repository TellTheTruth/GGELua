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
\brief Button�ؼ�
*/

#pragma once
#include "ggeguiwindow.h"

namespace gge
{
	/// Button �ؼ�
	class ggeGuiButton : public ggeGuiWindow
	{
	public:
		ggeGuiButton(int id = -1, const ggeRect &rect = ggeRect(0, 0, 32.0f, 32.0f)) : ggeGuiWindow(id, rect)
		{
			m_bPressed = false;
			m_bMouseOver = false;
		}

		virtual void SetRenderState(GUI_RENDER_STATE_TYPE rt, const ggeGuiRenderState &rs)
		{
			switch (rt)
			{
			case GRST_PRESS:
				m_pressRS = rs;
				break;

			case GRST_MOUSEOVER:
				m_mouseOverRS = rs;
				break;

			default:
				ggeGuiWindow::SetRenderState(rt, rs);
				break;
			}
		}

		virtual ggeGuiRenderState* GetRenderState(GUI_RENDER_STATE_TYPE rt)
		{
			switch (rt)
			{
			case GRST_PRESS:
				return &m_pressRS;

			case GRST_MOUSEOVER:
				return &m_mouseOverRS;
			}

			return ggeGuiWindow::GetRenderState(rt);
		}

		virtual ggeGuiRenderState*	GetCurRenderState()
		{
			if (!IsEnabled())
			{
				return GetRenderState(GRST_DISABLE);
			}
			else if (m_bPressed)
			{
				return GetRenderState(GRST_PRESS);
			}
			else if (m_bMouseOver)
			{
				return GetRenderState(GRST_MOUSEOVER);
			}

			return GetRenderState(GRST_NORMAL);
		}

		virtual void RenderCtrlFont(const ggeGuiRenderState &rs)
		{
			float h = 0;

			if (GetFont()) 
			{
				h = (GetHeight() + GetLineSpace()) / 2.0f;
				h -= GetFont()->GetFontHight() / 2.0f;
			}

			RenderFont(rs, GetFont(), GetText(), GetPosX(), GetPosY() + h, (int)GetWidth(), GetFontState());
		}

		virtual void OnMouseLButton(bool bDown, float x, float y)
		{
			m_bPressed = bDown;
			if (!bDown && m_bMouseOver && GetRect().TestPoint(x, y)) 
				NotifyParent(CMT_BUTTON_CLICKED);
		}

		virtual void OnMouseOver(bool bOver)
		{
			m_bMouseOver = bOver;
		}

		virtual int GetType() 
		{ 
			return GGT_Button; 
		}

	private:
		bool m_bPressed;
		bool m_bMouseOver;

		ggeGuiRenderState m_pressRS;
		ggeGuiRenderState m_mouseOverRS;
	};

	/// CheckButton �ؼ�
	class ggeGuiCheckButton : public ggeGuiWindow
	{
	public:
		ggeGuiCheckButton(int id = -1, const ggeRect &rect = ggeRect(0, 0, 32.0f, 32.0f)) : ggeGuiWindow(id, rect)
		{
			m_bChecked = false;
			m_bPressed = false;
			m_bMouseOver = false;
		}

		/// ����ѡ��״̬
		void SetChecked(bool b)
		{
			if (IsChecked() != b)
			{
				m_bChecked = b;
				NotifyParent(CMT_CHECKBUTTON_TOGGLED);
			}
		}
		/// ����ѡ��״̬
		bool IsChecked()
		{
			return m_bChecked;
		}

		virtual void SetRenderState(GUI_RENDER_STATE_TYPE rt, const ggeGuiRenderState &rs)
		{
			switch (rt)
			{
			case GRST_PRESS:
				m_pressRS = rs;
				break;

			case GRST_MOUSEOVER:
				m_mouseOverRS = rs;
				break;

			case GRST_CHECKED_NORMAL:
				m_chkNormalRS = rs;
				break;

			case GRST_CHECKED_DISABLE:
				m_chkDisableRS = rs;
				break;

			case GRST_CHECKED_PRESS:
				m_chkPressRS = rs;
				break;

			case GRST_CHECKED_MOUSEOVER:
				m_chkMouseOverRS = rs;
				break;

			default:
				ggeGuiWindow::SetRenderState(rt, rs);
				break;
			}
		}

		virtual ggeGuiRenderState* GetRenderState(GUI_RENDER_STATE_TYPE rt)
		{
			switch (rt)
			{
			case GRST_PRESS:
				return &m_pressRS;

			case GRST_MOUSEOVER:
				return &m_mouseOverRS;

			case GRST_CHECKED_NORMAL:
				return &m_chkNormalRS;

			case GRST_CHECKED_DISABLE:
				return &m_chkDisableRS;

			case GRST_CHECKED_PRESS:
				return &m_chkPressRS;

			case GRST_CHECKED_MOUSEOVER:
				return &m_chkMouseOverRS;
			}

			return ggeGuiWindow::GetRenderState(rt);
		}

		virtual ggeGuiRenderState*	GetCurRenderState()
		{
			if (IsChecked())
			{

				if (!IsEnabled())
				{
					return GetRenderState(GRST_CHECKED_DISABLE);
				}
				else if (m_bPressed)
				{
					return GetRenderState(GRST_CHECKED_PRESS);
				}
				else if (m_bMouseOver)
				{
					return GetRenderState(GRST_CHECKED_MOUSEOVER);
				}
				else
				{
					return GetRenderState(GRST_CHECKED_NORMAL);
				}
			}
			else
			{
				if (!IsEnabled())
				{
					return GetRenderState(GRST_DISABLE);
				}
				if (m_bPressed)
				{
					return GetRenderState(GRST_PRESS);
				}
				else if (m_bMouseOver)
				{
					return GetRenderState(GRST_MOUSEOVER);
				}
			}

			return GetRenderState(GRST_NORMAL);
		}

		virtual void OnMouseLButton(bool bDown, float x, float y)
		{
			m_bPressed = bDown;
			if (!bDown && m_bMouseOver && GetRect().TestPoint(x, y))
			{
				m_bChecked = !m_bChecked;
				NotifyParent(CMT_BUTTON_CLICKED);
				NotifyParent(CMT_CHECKBUTTON_TOGGLED);
			}
		}

		virtual void OnMouseOver(bool bOver)
		{
			m_bMouseOver = bOver;
		}

		virtual int GetType() 
		{ 
			return GGT_CheckButton; 
		}

	private:
		bool m_bPressed;
		bool m_bMouseOver;
		bool m_bChecked;

		ggeGuiRenderState m_pressRS;
		ggeGuiRenderState m_mouseOverRS;
		ggeGuiRenderState m_chkNormalRS;
		ggeGuiRenderState m_chkDisableRS;
		ggeGuiRenderState m_chkPressRS;
		ggeGuiRenderState m_chkMouseOverRS;
	};
}