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
\brief ת��ģ��
*/

#pragma once
#include "ggecommon.h"

namespace gge
{
	/// Variant
	class GGE_EXPORT ggeVariant
	{
	public:
		/** @name ���캯��
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

		/// ��������
		~ggeVariant();

		/** @name ����ֵ
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

		/** @name ����ֵ��bOk�����ж��Ƿ�ת���ɹ�
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
	@brief �����ֽ���ת��Ϊ���ֽ���
	@param str Ҫת�����ַ���
	@return ת���ɹ�����ת����Ŀ��ֽ��룬���򷵻�0
	@note �ú������ε�����Ч������ⲿ��Ҫ��������ֵ���������и���
	*/
	GGE_EXPORT const wchar_t* GGE_CALL Variant_Asc2Unicode(const char *str);
	 /**
	@brief �����ֽ���ת��Ϊ���ֽ���
	@param str Ҫת�����ַ���
	@return ת���ɹ�����ת����� ���ֽ��� �����򷵻�0
	@note �ú������ε�����Ч������ⲿ��Ҫ��������ֵ���������и���
	*/
	GGE_EXPORT const char* GGE_CALL Variant_Unicode2Asc(const wchar_t *str);
	 /**
	@brief �����ֽ���ת��ΪUTF8����
	@param str Ҫת�����ַ���
	@return ת���ɹ�����ת�����UTF8���룬���򷵻�0
	@note �ú������ε�����Ч������ⲿ��Ҫ��������ֵ���������и���
	*/
	GGE_EXPORT const char* GGE_CALL Variant_Unicode2Utf8(const wchar_t *str);
	 /**
	@brief ��UTF8����ת��Ϊ���ֽ���
	@param str Ҫת�����ַ���
	@return ת���ɹ�����ת����Ŀ��ֽ��룬���򷵻�0
	@note �ú������ε�����Ч������ⲿ��Ҫ��������ֵ���������и���
	*/
	GGE_EXPORT const wchar_t* GGE_CALL Variant_Utf82Unicode(const char *str);
	 /**
	@brief �����ֽ���ת��ΪUTF8����
	@param str Ҫת�����ַ���
	@return ת���ɹ�����ת�����UTF8���룬���򷵻�0
	@note �ú������ε�����Ч������ⲿ��Ҫ��������ֵ���������и���
	*/
	GGE_EXPORT const char* GGE_CALL Variant_Asc2Utf8(const char *str);
	 /**
	@brief ��UTF8����ת��Ϊ���ֽ���
	@param str Ҫת�����ַ���
	@return ת���ɹ�����ת����Ķ��ֽ��룬���򷵻�0
	@note �ú������ε�����Ч������ⲿ��Ҫ��������ֵ���������и���
	*/
	GGE_EXPORT const char* GGE_CALL Variant_Utf82Asc(const char *str);
}