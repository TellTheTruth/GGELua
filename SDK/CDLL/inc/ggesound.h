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
\brief 音效模块
*/

#pragma once
#include "ggecommon.h"
#include "ggerefcounter.h"

namespace gge
{
	/// 音效模块
	class ggeSound : public ggeRefCounter
	{
	public:
		/**
		@brief 播放
		@param bLoop 设置是否重复播放
		@return 成功返回true，失败返回false
		*/
		virtual bool	Play(bool bLoop = false) = 0;	
		/**
		@brief 播放
		@param volume 音量，范围0～100
		@param pan 声道平衡，范围-100～100，小于0表示左声道，大于0表示右声道
		@param pitch 音效频率，范围0.0f～10.0f，1.0f表示原始频率
		@param bLoop 设置是否重复播放
		@return 成功返回true，失败返回false
		*/
		virtual bool	PlayEx(int volume = 100, int pan = 0, float pitch = 1.0f, bool bLoop = false) = 0;

		/**
		@brief 是否正在播放
		@return 如果正在播放返回true，否则返回false
		*/
		virtual bool	IsPlaying() = 0;	
		/**
		@brief 停止播放
		*/
		virtual void	Stop() = 0;	
		/**
		@brief 暂停播放
		*/
		virtual void	Pause() = 0;
		/**
		@brief 继续播放
		*/
		virtual void	Resume() = 0;

		/**
		@brief 设置声道平衡
		@param pan 范围-100～100，小于0表示左声道，大于0表示右声道
		*/
		virtual void	SetPan(int pan) = 0;
		/**
		@brief 设置音量
		@param volume 设置音量，范围0～100
		*/
		virtual void	SetVolume(int volume) = 0;
		/**
		@brief 设置频率
		@param pitch 设置频率，范围0.0f～10.0f，1.0f表示原始频
		*/
		virtual void	SetPitch(float pitch) = 0;
	};

	/**
	@brief 载入音效文件
	@param filename 音效文件名，支持文件格式：.wav, .ogg
	@param bStream 是否以流方式载入
	@param size 内存大小，若该值为0忽略，否则将filename做为音效文件在内存中的地址，该值指示这块内存的大小，从内存中载入音效
	@return 成功返回ggeSound指针，否则返回0
	@note 如果是音乐文件，bStream设为true，以减小内存占用。如果是像子弹之类需要实时播放且可能同时播放多次的音效，bStream设为false
	*/
	GGE_EXPORT ggeSound*	GGE_CALL Sound_Load(const char *filename, bool bStream = false, gULong size = 0);
}