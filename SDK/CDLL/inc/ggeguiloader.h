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
\brief GUI������
*/

#pragma once
#include "ggeguiwindow.h"

namespace gge
{
	typedef ggeGuiWindow*(*GGE_GUICREATEFUNC)(ggeGuiCreateInfo &info);

	/// GUI������
	class ggeGuiLoader : public ggeRefCounter
	{
	public:
		/**
		@brief ����Զ���ؼ���������
		@param className �Զ���ؼ�����
		@param func ��������
		@note	1.��className��GUI�༭����"�Զ�������"�е�"ClassName"��һ��ʱ��ʹ��func���������ؼ�
				2.className��Ϊ0��������Ĭ�ϴ�������
				3.����༭����"ClassName"Ϊ�ջ��Ҳ�����Ӧ�Ĵ���������ʹ��Ĭ�ϴ������������ؼ������û������Ĭ�ϴ��������򴴽������ؼ�
		*/
		virtual void AddCreateFunc(const char *className, GGE_GUICREATEFUNC func) = 0;

		/**
		@brief ɾ���Զ���ؼ���������
		@param className �Զ���ؼ�������0ΪĬ�ϴ�������
		*/
		virtual void DelCreateFunc(const char *className) = 0;

		/// ɾ�������Զ���ؼ���������
		virtual void DelAllCreateFunc() = 0;

		/**
		@brief ������Դ������
		@param resmgr ��Դ������ָ��
		*/
		virtual void SetResManager(ggeResManager *resmgr) = 0;

		/**
		@brief ����GUI�ļ�
		@param filename GUI�ļ���
		@return ����ɹ�����true�����򷵻�false
		*/
		virtual bool Load(const char *filename) = 0;

		/**
		@brief �����ؼ�
		@param ctrlname �ؼ���
		@return �����ɹ����ؿؼ�ָ�룬���򷵻�0
		@note	1.�ú���ֻ�ܴ���GUI�ؼ��б��еĶ���ؼ�
				2.����������Դ�����������򴴽�ʧ��
		*/
		virtual ggeGuiWindow* CreateControl(const char *ctrlname) = 0;
	};

	/// ����GUI������
	GGE_EXPORT ggeGuiLoader* GGE_CALL GUI_CreateGuiLoader();
}