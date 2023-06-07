
local FMOD = class()
local ffi = require( "ffi" )

ffi.cdef[[
	void* 	__stdcall FSOUND_Init(int,int,int);
	void 	__stdcall FSOUND_Close();

	void*  	__stdcall FSOUND_Stream_Open(const char*,int,int,int);

	int  	__stdcall FSOUND_Stream_Play(int,void*);
	bool 	__stdcall FSOUND_Stream_Close(void*);
	bool 	__stdcall FSOUND_Stream_Stop(void*);
	bool 	__stdcall FSOUND_Stream_SetPosition(void*,int);
	int 	__stdcall FSOUND_Stream_GetPosition(void*);
	bool 	__stdcall FSOUND_Stream_SetTime(void*,int);
	int 	__stdcall FSOUND_Stream_GetTime(void*);
	int 	__stdcall FSOUND_Stream_GetLength(void*);
	int 	__stdcall FSOUND_Stream_GetLengthMs(void*);
	bool 	__stdcall FSOUND_Stream_SetMode(void*,int);
	int 	__stdcall FSOUND_Stream_GetMode(void*);
	bool 	__stdcall FSOUND_Stream_SetLoopPoints(void*,int,int);
	bool	__stdcall FSOUND_Stream_SetLoopCount(void*,int);

	bool	__stdcall FSOUND_SetFrequency(int,int);
	bool	__stdcall FSOUND_SetVolume(int,int);
	bool	__stdcall FSOUND_SetVolumeAbsolute(int,int);
	bool	__stdcall FSOUND_SetPaused(int,bool);
	bool	__stdcall FSOUND_SetLoopMode(int,int);
	bool	__stdcall FSOUND_SetCurrentPosition(int,int);

	bool 	__stdcall FSOUND_IsPlaying(int);
	int 	__stdcall FSOUND_GetVolume(int);
	bool 	__stdcall FSOUND_GetPaused(int);
	int 	__stdcall FSOUND_GetLoopMode(int);
	int 	__stdcall FSOUND_GetCurrentPosition(int);

	int 	_access(const char*, int);
]]
local _fmod

if ffi.C._access(__gge.runpath.."/lib/fmod.dll",0) == 0 then
    _fmod = ffi.load("./lib/fmod.dll")
else
	_fmod = ffi.load("fmod.dll")
end

local init = ffi.gc(_fmod.FSOUND_Init(44100, 32, 0),function ()
	_fmod.FSOUND_Close()
end)
rawset(FMOD, "_finit", init)
-- #define FSOUND_LOOP_OFF      0x00000001  /* For non looping samples. */
-- #define FSOUND_LOOP_NORMAL   0x00000002  /* For forward looping samples. */
-- #define FSOUND_LOOP_BIDI     0x00000004  /* For bidirectional looping samples.  (no effect if in hardware). */
-- #define FSOUND_8BITS         0x00000008  /* For 8 bit samples. */
-- #define FSOUND_16BITS        0x00000010  /* For 16 bit samples. */
-- #define FSOUND_MONO          0x00000020  /* For mono samples. */
-- #define FSOUND_STEREO        0x00000040  /* For stereo samples. */
-- #define FSOUND_UNSIGNED      0x00000080  /* For user created source data containing unsigned samples. */
-- #define FSOUND_SIGNED        0x00000100  /* For user created source data containing signed data. */
-- #define FSOUND_DELTA         0x00000200  /* For user created source data stored as delta values. */
-- #define FSOUND_IT214         0x00000400  /* For user created source data stored using IT214 compression. */
-- #define FSOUND_IT215         0x00000800  /* For user created source data stored using IT215 compression. */
-- #define FSOUND_HW3D          0x00001000  /* Attempts to make samples use 3d hardware acceleration. (if the card supports it) */
-- #define FSOUND_2D            0x00002000  /* Tells software (not hardware) based sample not to be included in 3d processing. */
-- #define FSOUND_STREAMABLE    0x00004000  /* For a streamimg sound where you feed the data to it. */
-- #define FSOUND_LOADMEMORY    0x00008000  /* "name" will be interpreted as a pointer to data for streaming and samples. */
-- #define FSOUND_LOADRAW       0x00010000  /* Will ignore file format and treat as raw pcm. */
-- #define FSOUND_MPEGACCURATE  0x00020000  /* For FSOUND_Stream_Open - for accurate FSOUND_Stream_GetLengthMs/FSOUND_Stream_SetTime.  WARNING, see FSOUND_Stream_Open for inital opening time performance issues. */
-- #define FSOUND_FORCEMONO     0x00040000  /* For forcing stereo streams and samples to be mono - needed if using FSOUND_HW3D and stereo data - incurs a small speed hit for streams */
-- #define FSOUND_HW2D          0x00080000  /* 2D hardware sounds.  allows hardware specific effects */
-- #define FSOUND_ENABLEFX      0x00100000  /* Allows DX8 FX to be played back on a sound.  Requires DirectX 8 - Note these sounds cannot be played more than once, be 8 bit, be less than a certain size, or have a changing frequency */
-- #define FSOUND_MPEGHALFRATE  0x00200000  /* For FMODCE only - decodes mpeg streams using a lower quality decode, but faster execution */
-- #define FSOUND_IMAADPCM      0x00400000  /* Contents are stored compressed as IMA ADPCM */
-- #define FSOUND_VAG           0x00800000  /* For PS2 only - Contents are compressed as Sony VAG format */
-- #define FSOUND_NONBLOCKING   0x01000000  /* For FSOUND_Stream_Open/FMUSIC_LoadSong - Causes stream or music to open in the background and not block the foreground app.  See FSOUND_Stream_GetOpenState or FMUSIC_GetOpenState to determine when it IS ready. */
-- #define FSOUND_GCADPCM       0x02000000  /* For Gamecube only - Contents are compressed as Gamecube DSP-ADPCM format */
-- #define FSOUND_MULTICHANNEL  0x04000000  /* For PS2 and Gamecube only - Contents are interleaved into a multi-channel (more than stereo) format */
-- #define FSOUND_USECORE0      0x08000000  /* For PS2 only - Sample/Stream is forced to use hardware voices 00-23 */
-- #define FSOUND_USECORE1      0x10000000  /* For PS2 only - Sample/Stream is forced to use hardware voices 24-47 */
-- #define FSOUND_LOADMEMORYIOP 0x20000000  /* For PS2 only - "name" will be interpreted as a pointer to data for streaming and samples.  The address provided will be an IOP address */
-- #define FSOUND_IGNORETAGS    0x40000000  /* Skips id3v2 etc tag checks when opening a stream, to reduce seek/read overhead when opening files (helps with CD performance) */
-- #define FSOUND_STREAM_NET    0x80000000  /* Specifies an internet stream */

-- #define FSOUND_NORMAL       (FSOUND_16BITS | FSOUND_SIGNED | FSOUND_MONO)
function FMOD:初始化(文件,模式,偏移,长度)
	self.channel = -1
	if 文件 then
		self.stream = ffi.gc(_fmod.FSOUND_Stream_Open(文件,模式 or 0,偏移 or 0,长度 or 0),function ( p )
			_fmod.FSOUND_Stream_Close(p)
		end)
	end
	self.是否暂停 = false
end
local 缓存地址 = {}
function FMOD:打开_从内存(循环,地址,长度)
	self.地址 = ffi.new('char[?]',长度)
	ffi.copy(self.地址,ffi.cast("char*",地址),长度)
	self.stream = ffi.gc(_fmod.FSOUND_Stream_Open(self.地址,循环 and 0x8002 or 0x8000,0,长度 or 0),function ( p )
		_fmod.FSOUND_Stream_Close(p)
		缓存地址[tostring(p)] = nil
	end)
	缓存地址[tostring(self.stream)] = self.地址
	return self
end
function FMOD:播放(channel)
	self.channel = _fmod.FSOUND_Stream_Play(channel or -1,self.stream)
	return self
end
function FMOD:暂停()
	self.是否暂停 = not self.是否暂停
	_fmod.FSOUND_SetPaused(self.channel,self.是否暂停)
end
-- function FMOD:恢复()
-- 	_fmod.FSOUND_SetPaused(self.stream,0)
-- end
function FMOD:停止()
	_fmod.FSOUND_Stream_Stop(self.stream)
	return self
end
function FMOD:置位置(v)--FSOUND_SetCurrentPosition
	_fmod.FSOUND_Stream_SetPosition(self.stream,v)
	return self
end
function FMOD:取位置()
	return _fmod.FSOUND_Stream_GetPosition(self.stream)
end
function FMOD:置模式(v)
	_fmod.FSOUND_Stream_SetMode(self.stream,v)
	return self
end
function FMOD:取模式()
	return _fmod.FSOUND_Stream_GetMode(self.stream)
end
function FMOD:置循环点(s,e)
	_fmod.FSOUND_Stream_SetLoopPoints(self.stream,s,e)
	return self
end
function FMOD:置循环次数(v)
	_fmod.FSOUND_Stream_SetLoopCount(self.stream,v)
	return self
end
function FMOD:置音量(v)
	_fmod.FSOUND_SetVolume(self.channel,v>100 and 100 or v)
	return self
end
function FMOD:是否播放()
	return _fmod.FSOUND_IsPlaying(self.channel)
end
function FMOD:取音量()
	return _fmod.FSOUND_GetVolume(self.channel)
end
function FMOD:是否暂停()
	return _fmod.FSOUND_GetPaused(self.channel) == 0
end
return FMOD