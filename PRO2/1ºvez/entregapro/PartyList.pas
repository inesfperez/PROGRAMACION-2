{program RecuentoVotos;}
{TITLE: PROGRAMMING II LABS
* SUBTITLE: Practical 2
* AUTHOR 1: Javier López Durán LOGIN 1: javier.lduran
* AUTHOR 2: Inés Faro Pérez LOGIN 2: ines.fperez
* GROUP: 3.1
* DATE: 03/05/19}

unit PartyList;
interface
	
	const
		blanckvote = 'B'; 		//establece votos en blanco
		nullvote = 'N';			//establece votos nulos
		NULL= nil;				//asignamos una direección de memoria nula
		nulo=0;					//establecemos un valor 0
	type
		tPartyName = string;		//nombre de los partidos
		tNumVotes = integer;		//numero de votos de los partidos
		tItem = record				//registro que almacena nombre de los partidos y sus votos correspondientes
			PartyName: tPartyName;		
			NumVotes: tNumVotes;		
			end;
		tPosL = ^tNodo;	
		
		tNodo= record				//Registro que almacena partidos y votos con la direccion de memoria del siguiente elemento
			dato: tItem;
			sig: tPosL;
			end;
		tList=tPosL;				//Puntero que contiene la dirección de memoria de cada partido y sus votos además de la siguiente posición de memoria
		
			//puntero que va a almacenar la dirección de memoria del primer elemento de la lista
   
	procedure createEmptyList(VAR L:tList); 
	{	OBJETIVO: Crea una lista vacía.
		ENTRADA: Lista
		SALIDA: Lista vacía
		POSTCONDICIÓN: La lista queda inicializada y no contiene elementos.}
	function CreateNodo(var P:tPosL; item: tItem): tPosL;
	{	OBJETIVO: Crea el elemento deseado de la lista
		ENTRADA: Partido y numero de votos con la posición donde queremos introducirlo
		SALIDA: Lista con ese nuevo dato.}
	function isEmptyList(L:tList):boolean;
	{	OBJETIVO: Determina si la lista está vacía.
		ENTRADA: La lista.
		SALIDA: TRUE si la lista está vacía, FALSE en caso contrario.}
	function first(L:tList): tPosL;
	{	OBJETIVO: Obtener el primer elemento de la lista.
		ENTRADA: La lista
		SALIDA: La posición del primer elemento de la lista.
		PRECONDICIÓN: La lista no está vacía.}
	function last(L: tList): tPosL;
	{	OBJETIVO: Devolver la posición del último elemento de la lista.
		ENTRADA: La lista.
		SALIDA: La posición del último elemento de la lista.
		PRECONDICIÓN:La lista no está vacía.}
	function next(P:tPosL; L:tList):tPosL;
	{	OBJETIVO:Obtener la posición en la lista del elemento siguiente a la posición indicada o NULL si la posición no tiene siguiente.
		ENTRADA: La lista y la posición deseada.
		SALIDA: Devuelve la posición siguiente a la indicada, si no NULL.
		PRECONDICIÓN:La posición indicada es una posición válida en la lista.}
	function previous (P:tPosL; L:tList): tPosL;
	{	OBJETIVO:Devolver la posición de la lista del elemento anterior a la posición indicada o NULL si la posición no tiene anterior.
		ENTRADA: La lista y la posición deseada.
		SALIDA: Devuelce la posición anterior a la indicada si tiene, si no NULL.
		PRECONDICIÓN:La posición indicada es una posición válida en la lista.}
	function insertItem(d:tItem; VAR L:tList): boolean;  
	{	OBJETIVO: Inserta elemento en la lista antes de la posición indicada. Si la posición es NULL se añade al final. Devuelve true si 
				el elemento fue insertado; false en caso contrario.
		ENTRADA: El elemento, la posición donde queremos insertarlo y la lista.
		SALIDA: Devuelve la lista con el elemento insertado en la posición indicada (si la posición es NULL la añade al final), y devuelve
				true si el elemento se insertó, false en caso contrario.
		PRECONDICIONES: La posición indicada es una posición válida en la lista o bien nula (NULL).
		POSTCONDICIONES: Las posiciones de los elementos de la lista posteriores al insertado pueden cambiar de valor.}
	procedure deleteAtPosition(P:tPosL; VAR L:tList);  
	{	OBJETIVO: Elimina de la lista el elemento que ocupa la posición indicada.
		ENTRADA: La posición a borrar y la lista.
		SALIDA: La lista con la posición eliminada.
		PRECONDICIÓN: La posición indicada es una posición válida en la lista.
		POSTCONDICIÓN: Tanto la posición del elemento eliminado como aquellas de los elementos de la lista 
						a continuación del mismo pueden cambiar de valor.}
	function getItem(P:tPosL; L:tList): tItem;
	{	OBJETIVO: Devuelve el contenido del elemento de la lista que ocupa la posición indicada.
		ENTRADA: La posición del elemento que queremos obtener y la lista.
		SALIDA: El dato buscado en la lista.
		PRECONDICIÓN: La posición indicada es una posición válida en la lista.
		POSTCONDICIÓN:}
	procedure updateVotes(nv: tNumVotes; P:tPosL; VAR L:tList); 
	{	OBJETIVO: Modifica el número de votos del elemento situado en la posición indicada.
		ENTRADA: numero de votos que queremos modificar con su posición correspondiente y la lista.
		SALIDA: el numero de votos actualizado.
		PRECONDICIÓN: La posición indicada es una posición válida en la lista.
		POSTCONDICIÓN: El orden de los elementos de la lista no se ve modificado. }
	function findItem(name:tPartyName; L:tList): tPosL; 
	{	OBJETIVO: Devolver la posición del primer elemento de la lista cuyo nombre de partido
					se corresponda con el indicado (o NULL si no existe tal elemento).
		ENTRADA: El nombre del partido y la lista.
		SALIDA: La posición de la lista donde está ese partido.}

implementation
(**********************************************************************)
	procedure createEmptyList(var L:tList);
		begin
			L:=NULL; //Con asignar una dirección de memoria nula al primer elemento de la lista ya creamos la lista vacía.
		end;
(**********************************************************************)
	function CreateNodo( var p:tPosL; item: tItem):tPosL;
		begin
			new(p);
			if p<> NULL then begin
				p^.dato:=item;
				p^.sig:=NULL;
				end;
			CreateNodo:= p;
		end;
(**********************************************************************)
	function isEmptyList(L:tList):boolean;
		begin
			isEmptyList:=(L=NULL); 
		end;
(**********************************************************************)
function first(L:tList): tPosL;
		begin
			first:=L;
		end;
(**********************************************************************)
	function last(L: tList): tPosL;
		var
			q:tPosL;
		begin 
			q:=L;
			while (q^.sig<>NULL) do
				q:=q^.sig;
			last:=q; 
		end;
(**********************************************************************)
	function next(P:tPosL; L:tList):tPosL;
		begin 
			next:=P^.sig;
		end;
(**********************************************************************)
	function previous (P:tPosL; L:tList): tPosL;
		var
			q:tPosL;
		begin
			if P=L then
			previous:=NULL
			else begin
			q:=L;
				while (q^.sig<>P) do 
				q:=q^.sig;
			previous:=q;
			end; //end else
		end;
(**********************************************************************)
function insertItem (d:tItem; var L:tList):boolean;
var
	q,r:tPosL;
begin
		CreateNodo(q,d);
		if q = NULL then
			insertItem:= false
		else begin
			if isEmptyList(L) then begin
				L:= q;
				insertItem:= true;
			end else begin
				r:= first(L);
				while r^.dato.PartyName < d.PartyName do
					r:= next(r,L);
				q^.dato:=r^.dato;
				r^.dato:= d;
				q^.sig:= r^.sig;
				r^.sig:= q;
				
				insertItem:= true;
			end;
		end;
				
	
	end;

(**********************************************************************)
	procedure deleteAtPosition(P:tPosL; VAR L:tList);
		var
			q: tPosL;
		begin
			if L=P then
				L:=L^.sig
			else if P^.sig=NULL then begin
				q:=L;
					while q^.sig<> P do
					q:=q^.sig;
				q^.sig:=NULL;
			end //end if
			else begin 
				q:=P^.sig;
				P^.dato:=q^.dato;
				P^.sig:=q^.sig;
				P:=q;
			end; //end else
			dispose(P);
			
		end;
(**********************************************************************)
	function getItem(P:tPosL; L:tList): tItem;
		begin
			getItem:= p^.dato;
		end;
(**********************************************************************)
	procedure updateVotes(nv: tNumVotes; P:tPosL; VAR L:tList); 
		begin
			p^.dato.numvotes:=nv;
		end;
(**********************************************************************)
	function findItem(name:tPartyName; L:tList): tPosL; 
		begin
		while (L <> NULL) and (L^.dato.partyname <> name) do 
			L := L^.sig;
		findItem := L;
		end;
	
END.
