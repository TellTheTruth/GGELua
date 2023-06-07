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
\brief 颜色模块
*/


#pragma once
#include "ggecommon.h"

namespace gge
{
	/** @name Color
	*  @{
	*/

	/// 生成颜色值
	GGE_INLINE gUInt Color_ARGB(gUInt a, gUInt r, gUInt g, gUInt b)	{ return (a << 24) + (r << 16) + (g << 8) + b; }
	/// 生成颜色值
	GGE_INLINE gUInt Color_XRGB(gUInt r, gUInt g, gUInt b)			{ return Color_ARGB(255, r, g, b); }
	/// 返回alpha值
	GGE_INLINE gUInt Color_GetA(gUInt col)						{ return col >> 24; }
	/// 返回红色值
	GGE_INLINE gUInt Color_GetR(gUInt col)						{ return (col >> 16) & 0xFF; }
	/// 返回绿色值
	GGE_INLINE gUInt Color_GetG(gUInt col)						{ return (col >> 8) & 0xFF; }
	/// 返回蓝色值
	GGE_INLINE gUInt Color_GetB(gUInt col)						{ return col & 0xFF; }
	/// 设置alpha值
	GGE_INLINE gUInt Color_SetA(gUInt col, gUInt a)				{ return (col & 0x00FFFFFF) + (a << 24); }
	/// 设置红色值
	GGE_INLINE gUInt Color_SetR(gUInt col, gUInt r)				{ return (col & 0xFF00FFFF) + (r << 16); }
	/// 设置绿色值
	GGE_INLINE gUInt Color_SetG(gUInt col, gUInt g)				{ return (col & 0xFFFF00FF) + (g << 8); }
	/// 设置蓝色值
	GGE_INLINE gUInt Color_SetB(gUInt col, gUInt b)				{ return (col & 0xFFFFFF00) + b; }

	/** 
	@} 
	*/

	/// 颜色模块
	class GGE_EXPORT ggeColor
	{
	public:
		float	r;	///< 红色分量(0.0f~1.0f)
		float	g;	///< 绿色分量(0.0f~1.0f)
		float	b;	///< 蓝色分量(0.0f~1.0f)
		float	a;	///< alpha分量(0.0f~1.0f)

		/// 构造函数
		ggeColor(float _r, float _g, float _b, float _a) { r = _r; g = _g; b = _b; a = _a; }
		/// 构造函数
		ggeColor(gUInt c)	{ SetColor(c); }
		/// 构造函数
		ggeColor()			{ r = g = b = a = 0; }

		/// 运算符重载
		ggeColor	operator-  (const ggeColor &c)	{ return ggeColor(r - c.r, g - c.g, b - c.b, a - c.a); }
		/// 运算符重载
		ggeColor	operator+  (const ggeColor &c)	{ return ggeColor(r + c.r, g + c.g, b + c.b, a + c.a); }
		/// 运算符重载
		ggeColor	operator*  (const ggeColor &c)  { return ggeColor(r * c.r, g * c.g, b * c.b, a * c.a); }
		/// 运算符重载
		ggeColor&	operator-= (const ggeColor &c)	{ r -= c.r; g -= c.g; b -= c.b; a -= c.a; return *this; }
		/// 运算符重载
		ggeColor&	operator+= (const ggeColor &c)	{ r += c.r; g +=c .g; b += c.b; a += c.a; return *this; }
		/// 运算符重载
		bool		operator== (const ggeColor &c)	{ return (r == c.r && g == c.g && b == c.b && a == c.a); }
		/// 运算符重载
		bool		operator!= (const ggeColor &c)	{ return (r != c.r || g != c.g || b != c.b || a != c.a); }

		/// 运算符重载
		ggeColor	operator*  (float scalar)		{ return ggeColor(r * scalar, g * scalar, b * scalar, a * scalar); }
		/// 运算符重载
		ggeColor	operator/  (float scalar)		{ return ggeColor(r / scalar, g / scalar, b / scalar, a / scalar); }
		/// 运算符重载
		ggeColor&	operator*= (float scalar)		{ r *= scalar; g *= scalar; b *= scalar; a *= scalar; return *this; }

		/**
		@brief 设置颜色值
		@param wcolor 32位颜色值
		*/
		void	SetColor(gUInt wcolor)				{ a = (wcolor >> 24) / 255.0f; r = ((wcolor >> 16) & 0xFF) / 255.0f; g = ((wcolor >> 8) & 0xFF) / 255.0f; b = (wcolor & 0xFF) / 255.0f; }
		/**
		@brief 获得32位颜色值
		@return 32位颜色值
		*/
		gUInt	GetColor() const					{ return (gUInt(a * 255.0f) << 24) + (gUInt(r * 255.0f) << 16) + (gUInt(g * 255.0f) << 8) + gUInt(b * 255.0f); }
		/**
		@brief 使颜色值在0.0f~1.0f范围内
		*/
		void	Clamp();
		/**
		@brief 保存c1和c2间线性插值的结果
		@param c1 颜色1
		@param c2 颜色2
		@param s 插值，越小越接近c1
		@return 返回自身引用
		*/
		ggeColor& Lerp(const ggeColor &c1, const ggeColor &c2, float s);
	};

	/** @name Color
	*  @{
	*/

	/// 颜色运算符重载
	GGE_INLINE ggeColor operator* (const ggeColor &c, float s)	{ return ggeColor(s * c.r, s * c.g, s * c.b, s * c.a); }
	/// 颜色运算符重载
	GGE_INLINE ggeColor operator* (float s, const ggeColor &c)	{ return ggeColor(s * c.r, s * c.g, s * c.b, s * c.a); }

	/** 
	@} 
	*/
}