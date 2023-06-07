require("GGE")--引用头


引擎("游戏模版",800,600,60)
curl = require("lcurl")
function ret(str)
	data = __gge.utf8toansi(str)
	print(data)
end

-- curl.easy()
--  :setopt_url('http://ggetest.host.gametata.com/user_register.lua')
--  :setopt_writefunction(ret)
--  :setopt_postfields('username=1zhangsan&password=zhangsan_password&test='..string.rep('a',10000))
--  :perform()
--  :close()

function gamett( ... )
	curl.easy()
	  :setopt_url('http://ggetest.host.gametata.com/user_register.lua?username=1zhangsan&password=zhangsan_password')
	  :setopt_writefunction(ret) -- use io.stderr:write()
	  :perform()
	:close()
	data = require("cjson").decode(data)
	table.print(data)
end
gamett()


function 更新函数(dt,x,y)--帧率,鼠标x,鼠标y
	if 引擎.按键按下(KEY.F1) then
		t=os.clock ()
	    	gamett()
	    	print(os.clock ()-t)
	end


end


function 渲染函数(x,y)--鼠标x,鼠标y
	引擎.渲染开始()
	引擎.渲染清除(0xFF272822)


	引擎.渲染结束()
end



function 退出函数()

	return true
end
引擎.置退出函数(退出函数)