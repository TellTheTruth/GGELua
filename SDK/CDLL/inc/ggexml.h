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
\brief XMLģ��
*/

#pragma once
#include "ggecommon.h"
#include "ggerefcounter.h"

namespace gge
{
	/// XML�ڵ�
	class GGE_EXPORT ggeXmlNode
	{
	public:
		/// ���캯��
		ggeXmlNode();

		/// ���ýڵ�����
		void			SetName(const char *name);
		/// ���ؽڵ�����
		const char*		GetName() const;
		/// �Ƿ�����Ч�ڵ�
		bool			IsValid() const;

		/**
		@brief ������һ���ڵ�
		@param name ���ָ���˸ò������򷵻���һ��������ò�����ͬ�Ľڵ�
		@return ����ggeXmlNode
		*/
		ggeXmlNode		GetNextNode(const char *name = 0) const;
		/**
		@brief ����ǰһ���ڵ�
		@param name ���ָ���˸ò������򷵻�ǰһ��������ò�����ͬ�Ľڵ�
		@return ����ggeXmlNode
		*/
		ggeXmlNode		GetPreviousNode(const char *name = 0) const;
		/**
		@brief ���ص�һ���ӽڵ�
		@param name ���ָ���˸ò������򷵻ص�һ��������ò�����ͬ���ӽڵ�
		@return ����ggeXmlNode
		*/
		ggeXmlNode		GetFirstChild(const char *name = 0) const;
		/**
		@brief �������һ���ӽڵ�
		@param name ���ָ���˸ò������򷵻����һ��������ò�����ͬ���ӽڵ�
		@return ����ggeXmlNode
		*/
		ggeXmlNode		GetLastChild(const char *name = 0) const;
		
		/**
		@brief ���ײ�����ڵ�
		@param name �ڵ�����
		@param bText �Ƿ���Text���ͽڵ㣬�����Text���ͽڵ㣬�����������Ժ��ӽڵ�
		@return ���ز���Ľڵ�
		*/
		ggeXmlNode		InsertFirstChild(const char *name, bool bText = false);
		/**
		@brief ��ָ���ӽڵ�����ڵ�
		@param after ����λ��
		@param name �ڵ�����
		@param bText �Ƿ���Text���ͽڵ㣬�����Text���ͽڵ㣬�����������Ժ��ӽڵ�
		@return ���ز���Ľڵ�
		*/
		ggeXmlNode		InsertAfterChild(ggeXmlNode after, const char *name, bool bText = false);
		/**
		@brief ��β������ڵ�
		@param name �ڵ�����
		@param bText �Ƿ���Text���ͽڵ㣬�����Text���ͽڵ㣬�����������Ժ��ӽڵ�
		@return ���ز���Ľڵ�
		*/
		ggeXmlNode		InsertEndChild(const char *name, bool bText = false);
		/**
		@brief ɾ��һ���ӽڵ�
		@param remove Ҫɾ���Ľڵ�
		*/
		void			DeleteChild(ggeXmlNode remove);
		/**
		@brief ��������ӽڵ�
		*/
		void			Clear();

		/**
		@brief ��������ֵ
		@param name ������
		@param def Ĭ��ֵ�������ȡ����ʧ�ܾͷ��ظ�ֵ
		*/
		const char*		GetString(const char *name, const char* def = 0) const;
		/**
		@brief ��������ֵ
		@param name ������
		@param def Ĭ��ֵ�������ȡ����ʧ�ܾͷ��ظ�ֵ
		*/
		short			GetShort(const char *name, short def = 0) const;
		/**
		@brief ��������ֵ
		@param name ������
		@param def Ĭ��ֵ�������ȡ����ʧ�ܾͷ��ظ�ֵ
		*/
		int				GetInt(const char *name, int def = 0) const;
		/**
		@brief ��������ֵ
		@param name ������
		@param def Ĭ��ֵ�������ȡ����ʧ�ܾͷ��ظ�ֵ
		*/
		bool			GetBool(const char *name, bool def = false) const;
		/**
		@brief ��������ֵ
		@param name ������
		@param def Ĭ��ֵ�������ȡ����ʧ�ܾͷ��ظ�ֵ
		*/
		float			GetFloat(const char *name, float def = 0) const;
		/**
		@brief ��������ֵ
		@param name ������
		@param def Ĭ��ֵ�������ȡ����ʧ�ܾͷ��ظ�ֵ
		*/
		double			GetDouble(const char *name, double def = 0) const;
		/**
		@brief ��������ֵ
		@param name ������
		@param def Ĭ��ֵ�������ȡ����ʧ�ܾͷ��ظ�ֵ
		*/
		gUShort			GetUShort(const char *name, gUShort def = 0) const;
		/**
		@brief ��������ֵ
		@param name ������
		@param def Ĭ��ֵ�������ȡ����ʧ�ܾͷ��ظ�ֵ
		*/
		gUInt			GetUInt(const char *name, gUInt def = 0) const;

		/**
		@brief ��������ֵ
		@param name ������
		@param val Ҫ���õ�ֵ
		*/
		void			SetString(const char *name, const char *val);
		/**
		@brief ��������ֵ
		@param name ������
		@param val Ҫ���õ�ֵ
		*/
		void			SetShort(const char *name, short val);
		/**
		@brief ��������ֵ
		@param name ������
		@param val Ҫ���õ�ֵ
		*/
		void			SetInt(const char *name, int val);
		/**
		@brief ��������ֵ
		@param name ������
		@param val Ҫ���õ�ֵ
		*/
		void			SetBool(const char *name, bool val);
		/**
		@brief ��������ֵ
		@param name ������
		@param val Ҫ���õ�ֵ
		*/
		void			SetFloat(const char *name, float val);
		/**
		@brief ��������ֵ
		@param name ������
		@param val Ҫ���õ�ֵ
		*/
		void			SetDouble(const char *name, double val);
		/**
		@brief ��������ֵ
		@param name ������
		@param val Ҫ���õ�ֵ
		*/
		void			SetUShort(const char *name, gUShort val);
		/**
		@brief ��������ֵ
		@param name ������
		@param val Ҫ���õ�ֵ
		*/
		void			SetUInt(const char *name, gUInt val);
		/**
		@brief ɾ������
		@param name ������
		*/
		void			DeleteAttribute(const char *name);

	private:
		friend class	ggeXmlElementHelp;
		void			*m_xmlImp;
	};

	/// XML�ļ�����ģ��
	class ggeXmlDocument : public ggeRefCounter
	{
	public:
		/**
		@brief ����XML�ļ������øú�����֮ǰ���ص�ggeXmlNode��ʧЧ
		@param filename �ļ���
		@return �ɹ�����true�����򷵻�false
		*/
		virtual bool			LoadFile(const char *filename) = 0;
		/**
		@brief ����XML�ļ�
		@param filename �ļ���
		@return �ɹ�����true�����򷵻�false
		*/
		virtual bool			SaveFile(const char *filename) = 0;
		/**
		@brief ����XML�ַ��������øú�����֮ǰ���ص�ggeXmlNode��ʧЧ
		@param str Ҫ�������ַ������磺\<node string="string">test_node\</node>
		@return �ɹ�����true�����򷵻�false
		*/
		virtual bool			Parse(const char* str) = 0;

		/**
		@brief ���ظ��ڵ�
		*/
		virtual ggeXmlNode		GetRootNode() = 0;
	};

	/**
	@brief ����XML�ļ�����ģ��
	@return �ɹ�����ggeXmlDocumentָ�룬���򷵻�0
	@note
		\code
		XML�ļ����ݣ�
		<?xml version="1.0" encoding="gb2312" ?>
		<XmlRoot>
			<Val1 Str="Test" />
			<Val2 Num="1" />
			<Val3>
				<ChildNode ID="0" />
				<ChildNode ID="1" />
				<ChildNode ID="2" />
				<ChildNode ID="3" />
			</Val3>
			<Val4>This is a text!</Val4>
		</XmlRoot>
		\endcode
		\code
		ʾ������

		//����Doc
		ggeXmlDocument *doc = Xml_Create();
		//��ȡ���ڵ�
		ggeXmlNode root = doc->GetRootNode();
		root.SetName("XmlRoot");

		//��������ΪVal1�Ľڵ�
		ggeXmlNode valNode = root.InsertEndChild("Val1");
		//��������"Str"��ֵΪ"Test"
		valNode.SetString("Str", "Test");

		//��������ΪVal2�Ľڵ�
		valNode = root.InsertEndChild("Val2");
		//��������"Num"��ֵΪ1
		valNode.SetInt("Num", 1);

		//��������ΪVal3�Ľڵ㣬
		valNode = root.InsertEndChild("Val3");
		for (int i = 0; i < 4; i++)
		{
		//��Val3�ڵ��´����ӽڵ�
		ggeXmlNode childNode = valNode.InsertEndChild("ChildNode");
		//��������"ID"ֵ
		childNode.SetInt("ID", i);
		}

		//��������ΪVal4�Ľڵ㣬
		valNode = root.InsertEndChild("Val4");
		//����һ���ַ����ӽڵ�
		valNode = valNode.InsertEndChild("This is a text!", true);

		//����xml�ļ�
		doc->SaveFile("myxml.xml");

		//��xml�ļ�
		doc->LoadFile("myxml.xml");

		//��ȡ���ڵ�
		root = doc->GetRootNode();

		//���Root��
		cout<<root.GetName()<<endl;
		//���Val1
		cout<<"Val1:"<<root.GetFirstChild("Val1").GetString("Str")<<endl;
		//���Val2
		cout<<"Val2:"<<root.GetFirstChild("Val2").GetInt("Num")<<endl;
		//���Val3
		valNode = root.GetFirstChild("Val3").GetFirstChild("ChildNode");
		while (valNode.IsValid())
		{
		cout<<"Val3:"<<valNode.GetString("ID")<<endl;
		valNode = valNode.GetNextNode();
		}
		//���Val4
		cout<<"Val4:"<<root.GetFirstChild("Val4").GetFirstChild().GetName()<<endl;

		//�ͷ�Doc
		SAFE_RELEASE(doc);
	\endcode
	*/
	GGE_EXPORT ggeXmlDocument* GGE_CALL Xml_Create();
}