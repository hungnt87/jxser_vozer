Include("\\script\\global\\login_head.lua")

function main(nItemIdx)
local nDate = tonumber(GetLocalDate("%d"))
if ( GetTask(DAY) ~= nDate ) then
	SetTask(DAY, nDate);
	SetTask(352,0);
	if (GetTask(352) <= 10000) then
		local k = random(1,100)
		SetTask(352,GetTask(352) + 1)
		if (k >= 95) then
			local x = random(1,100)
				if (x >= 90) then
					AddStackItem(2,4,2045,1,1,0,0,0)
					AddGlobalNews("��i hi�p <color=green>"..GetName().."<color> m� t�i Ho�ng Kim , may m�n nh�n ���c <color=gold>2 Kim Lo�i Hi�m<color> !")
					Msg2Player("M� c�m nang Ho�ng Kim, nh�n ���c 2 Kim Lo�i Hi�m")
				else
					AddStackItem(1,4,2045,1,1,0,0,0)
					AddGlobalNews("��i hi�p <color=green>"..GetName().."<color> m� t�i Ho�ng Kim , may m�n nh�n ���c <color=gold>Kim Lo�i Hi�m<color> !")
					Msg2Player("M� c�m nang Ho�ng Kim, nh�n ���c Kim Lo�i Hi�m")
				end
		elseif (k >=40) then
			local m = random (5,45)
			n = GetLevel()
			AddOwnExp(n*m*200)
		else
			Earn(20000)
		end
	else
		Talk(1,"","<color=green>H�m nay �� m� �� 10000 C�m nang Ho�ng Kim r�i, ng�y mai h�y m� ti�p<color>")
	end
	
else	--Sau khi da set ngay

if (GetTask(352) <= 10000) then
		local k = random(1,100)
		SetTask(352,GetTask(352) + 1)
		if (k >= 95) then
			local x = random(1,100)
				if (x >= 90) then
					AddStackItem(2,4,2045,1,1,0,0,0)
					AddGlobalNews("��i hi�p <color=green>"..GetName().."<color> m� t�i Ho�ng Kim , may m�n nh�n ���c <color=gold>2 Kim Lo�i Hi�m<color> !")
					Msg2Player("M� c�m nang Ho�ng Kim, nh�n ���c 2 Kim Lo�i Hi�m")
				else
					AddStackItem(1,4,2045,1,1,0,0,0)
					AddGlobalNews("��i hi�p <color=green>"..GetName().."<color> m� t�i Ho�ng Kim , may m�n nh�n ���c <color=gold>Kim Lo�i Hi�m<color> !")
					Msg2Player("M� c�m nang Ho�ng Kim, nh�n ���c Kim Lo�i Hi�m")
				end
		elseif (k >=40) then
			local m = random (5,45)
			n = GetLevel()
			AddOwnExp(n*m*200)
		else
			Earn(20000)
		end
	else
		Talk(1,"","<color=green>H�m nay �� m� �� 10000 C�m nang Ho�ng Kim r�i, ng�y mai h�y m� ti�p<color>")
	end

end
end 