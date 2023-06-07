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
	class ggeAnimation : public ggeRefCounter
	{
	public:
		/**
		@brief ���ƶ���
		@param ani Դ����
		*/
		virtual void		Copy(ggeAnimation *ani) = 0;
		/**
		@brief ���ص�ǰ������һ������
		@return ��ǰ������һ������
		*/
		virtual ggeAnimation*	Clone() = 0;

		/**
		@brief ��ʼ���Ŷ���
		*/
		virtual void		Play() = 0;
		/**
		@brief ֹͣ���Ŷ���
		*/
		virtual void		Stop() = 0;
		/**
		@brief �������Ŷ���
		*/
		virtual void		Resume() = 0;
		/**
		@brief ˢ�¶���
		@param dt ��һ֡����ʱ�䣬����Timer_GetDelta()���
		*/
		virtual void		Update(float dt) = 0;
		/**
		@brief �Ƿ����ڲ���
		@return ���ڲ��ŷ���true�����򷵻�false
		*/
		virtual bool		IsPlaying() = 0;

		/**
		@brief ���ò���ģʽ
		@param mode ����ģʽ������"|"��ϣ�Ĭ��Ϊ��ANI_FORWARD|ANI_LOOP
		$see ANIMATION_MODE
		*/
		virtual void		SetMode(int mode) = 0;
		/**
		@brief ����֡��
		@param fps ֡��
		*/
		virtual void		SetSpeed(float fps) = 0;
		/**
		@brief ���õ�ǰ����֡
		@param n ��ǰ����֡
		*/
		virtual void		SetFrame(int n) = 0;
		/**
		@brief ����ȫ������֡��
		@param n ȫ������֡��
		*/
		virtual void		SetFrameNum(int n) = 0;

		/**
		@brief ��ò���ģʽ
		@return ����ģʽ
		*/
		virtual int			GetMode() = 0;
		/**
		@brief ���֡�� 
		@return ֡��
		*/
		virtual float		GetSpeed() = 0;
		/**
		@brief ��õ�ǰ����֡
		@return ��ǰ����֡
		*/
		virtual int			GetFrame() = 0;
		/**
		@brief ���ȫ������֡�� 
		@return ȫ������֡��
		*/
		virtual int			GetFrameNum() = 0;

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
		@brief ������Ⱦ�������������Զ���Ϊ��������
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
		@brief �Ƿ����������
		@param b Ϊtrueʱ������Ĭ�Ϲر�
		*/
		virtual void		SetTextureFilter(bool b) = 0;
		/**
		@brief ���ò��յ�
		@param x x����
		@param y y����
		*/
		virtual void		SetHotSpot(float x, float y) = 0;
		/**
		@brief ��������ת����
		@param x ˮƽ��ת
		@param y ��ֱ��ת
		@param hotSpot �Ƿ�תԭ��
		*/
		virtual void		SetFlip(bool x, bool y, bool hotSpot = false) = 0;

		/**
		@brief ��ö���ϵͳ�ڲ�ʹ�õľ������
		@return ����ϵͳ�ڲ�ʹ�õľ������
		*/
		virtual ggeSprite*	GetSprite() = 0;
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
		@brief �Ƿ����������
		*/
		virtual bool		IsTextureFilter() = 0;
		/**
		@brief ��ò��յ�����
		@param x x����
		@param y y����
		*/
		virtual void		GetHotSpot(float *x, float *y) = 0;
		/**
		@brief ��÷�תģʽ����
		@param x ˮƽ��ת
		@param y ��ֱ��ת
		*/
		virtual void		GetFlip(bool *x, bool *y) = 0;
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
		@brief ��ö����İ�Χ��
		@param rect �����Χ�о������ò���
		@param x ��Χ�����Ͻ�x����
		@param y ��Χ�����Ͻ�y����
		@return ��Χ�о���
		*/
		virtual ggeRect*	GetBoundingBox(ggeRect *rect, float x, float y) = 0;
		/**
		@brief �����ת�ͷ�ת��Ķ�����Χ��
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
	@param frames ����֡��
	@param fps ��������֡��
	@param width ���
	@param height �߶�
	@param tx ����x����
	@param ty ����y����
	@return �ɹ�����ggeAnimationָ�룬���򷵻�0
	*/
	GGE_EXPORT ggeAnimation* GGE_CALL Animation_Create(ggeTexture *texture, int frames, float fps, float width, float height, float tx = 0.0f, float ty = 0.0f);
}