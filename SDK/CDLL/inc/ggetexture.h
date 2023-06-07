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
	/// ����
	class ggeTexture : public ggeRefCounter
	{
	public:
		/**
		@brief ��������
		@param bReadOnly �Ƿ�ֻ������Ϊtrue�������ڽ���֮�󲻻����(�������Ҫд�����ݣ���ֵ��Ϊtrue�������Ч��)
		@param left ���������������λ��
		@param top �������������Ϸ�λ��
		@param width ��������������
		@param height ������������߶�
		@return �ɹ�������������(��ʽ��32λ/ARGB)�����򷵻�0
		@note 1.δ������������ʱ��������������Ϊ�����Ч����������ʱӦ����ָ����������\n
		2.��������ʽ��ȡ��ɫֵ��\n
		\code gUInt color = [y * textureWidth + x]; [y * textureWidth + x] = newColor; \endcode
		����textureWidth����GetWidth()��á�\n
		3.��ȾĿ������Ҳ�ǿ���Lock��
		*/
		virtual gUInt*	Lock(bool bReadOnly = true, int left = 0, int top = 0, int width = 0, int height = 0) = 0;
		/**
		@brief �����������
		*/
		virtual void	Unlock() = 0;

		/**
		@brief ���������
		@param bOrginal Ϊtrueʱ��������ԭʼ��ȣ�Ϊfalseʱ�����������Դ���
		@return ������
		*/
		virtual int		GetWidth(bool bOrginal = false) = 0;
		/**
		@brief �������߶�
		@param bOrginal Ϊtrueʱ��������ԭʼ�߶ȣ�Ϊfalseʱ�����������Դ�߶�
		@return ����߶�
		*/
		virtual int		GetHeight(bool bOrginal = false) = 0;

		/**
		@brief ��ָ������ɫ�������
		@param color ���ɫ
		*/
		virtual void	FillColor(gUInt color) = 0;

		/**
		@brief ���浽�ļ�
		@param filename �ļ���
		@param imageFormat �ļ���ʽ��Ĭ�ϱ���ΪPNG��ʽͼƬ
		@return ���ر����Ƿ�ɹ�
		*/
		virtual bool	SaveToFile(const char *filename, GGE_IMAGE_FORMAT imageFormat = IMAGE_PNG) = 0;
	};

	/// ��ȾĿ����������
	enum TARGET_TYPE
	{
		TARGET_DEFAULT	= 0,	///< Ĭ������
		TARGET_ZBUFFER	= 1,	///< ����ZBuffer
		TARGET_LOCKABLE	= 2,	///< ��ȾĿ��������Ա�����
		TARGET_ALPHA	= 4,	///< ��ȾĿ�������Alphaͨ����ע�⣺ĳЩ�Կ����ܲ�֧�ִ�Alphaͨ������ȾĿ��������ʱ������alphaͨ������������ʧ��
		TARGET_FORCE32BIT = 0x7FFFFFFF,
	};

	/**
	@brief ��������
	@param width ������
	@param height ����߶�
	@return �ɹ�����ggeTextureָ�룬ʧ�ܷ���0
	*/
	GGE_EXPORT ggeTexture*	GGE_CALL Texture_Create(int width, int height);
	/**
	@brief ������ȾĿ������
	@param width ������
	@param height ����߶�
	@param targetType ��ȾĿ���������ͣ�����"|"��� @see TARGET_TYPE
	@return �ɹ�����ggeTextureָ�룬ʧ�ܷ���0
	*/
	GGE_EXPORT ggeTexture*	GGE_CALL Texture_CreateRenderTarget(int width, int height, int targetType = TARGET_DEFAULT);
	/**
	@brief ��������
	@param filename �����ļ�����֧���ļ����ͣ�*.bmp, *.png, *.jpg, *.tga, *.dds(DXT1-DXT5)
	@param colorKey ��ɫ��
	@param size �ڴ��С������ֵΪ0���ԣ�����filename��Ϊ�����ļ����ڴ��еĵ�ַ����ֵָʾ����ڴ�Ĵ�С�����ڴ�����������
	@return �ɹ�����ggeTextureָ�룬ʧ�ܷ���0
	*/
	GGE_EXPORT ggeTexture*	GGE_CALL Texture_Load(const char *filename, gUInt colorKey = 0x00000000, gULong size = 0);
}