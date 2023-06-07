/*
**  =======================================================
**                Galaxy2D Game Engine       
**                                
**       ��Ȩ����(c) 2005 ����. ��������Ȩ��.
**    ��ҳ��ַ: http://www.cppblog.com/jianguhan/
**			 ��������: jianguhan@126.com
**  =======================================================
*/

/** \file
\brief ��������
*/

#pragma once
#include "ggecommon.h"

namespace gge
{
	/// �汾��
	#define GGE_VERSION 41

	/** @name ��������
	*  @{
	*/

	/**
	@brief ��������
	@param ver �汾��
	@return �ɹ�����true��ʧ�ܷ���false
	*/
	GGE_EXPORT bool			GGE_CALL Engine_Create(int ver = GGE_VERSION);
	/**
	@brief �ͷ�����
	*/
	GGE_EXPORT void			GGE_CALL Engine_Release();

	/**
	@brief ��ʼ��ϵͳ
	@return �ɹ�����true��ʧ�ܷ���false
	@note ϵͳδ��ʼ��ǰֻ��System_SetState������Ч
	*/
	GGE_EXPORT bool			GGE_CALL System_Initiate();
	/**
	@brief ϵͳ��ʼ����
	@return ������������true�����򷵻�false
	@note ���иú���ǰ��������֡����
	*/
	GGE_EXPORT bool			GGE_CALL System_Start();

	/**
	@brief ����ϵͳ״̬
	@param state ״̬
	@param value ״ֵ̬
	*/
	GGE_EXPORT void			GGE_CALL System_SetState(GGE_STATE_INT state, int value);
	/**
	@brief ����ϵͳ״̬
	@param state ״̬
	@param value ״ֵ̬
	*/
	GGE_EXPORT void			GGE_CALL System_SetState(GGE_STATE_BOOL state, bool value);
	/**
	@brief ����ϵͳ״̬
	@param state ״̬
	@param value ״ֵ̬
	*/
	GGE_EXPORT void			GGE_CALL System_SetState(GGE_STATE_CHAR state, const char *value);
	/**
	@brief ����ϵͳ״̬
	@param state ״̬
	@param value ״ֵ̬
	*/
	GGE_EXPORT void			GGE_CALL System_SetState(GGE_STATE_HWND state, HWND value);
	/**
	@brief ����ϵͳ״̬
	@param state ״̬
	@param value ״ֵ̬
	*/
	GGE_EXPORT void			GGE_CALL System_SetState(GGE_STATE_BOOL_FUN state, GGE_BOOLFUN value);
	/**
	@brief ����ϵͳ״̬
	@param state ״̬
	@param value ״ֵ̬
	*/
	GGE_EXPORT void			GGE_CALL System_SetState(GGE_STATE_MSG_FUN state, GGE_MSGFUN value);

	/**
	@brief ����ϵͳ״̬
	@param state ״̬
	*/
	GGE_EXPORT int			GGE_CALL System_GetState(GGE_STATE_INT state);
	/**
	@brief ����ϵͳ״̬
	@param state ״̬
	*/
	GGE_EXPORT bool			GGE_CALL System_GetState(GGE_STATE_BOOL state);
	/**
	@brief ����ϵͳ״̬
	@param state ״̬
	*/
	GGE_EXPORT const char*	GGE_CALL System_GetState(GGE_STATE_CHAR state);
	/**
	@brief ����ϵͳ״̬
	@param state ״̬
	*/
	GGE_EXPORT HWND			GGE_CALL System_GetState(GGE_STATE_HWND state);
	/**
	@brief ����ϵͳ״̬
	@param state ״̬
	*/
	GGE_EXPORT GGE_BOOLFUN	GGE_CALL System_GetState(GGE_STATE_BOOL_FUN state);
	/**
	@brief ����ϵͳ״̬
	@param state ״̬
	*/
	GGE_EXPORT GGE_MSGFUN	GGE_CALL System_GetState(GGE_STATE_MSG_FUN state);

	/**
	@brief д�����Log
	@param format log��¼
	*/
	GGE_EXPORT void			GGE_CALL System_Log(const char *format, ...);
	/**
	@brief �����ⲿ��ִ���ļ����URL
	@param url ��ִ���ļ���URL
	*/
	GGE_EXPORT bool			GGE_CALL System_Launch(const char *url);

	/**
	@brief ��ȡ��Դ�ļ�
	@param filename ��Դ�ļ���
	@param size ��ȡ�ļ��ɹ����ļ���Сд��ò���
	@return ��ȡ�ɹ�������Դ�ڴ�ָ�룬���򷵻�0
	@note �ú����Ȳ��Ұ󶨵�ZIPѹ������û�ҵ�����ҵ�ǰĿ¼�����Ƶ��ļ�
	*/
	GGE_EXPORT void*		GGE_CALL Resource_Load(const char *filename, gULong *size = 0);
	/**
	@brief ��ȡ��Դ�ļ�
	@param filename ��Դ�ļ���
	@param buf ����Դ�ļ���ȡ��ָ�����ڴ���
	@param size ָ���ڴ��С������ļ���С�����Ĳ�����С�����������ݽ�������
	@return ��ȡ�ļ���С����ȡʧ�ܷ���0
	@note �ú����Ȳ��Ұ󶨵�ZIPѹ������û�ҵ�����ҵ�ǰĿ¼�����Ƶ��ļ�
	*/
	GGE_EXPORT gULong		GGE_CALL Resource_LoadTo(const char *filename, void *buf, gULong size);
	/**
	@brief ��ȡ��Դ�ļ���С
	@param filename ��Դ�ļ���
	@return ��Դ�ļ���С
	*/
	GGE_EXPORT gULong		GGE_CALL Resource_GetSize(const char *filename);
	/**
	@brief ������Դ�ļ��Ƿ����
	@param filename ��Դ�ļ���
	@return ��Դ�ļ��Ƿ���ڷ���true�����򷵻�false
	*/
	GGE_EXPORT bool			GGE_CALL Resource_IsExist(const char *filename);
	/**
	@brief �ͷ���Դ
	@param res Resource_Load()�����������Դ
	*/
	GGE_EXPORT void			GGE_CALL Resource_Free(void *res);
	/**
	@brief ��ZIPѹ����
	@param filename ѹ�����ļ���
	@param password ѹ��������
	@return �󶨳ɹ�����true�����򷵻�false
	@note ���ж��ѹ���������ΰ󶨼��ɡ������ļ�ʱ�ӵ�һ��ѹ������ʼ���ҵ��ļ��������أ����Ժ���ѹ�����е�ͬ���ļ�
	*/
	GGE_EXPORT bool			GGE_CALL Resource_AttachPack(const char *filename, const char *password = 0);
	/**
	@brief �Ƴ��󶨵�ѹ����
	@param filename ѹ�����ļ���
	*/
	GGE_EXPORT void			GGE_CALL Resource_RemovePack(const char *filename = 0);
	/**
	@brief �����Դ����·��
	��Resource_Load�ڵ�ǰĿ¼�޷��ҵ��ļ������Զ�ת����ӵ�·���в��Ҹ��ļ�������·������Ӷ��������ɾ��
	@param pathname ��Դ����·��
	*/
	GGE_EXPORT void			GGE_CALL Resource_AddPath(const char *pathname);
	/**
	@brief ����ZIPѹ������һ���ļ����ļ���
	@param filename ѹ�����ļ�������
	@return ������óɹ������ļ��������򷵻�0
	*/
	GGE_EXPORT const char*	GGE_CALL Resource_GetPackFirstFileName(const char *filename);
	/**
	@brief ����ZIPѹ������һ���ļ����ļ���������Resource_GetPackFirstFileName()��������Ч
	@return ����ҵ���һ���ļ��򷵻��ļ��������򷵻�0
	*/
	GGE_EXPORT const char*	GGE_CALL Resource_GetPackNextFileName();

	/**
	@brief �������ڲ�����ini�ļ�����������ļ��ڵ�ǰĿ¼��Ҫ���ļ���ǰ��"./"�����磺Ini_SetFile("./cfg.ini")
	@param filename �ļ���
	@note �����ļ���ʽ:\n
	;ע��\n
	[�ֶ���]\n
	����=��ֵ\n
	*/
	GGE_EXPORT void			GGE_CALL Ini_SetFile(const char *filename);
	/**
	@brief ��int����ֵд�������ļ�
	@param section �ֶ���
	@param name ����
	@param value ��ֵ
	*/
	GGE_EXPORT void			GGE_CALL Ini_SetInt(const char *section, const char *name, int value);
	/**
	@brief ���int����ֵ
	@param section �ֶ���
	@param name ����
	@param def_val Ĭ��ֵ
	@return ����ҵ�ָ���ļ�ֵ���ظ�ֵ���򷵻�defval
	*/
	GGE_EXPORT int			GGE_CALL Ini_GetInt(const char *section, const char *name, int def_val);
	/**
	@brief ��float����ֵд�������ļ�
	@param section �ֶ���
	@param name ����
	@param value ��ֵ
	*/
	GGE_EXPORT void			GGE_CALL Ini_SetFloat(const char *section, const char *name, float value);
	/**
	@brief ���float����ֵ
	@param section �ֶ���
	@param name ����
	@param def_val Ĭ��ֵ
	@return ����ҵ�ָ���ļ�ֵ���ظ�ֵ���򷵻�defval
	*/
	GGE_EXPORT float		GGE_CALL Ini_GetFloat(const char *section, const char *name, float def_val);
	/**
	@brief ���ַ���д�������ļ�
	@param section �ֶ���
	@param name ����
	@param value ��ֵ
	*/
	GGE_EXPORT void			GGE_CALL Ini_SetString(const char *section, const char *name, const char *value);
	/**
	@brief ����ַ��� 
	@param section �ֶ���
	@param name ����
	@param def_val Ĭ��ֵ
	@return ����ҵ�ָ���ļ�ֵ���ظ�ֵ���򷵻�defval
	*/
	GGE_EXPORT const char*	GGE_CALL Ini_GetString(const char *section, const char *name, const char *def_val);

	/**
	@brief ������Ϸʱ�䣬��ʱ����Timer_GetDelta()�����ۼӵõ���ÿ֡ˢ��һ�Σ���ȷ��0.001��
	@return ������Ϸʱ��
	*/
	GGE_EXPORT float		GGE_CALL Timer_GetTime();
	/**
	@brief ���ص�ǰʱ������ú������ص�ʱ�����ʵʱˢ�µģ�һ֡�����ε��øú���������ֵ���ܲ�ͬ����ȷ��1����
	@return ���ص�ǰʱ���
	*/
	GGE_EXPORT gUInt		GGE_CALL Timer_GetTick();
	/**
	@brief ������һ֡����ʱ��
	@return ��һ֡����ʱ�䣬��ȷ��0.001��
	*/
	GGE_EXPORT float		GGE_CALL Timer_GetDelta();
	/**
	@brief ����Fps
	@return Fps
	*/
	GGE_EXPORT int			GGE_CALL Timer_GetFPS();

	/**
	@brief �������������
	@param seed ��������ӣ�Ϊ0ʱ�Զ�����
	*/
	GGE_EXPORT void			GGE_CALL Random_Seed(int seed = 0);
	/**
	@brief ����int�������
	@param min ��Сֵ
	@param max ���ֵ
	@return int��min��max��������������min��max
	*/
	GGE_EXPORT int			GGE_CALL Random_Int(int min, int max);
	/**
	@brief ����float�������
	@param min ��Сֵ
	@param max ���ֵ
	@return float��min��max��������������min��max
	*/
	GGE_EXPORT float		GGE_CALL Random_Float(float min, float max);

	/**
	@brief ��ָ����ɫ�����Ļ
	@param color �����Ļ��ɫ
	*/
	GGE_EXPORT void			GGE_CALL Graph_Clear(gUInt color = 0xFF000000);
	/**
	@brief ��ʼ��Ⱦ
	@param texture ��������Ϊ��ȾĿ����������Ⱦ��������������Ⱦ��Ĭ����ȾĿ��
	@return ���óɹ�����true
	*/
	GGE_EXPORT bool			GGE_CALL Graph_BeginScene(ggeTexture *texture = 0);
	/**
	@brief ������Ⱦ
	*/
	GGE_EXPORT void			GGE_CALL Graph_EndScene();
	/**
	@brief ����ȾĿ�긴�Ƶ�ָ��������
	@param texture ��ǰ��ȾĿ�����ݽ����Ƶ��������������������ȾĿ������
	*/
	GGE_EXPORT void			GGE_CALL Graph_GetRenderTarget(ggeTexture *texture);
	/**
	@brief �ӵ�(x1,y1)��(x2,y2)����
	@param x1 ��ʼ��x����
	@param y1 ��ʼ��y����
	@param x2 ������x����
	@param y2 ������y����
	@param color ָ���ߵ���ɫ
	@param z Z�����
	*/
	GGE_EXPORT void			GGE_CALL Graph_RenderLine(float x1, float y1, float x2, float y2, gUInt color = 0xFFFFFFFF, float z = 0.5f);
	/**
	@brief �ӵ�(x1,y1)��(x2,y2)������
	@param x1 ��ʼ��x����
	@param y1 ��ʼ��y����
	@param x2 ������x����
	@param y2 ������y����
	@param color ָ���ߵ���ɫ
	@param z Z�����
	*/
	GGE_EXPORT void			GGE_CALL Graph_RenderQuad(float x1, float y1, float x2, float y2, gUInt color = 0xFFFFFFFF, float z = 0.5f);
	/**
	@brief ���ü�������
	@param x �����������Ͻ�x����
	@param y �����������Ͻ�y����
	@param width  ����������
	@param height ��������߶�
	@note �����в���Ϊ0�������ü�������Ϊ������ȾĿ��,����ȾĿ��仯ʱҲ������Ϊ������ȾĿ��
	*/
	GGE_EXPORT void			GGE_CALL Graph_SetClipping(int x = 0, int y = 0, int width = 0, int height = 0);
	/**
	@brief ������Ļ�任����
	@param x ���ĵ�x����
	@param y ���ĵ�y����
	@param dx ���ĵ�x����ƫ���� 
	@param dy ���ĵ�y����ƫ���� 
	@param rot ��ת�Ƕ�(��λ:����)
	@param hscale ���������ű���
	@param vscale ���������ű���
	@note �����в���Ϊ0������ΪĬ��ֵ������ȾĿ��仯ʱҲ������ΪĬ��ֵ
	*/
	GGE_EXPORT void			GGE_CALL Graph_SetTransform(float x = 0.0f, float y = 0.0f, float dx = 0.0f, float dy = 0.0f, float rot = 0.0f, float hscale = 1.0f, float vscale = 1.0f); 
	/**
	@brief ������Ļ��ͼ
	@param filename �����ļ���
	@param imageFormat �ļ���ʽ(�ú�����֧��ddsѹ����ʽ)
	*/
	GGE_EXPORT void			GGE_CALL Graph_Snapshot(const char *filename, GGE_IMAGE_FORMAT imageFormat = IMAGE_PNG);
	/**
	@brief ��Ⱦ�Զ���ͼԪ
	@param primType ͼԪ����
	@param vt ͼԪ����
	@param primNum ͼԪ����
	@param tex ��ȾͼԪʱʹ�õ��������û�п��Դ�0
	@param blend ������ģʽ������"|"���
	@param bFilter �Ƿ����������
	@see BLEND_MODE
	*/
	GGE_EXPORT void			GGE_CALL Graph_RenderBatch(PRIM_TYPE primType, ggeVertex *vt, int primNum, ggeTexture *tex, int blend = BLEND_DEFAULT, bool bFilter = false);

	/**
	@brief ������X����
	@return ���X����
	*/
	GGE_EXPORT float 		GGE_CALL Input_GetMousePosX();
	/**
	@brief ������Y����
	@return ���Y����
	*/
	GGE_EXPORT float 		GGE_CALL Input_GetMousePosY();
	/**
	@brief �������λ��
	@param x ���x������
	@param y ���y������
	*/
	GGE_EXPORT void			GGE_CALL Input_SetMousePos(float x, float y);
	/**
	@brief ���������λ��
	@return ������λ��
	*/
	GGE_EXPORT int			GGE_CALL Input_GetMouseWheel();
	/**
	@brief ����Ƿ��ڴ�����
	@return �������ڴ����ڷ���true�����򷵻�false
	*/
	GGE_EXPORT bool			GGE_CALL Input_IsMouseOver();
	/**
	@brief �Ƿ��а���������ס
	@param key Ҫ���İ�������ɨ����
	@return ���򷵻�true�����򷵻�false
	*/
	GGE_EXPORT bool			GGE_CALL Input_IsKeyPress(int key);
	/**
	@brief �Ƿ��а���̧��
	@param key Ҫ���İ�������ɨ����
	@return ���򷵻�true�����򷵻�false
	*/
	GGE_EXPORT bool			GGE_CALL Input_IsKeyUp(int key);
	/**
	@brief �Ƿ��а�������
	@param key Ҫ���İ�������ɨ����
	@return ���򷵻�true�����򷵻�false
	*/
	GGE_EXPORT bool			GGE_CALL Input_IsKeyDown(int key);
	/**
	@brief �Ƿ�����갴��������ס
	@param key Ҫ������갴������ɨ����
	@return ���򷵻�true�����򷵻�false
	*/
	GGE_EXPORT bool			GGE_CALL Input_IsMousePress(int key);
	/**
	@brief �Ƿ�����갴��̧��
	@param key Ҫ������갴������ɨ����
	@return ���򷵻�true�����򷵻�false
	*/
	GGE_EXPORT bool			GGE_CALL Input_IsMouseUp(int key);
	/**
	@brief �Ƿ�����갴������
	@param key Ҫ������갴������ɨ����
	@return ���򷵻�true�����򷵻�false
	*/
	GGE_EXPORT bool			GGE_CALL Input_IsMouseDown(int key);
	/**
	@brief ���ص�ǰ���µİ����ļ�ֵ
	@return ��ǰ���µİ����ļ�ֵ�����޼����·���-1
	@note ���������·�ʽʹ�øú�����\n
	\code switch (Input_GetKey())
	{
	case GGEK_A:
		fnt->Print(0.0f, 0.0f, "A Key Down!");
		break;
	} \endcode
	*/
	GGE_EXPORT int			GGE_CALL Input_GetKey();
	/**
	@brief ���ص�ǰ������ַ����ַ���
	@return ��ǰ������ַ����ַ���,֧���������뷨
	*/
	GGE_EXPORT const char*	GGE_CALL Input_GetChar();

	/**
	@brief ������Ƶ�ļ�
	@return �ɹ�����true�����򷵻�false
	*/
	GGE_EXPORT bool			GGE_CALL Video_LoadFromFile(const char *filename);
	/**
	@brief ��������Ƶ�ļ��ɹ������øú�����ʼ������Ƶ�ļ�
	*/
	GGE_EXPORT void			GGE_CALL Video_Play();
	/**
	@brief ��ͣ���ţ���ִ��һ�δ���ͣ�ĵط���������
	*/
	GGE_EXPORT void			GGE_CALL Video_Pause();
	/**
	@brief ֹͣ������Ƶ�ļ����ͷ���Դ
	*/
	GGE_EXPORT void			GGE_CALL Video_Stop();
	/**
	@brief ��Ⱦ��Ƶ�ļ��������Ƶ�ļ���С�봰�ڴ�С��һ�½�������
	*/
	GGE_EXPORT void			GGE_CALL Video_Render();
	/**
	@brief ��ָ��λ�úͳߴ���Ⱦ��Ƶ�ļ�
	@param x x����
	@param y y����
	@param width ���
	@param height �߶�
	*/
	GGE_EXPORT void			GGE_CALL Video_RenderEx(float x, float y, float width, float height);
	/**
	@brief ������Ƶ�ļ��Ƿ����ڲ���
	@return ���ڲ��ŷ���true�����򷵻�false
	*/
	GGE_EXPORT bool			GGE_CALL Video_IsPlaying();
	/**
	@brief ������Ƶ�ļ��Ѳ���ʱ��
	@return ��Ƶ�ļ��Ѳ���ʱ��
	*/
	GGE_EXPORT double		GGE_CALL Video_GetPlayingTime();
	/**
	@brief ������Ƶ�ļ�����
	@param volume ����
	*/
	GGE_EXPORT void			GGE_CALL Video_SetVolume(int volume);


	/** @} */
}

