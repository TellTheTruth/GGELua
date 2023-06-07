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
\brief 图像模块
*/

#pragma once
#include "ggecommon.h"
#include "ggerefcounter.h"

namespace gge
{
	/// 图像模块
	class ggeImage : public ggeRefCounter
	{
	public:
		/**
		@brief 渲染
		@param x 左上角x坐标
		@param y 左上角y坐标
		*/
		virtual void	Render(float x, float y) = 0;

		/**
		@brief 锁定图像
		@param readOnly 是否只读，若为true该纹理在解锁之后不会更新(如果不需要写入数据，该值设为true，能提高效率)
		@return 锁定成功返回true，否则返回false
		@note 用GetPixel()函数获取数据
		*/
		virtual bool	Lock(bool readOnly = true) = 0;
		/**
		@brief 获得指定点的数据
		@param x x坐标
		@param y y坐标
		@return 指定点的数据
		*/
		virtual gUInt	GetPixel(int x, int y) = 0;
		/**
		@brief 设置指定点的数据
		@param x x坐标
		@param y y坐标
		@param col 要写入的数据
		*/
		virtual void	SetPixel(int x, int y, gUInt col) = 0;
		/**
		@brief 解除图像锁定
		*/
		virtual void	Unlock() = 0;

		/**
		@brief 设置要渲染的图像区域
		@param x x坐标
		@param y y坐标
		@param width 宽度
		@param height 高度
		*/
		virtual void	SetRect(float x, float y, float width, float height) = 0;
		/**
		@brief 设置渲染颜色
		@param color 渲染颜色
		*/
		virtual void	SetColor(gUInt color) = 0;
		/**
		@brief 设置Z轴次序
		@param z Z轴次序(0.0f～1.0f，0表示最上层，1表示最下层)
		*/
		virtual void	SetZ(float z) = 0;
		/**
		@brief 设置混合模式
		@param blend 混合模式，可用"|"结合
		@see BLEND_MODE
		*/
		virtual void	SetBlendMode(int blend) = 0;
		/**
		@brief 是否开启纹理过滤
		@param b 为true时开启，默认关闭
		*/
		virtual void	SetTextureFilter(bool b) = 0;
		/**
		@brief 设置纹理翻转属性
		@param bX 水平翻转
		@param bY 垂直翻转
		*/
		virtual void	SetFlip(bool bX, bool bY) = 0;

		/**
		@brief 获得用于渲染的纹理区域
		@param x x坐标
		@param y y坐标
		@param width 宽度
		@param height 高度
		*/
		virtual void	GetRect(float *x, float *y, float *width, float *height) = 0;
		/**
		@brief 获得图像颜色
		@return 图像颜色
		*/
		virtual gUInt	GetColor() = 0;				
		/**
		@brief 获得Z轴次序
		@return Z轴次序
		*/
		virtual float	GetZ() = 0;
		/**
		@brief 获得混合模式
		@return 混合模式
		*/
		virtual int		GetBlendMode() = 0;
		/**
		@brief 是否开启纹理过滤
		*/
		virtual bool	IsTextureFilter() = 0;
		/**
		@brief 获得翻转模式属性
		@param bX 水平翻转
		@param bY 垂直翻转
		*/
		virtual void	GetFlip(bool *bX, bool *bY) = 0;

		/**
		@brief 获得图像宽度
		@return 图像宽度
		*/
		virtual int		GetWidth() = 0;
		/**
		@brief 获得图像高度
		@return 图像高度
		*/
		virtual int		GetHeight() = 0;
	};

	/**
	@brief 载入图像文件，可载入并显示超过显卡最大纹理大小的图片
	@param filename 纹理文件名，支持文件类型：*.bmp, *.png, *.jpg, *.tga, *.dds(DXT1-DXT5)
	@param colorKey 颜色键
	@param size 内存大小，若该值为0忽略，否则将filename做为图像文件在内存中的地址，该值指示这块内存的大小，从内存中载入图像
	@return 成功返回ggeImage指针，失败返回0
	*/
	GGE_EXPORT ggeImage* GGE_CALL Image_Load(const char *filename, gUInt colorKey = 0x00000000, gULong size = 0);
}