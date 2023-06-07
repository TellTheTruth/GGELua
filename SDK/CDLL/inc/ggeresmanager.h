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
\brief ��Դ������
*/

#pragma once
#include "ggecommon.h"
#include "ggerefcounter.h"

namespace gge
{
	/// ��Դ����
	enum GGE_RES_TYPE
	{
		GRT_FILETEX,		///< �ļ�����
		GRT_EMPTYTEX,		///< �հ�����
		GRT_SOUND,			///< ��Ч
		GRT_SPRITE,			///< ����
		GRT_ANIMATION,		///< ����
		GRT_FONT,			///< ����
		GRT_PARTICLE,		///< ����
		GRT_MESH,			///< ����
		GRT_IMAGE,			///< ͼ��
		GRT_STRING,			///< �ַ���
		GRT_CUSTOMRES,		///< �Զ�����Դ
		GRT_LAST,
		GRT_FORCE32BIT = 0x7FFFFFFF,
	};

	/// ��Դ������ö����Դ�ص�
	class ggeEnumResCallBack
	{
	public:
		virtual ~ggeEnumResCallBack() {}
		/**
		@brief ö����Դ
		@param name ��Դ��
		@param type ��Դ����
		@return ���Ҫ�ж�ö�ٷ���true
		*/
		virtual bool OnEnumRes(const char *name, GGE_RES_TYPE type) { return false; }
	};

	/// ��Դ������
	class ggeResManager : public ggeRefCounter
	{
	public:
		/**
		@brief ������Դ�ļ�
		@param filename ��Դ��
		@return ����ɹ�true,���򷵻�false
		*/
		virtual bool	LoadResFile(const char *filename) = 0;
		/**
		@brief Ԥ����������Դ
		@return ���������Դ����ɹ�����true�����򷵻�false
		*/
		virtual bool	PrepareCache() = 0;
		/**
		@brief ���������Դ
		@note ע�⣬���ĳЩ��Դ���ⲿ���ã����øú���ֻ�Ὣ����Դ����Դ���������Ƴ����������ͷŸ���Դ�����ø���Դ�ĵط������ֶ��ͷ�
		*/
		virtual void	Clear() = 0;
		/**
		@brief ��ʼ������Դ
		@return ������Դ����
		*/
		virtual int		BeginLoadRes() = 0;
		/**
		@brief �����¸���Դ
		@return �ɹ�����true��ʧ�ܷ���false
		@note ʾ����\n
		int ResCount = ResMgr->BeginLoadRes();\n
		for (int i = 1; i <= ResCount; i++) \n
		{\n
			ResMgr->LoadNextRes();\n
			Font->Print(0, 0, "�������:%d", i * 100 / ResCount);\n
		}\n
		*/
		virtual bool	LoadNextRes() = 0;
		/**
		@brief ������������ʱ��
		@param gcTime ��������ʱ��(��λ:��),��gcTime>0ʱ�����������չ���,gcTime=0�ر��������չ���,Ĭ��gcTime=0
		*/
		virtual void	SetGarbageCollectTime(float gcTime) = 0;
		/**
		@brief ǿ�ƽ���һ����������
		@note ��Galaxy2D����������Ϸ����ʱ����ʹ��������������ʱ��Ҳ�����������չ��ڵ���Դ�������ֶ����øú���������������
		*/
		virtual void	GarbageCollect() = 0;
		/**
		@brief ö����Դ�������е���Դ
		*/
		virtual void	EnumRes(ggeEnumResCallBack *callback) = 0;

		/**
		@brief ����ָ����Դ��������
		@param name ��Դ��
		@return �ɹ���������ʧ�ܷ���0
		*/
		virtual ggeTexture*		CreateTexture(const char *name) = 0;
		/**
		@brief ���������ָ���ļ����������ֱ�ӷ��ظ�����������ָ���Ĳ�������һ��
		@param name ��Դ��
		@param filename �ļ���
		@param colorKey ��ɫ��
		@return �ɹ���������ʧ�ܷ���0
		*/
		virtual ggeTexture*		CreateTextureFromFile(const char *name, const char *filename, gUInt colorKey = 0) = 0;
		/**
		@brief ����ָ����Դ������Ч
		@param name ��Դ��
		@return �ɹ�������Ч��ʧ�ܷ���0
		*/
		virtual ggeSound*		CreateSound(const char *name) = 0;
		/**
		@brief ���������ָ���ļ�������Ч��ֱ�ӷ��ظ���Ч��������ָ���Ĳ�������һ��
		@param name ��Դ��
		@param filename �ļ���
		@param bStream �Ƿ�������ʽ����
		@return �ɹ�������Ч��ʧ�ܷ���0
		*/
		virtual ggeSound*		CreateSoundFromFile(const char *name, const char *filename, bool bStream = false) = 0;
		/**
		@brief ����ָ����Դ���ľ���
		@param name ��Դ��
		@return �ɹ����ؾ��飬ʧ�ܷ���0
		*/
		virtual ggeSprite*		CreateSprite(const char *name) = 0;
		/**
		@brief ����ָ����Դ���Ķ���
		@param name ��Դ��
		@return �ɹ����ض�����ʧ�ܷ���0
		*/
		virtual ggeAnimation*	CreateAnimation(const char *name) = 0;
		/**
		@brief ����ָ����Դ��������
		@param name ��Դ��
		@return �ɹ��������壬ʧ�ܷ���0
		*/
		virtual ggeFont*		CreateFont(const char *name) = 0;
		/**
		@brief ����ָ����Դ�������壬���û�ҵ�����ָ���Ĳ�������һ��
		@param name ��Դ��
		@param filename �����ļ���(*.ttf/*.ttc)
		@param size �����С����λ������
		@param createMode ���崴��ģʽ������"|"��� @see FONT_CREATE_MODE
		@return �ɹ��������壬ʧ�ܷ���0
		*/
		virtual ggeFont*		CreateCustomFont(const char *name, const char *filename, int size = 16, int createMode = FONT_MODE_DEFAULT) = 0;
		/**
		@brief ����ָ����Դ�������壬���û�ҵ�����ָ���Ĳ�������һ��
		@param name ��Դ��
		@param filename ���������ļ�
		@return �ɹ��������壬ʧ�ܷ���0
		*/
		virtual ggeFont*		CreateCustomFontFromImage(const char *name, const char *filename) = 0;
		/**
		@brief ����ָ����Դ��������ϵͳ
		@param name ��Դ��
		@return �ɹ���������ϵͳ��ʧ�ܷ���0
		*/
		virtual ggeParticle*	CreateParticle(const char *name) = 0;
		/**
		@brief ����ָ����Դ��������
		@param name ��Դ��
		@return �ɹ���������ʧ�ܷ���0
		*/
		virtual ggeMesh*		CreateMesh(const char *name) = 0;
		/**
		@brief ����ָ����Դ����ͼ��
		@param name ��Դ��
		@return �ɹ�����ͼ��ʧ�ܷ���0
		*/
		virtual ggeImage*		CreateImage(const char *name) = 0;
		/**
		@brief ���������ָ���ļ�����ͼ���ֱ�ӷ��ظ�ͼ�񣬷�����ָ���Ĳ�������һ��
		@param name ��Դ��
		@param filename �ļ���
		@param colorKey ��ɫ��
		@return �ɹ���������ʧ�ܷ���0
		*/
		virtual ggeImage*		CreateImageFromFile(const char *name, const char *filename, gUInt colorKey = 0) = 0;
		/**
		@brief ����ָ����Դ�����ַ���
		@param name ��Դ��
		@return �ɹ������ַ�����ʧ�ܷ���0
		*/
		virtual const char*		GetString(const char *name) = 0;
		/**
		@brief ����йܵ��Զ�����Դ
		@param name ��Դ��
		@param res �йܵ���Դ
		@note �ú������������ü���
		*/
		virtual void			AddCustomRes(const char *name, ggeRefCounter *res) = 0;
		/**
		@brief �����йܵ��Զ�����Դ
		@param name ��Դ��
		@return �ɹ������Զ�����Դ��ʧ�ܷ���0
		@note �����Դ�������������������ջ��ƣ��йܵ���ԴҲ�ᱻ���ա�
		����й���Դ�����գ��ú�������0���ⲿ��Ҫ�ٴδ�������Դ������AddCustomRes()������ӵ���Դ������
		*/
		virtual ggeRefCounter*	CreateCustomRes(const char *name) = 0;
	};

	GGE_EXPORT ggeResManager*	GGE_CALL ResManager_Create();
}