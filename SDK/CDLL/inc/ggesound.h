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
\brief ��Чģ��
*/

#pragma once
#include "ggecommon.h"
#include "ggerefcounter.h"

namespace gge
{
	/// ��Чģ��
	class ggeSound : public ggeRefCounter
	{
	public:
		/**
		@brief ����
		@param bLoop �����Ƿ��ظ�����
		@return �ɹ�����true��ʧ�ܷ���false
		*/
		virtual bool	Play(bool bLoop = false) = 0;	
		/**
		@brief ����
		@param volume ��������Χ0��100
		@param pan ����ƽ�⣬��Χ-100��100��С��0��ʾ������������0��ʾ������
		@param pitch ��ЧƵ�ʣ���Χ0.0f��10.0f��1.0f��ʾԭʼƵ��
		@param bLoop �����Ƿ��ظ�����
		@return �ɹ�����true��ʧ�ܷ���false
		*/
		virtual bool	PlayEx(int volume = 100, int pan = 0, float pitch = 1.0f, bool bLoop = false) = 0;

		/**
		@brief �Ƿ����ڲ���
		@return ������ڲ��ŷ���true�����򷵻�false
		*/
		virtual bool	IsPlaying() = 0;	
		/**
		@brief ֹͣ����
		*/
		virtual void	Stop() = 0;	
		/**
		@brief ��ͣ����
		*/
		virtual void	Pause() = 0;
		/**
		@brief ��������
		*/
		virtual void	Resume() = 0;

		/**
		@brief ��������ƽ��
		@param pan ��Χ-100��100��С��0��ʾ������������0��ʾ������
		*/
		virtual void	SetPan(int pan) = 0;
		/**
		@brief ��������
		@param volume ������������Χ0��100
		*/
		virtual void	SetVolume(int volume) = 0;
		/**
		@brief ����Ƶ��
		@param pitch ����Ƶ�ʣ���Χ0.0f��10.0f��1.0f��ʾԭʼƵ
		*/
		virtual void	SetPitch(float pitch) = 0;
	};

	/**
	@brief ������Ч�ļ�
	@param filename ��Ч�ļ�����֧���ļ���ʽ��.wav, .ogg
	@param bStream �Ƿ�������ʽ����
	@param size �ڴ��С������ֵΪ0���ԣ�����filename��Ϊ��Ч�ļ����ڴ��еĵ�ַ����ֵָʾ����ڴ�Ĵ�С�����ڴ���������Ч
	@return �ɹ�����ggeSoundָ�룬���򷵻�0
	@note ����������ļ���bStream��Ϊtrue���Լ�С�ڴ�ռ�á���������ӵ�֮����Ҫʵʱ�����ҿ���ͬʱ���Ŷ�ε���Ч��bStream��Ϊfalse
	*/
	GGE_EXPORT ggeSound*	GGE_CALL Sound_Load(const char *filename, bool bStream = false, gULong size = 0);
}