-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2016-06-11 16:58:05
-- @最后修改来自: baidwwy
-- @Last Modified time: 2016-06-30 17:08:44
local ffi = require("ffi")
ffi.cdef[[
	typedef struct
	{
		uint8_t title[36];
		uint32_t unk;
		uint32_t unk1;
		uint32_t num;
	}wzxhead;

	typedef struct
	{
		uint8_t title[36];
		uint32_t unk;
		uint32_t unk1;
		uint32_t num;
	}wzlhead;
	typedef struct
	{
		uint8_t a;//05是16位,03是8位
		uint8_t b;
		uint8_t c;
		uint8_t d;
		uint16_t w;
		uint16_t h;
		short x;
		short y;
		uint32_t len;//zlib压缩后长度
	}wzlimg;

]]
local b64pal = [[
eJwtkyGM3UYQhj9ouJVa1STAZRs1YEHABlpRwUJLrZQlBQYFRpXBqTI5YHBgoaWokqMG
1CTSgao1KLB06KmqqgeNmldVBWF9UckDAe7vS2yPx7s788/8M2PYr+v7h+vr92q/9XF3
d8fz6y/57dcXtG2HtY+oqkiMNd6X5PkDjMmlLVlm+Pa7//j6m791vuHcRhVXMAO5HSDz
+m4hn6nqBZOXfP9q017E+hYXJtpuwFU6Kypy18nmkfYT7P5uoWoP2m8omwOEI76etI7C
eCj8T4T9RNlnEisJkheSPyUnyTv5j4RmwIZWfooh7I+e3kARFKsgDivFjt2c4WqjHyYK
V5KJYyaOSkxcvOImjBX/shFGp1ADXZ+IdYMvA3lhxekLhmkmNh3DT0faNBHbRDvMtNNK
mM6kw5my7vBfNYq9IGBuDyu2VG71wO16ppZfUL27aVG8iEsL1j2m7gdx6Yg6tyHiuxGj
XItb5a58UQ40I1F2ufBsbCgUq5Ad0wmvPhrr6BbVUfhBdnZSfUdDSCVlciq7EVSm/may
zZRXzu2sPrWNZiEnlLs4Toea7fVTzmvCNy3+dCGdL/DmIv4NU4qcZ89xDMy9o6kc6+nE
vCz0KXG6XFAIvF7W6GNfKN5UqXN7ea2h8YZUGaaoPjlDX0qE44qcLgampqL2llMwom7x
QX2QttJl1xHGUTWIfFyWCqRZfPaMzx//TiEuOIvxjlwiQqq96tVG9VZr4eNynYtrrzot
DWHetWRU3VMgiH9Y9xrufo64rxclvxnlIL8b2bzRPGpU0bgxfBjJf+/HkkH5z23NmjrW
rmG7ueJ4ODAOA4dhxDtHr/nryak0X5362apnl/nI2CX++OyK7dVrHv7ylh/4i58//Ye3
7zZ+fPlS//H+R2/3D9v2Xu33vqXX//gTF+k=
]]
local _pal = ffi.new("uint8_t[1024]")
do
	local len = __gge.debase64(_pal,1024,b64pal,#b64pal)
	local palstr = ffi.string(_pal,len)
	assert(__gge.uncompress(_pal,1024,palstr,len)>0, "调色板解压失败!")
end

local ggewzl = class()


function ggewzl:初始化(路径,内存)
	self.路径 = 路径
	self.内存大小 = 内存 or 262144
	local wzx = 路径:sub(1,-4).."wzx"
	if 引擎.文件是否存在(路径) and 引擎.文件是否存在(wzx) then
		self.wzl 		= require("文件类")(路径)
		local wzxfile 	= require("文件类")(wzx)
		--wzx
		local wzxhead 	= wzxfile:读入数据(ffi.new("wzxhead"))

		if ffi.string(wzxhead.title) == "www.shandagames.com" then
			self.num 	= wzxhead.num
			if self.num>0 and wzxfile:取文件长度() > self.num*4 then
			    self.index 	= wzxfile:读入数据(ffi.new("uint32_t[?]",self.num))
	 			--wzl
	 			local wzlhead = self.wzl:读入数据(ffi.new("wzlhead"))
	 			if ffi.string(wzlhead.title) == "www.shandagames.com" then
	 				self.imginfo = ffi.new("wzlimg")--宽高xy
	 				self.bmp 	= require("字节集类")(self.内存大小)--宽19高23
	 				self.unmem 	= require("字节集类")(self.内存大小)
		 			self.isok 	= true
		 			self.cache 	={}
		 			self.cacheinfo ={}
		 		else
		 			error("wzl格式不正确!")
	 			end
	 		else
	 		    self.num = 0
			end
 		else
 			error("wzx格式不正确!")
		end
	else
	    error("wzl或wzx文件不存在!->"..路径)
	end
end
function ggewzl:_BMPHEAD(t)
	if t>0 and self.type ~= t then
	    self.type = t
	    self.bmp:填充(0,1,54)
	    self.bmp:写整数(1,19778)
	    if t == 3 then--8
			self.bmp[15] = 40
			self.bmp[27] = 1
			self.bmp[29] = 8
		elseif t == 5 then--16
			self.bmp[15] = 56
			self.bmp[27] = 1
			self.bmp[29] = 16
			self.bmp[31] = 3
			self.bmp:写整数(55,63488)--565
			self.bmp:写整数(59,2016)
			self.bmp:写整数(63,31)
			self.bmp:写整数(67,0)
		else
			error("未知格式!")
	    end
	end
end
function ggewzl:取数量()
	return self.num
end
function ggewzl:取偏移(id)--先取纹理才行
	local r = {}
	if self.cacheinfo[id] then
		setmetatable(r, {__index=self.cacheinfo[id]})
	    return r
	end
	self.cacheinfo[id] = {
		w=self.imginfo.w,
		h=self.imginfo.h,
		x=self.imginfo.x,
		y=self.imginfo.y
	}
	setmetatable(r, {__index=self.cacheinfo[id]})
	return r
end
function ggewzl:取纹理(id)
	if self.cache[id] then
	    return self.cache[id]
	end
	if self.isok and id>=0 and id < self.num then
		if self.index[id] > 0 then
	        self.wzl:移动读写位置(self.index[id])
	        self.wzl:读入数据(self.imginfo)--宽高偏移
	        if self.imginfo.len >0 then
		        self:_BMPHEAD(self.imginfo.a)
		        self.bmp:写整数(19,self.imginfo.w)--写宽高
		        self.bmp:写整数(23,self.imginfo.h)
		        self.wzl:读入数据(self.unmem:取地址(),self.imginfo.len)
		        if self.type == 3  then -- 8位
		        	local imglen = self.imginfo.w*self.imginfo.h
		        	assert(self.内存大小 > imglen+1078, "内存不足!")
		        	assert(__gge.uncompress(self.bmp:取地址()+1078,self.内存大小,self.unmem:取地址(),imglen)==imglen, "解压失败!")
		        	ffi.copy(self.bmp:取地址()+54,_pal,1024)
			        self.cache[id] = require("gge纹理类")(self.bmp:取地址(),imglen+1078,0xFF000000)
			        return self.cache[id]
		        elseif self.type == 5 then --16位
			    	local imglen = (self.imginfo.w+self.imginfo.w%2)*self.imginfo.h*2
			    	assert(self.内存大小 > imglen+70, "内存不足!")
		        	assert(__gge.uncompress(self.bmp:取地址()+70,self.内存大小,self.unmem:取地址(),imglen)==imglen, "解压失败!")
		        	-- self.type = 0
		        	-- self.bmp:填充(0,1,70)
		        	-- self:_BMPHEAD(self.imginfo.a)
		        	-- self.bmp:写整数(19,self.imginfo.w)--写宽高
		        	-- self.bmp:写整数(23,self.imginfo.h)

			        self.cache[id] = require("gge纹理类")(self.bmp:取地址(),imglen+70,0xFF000000)
			        return self.cache[id]
		        end
	        end
		end
	else
		print(self.路径..":"..id)
	end
end
function ggewzl:取精灵(id)
	return require("gge精灵类")(self:取纹理(id))
end
function ggewzl:取信息(id)
	local s = self:取精灵(id)
	local t = self:取偏移(id)
	t.精灵 = s
	return t
end
function ggewzl:优化影子(s)
	if not s:取纹理() or s:取纹理().已优化 then
	    return
	end
	local ptr 	= s:取纹理():锁定()
	local int 	= ffi.cast("uint32_t*",ptr)
	local sw,sh = s:取宽度(),s:取高度()
	local i 	=0
	local ishead,isnext,isstart = true,false,false
	for h=1,sh do
		for l=1,sw do
			if ishead then--查找3点颜色头
				if int[i]~=0 and int[i+1]==0 and int[i+2]~=0 and l+2<=sw then
					ishead,isnext,isstart = false,false,true--下一点没有颜色
					int[i] = 0x50000000
				elseif int[i]==0 and int[i+1]~=0 and int[i+2]==0 and l+2<=sw then
					ishead,isnext,isstart = false,true,true--下一点有颜色
					int[i] = 0x50000000
				end
			elseif isstart and isnext and int[i]~=0 then
				int[i] = 0x50000000
				isnext = not isnext
			elseif isstart and not isnext and int[i]==0 then
				int[i] = 0x50000000
				isnext = not isnext
			else
				ishead,isnext,isstart = true,false,false--恢复
			end
			i=i+1
		end
		ishead,isnext,isstart = true,false,false--恢复
	end
	s:取纹理():解锁()
	s:取纹理().已优化 = true
end
return ggewzl