--======================================================================--
--该 文件由GGELUA创建
--
--作者：baidwwy  创建日期：2014-07-10 00:07:37
--======================================================================--
--=======初始化地图文件=============
_Objects = {}
local WIL类 = require("mir/wil类")
for i=0,6 do
	_Objects[i] = WIL类(string.format(游戏目录 ..'Data/Objects%s',i==0 and '' or (i+1)))--顶层
end
_SmTiles = WIL类(游戏目录 ..'Data/SmTiles')--中层
_Tiles = WIL类(游戏目录 ..'Data/Tiles')--底层


local 地图 = class()

function 地图:初始化(文件)
	self.map 	= require("mir/map类")(文件)
	self.列数 	= self.map.head.width
	self.行数 	= self.map.head.height
	self.宽度 	= self.列数*48
	self.高度 	= self.行数*32

	--============初始化块ID================
	self.信息组 	= {}
	local i = 0
	for l = 1 , self.列数  do
		self.信息组[l] = {}
		for h = 1 , self.行数  do
			self.信息组[l][h] = i --初始化编号
			i = i+1
		end
	end

	self.开始位置 	= require("gge坐标类")(1,1)
	self.结束位置 	= require("gge坐标类")(1,1)
	--self.显示坐标 	= 生成XY(16000,10000) --土城
	self.显示坐标 	= require("gge坐标类")(16000,10000)



	Hum = WIL类(游戏目录 ..'Data/Hum')
	人 = Hum:取精灵(7232)

	print(self.宽度,self.高度,self.列数,self.行数)
	障碍 = _SmTiles:取精灵(59):置颜色(ARGB(50,255,255,255))
end


function 地图:更新(dt,x,y)
	local 显示位置  = self.显示坐标:取地图位置(48,32)
    self.偏移 =  self.显示坐标:取屏幕坐标(self.宽度,self.高度)
    --=================鼠标拖动=====================
    if 引擎.鼠标按下(KEY.LBUTTON) then
        self.按下x,self.按下y = x,y
        self.旧x,self.旧y =  self.显示坐标.x, self.显示坐标.y
        self.鼠标按下 = true
    end
    if 引擎.鼠标弹起(KEY.LBUTTON) then
    	self.鼠标按下 = false
    end
    if self.鼠标按下 then

        self.显示坐标.x = self.旧x-(x-self.按下x)
        self.显示坐标.y = self.旧y-(y-self.按下y)
        if self.显示坐标.x<400 then
            self.显示坐标.x=400
        end
        if self.显示坐标.y<300 then
            self.显示坐标.y=300
        end
         if self.显示坐标.x>self.宽度-400 then
            self.显示坐标.x=self.宽度-400
        end
        if self.显示坐标.y>self.宽度-300 then
            self.显示坐标.y=self.宽度-300
        end
    end
	--===================局部计算============================

	if(显示位置.x < 15)then
		self.开始位置.x= 1
		self.结束位置.x = 30
	elseif(显示位置.x >= self.列数- 15)then
		self.开始位置.x = 显示位置.x - 15
		self.结束位置.x = self.列数
	else
		 self.开始位置.x = 显示位置.x - 15
		 self.结束位置.x = 显示位置.x + 15
	end

	if(显示位置.y < 15)then
		self.开始位置.y = 1
		self.结束位置.y = 30
	elseif(显示位置.y >= self.行数-15 )then
		self.开始位置.y = self.行数 - 15
		self.结束位置.y = self.行数
	else
		self.开始位置.y = 显示位置.y - 15
		self.结束位置.y = 显示位置.y + 30
	end

end


function 地图:显示(x,y)
	for l = self.开始位置.x, self.结束位置.x do
		for  h = self.开始位置.y, self.结束位置.y do
			if self.信息组[l] and self.信息组[l][h] then
				if type(self.信息组[l][h]) == 'number' then --初始编号

					self.信息组[l][h] = self.map:取信息(self.信息组[l][h])--从编号取块信息
					--======================底层载入===================================
					local bk = bit.band(self.信息组[l][h].BkImg,32767)-1
					if bk>=0 and bk<_Tiles.num and (l-1)%2==0 and (h-1)%2==0 then --底层 >Tiles
						local t = _Tiles:取信息(bk)
						t.px = (l-1)*48
						t.py = (h-1)*32
						t.xy = require("gge坐标类")(t.px,t.py)
						t.精灵 = _Tiles:取精灵(bk)--从tile_wil取图片
						self.信息组[l][h].底层 = t
					end
					-- --=======================中层载入==================================
					local mid = bit.band(self.信息组[l][h].MidImg,32767)-1
					if mid>=0 and mid<_SmTiles.num then --中层>SmTiles
						local t = _SmTiles:取信息(mid)
						t.px = (l-1)*48
						t.py = (h-1)*32
						t.xy = require("gge坐标类")(t.px,t.py)
						t.精灵 = _SmTiles:取精灵(mid)
						self.信息组[l][h].中层 = t
					end
					--=======================顶层载入==================================
					local fr = bit.band(self.信息组[l][h].FrImg,32767)-1
					if fr>=0  then --顶层 >Objects
						local id = self.信息组[l][h].ObjFile --obj文件_id
						local t = _Objects[id]:取信息(fr)

						t.px = (l-1)*48
						t.py = (h-1)*32
					   	t.精灵 = _Objects[id]:取精灵(fr)--从obj_wil取图片
					   	if t.y ~= -44 then
					   	    t.py = h*32-t.h+t.y
					   	    t.px = (l-1)*48
					   	else
					   		t.py = h*32-t.h
					   		t.px = (l-1)*48
					   	end
					   	t.xy = require("gge坐标类")(t.px,t.py)
					   	self.信息组[l][h].顶层 = t


					   	-- if fr==2723 then
					   	--     self.信息组[l][h].顶层.精灵:置混合(2):置颜色(ARGB(100,255,255,255))
					   	-- end
					end
				end
				--========================显示=================================
				if self.信息组[l][h].底层 then
					self.信息组[l][h].底层.精灵:显示(self.信息组[l][h].底层.xy + self.偏移)
				end
				if self.信息组[l][h].中层 then --中层
					self.信息组[l][h].中层.精灵:显示(self.信息组[l][h].中层.xy + self.偏移)
					--self.信息组[l][h].中层.精灵:取包围盒():显示()
				end
				if self.信息组[l][h].顶层 and self.信息组[l][h].顶层.h <=32 then
					self.信息组[l][h].顶层.精灵:显示(self.信息组[l][h].顶层.xy + self.偏移)
					--T:显示(self.信息组[l][h].顶层.xy + self.偏移,string.format('%d,%d',l,h))
				end
			end
		end
	end
	--顶层显示
	人:置颜色(ARGB(255,255,255,255)):显示(400,300)

	for l = self.开始位置.x, self.结束位置.x do
		for  h = self.开始位置.y, self.结束位置.y do
			if self.信息组[l] and self.信息组[l][h] then
				if self.信息组[l][h].顶层 and self.信息组[l][h].顶层.h>32   then
					self.信息组[l][h].顶层.精灵:显示(self.信息组[l][h].顶层.xy + self.偏移)
					--T:显示(self.信息组[l][h].顶层.xy + self.偏移,string.format('%d,%d',self.信息组[l][h].顶层.x,self.信息组[l][h].顶层.y))
					--self.信息组[l][h].顶层.精灵:取包围盒():显示()
				end
			end
		end
	end
	人:置颜色(ARGB(100,255,255,255)):显示(400,300)
	for l = self.开始位置.x, self.结束位置.x do
		for  h = self.开始位置.y, self.结束位置.y do
			if self.信息组[l] and self.信息组[l][h] then
				if bit.rshift(self.信息组[l][h].BkImg,15) ==1 then
				    --障碍:显示(require("gge坐标类")((l-1)*48,(h-1)*32)+self.偏移)
				    障碍:置坐标(require("gge坐标类")((l-1)*48,(h-1)*32)+self.偏移)
				   	障碍:取包围盒():显示()
				end
			end
		end
	end
	T:显示(10,10,string.format('%s,%s', self.显示坐标.x,self.显示坐标.y))



end


return 地图