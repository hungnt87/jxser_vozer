Include("\\script\\mission\\sevencity\\war.lua")

--------------------------------------------------------------------

function Mo_TongKim(level)
	Battle_StartNewRound(1, level );
	zAddLocalCountNews = "Chi�n tr��ng T�ng Kim �ang trong giai �o�n b�o danh. C�c hi�p kh�ch mu�n tham gia h�y nhanh ch�ng ��n T��ng D��ng ho�c Chu Ti�n Tr�n �� b�o danh! (ho�c d�ng T�ng Kim chi�u th� )"
	GlobalExecute(format("dw Msg2SubWorld([[%s]])",zAddLocalCountNews))
	GlobalExecute(format("dw AddLocalCountNews([[%s]], 1)",zAddLocalCountNews))
end


function Mo_PhongHoaLienThanh(loai, phe)
	if (phe == 2) then
		OutputMsg("'V� qu�c li�n th�nh'   phe Kim �� b�t ��u b�o danh.");

		if loai == 1 then 
			GlobalExecute("dw CityDefence_OpenMain(2)");
		else
			GlobalExecute("dw NewCityDefence_OpenMain(2)");
		end
	else
		OutputMsg("'V� qu�c li�n th�nh'   T�ng �� b�t ��u b�o danh.");
		if loai == 1 then 
			GlobalExecute("dw CityDefence_OpenMain(1)");
		else
			GlobalExecute("dw NewCityDefence_OpenMain(1)");
		end
	end
end