function TaskShedule()
	TaskName("Boss ��i Ho�ng Kim 21:00")
	TaskTime(21,0);
	
	--���ü��ʱ�䣬��λΪ����
	TaskInterval(1440) --60����һ��
	
	--���ô���������0��ʾ���޴���
	TaskCountLimit(0)
	OutputMsg("================[START BOSS HOANG KIM [21:00 PM] ]==================");
end

function TaskContent()
	GlobalExecute("dwf \\script\\global\\pgaming\\missions\\bosshoangkim\\bossdai\\goldboss_main.lua bigboss_call2world()")
	OutputMsg("============[RUN BOSS HOANG KIM [21:00 PM] ]=============");
end

function GameSvrConnected(dwGameSvrIP)
end
function GameSvrReady(dwGameSvrIP)
end