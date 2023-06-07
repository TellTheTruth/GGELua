--======================================================================--
--该 文件由GGELUA创建
--
--作者：baidwwy  创建日期：2014-05-18 09:05:47
--======================================================================--

动画类 = class()


function 动画类:初始化(p,len)
	local WAS类 = require("Glow/WAS类")

	self.was = WAS类.创建(p,len)
	--self.was:置调色板([[D:\Desktop\EM\was\WasSee2_src\Bin\梦幻调色板\0006-虎头怪.wpal]]):调色(6,6,6,0)

	self.信息组 = {};
	self.数量 = self.was.方向数 * self.was.帧数-1;


	for n = 0 ,self.数量 do
		self.信息组[n] = {};
	end
	self.信息组[0] = self.was:取精灵(0);

	self.精灵 = self.信息组[0].精灵;



	self.高度 = self.was.高度;
	self.宽度 = self.was.宽度;
	self.中心x = self.was.x;
	self.中心y = self.was.y;
	self.开始帧 = 0;
	self.结束帧 = 0;  
	self.当前帧 = 0;

	self.时间累积 = 0;
	self.方向数 = self.was.方向数;
	self.帧数 = self.was.帧数;
	self.帧率 = 100/1000;

	self.已载入 = 0;
	self:置方向(0);
end

function 动画类:更新纹理()
	if (self.was and self.信息组[self.当前帧].纹理 == nil) then
		self.信息组[self.当前帧] = self.was:取纹理(self.当前帧);

		self.已载入 = self.已载入 +1;
		if(self.已载入 >= self.数量)then
			self.was = nil;
		end
	end
	local t = self.信息组[self.当前帧];
	
	self.精灵:置纹理(t.纹理)
end
function 动画类:更新(dt)
	self.时间累积 = self.时间累积 + dt;

	if (self.时间累积 > self.帧率) then
		self.当前帧 = self.当前帧 + 1
		self.时间累积 = 0;
		if (self.当前帧 > self.结束帧) then
			self.当前帧 = self.开始帧;
		end
		self:更新纹理();
	end
end


function 动画类:显示(x,y)
	self.x = x - self.信息组[self.当前帧].Key_X ;
	self.y = y - self.信息组[self.当前帧].Key_Y ;

	self.精灵:显示(self.x,self.y)
	--画多边形(x,y,3,20)
end

function 动画类:置方向(d)
	if(self.方向~=d)then
		self.方向 = d
		if d > self.帧数 then
		    d = 0
		end
	 
		self.开始帧 = d * self.帧数
		self.结束帧 = self.帧数 + self.开始帧 - 1

		self.当前帧 = self.开始帧
		self:更新纹理()
	end
end

return 动画类