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
\brief 数学库
*/

#pragma once
#include "ggecommon.h"

namespace gge
{
	/** @name Math
	*  @{
	*/

	#define GGE_PI		3.14159265358979323846f		///< 圆周率
	#define GGE_PI_2	1.57079632679489661923f		///< 圆周率
	#define GGE_PI_4	0.785398163397448309616f	///< 圆周率
	#define GGE_1_PI	0.318309886183790671538f	///< 圆周率
	#define GGE_2_PI	0.636619772367581343076f	///< 圆周率

	/// 弧度转角度
	GGE_INLINE float ToDegree(float radian) { return (radian) * (180.0f / ((float)3.141592654f)); }
	/// 角度转弧度
	GGE_INLINE float ToRadian(float degree) { return (degree) * (((float)3.141592654f) / 180.0f); }
	/// 以s为参数在v1和v2间线性插值
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

		/// 构造函数
		ggeVector(float _x, float _y)				{ x = _x; y = _y; }
		/// 构造函数
		ggeVector()									{ x = 0; y = 0; }

		/// 运算符重载
		ggeVector	operator-  (const ggeVector &v)	{ return ggeVector(x - v.x, y - v.y); }
		/// 运算符重载
		ggeVector	operator+  (const ggeVector &v)	{ return ggeVector(x + v.x, y + v.y); }
		/// 运算符重载
		ggeVector	operator*  (float scalar)		{ return ggeVector(x * scalar, y * scalar); }
		/// 运算符重载
		ggeVector	operator/  (const float scalar)	{ return ggeVector(x / scalar, y / scalar); }
		/// 运算符重载
		ggeVector&	operator-= (const ggeVector &v)	{ x -= v.x; y -= v.y; return *this; }
		/// 运算符重载
		ggeVector&	operator+= (const ggeVector &v)	{ x += v.x; y += v.y; return *this; }
		/// 运算符重载
		ggeVector&	operator*= (float scalar)		{ x *= scalar; y *= scalar; return *this; }
		/// 运算符重载
		/// 运算符重载
		ggeVector	operator-  ()					{ return ggeVector(-x, -y); }
		/// 运算符重载
		bool		operator== (const ggeVector &v)	{ return (x == v.x && y == v.y); }
		/// 运算符重载
		bool		operator!= (const ggeVector &v)	{ return (x != v.x || y != v.y); }

		/**
		@brief 获得两矢量点积
		@param v 矢量
		@return 两矢量点积
		*/
		float		Dot(const ggeVector *v) const;
		/**
		@brief 标准化矢量
		@return this
		*/
		ggeVector*	Normalize();	
		/**
		@brief 获得矢量长度
		@return 矢量长度
		*/
		float		Length() const;
		/**
		@brief 获得两矢量间角度
		@param v 矢量
		@return 两矢量间角度
		*/
		float		Angle(const ggeVector *v = 0) const;
		/**
		@brief 将矢量旋转指定角度
		@param radian 旋转角度
		@return this
		*/
		ggeVector*	Rotate(float radian);
		/**
		@brief 使矢量长度不大于max
		@param max 最大长度
		*/
		void		Clamp(float max);
	};
	
	/** @name Vector
	*  @{
	*/

	/// Vector运算符重载
	GGE_INLINE ggeVector operator* (const ggeVector &v, float s)		{ return ggeVector(s * v.x, s * v.y); }
	/// Vector运算符重载
	GGE_INLINE ggeVector operator* (float s, const ggeVector &v)		{ return ggeVector(s * v.x, s * v.y); }
	/// Vector运算符重载
	GGE_INLINE float operator^ (const ggeVector &v, const ggeVector &u)	{ return v.Angle(&u); }
	/// Vector运算符重载
	GGE_INLINE float operator% (const ggeVector &v, const ggeVector &u)	{ return v.Dot(&u); }

	/** 
	@} 
	*/

	/// Rect
	class GGE_EXPORT ggeRect
	{
	public:
		float	x1;	///< 左上角x坐标
		float	y1; ///< 左上角y坐标
		float	x2; ///< 右下角x坐标
		float	y2; ///< 右下角y坐标

		/// 构造函数
		ggeRect()												{ m_bClean = true; }
		/// 构造函数
		ggeRect(float _x1, float _y1, float _x2, float _y2)		{ x1 = _x1; y1 = _y1; x2 = _x2; y2 = _y2; m_bClean = false; }

		/**
		@brief 设置矩形坐标
		@param _x1 左上角x坐标
		@param _y1 左上角y坐标
		@param _x2 右下角x坐标
		@param _y2 右下角y坐标
		*/
		void Set(float _x1, float _y1, float _x2, float _y2);
		/**
		@brief 清除矩形
		*/
		void Clear();
		/**
		@brief 矩形是否有效
		@return 矩形是否有效
		*/
		bool IsClean() const;
		/**
		@brief 移动矩形到点(x, y)，矩形大小不变
		@param x x坐标
		@param y y坐标
		*/
		void Move(float x, float y);
		/**
		@brief 设置矩形范围
		@param x 矩形中心x坐标
		@param y 矩形中心y坐标
		@param r 矩形范围
		*/
		void SetRadius(float x, float y, float r);
		/**
		@brief 调整矩形大小使其能够包含点(x, y)
		@param x x坐标
		@param y y坐标
		*/
		void Encapsulate(float x, float y);
		/**
		@brief 测试点(x, y)是否在该矩形框内
		@param x x坐标
		@param y y坐标
		@return 点是否在该矩形框内
		*/
		bool TestPoint(float x, float y) const;
		/**
		@brief 测试两个矩形框是否相交
		@param rect 要测试的矩形
		@return 两个矩形框是否相交
		*/
		bool Intersect(const ggeRect *rect) const;

	private:
		bool	m_bClean;
	};
}