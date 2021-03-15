{TITLE: PROGRAMMING II LABS
* SUBTITLE: Practical 2
* AUTHOR 1: Javier López Durán LOGIN 1: javier.lduran
* AUTHOR 2: Inés Faro Pérez LOGIN 2: ines.fperez
* GROUP: 3.1
* DATE: 03/05/19}

program main;

uses sysutils, Manager, SharedTypes, PartyList, CenterList, RequestQueue;

(**********************************************************************)

procedure create(code, request, param1, param2: string; var M: tManager);
var
	voters: tNumVotes;
begin
	voters := StrToInt(param2);
	writeln(code, ' ', request, ': center ', param1, ' totalvoters ', param2);
	writeln;
	if (insertCenter(param1, voters, M)= TRUE) then
		writeln('* Create: center ',param1, ' totalvoters ', param2)	
	else
		writeln('+ Error: Create not possible');	
end;

(**********************************************************************)
procedure New(code, request, param1, param2: string; var m:tManager);
BEGIN
		writeln(code, ' ', request,': center ', param1,' party ',param2);
		writeln;
		if (insertPartyInCenter(param1, param2,m)= TRUE) then 
			writeln('* New: center ',param1,' party ',param2)
		else
			writeln('+ Error: New not possible');	
END;
(**********************************************************************)
procedure Vote(code, request, param1, param2:string; var m:tManager);
BEGIN
	writeln(code, ' ', request,': center ',param1, ' party ', param2);
	writeln;
	if (voteInCenter(param1, param2,m) = TRUE) then
		writeln('* Vote: center ',param1,' party ', param2)
	else
		writeln('+ Error: Vote not possible. Party ',param2,' not found in center ',param1,'. NULLVOTE');
END;

(**********************************************************************)
procedure stats(code,request: string; M: tManager);
begin
	writeln(code, ' ', request,':');
	showStats(M);
end;

(**********************************************************************)
procedure Remove(code,request:string; var m:tManager);
BEGIN
	writeln(code, ' ', request,':');
	writeln;
	if deleteCenters(m)=0 then
		writeln('* Remove: no centers removed')
END;
(**********************************************************************)

procedure readTasks(filename:string);

VAR
   usersFile  : TEXT;
   line            : STRING;
   code          : STRING;
   param1,param2: string;
   request: char;
   M: tManager;
   itemQ: tItemQ;
   Q: tQueue;
 

BEGIN

   {proceso de lectura del fichero filename }

   {$i-} { Deactivate checkout of input/output errors}
   Assign(usersFile, filename);
   Reset(usersFile);
   {$i+} { Activate checkout of input/output errors}
   IF (IoResult <> 0) THEN BEGIN
      writeln('**** Error reading '+filename);
      halt(1)
   END;
	createEmptyQueue(Q);
	createEmptyManager(M);
	
   WHILE NOT EOF(usersFile) DO
	BEGIN
      { Read a line in the file and save it in different variables}
	ReadLn(usersFile, line);
	code := trim(copy(line,1,2));
	request:= line[4];
	param1 := trim(copy(line,5,10)); { trim removes blank spaces of the string}
                                         { copy(s, i, j) copies j characters of string s }
                                       { from position i }
	param2 := trim(copy(line,15,10));
	
	itemQ.code:= code;
	itemQ.request:= request;
	itemQ.param1:= param1;
	itemQ.param2:= param2;
	
	enqueue(Q, itemQ);
	writeln('********************');	
	case request of
	
	'C': create(itemQ.code, itemQ.request, itemQ.param1, itemQ.param2, M);
	'S': stats(itemQ.code, itemQ.request, M);
	'N': New(itemQ.code, itemQ.request, itemQ.param1, itemQ.param2,m);
	'V': Vote(itemQ.code, itemQ.request, itemQ.param1, itemQ.param2, m);
	'R': Remove(itemQ.code, itemQ.request, m);	
	end;
	dequeue(Q);

	END;

	Close(usersFile);
	
END;


{Main program}

BEGIN
   
    if (paramCount>0) then
        readTasks(ParamStr(1))
    else
        readTasks('vote.txt');
	
END.
