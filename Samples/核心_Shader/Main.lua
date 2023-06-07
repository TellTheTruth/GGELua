require("GGE")--引用头


引擎("模糊效果",800,600,60)
fx=[[
sampler2D uSourcImg;

float4 main(float2 vTexCoord:TEXCOORD0) : COLOR0
{
	float2 pixelSize = float2(1.0 / 640, 1.0 / 480);
	float4 sum = float4(0, 0, 0, 1);

	sum += tex2D(uSourcImg, float2(vTexCoord.x - 4.0 * pixelSize.x, vTexCoord.y - 4.0 * pixelSize.y)) * 1.0 / 47.0;
    sum += tex2D(uSourcImg, float2(vTexCoord.x - 3.0 * pixelSize.x, vTexCoord.y - 3.0 * pixelSize.y)) * 2.0 / 47.0;
    sum += tex2D(uSourcImg, float2(vTexCoord.x - 2.0 * pixelSize.x, vTexCoord.y - 2.0 * pixelSize.y)) * 3.0 / 47.0;
    sum += tex2D(uSourcImg, float2(vTexCoord.x - pixelSize.x, vTexCoord.y - pixelSize.y)) * 10.0 / 47.0;
    sum += tex2D(uSourcImg, float2(vTexCoord.x, vTexCoord.y)) * 15.0 / 47.0;
    sum += tex2D(uSourcImg, float2(vTexCoord.x + pixelSize.x, vTexCoord.y + pixelSize.y)) * 10.0 / 47.0;
    sum += tex2D(uSourcImg, float2(vTexCoord.x + 2.0 * pixelSize.x, vTexCoord.y + 2.0 * pixelSize.y)) * 3.0 / 47.0;
    sum += tex2D(uSourcImg, float2(vTexCoord.x + 3.0 * pixelSize.x, vTexCoord.y + 3.0 * pixelSize.y)) * 2.0 / 47.0;
    sum += tex2D(uSourcImg, float2(vTexCoord.x + 4.0 * pixelSize.x, vTexCoord.y + 4.0 * pixelSize.y)) * 1.0 / 47.0;

	return sum;
}
]]
精灵 = require("gge精灵类")("test.jpg")
shader = require("ggeshader")()
shader:载入__从文本(fx,"main")

渲染区 = require("gge纹理类")():渲染目标(800,600)
渲染区精灵 = require("gge精灵类")(渲染区)
--帧率,鼠标x,鼠标y
function 更新函数(dt,x,y)--帧率,鼠标x,鼠标y



end


function 渲染函数(x,y)--鼠标x,鼠标y
	引擎.渲染开始(渲染区)
	引擎.渲染清除(0xFF808080)
	精灵:显示()
	引擎.渲染结束()


	引擎.渲染开始() --所有引擎函数都是使用点"."调用,不是冒号":"
	引擎.渲染清除(0xFF808080)--快捷键 Ctrl+Shift+C可以快速插入颜色哦

	引擎.置Shader(shader)
		:置纹理("uSourcImg",渲染区)
	渲染区精灵:显示()
	引擎.置Shader()
	引擎.渲染结束()
end



local function 退出函数()

	return true
end
引擎.置退出函数(退出函数)