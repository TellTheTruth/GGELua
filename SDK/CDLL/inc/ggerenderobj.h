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
\brief 渲染对象管理
*/

#pragma once
#include "ggecommon.h"
#include "ggerefcounter.h"

namespace gge
{
	/// 渲染对象
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

		/// 返回父渲染对象
		ggeRenderObj* GetParentObj() const	{ return m_parentObj; }

		/// 返回根渲染对象
		GGE_EXPORT ggeRenderObj* GetRootObj() const;

		/// 添加子渲染对象
		GGE_EXPORT void AddChild(ggeRenderObj* obj);

		/// 移除子渲染对象
		GGE_EXPORT void RemoveChild(ggeRenderObj* obj);

		/// 移除所有子渲染对象
		GGE_EXPORT void RemoveAllChild();

		/// 返回子渲染对象总数
		GGE_EXPORT gUInt GetChildNum() const;

		/// 返回子渲染对象列表中指定位置的渲染对象
		GGE_EXPORT ggeRenderObj* GetChild(gUInt pos) const;

	public:
		/// 刷新
		virtual	void Update(float dt)				
		{ 
			OnUpdate(dt); 
			_Update(dt);
		}

		/// 渲染
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

		/// 刷新时调用
		virtual void	OnUpdate(float dt)			{}
		/// 渲染时调用
		virtual void	OnRender()					{}

		/// 设置相对父渲染对象坐标
		virtual void	SetPos(float x, float y)	{ m_posX = x; m_posY = y; }
		/// 返回相对父渲染对象坐标
		virtual float	GetPosX() const				{ return m_posX; }
		/// 返回相对父渲染对象坐标
		virtual float	GetPosY() const				{ return m_posY; }

		/// 设置绝对坐标
		virtual void	SetAbsolutePos(float x, float y)
		{
			ggeRenderObj *obj = GetParentObj();
			if (obj) SetPos(x - obj->GetAbsolutePosX(), y - obj->GetAbsolutePosY());
			else SetPos(x, y);
		}
		/// 返回绝对坐标
		virtual float	GetAbsolutePosX() const
		{
			float x = GetPosX();
			ggeRenderObj *obj = GetParentObj();
			if (obj) x += obj->GetAbsolutePosX();

			return x;
		}
		/// 返回绝对坐标
		virtual float	GetAbsolutePosY() const
		{
			float y = GetPosY();
			ggeRenderObj *obj = GetParentObj();
			if (obj) y += obj->GetAbsolutePosY();

			return y;
		}

	public:
		/// 如果需要按ZOrder排序，可在渲染前手动调用该函数，bTraversal指定是否遍历所有子控件
		virtual void	Sort(bool bTraversal = false) { _Sort(bTraversal); }

		/// 是否有效，如果无效会被父渲染对象销毁
		virtual bool	IsValid() const				{ return m_bValid; }
		/// 设置为无效状态
		virtual void	Kill()						{ m_bValid = false; }

		/// 返回ZOrder，默认为0，数值越大越后渲染，如果<0则表示在父节点之前渲染
		virtual void	SetZOrder(int z)			{ m_zorder = z; }
		/// 返回ZOrder
		virtual int		GetZOrder() const			{ return m_zorder; }

		/// 设置是否可见
		virtual void	SetVisible(bool b)			{ m_bVisible = b; }
		/// 返回是否可见
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