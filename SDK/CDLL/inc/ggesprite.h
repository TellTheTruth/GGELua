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
\brief ����ģ��
*/

#pragma once
#include "ggecommon.h"
#include "ggerefcounter.h"

namespace gge
{
	/// ����ģ��
	class ggeSprite : public ggeRefCounter
	{
	public:
		/**
		@brief ���ƾ���
		@param spr Դ����
		*/
		virtual void		Copy(ggeSprite *spr) = 0;
		/**
		@brief ���ص�ǰ�����һ������
		@return ��ǰ�����һ������
		*/
		virtual ggeSprite*	Clone() = 0;

		/**
		@brief ��Ⱦ
		*/
		virtual void		Render() = 0;
		/**
		@brief ������Ⱦ����
		@param x x����
		@param y y����
		*/
		virtual void		SetPosition(float x, float y) = 0;
		/**
		@brief ������Ⱦ����
		@param x x����
		@param y y����
		@param rotation ��ת������
		@param hscale ˮƽ����ϵ��
		@param vscale ��ֱ����ϵ��������ֵΪ0.0f����ȡhscale
		*/
		virtual void		SetPositionEx(float x, float y, float rotation, float hscale = 1.0f, float vscale = 0.0f) = 0;
		/**
		@brief ������Ⱦ����
		@param x1 ���Ͻ�x����
		@param y1 ���Ͻ�y����
		@param x2 ���½�x����
		@param y2 ���½�y����
		*/
		virtual void		SetPositionStretch(float x1, float y1, float x2, float y2) = 0;
		/**
		@brief ������Ⱦ����
		@param x0 ���Ͻ�x����
		@param y0 ���Ͻ�y����
		@param x1 ���Ͻ�x����
		@param y1 ���Ͻ�y����
		@param x2 ���½�x����
		@param y2 ���½�y����
		@param x3 ���½�x����
		@param y3 ���½�y����
		*/
		virtual void		SetPosition4V(float x0, float y0, float x1, float y1, float x2, float y2, float x3, float y3) = 0;

		/**
		@brief ������Ⱦ�������ú����������Զ���Ϊ��������
		@param texture ��Ⱦ����
		*/
		virtual void		SetTexture(ggeTexture *texture) = 0;
		/**
		@brief ������Ⱦ��������
		@param x x����
		@param y y����
		@param width ���
		@param height �߶�
		*/
		virtual void		SetTextureRect(float x, float y, float width, float height) = 0;
		/**
		@brief �Ƿ����������
		@param b Ϊtrueʱ������Ĭ�Ϲر�
		*/
		virtual void		SetTextureFilter(bool b) = 0;
		/**
		@brief ������Ⱦ��ɫ
		@param color ��Ⱦ��ɫ
		@param i Ҫ���õĶ���(0~3)��-1���ĸ����㶼����Ϊ��ֵ
		*/
		virtual void		SetColor(gUInt color, int i = -1) = 0;
		/**
		@brief ����Z�����
		@param z Z�����(0.0f��1.0f��0��ʾ���ϲ㣬1��ʾ���²�)
		@param i Ҫ���õĶ���(0~3)��-1���ĸ����㶼����Ϊ��ֵ
		*/
		virtual void		SetZ(float z, int i = -1) = 0;
		/**
		@brief ���û��ģʽ
		@param blend ���ģʽ������"|"���
		@see BLEND_MODE
		*/
		virtual void		SetBlendMode(int blend) = 0;
		/**
		@brief ���ò��յ�
		@param x x����
		@param y y����
		*/
		virtual void		SetHotSpot(float x, float y) = 0;
		/**
		@brief ��������ת����
		@param bX ˮƽ��ת
		@param bY ��ֱ��ת
		@param bHotSpot �Ƿ�תԭ��
		*/
		virtual void		SetFlip(bool bX, bool bY, bool bHotSpot = false) = 0;

		/**
		@brief ���������Ⱦ������ָ��
		@return ������Ⱦ������ָ��
		*/
		virtual ggeTexture*	GetTexture() = 0;					
		/**
		@brief ���������Ⱦ����������
		@param x x����
		@param y y����
		@param width ���
		@param height �߶�
		*/
		virtual void		GetTextureRect(float *x, float *y, float *width, float *height) = 0;
		/**
		@brief �Ƿ����������
		*/
		virtual bool		IsTextureFilter() = 0;
		/**
		@brief ���ָ���Ķ�����ɫ
		@param i �������
		@return ������ɫ
		*/
		virtual gUInt		GetColor(int i = 0) = 0;				
		/**
		@brief ���Z�����
		@param i �������
		@return Z�����
		*/
		virtual float		GetZ(int i = 0) = 0;
		/**
		@brief ��û��ģʽ
		@return ���ģʽ
		*/
		virtual int			GetBlendMode() = 0;
		/**
		@brief ��ò��յ�����
		@param x x����
		@param y y����
		*/
		virtual void		GetHotSpot(float *x, float *y) = 0;
		/**
		@brief ��÷�תģʽ����
		@param bX ˮƽ��ת
		@param bY ��ֱ��ת
		*/
		virtual void		GetFlip(bool *bX, bool *bY) = 0;
		/**
		@brief ��ÿ��
		@return ���
		*/
		virtual float		GetWidth() = 0;
		/**
		@brief ��ø߶�
		@return �߶�
		*/
		virtual float		GetHeight() = 0;

		/**
		@brief ��þ���İ�Χ��
		@param rect �����Χ�о������ò���
		@param x ��Χ�����Ͻ�x����
		@param y ��Χ�����Ͻ�y����
		@return ��Χ�о���
		*/
		virtual ggeRect*	GetBoundingBox(ggeRect *rect, float x, float y) = 0;
		/**
		@brief �����ת�ͷ�ת��ľ����Χ��
		@param rect �����Χ�о������ò���
		@param x �����Χ�о������ò���
		@param y �����Χ�о������ò���
		@param rotation ��ת������,0.0f��ΪĬ��
		@param hscale ˮƽ����ϵ��,1.0f��ΪĬ��
		@param vscale ��ֱ����ϵ��,1.0f��ΪĬ��
		@return ��Χ�о���
		*/
		virtual ggeRect*	GetBoundingBoxEx(ggeRect *rect, float x, float y, float rotation, float hscale, float vscale) = 0;
	};

	/**
	@brief ��������
	@param texture ����ʹ�õ�����
	@param x ����x����
	@param y ����y����
	@param width ������
	@param height ����߶�
	@return �ɹ�����ggeSpriteָ�룬���򷵻�0
	*/
	GGE_EXPORT ggeSprite*	GGE_CALL Sprite_Create(ggeTexture *texture, float x = 0.0f, float y = 0.0f, float width = 0.0f, float height = 0.0f);
}