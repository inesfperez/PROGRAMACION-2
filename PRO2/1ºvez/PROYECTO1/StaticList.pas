{program RecuentoVotos;}
{TITLE: PROGRAMMING II LABS
* SUBTITLE: Practical 1
* AUTHOR 1: Javier López Durán LOGIN 1: javier.lduran
* AUTHOR 2: Inés Faro Pérez LOGIN 2: ines.fperez
* GROUP: 3.1
* DATE: 15/03/19}

unit StaticList;

interface

 const
  max = 25;
  blanckvote = 'B';
  nullvote = 'N';
  nulo = 'NULL';
  NULL = 0;
 type
  tPartyName = string;
  tNumVotes = integer;
  tItem = record
           PartyName: tPartyName;
           NumVotes: tNumVotes;
           end;
  tPosL = NULL..max; 
  tList = record
          dato: array [1..max] of tItem;
          index: tPosL;
          end;
   
 procedure createEmptyList(VAR L:tList); 
 {Objetivo: Crear una lista vacía.
 ENTRADA: Lista
 SALIDA: Lista vacía
  PostCD: La lista queda inicializada y no contiene elementos.}
 
 function isEmptyList (L:tList): boolean;
{Con comprobar que el indice de la lista es 0 ya sabemos si está vacía
 ENTRADA:Lista
 SALIDA: TRUE si está vacía/ FALSE si no lo está
Objetivo: Determinar si la lista está vacía. }
 function first(L:tList): tPosL;
{Objetivo: Devolver la posición del primer elemento de la lista.
ENTRADA: Lista
SALIDA:	Posicion del 1 elemento
PreCD: La lista no puede estar vacía}
 function last(L: tList): tPosL;
{Objetivo: Devolver la posición del último elemento de la lista.
ENTRADA: Lista
SALIDA: Posicion del ultimo elemento
PreCD: La lista no puede estar vacía.}
 function next(P:tPosL; L:tList):tPosL;
{Objetivo: Devolver la posición en la lista del elemento siguiente a la posición indicada
(NULL si la posición no tiene siguiente).
ENTRADA: Posicion y lista
SALIDA: Siguiente elemento de la lista al de la posicion indicada
PreCD: La posición indicada es válida en la lista.}
 function previous (P:tPosL; L:tList): tPosL;
{Objetivo: Devuelve la posición en la lista del elemento anterior a la posición indicada (o
NULL si la posición no tiene anterior).
ENTRADA: posicion y lista
SALIDA: anterior elemento de la lista al de la posicion indicada
PreCD: La posición indicada es una posición válida en la lista.}

 function insertItem(I:tItem; P:tPosL; VAR L:tList): boolean;  
 {Objetivo: Inserta un elemento en la lista antes de la posición indicada. Si la posición es
NULL,se añade al final. Devuelve un valor true si el elemento fue
insertado y si no false.
ENTRADA: nuevo item, la posicion y la lista donde se inserta
SALIDA:TRUE o FALSE si se puede o no insertar
PreCD: La posición indicada es una posición válida en la lista o bien nula (NULL).
PostCD: Las posiciones de los elementos de la lista posteriores al
insertado pueden cambiar de valor.}
 procedure deleteAtPosition(P:tPosL; VAR L:tList);  
{Objetivo: Eliminar de la lista el elemento de la posición indicada.
ENTRADA: posicion del elemento y la lista
SALIDA: elimina el elemento de esa posicion y nos deja la lista
PreCD: La posición indicada es una posición válida.
PostCD: Tanto la posición del elemento eliminado como aquellas de los
elementos de la lista a continuación del mismo pueden cambiar de valor.}
 function getItem(P:tPosL; L:tList): tItem;
{Objetivo: Devolver el contenido del elemento de la lista que ocupa la posición indicada.
ENTRADA: posicion y la lista
SALIDA: el elemento de esa posicion
PreCD: La posición indicada es una posición válida en la lista}
 procedure updateVotes(nv: tNumVotes; P:tPosL; VAR L:tList); 
{Objetivo: Modificar número de votos del elemento de la posición indicada.
ENTRADA: nuevo numero de votos, la posicion y la lista
SALIDA: cambia el valor de los votos en esa posicion
 PreCD: La posición indicada es válida en la lista.
 PostCD: El orden de los elementos de la lista no se ve modificado.}
 function findItem(name:tPartyName; L:tList): tPosL; 
 {Objetivo: Devolver la posición del primer elemento de la lista cuyo nombre de partido
se corresponda con el indicado (o NULL si no existe tal elemento).
ENTRADA: nombre del partido y la lista
SALIDA: posicion de ese partido
}

implementation

 procedure createEmptyList(VAR L:tList);
 
  BEGIN
   L.index:=NULL; {Solo es necesario inicilizar el campo indice a 0, no hace falta inicializar los elementos de la lista}
  END;
(**********************************************************************) 
 function isEmptyList(L:tList):boolean;
 
  BEGIN
   isEmptyList:=(L.index=NULL); //Comprueba si se cumple que el indice es nulo
  END;
(**********************************************************************)
 function first(L:tList): tPosL;
 
 
   BEGIN
     first:=1;      			//Devuelve la posicion 1
  END;
(**********************************************************************)
function last(L:tList):tPosL;

 BEGIN
  
     last:=L.index;				// Devuelve la ultima posicion de la lista  
   END;
(**********************************************************************)
function next(P:tPosL; L:tList): tPosL;

 BEGIN
  if (P >= L.index) then    //Si la posicion es mayor o igual que el index, no hay next; si no, el next es p+1
   next:=NULL
  else
   next:=P+1;
  END;
(**********************************************************************)
function previous(P:tPosL; L:tList): tPosL;
 BEGIN
  if (P<= L.index) then 		//Si p es menor o igual que index, el anterior es p-1; si no no existe previous
   previous:=P-1
  else
   previous:=NULL;
  END; 
(**********************************************************************)
function InsertItem(I:tItem; P:tPosL; VAR L:tList): boolean; 
 
VAR
 q:tPosL;
BEGIN
 insertItem:=TRUE;							//Si la lista ya está completa no se pueden añadir mas elementos
 if L.index=max then						//Si hay espacio, index se aumenta uno
  insertItem:=FALSE 						// Si la p es nula, el elemento se inserta al final de la lista
 else begin 								//Si no lo es, se inserta en p, y desplaza los demas elementos en 1 a la derecha
  L.index:=L.index+1;
  if (P=NULL) then begin
   L.Dato[L.index]:=I;
  end
  else begin
   for q:=L.index downto P+1 do
    L.Dato[q]:=L.Dato[q-1];
   L.Dato[P]:=I;
   end;
  end;
 end;
(**********************************************************************)
procedure deleteAtPosition(P:tPosL; VAR L:tList);

VAR
 q:integer;								//Se reduce el index en 1 y se van desplazando los elementos hasta solapar el que queremos borrar
BEGIN
 L.index:=L.index-1;
 for q:=P to L.index do
  L.Dato[q]:=L.Dato[q+1];
END;
(**********************************************************************)
function getItem(P:tPosL; L:tList): tItem;

BEGIN
  getItem:=L.dato[p]; 					//getItem es el item que se encuentra en la posicion p
END;
(**********************************************************************)
procedure updateVotes(nv: tNumVotes; P:tPosL; VAR L:tList);

 BEGIN
  L.dato[P].NumVotes:= nv; 				//Se le establece un nuevo valor a los votos de un partido de la posicion deseada
 END;	
(**********************************************************************)	
function findItem(name:tPartyName; L:tList): tPosL;

VAR  
    i:tPosL; 													//Finditem busca en toda la lista si hay un partido con el nombre introducido
begin 															//Si se encuentra, findItem es igual a la posicion,
	i:=1;
	while (L.dato[i].PartyName <> name) and (i<=L.index) do 		//Si no se encuentra el partido, la posicion es null
	  i:= i+ 1;
	  
	 
	if L.dato[i].PartyName = name then
		findItem:= i
		
	 else 
		findItem:= NULL;
			END;
END.
(**********************************************************************)
{END.}
