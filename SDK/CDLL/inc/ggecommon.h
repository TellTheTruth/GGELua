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
\brief ���ú궨�弰������
*/

#pragma once

#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#include <windows.h>

/// Galaxy2D Game Engine ���ֿռ�
namespace gge
{
	#ifdef GALAXY2D_DLL
	#define GGE_EXPORT __declspec(dllexport)
	#else
	#define GGE_EXPORT __declspec(dllimport)
	#endif

	#define GGE_CALL  __stdcall
	#define GGE_INLINE inline

	/// ��ȫɾ��ָ��
	#define GGE_DELETE(p)		{ if(p) { delete (p);     (p)=NULL; } }

	/// ��ȫɾ������
	#define GGE_DELETE_ARRAY(p)	{ if(p) { delete[] (p);   (p)=NULL; } }

	/// ��ȫ�ͷ�ָ��
	#define GGE_RELEASE(p)		{ if(p) { (p)->Release(); (p)=NULL; } }

	/// ���ģʽ
	enum BLEND_MODE
	{
		BLEND_COLORMUL	= 0,												///< ��ɫ��
		BLEND_COLORADD	= 1,												///< ��ɫ��
		BLEND_ALPHAMUL	= 0,												///< alpha��
		BLEND_ALPHAADD	= 2,												///< alpha��
		BLEND_NOZWRITE	= 0,												///< �ر�Z������
		BLEND_ZWRITE	= 4,												///< ����Z������
		BLEND_DEFAULT	= BLEND_COLORMUL|BLEND_ALPHAMUL|BLEND_NOZWRITE,		///< Ĭ�ϻ��ģʽ
		BLEND_DEFAULT_Z	= BLEND_COLORMUL|BLEND_ALPHAMUL|BLEND_ZWRITE,		///< Ĭ�Ͽ���Z��������ģʽ
		BLEND_FORCE32BIT = 0x7FFFFFFF,
	};

	/// ���崴��ģʽ
	enum FONT_CREATE_MODE
	{
		FONT_MODE_DEFAULT	= 0,	///< Ĭ��
		FONT_MODE_BOLD		= 1,	///< ����
		FONT_MODE_BORDER	= 2,	///< ������߹��ܣ����뿪���ù������ñ߿���ɫ��������Ч
		FONT_MODE_MONO		= 4,	///< �رտ���ݹ��ܣ�������Ⱦ������������
		FONT_MODE_FORCE32BIT = 0x7FFFFFFF,
	};

	/// �����Ű���ʽ
	enum FONT_ALIGN
	{
		TEXT_LEFT,		///< �����
		TEXT_CENTER,	///< ���ж���
		TEXT_RIGHT,		///< �Ҷ���
		TEXT_FORCE32BIT = 0x7FFFFFFF,
	};

	/// ����ģʽ
	enum ANIMATION_MODE
	{
		ANI_FORWARD		= 0,	///< ��ǰ����
		ANI_REVERSAL	= 1,	///< ��󲥷�
		ANI_REPEAT	 	= 2,	///< ��������
		ANI_NOREPEAT	= 0,	///< ����������
		ANI_LOOP		= 4,	///< ѭ������
		ANI_NOLOOP		= 0,	///< ��ѭ��
		ANI_FORCE32BIT = 0x7FFFFFFF,
	};

	/// ͼԪ����
	enum PRIM_TYPE
	{
		PRIM_POINTS			= 1, ///< ����
		PRIM_LINES			= 2, ///< ����
		PRIM_TRIPLES		= 3, ///< ��������
		PRIM_QUADS			= 4, ///< ������
		PRIM_LINESTRIP		= 5, ///< ���ߴ�
		PRIM_TRIANGLESTRIP	= 6, ///< �����Ǵ�
		PRIM_TRIANGLEFAN	= 7, ///< ������
		PRIM_FORCE32BIT = 0x7FFFFFFF,
	};

	/// ��Ļ��ͼ��ʽ
	enum GGE_IMAGE_FORMAT
	{
		IMAGE_JPG, ///< jpg�ļ�
		IMAGE_PNG, ///< png�ļ�
		IMAGE_BMP, ///< bmp�ļ�
		IMAGE_TGA, ///< tga�ļ�
		IMAGE_DXT1,///< dds�ļ�
		IMAGE_DXT3,///< dds�ļ�
		IMAGE_DXT5,///< dds�ļ�
		IMAGE_FORCE32BIT = 0x7FFFFFFF,
	};

	/// PixelShader�汾
	enum PIXEL_SHADER_VERSION
	{
		PS_NONE,	///< ��֧��PixelShader
		PS_1_1,		///< ps1.1
		PS_1_2,		///< ps1.2
		PS_1_3,		///< ps1.3
		PS_1_4,		///< ps1.4
		PS_2_0,		///< ps2.0
		PS_LAST,	///< ��Чֵ
		PS_FORCE32BIT = 0x7FFFFFFF,
	};

	/// ϵͳ״̬
	enum GGE_STATE_BOOL_FUN
	{
		GGE_FRAMEFUNC,		///< bool*()	֡��������������ʱ���ģ���������,����true���˳���false��������
		GGE_EXITFUNC,		///< bool*()	�˳���������������ʱ���ģ�����true���˳���false��������
		GGE_FOCUSLOSTFUNC,	///< bool*()	ʧȥ���㣬��������ʱ����
		GGE_FOCUSGAINFUNC,	///< bool*()	��ý��㣬��������ʱ����
		GGE_FORCE32BIT_STATE_BF = 0x7FFFFFFF,
	};

	/// ϵͳ״̬
	enum GGE_STATE_MSG_FUN
	{
		GGE_MESSAGEFUNC,	///< bool*(HWND, UINT, WPARAM, LPARAM)	������Ϣ������,�����������true��ʾ������Ϣ�Ѵ������ᴫ��Ĭ����Ϣ����������������ʱ����
		GGE_FORCE32BIT_STATE_MF = 0x7FFFFFFF,
	};

	/// ϵͳ״̬
	enum GGE_STATE_HWND
	{
		GGE_HWND,			///< HWND	���ھ��������System_SetState()��������ʱ����ʾģʽǿ��ʹ�ô���ģʽ����������Input������֡ʱ����غ����������ã���Ҫ����������Ϸ�༭���ȹ������(ʹ�÷����ɲο�ʾ������sample3)��������System_GetState()����ʱ�����֮ǰ���ù����ھ�����򷵻�֮ǰ���õĴ��ھ�������򷵻����洴���Ĵ��ڵĴ��ھ����
		GGE_FORCE32BIT_STATE_H = 0x7FFFFFFF,
	};

	/// ϵͳ״̬
	enum GGE_STATE_INT
	{
		GGE_ICON,			///< int	����ͼ��
		GGE_FPS,			///< int	����֡��(0:������ | >0:����Ϊ��֡��)����������ʱ���ģ�Ĭ��:0
		GGE_SCREENWIDTH,    ///< int	��Ļ��ȣ���������ʱ���ģ�Ĭ��:640
		GGE_SCREENHEIGHT,   ///< int	��Ļ�߶ȣ���������ʱ���ģ�Ĭ��:480
		GGE_SCREENBPP,		///< int	ɫ��(16/32)����������ʱ���ģ�Ĭ��:32
		GGE_TEXTURESIZE,	///< int	����������ߴ磬ֻ����System_GetState()����
		GGE_SOUNDBIT,		///< int	��Ƶλ�ʣ�Ĭ��:16
		GGE_SOUNDRATE,		///< int	��ƵƵ�ʣ�Ĭ��:44100
		GGE_PSVERSION,		///< int	PixelShader�汾���μ�PIXEL_SHADER_VERSION��ֻ����System_GetState()����
		GGE_FORCE32BIT_STATE_I = 0x7FFFFFFF,
	};

	/// ϵͳ״̬
	enum GGE_STATE_BOOL
	{
		GGE_FULLSCREEN,		///< bool	�Ƿ�ȫ��ģʽ����������ʱ���ģ�Ĭ��:false
		GGE_HIDEMOUSE,		///< bool	�Ƿ�����ϵͳ��꣬��������ʱ���ģ�Ĭ��:true
		GGE_DEBUGLOG,		///< bool	�Ƿ�д����Լ�¼��ע�⣺��ʹ�رյ��Լ�¼�����ǻᴴ�����Լ�¼�ļ���д������¼������������ʱ���ģ�Ĭ��:true
		GGE_SUSPEND,		///< bool	�Ǽ���״̬ʱ�Ƿ����Ĭ��:false
		GGE_ZBUFFER,		///< bool	�Ƿ���Z���壬��������ʱ���ģ�Ĭ��:false��ע�⣺����System_Initiate()ʱ��Ϊtrue�ù��ܷ���ʹ�ã�
		GGE_USESOUND,		///< bool	�Ƿ�����������Чģ�飬Ĭ��:true
		GGE_VSYNC,			///< bool	�Ƿ�����ֱͬ������������ʱ���ģ�Ĭ��:false
		GGE_FORCETEXFILTER,	///< bool	ǿ�ƿ���������ˣ���������ʱ���ģ�Ĭ��:false
		GGE_FPUPRESERVE,	///< bool	�Ƿ񱣳ָ��㾫�ȣ����ڽ��D3D�Զ��޸ĸ��㾫�ȵ��µ�һЩ���⣬Ĭ��:false
		GGE_FORCE32BIT_STATE_B = 0x7FFFFFFF,
	};

	/// ϵͳ״̬
	enum GGE_STATE_CHAR
	{
		GGE_TITLE,			///< char*		���ô��ڱ���
		GGE_LOGNAME,		///< char*		��¼�ļ�����Ĭ��:"galaxy2d.log"
		GGE_FORCE32BIT_STATE_C = 0x7FFFFFFF,
	};

	typedef unsigned long  gULong;	///< gULong
	typedef unsigned int   gUInt;	///< gUInt
	typedef unsigned short gUShort;	///< gUShort
	typedef unsigned char  gUChar;	///< gUChar

	typedef bool (*GGE_MSGFUN)(HWND, UINT, WPARAM, LPARAM);
	typedef bool (*GGE_BOOLFUN)();

	/// ���㶨��
	struct ggeVertex
	{
		float	x, y;		///< ��Ļ����
		float	z;			///< Z����(0~1)
		gUInt	color;		///< ������ɫ
		float	tx, ty;		///< ��������
	};

	class ggeAnimation;
	class ggeMesh;
	class ggeImage;
	class ggeMusic;
	class ggeParticle;
	class ggeSound;
	class ggeSprite;
	class ggeTexture;
	class ggeFont;
	class ggeSwapChain;
	class ggeGuiManager;
	class ggeGuiWindow;
	class ggeGuiButton;
	class ggeGuiCheckButton;
	class ggeGuiEditBox;
	class ggeGuiListBox;
	class ggeGuiSlider;
	class ggeGuiRichText;
	class ggeGuiRenderState;
	class ggeGuiCreateInfo;
	class ggeGuiFactory;
	class ggeGuiLoader;
	class ggeResManager;
	class ggeColor;
	class ggeRect;
	class ggeVector;
	class ggeShader;

	/** @name ����ɨ����
	*  @{
	*/

	#define GGEK_LBUTTON	0x00
	#define GGEK_RBUTTON	0x01
	#define GGEK_MBUTTON	0x02

	#define GGEK_ESCAPE		0x1B
	#define GGEK_BACKSPACE	0x08
	#define GGEK_TAB		0x09
	#define GGEK_ENTER		0x0D
	#define GGEK_SPACE		0x20

	#define GGEK_SHIFT		0x10
	#define GGEK_CTRL		0x11
	#define GGEK_ALT		0x12

	#define GGEK_LWIN		0x5B
	#define GGEK_RWIN		0x5C
	#define GGEK_APPS		0x5D

	#define GGEK_PAUSE		0x13
	#define GGEK_CAPSLOCK	0x14
	#define GGEK_NUMLOCK	0x90
	#define GGEK_SCROLLLOCK	0x91

	#define GGEK_PGUP		0x21
	#define GGEK_PGDN		0x22
	#define GGEK_HOME		0x24
	#define GGEK_END		0x23
	#define GGEK_INSERT		0x2D
	#define GGEK_DELETE		0x2E

	#define GGEK_LEFT		0x25
	#define GGEK_UP			0x26
	#define GGEK_RIGHT		0x27
	#define GGEK_DOWN		0x28

	#define GGEK_0			0x30
	#define GGEK_1			0x31
	#define GGEK_2			0x32
	#define GGEK_3			0x33
	#define GGEK_4			0x34
	#define GGEK_5			0x35
	#define GGEK_6			0x36
	#define GGEK_7			0x37
	#define GGEK_8			0x38
	#define GGEK_9			0x39

	#define GGEK_A			0x41
	#define GGEK_B			0x42
	#define GGEK_C			0x43
	#define GGEK_D			0x44
	#define GGEK_E			0x45
	#define GGEK_F			0x46
	#define GGEK_G			0x47
	#define GGEK_H			0x48
	#define GGEK_I			0x49
	#define GGEK_J			0x4A
	#define GGEK_K			0x4B
	#define GGEK_L			0x4C
	#define GGEK_M			0x4D
	#define GGEK_N			0x4E
	#define GGEK_O			0x4F
	#define GGEK_P			0x50
	#define GGEK_Q			0x51
	#define GGEK_R			0x52
	#define GGEK_S			0x53
	#define GGEK_T			0x54
	#define GGEK_U			0x55
	#define GGEK_V			0x56
	#define GGEK_W			0x57
	#define GGEK_X			0x58
	#define GGEK_Y			0x59
	#define GGEK_Z			0x5A

	#define GGEK_GRAVE		0xC0
	#define GGEK_MINUS		0xBD
	#define GGEK_EQUALS		0xBB
	#define GGEK_BACKSLASH	0xDC
	#define GGEK_LBRACKET	0xDB
	#define GGEK_RBRACKET	0xDD
	#define GGEK_SEMICOLON	0xBA
	#define GGEK_APOSTROPHE	0xDE
	#define GGEK_COMMA		0xBC
	#define GGEK_PERIOD		0xBE
	#define GGEK_SLASH		0xBF

	#define GGEK_NUMPAD0	0x60
	#define GGEK_NUMPAD1	0x61
	#define GGEK_NUMPAD2	0x62
	#define GGEK_NUMPAD3	0x63
	#define GGEK_NUMPAD4	0x64
	#define GGEK_NUMPAD5	0x65
	#define GGEK_NUMPAD6	0x66
	#define GGEK_NUMPAD7	0x67
	#define GGEK_NUMPAD8	0x68
	#define GGEK_NUMPAD9	0x69

	#define GGEK_MULTIPLY	0x6A
	#define GGEK_DIVIDE		0x6F
	#define GGEK_ADD		0x6B
	#define GGEK_SUBTRACT	0x6D
	#define GGEK_DECIMAL	0x6E

	#define GGEK_F1			0x70
	#define GGEK_F2			0x71
	#define GGEK_F3			0x72
	#define GGEK_F4			0x73
	#define GGEK_F5			0x74
	#define GGEK_F6			0x75
	#define GGEK_F7			0x76
	#define GGEK_F8			0x77
	#define GGEK_F9			0x78
	#define GGEK_F10		0x79
	#define GGEK_F11		0x7A
	#define GGEK_F12		0x7B

	/** @} */
}
