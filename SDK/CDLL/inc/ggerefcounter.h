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
\brief ���ü���ģ��
*/

#pragma once

namespace gge
{
	class ggeRefCounter;

	/// �Զ�����Դ�ͷž��,��Ҫ������Դ����,�������ĳЩ��Դ���ڴ�ص�
	class ggeResReleaseHandler
	{
	public:
		/// ��������
		virtual ~ggeResReleaseHandler() {}

		/// �Զ�����Դ�ͷź���
		virtual void OnRelease(ggeRefCounter *p) = 0;
	};

	/// ���ü���ģ��
	class ggeRefCounter
	{
	public:
		/// ���캯��
		ggeRefCounter() : m_refCount(1), m_releaseHandler(0) {}
		/// ��������
		virtual ~ggeRefCounter() {}

		/**
		@brief ������
		@note ����ⲿ��Ҫ�������ø���Դ,����Ҫ�ֶ����øú���,������Դ����ʹ��ʱ���� Release() ����.
		*/
		void AddRef()	{ m_refCount++; }

		/**
		@brief �����ò��ͷ���Դ
		@note һ����˵ֻ��Create*�ӿڴ�����������Դ��Ҫ���øú���,Get*�ӿڷ��ص���Դ����Ҫ���øú������ҷ��ص���Դֻ���ھֲ�����ʹ��,�����Ҫ�������ø���Դ��Ҫ�ֶ����� AddRef() ����
		*/
		void Release()	
		{
			m_refCount--;

			if (m_releaseHandler) 
			{
				m_releaseHandler->OnRelease(this);
			}
			else if (m_refCount == 0)
			{
				delete this;
			}
		}

		/// ����������
		int GetRefCount()
		{
			return m_refCount;
		}

		/// �Զ�����Դ�ͷž��
		void SetReleaseHandler(ggeResReleaseHandler *handler)
		{
			m_releaseHandler = handler;
		}

	private:
		ggeResReleaseHandler	*m_releaseHandler;
		mutable int				m_refCount;
	};
}

