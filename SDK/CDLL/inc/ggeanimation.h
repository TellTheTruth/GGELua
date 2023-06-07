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
\brief 动画模块
*/

#pragma once
#include "ggecommon.h"
#include "ggerefcounter.h"

namespace gge
{
	/// 动画模块
	class ggeAnimation : public ggeRefCounter
	{
	public:
		/**
		@brief 复制动画
		@param ani 源动画
		*/
		virtual void		Copy(ggeAnimation *ani) = 0;
		/**
		@brief 返回当前动画的一个副本
		@return 当前动画的一个副本
		*/
		virtual ggeAnimation*	Clone() = 0;

		/**
		@brief 开始播放动画
		*/
		virtual void		Play() = 0;
		/**
		@brief 停止播放动画
		*/
		virtual void		Stop() = 0;
		/**
		@brief 继续播放动画
		*/
		virtual void		Resume() = 0;
		/**
		@brief 刷新动画
		@param dt 上一帧所用时间，可用Timer_GetDelta()获得
		*/
		virtual void		Update(float dt) = 0;
		/**
		@brief 是否正在播放
		@return 正在播放返回true，否则返回false
		*/
		virtual bool		IsPlaying() = 0;

		/**
		@brief 设置播放模式
		@param mode 播放模式，可用"|"结合，默认为：ANI_FORWARD|ANI_LOOP
		$see ANIMATION_MODE
		*/
		virtual void		SetMode(int mode) = 0;
		/**
		@brief 设置帧率
		@param fps 帧率
		*/
		virtual void		SetSpeed(float fps) = 0;
		/**
		@brief 设置当前动画帧
		@param n 当前动画帧
		*/
		virtual void		SetFrame(int n) = 0;
		/**
		@brief 设置全部动画帧数
		@param n 全部动画帧数
		*/
		virtual void		SetFrameNum(int n) = 0;

		/**
		@brief 获得播放模式
		@return 播放模式
		*/
		virtual int			GetMode() = 0;
		/**
		@brief 获得帧率 
		@return 帧率
		*/
		virtual float		GetSpeed() = 0;
		/**
		@brief 获得当前动画帧
		@return 当前动画帧
		*/
		virtual int			GetFrame() = 0;
		/**
		@brief 获得全部动画帧数 
		@return 全部动画帧数
		*/
		virtual int			GetFrameNum() = 0;

		/**
		@brief 渲染
		*/
		virtual void		Render() = 0;
		/**
		@brief 设置渲染坐标
		@param x x坐标
		@param y y坐标
		*/
		virtual void		SetPosition(float x, float y) = 0;
		/**
		@brief 设置渲染坐标
		@param x x坐标
		@param y y坐标
		@param rotation 旋转弧度数
		@param hscale 水平缩放系数
		@param vscale 垂直缩放系数，若该值为0.0f，则取hscale
		*/
		virtual void		SetPositionEx(float x, float y, float rotation, float hscale = 1.0f, float vscale = 0.0f) = 0;
		/**
		@brief 设置渲染坐标
		@param x1 左上角x坐标
		@param y1 左上角y坐标
		@param x2 右下角x坐标
		@param y2 右下角y坐标
		*/
		virtual void		SetPositionStretch(float x1, float y1, float x2, float y2) = 0;
		/**
		@brief 设置渲染坐标
		@param x0 左上角x坐标
		@param y0 左上角y坐标
		@param x1 右上角x坐标
		@param y1 右上角y坐标
		@param x2 左下角x坐标
		@param y2 左下角y坐标
		@param x3 右下角x坐标
		@param y3 右下角y坐标
		*/
		virtual void		SetPosition4V(float x0, float y0, float x1, float y1, float x2, float y2, float x3, float y3) = 0;

		/**
		@brief 设置渲染纹理，纹理区域自动设为整个纹理
		@param texture 渲染纹理
		*/
		virtual void		SetTexture(ggeTexture *texture) = 0;
		/**
		@brief 设置渲染纹理区域
		@param x x坐标
		@param y y坐标
		@param width 宽度
		@param height 高度
		*/
		virtual void		SetTextureRect(float x, float y, float width, float height) = 0;
		/**
		@brief 设置渲染颜色
		@param color 渲染颜色
		@param i 要设置的顶点(0~3)，-1则四个顶点都设置为该值
		*/
		virtual void		SetColor(gUInt color, int i = -1) = 0;
		/**
		@brief 设置Z轴次序
		@param z Z轴次序(0.0f～1.0f，0表示最上层，1表示最下层)
		@param i 要设置的顶点(0~3)，-1则四个顶点都设置为该值
		*/
		virtual void		SetZ(float z, int i = -1) = 0;
		/**
		@brief 设置混合模式
		@param blend 混合模式，可用"|"结合
		@see BLEND_MODE
		*/
		virtual void		SetBlendMode(int blend) = 0;
		/**
		@brief 是否开启纹理过滤
		@param b 为true时开启，默认关闭
		*/
		virtual void		SetTextureFilter(bool b) = 0;
		/**
		@brief 设置参照点
		@param x x坐标
		@param y y坐标
		*/
		virtual void		SetHotSpot(float x, float y) = 0;
		/**
		@brief 设置纹理翻转属性
		@param x 水平翻转
		@param y 垂直翻转
		@param hotSpot 是否翻转原点
		*/
		virtual void		SetFlip(bool x, bool y, bool hotSpot = false) = 0;

		/**
		@brief 获得动画系统内部使用的精灵对象
		@return 动画系统内部使用的精灵对象
		*/
		virtual ggeSprite*	GetSprite() = 0;
		/**
		@brief 获得用于渲染的纹理指针
		@return 用于渲染的纹理指针
		*/
		virtual ggeTexture*	GetTexture() = 0;					
		/**
		@brief 获得用于渲染的纹理区域
		@param x x坐标
		@param y y坐标
		@param width 宽度
		@param height 高度
		*/
		virtual void		GetTextureRect(float *x, float *y, float *width, float *height) = 0;
		/**
		@brief 获得指定的顶点颜色
		@param i 顶点序号
		@return 顶点颜色
		*/
		virtual gUInt		GetColor(int i = 0) = 0;				
		/**
		@brief 获得Z轴次序
		@param i 顶点序号
		@return Z轴次序
		*/
		virtual float		GetZ(int i = 0) = 0;
		/**
		@brief 获得混合模式
		@return 混合模式
		*/
		virtual int			GetBlendMode() = 0;
		/**
		@brief 是否开启纹理过滤
		*/
		virtual bool		IsTextureFilter() = 0;
		/**
		@brief 获得参照点坐标
		@param x x坐标
		@param y y坐标
		*/
		virtual void		GetHotSpot(float *x, float *y) = 0;
		/**
		@brief 获得翻转模式属性
		@param x 水平翻转
		@param y 垂直翻转
		*/
		virtual void		GetFlip(bool *x, bool *y) = 0;
		/**
		@brief 获得宽度
		@return 宽度
		*/
		virtual float		GetWidth() = 0;
		/**
		@brief 获得高度
		@return 高度
		*/
		virtual float		GetHeight() = 0;

		/**
		@brief 获得动画的包围盒
		@param rect 保存包围盒矩形至该参数
		@param x 包围盒左上角x坐标
		@param y 包围盒左上角y坐标
		@return 包围盒矩形
		*/
		virtual ggeRect*	GetBoundingBox(ggeRect *rect, float x, float y) = 0;
		/**
		@brief 获得旋转和翻转后的动画包围盒
		@param rect 保存包围盒矩形至该参数
		@param x 保存包围盒矩形至该参数
		@param y 保存包围盒矩形至该参数
		@param rotation 旋转弧度数,0.0f设为默认
		@param hscale 水平缩放系数,1.0f设为默认
		@param vscale 垂直缩放系数,1.0f设为默认
		@return 包围盒矩形
		*/
		virtual ggeRect*	GetBoundingBoxEx(ggeRect *rect, float x, float y, float rotation, float hscale, float vscale) = 0;
	};

	/**
	@brief 创建动画
	@param texture 动画使用的纹理
	@param frames 动画帧数
	@param fps 动画播放帧率
	@param width 宽度
	@param height 高度
	@param tx 纹理x坐标
	@param ty 纹理y坐标
	@return 成功返回ggeAnimation指针，否则返回0
	*/
	GGE_EXPORT ggeAnimation* GGE_CALL Animation_Create(ggeTexture *texture, int frames, float fps, float width, float height, float tx = 0.0f, float ty = 0.0f);
}