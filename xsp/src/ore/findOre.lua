local touch = require("Touch")
local k = require("ore/Kuang")
local findHome = require("FindHome")
local sh = require("ShowHUD")

--隐藏地图其他按钮
function gb()
	x, y = findColor({0, 0, 719, 1279}, 
		"0|0|0x2c5e6c,-14|-14|0xf8c061,15|-13|0xe5a23d,16|17|0xebb94d,-14|16|0xf8cf5b,-18|2|0x276171,21|2|0x276171,0|-20|0x3e7182,1|18|0x335058",
		80, 0, 0, 0)
	if x > -1 then
		touch.touch(x,y)
	end
	return x
end

--打开地图其他按钮
function zk()
	x, y = findColor({0, 0, 719, 1279}, 
		"0|0|0x2a5d6e,-20|-11|0x266070,-11|-19|0x2c5e66,11|-17|0x375c66,20|-12|0x384132,20|12|0x2d5667,13|21|0x344b4e,-13|21|0x5c3c0c,-18|12|0x2b5c6d,-9|12|0xfdcd61,10|12|0xe5ad42,9|-8|0xdea045,-6|-6|0xeaaf49",
		80, 0, 0, 0)
	if x > -1 then
		touch.touch(x,y)
	end
	return x
end

--采集按钮
function gether_btn()
	x, y = findColor({0, 0, 719, 1279}, 
		"0|0|0x307283,5|-47|0x2c7586,2|78|0x2b7586,5|136|0x2d7585,6|204|0x2f7586,-5|30|0xeef0f0,2|30|0xffffff,11|31|0xebedee,6|25|0xd9ddde,6|32|0xb7bec0,2|39|0xe2e7e9,5|46|0xffffff,4|54|0xffffff,-4|52|0xedefef,-6|61|0x9fabac,2|78|0x2b7586",
		70, 0, 0, 0)
	if x > -1 then
		touch.touch(x,y)
		sysLog("采集按钮")
	end
end

--采集选兵
function gether_xb_btn()
	x, y = findColor({0, 0, 719, 1279}, 
		"0|0|0xf2c55a,-12|8|0xf19e33,9|8|0xf6c45f,-1|8|0x327384,-18|-14|0x377982,12|-16|0x2e7384,-18|20|0x377982,17|23|0x2f7992",
		80, 0, 0, 0)
	if x > -1 then
		touch.touch(x,y)
		sysLog("采集选兵")
	end
end

--低阶优先
function djyx_btn()
	x, y = findColor({0, 0, 719, 1279}, 
		"0|0|0xfcfcfc,-5|1|0xffffff,-9|1|0xffffff,-9|7|0xfefefe,-1|8|0xeeeeef,4|9|0xd0d1d1,-1|13|0xf7f7f7,-9|15|0x9b9b9b,-13|9|0xfafafa,-20|-14|0x377982,-10|-27|0x337585,7|-10|0x2f7182,3|112|0x327485,-13|120|0x337584,-9|137|0x337585,-2|81|0xbcbcbc,-3|62|0x494e50,-5|43|0x337586,-5|25|0x272b2c",
		80, 1, 0, 0)
	if x > -1 then
		touch.touch(x,y)
		sysLog("低阶优先")
	end
end

bingxian = 0

--执行采集
function ex_gether(x1,y1)
	touch.touch(x1,y1)
	mSleep(500)
	gether_btn()
	mSleep(500)
	gether_xb_btn()
	mSleep(500)
	djyx_btn()
	mSleep(500)
	x, y = findColor({0, 0, 719, 1279}, 
		"0|0|0x8c7b6b,33|-21|0x97844b,0|-46|0xb77523,45|14|0xb77523,40|-68|0x5c5958,40|-61|0xa59e9e,-24|-71|0x986935,48|62|0xcfd2d2,32|60|0xada6a6,43|82|0x706c6c,-15|74|0x876237,-54|52|0x986b3a,-24|-1|0x8d5c0d,-41|23|0xb77523,-42|-44|0xb77523",
		80, 0, 0, 0)
	if x > -1 then
		touch.touch(x,y)
		mSleep(3000)
		fh.backToFirstPage()
		bingxian = bingxian + 1
	end
end



fo = {}

function findOre(t)
	mSleep(200)
	
	if t == "石" then
		local x,y = k.sk_4()
		if x > -1 then
			return x,y
		else
			return k.sk_3()
		end
	elseif t == "木" then
		local x,y = k.mk_4()
		if x > -1 then
			return x,y
		else
			return k.mk_3()
		end
	elseif t == "铁" then
		local x,y = k.tk_4()
		if x > -1 then
			return x,y
		else
			return k.tk_3()
		end
	elseif t == "金" then
		local x,y = k.jk_4()
		if x > -1 then
			return x,y
		else
			return k.jk_3()
		end
	elseif t == "水" then
		return k.sj()
	end
	mSleep(200)
end

function fzk(t,bx)
	x,y = findOre(t)
	if x > -1 then
		local hx,hy = k.h_bx(x-20,y-20,x+20,y+20)
		local lx,ly = k.l_bx(x-20,y-20,x+20,y+20)
		local sx,sy = k.s_bx(x-20,y-20,x+20,y+20)
		
		sysLog(hx..","..hy.."--"..lx..","..ly.."--"..sx..","..sy)
		
		if hx > -1 or lx > -1 or sx > -1 then
			return 1
		end
		
		ex_gether(x,y)
		sh.show("当前剩余"..(bx - bingxian).."条兵线")
		if bingxian >= bx then
			return -1
		end
		return 0
	end
	return 1
end

function lookUp(bx,index,t)
	local orientations = {"上","右","下","左","上"}
	local indexs = { 1 , (index * 2) - 1 , index * 2, index * 2, index * 2 }
	local width,height = getScreenSize()
	
	mSleep(500)
	local task_type = fzk(t,bx)
	if task_type ~= 1 then
		return task_type
	end
	
	for i,ori in ipairs(orientations) do
		for tmpi=1,indexs[i] do
			touch.move(width,orientations[i])
			mSleep(500)
			local task_type = fzk(t,bx)
			if task_type ~= 1 then
				return task_type
			end
		end
	end
	return 1
end

function fo.start_gether(bx,t)
	findHome.openMap()
	gb()
	bingxian = 0
	mSleep(500)
	local index = 1
	while (true) 
	do
		x = lookUp(bx,index,t)
		if x == -1 then 
			break
		elseif x == 0 then
			index = 1
		else
			index = index + 1
		end
	end
	sh.show("采集完成")
	mSleep(500)
	zk()
end

return fo