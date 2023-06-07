/*
**  =======================================================
**              Galaxy2D Game Engine       
**                                
**       版权所有(c) 2005 沈明. 保留所有权利.
**    主页地址: http://www.cppblog.com/jianguhan/
**			 电子邮箱: jianguhan@126.com
**  =======================================================
*/

/** \file
\brief 资源管理器
*/

#pragma once
#include "ggecommon.h"
#include "ggerefcounter.h"

namespace gge
{
	/// 资源类型
	enum GGE_RES_TYPE
	{
		GRT_FILETEX,		///< 文件纹理
		GRT_EMPTYTEX,		///< 空白纹理
		GRT_SOUND,			///< 音效
		GRT_SPRITE,			///< 精灵
		GRT_ANIMATION,		///< 动画
		GRT_FONT,			///< 字体
		GRT_PARTICLE,		///< 粒子
		GRT_MESH,			///< 网格
		GRT_IMAGE,			///< 图像
		GRT_STRING,			///< 字符串
		GRT_CUSTOMRES,		///< 自定义资源
		GRT_LAST,
		GRT_FORCE32BIT = 0x7FFFFFFF,
	};

	/// 资源管理器枚举资源回调
	class ggeEnumResCallBack
	{
	public:
		virtual ~ggeEnumResCallBack() {}
		/**
		@brief 枚举资源
		@param name 资源名
		@param type 资源类型
		@return 如果要中断枚举返回true
		*/
		virtual bool OnEnumRes(const char *name, GGE_RES_TYPE type) { return false; }
	};

	/// 资源管理器
	class ggeResManager : public ggeRefCounter
	{
	public:
		/**
		@brief 载入资源文件
		@param filename 资源名
		@return 载入成功true,否则返回false
		*/
		virtual bool	LoadResFile(const char *filename) = 0;
		/**
		@brief 预缓存所有资源
		@return 如果所有资源缓存成功返回true，否则返回false
		*/
		virtual bool	PrepareCache() = 0;
		/**
		@brief 清除所有资源
		@note 注意，如果某些资源被外部引用，调用该函数只会将该资源从资源管理器中移除，但并不释放该资源，引用该资源的地方必须手动释放
		*/
		virtual void	Clear() = 0;
		/**
		@brief 开始载入资源
		@return 返回资源总数
		*/
		virtual int		BeginLoadRes() = 0;
		/**
		@brief 载入下个资源
		@return 成功返回true，失败返回false
		@note 示例：\n
		int ResCount = ResMgr->BeginLoadRes();\n
		for (int i = 1; i <= ResCount; i++) \n
		{\n
			ResMgr->LoadNextRes();\n
			Font->Print(0, 0, "载入进度:%d", i * 100 / ResCount);\n
		}\n
		*/
		virtual bool	LoadNextRes() = 0;
		/**
		@brief 设置垃圾回收时间
		@param gcTime 垃圾回收时间(单位:秒),当gcTime>0时开启垃圾回收功能,gcTime=0关闭垃圾回收功能,默认gcTime=0
		*/
		virtual void	SetGarbageCollectTime(float gcTime) = 0;
		/**
		@brief 强制进行一次垃圾回收
		@note 用Galaxy2D引擎制作游戏工具时，即使设置了垃圾回收时间也不会主动回收过期的资源，必须手动调用该函数进行垃圾回收
		*/
		virtual void	GarbageCollect() = 0;
		/**
		@brief 枚举资源管理器中的资源
		*/
		virtual void	EnumRes(ggeEnumResCallBack *callback) = 0;

		/**
		@brief 返回指定资源名的纹理
		@param name 资源名
		@return 成功返回纹理，失败返回0
		*/
		virtual ggeTexture*		CreateTexture(const char *name) = 0;
		/**
		@brief 如果已载入指定文件名的纹理就直接返回该纹理，否则以指定的参数创建一个
		@param name 资源名
		@param filename 文件名
		@param colorKey 颜色键
		@return 成功返回纹理，失败返回0
		*/
		virtual ggeTexture*		CreateTextureFromFile(const char *name, const char *filename, gUInt colorKey = 0) = 0;
		/**
		@brief 返回指定资源名的音效
		@param name 资源名
		@return 成功返回音效，失败返回0
		*/
		virtual ggeSound*		CreateSound(const char *name) = 0;
		/**
		@brief 如果已载入指定文件名的音效就直接返回该音效，否则以指定的参数创建一个
		@param name 资源名
		@param filename 文件名
		@param bStream 是否以流方式载入
		@return 成功返回音效，失败返回0
		*/
		virtual ggeSound*		CreateSoundFromFile(const char *name, const char *filename, bool bStream = false) = 0;
		/**
		@brief 返回指定资源名的精灵
		@param name 资源名
		@return 成功返回精灵，失败返回0
		*/
		virtual ggeSprite*		CreateSprite(const char *name) = 0;
		/**
		@brief 返回指定资源名的动画
		@param name 资源名
		@return 成功返回动画，失败返回0
		*/
		virtual ggeAnimation*	CreateAnimation(const char *name) = 0;
		/**
		@brief 返回指定资源名的字体
		@param name 资源名
		@return 成功返回字体，失败返回0
		*/
		virtual ggeFont*		CreateFont(const char *name) = 0;
		/**
		@brief 返回指定资源名的字体，如果没找到就用指定的参数创建一个
		@param name 资源名
		@param filename 字体文件名(*.ttf/*.ttc)
		@param size 字体大小，单位：象素
		@param createMode 字体创建模式，可用"|"结合 @see FONT_CREATE_MODE
		@return 成功返回字体，失败返回0
		*/
		virtual ggeFont*		CreateCustomFont(const char *name, const char *filename, int size = 16, int createMode = FONT_MODE_DEFAULT) = 0;
		/**
		@brief 返回指定资源名的字体，如果没找到就用指定的参数创建一个
		@param name 资源名
		@param filename 字体配置文件
		@return 成功返回字体，失败返回0
		*/
		virtual ggeFont*		CreateCustomFontFromImage(const char *name, const char *filename) = 0;
		/**
		@brief 返回指定资源名的粒子系统
		@param name 资源名
		@return 成功返回粒子系统，失败返回0
		*/
		virtual ggeParticle*	CreateParticle(const char *name) = 0;
		/**
		@brief 返回指定资源名的网格
		@param name 资源名
		@return 成功返回网格，失败返回0
		*/
		virtual ggeMesh*		CreateMesh(const char *name) = 0;
		/**
		@brief 返回指定资源名的图像
		@param name 资源名
		@return 成功返回图像，失败返回0
		*/
		virtual ggeImage*		CreateImage(const char *name) = 0;
		/**
		@brief 如果已载入指定文件名的图像就直接返回该图像，否则以指定的参数创建一个
		@param name 资源名
		@param filename 文件名
		@param colorKey 颜色键
		@return 成功返回纹理，失败返回0
		*/
		virtual ggeImage*		CreateImageFromFile(const char *name, const char *filename, gUInt colorKey = 0) = 0;
		/**
		@brief 返回指定资源名的字符串
		@param name 资源名
		@return 成功返回字符串，失败返回0
		*/
		virtual const char*		GetString(const char *name) = 0;
		/**
		@brief 添加托管的自定义资源
		@param name 资源名
		@param res 托管的资源
		@note 该函数会增加引用计数
		*/
		virtual void			AddCustomRes(const char *name, ggeRefCounter *res) = 0;
		/**
		@brief 返回托管的自定义资源
		@param name 资源名
		@return 成功返回自定义资源，失败返回0
		@note 如果资源管理器开启了垃圾回收机制，托管的资源也会被回收。
		如果托管资源被回收，该函数返回0，外部需要再次创建该资源并调用AddCustomRes()函数添加到资源管理器
		*/
		virtual ggeRefCounter*	CreateCustomRes(const char *name) = 0;
	};

	GGE_EXPORT ggeResManager*	GGE_CALL ResManager_Create();
}