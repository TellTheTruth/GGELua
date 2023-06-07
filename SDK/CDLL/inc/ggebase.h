/*
**  =======================================================
**                Galaxy2D Game Engine       
**                                
**       版权所有(c) 2005 沈明. 保留所有权利.
**    主页地址: http://www.cppblog.com/jianguhan/
**			 电子邮箱: jianguhan@126.com
**  =======================================================
*/

/** \file
\brief 基础函数
*/

#pragma once
#include "ggecommon.h"

namespace gge
{
	/// 版本号
	#define GGE_VERSION 41

	/** @name 基础函数
	*  @{
	*/

	/**
	@brief 创建引擎
	@param ver 版本号
	@return 成功返回true，失败返回false
	*/
	GGE_EXPORT bool			GGE_CALL Engine_Create(int ver = GGE_VERSION);
	/**
	@brief 释放引擎
	*/
	GGE_EXPORT void			GGE_CALL Engine_Release();

	/**
	@brief 初始化系统
	@return 成功返回true，失败返回false
	@note 系统未初始化前只有System_SetState函数有效
	*/
	GGE_EXPORT bool			GGE_CALL System_Initiate();
	/**
	@brief 系统开始运行
	@return 正常结束返回true，否则返回false
	@note 运行该函数前必须设置帧函数
	*/
	GGE_EXPORT bool			GGE_CALL System_Start();

	/**
	@brief 设置系统状态
	@param state 状态
	@param value 状态值
	*/
	GGE_EXPORT void			GGE_CALL System_SetState(GGE_STATE_INT state, int value);
	/**
	@brief 设置系统状态
	@param state 状态
	@param value 状态值
	*/
	GGE_EXPORT void			GGE_CALL System_SetState(GGE_STATE_BOOL state, bool value);
	/**
	@brief 设置系统状态
	@param state 状态
	@param value 状态值
	*/
	GGE_EXPORT void			GGE_CALL System_SetState(GGE_STATE_CHAR state, const char *value);
	/**
	@brief 设置系统状态
	@param state 状态
	@param value 状态值
	*/
	GGE_EXPORT void			GGE_CALL System_SetState(GGE_STATE_HWND state, HWND value);
	/**
	@brief 设置系统状态
	@param state 状态
	@param value 状态值
	*/
	GGE_EXPORT void			GGE_CALL System_SetState(GGE_STATE_BOOL_FUN state, GGE_BOOLFUN value);
	/**
	@brief 设置系统状态
	@param state 状态
	@param value 状态值
	*/
	GGE_EXPORT void			GGE_CALL System_SetState(GGE_STATE_MSG_FUN state, GGE_MSGFUN value);

	/**
	@brief 返回系统状态
	@param state 状态
	*/
	GGE_EXPORT int			GGE_CALL System_GetState(GGE_STATE_INT state);
	/**
	@brief 返回系统状态
	@param state 状态
	*/
	GGE_EXPORT bool			GGE_CALL System_GetState(GGE_STATE_BOOL state);
	/**
	@brief 返回系统状态
	@param state 状态
	*/
	GGE_EXPORT const char*	GGE_CALL System_GetState(GGE_STATE_CHAR state);
	/**
	@brief 返回系统状态
	@param state 状态
	*/
	GGE_EXPORT HWND			GGE_CALL System_GetState(GGE_STATE_HWND state);
	/**
	@brief 返回系统状态
	@param state 状态
	*/
	GGE_EXPORT GGE_BOOLFUN	GGE_CALL System_GetState(GGE_STATE_BOOL_FUN state);
	/**
	@brief 返回系统状态
	@param state 状态
	*/
	GGE_EXPORT GGE_MSGFUN	GGE_CALL System_GetState(GGE_STATE_MSG_FUN state);

	/**
	@brief 写入调试Log
	@param format log记录
	*/
	GGE_EXPORT void			GGE_CALL System_Log(const char *format, ...);
	/**
	@brief 运行外部可执行文件或打开URL
	@param url 可执行文件或URL
	*/
	GGE_EXPORT bool			GGE_CALL System_Launch(const char *url);

	/**
	@brief 读取资源文件
	@param filename 资源文件名
	@param size 读取文件成功后将文件大小写入该参数
	@return 读取成功返回资源内存指针，否则返回0
	@note 该函数先查找绑定的ZIP压缩包若没找到则查找当前目录该名称的文件
	*/
	GGE_EXPORT void*		GGE_CALL Resource_Load(const char *filename, gULong *size = 0);
	/**
	@brief 读取资源文件
	@param filename 资源文件名
	@param buf 将资源文件读取到指定的内存中
	@param size 指定内存大小，如果文件大小超过改参数大小，超过的数据将被丢弃
	@return 读取文件大小，读取失败返回0
	@note 该函数先查找绑定的ZIP压缩包若没找到则查找当前目录该名称的文件
	*/
	GGE_EXPORT gULong		GGE_CALL Resource_LoadTo(const char *filename, void *buf, gULong size);
	/**
	@brief 获取资源文件大小
	@param filename 资源文件名
	@return 资源文件大小
	*/
	GGE_EXPORT gULong		GGE_CALL Resource_GetSize(const char *filename);
	/**
	@brief 测试资源文件是否存在
	@param filename 资源文件名
	@return 资源文件是否存在返回true，否则返回false
	*/
	GGE_EXPORT bool			GGE_CALL Resource_IsExist(const char *filename);
	/**
	@brief 释放资源
	@param res Resource_Load()函数载入的资源
	*/
	GGE_EXPORT void			GGE_CALL Resource_Free(void *res);
	/**
	@brief 绑定ZIP压缩包
	@param filename 压缩包文件名
	@param password 压缩包密码
	@return 绑定成功返回true，否则返回false
	@note 若有多个压缩包，依次绑定即可。搜索文件时从第一个压缩包开始，找到文件立即返回，忽略后面压缩包中的同名文件
	*/
	GGE_EXPORT bool			GGE_CALL Resource_AttachPack(const char *filename, const char *password = 0);
	/**
	@brief 移除绑定的压缩包
	@param filename 压缩包文件名
	*/
	GGE_EXPORT void			GGE_CALL Resource_RemovePack(const char *filename = 0);
	/**
	@brief 添加资源搜索路径
	若Resource_Load在当前目录无法找到文件，则自动转到添加的路径中查找该文件，搜索路径可添加多个但不可删除
	@param pathname 资源搜索路径
	*/
	GGE_EXPORT void			GGE_CALL Resource_AddPath(const char *pathname);
	/**
	@brief 返回ZIP压缩包第一个文件的文件名
	@param filename 压缩包文件名名字
	@return 如果调用成功返回文件名，否则返回0
	*/
	GGE_EXPORT const char*	GGE_CALL Resource_GetPackFirstFileName(const char *filename);
	/**
	@brief 返回ZIP压缩包下一个文件的文件名，调用Resource_GetPackFirstFileName()函数后有效
	@return 如果找到下一个文件则返回文件名，否则返回0
	*/
	GGE_EXPORT const char*	GGE_CALL Resource_GetPackNextFileName();

	/**
	@brief 设置用于操作的ini文件，如果配置文件在但前目录下要在文件名前加"./"，例如：Ini_SetFile("./cfg.ini")
	@param filename 文件名
	@note 配置文件格式:\n
	;注释\n
	[字段名]\n
	键名=键值\n
	*/
	GGE_EXPORT void			GGE_CALL Ini_SetFile(const char *filename);
	/**
	@brief 将int类型值写入配置文件
	@param section 字段名
	@param name 键名
	@param value 键值
	*/
	GGE_EXPORT void			GGE_CALL Ini_SetInt(const char *section, const char *name, int value);
	/**
	@brief 获得int类型值
	@param section 字段名
	@param name 键名
	@param def_val 默认值
	@return 如果找到指定的键值返回该值否则返回defval
	*/
	GGE_EXPORT int			GGE_CALL Ini_GetInt(const char *section, const char *name, int def_val);
	/**
	@brief 将float类型值写入配置文件
	@param section 字段名
	@param name 键名
	@param value 键值
	*/
	GGE_EXPORT void			GGE_CALL Ini_SetFloat(const char *section, const char *name, float value);
	/**
	@brief 获得float类型值
	@param section 字段名
	@param name 键名
	@param def_val 默认值
	@return 如果找到指定的键值返回该值否则返回defval
	*/
	GGE_EXPORT float		GGE_CALL Ini_GetFloat(const char *section, const char *name, float def_val);
	/**
	@brief 将字符串写入配置文件
	@param section 字段名
	@param name 键名
	@param value 键值
	*/
	GGE_EXPORT void			GGE_CALL Ini_SetString(const char *section, const char *name, const char *value);
	/**
	@brief 获得字符串 
	@param section 字段名
	@param name 键名
	@param def_val 默认值
	@return 如果找到指定的键值返回该值否则返回defval
	*/
	GGE_EXPORT const char*	GGE_CALL Ini_GetString(const char *section, const char *name, const char *def_val);

	/**
	@brief 返回游戏时间，该时间由Timer_GetDelta()函数累加得到，每帧刷新一次，精确到0.001秒
	@return 返回游戏时间
	*/
	GGE_EXPORT float		GGE_CALL Timer_GetTime();
	/**
	@brief 返回当前时间戳，该函数返回的时间戳是实时刷新的，一帧内两次调用该函数，返回值可能不同，精确到1毫秒
	@return 返回当前时间戳
	*/
	GGE_EXPORT gUInt		GGE_CALL Timer_GetTick();
	/**
	@brief 返回上一帧所用时间
	@return 上一帧所用时间，精确到0.001秒
	*/
	GGE_EXPORT float		GGE_CALL Timer_GetDelta();
	/**
	@brief 返回Fps
	@return Fps
	*/
	GGE_EXPORT int			GGE_CALL Timer_GetFPS();

	/**
	@brief 设置随机数种子
	@param seed 随机数种子，为0时自动设置
	*/
	GGE_EXPORT void			GGE_CALL Random_Seed(int seed = 0);
	/**
	@brief 返回int型随机数
	@param min 最小值
	@param max 最大值
	@return int型min到max间的随机数，包括min和max
	*/
	GGE_EXPORT int			GGE_CALL Random_Int(int min, int max);
	/**
	@brief 返回float型随机数
	@param min 最小值
	@param max 最大值
	@return float型min到max间的随机数，包括min和max
	*/
	GGE_EXPORT float		GGE_CALL Random_Float(float min, float max);

	/**
	@brief 以指定颜色清除屏幕
	@param color 清除屏幕颜色
	*/
	GGE_EXPORT void			GGE_CALL Graph_Clear(gUInt color = 0xFF000000);
	/**
	@brief 开始渲染
	@param texture 若该纹理为渲染目标纹理，则渲染到该纹理，否则渲染到默认渲染目标
	@return 调用成功返回true
	*/
	GGE_EXPORT bool			GGE_CALL Graph_BeginScene(ggeTexture *texture = 0);
	/**
	@brief 结束渲染
	*/
	GGE_EXPORT void			GGE_CALL Graph_EndScene();
	/**
	@brief 将渲染目标复制到指定的纹理
	@param texture 当前渲染目标内容将复制到该纹理，该纹理必须是渲染目标纹理
	*/
	GGE_EXPORT void			GGE_CALL Graph_GetRenderTarget(ggeTexture *texture);
	/**
	@brief 从点(x1,y1)至(x2,y2)画线
	@param x1 起始点x坐标
	@param y1 起始点y坐标
	@param x2 结束点x坐标
	@param y2 结束点y坐标
	@param color 指定线的颜色
	@param z Z轴次序
	*/
	GGE_EXPORT void			GGE_CALL Graph_RenderLine(float x1, float y1, float x2, float y2, gUInt color = 0xFFFFFFFF, float z = 0.5f);
	/**
	@brief 从点(x1,y1)至(x2,y2)画矩形
	@param x1 起始点x坐标
	@param y1 起始点y坐标
	@param x2 结束点x坐标
	@param y2 结束点y坐标
	@param color 指定线的颜色
	@param z Z轴次序
	*/
	GGE_EXPORT void			GGE_CALL Graph_RenderQuad(float x1, float y1, float x2, float y2, gUInt color = 0xFFFFFFFF, float z = 0.5f);
	/**
	@brief 设置剪裁区域
	@param x 剪裁区域左上角x坐标
	@param y 剪裁区域左上角y坐标
	@param width  剪裁区域宽度
	@param height 剪裁区域高度
	@note 若所有参数为0，则设置剪裁区域为整个渲染目标,当渲染目标变化时也会重置为整个渲染目标
	*/
	GGE_EXPORT void			GGE_CALL Graph_SetClipping(int x = 0, int y = 0, int width = 0, int height = 0);
	/**
	@brief 设置屏幕变换矩阵
	@param x 中心点x坐标
	@param y 中心点y坐标
	@param dx 中心点x坐标偏移量 
	@param dy 中心点y坐标偏移量 
	@param rot 旋转角度(单位:弧度)
	@param hscale 横坐标缩放比例
	@param vscale 纵坐标缩放比例
	@note 若所有参数为0则重置为默认值，当渲染目标变化时也会重置为默认值
	*/
	GGE_EXPORT void			GGE_CALL Graph_SetTransform(float x = 0.0f, float y = 0.0f, float dx = 0.0f, float dy = 0.0f, float rot = 0.0f, float hscale = 1.0f, float vscale = 1.0f); 
	/**
	@brief 保存屏幕截图
	@param filename 保存文件名
	@param imageFormat 文件格式(该函数不支持dds压缩格式)
	*/
	GGE_EXPORT void			GGE_CALL Graph_Snapshot(const char *filename, GGE_IMAGE_FORMAT imageFormat = IMAGE_PNG);
	/**
	@brief 渲染自定义图元
	@param primType 图元类型
	@param vt 图元数组
	@param primNum 图元数量
	@param tex 渲染图元时使用的纹理，如果没有可以传0
	@param blend 纹理混合模式，可用"|"结合
	@param bFilter 是否开启纹理过滤
	@see BLEND_MODE
	*/
	GGE_EXPORT void			GGE_CALL Graph_RenderBatch(PRIM_TYPE primType, ggeVertex *vt, int primNum, ggeTexture *tex, int blend = BLEND_DEFAULT, bool bFilter = false);

	/**
	@brief 获得鼠标X坐标
	@return 鼠标X坐标
	*/
	GGE_EXPORT float 		GGE_CALL Input_GetMousePosX();
	/**
	@brief 获得鼠标Y坐标
	@return 鼠标Y坐标
	*/
	GGE_EXPORT float 		GGE_CALL Input_GetMousePosY();
	/**
	@brief 设置鼠标位置
	@param x 鼠标x轴坐标
	@param y 鼠标y轴坐标
	*/
	GGE_EXPORT void			GGE_CALL Input_SetMousePos(float x, float y);
	/**
	@brief 获得鼠标滚轮位移
	@return 鼠标滚轮位移
	*/
	GGE_EXPORT int			GGE_CALL Input_GetMouseWheel();
	/**
	@brief 鼠标是否在窗口内
	@return 如果鼠标在窗口内返回true，否则返回false
	*/
	GGE_EXPORT bool			GGE_CALL Input_IsMouseOver();
	/**
	@brief 是否有按键正被按住
	@param key 要检测的按键键盘扫描码
	@return 有则返回true，否则返回false
	*/
	GGE_EXPORT bool			GGE_CALL Input_IsKeyPress(int key);
	/**
	@brief 是否有按键抬起
	@param key 要检测的按键键盘扫描码
	@return 有则返回true，否则返回false
	*/
	GGE_EXPORT bool			GGE_CALL Input_IsKeyUp(int key);
	/**
	@brief 是否有按键按下
	@param key 要检测的按键键盘扫描码
	@return 有则返回true，否则返回false
	*/
	GGE_EXPORT bool			GGE_CALL Input_IsKeyDown(int key);
	/**
	@brief 是否有鼠标按键正被按住
	@param key 要检测的鼠标按键键盘扫描码
	@return 有则返回true，否则返回false
	*/
	GGE_EXPORT bool			GGE_CALL Input_IsMousePress(int key);
	/**
	@brief 是否有鼠标按键抬起
	@param key 要检测的鼠标按键键盘扫描码
	@return 有则返回true，否则返回false
	*/
	GGE_EXPORT bool			GGE_CALL Input_IsMouseUp(int key);
	/**
	@brief 是否有鼠标按键按下
	@param key 要检测的鼠标按键键盘扫描码
	@return 有则返回true，否则返回false
	*/
	GGE_EXPORT bool			GGE_CALL Input_IsMouseDown(int key);
	/**
	@brief 返回当前按下的按键的键值
	@return 当前按下的按键的键值，若无键按下返回-1
	@note 可以像如下方式使用该函数：\n
	\code switch (Input_GetKey())
	{
	case GGEK_A:
		fnt->Print(0.0f, 0.0f, "A Key Down!");
		break;
	} \endcode
	*/
	GGE_EXPORT int			GGE_CALL Input_GetKey();
	/**
	@brief 返回当前输入的字符或字符串
	@return 当前输入的字符或字符串,支持中文输入法
	*/
	GGE_EXPORT const char*	GGE_CALL Input_GetChar();

	/**
	@brief 载入视频文件
	@return 成功返回true，否则返回false
	*/
	GGE_EXPORT bool			GGE_CALL Video_LoadFromFile(const char *filename);
	/**
	@brief 若载入视频文件成功，调用该函数开始播放视频文件
	*/
	GGE_EXPORT void			GGE_CALL Video_Play();
	/**
	@brief 暂停播放，再执行一次从暂停的地方继续播放
	*/
	GGE_EXPORT void			GGE_CALL Video_Pause();
	/**
	@brief 停止播放视频文件并释放资源
	*/
	GGE_EXPORT void			GGE_CALL Video_Stop();
	/**
	@brief 渲染视频文件，如果视频文件大小与窗口大小不一致将被拉伸
	*/
	GGE_EXPORT void			GGE_CALL Video_Render();
	/**
	@brief 在指定位置和尺寸渲染视频文件
	@param x x坐标
	@param y y坐标
	@param width 宽度
	@param height 高度
	*/
	GGE_EXPORT void			GGE_CALL Video_RenderEx(float x, float y, float width, float height);
	/**
	@brief 测试视频文件是否正在播放
	@return 正在播放返回true，否则返回false
	*/
	GGE_EXPORT bool			GGE_CALL Video_IsPlaying();
	/**
	@brief 返回视频文件已播放时间
	@return 视频文件已播放时间
	*/
	GGE_EXPORT double		GGE_CALL Video_GetPlayingTime();
	/**
	@brief 设置视频文件音量
	@param volume 音量
	*/
	GGE_EXPORT void			GGE_CALL Video_SetVolume(int volume);


	/** @} */
}

