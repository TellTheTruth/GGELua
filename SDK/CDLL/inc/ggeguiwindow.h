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
\brief GUIģ��
*/

#pragma once
#include <string>
#include "ggemath.h"
#include "ggerefcounter.h"
#include "ggevariant.h"
#include "ggetexture.h"
#include "ggefont.h"
#include "ggesprite.h"

namespace gge
{
	/// GUI����
	enum GGE_GUI_TYPE
	{
		GGT_Window,		///< Window
		GGT_Button,		///< Button
		GGT_CheckButton,///< CheckButton
		GGT_Slider,		///< Slider
		GGT_ListBox,	///< ListBox
		GGT_EditBox,	///< EditBox
		GGT_RichText,	///< RichText
		GGT_Last,
		GGT_FORCE32BIT = 0x7FFFFFFF,
	};

	/// �ӿؼ���Ϣ����
	enum CHILD_MESSAGE_TYPE
	{
		CMT_MOUSE_ENTER,			///< ����Ƶ��ؼ���
		CMT_MOUSE_LEAVE,			///< ���ӿؼ�������
		CMT_MOUSE_MOVE,				///< ����ƶ�
		CMT_MOUSE_LBUTTON_DOWN,		///< ����������
		CMT_MOUSE_LBUTTON_UP,		///< ������̧��
		CMT_MOUSE_RBUTTON_DOWN,		///< ����Ҽ�����
		CMT_MOUSE_RBUTTON_UP,		///< ����Ҽ�̧��
		CMT_MOUSE_WHEEL,			///< �������ƶ�
		CMT_KEY_CLICK,				///< ���̰���

		CMT_GAIN_FOCUSE,			///< ��ý���
		CMT_LOST_FOCUSE,			///< ʧȥ����
		CMT_BUTTON_CLICKED,			///< ���Button
		CMT_CHECKBUTTON_TOGGLED,	///< CheckButton״̬�ı�
		CMT_EDIT_TEXT_CHANGED,		///< EditBox���ݸı�
		CMT_SLIDER_VALUE_CHANGED,	///< Slider��ֵ�仯
		CMT_SLIDER_BAR_MOVED,		///< Slider�����ƶ�
		CMT_LIST_ITEM_CLICKED,		///< ListBox�����
		CMT_LIST_ITEM_CHANGED,		///< ListBoxѡ����ı�
		CMT_LIST_TOP_ITEM_CHANGED,	///< ListBox������Ŀ�ı�
		CMT_LIST_ITEM_ROLL,			///< ListBox��Ŀ����
		CMT_LAST,
		CMT_FORCE32BIT = 0x7FFFFFFF,
	};

	/// GUI��Ⱦ״̬
	enum GUI_RENDER_STATE_TYPE
	{
		GRST_NORMAL,				///< ��ͨ״̬
		GRST_PRESS,					///< ����״̬
		GRST_MOUSEOVER,				///< ��꾭��״̬
		GRST_DISABLE,				///< ��Ч״̬
		GRST_CHECKED_NORMAL,		///< ѡ����ͨ״̬
		GRST_CHECKED_PRESS,			///< ѡ�а���״̬
		GRST_CHECKED_MOUSEOVER,		///< ѡ����꾭��״̬
		GRST_CHECKED_DISABLE,		///< ѡ����Ч״̬
		GRST_LAST,
		GRST_FORCE32BIT = 0x7FFFFFFF,
	};

	/// GUI������Ⱦ��ʽ
	enum GUI_TEXTURE_RENDER_TYPE
	{
		GTRT_NORMAL,		///< ����
		GTRT_STRETCH,		///< ����
		GTRT_STRETCH_H,		///< ˮƽ���죬���������ҷ���������
		GTRT_STRETCH_V,		///< ��ֱ���죬�������ϡ��·���������
		GTRT_STRETCH_RECT,	///< �������죬�������ϡ��¡����ҷ���������
		GTRT_TILE,			///< ƽ��
		GTRT_LAST,
		GTRT_FORCE32BIT = 0x7FFFFFFF,
	};

	/// GUI������Ϣ
	class ggeGuiCreateInfo : public ggeRefCounter
	{
	public:
		/// ����ID
		virtual int GetID() = 0;
		/// ���ؿؼ��ߴ�
		virtual const ggeRect& GetRect() = 0;
		/// ���ؿؼ����� @see GGE_GUI_TYPE
		virtual int GetType() = 0;
		/// ��������
		virtual const char* GetName() = 0;
		/// �����Զ������Զ�Ӧ��ֵ�����û���з���0
		virtual ggeVariant* GetValue(const char *key) = 0;
		/// �����Զ���ؼ�����
		virtual const char* GetClassName() = 0;
	};

	/// GUI��Ⱦ״̬
	class ggeGuiRenderState
	{
	public:
		/// ���캯��
		ggeGuiRenderState() : m_texRT(GTRT_NORMAL), m_texture(0), m_texRect(0, 0, 0, 0), 
			m_texColor(0xFFFFFFFF), m_topTexSize(0), m_bottomTexSize(0), m_leftTexSize(0), m_rightTexSize(0), 
			m_fontColor(0xFFFFFFFF), m_fontBColor(0xFF000000), m_fontSColor(0), m_fontOffsetX(0), m_fontOffsetY(0){}
		/// ���캯��
		ggeGuiRenderState(const ggeGuiRenderState &val) :
		m_texRT(val.m_texRT), m_texture(val.m_texture), m_texRect(val.m_texRect), 
			m_texColor(val.m_texColor), m_topTexSize(val.m_topTexSize), m_bottomTexSize(val.m_bottomTexSize), 
			m_leftTexSize(val.m_leftTexSize), m_rightTexSize(val.m_rightTexSize), m_fontColor(val.m_fontColor), 
			m_fontBColor(val.m_fontBColor), m_fontSColor(val.m_fontSColor), m_fontOffsetX(val.m_fontOffsetX), 
			m_fontOffsetY(val.m_fontOffsetY) { if (m_texture) m_texture->AddRef(); }
		/// ��ֵ����
		ggeGuiRenderState& operator = (const ggeGuiRenderState &val)
		{
			if (this == &val) return *this;
			GGE_RELEASE(m_texture);

			m_texRT = val.m_texRT;
			m_texture = val.m_texture;
			m_texRect = val.m_texRect; 
			m_texColor = val.m_texColor;
			m_topTexSize = val.m_topTexSize;
			m_bottomTexSize = val.m_bottomTexSize;
			m_leftTexSize = val.m_leftTexSize;
			m_rightTexSize = val.m_rightTexSize;
			m_fontColor = val.m_fontColor;
			m_fontBColor = val.m_fontBColor;
			m_fontSColor = val.m_fontSColor;
			m_fontOffsetX = val.m_fontOffsetX;
			m_fontOffsetY = val.m_fontOffsetY;
			if (m_texture) m_texture->AddRef();

			return *this;
		}

		~ggeGuiRenderState()
		{
			GGE_RELEASE(m_texture);
		}

		/// ����������Ⱦ��ʽ
		void SetTexRenderType(GUI_TEXTURE_RENDER_TYPE rt)	{ m_texRT = rt; }
		/// ����������Ⱦ��ʽ
		GUI_TEXTURE_RENDER_TYPE GetTexRenderType() const	{ return m_texRT; }

		/// ��������
		void SetTexture(ggeTexture *tex)
		{
			GGE_RELEASE(m_texture);
			if (tex) tex->AddRef();
			m_texture = tex;
		}
		/// ��������
		ggeTexture* GetTexture() const		{ return m_texture; }
		/// ������������
		void SetTexRect(const ggeRect &rt)	{ m_texRect = rt; }
		/// ������������
		const ggeRect& GetTexRect() const	{ return m_texRect; }
		/// ����������ɫ
		void SetTexColor(gUInt color)		{ m_texColor = color; }
		/// ����������ɫ
		gUInt GetTexColor() const			{ return m_texColor; }

		/// ���÷������ƽ������
		void SetTopTexSize(float v)			{ m_topTexSize = v; }
		/// ���ط������ƽ������
		float GetTopTexSize() const			{ return m_topTexSize; }
		/// ���÷������ƽ������
		void SetBottomTexSize(float v)		{ m_bottomTexSize = v; }
		/// ���ط������ƽ������
		float GetBottomTexSize() const		{ return m_bottomTexSize; }
		/// ���÷������ƽ������
		void SetLeftTexSize(float v)		{ m_leftTexSize = v; }
		/// ���ط������ƽ������
		float GetLeftTexSize() const		{ return m_leftTexSize; }
		/// ���÷������ƽ������
		void SetRightTexSize(float v)		{ m_rightTexSize = v; }
		/// ���ط������ƽ������
		float GetRightTexSize() const		{ return m_rightTexSize; }

		/// ����������ɫ
		void SetFontColor(gUInt color)		{ m_fontColor = color; }
		/// ����������ɫ
		gUInt GetFontColor() const			{ return m_fontColor; }
		/// ��������߿���ɫ
		void SetFontBColor(gUInt color)		{ m_fontBColor = color; }
		/// ��������߿���ɫ
		gUInt GetFontBColor() const			{ return m_fontBColor; }
		/// ����������Ӱ��ɫ
		void SetFontSColor(gUInt color)		{ m_fontSColor = color; }
		/// ����������Ӱ��ɫ
		gUInt GetFontSColor() const			{ return m_fontSColor; }
		///< ������ʾʱ��Կؼ����Ͻ�ƫ����
		void SetFontOffsetX(float v)		{ m_fontOffsetX = v; }
		///< ������ʾʱ��Կؼ����Ͻ�ƫ����
		float GetFontOffsetX() const		{ return m_fontOffsetX; }
		///< ������ʾʱ��Կؼ����Ͻ�ƫ����
		void SetFontOffsetY(float v)		{ m_fontOffsetY = v; }
		///< ������ʾʱ��Կؼ����Ͻ�ƫ����
		float GetFontOffsetY() const		{ return m_fontOffsetY; }

	private:
		GUI_TEXTURE_RENDER_TYPE	m_texRT;

		ggeTexture	*m_texture;
		ggeRect		m_texRect;
		gUInt		m_texColor;

		float		m_topTexSize;
		float		m_bottomTexSize;
		float		m_leftTexSize;
		float		m_rightTexSize;

		gUInt		m_fontColor;
		gUInt		m_fontBColor;
		gUInt		m_fontSColor;
		float		m_fontOffsetX;
		float		m_fontOffsetY;
	};

	/// GUI����״̬
	struct ggeGuiFontState
	{
		/// ���캯��
		ggeGuiFontState() : alignMode(TEXT_LEFT), bTextWarp(false), lineSpace(0), charSpace(0) {}
		/// ���캯��
		ggeGuiFontState(int _alignMode, bool _bTextWarp, int _lineSpace, int _charSpace) :
			alignMode(_alignMode), bTextWarp(_bTextWarp), lineSpace(_lineSpace), charSpace(_charSpace) {}

		int alignMode;	///< ����ģʽ
		bool bTextWarp;	///< �Զ�����
		int lineSpace;	///< �м��
		int charSpace;	///< �ּ��
	};

	/// Window �ؼ�
	class ggeGuiWindow : public ggeRefCounter
	{
	public:
		/**
		@brief ���캯��
		@param id �ؼ�ID
		@param rect �ؼ��ߴ磺ggeRect(X����, Y����, ���, �߶�)
		*/
		ggeGuiWindow(int id = -1, const ggeRect &rect = ggeRect(0, 0, 32.0f, 32.0f)) : 
		  m_id(id), m_rect(rect), m_next(0), m_prev(0), m_parent(0),m_bStatic(false), m_bVisible(true), 
			  m_bEnabled(true), m_firstChild(0), m_lastChild(0), m_bNotifyParent(false), m_font(0), 
			  m_tooltipWidth(0), m_createInfo(0)
		  {
			  _CreateWindowData();
			  m_spr = Sprite_Create(0);
			  SetWidth(m_rect.x2);
			  SetHeight(m_rect.y2);
		  }

		/// ��������
		virtual ~ggeGuiWindow()
		{
			RemoveAllCtrl();
			GGE_RELEASE(m_font);
			GGE_RELEASE(m_spr);
			GGE_RELEASE(m_createInfo);
			_DestroyWnd();
			_DeleteWindowData();
		}
		
		/// ���ÿؼ�ID
		virtual void	SetID(int id)						{ m_id = id; }
		/// ���ؿؼ�ID
		virtual int		GetID()								{ return m_id; }
		/// ���ÿؼ�����
		virtual void	SetName(const char *name)			{ _SetName(name); }
		/// ���ؿؼ�����
		virtual const char*	GetName()						{ return _GetName(); }
		/// ���ÿؼ�ToolTip
		virtual void	SetToolTip(const char *str)			{ _SetToolTip(str); }
		/// ���ؿؼ�ToolTip
		virtual const char* GetToolTip()					{ return _GetToolTip(); }
		/// ����ToolTip��ȣ�Ĭ��Ϊ0��Ϊ0ʱ����Ӧ���õ�ToolTip�ַ����
		virtual void	SetToolTipWidth(gUShort w)			{ m_tooltipWidth = w; }
		/// ����ToolTip���
		virtual gUShort GetToolTipWidth()					{ return m_tooltipWidth; }

		/// ��������
		virtual	void	SetPos(float x, float y, bool bMoveChild = true) { _SetPos(x, y, bMoveChild); }
		/// ����x����
		virtual float	GetPosX()				{ return m_rect.x1; }
		/// ����y����
		virtual float	GetPosY()				{ return m_rect.y1; }
		/// ���ÿ��
		virtual void	SetWidth(float width)	{ m_rect.x2 = m_rect.x1 + width; }
		/// ���ؿ��
		virtual float	GetWidth()				{ return m_rect.x2 - m_rect.x1; }
		/// ���ø߶�
		virtual void	SetHeight(float height)	{ m_rect.y2 = m_rect.y1 + height; }
		/// ���ظ߶�
		virtual float	GetHeight()				{ return m_rect.y2 - m_rect.y1; }
		/// ���ÿؼ���������
		virtual void	SetRect(const ggeRect &rt, bool bMoveChild = true) { _SetRect(rt, bMoveChild); }
		/// ���ؿؼ���������
		virtual ggeRect& GetRect()				{ return m_rect; }
		/// �����յ����������Ϣʱ�Ƿ���֪ͨ���ؼ���������ؼ�δ���ղŷ��͵����ؼ�����Ĭ��Ϊfalse
		virtual void	SetNotifyParent(bool b)	{ m_bNotifyParent = b; }
		/// �����յ����������Ϣʱ�Ƿ���֪ͨ���ؼ�
		virtual bool	IsNotifyParent()		{ return m_bNotifyParent; }

		/// ��Ϊ��̬�ؼ�����̬�ؼ�������ռ��������Ϣ���������ý��㣬Ĭ��Ϊfalse
		virtual void	SetStatic(bool b)		{ m_bStatic = b; }
		/// �Ƿ��Ǿ�̬�ؼ�
		virtual bool	IsStatic()			
		{ 
			if (GetParent() && GetParent()->IsStatic()) return true;
			return m_bStatic; 
		}
		/// �����Ƿ�ɼ�������ؼ����ɼ���������ռ��������Ϣ���������ý��㣬Ҳ������Ⱦ��Ĭ��Ϊtrue
		virtual void	SetVisible(bool b)		{ m_bVisible = b; }
		/// �Ƿ�ɼ�
		virtual bool	IsVisible()	
		{ 
			if (GetParent() && !GetParent()->IsVisible()) return false;
			return m_bVisible; 
		}
		/// �����Ƿ���Ч������ؼ���Ч������ռ��������Ϣ���������ý��㣬Ҳ����ˢ�£�Ĭ��Ϊtrue
		virtual void	SetEnabled(bool b)		{ m_bEnabled = b;  }
		/// �Ƿ���Ч
		virtual bool	IsEnabled()
		{ 
			if (GetParent() && !GetParent()->IsEnabled()) return false;
			return m_bEnabled; 
		}
		/// �����ı�
		virtual void	SetText(const char *text)			{ _SetText(text); }
		/// �����ı�
		virtual const char*	GetText()						{ return _GetText(); }
		/// ���ö���ģʽ��Ĭ��Ϊ TEXT_LEFT @see FONT_ALIGN
		virtual void	SetAlignMode(int v)	{ m_fontState.alignMode = v; }
		/// ���ض���ģʽ
		virtual int		GetAlignMode()		{ return m_fontState.alignMode; }
		/// �����Ƿ��Զ����У�Ĭ��Ϊfalse
		virtual void	SetTextWarp(bool b)	{ m_fontState.bTextWarp = b; }
		/// �����Ƿ��Զ�����
		virtual bool	IsTextWarp()		{ return m_fontState.bTextWarp; }
		/// �����м��
		virtual void	SetLineSpace(int v) { m_fontState.lineSpace = v; }
		/// �����м��
		virtual int		GetLineSpace()		{ return m_fontState.lineSpace; }
		/// �����ּ��
		virtual void	SetCharSpace(int v) { m_fontState.charSpace = v; }
		/// �����ּ��
		virtual int		GetCharSpace()		{ return m_fontState.charSpace; }
		/// ��������״̬
		virtual void	SetFontState(const ggeGuiFontState &fontRS) { m_fontState = fontRS; }
		/// ��������״̬
		virtual const ggeGuiFontState& GetFontState()	{ return  m_fontState; }
		
		/// ��õ�һ���ӿؼ�
		virtual ggeGuiWindow*		GetFirstChildCtrl()	{ return m_firstChild; }
		/// ������һ���ӿؼ�
		virtual ggeGuiWindow*		GetLastChildCtrl()	{ return m_lastChild; }
		/// ����ǰһ���ؼ�
		virtual ggeGuiWindow*		GetPrevCtrl()		{ return m_prev; }
		/// ���غ�һ���ؼ�
		virtual ggeGuiWindow*		GetNextCtrl()		{ return m_next; }
		/// ���ظ��ؼ� 
		virtual ggeGuiWindow*		GetParent()			{ return m_parent; }
		/// ����Ϊ����ؼ�
		virtual void				SetTop()			{ _SetTop(); }
		/// ����Ϊ����ؼ�
		virtual void				SetFocus()			{ _SetFocus(); }

		/**
		@brief ���һ���ؼ������ʧ�ܷ���false
		@param ctrl Ҫ��ӵĿؼ�
		@param resetPos ������Ը��ؼ�����
		@return �ɹ�����true��ʧ�ܷ���false
		*/
		GGE_EXPORT	bool			AddCtrl(ggeGuiWindow *ctrl, bool resetPos = false);
		/// �Ƴ��ؼ�
		GGE_EXPORT	void			RemoveCtrl(ggeGuiWindow *ctrl);
		/// �Ƴ����пؼ�
		GGE_EXPORT	void			RemoveAllCtrl();
		/// ���ҵ�һ��ָ��ID�Ŀؼ���bTraversalָ���Ƿ���������ӿؼ�
		GGE_EXPORT	ggeGuiWindow*	FindCtrl(int id, bool bTraversal = false);
		/// ���ҵ�һ��ָ�����ֵĿؼ���bTraversalָ���Ƿ���������ӿؼ�
		GGE_EXPORT	ggeGuiWindow*	FindCtrl(const char *name, bool bTraversal = false);
		/// ����ָ��λ�õ�һ���ɼ��ؼ�
		ggeGuiWindow*				FindCtrlFromPoint(float x, float y)	{ return _FindCtrlFromPoint(GetLastChildCtrl(), x, y); }
		/// �ؼ��Ƿ��Ǹô��ڵ��ӿؼ���bTraversalָ���Ƿ���������ӿؼ�
		GGE_EXPORT	bool			IsChild(ggeGuiWindow *ctrl, bool bTraversal = false);
		/// �ô����Ƿ��ǿؼ����ӿؼ�
		GGE_EXPORT	bool			IsParent(ggeGuiWindow *ctrl);
		/**
		@brief ������Ϣ���ӿؼ�
		@param msgType ��Ϣ����
		@param msgData ��Ϣ����
		@param bTraversal ���Ϊfalse��ֻ������Ϣ����һ���ӿؼ������Ϊtrue��������Ϣ�������ӿؼ�
		*/
		bool						SendChildMsg(int msgType, void *msgData = 0, bool bTraversal = false) { return _SendChildMsg(this, m_lastChild, msgType, msgData, bTraversal); }
		/**
		@brief ������Ϣ�����ؼ�
		@param msgType ��Ϣ����
		@param msgData ��Ϣ����
		*/
		GGE_EXPORT	bool			SendParentMsg(int msgType, void *msgData = 0);
		/**
		@brief ֪ͨ���ؼ�
		@param msgType ��Ϣ���� @see CHILD_MESSAGE_TYPE
		*/
		virtual bool				NotifyParent(int msgType)	{ if (GetParent()) return GetParent()->OnChildMsg(msgType, this); return false; }

		/// ��������
		virtual void				SetFont(ggeFont *font)		{ GGE_RELEASE(m_font); if (font) font->AddRef(); m_font = font; }
		/// ��������
		virtual ggeFont*			GetFont()					{ return m_font; }
		/// ������Ⱦ״̬
		virtual void				SetRenderState(GUI_RENDER_STATE_TYPE rt, const ggeGuiRenderState &rs)
		{
			switch (rt)
			{
			case GRST_NORMAL:
				m_normalRS = rs;
				break;

			case GRST_DISABLE:
				m_disableRS = rs;
				break;
			}
		}
		/// ������Ⱦ״̬
		virtual ggeGuiRenderState*	GetRenderState(GUI_RENDER_STATE_TYPE rt)
		{
			switch (rt)
			{
			case GRST_NORMAL:
				return &m_normalRS;

			case GRST_DISABLE:
				return &m_disableRS;
			}

			return 0;
		}
		/// ���ص�ǰ��Ⱦ״̬
		virtual ggeGuiRenderState*	GetCurRenderState()
		{
			if (!IsEnabled())
			{
				return GetRenderState(GRST_DISABLE);
			}
			else
			{
				return GetRenderState(GRST_NORMAL);
			}

			return 0;
		}
		/// ��������
		GGE_EXPORT void	RenderTexture(const ggeGuiRenderState &rs, const ggeRect &rt);
		/// ��������
		GGE_EXPORT void	RenderFont(const ggeGuiRenderState &rs, ggeFont *font, const char *str, float x, float y, int lineWidth, const ggeGuiFontState &fontRS);
		/// ���ƿؼ�����
		virtual void	RenderCtrlTexture(const ggeGuiRenderState &rs)	{ RenderTexture(rs, GetRect()); }
		/// ���ƿؼ�����
		virtual void	RenderCtrlFont(const ggeGuiRenderState &rs)		{ RenderFont(rs, GetFont(), GetText(), GetPosX(), GetPosY(), (int)GetWidth(), GetFontState()); }
		/// ˢ�±��ؼ����ӿؼ�
		virtual void	Update(float dt)								{ _Update(dt); }
		/// ��Ⱦ���ؼ����ӿؼ�
		virtual void	Render()										{ _Render(); }

	public:
		/// ��Ⱦ�ؼ�
		virtual void	OnRender() { ggeGuiRenderState *rs = GetCurRenderState(); if (rs) { RenderCtrlTexture(*rs); RenderCtrlFont(*rs); } }
		/// ˢ�¿ؼ�
		virtual void	OnUpdate(float dt) {}

		/**
		@brief �ڿؼ��õ���ʧȥ����ʱ����
		@param bFocused Ϊtrueʱ�õ����㣬Ϊfalseʱʧȥ����
		*/
		virtual void	OnFocus(bool bFocused) {}
		/**
		@brief ��������뿪�ؼ�����ʱ����
		@param bOver Ϊtrueʱ����ؼ���Ϊfalseʱ�뿪�ؼ�
		*/
		virtual void	OnMouseOver(bool bOver) {}
		/**
		@brief ����ڿؼ����ƶ�ʱ����
		@param x ���X����
		@param y ���Y����
		*/
		virtual void	OnMouseMove(float x, float y) {}
		/**
		@brief ������״̬�ı�ʱ����
		@param bDown ��갴���Ƿ���
		@param x ���X����
		@param y ���Y����
		*/
		virtual void	OnMouseLButton(bool bDown, float x, float y) {}
		/**
		@brief ����Ҽ�״̬�ı�ʱ����
		@param bDown ��갴���Ƿ���
		@param x ���X����
		@param y ���Y����
		*/
		virtual void	OnMouseRButton(bool bDown, float x, float y) {}
		/**
		@brief ������ֵ�ı�ʱ����
		@param notches ����ֵ����ǰ����Ϊ����������Ϊ��
		*/
		virtual void	OnMouseWheel(int notches)	{}
		/**
		@brief ���̰���ʱ����
		@param key ��ֵ
		@param str �ַ���
		*/
		virtual void	OnKeyClick(int key, const char* str) {}
		/**
		@brief �յ���Ϣʱ����
		@param ctrl ������Ϣ�Ŀؼ�
		@param msgType ��Ϣ����
		@param msgData ��Ϣ����
		@return ������ո���Ϣ����true�����򷵻�false
		*/
		virtual bool	OnMessage(ggeGuiWindow *ctrl, int msgType, void *msgData = 0) { return false; }
		/**
		@brief �յ��ӿؼ���Ϣʱ����
		@param ctrl ������Ϣ�Ŀؼ�
		@param msgType ��Ϣ���� @see CHILD_MESSAGE_TYPE
		@return ������ո���Ϣ����true�����򷵻�false
		*/
		virtual bool	OnChildMsg(int msgType, ggeGuiWindow *ctrl) { if (GetParent()) return GetParent()->OnChildMsg(msgType, ctrl); return false; }
		/// ���ؿؼ����� @see GGE_GUI_TYPE
		virtual int		GetType() { return GGT_Window; }
		
		/// ���ش�����Ϣ
		virtual ggeGuiCreateInfo* GetCreateInfo() { return m_createInfo; }

	private:
		int				m_id;
		ggeRect			m_rect;
		bool			m_bStatic;
		bool			m_bVisible;
		bool			m_bEnabled;
		bool			m_bNotifyParent;
		gUShort			m_tooltipWidth;
		ggeGuiFontState	m_fontState;

		ggeGuiWindow	*m_next;
		ggeGuiWindow	*m_prev;
		ggeGuiWindow	*m_parent;
		ggeGuiWindow	*m_firstChild;
		ggeGuiWindow	*m_lastChild;
		ggeFont			*m_font;
		ggeSprite		*m_spr;

		ggeGuiRenderState	m_normalRS;
		ggeGuiRenderState	m_disableRS;
		ggeGuiCreateInfo	*m_createInfo;

		struct				ggeGuiWindowData;
		ggeGuiWindowData	*m_wndData;

	private:
		GGE_EXPORT	void			_CreateWindowData();
		GGE_EXPORT	void			_DeleteWindowData();
		GGE_EXPORT	void			_DestroyWnd();
		GGE_EXPORT	void			_SetName(const char *name);
		GGE_EXPORT	const char*		_GetName();
		GGE_EXPORT	void			_SetToolTip(const char *str);
		GGE_EXPORT	const char*		_GetToolTip();
		GGE_EXPORT	void			_SetText(const char *text);
		GGE_EXPORT	const char*		_GetText();
		GGE_EXPORT	void			_SetPos(float x, float y, bool bMoveChild);
		GGE_EXPORT	void			_SetRect(const ggeRect &rt, bool bMoveChild);
		GGE_EXPORT	void			_SetTop();
		GGE_EXPORT	void			_SetFocus();
		GGE_EXPORT	void			_RemoveCtrl(ggeGuiWindow *ctrl);
		GGE_EXPORT	ggeGuiWindow*	_FindCtrlFromPoint(ggeGuiWindow* ctrl, float x, float y);
		GGE_EXPORT	bool			_SendChildMsg(ggeGuiWindow *sendctrl, ggeGuiWindow *ctrl, int msgType, void *msgData, bool bTraversal);
		GGE_EXPORT	void			_Update(float dt);
		GGE_EXPORT	void			_Render();

	private:
		ggeGuiWindow(const ggeGuiWindow &val);
		ggeGuiWindow& operator = (const ggeGuiWindow &val);
		friend class ggeGUILoaderImp;
	};


}