
local 动画类 = class()


function 动画类:初始化(文件)
	self.hum = require("mir/wil类")(文件)
	self.信息 = {}
	self.信息[0] = self.hum:取信息(0)
	self.信息[0].纹理 = self.hum:取纹理(0)

	self.精灵 = require("gge精灵类")(self.信息[0].纹理)
	self.帧率 = 0.1
	self.dtt = 0
	self.时间累积 = 0;

	self.开始帧 = 7200;
	self.结束帧 = self.开始帧+7;
	self.当前帧 = self.开始帧;
	self.x,self.y = 0,0
end


function 动画类:更新(dt)
	if 引擎.按键按下(KEY.F1) then
		self.开始帧 = self.开始帧 + 8
		self.结束帧 = self.结束帧 + 8
	end
	if dt >self.帧率 or  self.dtt >0 then
		self.dtt = self.dtt + dt + self.时间累积
		self.时间累积 = self.帧率
		self.dtt = self.dtt - self.帧率
	else
		self.时间累积 = self.时间累积 + dt;
	end

	if (self.时间累积 >= self.帧率) then
		self.当前帧 = self.当前帧 + 1
		self.时间累积 = 0;
		if (self.当前帧 > self.结束帧) then
			self.当前帧 = self.开始帧;
		end

		if not self.信息[self.当前帧] then
			self.信息[self.当前帧] = self.hum:取信息(self.当前帧)
			self.信息[self.当前帧].纹理 = self.hum:取纹理(self.当前帧)
		end

		if self.信息[self.当前帧].x ~= 0 then
		    self.精灵:置纹理(self.信息[self.当前帧].纹理)
		else
			self.时间累积 = self.帧率
		end
	end
end


function 动画类:显示(x,y)
	if self.信息[self.当前帧] and self.信息[self.当前帧].x ~= 0 then
		self.x= x +self.信息[self.当前帧].x
		self.y= y +self.信息[self.当前帧].y
	end
	self.精灵:显示(self.x,self.y)
end

return 动画类