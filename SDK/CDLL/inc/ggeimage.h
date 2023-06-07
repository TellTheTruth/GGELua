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
\brief ͼ��ģ��
*/

#pragma once
#include "ggecommon.h"
#include "ggerefcounter.h"

namespace gge
{
	/// ͼ��ģ��
	class ggeImage : public ggeRefCounter
	{
	public:
		/**
		@brief ��Ⱦ
		@param x ���Ͻ�x����
		@param y ���Ͻ�y����
		*/
		virtual void	Render(float x, float y) = 0;

		/**
		@brief ����ͼ��
		@param readOnly �Ƿ�ֻ������Ϊtrue�������ڽ���֮�󲻻����(�������Ҫд�����ݣ���ֵ��Ϊtrue�������Ч��)
		@return �����ɹ�����true�����򷵻�false
		@note ��GetPixel()������ȡ����
		*/
		virtual bool	Lock(bool readOnly = true) = 0;
		/**
		@brief ���ָ���������
		@param x x����
		@param y y����
		@return ָ���������
		*/
		virtual gUInt	GetPixel(int x, int y) = 0;
		/**
		@brief ����ָ���������
		@param x x����
		@param y y����
		@param col Ҫд�������
		*/
		virtual void	SetPixel(int x, int y, gUInt col) = 0;
		/**
		@brief ���ͼ������
		*/
		virtual void	Unlock() = 0;

		/**
		@brief ����Ҫ��Ⱦ��ͼ������
		@param x x����
		@param y y����
		@param width ���
		@param height �߶�
		*/
		virtual void	SetRect(float x, float y, float width, float height) = 0;
		/**
		@brief ������Ⱦ��ɫ
		@param color ��Ⱦ��ɫ
		*/
		virtual void	SetColor(gUInt color) = 0;
		/**
		@brief ����Z�����
		@param z Z�����(0.0f��1.0f��0��ʾ���ϲ㣬1��ʾ���²�)
		*/
		virtual void	SetZ(float z) = 0;
		/**
		@brief ���û��ģʽ
		@param blend ���ģʽ������"|"���
		@see BLEND_MODE
		*/
		virtual void	SetBlendMode(int blend) = 0;
		/**
		@brief �Ƿ����������
		@param b Ϊtrueʱ������Ĭ�Ϲر�
		*/
		virtual void	SetTextureFilter(bool b) = 0;
		/**
		@brief ��������ת����
		@param bX ˮƽ��ת
		@param bY ��ֱ��ת
		*/
		virtual void	SetFlip(bool bX, bool bY) = 0;

		/**
		@brief ���������Ⱦ����������
		@param x x����
		@param y y����
		@param width ���
		@param height �߶�
		*/
		virtual void	GetRect(float *x, float *y, float *width, float *height) = 0;
		/**
		@brief ���ͼ����ɫ
		@return ͼ����ɫ
		*/
		virtual gUInt	GetColor() = 0;				
		/**
		@brief ���Z�����
		@return Z�����
		*/
		virtual float	GetZ() = 0;
		/**
		@brief ��û��ģʽ
		@return ���ģʽ
		*/
		virtual int		GetBlendMode() = 0;
		/**
		@brief �Ƿ����������
		*/
		virtual bool	IsTextureFilter() = 0;
		/**
		@brief ��÷�תģʽ����
		@param bX ˮƽ��ת
		@param bY ��ֱ��ת
		*/
		virtual void	GetFlip(bool *bX, bool *bY) = 0;

		/**
		@brief ���ͼ����
		@return ͼ����
		*/
		virtual int		GetWidth() = 0;
		/**
		@brief ���ͼ��߶�
		@return ͼ��߶�
		*/
		virtual int		GetHeight() = 0;
	};

	/**
	@brief ����ͼ���ļ��������벢��ʾ�����Կ���������С��ͼƬ
	@param filename �����ļ�����֧���ļ����ͣ�*.bmp, *.png, *.jpg, *.tga, *.dds(DXT1-DXT5)
	@param colorKey ��ɫ��
	@param size �ڴ��С������ֵΪ0���ԣ�����filename��Ϊͼ���ļ����ڴ��еĵ�ַ����ֵָʾ����ڴ�Ĵ�С�����ڴ�������ͼ��
	@return �ɹ�����ggeImageָ�룬ʧ�ܷ���0
	*/
	GGE_EXPORT ggeImage* GGE_CALL Image_Load(const char *filename, gUInt colorKey = 0x00000000, gULong size = 0);
}