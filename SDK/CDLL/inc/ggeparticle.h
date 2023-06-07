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
\brief ����ϵͳ
*/

#pragma once
#include "ggecommon.h"
#include "ggerefcounter.h"
#include "ggecolor.h"
#include "ggemath.h"

namespace gge
{
	/// ��������ϵͳʱĬ�ϵ����������
	const int MAX_PARTICLES			= 500;
	/// ������������ϵͳ����ʱ�䣬�������ʱ����Ϊ��ֵ��������ϵͳһֱ��������״̬
	const float PAR_AGE_INCESSANCY	= -1.0f;
	/// ����ϵͳ��ֹͣ����
	const float PAR_AGE_STOPPED		= -2.0f;
	/// ������������ϵͳ״̬ÿ�����������������ÿ��������������ɸ�ֵ���򱣳��������������
	const int PAR_MAX_EMISSION		= -1;

	/// ����ϵͳ��Ϣ
	struct ggeParticleInfo
	{
		/// ���ӷ���������
		enum PARTICLE_EMITTER_TYPE
		{
			EMT_POINT,			///< �㷢����
			EMT_RECT,			///< ���η�����
			EMT_CIRCLE,			///< Բ�η�����
			EMT_RECT_AREA,		///< ������������
			EMT_CIRCLE_AREA,	///< Բ����������
		};

		/// ���ӷ��������䷽��
		enum PARTICLE_EMITTER_DIR
		{
			EMT_NONE,			///< ���ı��ʼ����
			EMT_IN,				///< ��������ϵͳ���ĵ�
			EMT_OUT,			///< ��������ϵͳ���ĵ�
		};

		ggeParticleInfo() : emitterType(EMT_POINT), emitterDir(EMT_NONE), emitterWidth(0), emitterHeight(0), emission(0), 
			lifetime(0), particleLifeMin(0), particleLifeMax(0), direction(0), spread(0), relative(false), speedMin(0), speedMax(0), 
			gravityMin(0), gravityMax(0), radialAccelMin(0), radialAccelMax(0), tangentialAccelMin(0), tangentialAccelMax(0), 
			sizeStart(1.0f), sizeEnd(1.0f), sizeVar(0), spinStart(0), spinEnd(0), spinVar(0), colorStart(1.0f, 1.0f, 1.0f, 1.0f), colorEnd(1.0f, 1.0f, 1.0f, 0), 
			colorVar(0), alphaVar(0), fadeColor(1.0f, 1.0f, 1.0f, 1.0f), fadeColorWeight(0), fadeColorVar(0), fadeAlphaVar(0) {}

		int			emitterType;		///< ���������� @see PARTICLE_EMITTER_TYPE
		int			emitterDir;			///< ����������EMT_POINT��������Ч @see PARTICLE_EMITTER_DIR
		float		emitterWidth;		///< ��������ȣ�EMT_POINT��������Ч
		float		emitterHeight;		///< �������߶ȣ�EMT_POINT��������Ч
		
		int			emission;			///< ÿ����������������Ϊ PAR_MAX_EMISSION �򱣳����������������������������������������������������µ�����
		float		lifetime;			///< ����ϵͳ����ʱ��(��)����Ϊ PAR_AGE_INCESSANCY ���������

		float		particleLifeMin;	///< ������С������(��)
		float		particleLifeMax;	///< �������������(��)

		float		direction;			///< ���ӷ���Ƕ�(����) 
		float		spread;				///< ���ӷ���Ƕ�ƫ����������Ƕ�ȡֵ��ΧΪ(direction +/- spread) 
		bool		relative;			///< ���Ϊtrue�����ӷ���Ƕ��ܵ�ǰ����ϵͳ�ƶ�����Ӱ�� 

		float		speedMin;			///< ��С��ʼ�ٶ�(����/��)
		float		speedMax;			///< �����ʼ�ٶ�(����/��)

		float		gravityMin;			///< ��С�������ٶ�
		float		gravityMax;			///< ����������ٶ�

		float		radialAccelMin;		///< ��С�߼��ٶ� 
		float		radialAccelMax;		///< ����߼��ٶ� 

		float		tangentialAccelMin;	///< ��С�Ǽ��ٶ�
		float		tangentialAccelMax;	///< ���Ǽ��ٶ�

		float		sizeStart;			///< ��ʼ�ߴ磬1.0f��ʾԭʼ�ߴ� 
		float		sizeEnd;			///< �����ߴ磬1.0f��ʾԭʼ�ߴ� 
		float		sizeVar;			///< �ߴ縡��ֵ(0.0f��1.0f)

		float		spinStart;			///< ��ʼ��ת�ٶ�(����) 
		float		spinEnd;			///< ������ת�ٶ�(����) 
		float		spinVar;			///< ��ת�ٶȸ���ֵ(0.0f��1.0f)

		ggeColor	colorStart;			///< ��ʼ��ɫ 
		ggeColor	colorEnd;			///< ������ɫ 
		float		colorVar;			///< ��ʼ��ɫ����ֵ(0.0f��1.0f)
		float		alphaVar;			///< ��ʼ��ɫAlpha����ֵ(0.0f��1.0f)

		float		fadeColorWeight;	///< ������ɫȨֵ��Խ���ʾ����ʼ��ɫ���䵽������ɫ�����ʱ��Խ�������Ϊ0��ʾ��ʹ�ù�����ɫ(0.0f��1.0f)
		ggeColor	fadeColor;			///< ������ɫ
		float		fadeColorVar;		///< ������ɫ����ֵ(0.0f��1.0f)
		float		fadeAlphaVar;		///< ������ɫAlpha����ֵ(0.0f��1.0f)
	};

	/// ����ϵͳ
	class ggeParticle : public ggeRefCounter
	{
	public:
		/**
		@brief ��������ϵͳ
		@param par Դ����ϵͳ
		*/
		virtual void				Copy(ggeParticle *par) = 0;
		/**
		@brief ���ص�ǰ����ϵͳ��һ������
		@return ��ǰ����ϵͳ��һ������
		*/
		virtual ggeParticle*		Clone() = 0;

		/**
		@brief ˢ������ϵͳ
		@param dt ��һ֡����ʱ�䣬����Timer_GetDelta()���
		*/
		virtual void				Update(float dt) = 0;
		/**
		@brief ��Ⱦ����ϵͳ
		*/
		virtual void				Render() = 0;
		/**
		@brief ��ָ��������������ϵͳ
		@param x x����
		@param y y����
		*/
		virtual void				FireAt(float x, float y) = 0;
		/**
		@brief ��������ϵͳ
		*/
		virtual void				Fire() = 0;
		/**
		@brief ֹͣ����ϵͳ
		@param bKillParticles �Ƿ������δ����������
		*/
		virtual void				Stop(bool bKillParticles = false) = 0;
		/**
		@brief �ƶ�����ϵͳ��ָ��λ��
		@param x x����
		@param y y����
		@param bMoveParticles ���Ϊtrue�����л���ӽ����ƶ�������ֻ�ƶ�����ϵͳ
		*/
		virtual void				MoveTo(float x, float y, bool bMoveParticles = false) = 0;
		/**
		@brief ��������ϵ��
		@param scale ����ϵ����Ĭ��Ϊ1.0f
		*/
		virtual void				SetScale(float scale) = 0;
		/**
		@brief ��������ϵͳ�ƶ�λ��
		@param x x����
		@param y y����
		*/
		virtual void				Transpose(float x, float y) = 0;
		/**
		@brief �Ƿ�������ϵͳ��Χ����
		@param bTrack �Ƿ�������ϵͳ��Χ����
		*/
		virtual void				TrackBoundingBox(bool bTrack) = 0;
		/**
		@brief ��������ϵͳ��Ϣ
		@param info ����ϵͳ��Ϣ
		*/
		virtual void				SetParticleInfo(ggeParticleInfo &info) = 0;
		/**
		@brief ���þ������
		@param sprite ��Ⱦ�������þ������
		*/
		virtual void				SetSprite(ggeSprite *sprite) = 0;

		/**
		@brief �����������
		@return ��������
		*/
		virtual int					GetParticleCount() = 0;
		/**
		@brief ��û������
		@return �������
		*/
		virtual int					GetParticlesAlive() = 0;
		/**
		@brief �������ϵͳ������������ȥ����
		@return ��������ǳ������еķ���PAR_AGE_INCESSANCY���������ϵͳ��ֹͣ�򷵻�PAR_AGE_STOPPED
		*/
		virtual float				GetAge() = 0;
		/**
		@brief ��������ϵ��
		*/
		virtual float				GetScale() = 0;
		/**
		@brief �������ϵͳ����
		@param x x����
		@param y y����
		*/
		virtual void				GetPosition(float *x, float *y) = 0;
		/**
		@brief �������ϵͳλ����
		@param x x����
		@param y y����
		*/
		virtual void				GetTransposition(float *x, float *y) = 0;
		/**
		@brief �������ϵͳ��Χ��
		@param rect ����ϵͳ��Χ��
		*/
		virtual ggeRect*			GetBoundingBox(ggeRect *rect) = 0;
		/**
		@brief �������ϵͳ������Ϣ
		@return ����ϵͳ������Ϣ
		*/
		virtual ggeParticleInfo&	GetParticleInfo() = 0;
		/**
		@brief ���ʹ���еľ������
		@return �������
		*/
		virtual ggeSprite*			GetSprite() = 0;
	};

	/**
	@brief ��������ϵͳ
	@param info ָ��һ��ggeParticleInfo�ṹ��
	@param sprite ��Ⱦ�������þ������
	@param maxPSNum ���������
	@return �ɹ�����ggeParticleָ�룬���򷵻�0
	*/
	GGE_EXPORT ggeParticle* GGE_CALL Particle_Create(const ggeParticleInfo &info, ggeSprite *sprite, int maxPSNum = MAX_PARTICLES);
}