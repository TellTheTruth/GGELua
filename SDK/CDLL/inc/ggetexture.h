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
\brief 纹理模块
*/

#pragma once
#include "ggecommon.h"
#include "ggerefcounter.h"

namespace gge
{
	/// 纹理
	class ggeTexture : public ggeRefCounter
	{
	public:
		/**
		@brief 锁定纹理
		@param bReadOnly 是否只读，若为true该纹理在解锁之后不会更新(如果不需要写入数据，该值设为true，能提高效率)
		@param left 设置锁定区域左边位置
		@param top 设置锁定区域上方位置
		@param width 设置锁定区域宽度
		@param height 设置锁定区域高度
		@return 成功返回纹理数据(格式：32位/ARGB)，否则返回0
		@note 1.未设置锁定区域时将锁定整个纹理，为了提高效率锁定纹理时应尽量指定锁定区域\n
		2.用以下形式存取颜色值：\n
		\code gUInt color = [y * textureWidth + x]; [y * textureWidth + x] = newColor; \endcode
		其中textureWidth可用GetWidth()获得。\n
		3.渲染目标纹理也是可以Lock的
		*/
		virtual gUInt*	Lock(bool bReadOnly = true, int left = 0, int top = 0, int width = 0, int height = 0) = 0;
		/**
		@brief 解除纹理锁定
		*/
		virtual void	Unlock() = 0;

		/**
		@brief 获得纹理宽度
		@param bOrginal 为true时返回纹理原始宽度，为false时返回纹理在显存宽度
		@return 纹理宽度
		*/
		virtual int		GetWidth(bool bOrginal = false) = 0;
		/**
		@brief 获得纹理高度
		@param bOrginal 为true时返回纹理原始高度，为false时返回纹理在显存高度
		@return 纹理高度
		*/
		virtual int		GetHeight(bool bOrginal = false) = 0;

		/**
		@brief 用指定的颜色填充纹理
		@param color 填充色
		*/
		virtual void	FillColor(gUInt color) = 0;

		/**
		@brief 保存到文件
		@param filename 文件名
		@param imageFormat 文件格式，默认保存为PNG格式图片
		@return 返回保存是否成功
		*/
		virtual bool	SaveToFile(const char *filename, GGE_IMAGE_FORMAT imageFormat = IMAGE_PNG) = 0;
	};

	/// 渲染目标纹理类型
	enum TARGET_TYPE
	{
		TARGET_DEFAULT	= 0,	///< 默认类型
		TARGET_ZBUFFER	= 1,	///< 开启ZBuffer
		TARGET_LOCKABLE	= 2,	///< 渲染目标纹理可以被锁定
		TARGET_ALPHA	= 4,	///< 渲染目标纹理带Alpha通道。注意：某些显卡可能不支持带Alpha通道的渲染目标纹理，此时创建带alpha通道的纹理将创建失败
		TARGET_FORCE32BIT = 0x7FFFFFFF,
	};

	/**
	@brief 创建纹理
	@param width 纹理宽度
	@param height 纹理高度
	@return 成功返回ggeTexture指针，失败返回0
	*/
	GGE_EXPORT ggeTexture*	GGE_CALL Texture_Create(int width, int height);
	/**
	@brief 创建渲染目标纹理
	@param width 纹理宽度
	@param height 纹理高度
	@param targetType 渲染目标纹理类型，可用"|"结合 @see TARGET_TYPE
	@return 成功返回ggeTexture指针，失败返回0
	*/
	GGE_EXPORT ggeTexture*	GGE_CALL Texture_CreateRenderTarget(int width, int height, int targetType = TARGET_DEFAULT);
	/**
	@brief 载入纹理
	@param filename 纹理文件名，支持文件类型：*.bmp, *.png, *.jpg, *.tga, *.dds(DXT1-DXT5)
	@param colorKey 颜色键
	@param size 内存大小，若该值为0忽略，否则将filename做为纹理文件在内存中的地址，该值指示这块内存的大小，从内存中载入纹理
	@return 成功返回ggeTexture指针，失败返回0
	*/
	GGE_EXPORT ggeTexture*	GGE_CALL Texture_Load(const char *filename, gUInt colorKey = 0x00000000, gULong size = 0);
}