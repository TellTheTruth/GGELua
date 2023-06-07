-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-05-06 16:35:49
-- @最后修改来自: baidwwy
-- @Last Modified time: 2017-02-10 22:06:40
local ffi = require("ffi")
local _ffi = {}
ffi.cdef [[
	//修改窗口图标
	void* 	LoadImageA(int,const char*,int,int,int,int);
	int 	SendMessageA(int,int,int,void*);
	//取硬盘序列号
	void* 	CreateFileA(const char*,int,int,void*,int,int,void*);
	bool  	DeviceIoControl(void*,int,void*,int,void*,int,void*,void*);
	bool 	CloseHandle(void*);

	//取窗口信息
	int GetWindowRect(int,void*);
	//取剪贴板
	int      OpenClipboard(unsigned);
	void*    GetClipboardData(unsigned);
	bool     CloseClipboard();
	void*    GlobalLock(void*);
	int      GlobalUnlock(void*);
	size_t   GlobalSize(void*);
	//置剪贴板
	bool 	EmptyClipboard();
	void* 	GlobalAlloc(unsigned, unsigned);
	void* 	GlobalFree(void*);
	void* 	lstrcpy(void*,const char*);
	void* 	SetClipboardData(unsigned,void*);
	//输出
	int printf(const char *fmt, ...);
	//读配置
	int GetPrivateProfileStringA(const char*, const char*, const char*, const char*, unsigned, const char*);
	//写配置
	bool WritePrivateProfileStringA(const char*, const char*, const char*, const char*);
	//设置窗口样式
	void SetWindowLongA(int ,int ,int );
	//取MD5
	typedef struct {
	    unsigned long i[2]; /* number of _bits_ handled mod 2^64 */
	    unsigned long buf[4]; /* scratch buffer */
	    unsigned char in[64]; /* input buffer */
	    unsigned char digest[16]; /* actual digest after MD5Final call */
	} MD5_CTX;
	void MD5Init(MD5_CTX *);
	void MD5Update(MD5_CTX *, const char *, unsigned int);
	void MD5Final(MD5_CTX *);
	//信息框
	int MessageBoxA(void *, const char*, const char*, int);
	//延迟
	void Sleep(int);
	//文件是否存在
	int _access(const char*, int);
	//打开网站
	void *ShellExecuteA(void*, const char *, const char*, const char*, const char*, int);
	//复制文件
	bool CopyFileA(const char*,const char*,bool );
	//读注册表
	long RegOpenKeyExA(unsigned,const char*,unsigned,unsigned,unsigned*);
	long RegQueryValueExA(unsigned,const char*,unsigned*,unsigned*,char*,unsigned*);
	long RegCloseKey(unsigned);
	//改窗口标题
	//int SetWindowTextA(int,const char*);
	//闪烁窗口
	int FlashWindow(int,bool);
	//查找文件
	typedef struct {
	        unsigned    attrib;
	        long  time_create;    /* -1 for FAT file systems */
	        long  time_access;    /* -1 for FAT file systems */
	        long  time_write;
	        unsigned long    size;
	        char  name[260];
	} _finddata32_t;
	int _findfirst32(const char*,_finddata32_t*);
	int _findnext32(int,_finddata32_t*);
	int _findclose(int);
]]
--local shell = ffi.load("shell32")
local advapi32 = ffi.load("advapi32.dll")
-- function _ffi.修改窗口标题(t)
-- 	ffi.C.SetWindowTextA(引擎.取窗口句柄(),t)
-- end
function _ffi.修改窗口图标(文件)
	local img = ffi.C.LoadImageA(0,文件,1,32,32,16)--IMAGE_BITMAP,LR_LOADFROMFILE
	ffi.C.SendMessageA(引擎.取窗口句柄(),128,0,img)--WM_SETICON
end
function _ffi.取硬盘序列号()
	local h = ffi.gc(ffi.C.CreateFileA("\\\\.\\PhysicalDrive0",bit.bor(2147483648,1073741824),bit.bor(1,2),nil,3,0,nil),ffi.C.CloseHandle)
	if h ~= ffi.cast('void*',-1) then
		local scip = ffi.new('unsigned char[32]')
		scip[10] = 236
		local data = ffi.new('char[528]')
		local size = ffi.new('int[1]')
	    if ffi.C.DeviceIoControl(h,508040,scip,32,data,528,size,nil) then
	        return ffi.string(data+36,20)
	    end
	end
	return ''
end
function _ffi.闪烁窗口(v)
	ffi.C.FlashWindow(引擎.取窗口句柄(),v)
end
function _ffi.取窗口信息()
	local data = ffi.new('int[4]')
	ffi.C.GetWindowRect(引擎.取窗口句柄(),data)
	rect = {
		Left 	= data[0],
		Top		= data[1],
		Right 	= data[2],
		Bottom 	= data[3]
	}
	return rect
end

function _ffi.取剪贴板()
	local text = ""
	local ok1    = ffi.C.OpenClipboard(0)
	local handle = ffi.C.GetClipboardData(1)
	if handle ~= nil then
		local size   = ffi.C.GlobalSize( handle )
		local mem    = ffi.C.GlobalLock( handle )
		text   = ffi.string( mem, size -1)
		local ok     = ffi.C.GlobalUnlock( handle )
	end
	local ok3    = ffi.C.CloseClipboard()
	return text
end

function _ffi.置剪贴板(txt)
	if txt then
		local ok1 = ffi.C.OpenClipboard(0)
		local ok2 = ffi.C.EmptyClipboard() --清空
		local handle = ffi.C.GlobalAlloc(66, #txt+1)
		if handle ~= nil then
			local mem = ffi.C.GlobalLock(handle)
			ffi.copy(mem, txt)
			local ok3 = ffi.C.GlobalUnlock(handle)
			handle = ffi.C.SetClipboardData(1, mem)
		end
		local ok4 = ffi.C.CloseClipboard()
	end
end
function _ffi.输出(...)
	ffi.C.printf(...)
end
function _ffi.读配置(文件,节点,名称)
	local buf = ffi.new("char[1024]")
	ffi.C.GetPrivateProfileStringA(节点,名称,"空",buf,1024,文件)
	return ffi.string(buf)
end
function _ffi.写配置(文件,节点,名称,值)
	return ffi.C.WritePrivateProfileStringA(节点,名称,tostring(值),文件)
end

--隐藏边框
--_ffi.设置窗口样式(引擎.取窗口句柄(),-16,369098752)
function _ffi.置窗口样式(h,a,b)
	ffi.C.SetWindowLongA(h,a,b)
end
function _ffi.取MD5(txt)
	local pctx = ffi.new("MD5_CTX[1]")
	advapi32.MD5Init(pctx)
	advapi32.MD5Update(pctx, tostring(txt), string.len(txt))
	advapi32.MD5Final(pctx)

	local md5str = ffi.string(pctx[0].digest,16)
	return string.format("%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",string.byte(md5str, 1, -1))
end
function _ffi.信息框(msg,title,type)
	ffi.C.MessageBoxA(nil, msg, title or '信息', mtype or 0)
end
function _ffi.延迟(int)
	ffi.C.Sleep(int)
end
function _ffi.文件是否存在(file)
	return ffi.C._access(file,0)==0
end
-- function _ffi.打开网站(file)
-- 	shell.ShellExecuteA(nil,"open",file,nil,nil,5)
-- end
function _ffi.复制文件(a,b,c)
	return  ffi.C.CopyFileA(a,b,c==nil and true or false)
end
--HKEY_CURRENT_USER 	0x80000001
--HKEY_LOCAL_MACHINE 	0x80000002
--HKEY_USERS			0x80000003
--KEY_READ				0x20019

--REG_SZ 				1
--REG_DWORD				4
function _ffi.读注册表(根,路径,名称)

	local hKey = ffi.new('unsigned [1]')
	if advapi32.RegOpenKeyExA(根,路径,0,0x20019,hKey) == 0 then
		local buf = ffi.new('char[128]')
		-- local REG_SZ = ffi.new('unsigned [1]')
		-- REG_SZ[0] = 1
		local buflen = ffi.new('unsigned [1]')
		buflen[0] = 128
	    if advapi32.RegQueryValueExA(hKey[0],名称,nil,nil,buf,buflen) == 0 then
	        return ffi.string(buf)
	    end
	    advapi32.RegCloseKey(hKey[0])
	end
	return ''
end
function _ffi.查找文件(目录,筛选,子目录,表)
	local result = 表 or {}
	local file = ffi.new("_finddata32_t")
	local HANDLE = ffi.C._findfirst32(目录..'/*.*',file)
	if HANDLE ~= -1 then
		repeat
			local name = ffi.string(file.name)
			if name ~= '.' and name ~='..' then
				if bit.band(file.attrib,16) == 16 then
					if 子目录 then
					    _ffi.查找文件(目录..'/'..name,筛选,子目录,result)
					end
				elseif name == 筛选 or name:match("%w+$")==筛选 then--全名或者扩展名
					table.insert(result, 目录.."/"..name)
				end
			end
		until ffi.C._findnext32(HANDLE,file)==-1
	end
	ffi.C._findclose(HANDLE)
	return result
end


--[==[
local ffi = require("ffi")
ffi.cdef[[
int __stdcall  CryptBinaryToStringA(
		const char *pbBinary,
		int  cbBinary,
		int  dwFlags,
		char * pszString,
		int *pcchString
);
int __stdcall CryptStringToBinaryA(
    const char *pszString,
    int  cchString,
    int  dwFlags,
	char *pbBinary,
    int  *pcbBinary,
    int  *pdwSkip,
    int  *pdwFlags
);
]]
local crypt = ffi.load(ffi.os == "Windows" and "crypt32")

local function toBase64(txt)
  local buflen = ffi.new("int[1]")
  crypt.CryptBinaryToStringA(txt, #txt, 1, nil, buflen)

  local buf = ffi.new("char[?]", buflen[0])
  crypt.CryptBinaryToStringA(txt, #txt, 1, buf, buflen)
  return ffi.string(buf, buflen[0])
end

local function fromBase64(txt)
  local buflen = ffi.new("int[1]")
  crypt.CryptStringToBinaryA(txt, #txt, 1, nil, buflen, nil, nil)

  local buf = ffi.new("char[?]", buflen[0])
  crypt.CryptStringToBinaryA(txt, #txt, 1, buf, buflen, nil, nil)
  return ffi.string(buf, buflen[0])
end
]==]

return _ffi