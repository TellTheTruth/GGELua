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
	class ggeFont : public ggeRefCounter
	{
	public:
		/**
		@brief ���ص�ǰ�����һ������
		@return ��ǰ�����һ������
		*/
		virtual ggeFont* Clone() = 0;

		/**
		@brief ��������
		@param x x����
		@param y y����
		@param str �ַ���
		*/
		virtual void	Render(float x, float y, const char *str) = 0;
		/**
		@brief ��������
		@param x x����
		@param y y����
		@param format ��ʽ���ַ���
		*/
		virtual void	Print(float x, float y, const char *format, ...) = 0;

		/**
		@brief ����������ɫ
		@param color ������ɫ
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
		@brief �����п�
		@param width �п�(��λ:����)���ַ��������п��Զ����У�0Ϊ�������п�
		*/
		virtual void	SetLineWidth(int width) = 0;
		/**
		@brief �����ּ��
		@param space �м��(��λ:����)��Ĭ��Ϊ0
		*/
		virtual void	SetCharSpace(int space) = 0;
		/**
		@brief �����м��
		@param space �м��(��λ:����)��Ĭ��Ϊ0
		*/
		virtual void	SetLineSpace(int space) = 0;
		/**
		@brief ����Ҫ��ʾ�����ָ���
		@param num ���ָ�����Ϊ-1ʱ����ʾ�������֣�Ĭ��Ϊ-1
		*/
		virtual void	SetCharNum(int num) = 0;
		/**
		@brief ���������Ű���ʽ
		@param align �����Ű���ʽ
		@see FONT_ALIGN
		*/
		virtual void	SetAlign(int align) = 0;
		/**
		@brief ����������Ӱ��ɫ
		@param color ��Ӱ��ɫ
		*/
		virtual void	SetShadowColor(gUInt color) = 0;
		/**
		@brief �������������ɫ(��Ҫ��������ʱ������߹���)
		@param color �����ɫ
		*/
		virtual void	SetBorderColor(gUInt color) = 0;

		/**
		@brief ���������ɫ
		@return ������ɫ
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
		@brief ����п�
		@return �п�
		*/
		virtual int		GetLineWidth() = 0;
		/**
		@brief ����ּ��
		@return �ּ��
		*/
		virtual int		GetCharSpace() = 0;
		/**
		@brief ����м��
		@return �м��
		*/
		virtual int		GetLineSpace() = 0;
		/**
		@brief �������߶�
		@return ����߶�
		*/
		virtual int		GetFontHight() = 0;
		/**
		@brief ��������С
		@return �����С
		*/
		virtual int		GetFontSize() = 0;
		/**
		@brief ����Ҫ��ʾ���ַ���
		@return ����Ҫ��ʾ���ַ���
		*/
		virtual int		GetCharNum() = 0;
		/**
		@brief ��������Ű���ʽ
		@return �����Ű���ʽ
		*/
		virtual int		GetAlign() = 0;
		/**
		@brief ���������Ӱ��ɫ
		@return ������Ӱ��ɫ
		*/
		virtual gUInt	GetShadowColor() = 0;
		/**
		@brief ������������ɫ
		@return ���������ɫ
		*/
		virtual gUInt	GetBorderColor() = 0;

		///�ַ�����Ϣ
		struct StringInfo
		{
			float Width;	///< �ַ������
			float Height;	///< �ַ����߶�
		};
		/**
		@brief ����ִ���Ϣ
		@param str �ַ���
		@param strinfo �ַ�����Ϣ @see StringInfo
		@param len Ҫɨ����ַ������ȣ����Ϊ-1��ɨ�������ַ���
		*/
		virtual void	GetStringInfo(const char *str, StringInfo &strinfo, int len = -1) = 0;
	};

	/**
	@brief ��������
	@param filename �����ļ���(*.ttf/*.ttc)
	@param fontSize �����С����λ������(�������4)
	@param createMode ���崴��ģʽ������"|"��� @see FONT_CREATE_MODE
	@return �ɹ�����ggeFontָ�룬���򷵻�0
	@note ����ײ��Ѷ�������Դ����ͳһ���Ⱥ͹����ظ�������ͬ���Ե������Clone����ֻ�����������ڴ�ռ����
	*/
	GGE_EXPORT ggeFont*	GGE_CALL Font_Create(const char *filename, int fontSize = 16, int createMode = FONT_MODE_DEFAULT);

	/**
	@brief ��ͼƬ��������
	@param filename ���������ļ�
	@return �ɹ�����ggeFontָ�룬���򷵻�0
	@code	һ�����������ļ���������ʽ���£�
		<?xml version="1.0" encoding="gb2312" ?>
		<Font_File>
			<FontInfo Size="28" LineSpace="28"/>
			<Page Texture="imgfont.png">
				<CharInfo Char="0" X="0" Y="4" W="28" H="27" Adv="28" OX="0" OY = "0"/>
			</Page>
		</Font_File>
		
		FontInfo�ڵ�������������Ļ�������
			Size�������С(��λ������)
			LineSpace��Ĭ���о�(��λ������)
		
		Page�ڵ���������һ�������ϵ��������ԣ�������ֲַ��ڶ��������ϣ�����д���Page��������������
			Texture����ǰ�������ڵ��������֣��������������������ļ�����ͬһĿ¼
		
		CharInfo�ڵ�����������������
			X/Y�������ڵ�ǰ���������Ͻ�����(��λ������)
			W/H�����ֿ�Ⱥ͸߶�(��λ������)
			Adv�������¸����ֻ���Ҫ�ƶ��ľ���(��λ������)
			OX/OY����������ʱX/Y�����ϵ�ƫ����(��λ������)
	@endcode 
	*/
	GGE_EXPORT ggeFont*	GGE_CALL Font_CreateFromImage(const char *filename);
}