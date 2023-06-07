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
\brief 转换模块
*/

#pragma once
#include "ggecommon.h"

namespace gge
{
	/// Variant
	class GGE_EXPORT ggeVariant
	{
	public:
		/** @name 构造函数
		*  @{
		*/
		ggeVariant();
		ggeVariant(const char *val);
		ggeVariant(short val);
		ggeVariant(int val);
		ggeVariant(bool val);
		ggeVariant(float val);
		ggeVariant(double val);
		ggeVariant(gUShort val);
		ggeVariant(gUInt val);
		ggeVariant(const ggeVariant &val);
		ggeVariant& operator = (const ggeVariant &val);
		/** 
		@} 
		*/

		/// 析构函数
		~ggeVariant();

		/** @name 设置值
		*  @{
		*/
		void			SetString(const char *val);
		void			SetShort(short val);
		void			SetInt(int val);
		void			SetBool(bool val);
		void			SetFloat(float val);
		void			SetDouble(double val);
		void			SetUShort(gUShort val);
		void			SetUInt(gUInt val);
		/** 
		@} 
		*/

		/** @name 返回值，bOk用于判断是否转换成功
		*  @{
		*/
		const char*		GetString() const;
		short			GetShort(bool *bOk = 0) const;
		int				GetInt(bool *bOk = 0) const;
		bool			GetBool(bool *bOk = 0) const;
		float			GetFloat(bool *bOk = 0) const;
		double			GetDouble(bool *bOk = 0) const;
		gUShort			GetUShort(bool *bOk = 0) const;
		gUInt			GetUInt(bool *bOk = 0) const;
		/** 
		@} 
		*/
		
	private:
		struct ggeVariantBuffer;
		ggeVariantBuffer *m_VarBuf;
	};

	 /**
	@brief 将多字节码转换为宽字节码
	@param str 要转换的字符串
	@return 转换成功返回转换后的宽字节码，否则返回0
	@note 该函数当次调用有效，如果外部需要保留返回值，必须自行复制
	*/
	GGE_EXPORT const wchar_t* GGE_CALL Variant_Asc2Unicode(const char *str);
	 /**
	@brief 将宽字节码转换为多字节码
	@param str 要转换的字符串
	@return 转换成功返回转换后的 多字节码 ，否则返回0
	@note 该函数当次调用有效，如果外部需要保留返回值，必须自行复制
	*/
	GGE_EXPORT const char* GGE_CALL Variant_Unicode2Asc(const wchar_t *str);
	 /**
	@brief 将宽字节码转换为UTF8编码
	@param str 要转换的字符串
	@return 转换成功返回转换后的UTF8编码，否则返回0
	@note 该函数当次调用有效，如果外部需要保留返回值，必须自行复制
	*/
	GGE_EXPORT const char* GGE_CALL Variant_Unicode2Utf8(const wchar_t *str);
	 /**
	@brief 将UTF8编码转换为宽字节码
	@param str 要转换的字符串
	@return 转换成功返回转换后的宽字节码，否则返回0
	@note 该函数当次调用有效，如果外部需要保留返回值，必须自行复制
	*/
	GGE_EXPORT const wchar_t* GGE_CALL Variant_Utf82Unicode(const char *str);
	 /**
	@brief 将多字节码转换为UTF8编码
	@param str 要转换的字符串
	@return 转换成功返回转换后的UTF8编码，否则返回0
	@note 该函数当次调用有效，如果外部需要保留返回值，必须自行复制
	*/
	GGE_EXPORT const char* GGE_CALL Variant_Asc2Utf8(const char *str);
	 /**
	@brief 将UTF8编码转换为多字节码
	@param str 要转换的字符串
	@return 转换成功返回转换后的多字节码，否则返回0
	@note 该函数当次调用有效，如果外部需要保留返回值，必须自行复制
	*/
	GGE_EXPORT const char* GGE_CALL Variant_Utf82Asc(const char *str);
}