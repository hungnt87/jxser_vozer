SimCityTieuThiep = {}

function createTaskSayTieuThiep(extra)
	local tbOpt = {}

	local name = GetName()

	local foundId
	local foundName = "V� K�"

	local found = SimCityTieuThiep:retrieveMine()
	if getn(found) > 0 then
		fighter = SimTheoSau.fighterList[found[1]]
		foundId = fighter.nNpcId
		foundName = fighter.szName
	end

	local saying = extra or "Nh�n sinh nh� m�ng, tr��ng l�u v� t�n, g�p g� ch� l� tho�ng qua"

	local nSettingIdx = foundId or 103


	local nActionId = 1
	tinsert(tbOpt, 1, "<dec><link=image[0,10]:#npcspr:?NPCSID="..tostring(nSettingIdx).."?ACTION="..tostring(nActionId)..">"..foundName..":<link> "..saying);
	return tbOpt
end

function SimCityTieuThiep:retrieveMine()
	local name = GetName()
	local found = {}
	for key, fighter in SimTheoSau.fighterList do
        if fighter.playerID == name and fighter.mode == "tieuthiep" then
            tinsert(found, key)
        end
    end
	return found
end

function SimCityTieuThiep:taoNV(id, camp, mapID, map, nt, theosau, capHP, extraConfig)
	local name = GetName()
	local rank = 1

	local tbNpc = {

		szName = SimCityNPCInfo:generateName(),

		nNpcId = id,   -- required, main char ID
		nMapId = mapID, -- required, map
		camp = camp,   -- optional, camp

		walkMode = "random", -- optional: random, keoxe, or 1 for formation
		walkVar = 2,   -- random walk of radius of 4*2
		

		noStop = 1,          -- optional: cannot pause any stop (otherwise 90% walk 10% stop)
		leaveFightWhenNoEnemy = 1, -- optional: leave fight instantly after no enemy, otherwise there's waiting period

		noRevive = 0,        -- optional: 0: keep reviving, 1: dead

		CHANCE_ATTACK_PLAYER = 1, -- co hoi tan cong nguoi choi neu di ngang qua
		CHANCE_ATTACK_NPC = 1, -- co hoi bat chien dau khi thay NPC khac phe
		CHANCE_JOIN_FIGHT = 1, -- co hoi tang cong NPC neu di ngang qua NPC danh nhau
		RADIUS_FIGHT_PLAYER = 15, -- scan for player around and randomly attack
		RADIUS_FIGHT_NPC = 10, -- scan for NPC around and start randomly attack,
		RADIUS_FIGHT_SCAN = 10, -- scan for fight around and join/leave fight it
 
		kind = 3,            -- quai mode
		TIME_FIGHTING_minTs = 1800*18/REFRESH_RATE,
		TIME_FIGHTING_maxTs = 3000*18/REFRESH_RATE,
		TIME_RESTING_minTs = 60*18/REFRESH_RATE,
		TIME_RESTING_maxTs = 120*18/REFRESH_RATE,


		ngoaitrang = nt or 0,

		childrenSetup = theosau or nil,
		childrenCheckDistance = (theosau and 8) or nil, -- force distance check for child

		playerID = name,
		capHP = capHP,
		role = "keoxe",
		mode = "tieuthiep"
	};
	if extraConfig then
		for k, v in extraConfig do
			tbNpc[k] = v
		end
	end
	return SimTheoSau:New(tbNpc);
end



function SimCityTieuThiep:nhanTieuThiep(id)

	local xemNpcIds = { 
		{1198, "Tri�u M�n"},
		{1309, "T�n H�ng Mi�n"},
		{1332, "Cam B�o B�o"},
		{1360, "A Ch�u"},
		{1439, "Lam Ph��ng Ho�ng"},
		{1504, "Nh�m Doanh Doanh"},
		{1678, "Chu Ch� Nh��c"},
		{1679, "�ao B�ch Ph��ng"},
		{1770, "Ho�ng Dung"},
		{2424, "�n Ly"},
	}

	if id < 1 then
		id = 1
	end
	if id > getn(xemNpcIds) then
		id = 1
	end

	local tbOpt = {}
	local nSettingIdx = xemNpcIds[id][1]
	local nName = xemNpcIds[id][2]
	local nActionId = 1
	tinsert(tbOpt, 1, "<dec><link=image[0,108]:#npcspr:?NPCSID="..tostring(nSettingIdx).."?ACTION="..tostring(nActionId).."><link>Duy�n t�nh ng� tr�m n�m, nh�ng khi t�nh gi�c th� ng��i �� b� �i.<enter><enter>Ng��i c� mu�n <color=yellow>"..nName.."<color> h�nh t�u giang h� c�ng ng��i? ");		
	
	local found = self:retrieveMine()
	if getn(found) > 0 then
		fighter = SimTheoSau.fighterList[found[1]]		
		tinsert(tbOpt, "�a t�, duy�n t�nh v�i "..fighter.szName.." dang d� t�i ��y/#SimCityTieuThiep:RemoveAll()")		
	end


	tinsert(tbOpt, format("K�t duy�n c�ng %s (10 v�n)/#SimCityTieuThiep:nhanTieuThiepConfirm('%s', %s)", nName, nName, nSettingIdx))	


	tinsert(tbOpt, "Xem ti�p/#SimCityTieuThiep:nhanTieuThiep("..(id+1)..")")
	tinsert(tbOpt, "K�t th�c ��i tho�i./no")
	CreateTaskSay(tbOpt)

	return 1
end

function SimCityTieuThiep:nhanTieuThiepConfirm(name, id)
	if GetCash() < 100000 then
		local tbOpt = createTaskSayTieuThiep("K�t duy�n kh�ng ph�i chuy�n ��n gi�n, ti�n b�c l� c�n thi�t. N�u ch�a ��, th�i ��nh ��i th�m th�i gian.")
		tinsert(tbOpt, "K�t th�c ��i tho�i./no")
		CreateTaskSay(tbOpt)
		return 1
	end
	local forCamp = GetCurCamp()
	local pW, pX, pY = GetWorldPos()
	self:RemoveAll()
	Pay(100000)
	self:taoNV(id, forCamp, pW, 1, 0, {}, 1, {
		szName = name,
		nSettingsIdx = id,
		series = 2,
		kind = 3,
		faction = "ngami",
		skillHoTro = 5,
		skillTranPhai = {109, 20},
		skillCastBua = {93, 20}
	})
end
 

function SimCityTieuThiep:GoiPTToiNoi()
    local nW, nX, nY = GetWorldPos();
    local nFightMode = GetFightState();

    local nPreservedPlayerIndex = PlayerIndex;
    local nMemCount = GetTeamSize(); 

    if (nMemCount == 0) then
		Msg2Player("Kh�ng c� ai trong PT �� g�i")
        return 0
    end


    for i = 1, nMemCount do
        PlayerIndex = GetTeamMember(i); 
        SetFightState(nFightMode)
        NewWorld(nW, nX, nY);
    end;

    PlayerIndex = nPreservedPlayerIndex;
    return 0
end

function SimCityTieuThiep:DenNoiTeXe()
    local nW = GetTask(801)
    local nX = GetTask(802)
    local nY = GetTask(803)
    if (nW ~= nil and nX ~= nil and nY ~= nil and nW > 0 and nY > 0 and nX > 0) then
        NewWorld(nW, nX, nY)
        SetFightState(1)
        SetTask(801, 0)
    else
        ReturnFromPortal()
    end
end

function SimCityTieuThiep:GoiBangToiNoi()
    local szTongName, nTongID   = GetTongName()
    local nMemberID             = TONG_GetFirstMember(nTongID, -1);
    local nPreservedPlayerIndex = PlayerIndex;
    local nW, nX, nY            = GetWorldPos();
    local nFightMode            = GetFightState();

    while (nMemberID > 0) do
        local pName = TONGM_GetName(nTongID, nMemberID)
        local index = SearchPlayer(pName)
        if index ~= nPreservedPlayerIndex and index > 0 then
            PlayerIndex = index
            SetFightState(nFightMode)
            NewWorld(nW, nX, nY) 
        end

        nMemberID = TONG_GetNextMember(nTongID, nMemberID, -1)
    end

    PlayerIndex = nPreservedPlayerIndex
end

function SimCityTieuThiep:trieuhoi()
	local tbOpt = createTaskSayTieuThiep()
	tinsert(tbOpt, "G�i PT ��n ��y/SimCityTieuThiep:GoiPTToiNoi()")
	tinsert(tbOpt, "G�i bang ��n ��y/SimCityTieuThiep:GoiBangToiNoi()")
	tinsert(tbOpt, "Quay l�i/#SimCityTieuThiep:mainMenu()")
	tinsert(tbOpt, "K�t th�c ��i tho�i./no")
	CreateTaskSay(tbOpt)
end

function SimCityTieuThiep:muathuoc(saying)
	local tbOpt = createTaskSayTieuThiep(saying)

	tinsert(tbOpt, "Cho ta xin �t thu�c/#SimCityTieuThiep:nhan5hoa()")
	tinsert(tbOpt, "Cho ta xin TDP/#SimCityTieuThiep:nhanTDP()")
	tinsert(tbOpt, "Cho ta xin �t ti�n/#SimCityTieuThiep:nhanTien()")
 
	tinsert(tbOpt, "Quay l�i/#SimCityTieuThiep:mainMenu()")
	tinsert(tbOpt, "K�t th�c ��i tho�i./no")
	CreateTaskSay(tbOpt)
end

function SimCityTieuThiep:nhan5hoa()
	local nW, nX, nY = GetWorldPos()
	for i=1, 25 do
		DropItem(SubWorldID2Idx(nW), nX*32, nY*32, -1, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	end
end

function SimCityTieuThiep:nhanTDP()
	local nW, nX, nY = GetWorldPos()
	for i=1, 3 do
		DropItem(SubWorldID2Idx(nW), nX*32, nY*32, -1, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	end
end

function SimCityTieuThiep:nhanTien()
	if random(1, 100) <= 90 then
		return self:muathuoc("Xin th� l�i, thi�p ch�ng ti�n can d� chuy�n ti�n b�c, mong ch�ng hi�u cho n�i kh� x� n�y.")
	end

	local amount = random(1, 5)
	Earn(amount*10000)
	local tbOpt = createTaskSayTieuThiep("Nam t� h�n ��i tr��ng phu, ai ng� l�i khi�n <color=yellow>n� nhi ta ph�i r�t h�u bao<color> tr��c. M�ng ��c m�t m�i nh� tranh hai qu� tim v�ng ��y sao?<enter><enter>Cho ng��i <color=yellow>"..amount.." v�n<color>.")
	tinsert(tbOpt, "K�t th�c ��i tho�i./no")
	CreateTaskSay(tbOpt)
	
	return 1
end
function SimCityTieuThiep:mainMenu()

	local tbOpt = createTaskSayTieuThiep()
	local name = GetName()
	local isStanding = 0
	local found = self:retrieveMine()
	if getn(found) > 0 then
		fighter = SimTheoSau.fighterList[found[1]]
		if fighter.isStanding == 1 then
			isStanding = 1
		end
	end
	if isStanding == 1 then
		tinsert(tbOpt, "H�y �i theo ta/#SimCityTieuThiep:SetStanding(0)")
	else
		tinsert(tbOpt, "H�y ��ng l�i ��y ch� ta/#SimCityTieuThiep:SetStanding(1)")
	end

	tinsert(tbOpt, "L�y thu�c, th� ��a ph�/#SimCityTieuThiep:muathuoc()")
	tinsert(tbOpt, "G�i th�nh vi�n PT, bang h�i/#SimCityTieuThiep:trieuhoi()")
	tinsert(tbOpt, "T�o b�i luy�n c�ng/#SimCityTieuThiep:luyencong()")
	tinsert(tbOpt, "T�m V� K�, Tri�u M�n v� L�o ��ng V�t/#SimCityTieuThiep:simcityMenu()")	
	tinsert(tbOpt, "��n n�i t� xe/#SimCityTieuThiep:DenNoiTeXe()")

	tinsert(tbOpt, "K�t th�c ��i tho�i./no")
	CreateTaskSay(tbOpt)
	return 1
end

function SimCityTieuThiep:SetStanding(isStanding)
	local name = GetName()
	local found = self:retrieveMine()
	if getn(found) > 0 then
		fighter = SimTheoSau.fighterList[found[1]]
		fighter.isStanding = isStanding
	end

	local saying = "Ch�ng ta ti�p t�c l�n ���ng!"
	if isStanding == 1 then
		saying = "Ta ��ng ��y ch� ng��i, h�y quay l�i ��n ta nh�."
	end
	local tbOpt = createTaskSayTieuThiep(saying)
	tinsert(tbOpt, "K�t th�c ��i tho�i./no")
	CreateTaskSay(tbOpt)
	return 1
end


function SimCityTieuThiep:simcityMenu()	
	local tbOpt = createTaskSayTieuThiep()
	tinsert(tbOpt, "G�p Tri�u M�n (th�nh th�)/#SimCityThanhThi:mainMenu()")
	tinsert(tbOpt, "G�p V� K� (k�o xe)/#SimCityKeoXe:mainMenu()")
	tinsert(tbOpt, "G�p L�o ��ng V�t (th� c�ng)/#SimCityVatNuoi:mainMenu()")
	tinsert(tbOpt, "Quay l�i/#SimCityTieuThiep:mainMenu()")
	tinsert(tbOpt, "K�t th�c ��i tho�i./no")
	CreateTaskSay(tbOpt)
	return 1
end


function SimCityTieuThiep:RemoveAll()
	local name = GetName()

	 
	local found = self:retrieveMine()
	if getn(found) > 0 then
		fighter = SimTheoSau.fighterList[found[1]]
		SimTheoSau:Remove(fighter.id)
	end
end

function SimCityTieuThiep:askBaiLevel()
	g_AskClientNumberEx(0, 110, "C�p qu�i", { self.askBaiLevel_confirm , {self}})
end
function SimCityTieuThiep:askBaiLevel_confirm(inp)
	local level = tonumber(inp)
	level = floor(level/10) * 10
	self:TaoBai(level)
end
function SimCityTieuThiep:luyencong()
	local tbOpt = createTaskSayTieuThiep()
	tinsert(tbOpt, "T� ��ng/#SimCityTieuThiep:TaoBai(999)")
	tinsert(tbOpt, "Ch�n c�p/#SimCityTieuThiep:askBaiLevel()")
	tinsert(tbOpt, "X�a qu�i xung quanh/#SimCityTieuThiep:XoaBai()")
	tinsert(tbOpt, "Quay l�i/#SimCityTieuThiep:mainMenu()")
	tinsert(tbOpt, "K�t th�c ��i tho�i./no")
	CreateTaskSay(tbOpt)
end

function SimCityTieuThiep:XoaBai()
	local fighterList = GetAroundNpcList(30)
	local pW, pX, pY = GetWorldPos()

	local tmpFound = {}
	local nNpcIdx
	for i = 1, getn(fighterList) do
		nNpcIdx = fighterList[i]
		local kind = GetNpcKind(nNpcIdx)
		local nSettingIdx = GetNpcSettingIdx(nNpcIdx)
		if nSettingIdx > 0 and kind == 0 then
			DelNpcSafe(nNpcIdx)
		end
	end
	return 0
end

function SimCityTieuThiep:TaoBai(forceLevel)
	-- Tam thoi xoa xe de tao NPC tu dong neu khong se copy NPC tu xe vao luon
	 

	local fighterList = GetAroundNpcList(60)
	local pW, pX, pY = GetWorldPos()

	local tmpFound = {}
	local nNpcIdx
	for i = 1, getn(fighterList) do
		nNpcIdx = fighterList[i]
		local nSettingIdx = GetNpcSettingIdx(nNpcIdx)
		local name = GetNpcName(nNpcIdx)
		local level = NPCINFO_GetLevel(nNpcIdx)
		local kind = GetNpcKind(nNpcIdx)
		if nSettingIdx > 0 and kind == 0 then
			tinsert(tmpFound, { nSettingIdx, name, level })
		end
	end
	local total = getn(tmpFound)

	if total == 0 then
		return 0
	end
	local j = 0
	while j < 20 do
		local data = tmpFound[random(1, total)]
		local isBoss = 0
		if (j == 10) then
			isBoss = 2
		end
		local targetLevel = data[3]
		if (forceLevel < 999 and ((targetLevel > forceLevel) or (targetLevel > 90))) then
			targetLevel = forceLevel
		end
		local nNpcIndex = AddNpcEx(data[1], targetLevel, random(0, 4), SubWorldID2Idx(pW), (pX + random(-5, 5)) * 32,
			(pY + random(-5, 5)) * 32, 0, data[2], isBoss)
		if nNpcIndex > 0 then
			j = j + 1
		end
	end
	return 0
end