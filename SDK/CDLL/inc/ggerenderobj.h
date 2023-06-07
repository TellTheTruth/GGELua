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
\brief ��Ⱦ�������
*/

#pragma once
#include "ggecommon.h"
#include "ggerefcounter.h"

namespace gge
{
	/// ��Ⱦ����
	class ggeRenderObj : public ggeRefCounter
	{
	public:
		ggeRenderObj() : m_parentObj(0), m_zorder(0), m_bValid(true), m_bVisible(true), m_posX(0), m_posY(0)
		{
			_CreateRenderObjData();
		}

		~ggeRenderObj()
		{
			RemoveAllChild();
			if (GetParentObj()) 
				GetParentObj()->_RemoveFromChildList(this);

			_DeleteRenderObjData();
		}

		/// ���ظ���Ⱦ����
		ggeRenderObj* GetParentObj() const	{ return m_parentObj; }

		/// ���ظ���Ⱦ����
		GGE_EXPORT ggeRenderObj* GetRootObj() const;

		/// �������Ⱦ����
		GGE_EXPORT void AddChild(ggeRenderObj* obj);

		/// �Ƴ�����Ⱦ����
		GGE_EXPORT void RemoveChild(ggeRenderObj* obj);

		/// �Ƴ���������Ⱦ����
		GGE_EXPORT void RemoveAllChild();

		/// ��������Ⱦ��������
		GGE_EXPORT gUInt GetChildNum() const;

		/// ��������Ⱦ�����б���ָ��λ�õ���Ⱦ����
		GGE_EXPORT ggeRenderObj* GetChild(gUInt pos) const;

	public:
		/// ˢ��
		virtual	void Update(float dt)				
		{ 
			OnUpdate(dt); 
			_Update(dt);
		}

		/// ��Ⱦ
		virtual	void Render()						
		{ 
			if (IsVisible())
			{
				if (GetChildNum() > 0)
				{
					_Render();
				}
				else
				{
					OnRender();
				}
			}
		}

		/// ˢ��ʱ����
		virtual void	OnUpdate(float dt)			{}
		/// ��Ⱦʱ����
		virtual void	OnRender()					{}

		/// ������Ը���Ⱦ��������
		virtual void	SetPos(float x, float y)	{ m_posX = x; m_posY = y; }
		/// ������Ը���Ⱦ��������
		virtual float	GetPosX() const				{ return m_posX; }
		/// ������Ը���Ⱦ��������
		virtual float	GetPosY() const				{ return m_posY; }

		/// ���þ�������
		virtual void	SetAbsolutePos(float x, float y)
		{
			ggeRenderObj *obj = GetParentObj();
			if (obj) SetPos(x - obj->GetAbsolutePosX(), y - obj->GetAbsolutePosY());
			else SetPos(x, y);
		}
		/// ���ؾ�������
		virtual float	GetAbsolutePosX() const
		{
			float x = GetPosX();
			ggeRenderObj *obj = GetParentObj();
			if (obj) x += obj->GetAbsolutePosX();

			return x;
		}
		/// ���ؾ�������
		virtual float	GetAbsolutePosY() const
		{
			float y = GetPosY();
			ggeRenderObj *obj = GetParentObj();
			if (obj) y += obj->GetAbsolutePosY();

			return y;
		}

	public:
		/// �����Ҫ��ZOrder���򣬿�����Ⱦǰ�ֶ����øú�����bTraversalָ���Ƿ���������ӿؼ�
		virtual void	Sort(bool bTraversal = false) { _Sort(bTraversal); }

		/// �Ƿ���Ч�������Ч�ᱻ����Ⱦ��������
		virtual bool	IsValid() const				{ return m_bValid; }
		/// ����Ϊ��Ч״̬
		virtual void	Kill()						{ m_bValid = false; }

		/// ����ZOrder��Ĭ��Ϊ0����ֵԽ��Խ����Ⱦ�����<0���ʾ�ڸ��ڵ�֮ǰ��Ⱦ
		virtual void	SetZOrder(int z)			{ m_zorder = z; }
		/// ����ZOrder
		virtual int		GetZOrder() const			{ return m_zorder; }

		/// �����Ƿ�ɼ�
		virtual void	SetVisible(bool b)			{ m_bVisible = b; }
		/// �����Ƿ�ɼ�
		virtual bool	IsVisible() const			{ return m_bVisible; }

	private:
		bool	m_bValid;
		int		m_zorder;
		bool	m_bVisible;
		float	m_posX;
		float	m_posY;

		ggeRenderObj	*m_parentObj;
		void			*m_renderObjData;

	private:
		GGE_EXPORT	void	_CreateRenderObjData();
		GGE_EXPORT	void	_DeleteRenderObjData();

		GGE_EXPORT	bool	_RemoveFromChildList(ggeRenderObj* obj);
		GGE_EXPORT	void	_Update(float dt);
		GGE_EXPORT	void	_Render();
		GGE_EXPORT	void	_Sort(bool bTraversal);
	};
};