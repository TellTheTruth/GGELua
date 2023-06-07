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
\brief ��Ϸ״̬������
*/

#pragma once
#include "ggecommon.h"
#include "ggerefcounter.h"

namespace gge
{
	class ggeGameStateManager;

	/// ״̬����
	class ggeGameState : public ggeRefCounter
	{
	public:
		ggeGameState()					{ m_manager = 0; }
		virtual ~ggeGameState()			{}

		/// �����״̬ʱ����
		virtual void OnEnter()			{}

		/// �뿪��״̬ʱ����
		virtual void OnLeave()			{}

		/// ˢ��
		virtual void OnUpdate(float dt)	{}

		/// ��Ⱦ
		virtual void OnRender()			{}

		/** @brief �յ���Ϣʱ���ã�����true���ʾ��Ϣ�Ѵ������ٴ������״̬
		    @param msgType ��Ϣ����
			@param msgData ��Ϣ����
		*/
		virtual bool OnMessage(int msgType, void *msgData = 0) { return false; }

		/// ���ظ�״̬�Ĺ�����
		ggeGameStateManager* GetManager()		{ return m_manager; }

	private:
		ggeGameStateManager	*m_manager;
		friend class	ggeGameStateManagerImp;
	};

	/// ״̬������
	class ggeGameStateManager : public ggeRefCounter
	{
	public:
		/// ����״̬
		virtual bool AddState(const char *stateName, ggeGameState *state) = 0;

		/// ����״̬
		virtual ggeGameState* GetState(const char *stateName) = 0;

		/// �Ƴ�״̬
		virtual void RemoveState(const char *stateName) = 0;

		/// �Ƴ�״̬
		virtual void RemoveState(ggeGameState *state) = 0;

		/// �Ƴ�����״̬
		virtual void RemoveAllState() = 0;

		/// �ı䵱ǰ״̬
		virtual bool ChangeState(const char *stateName) = 0;

		/// ���ص�ǰ״̬
		virtual ggeGameState* GetCurrentState() = 0;

		/// ˢ��
		virtual void Update(float dt) = 0;

		/// ��Ⱦ
		virtual void Render() = 0;

		/** @brief ������Ϣ
			@param stateName ������Ϣ��״̬�������Ϊ0���͸�����״̬
		    @param msgType ��Ϣ����
			@param msgData ��Ϣ����
		*/
		virtual bool SendMsg(const char *stateName = 0, int msgType = 0, void *msgData = 0) = 0;
	};

	/// ����״̬������
	GGE_EXPORT ggeGameStateManager* GGE_CALL GameState_CreateManager();
}