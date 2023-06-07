--======================================================================--
--该 文件由GGELUA创建
--
--作者：baidwwy  创建日期：2014-05-18 14:42:36
--======================================================================--
local 地图类 = class()
local ffi = require("ffi")

function 地图类:初始化(文件)
	self.char = ffi.new('char[2097152]')
	self.p = tonumber(ffi.cast("intptr_t",self.char))
	self.map = require("glow/MAP类")(文件,self.p,2097152)
	self.宽度 		= self.map.宽度
	self.高度 		= self.map.高度
	self.行数 		= self.map.行数 
	self.列数 		= self.map.列数
	
	self.地表组 	= {}

	local id = 0
	for h = 1 , self.行数  do
		self.地表组[h] = {}
		for l = 1 , self.列数  do
			self.地表组[h][l] = 
			{
				id=id,
				遮罩	={}
			}
			id=id+1
			
		end
	end

	self.精灵 = self.map:取精灵(0)

	self.地表组[1][1].纹理 = self.精灵:取纹理()

	self.开始位置 	= require("gge坐标类")(1,1) --require("gge坐标类")() 是GGE函数，生成的{x=0,y=0},而且重载了相加和相减
	self.结束位置 	= require("gge坐标类")(1,1) 
end


function 地图类:更新(pos)
	local 主角位置  = require("gge坐标类")(math.ceil(pos.x/320), math.ceil(pos.y/240) ) 
     
	if(主角位置.x == 1)then
		self.开始位置.x 	= 1
		self.结束位置.x 	= 3
	elseif(主角位置.x >= self.列数)then
		self.开始位置.x 	= 主角位置.x - 2
		self.结束位置.x 	= 主角位置.x
	else
		self.开始位置.x 	= 主角位置.x - 1
		self.结束位置.x 	= 主角位置.x + 1
	end

	if(主角位置.y == 1)then
		self.开始位置.y 	= 1
		self.结束位置.y 	= 3
	elseif(主角位置.y >= self.行数)then
		self.开始位置.y 	= 主角位置.y - 2
		self.结束位置.y 	= 主角位置.y	
	else
		self.开始位置.y 	= 主角位置.y - 1
		self.结束位置.y 	= 主角位置.y + 1
	end
end


function 地图类:显示(偏移)

	for h = self.开始位置.y, self.结束位置.y do
		for  l = self.开始位置.x, self.结束位置.x do
			if (not self.地表组[h][l].纹理)then
				self.地表组[h][l].纹理 =self.map:取纹理(self.地表组[h][l].id)
			end
			self.精灵:置纹理(self.地表组[h][l].纹理)
			self.精灵:显示(require("gge坐标类")((l-1)*320,(h-1)*240) + 偏移)
		end
	end
end

return 地图类