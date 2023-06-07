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
\brief Slider�ؼ�
*/

#pragma once
#include "ggeguiwindow.h"

namespace gge
{
	/// Slider �ؼ�
	class ggeGuiSlider : public ggeGuiWindow
	{
	public:
		ggeGuiSlider(int id = -1, const ggeRect &rect = ggeRect(0, 0, 32.0f, 32.0f)) : ggeGuiWindow(id, rect),
			m_bVertical(false), m_bPressed(false), m_bMouseOver(false), m_min(0), m_max(0), m_val(0), m_barSize(32.0f) {}

		/// �����Ƿ�ֱ����
		void			SetVertical(bool b)				{ m_bVertical = b; }
		/// �Ƿ�ֱ����
		bool			IsVertical()					{ return m_bVertical; }
		/// ���û���ߴ�
		void			SetBarSize(float v)				{ m_barSize = v; }
		/// ���ػ���ߴ�
		float			GetBarSize()					{ return m_barSize; }

		/// �������ֵ����Сֵ
		void			SetRange(float min, float max)
		{
			if (max < min) max = min; 
			m_min = min; 
			m_max = max; 
			SetValue(GetValue());
		}
		/// ������Сֵ
		float			GetMinVal()						{ return m_min; }
		/// �������ֵ
		float			GetMaxVal()						{ return m_max; }
		/// ���õ�ǰֵ
		void			SetValue(float val)
		{
			if (val < m_min) m_val = m_min;
			else if (val > m_max) m_val = m_max;
			else m_val = val;

			NotifyParent(CMT_SLIDER_VALUE_CHANGED);
		}
		/// ��õ�ǰֵ
		float			GetValue()						{ return m_val; }

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

		virtual ggeGuiRenderState* GetCurRenderState()
		{
			if (!IsEnabled())
			{
				return GetRenderState(GRST_DISABLE);
			}
			else if (m_bPressed)
			{
				return GetRenderState(GRST_PRESS);
			}
			else if (m_bMouseOver && m_drawRt.TestPoint(m_mouseX, m_mouseY))
			{
				return GetRenderState(GRST_MOUSEOVER);
			}

			return GetRenderState(GRST_NORMAL);
		}

		virtual void OnRender()							{ _OnRender(); }
		virtual void OnMouseMove(float x, float y)		{ _OnMouseMove(x, y); }
		virtual void OnMouseLButton(bool bDown, float x, float y)
		{
			m_bPressed = bDown;
			OnMouseMove(x, y);
		}
		virtual void OnMouseOver(bool bOver)			{ m_bMouseOver = bOver; }
		virtual int GetType()							{ return GGT_Slider; }

	private:
		GGE_EXPORT	void	_UpdateDrawRect();
		GGE_EXPORT	void	_OnRender();
		GGE_EXPORT	void	_OnMouseMove(float x, float y)	;

		bool	m_bMouseOver;
		bool	m_bPressed;
		bool	m_bVertical;
		float	m_mouseX;
		float	m_mouseY;
		ggeRect	m_drawRt;

		float	m_min;
		float	m_max;
		float	m_val;
		float	m_barSize;

		ggeGuiRenderState m_pressRS;
		ggeGuiRenderState m_mouseOverRS;
	};
}