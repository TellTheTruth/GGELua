-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2016-06-08 16:51:51
-- @最后修改来自: baidwwy
-- @Last Modified time: 2017-03-10 11:30:55
local ffi = require("ffi")
ffi.cdef[[
	typedef struct
	{
		uint8_t title[36];//Title
		uint32_t unk;
		uint32_t unk1;
		uint32_t num;//数量IndexCount
	}wixhead;
	typedef struct
	{
		uint8_t title[36];
		uint32_t unk;
		uint32_t unk1;
		uint32_t num;//数量ImageCount
		uint32_t type;//类型ColorCount
		uint32_t plen;//调色板长度PaletteSize
	}wilhead;
]]
local ggewil = class()


function ggewil:初始化(路径,内存)
	self.路径 = 路径
	self.内存大小 = 内存 or 262144
	local wix = 路径:sub(1,-4).."wix"
	if 引擎.文件是否存在(路径) and 引擎.文件是否存在(wix) then
		self.wil 		= require("文件类")(路径)
		local wixfile 	= require("文件类")(wix)
		--wix
		local wixhead 	= wixfile:读入数据(ffi.new("wixhead"))

		if ffi.string(wixhead.title,36) == "#INDX v1.0-WEMADE Entertainment inc." or ffi.string(wixhead.title,26)=='\25WEMADE Entertainment inc.' then
			self.num 	= wixhead.num
		    self.index 	= wixfile:读入数据(ffi.new("uint32_t[?]",self.num))
 			--wil
 			local wilhead = self.wil:读入数据(ffi.new("wilhead"))
 			if ffi.string(wilhead.title,36) == "#ILIB v1.0-WEMADE Entertainment inc." or ffi.string(wilhead.title,26) == "\25WEMADE Entertainment inc." then
	 			self.type = wilhead.type
 				--写bmp头
 				self.bmp = require("字节集类")(self.内存大小)--宽19高23
	 			if self.type == 256 then--8位
					self.bmp:写整数(1,19778)
					self.bmp[15] = 40
					self.bmp[27] = 1
					self.bmp[29] = 8
				elseif self.type == 65536 then --16位
					self.bmp:写整数(1,19778)
					self.bmp[15] = 56
					self.bmp[27] = 1
					self.bmp[29] = 16
					self.bmp[31] = 3
					self.bmp:写整数(55,63488)--565
					self.bmp:写整数(59,2016)
					self.bmp:写整数(63,31)
				else
					error("未知格式:"..self.type)
	 			end
	 			--self.bmp:print()
	 			if wilhead.plen > 0 then
					--写bmp调色板
					if self.type == 256 then
					    self.wil:读入数据(self.bmp:取地址()+54,1024)
					end
					self.imginfo = ffi.new("short[4]")--宽高xy
	 			else
	 				print("没有调色版")
	 			end
	 			self.isok = true
	 			self.cache ={}
	 			self.cacheinfo ={}
	 		else
	 			error("wil格式不正确!")
 			end
 		else
 			error("wix格式不正确!")
		end
	else
	    error("wil或wix文件不存在!->"..路径)
	end
end
function ggewil:取数量()
	return self.num
end
-- function ggewil:取类型(id)
-- 	if self.type == 256 then
-- 	    return 8
-- 	elseif self.type == 65536 then
-- 		return 16
-- 	end
-- end
function ggewil:取偏移(id)--先取纹理才行
	local r = {}
	if self.cacheinfo[id] then
		setmetatable(r, {__index=self.cacheinfo[id]})
	    return r
	end
	self.cacheinfo[id] = {
		w=self.imginfo[0],
		h=self.imginfo[1],
		x=self.imginfo[2],
		y=self.imginfo[3]
	}
	setmetatable(r, {__index=self.cacheinfo[id]})
	return r
end
function ggewil:取纹理(id)
	if self.cache[id] then
	    return self.cache[id]
	end
	if self.isok and id>=0 and id < self.num and self.index[id] > 0 then
        self.wil:移动读写位置(self.index[id])
        self.wil:读入数据(self.imginfo)--宽高偏移
        self.bmp:写整数(19,self.imginfo[0])--写宽高
        self.bmp:写整数(23,self.imginfo[1])
        --print(self.type,id,self.imginfo[0],self.imginfo[1])
	    if self.type == 256 then -- 8位
	        local imglen = (self.imginfo[0]+4-self.imginfo[0]%4)*self.imginfo[1]
	        assert(self.内存大小 > imglen+1078, "内存不足!")
	        if imglen > 4 then
		        self.wil:读入数据(self.bmp:取地址(1078),imglen)--写bmp数据
		        self.cache[id] = require("gge纹理类")(self.bmp:取地址(),imglen+1078,0xFF000000)
		        return self.cache[id]
	        end
	    elseif self.type == 65536 then --16位
	    	local imglen = (self.imginfo[0]+4-self.imginfo[0]%4)*self.imginfo[1]*2
	    	assert(self.内存大小 > imglen+70, "内存不足!")
	        if imglen > 4 then
		        self.wil:读入数据(self.bmp:取地址(70),imglen)--写bmp数据
		        self.cache[id] = require("gge纹理类")(self.bmp:取地址(),imglen+70,0xFF000000)
		        return self.cache[id]
	        end
	    end
	else
		print(self.路径..":"..id)
	end
end
function ggewil:取精灵(id)
	return require("gge精灵类")(self:取纹理(id))
end
function ggewil:取信息(id)
	local s = self:取精灵(id)
	local t = self:取偏移(id)
	t.精灵 = s
	return t
end
function ggewil:取数据(id)
	if self.isok and id>=0 and id < self.num and self.index[id] > 0 then
        self.wil:移动读写位置(self.index[id])
        self.wil:读入数据(self.imginfo)
        local imglen = self.imginfo[0]*self.imginfo[1]
        ffi.copy(self.bmp:取地址(),self.imginfo,8)
        self.wil:读入数据(self.bmp:取地址()+8,imglen)
        return self.bmp:取地址(),imglen+8
    end
end
function ggewil:优化影子(s,c)
	if not s:取纹理() or s:取纹理().已优化 then
	    return
	end
	local ptr 	= s:取纹理():锁定()
	local int 	= ffi.cast("uint32_t*",ptr)
	local sw,sh = s:取宽度(),s:取高度()
	local i 	= 0
	local ishead,isnext,isstart = true,false,false
	c=c or 0x50000000
	for h=1,sh do
		for l=1,sw do
			if ishead then--查找3点颜色头
				if int[i]~=0 and int[i+1]==0 and int[i+2]~=0 and l+2<=sw then
					ishead,isnext,isstart = false,false,true--下一点没有颜色
					int[i] = c
				elseif int[i]==0 and int[i+1]~=0 and int[i+2]==0 and l+2<=sw then
					ishead,isnext,isstart = false,true,true--下一点有颜色
					int[i] = c
				end
			elseif isstart and isnext and int[i]~=0 then
				int[i] = c
				isnext = not isnext
			elseif isstart and not isnext and int[i]==0 then
				int[i] = c
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

return ggewil