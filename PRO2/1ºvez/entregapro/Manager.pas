{TITLE: PROGRAMMING II LABS
* SUBTITLE: Practical 2
* AUTHOR 1: Javier López Durán LOGIN 1: javier.lduran
* AUTHOR 2: Inés Faro Pérez LOGIN 2: ines.fperez
* GROUP: 3.1
* DATE: 03/05/19}

unit Manager;

interface

uses SharedTypes, CenterList, PartyList, RequestQueue;

type

	tManager = tListC;
	
	
	procedure createEmptyManager(VAR manager:tManager);
	function insertCenter (center :tCenterName; votes: tNumVotes; VAR manager: tManager): boolean;
	function insertPartyInCenter (center: tCenterName; party: tPartyName; VAR manager: tManager): boolean;
	function deleteCenters (VAR manager: tManager): integer;
	procedure deleteManager (VAR manager: tManager);
	procedure showStats(manager: tManager);
	function voteInCenter(center: tCenterName; party: tPartyName; VAR manager: tManager) : boolean;

	
implementation

	procedure createEmptyManager(VAR manager:tManager);
	
	begin
	
		createEmptyListC(manager);
		createEmptyList(manager.dato[INI].partyList);
		
	end;

(**********************************************************************)

	function insertCenter (center :tCenterName; votes: tNumVotes; VAR manager: tManager): boolean;
	
	var
	
		itemC: tItemC;
		partyN, partyB: tItem;
		L: tList;
	begin
		createEmptyList(L);
		partyB.partyname := BLANCKVOTE;
		partyN.partyname := 'N';
		partyN.numvotes := 0;
		partyB.numvotes := 0;
		itemC.centername := center;
		itemC.totalvoters := votes;
		itemC.validvotes := 0;
		
		if (insertItem(partyN, L) = TRUE) and insertItem(partyB, L) = TRUE then BEGIN
			itemC.partyList:=L;
			if insertItemC(itemC, manager) = TRUE then 	
				insertCenter := true
			else
				insertCenter := false;	
		end else
				insertCenter := false;	
END;
(**********************************************************************)

	function insertPartyInCenter (center: tCenterName; party: tPartyName; VAR manager: tManager): boolean;
	var
		pos: tPosC;	
		partido: tItem;
		itemC: tItemC;
	begin
		pos := findItemC(center, manager);
		if pos <> NULLC then begin
		itemC:= getItemC(pos,manager);
			if findItem(party, itemC.partyList) = NULL then begin
			partido.partyname := party;
			partido.numvotes := 0;
			insertItem(partido, itemC.partyList);
			insertPartyInCenter := true;
			end	
			else
				insertPartyInCenter := false;
		end else
			insertPartyInCenter:= FALSE;
	
	end;

(**********************************************************************)

	function deleteCenters (VAR manager: tManager): integer;
	var
		p: tPosC;
		cnt: integer;
		pl: tPosL;
		itemC: tItemC;
	begin
		
	if isEmptyListC(manager) then
		deleteCenters:= 0
	else begin
		cnt:= 0;
		p:=firstC(manager);
		while (p<> NULLC) do begin
			itemC:= getItemC(p, manager);
			if (itemC.validvotes = 0) then begin 
				writeln('* Remove: center ',itemC.centername);
				while not isEmptyList(itemC.partylist) do BEGIN
					pl:= first(itemC.partylist);
					deleteAtPosition(pl, itemC.partylist);
					updateListC(itemC.partylist, p, manager);
				end;
			deleteAtPositionC(p, manager);
			cnt:= cnt + 1;
			p:= firstC(manager);
		end;
		p:= nextC(p,manager);
	end;
	deleteCenters:= cnt;
	end;
end;
(**********************************************************************)

	procedure deleteManager (VAR manager: tManager);
	var
		pos: tPosC;
		partypos: tPosL;
		itemC: tItemC;
	begin
		pos := 1;
		while pos <> NULLC do begin
			itemC:= getItemC(pos,manager);
			partypos := first(itemC.partyList);
			while partypos <> NULL do begin	
				deleteAtPosition(partypos, itemC.partyList);
				partypos := first(itemC.partyList);						
			end;
			deleteAtPositionC(pos, manager);	
		end;
		pos := pos + 1;	
	end;

	
(**********************************************************************)

	procedure showStats(manager: tManager);	
	var
		itemC: tItemC;
		item: tItem;
		pos: tPosC;
		pos2: tPosL;	
		votosnulos: integer;
		w: tPosL;
			
	begin
		pos := firstC(manager);
				
		while pos <> NULLC do begin
			itemC := getItemC(pos,manager);
			writeln;
			writeln('Center ', itemC.centername);
			pos2 := first(itemC.partyList);
			while pos2 <> NULL do begin
				item := getItem(pos2, itemC.partyList);
				if item.partyname = 'N' then
					writeln('Party ',item.partyname, ' numvotes ', item.numvotes)
				else if itemC.validvotes = 0 then 
					writeln('Party ',item.partyname, ' numvotes ', item.numvotes,' (0.00%)')
				else
					writeln('Party ',item.partyname, ' numvotes ', item.numvotes, ' (',((item.numvotes/itemC.validvotes)*100):0:2,'%)');
				pos2 := next(pos2,itemC.partyList);
			end;
			if itemC.totalvoters = 0 then	
					writeln('Participation: ',itemC.validvotes, ' votes from ', itemC.totalvoters, ' voters (0.00%)')
			else
					w:= findItem('N', itemC.partylist);
					votosnulos:= getItem(w,itemC.partylist).numvotes;
					writeln('Participation: ',itemC.validvotes + votosnulos, ' votes from ', itemC.totalvoters, ' voters (',((((itemC.validvotes+votosnulos)/itemC.totalvoters))*100):0:2,'%)');
					writeln;
			pos := nextC(pos,manager);					
		end;							
end;

(**********************************************************************)

	function voteInCenter(center: tCenterName; party: tPartyName; VAR manager: tManager) : boolean;
	var
		pos: tPosC;
		lista: tPosL;
		partido, posnulo: tPosL;
		item: tItem;
		itemC: tItemC;
	begin
		pos := findItemC(center, manager);
		lista:= manager.dato[pos].partylist;
		partido:= findItem(party, lista);
		
		if partido = NULL then begin
			voteInCenter:= false;
			posnulo:= findItem('N', lista);
			item:= getItem(posnulo, lista);
			itemC:= getItemC(pos, manager);
			item.numvotes:= item.numvotes +1;
			updateVotes(item.numvotes, posnulo,lista);
			updateValidVotersC(itemC.validvotes,pos, manager);
			
		end else begin
			voteInCenter:= true;
			 item:= getItem(partido, lista);
			 itemC:= getItemC(pos, manager);
			 item.numvotes:= item.numvotes + 1;
			 updateVotes(item.numvotes, partido, lista);
			 itemC.validvotes:= itemC.validvotes +1;
			 updateValidVotersC(itemC.validvotes, pos, manager);
			 end;				
		end;
	


END.	
