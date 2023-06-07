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
\brief Shaderģ��

Shader��չģ��Ŀǰֻ֧��PixelShader
*/

#pragma once
#include "ggecommon.h"
#include "ggerefcounter.h"

namespace gge
{
	/// ����Ѱַģʽ
	enum TEXTURE_ADDRESS
	{
		TEXADDRESS_WRAP = 1,	///< �ص�ӳ��Ѱַ
		TEXADDRESS_MIRROR = 2,	///< ��������Ѱַ
		TEXADDRESS_CLAMP = 3,	///< ��ȡ����Ѱַ
		TEXADDRESS_BORDER = 4,	///< �߿���ɫѰַ
		TEXADDRESS_FORCE32BIT = 0x7FFFFFFF,
	};

	/// Shaderģ��
	class ggeShader : public ggeRefCounter
	{
	public:
		/**
		@brief �������������ȵ���Shader_SetCurrentShader()�������õ�ǰShader
		@param name ������
		@param tex ����
		@param bFilter �Ƿ����������
		@param texAddres ����Ѱַģʽ
		@param borderColor �߿���ɫѰַ���õı߿���ɫ
		@return �ɹ�����true��ʧ�ܷ���false
		*/
		virtual bool SetTexture(const char *name, ggeTexture *tex, bool bFilter = false, TEXTURE_ADDRESS texAddres = TEXADDRESS_WRAP, gUInt borderColor = 0) = 0;
		/**
		@brief ����float����ֵ�������ȵ���Shader_SetCurrentShader()�������õ�ǰShader
		@param name ������
		@param f ����ֵ
		@return �ɹ�����true��ʧ�ܷ���false
		*/
		virtual bool SetFloat(const char *name, float f) = 0;
		/**
		@brief ����float�������飬�����ȵ���Shader_SetCurrentShader()�������õ�ǰShader
		@param name ������
		@param pf ��������
		@param count Ԫ�ظ���
		@return �ɹ�����true��ʧ�ܷ���false
		*/
		virtual bool SetFloatArray(const char *name, const float *pf, gUInt count) = 0;
	};

	/**
	@brief ����Shader�ļ�
	@param filename �ļ���
	@param function ��ں�����
	@param psVersion PixelShader�汾
	@return �ɹ�����ggeShader*��ʧ�ܷ���0
	*/
	GGE_EXPORT ggeShader*	GGE_CALL Shader_Load(const char *filename, const char *function, PIXEL_SHADER_VERSION psVersion = PS_1_1);
	/**
	@brief ���ַ�������Shader
	@param shaderstr shader�ַ���
	@param function ��ں�����
	@param psVersion PixelShader�汾
	@return �ɹ�����ggeShaderָ�룬ʧ�ܷ���0
	*/
	GGE_EXPORT ggeShader*	GGE_CALL Shader_Create(const char *shaderstr, const char *function, PIXEL_SHADER_VERSION psVersion = PS_1_1);
	/**
	@brief ���õ�ǰShader
	@param shader Ҫ���õ�Shader�����Ϊ0�������ǰShader
	@return �ɹ�����trueָ�룬ʧ�ܷ���false
	*/
	GGE_EXPORT void GGE_CALL Shader_SetCurrentShader(ggeShader *shader = 0);
	/**
	@brief ���ص�ǰShader
	*/
	GGE_EXPORT ggeShader* GGE_CALL Shader_GetCurrentShader();
}