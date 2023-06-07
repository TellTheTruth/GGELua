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
\brief �켣��ģ��
*/

#pragma once
#include "ggecommon.h"
#include "ggerefcounter.h"

namespace gge
{
	/// �켣��ģ��
	class ggeRibbonTrail : public ggeRefCounter
	{
	public:
		/**
		@brief ���ƹ켣��
		@param trail Դ�켣��
		*/
		virtual void				Copy(ggeRibbonTrail *trail) = 0;
		/**
		@brief ���ص�ǰ�켣����һ������
		@return ��ǰ�켣������
		*/
		virtual ggeRibbonTrail*		Clone() = 0;

		/**
		@brief ˢ�¹켣��
		@param dt ��һ֡����ʱ�䣬����Timer_GetDelta()���
		*/
		virtual void				Update(float dt) = 0;
		/**
		@brief ��Ⱦ�켣��
		*/
		virtual void				Render() = 0;
		/**
		@brief ֹͣ��Ⱦ�켣��
		*/
		virtual void				Stop() = 0;
		/**
		@brief �ƶ��켣����ָ��λ��
		@param x x����
		@param y y����
		@param bMoveNodes ���Ϊtrue�����л�ڵ㽫���ƶ�������ֻ�ƶ�ͷ�ڵ�
		*/
		virtual void				MoveTo(float x, float y, bool bMoveNodes = false) = 0;
		/**
		@brief ���ù켣���ƶ�λ��
		@param x x����
		@param y y����
		*/
		virtual void				Transpose(float x, float y) = 0;
		/**
		@brief �Ƿ����켣����Χ����
		@param bTrack �Ƿ����켣����Χ����
		*/
		virtual void				TrackBoundingBox(bool bTrack) = 0;

		/**
		@brief ���ù켣�����ڵ���
		@param num ���ڵ���
		*/
		virtual void				SetMaxNodeNum(gUInt num) = 0;
		/**
		@brief ���ù켣��������
		@param time �켣��������(��λ����)
		*/
		virtual void				SetLifeTime(float time) = 0	;	
		/**
		@brief ���ù켣����ʼ��ɫ
		@param color �켣����ʼ��ɫ
		*/
		virtual void				SetStartColor(gUInt color) = 0;
		/**
		@brief ���ù켣��������ɫ
		@param color �켣��������ɫ
		*/
		virtual void				SetEndColor(gUInt color) = 0;
		/**
		@brief ���ù켣�������
		@param width �켣�������
		*/
		virtual void				SetMaxWidth(float width) = 0;
		/**
		@brief ���ù켣����С���
		@param width �켣����С���
		*/
		virtual void				SetMinWidth(float width) = 0;
		/**
		@brief ���ù켣���ڵ㳤��
		@param len �켣���ڵ㳤��
		*/
		virtual void				SetNodeLength(gUInt len) = 0;
		/**
		@brief �����ƶ������Զ����ù켣������
		@param b trueΪ������falseΪ�رգ�Ĭ�Ͽ���
		*/
		virtual void				TrackMovingDirection(bool b) = 0;
		/**
		@brief ���ù켣�����򣬹رո����ƶ�������ʱ��Ч
		@param angle �켣������(��λ������)
		*/
		virtual void				SetDirection(float angle) = 0;

		/**
		@brief ������Ⱦ�������������Զ���Ϊ��������
		@param texture ��Ⱦ����
		*/
		virtual void				SetTexture(ggeTexture *texture) = 0;
		/**
		@brief ������Ⱦ��������
		@param x x����
		@param y y����
		@param width ���
		@param height �߶�
		*/
		virtual void				SetTextureRect(float x, float y, float width, float height) = 0;
		/**
		@brief ����Z�����
		@param z Z�����(0.0f��1.0f��0��ʾ���ϲ㣬1��ʾ���²�)
		*/
		virtual void				SetZ(float z) = 0;
		/**
		@brief �Ƿ����������
		@param b Ϊtrueʱ������Ĭ�Ͽ���
		*/
		virtual void				SetTextureFilter(bool b) = 0;
		/**
		@brief ���û��ģʽ
		@param blend ���ģʽ������"|"��ϣ�Ĭ��Ϊ BLEND_COLORMUL|BLEND_ALPHAADD|BLEND_NOZWRITE
		@see BLEND_MODE
		*/
		virtual void				SetBlendMode(int blend) = 0;

		/**
		@brief ��ù켣�����ڵ���
		@return �켣�����ڵ���
		*/
		virtual gUInt				GetMaxNodeNum() = 0;
		/**
		@brief ��ù켣��������
		@return �켣��������
		*/
		virtual float				GetLifeTime() = 0;
		/**
		@brief ��ù켣����ʼ��ɫ
		@return �켣����ʼ��ɫ
		*/
		virtual gUInt				GetStartColor() = 0;
		/**
		@brief ��ù켣��������ɫ
		@return �켣��������ɫ
		*/
		virtual gUInt				GetEndColor() = 0;
		/**
		@brief ��ù켣�������
		@return �켣�������
		*/
		virtual float				GetMaxWidth() = 0;
		/**
		@brief ��ù켣����С���
		@return �켣����С���
		*/
		virtual float				GetMinWidth() = 0;
		/**
		@brief ��ù켣���ڵ㳤��
		@return �켣���ڵ㳤��
		*/
		virtual gUInt				GetNodeLength() = 0;
		/**
		@brief ����Ƿ�����ƶ�����
		@return �Ƿ�����ƶ�����
		*/
		virtual bool				IsTrackMovingDirection() = 0;
		/**
		@brief ��ù켣������
		@return �켣������
		*/
		virtual float				GetDirection() = 0;

		/**
		@brief ���������Ⱦ������ָ��
		@return ������Ⱦ������ָ��
		*/
		virtual ggeTexture*			GetTexture() = 0;
		/**
		@brief ���������Ⱦ����������
		@param x x����
		@param y y����
		@param width ���
		@param height �߶�
		*/
		virtual void				GetTextureRect(float *x, float *y, float *width, float *height) = 0;
		/**
		@brief ���Z�����
		@return Z�����
		*/
		virtual float				GetZ() = 0;
		/**
		@brief �Ƿ����������
		*/
		virtual bool				IsTextureFilter() = 0;
		/**
		@brief ��û��ģʽ
		@return ���ģʽ
		*/
		virtual int					GetBlendMode() = 0;


		/**
		@brief ��ù켣������
		@param x x����
		@param y y����
		*/
		virtual void				GetPosition(float *x, float *y) = 0;
		/**
		@brief ��ù켣��λ����
		@param x x����
		@param y y����
		*/
		virtual void				GetTransposition(float *x, float *y) = 0;
		/**
		@brief ��ù켣����Χ��
		@param rect �켣����Χ��
		*/
		virtual ggeRect*			GetBoundingBox(ggeRect *rect) = 0;
	};

	/**
	@brief �����켣��
	@param startCol �켣����ʼ��ɫ
	@param endColor �켣��������ɫ
	@param maxW �켣�������
	@param minW �켣����С���
	@param time �켣��������
	@param maxNodes �켣�����ڵ���
	@param nodeLen �켣���ڵ㳤��(��λ������)
	@return �ɹ�����ggeRibbonTrailָ�룬���򷵻�0
	*/
	GGE_EXPORT ggeRibbonTrail* GGE_CALL RibbonTrail_Create(gUInt startCol = 0xFFFFFFFF, gUInt endColor = 0x00FFFFFF, float maxW = 16.0f, float minW = 0.0f, float time = 1.0f, gUInt maxNodes = 64, gUInt nodeLen = 4);
}