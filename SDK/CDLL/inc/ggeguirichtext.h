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
\brief RichText�ؼ�
*/

#pragma once
#include "ggeguiwindow.h"

namespace gge
{
	/// RichText �ؼ�
	class ggeGuiRichText : public ggeGuiWindow
	{
	public:
		ggeGuiRichText(int id = -1, const ggeRect &rect = ggeRect(0, 0, 32.0f, 32.0f)) : ggeGuiWindow(id, rect), m_bUpdateData(false)
		{
			_CreateRichTextData();
			SetStatic(true);
		}
		virtual ~ggeGuiRichText()
		{
			_DeleteRichTextData();
		}

		/**
		@brief �����ı�
		@note �����б�\n
		\##: "#"����\n
		\#c: ����������ɫ���磺"#cFF0000FF��ɫ����"\n
		\#d: ������Ӱ��ɫ\n
		\#b: ���ñ߿���ɫ\n
		\#u: �л������Ƿ���»���\n
		\#p: ���뷽ʽ( 0:����� / 1:���ж��� / 2:�Ҷ��� )\n
		\#s: ����Sprite���磺"���м���ʾ#s1ͼ��"\n
		\#a: ����Animation���磺"���м���ʾ#a1ͼ��"\n
		\#f: ����������������( 0:�ָ�Ĭ������ / >0:������������ )���磺"��ͨ����#f1�������#f0��ͨ����"\n
		*/
		virtual void		SetText(const char *text)	{ ggeGuiWindow::SetText(text); m_bUpdateData = true; }
		/// ����������ֿ�ȣ������ÿ���Զ����У���Ϊ0���Զ����У�Ĭ��Ϊ0
		GGE_EXPORT void		SetMaxTextWidth(gUShort width);
		/// ����������ֿ��
		GGE_EXPORT gUShort	GetMaxTextWidth();
		/// �����ı����
		GGE_EXPORT gUShort	GetCurTextWidth();
		/// �����ı��߶�
		GGE_EXPORT gUShort	GetCurTextHeigth();

		/// ����Sprite
		GGE_EXPORT void		InsertSprite(gUShort id, ggeSprite *spr);
		/// �Ƴ�Sprite
		GGE_EXPORT void		RemoveSprite(gUShort id);
		/// ����Animation
		GGE_EXPORT void		InsertAnimation(gUShort id, ggeAnimation *ani);
		/// �Ƴ�Animation
		GGE_EXPORT void		RemoveAnimation(gUShort id);
		/// ����Font
		GGE_EXPORT void		InsertFont(gUShort id, ggeFont *fnt);
		/// �Ƴ�Font
		GGE_EXPORT void		RemoveFont(gUShort id);

		virtual	void		SetPos(float x, float y, bool bMoveChild = true) { ggeGuiWindow::SetPos(x, y, bMoveChild); m_bUpdateData = true; }
		virtual void		SetWidth(float width)	{ ggeGuiWindow::SetWidth(width); m_bUpdateData = true; }
		virtual void		SetHeight(float height)	{ ggeGuiWindow::SetHeight(height); m_bUpdateData = true; }
		virtual void		SetRect(const ggeRect &rt, bool bMoveChild = true) { ggeGuiWindow::SetRect(rt, bMoveChild); m_bUpdateData = true; }
		virtual void		SetLineSpace(int v)		{ ggeGuiWindow::SetLineSpace(v); m_bUpdateData = true;; }
		virtual void		SetCharSpace(int v)		{ ggeGuiWindow::SetCharSpace(v); m_bUpdateData = true; }
		virtual void		SetFontState(const ggeGuiFontState &fontRS) { ggeGuiWindow::SetFontState(fontRS); m_bUpdateData = true; }
		virtual void		SetFont(ggeFont *font)	{ ggeGuiWindow::SetFont(font); m_bUpdateData = true; }

		virtual void		OnUpdate(float dt)		{ _OnUpdate(dt); }
		virtual void		OnRender()				{ _OnRender(); }
		virtual int			GetType()				{ return GGT_RichText; }

	private:
		GGE_EXPORT	void	_CreateRichTextData();
		GGE_EXPORT	void	_DeleteRichTextData();
		GGE_EXPORT	void	_OnUpdate(float dt);
		GGE_EXPORT	void	_OnRender();
		GGE_EXPORT	void	_UpdateData();

		class				ggeGuiRichTextData;
		ggeGuiRichTextData	*m_rcTextData;
		bool				m_bUpdateData;
	};
}