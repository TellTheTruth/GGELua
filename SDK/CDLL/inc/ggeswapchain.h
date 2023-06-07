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
\brief ������ģ��
*/

#pragma once
#include "ggecommon.h"
#include "ggerefcounter.h"

namespace gge
{
	/// ������ģ��
	class ggeSwapChain : public ggeRefCounter
	{
	public:
		/**
		@brief ��ʼ�Խ�����Ϊ��ȾĿ�꿪ʼ��Ⱦ
		@param color �Ը���ɫˢ�´���
		@return �ɹ�����true��ʧ�ܷ���false
		*/
		virtual bool BeginScene(gUInt color = 0xFF000000) = 0;
		/**
		@brief ������������Ⱦ�����������Ⱦ�����ڵ�ǰ�������������ݶ���Ⱦ�������������Ⱦ����ߴ��뽻�����ߴ粻ͬ����Ⱦ�����Ļ��潫�ᱻ�����ѹ��
		@param x x����
		@param y y����
		@param width ���
		@param height �߶�
		*/
		virtual void EndScene(int x = 0, int y = 0, int width = 0, int height = 0) = 0;
	};

	/**
	@brief ����һ��ָ�����ھ���Ľ�����
	@param hwnd ���ھ��
	@param width ��̨�����ȣ�Ϊ0��ʹ��GGE_SCREENWIDTH
	@param height ��̨����߶ȣ�Ϊ0��ʹ��GGE_SCREENHEIGHT
	@return �����ɹ�����ggeSwapChainָ�룬���򷵻�0
	*/
	GGE_EXPORT ggeSwapChain* GGE_CALL SwapChain_Create(HWND hwnd, int width = 0, int height = 0);
}