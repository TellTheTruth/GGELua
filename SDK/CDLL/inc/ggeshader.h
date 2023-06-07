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
\brief Shader模块

Shader扩展模块目前只支持PixelShader
*/

#pragma once
#include "ggecommon.h"
#include "ggerefcounter.h"

namespace gge
{
	/// 纹理寻址模式
	enum TEXTURE_ADDRESS
	{
		TEXADDRESS_WRAP = 1,	///< 重叠映射寻址
		TEXADDRESS_MIRROR = 2,	///< 镜像纹理寻址
		TEXADDRESS_CLAMP = 3,	///< 夹取纹理寻址
		TEXADDRESS_BORDER = 4,	///< 边框颜色寻址
		TEXADDRESS_FORCE32BIT = 0x7FFFFFFF,
	};

	/// Shader模块
	class ggeShader : public ggeRefCounter
	{
	public:
		/**
		@brief 设置纹理，必须先调用Shader_SetCurrentShader()函数设置当前Shader
		@param name 纹理名
		@param tex 纹理
		@param bFilter 是否开启纹理过滤
		@param texAddres 纹理寻址模式
		@param borderColor 边框颜色寻址所用的边框颜色
		@return 成功返回true，失败返回false
		*/
		virtual bool SetTexture(const char *name, ggeTexture *tex, bool bFilter = false, TEXTURE_ADDRESS texAddres = TEXADDRESS_WRAP, gUInt borderColor = 0) = 0;
		/**
		@brief 设置float类型值，必须先调用Shader_SetCurrentShader()函数设置当前Shader
		@param name 变量名
		@param f 变量值
		@return 成功返回true，失败返回false
		*/
		virtual bool SetFloat(const char *name, float f) = 0;
		/**
		@brief 设置float类型数组，必须先调用Shader_SetCurrentShader()函数设置当前Shader
		@param name 变量名
		@param pf 变量数组
		@param count 元素个数
		@return 成功返回true，失败返回false
		*/
		virtual bool SetFloatArray(const char *name, const float *pf, gUInt count) = 0;
	};

	/**
	@brief 载入Shader文件
	@param filename 文件名
	@param function 入口函数名
	@param psVersion PixelShader版本
	@return 成功返回ggeShader*，失败返回0
	*/
	GGE_EXPORT ggeShader*	GGE_CALL Shader_Load(const char *filename, const char *function, PIXEL_SHADER_VERSION psVersion = PS_1_1);
	/**
	@brief 从字符串创建Shader
	@param shaderstr shader字符串
	@param function 入口函数名
	@param psVersion PixelShader版本
	@return 成功返回ggeShader指针，失败返回0
	*/
	GGE_EXPORT ggeShader*	GGE_CALL Shader_Create(const char *shaderstr, const char *function, PIXEL_SHADER_VERSION psVersion = PS_1_1);
	/**
	@brief 设置当前Shader
	@param shader 要设置的Shader，如果为0则清除当前Shader
	@return 成功返回true指针，失败返回false
	*/
	GGE_EXPORT void GGE_CALL Shader_SetCurrentShader(ggeShader *shader = 0);
	/**
	@brief 返回当前Shader
	*/
	GGE_EXPORT ggeShader* GGE_CALL Shader_GetCurrentShader();
}