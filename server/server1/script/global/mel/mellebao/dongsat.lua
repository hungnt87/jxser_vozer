Include("\\script\\lib\\awardtemplet.lua")
local tbItem = 
{
	{szName="[C�c ph�m] ��ng S�t B�ch Kim �i�u Long Gi�i", nQuality=1, tbProp={0, 494}, nBindState = -2},
	{szName="[C�c ph�m] ��ng S�t B�ch Ng�c C�n Kh�n B�i", nQuality=1, tbProp={0, 495}, nBindState = -2},
	{szName="[C�c ph�m] ��ng S�t B�ch Kim T� Ph�ng Gi�i", nQuality=1, tbProp={0, 496}, nBindState = -2},
	{szName="[C�c ph�m] ��ng S�t Ph� Th�y Ng�c H�ng Khuy�n", nQuality=1, tbProp={0, 497}, nBindState = -2},
}
function main()
	
	if  CountFreeRoomByWH(2, 5, 1) < 1 then
		Talk(1, "", format("�� b�o ��m t�i s�n c�a ��i hi�p, xin h�y �� tr�ng %d %dx%d h�nh trang", 1, 2, 5))
		return 1
	end
	
	
	tbAwardTemplet:GiveAwardByList(%tbItem, "��ng S�t")
	
end