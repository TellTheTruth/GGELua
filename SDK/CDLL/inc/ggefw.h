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
\brief Ӧ�ó����ܻ���\n
	Ҫ����һ���򵥵���ϷӦ�ó���ֻ��̳�ggeApplication���ṩһ��ʵ�����ɡ�

	ʾ����
	@code
	class CGameMain : public ggeApplication
	{
	public:
		void OnUpdate(float dt)
		{
		}

		void OnRender()
		{
			Graph_BeginScene();
			Graph_Clear();
			//Draw Something...
			Graph_EndScene();
		}
	};

	int WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
	{
		CGameMain GameMain;
		GameMain.Start();

		return 0;
	}
	@endcode
*/

#pragma once
#include "ggecommon.h"

namespace gge
{
	/// Ӧ�ó�����
	class GGE_EXPORT ggeApplication
	{
	public:
		ggeApplication();
		virtual ~ggeApplication()				{}

	public:
		/// ��Ϸ����ǰ�ú��������ã��������false��Ϸ�˳�
		virtual bool OnConfig()					{ return true; }

		/// ��Ϸ������ú��������ã��������false��Ϸ�˳�
		virtual bool OnInitiate()				{ return true; }

		/// ��Ϸ�˳�ʱǰ�ú���������
		virtual void OnRelease()				{}

		/// ˢ��
		virtual void OnUpdate(float dt) = 0;

		/// ��Ⱦ
		virtual void OnRender() = 0;

		/// ����Dumpʱ���ã�dirΪDump����Ŀ¼�����Դ˴�д��һЩ������Ϣ��log�������ʾ���ڵ�
		virtual void OnMiniDump(const char *dir){}

	public:
		/// ��ʼ����
		void Start();

		/// �˳���Ϸ
		void Exit();

		/// �Ƿ������˳���Ϸ
		bool IsExit();

		/// �л�αȫ��������ģʽ����Ч������System_Initiate()֮�󷽿ɵ���
		void SwitchSimFullScreen(bool bEnable);

		/// �Ƿ���αȫ��
		bool IsSimFullScreen();

		/// ����MiniDump���������MiniDump���뱣֤����Ŀ¼��ϵͳĿ¼�´���"dbghelp.dll"
		void EnableMiniDump();

	private:
		bool m_bExit;
		bool m_bSimFS;

		bool Update(float dt);
		friend class ggeAppInstance;
	};
}