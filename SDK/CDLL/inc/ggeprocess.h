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
\brief Processģ�飬������Ϸ�еĲ��д���
*/

#pragma once
#include "ggecommon.h"
#include "ggerefcounter.h"

namespace gge
{
	class ggeProcessManager;

	/// ���̻���
	class ggeProcess : public ggeRefCounter
	{
	public:
		ggeProcess():m_type(-1), m_bKill(false), m_bActive(true), m_bPause(false), 
			m_bInitialize(false), m_bAttache(false), m_manager(0), m_next(0) {}

		virtual ~ggeProcess()					{ GGE_RELEASE(m_next); }

		/// ɱ����ǰ����
		virtual void	Kill()					{ m_bKill = true; }
		/// �����Ƿ�����
		virtual bool	IsDead()				{ return m_bKill; }

		/// ���ý������ͣ�Ĭ��Ϊ-1
		virtual void	SetType(int type)		{ m_type = type; }
		/// �õ���������
		virtual int		GetType()				{ return m_type; }

		/// ���ý����Ƿ񼤻�
		virtual void	SetActive(bool b)		{ m_bActive = b; }
		/// �����Ƿ񼤻�
		virtual bool	IsActive()				{ return m_bActive; }

		/// ���̹���������/�Ƴ��ý���ʱ����
		virtual void	SetAttached(bool b)		{ m_bAttache = b; }
		/// �����Ƿ񱻼ӵ����̹�����
		virtual bool	IsAttached()			{ return m_bAttache;}

		/// �л���ͣ
		virtual void	TogglePause()			{ m_bPause = !m_bPause; }
		/// �Ƿ���ͣ
		virtual bool	IsPaused()				{ return m_bPause; }

		/// �����Ƿ��ѳ�ʼ��
		virtual bool	IsInitialized()			{ return !m_bInitialize; }

		/// �����¸�����
		virtual ggeProcess*	GetNext()			{ return m_next; }
		/** @brief ���õ�ǰ���̽�������һ��Ҫִ�еĽ���
		    @note ����ֵΪ�¸����̣�ʾ����\n
		    npcProcess->SetNext(new WalkToDoor)->SetNext(new OpenDoor)->SetNext(new WalkToTable);
		*/
		virtual ggeProcess*	SetNext(ggeProcess *next) { if (next) next->AddRef(); m_next = next; return next; }

		/// ˢ��ʱ����
		virtual void	OnUpdate(float dt)		{}
		/// ��ʼ��ʱ����
		virtual void	OnInitialize()			{}
		/** @brief �յ���Ϣʱ���ã�����true���ʾ��Ϣ�Ѵ������ٴ�����Ľ���\n
		    @param msgType ��Ϣ����
			@param msgData ��Ϣ����
		*/
		virtual bool	OnMessage(int msgType, void *msgData) { return false; }

		/// ���ظý��̵Ĺ�����
		ggeProcessManager* GetManager()			{ return m_manager; }

	private:
		int				m_type;
		bool			m_bKill;
		bool			m_bActive;
		bool			m_bPause;
		bool			m_bInitialize;
		bool			m_bAttache;
		ggeProcess		*m_next;

	private:	
		ggeProcessManager	*m_manager;
		ggeProcess(const ggeProcess &rhs);
		ggeProcess& operator = (const ggeProcess& val);
		friend class ggeProcessManagerImp;
	};

	/// ���̹�����
	class ggeProcessManager : public ggeRefCounter
	{
	public:
		/// ����һ�����̵�������
		virtual void	Attach(ggeProcess *process) = 0;

		/// ˢ�¹�����
		virtual void	Update(float dt) = 0;

		/// ��ս��̱�
		virtual void	ClearProcessList() = 0;

		/// ���̱����Ƿ��н���
		virtual bool	HasProcesses() = 0;

		/// ���ĳ���ͽ���������typeΪ-1�������н�����
		virtual int		GetProcessCount(int type = -1) = 0;

		/// �Ƿ���ָ�����͵Ľ��̱�����
		virtual bool	IsProcessActive(int type) = 0;

		/// ɱ������ָ�����͵Ľ���
		virtual void	KillProcess(int type) = 0;

		/// ������Ϣ��ָ�����͵Ľ��̣�����Ϣ�������򷵻�true��type = -1�򷢸����н���
		virtual bool	SendMsg(int msgType, void *msgData = 0, int type = -1) = 0;

		/// ������Ϣ����Ϣ���У�������Ϣ���´ε���Updateʱ���͵�ָ�����̡�type = -1�򷢸����н���
		virtual void	PostMsg(int msgType, void *msgData = 0, int type = -1) = 0;

		/// �����û�����
		virtual void	SetUserDate(void *data) = 0;

		/// ����û�����
		virtual void*	GetUserData() = 0;
	};

	/// ����״̬������
	GGE_EXPORT ggeProcessManager* GGE_CALL Process_CreateManager();
}