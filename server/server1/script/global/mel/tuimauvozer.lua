
Include("\\script\\lib\\alonelib.lua");
Include("\\script\\lib\\awardtemplet.lua")
Include("\\script\\misc\\eventsys\\type\\npc.lua");
Include("\\script\\dailogsys\\dailogsay.lua");

TAB_VATPHAM = {
	{szName="T�i m�u Vozer", tbProp={6,1,1781,1,0,0}, tbParam={9999}, nWidth=1, nHeight=1},

}

function tuimauvozer()
	local tbVPHT = TAB_VATPHAM;
	local nVoLamLenh = CalcEquiproomItemCount(6,1,4903,-1);
	if nVoLamLenh > 1 then
		AddItemByTable("��i t�i m�u Vozer", tbVPHT)
		ConsumeEquiproomItem(1,6,1,4903,-1)
	else
		Talk(1,"","B�n v�n ch�a �� V� L�m L�nh, h�y c� g�ng thu th�p th�m")
		return 1
	end
end

-- pEventType:Reg("T�nh n�ng th� nghi�m", "V�t ph�m h� tr�", VatPhamHoTro, {});
-- pEventType:Reg("L�nh b�i T�n Th�", "V�t ph�m h� tr�", VatPhamHoTro, {});
