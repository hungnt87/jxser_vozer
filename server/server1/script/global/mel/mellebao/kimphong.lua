Include("\\script\\lib\\awardtemplet.lua")
local tbItem = 
{
		{szName="Kim Phong Thanh D��ng Kh�i", tbProp={0,177}, nQuality=1, nBindState=-2},
		{szName="Kim Phong K� L�n Huy�t", tbProp={0,178}, nQuality=1, nBindState=-2},
		{szName="Kim Phong Tr�c Li�n Quang", tbProp={0,179}, nQuality=1, nBindState=-2},
		{szName="Kim Phong C�ng C�n Tam Th�n", tbProp={0,180}, nQuality=1, nBindState=-2},
		{szName="Kim Phong �o�t H�n Ng�c ��i", tbProp={0,181}, nQuality=1, nBindState=-2},
		{szName="Kim Phong H�u Ngh� d�n cung", tbProp={0,182}, nQuality=1, nBindState=-2},
		{szName="Kim Phong Lan ��nh Ng�c", tbProp={0,183}, nQuality=1, nBindState=-2},
		{szName="Kim Phong Thi�n L� Th�o Th��ng Phi", tbProp={0,184}, nQuality=1, nBindState=-2},
		{szName="Kim Phong ��ng T��c Xu�n Th�m", tbProp={0,185}, nQuality=1, nBindState=-2},
}
function main()
	
	if (CalcFreeItemCellCount() < 40) then
		Talk(1, "", "H�nh trang kh�ng �� 40 � tr�ng �� nh�n.")
	return 1
	end
	
	
	tbAwardTemplet:GiveAwardByList(%tbItem, "Kim Phong")
	
end