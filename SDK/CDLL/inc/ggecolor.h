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
\brief ��ɫģ��
*/


#pragma once
#include "ggecommon.h"

namespace gge
{
	/** @name Color
	*  @{
	*/

	/// ������ɫֵ
	GGE_INLINE gUInt Color_ARGB(gUInt a, gUInt r, gUInt g, gUInt b)	{ return (a << 24) + (r << 16) + (g << 8) + b; }
	/// ������ɫֵ
	GGE_INLINE gUInt Color_XRGB(gUInt r, gUInt g, gUInt b)			{ return Color_ARGB(255, r, g, b); }
	/// ����alphaֵ
	GGE_INLINE gUInt Color_GetA(gUInt col)						{ return col >> 24; }
	/// ���غ�ɫֵ
	GGE_INLINE gUInt Color_GetR(gUInt col)						{ return (col >> 16) & 0xFF; }
	/// ������ɫֵ
	GGE_INLINE gUInt Color_GetG(gUInt col)						{ return (col >> 8) & 0xFF; }
	/// ������ɫֵ
	GGE_INLINE gUInt Color_GetB(gUInt col)						{ return col & 0xFF; }
	/// ����alphaֵ
	GGE_INLINE gUInt Color_SetA(gUInt col, gUInt a)				{ return (col & 0x00FFFFFF) + (a << 24); }
	/// ���ú�ɫֵ
	GGE_INLINE gUInt Color_SetR(gUInt col, gUInt r)				{ return (col & 0xFF00FFFF) + (r << 16); }
	/// ������ɫֵ
	GGE_INLINE gUInt Color_SetG(gUInt col, gUInt g)				{ return (col & 0xFFFF00FF) + (g << 8); }
	/// ������ɫֵ
	GGE_INLINE gUInt Color_SetB(gUInt col, gUInt b)				{ return (col & 0xFFFFFF00) + b; }

	/** 
	@} 
	*/

	/// ��ɫģ��
	class GGE_EXPORT ggeColor
	{
	public:
		float	r;	///< ��ɫ����(0.0f~1.0f)
		float	g;	///< ��ɫ����(0.0f~1.0f)
		float	b;	///< ��ɫ����(0.0f~1.0f)
		float	a;	///< alpha����(0.0f~1.0f)

		/// ���캯��
		ggeColor(float _r, float _g, float _b, float _a) { r = _r; g = _g; b = _b; a = _a; }
		/// ���캯��
		ggeColor(gUInt c)	{ SetColor(c); }
		/// ���캯��
		ggeColor()			{ r = g = b = a = 0; }

		/// ���������
		ggeColor	operator-  (const ggeColor &c)	{ return ggeColor(r - c.r, g - c.g, b - c.b, a - c.a); }
		/// ���������
		ggeColor	operator+  (const ggeColor &c)	{ return ggeColor(r + c.r, g + c.g, b + c.b, a + c.a); }
		/// ���������
		ggeColor	operator*  (const ggeColor &c)  { return ggeColor(r * c.r, g * c.g, b * c.b, a * c.a); }
		/// ���������
		ggeColor&	operator-= (const ggeColor &c)	{ r -= c.r; g -= c.g; b -= c.b; a -= c.a; return *this; }
		/// ���������
		ggeColor&	operator+= (const ggeColor &c)	{ r += c.r; g +=c .g; b += c.b; a += c.a; return *this; }
		/// ���������
		bool		operator== (const ggeColor &c)	{ return (r == c.r && g == c.g && b == c.b && a == c.a); }
		/// ���������
		bool		operator!= (const ggeColor &c)	{ return (r != c.r || g != c.g || b != c.b || a != c.a); }

		/// ���������
		ggeColor	operator*  (float scalar)		{ return ggeColor(r * scalar, g * scalar, b * scalar, a * scalar); }
		/// ���������
		ggeColor	operator/  (float scalar)		{ return ggeColor(r / scalar, g / scalar, b / scalar, a / scalar); }
		/// ���������
		ggeColor&	operator*= (float scalar)		{ r *= scalar; g *= scalar; b *= scalar; a *= scalar; return *this; }

		/**
		@brief ������ɫֵ
		@param wcolor 32λ��ɫֵ
		*/
		void	SetColor(gUInt wcolor)				{ a = (wcolor >> 24) / 255.0f; r = ((wcolor >> 16) & 0xFF) / 255.0f; g = ((wcolor >> 8) & 0xFF) / 255.0f; b = (wcolor & 0xFF) / 255.0f; }
		/**
		@brief ���32λ��ɫֵ
		@return 32λ��ɫֵ
		*/
		gUInt	GetColor() const					{ return (gUInt(a * 255.0f) << 24) + (gUInt(r * 255.0f) << 16) + (gUInt(g * 255.0f) << 8) + gUInt(b * 255.0f); }
		/**
		@brief ʹ��ɫֵ��0.0f~1.0f��Χ��
		*/
		void	Clamp();
		/**
		@brief ����c1��c2�����Բ�ֵ�Ľ��
		@param c1 ��ɫ1
		@param c2 ��ɫ2
		@param s ��ֵ��ԽСԽ�ӽ�c1
		@return ������������
		*/
		ggeColor& Lerp(const ggeColor &c1, const ggeColor &c2, float s);
	};

	/** @name Color
	*  @{
	*/

	/// ��ɫ���������
	GGE_INLINE ggeColor operator* (const ggeColor &c, float s)	{ return ggeColor(s * c.r, s * c.g, s * c.b, s * c.a); }
	/// ��ɫ���������
	GGE_INLINE ggeColor operator* (float s, const ggeColor &c)	{ return ggeColor(s * c.r, s * c.g, s * c.b, s * c.a); }

	/** 
	@} 
	*/
}