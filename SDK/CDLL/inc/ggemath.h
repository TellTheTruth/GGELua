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
\brief ��ѧ��
*/

#pragma once
#include "ggecommon.h"

namespace gge
{
	/** @name Math
	*  @{
	*/

	#define GGE_PI		3.14159265358979323846f		///< Բ����
	#define GGE_PI_2	1.57079632679489661923f		///< Բ����
	#define GGE_PI_4	0.785398163397448309616f	///< Բ����
	#define GGE_1_PI	0.318309886183790671538f	///< Բ����
	#define GGE_2_PI	0.636619772367581343076f	///< Բ����

	/// ����ת�Ƕ�
	GGE_INLINE float ToDegree(float radian) { return (radian) * (180.0f / ((float)3.141592654f)); }
	/// �Ƕ�ת����
	GGE_INLINE float ToRadian(float degree) { return (degree) * (((float)3.141592654f) / 180.0f); }
	/// ��sΪ������v1��v2�����Բ�ֵ
	GGE_INLINE float LinearErp(float v1, float v2, float s) { return v1 + s * (v2 - v1); }

	/** 
	@} 
	*/

	/// Vector
	class GGE_EXPORT ggeVector
	{
	public:
		float	x;	///< x
		float	y;	///< y

		/// ���캯��
		ggeVector(float _x, float _y)				{ x = _x; y = _y; }
		/// ���캯��
		ggeVector()									{ x = 0; y = 0; }

		/// ���������
		ggeVector	operator-  (const ggeVector &v)	{ return ggeVector(x - v.x, y - v.y); }
		/// ���������
		ggeVector	operator+  (const ggeVector &v)	{ return ggeVector(x + v.x, y + v.y); }
		/// ���������
		ggeVector	operator*  (float scalar)		{ return ggeVector(x * scalar, y * scalar); }
		/// ���������
		ggeVector	operator/  (const float scalar)	{ return ggeVector(x / scalar, y / scalar); }
		/// ���������
		ggeVector&	operator-= (const ggeVector &v)	{ x -= v.x; y -= v.y; return *this; }
		/// ���������
		ggeVector&	operator+= (const ggeVector &v)	{ x += v.x; y += v.y; return *this; }
		/// ���������
		ggeVector&	operator*= (float scalar)		{ x *= scalar; y *= scalar; return *this; }
		/// ���������
		/// ���������
		ggeVector	operator-  ()					{ return ggeVector(-x, -y); }
		/// ���������
		bool		operator== (const ggeVector &v)	{ return (x == v.x && y == v.y); }
		/// ���������
		bool		operator!= (const ggeVector &v)	{ return (x != v.x || y != v.y); }

		/**
		@brief �����ʸ�����
		@param v ʸ��
		@return ��ʸ�����
		*/
		float		Dot(const ggeVector *v) const;
		/**
		@brief ��׼��ʸ��
		@return this
		*/
		ggeVector*	Normalize();	
		/**
		@brief ���ʸ������
		@return ʸ������
		*/
		float		Length() const;
		/**
		@brief �����ʸ����Ƕ�
		@param v ʸ��
		@return ��ʸ����Ƕ�
		*/
		float		Angle(const ggeVector *v = 0) const;
		/**
		@brief ��ʸ����תָ���Ƕ�
		@param radian ��ת�Ƕ�
		@return this
		*/
		ggeVector*	Rotate(float radian);
		/**
		@brief ʹʸ�����Ȳ�����max
		@param max ��󳤶�
		*/
		void		Clamp(float max);
	};
	
	/** @name Vector
	*  @{
	*/

	/// Vector���������
	GGE_INLINE ggeVector operator* (const ggeVector &v, float s)		{ return ggeVector(s * v.x, s * v.y); }
	/// Vector���������
	GGE_INLINE ggeVector operator* (float s, const ggeVector &v)		{ return ggeVector(s * v.x, s * v.y); }
	/// Vector���������
	GGE_INLINE float operator^ (const ggeVector &v, const ggeVector &u)	{ return v.Angle(&u); }
	/// Vector���������
	GGE_INLINE float operator% (const ggeVector &v, const ggeVector &u)	{ return v.Dot(&u); }

	/** 
	@} 
	*/

	/// Rect
	class GGE_EXPORT ggeRect
	{
	public:
		float	x1;	///< ���Ͻ�x����
		float	y1; ///< ���Ͻ�y����
		float	x2; ///< ���½�x����
		float	y2; ///< ���½�y����

		/// ���캯��
		ggeRect()												{ m_bClean = true; }
		/// ���캯��
		ggeRect(float _x1, float _y1, float _x2, float _y2)		{ x1 = _x1; y1 = _y1; x2 = _x2; y2 = _y2; m_bClean = false; }

		/**
		@brief ���þ�������
		@param _x1 ���Ͻ�x����
		@param _y1 ���Ͻ�y����
		@param _x2 ���½�x����
		@param _y2 ���½�y����
		*/
		void Set(float _x1, float _y1, float _x2, float _y2);
		/**
		@brief �������
		*/
		void Clear();
		/**
		@brief �����Ƿ���Ч
		@return �����Ƿ���Ч
		*/
		bool IsClean() const;
		/**
		@brief �ƶ����ε���(x, y)�����δ�С����
		@param x x����
		@param y y����
		*/
		void Move(float x, float y);
		/**
		@brief ���þ��η�Χ
		@param x ��������x����
		@param y ��������y����
		@param r ���η�Χ
		*/
		void SetRadius(float x, float y, float r);
		/**
		@brief �������δ�Сʹ���ܹ�������(x, y)
		@param x x����
		@param y y����
		*/
		void Encapsulate(float x, float y);
		/**
		@brief ���Ե�(x, y)�Ƿ��ڸþ��ο���
		@param x x����
		@param y y����
		@return ���Ƿ��ڸþ��ο���
		*/
		bool TestPoint(float x, float y) const;
		/**
		@brief �����������ο��Ƿ��ཻ
		@param rect Ҫ���Եľ���
		@return �������ο��Ƿ��ཻ
		*/
		bool Intersect(const ggeRect *rect) const;

	private:
		bool	m_bClean;
	};
}