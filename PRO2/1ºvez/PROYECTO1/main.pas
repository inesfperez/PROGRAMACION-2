{program RecuentoVotos;}
{TITLE: PROGRAMMING II LABS
* SUBTITLE: Practical 1
* AUTHOR 1: Javier López Durán LOGIN 1: javier.lduran
* AUTHOR 2: Inés Faro Pérez LOGIN 2: ines.fperez
* GROUP: 3.1
* DATE: 15/03/19}

USES sysutils, DynamicList;

	procedure readTasks(filename:string );
	
	VAR
	usersFile: TEXT;
	code 	     :string;
	line          : STRING;
	task          : STRING;
	partyOrVoters : STRING;
	p:tPosL;
	participation: integer;
	a: tItem;
	PartyList: tList;
(**********************************************************************)	
	procedure Stats(partyOrVoters:string; VAR L:tList);
	var
	votenull: integer;
	voters: integer;
	z:tPosL;
	begin
	z:=findItem(nullvote,PartyList);   //Posicion partido nulo
	
	writeln;
	
		participation:= 0;
		p:=first(PartyList);
		while (p<> NULL) do begin
			participation:= participation + getItem(p,PartyList).NumVotes;
			p:= next(p,PartyList);
		end;
		
		votenull:=getItem(z,PartyList).numvotes;
		
		p:= first(PartyList);
		if participation = 0 then begin
			participation:= participation + 1;
			voters:=0;
		end
		else 	
			voters:= participation;
			
		if (votenull>=participation) then
			participation:= votenull +1;
			
		while (p<>NULL) do begin
			if getItem(p,PartyList).PartyName = 'N' then
				writeln('Party ' , getItem(p,PartyList).PartyName, ' numvotes ' , getItem(p,PartyList).NumVotes )
				
			else
				writeln('Party ' , getItem(p,PartyList).PartyName, ' numvotes ' , getItem(p,PartyList).NumVotes , ' (' , (getItem(p,PartyList).NumVotes)*100 / (participation-votenull):4:2, '%) ');
		p:=next(p,PartyList); 
		end;
		
		writeln('Participation: ' ,voters, ' votes from ' , partyOrVoters,' voters (' ,(voters*100)/StrToInt(partyOrVoters):4:2, '%)');
	end;
(**********************************************************************)
	procedure New(partyOrVoters:string; VAR L: tList);
	begin
		
		writeln;
		a.PartyName:=partyOrVoters;
		a.NumVotes:=0;
		if findItem(partyOrVoters, PartyList) = NULL then begin //Si la posicion es nula quiere decir que hay espacio para crear el nuevo partido
			writeln('* New: party ',partyOrVoters);				//Impriome un mensaje y establece los votos del nuevo partido a 0
			
			insertItem(a,NULL, PartyList)					
		end
		else
			writeln('+ Error: New not possible');				//si no hay espacio o ya existe, no se crea e imprimira un mensaje de error
	end; 
(**********************************************************************)
	procedure Vote(partyOrVoters:string; VAR L: tList);
	var
	w, y: tPosL;
	begin
		
		writeln;
		w:= findItem(nullvote,PartyList); 		{Posicion del partido nulo}
		y:= findItem(partyOrVoters,PartyList);  {Posicion del partido al cual queremos sumar voto}
		if y = NULL then begin         			// Si la posicion del partido es nula, no se suman votos y se suma 1 al partido nulo
			writeln('+ Error: Vote not possible. Party ', partyOrVoters,' not found. NULLVOTE');
			updateVotes(getItem(w,PartyList).NumVotes+1, w ,PartyList);
		end;
		if findItem(partyOrVoters,PartyList) <> NULL then begin											//Si no, pues suma un voto al partido que se introduce
		updateVotes(getItem(y,PartyList).NumVotes+1, y ,PartyList);
		writeln('* Vote: party ', partyOrVoters, ' numvotes ', getItem(y,PartyList).NumVotes);
		end;
	end;
(**********************************************************************)
	procedure Illegalize(partyOrVoters:string; VAR L:tList);
	var
		w, y: tPosL;
	begin
		
		writeln;
		w:= findItem(nullvote,PartyList);		{Posicion partido nulo}
		y:= findItem(partyOrVoters,PartyList);	{Posicion del partido}
		if (findItem(partyOrVoters, PartyList) = NULL) then  //Si la posicion del partido es nula, es decir, el partido no existe, entonces imprime un mensaje en el que da error
			writeln('+ Error: Illegalize not possible')
		else begin											 //Si existe, los votos del partido pasan al partido nulo y se borra el partido indicado; imprimiendo un mensaje
			writeln('* Illegalize: party ', partyOrVoters);
			updateVotes(getItem(w,PartyList).NumVotes + getItem(y,PartyList).NumVotes, w,PartyList);
			deleteAtPosition(y, PartyList);
		end;	
	end;
(**********************************************************************)			    
BEGIN
  
   {process the operation file named filename}

   {$i-} { Deactivate checkout of input/output errors}
   Assign(usersFile, filename);
   Reset(usersFile);
   {$i+} { Activate checkout of input/output errors}
   IF (IoResult <> 0) THEN BEGIN
      writeln('**** Error reading '+filename);
      halt(1)
   END;
	createEmptyList(PartyList);
   WHILE NOT EOF(usersFile) DO
   BEGIN
		writeln('********************'); 
      { Read a line in the file and save it in different variables}
      ReadLn(usersFile, line);
      code := trim(copy(line,1,2));
      task:= line[4];
      partyOrVoters := trim(copy(line,5,8));  { trim removes blank spaces of the string}
                                          { copy(s, i, j) copies j characters of string s }
                                          { from position i } 
      
      {Show the task --> Change by the adequate operation} 
      if (task = 'S') then begin
		writeln(code, ' ',task, ': totalvoters ', partyOrVoters);
        Stats(partyOrVoters,PartyList);
        end
	  else begin
	  writeln(code, ' ',task, ': party ', partyOrVoters);
	  CASE task of
		'N': New(partyOrVoters, PartyList);
		'V': Vote(partyOrVoters, PartyList);
		'I': Illegalize(partyOrVoters, PartyList);
	  end; 
	end;
  end;
   Close(usersFile);

end;

{Main program}
BEGIN

	if (paramCount>0) then
		readTasks(ParamStr(1))
	else
		readTasks('vote.txt');

END.
