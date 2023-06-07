
local ffi 	= require("ffi")
local ggebuf = class()

function ggebuf:初始化(v)
	self.buflen 	= v or 4096 --缓存大小
	self.bodylen 	= self.buflen - 12--包体长度
	self.flag 	= 14138 --包头识别
	self.seq 	= 0 -- 包序号
	self.seqlen = 9527
	self.data 	= ffi.new('char[?]',self.buflen)
	self.int 	= ffi.cast('int*',self.data)
	self.prt 	= tonumber(ffi.cast("intptr_t",self.data))
	self.len 	= 0
	self.lock 	= true
end
function ggebuf:打包()--0包头，1序号，2长度，3数量
	self.int[0] = self.flag
	self.int[1] = self.seq
	self.i 		= 4--位置
	self.len 	= 16--位置*int
	self.seq 	= self.seq +1
	self.lock 	= false
	if self.seq >self.seqlen then
	    self.seq = 1
	end
end
function ggebuf:添加数值(v)
	if self.len+4 <=self.buflen and not self.lock then
		self.int[self.i] = tonumber(v)
		self.i = self.i +1
		self.len = self.len +4
	else
		error(string.format('添加失败:规则错误或者数据过长.(%s)', v))
	end
end
function ggebuf:添加文本(v)
	if self.len+#v <=self.buflen and not self.lock then
		ffi.copy(self.data+self.len,v)
		self.len = self.len + #v
		self.lock = true
	else
		error(string.format('添加失败:规则错误或者数据过长.(%s)', v))
	end
end
function ggebuf:打包完成()
	self.int[2] = self.len -12
	self.int[3] = self.i -4
	self.lock 	= true
end
function ggebuf:添加数据( ... )
	self:打包()
	local arg = {...}
	for i,v in ipairs(arg) do
		if type(v) == 'number' then
			self:添加数值(v)
		else
		    self:添加文本(tostring(v))
		end
	end
	self:打包完成()
end
--=========================解包========================================
function ggebuf:取头长()--0包头，1序号，2长度
	return 12
end
function ggebuf:校验头()--成功返回包体长度
	local flag,seq,len = self.int[0],self.int[1],self.int[2]
	if flag == self.flag and len >0 and len <=self.bodylen then
		self.len = len
		self.seq = self.seq +1
	    return self.len
	end
	return 0
end
function ggebuf:取数据()
	local r = {}
	local num = self.int[0]
	if num >= 0 and num*4 < self.bodylen then
		for i=1,num do
			table.insert(r, self.int[i])
		end
		local stroff = num*4+4
		if self.len > stroff then
		    table.insert(r, ffi.string(self.data+stroff,self.len-stroff))
		end
	end
	return r
end
function ggebuf:取指针()
	return self.prt
end
function ggebuf:取长度()
	return self.len
end
return ggebuf