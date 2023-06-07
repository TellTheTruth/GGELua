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
\brief ListBox�ؼ�
*/

#pragma once
#include "ggeguiwindow.h"

namespace gge
{
	/// ListBox �ؼ�
	class ggeGuiListBox : public ggeGuiWindow
	{
	public:
		ggeGuiListBox(int id = -1, const ggeRect &rect = ggeRect(0, 0, 32.0f, 32.0f)) : ggeGuiWindow(id, rect)
		{
			_CreateListBoxData();
			m_selectedItem = -1;
			m_topItem = 0;
			m_bMouseOver = false;
		}

		virtual ~ggeGuiListBox()
		{
			_DeleteListBoxData();
		}

		/// ���һ����Ŀ��������Ŀ��������Ŀ������0��ʼ
		GGE_EXPORT	int		AddItem(const char *item, void *p = 0);
		/// ɾ��һ����Ŀ
		GGE_EXPORT	bool	DeleteItem(int n);
		/// ��õ�ǰѡ�е���Ŀ����Ŀ������δѡ���κ����-1
		int		GetSelectedItem()			{ return m_selectedItem; }
		/// ���õ�ǰѡ�е���Ŀ����Ŀ����
		GGE_EXPORT	void	SetSelectedItem(int n);
		/// �õ�������Ŀ����
		int		GetTopItem()				{ return m_topItem; }
		/// ���ö�����Ŀ����
		GGE_EXPORT	void	SetTopItem(int n);

		/// ������Ŀ������
		GGE_EXPORT	bool	SetContext(int n, void *p);
		/// ������Ŀ������
		GGE_EXPORT	void*	GetContext(int n);
		/// ������Ŀ�ı�
		GGE_EXPORT	void	SetItemText(int n, const char *text);
		/// �����Ŀ�ı�
		GGE_EXPORT	const char*	GetItemText(int n);
		/// �����Ŀ����
		GGE_EXPORT	int		GetNumItems();
		/// �����ʾ����Ŀ��
		GGE_EXPORT	int		GetNumRows();
		/// ɾ��������Ŀ
		GGE_EXPORT	void	Clear();

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

		virtual void	OnRender()						{ _OnRender(); }
		virtual void	OnMouseLButton(bool bDown, float x, float y) { _OnMouseLButton(bDown, x, y); }
		virtual void	OnMouseOver(bool bOver)			{ m_bMouseOver = bOver; }
		virtual void	OnMouseMove(float x, float y)	{ m_mouseY = y; }
		virtual void	OnMouseWheel(int notches)		{ int topItem = m_topItem - notches; SetTopItem(topItem); NotifyParent(CMT_LIST_ITEM_ROLL); }
		virtual void	OnKeyClick(int key, const char *str) { _OnKeyClick(key, str); }
		virtual int		GetType()						{ return GGT_ListBox; }

	private:
		GGE_EXPORT	void	_CreateListBoxData();
		GGE_EXPORT	void	_DeleteListBoxData();
		GGE_EXPORT	void	_OnRender();
		GGE_EXPORT	void	_OnMouseLButton(bool bDown, float x, float y);
		GGE_EXPORT	void	_OnKeyClick(int key, const char *str);

		struct				ggeGuiListBoxData;
		ggeGuiListBoxData	*m_listBoxData;

		ggeGuiRenderState	m_pressRS;
		ggeGuiRenderState	m_mouseOverRS;

		bool	m_bMouseOver;
		float	m_mouseY;

		int		m_selectedItem;
		int		m_topItem;
	};
}