local ffi = require( "ffi" )
ffi.cdef[[
	int 	_access(const char*, int);
	void*  	BASS_Init(int,uint32_t,uint32_t,int,void*);
	bool 	BASS_Free();
	void* 	BASS_StreamCreateFile(bool,const char*,uint64_t,uint64_t,uint32_t);
	bool 	BASS_StreamFree(void*);
	bool 	BASS_ChannelPlay(void*,bool);
	bool 	BASS_ChannelStop(void*);
	bool 	BASS_ChannelPause(void*);
	float 	BASS_GetVolume();
	bool 	BASS_SetVolume(float);
	bool 	BASS_ChannelSetAttribute(void*,int,float);
	bool 	BASS_ChannelGetAttribute(void*,int,float*);
	int 	BASS_ChannelIsActive(void*);
]]
local _bass
if ffi.C._access(__gge.runpath.."/lib/bass.dll",0) == 0 then
    _bass = ffi.load("./lib/bass.dll")
else
	_bass = ffi.load("bass.dll")
end
local init = ffi.gc(_bass.BASS_Init(-1,44100,0,0,nil),function ()
	_bass.BASS_Free()
end)

local BASS类 = class()
rawset(BASS类, "_binit", init)

function BASS类:初始化(文件,偏移,长度,模式)
	if type(文件) == "string"  then
		self.stream = ffi.gc(_bass.BASS_StreamCreateFile(false,文件,偏移 or 0,长度 or 0,模式 or 0),_bass.BASS_StreamFree)
	elseif type(文件) == "number"  then
		self.stream = ffi.gc(_bass.BASS_StreamCreateFile(true,ffi.cast("char*",文件),偏移 or 0,长度 or 0,模式 or 0),_bass.BASS_StreamFree)
	end
end

function BASS类:播放(重头播放)
	_bass.BASS_ChannelPlay(self.stream,重头播放 and true or false)
	return self
end
function BASS类:停止()
	return _bass.BASS_ChannelStop(self.stream)
end
function BASS类:暂停()
	return _bass.BASS_ChannelPause(self.stream)
end
function BASS类:置音量(v)
	return _bass.BASS_ChannelSetAttribute(self.stream,2,v)--BASS_ATTRIB_VOL=2
end
function BASS类:取音量()
	local v = ffi.new("float[1]")
	_bass.BASS_ChannelGetAttribute(self.stream,2,v);
	return v[0]
end
function BASS类:取状态()
	return _bass.BASS_ChannelIsActive(self.stream)
end
return BASS类