{program RecuentoVotos;}
{TITLE: PROGRAMMING II LABS
* SUBTITLE: Practical 2
* AUTHOR 1: Javier López Durán LOGIN 1: javier.lduran
* AUTHOR 2: Inés Faro Pérez LOGIN 2: ines.fperez
* GROUP: 3.1
* DATE: 03/05/19}

unit CenterList;
interface
 uses SharedTypes, PartyList;	
 const
	NULLC = 0;
	beg = 1;
	MAX = 25;
	
 type	
 	tNumVotes = integer; 	
 	tPartyName = string; 		
	tItemC = record 
		centername: tCenterName;
		totalvoters: tNumVotes;
		validvotes: tNumVotes;
		partyList: tList;
		end;
	tPosC = NULLC .. MAX; 
	tListC = record 
		dato: array[beg..MAX] of tItemC;
		index: tPosC;		
		end;				
		
	procedure createEmptyListC(var L: tListC);
	function isEmptyListC(L: tListC): boolean;
	function firstC(L: tListC): tPosC;
	function lastC(L: tListC): tPosC;
	function nextC(p: tPosC; L: tListC): tPosC;
	function previousC(p: tPosC; L: tListC): tPosC;
	function insertItemC(I: tItemC; var L: tListC): boolean;
	procedure deleteAtPositionC(p: tPosC; var L: tListC);
	function getItemC(p: tPosC; L: tListC): tItemC;
	function updateValidVotersC(nv: tNumVotes; p: tPosC; var L: tListC):tListC;
	procedure updateListC(L: tList; p: tPosC; var LC: tListC);
	function findItemC(cn: tCenterName; L: tListC):tPosC;

implementation 

	procedure createEmptyListC(var L: tListC);
	begin	
		L.index := NULLC;		
	end;
				
(**********************************************************************)
	function isEmptyListC(L: tListC): boolean;
	begin
		isEmptyListC := (L.index = NULLC);
	end;
		
(**********************************************************************)

	function firstC(L: tListC): tPosC;
	begin	
		firstC := beg;				
	end;
		
(**********************************************************************)

	function lastC(L: tListC): tPosC;
	begin
		lastC := L.index;
	end;

(**********************************************************************)

	function nextC(p: tPosC; L: tListC): tPosC;
	begin
		if p = L.index then
			nextC := NULLC
		else
			nextC := p + 1;	
		
	end;
		
(**********************************************************************)

	function previousC(p: tPosC; L: tListC): tPosC;	
	begin
		if p = firstC(L) then
			previousC := NULLC
		else
			previousC := p - 1;	
		
	end;
		
(**********************************************************************)

	function insertItemC(I: tItemC; var L: tListC): boolean;
	var
		w : tPosC;
	begin
		if L.index = MAX then 
			insertItemC := false
		else begin
			if isEmptyListC(L) then begin 
				insertItemC := true;
				L.index:= L.index + 1; 
				L.dato[beg] := I;
			end else begin
				insertItemC := true;
				L.index:= L.index + 1; 
				w := L.index;
				L.dato[w] := I;
				while L.dato[w-1].centername > I.centername do begin
					L.dato[w] := L.dato[w-1];
					w := w - 1;
				end;
				L.dato[w] := I;
			end;	
		end;
	
end;
	
(**********************************************************************)

	procedure deleteAtPositionC(p: tPosC; var L: tListC);
	var
		i: tPosC;
	begin
		L.index := L.index - 1; 
		for i := p to L.index do
			L.dato[i] := L.dato[i+1];
	end;	

(**********************************************************************)

	function getItemC(p: tPosC; L: tListC): tItemC;
	begin
		getItemC := L.dato[p];
	end;
		
(**********************************************************************)
	
	function updateValidVotersC(nv: tNumVotes; p: tPosC; var L: tListC):tListC;
	begin	
		L.dato[p].validvotes := nv;
		updateValidVotersC:= L;
	end;

(**********************************************************************)

	procedure updateListC(L: tList; p: tPosC; var LC: tListC);
	begin
		LC.dato[p].partylist := L;	
	end;
		
(**********************************************************************)
 
	function findItemC(cn: tCenterName; L: tListC):tPosC;
	var	
		p: tPosC;
			
	begin
			p := firstC(L);
			while (p < L.index) and (L.dato[p].centername <> cn) do
				p := nextC(p,L);
			if (L.dato[p].centername = cn) then
				findItemC := p
			else
				findItemC := NULLC;
	end;		

			
END.



