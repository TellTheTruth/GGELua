-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2016-06-09 15:01:50
-- @最后修改来自: baidwwy
-- @Last Modified time: 2016-06-11 13:20:32
local ffi = require("ffi")
ffi.cdef[[
	#pragma pack(1)
	typedef struct
	{
		uint16_t 	Width;
		uint16_t 	Height;
		uint8_t 	Title[16];
		int64_t 	UpdateDate;
		//uint32_t 	UpdateDate1;
		uint8_t 	Reserved[24];
	}MapHeader;
	#pragma pack()
	typedef struct
	{
		uint16_t 	BkImg;//背景层Tiles
		uint16_t 	MidImg;//中间层SmTiles
		uint16_t 	FrImg;//表层 Objects
		uint8_t 	DoorIndex;
		uint8_t 	DoorOffset;
		uint8_t 	AniFrame;
		uint8_t 	AniTick;
		uint8_t 	Area;//FrImg的OBJ文件编号
		uint8_t 	Light;
	}MapInfo;
]]


local ggemap = class()


function ggemap:初始化(路径)
	local mapfile 	= require("文件类")(路径)
	local MapHeader = mapfile:读入数据(ffi.new("MapHeader"))

	if ffi.string(MapHeader.Title+1,13) == 'Legend of mir' then
		--self.num = MapHeader.Width*MapHeader.Height
		self.Width 	= MapHeader.Width
		self.Height = MapHeader.Height
		self.cinfo 	= mapfile:读入数据(ffi.new(string.format("MapInfo[%d][%d]",self.Width,self.Height)))
		self.info  	= {}
		for i=0,self.Width-1 do
			self.info[i] = {}
		end
	else
		error("不支持该地图.")
	end
end


function ggemap:解析(x,y)
	if x>=0 and y>=0 and x <self.Width and y < self.Height and not self.info[x][y] then
	    self.info[x][y] = {
	    	大图idx 	= bit.band(self.cinfo[x][y].BkImg,0x7FFF)-1,
	    	小图idx 	= bit.band(self.cinfo[x][y].MidImg,0x7FFF)-1,
	    	物件idx 	= bit.band(self.cinfo[x][y].FrImg,0x7FFF)-1+bit.band(self.cinfo[x][y].DoorOffset,0x7F),--有AniFrame&0x80>0则不显示
	    	物件id 	= self.cinfo[x][y].Area,
	    	门 		= bit.band(self.cinfo[x][y].DoorIndex,0x80),--是否有门
	    	门状态 	= bit.band(self.cinfo[x][y].DoorOffset,0x80),--0关闭1打开
	    	门id 	= bit.band(self.cinfo[x][y].DoorIndex,0x7F),--门编号(附近10*10)
	    	门idx 	= bit.band(self.cinfo[x][y].DoorOffset,0x7F),--门obj偏移
	    	动画 	= self.cinfo[x][y].AniFrame,--是否有动画
	    	动画偏移 = bit.band(self.cinfo[x][y].AniFrame,0x80),--修正坐标
	    	动画帧数 = bit.band(self.cinfo[x][y].AniFrame,0x7F),
	    	动画帧率 = self.cinfo[x][y].AniTick,
	    	障碍 	= self:取障碍(x,y),
		}
	end
	return self.info[x][y]
end

function ggemap:取障碍(x,y)
	local r = bit.band(self.cinfo[x][y].BkImg,0x8000)+bit.band(self.cinfo[x][y].FrImg,0x8000)
	-- if r>0 then
	--     if bit.band(self.cinfo[x][y].DoorIndex,0x80) > 0 then
	--     	r = bit.band(self.cinfo[x][y].DoorOffset,0x80)
	--     end
	-- end
	return r>0
end
-- function ggemap:取下层声音(x,y)--取地表ID
-- 	local bidx = bit.band(self.cinfo[x][y].BkImg,0x7FFF)-1
-- 	bidx = self.cinfo[x][y].Area * 1000 + bidx -1
-- 	return bidx
-- end
function ggemap:取宽高()
	return self.Width-1,self.Height-1
end

return ggemap