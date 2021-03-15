{program RecuentoVotos;}
{TITLE: PROGRAMMING II LABS
* SUBTITLE: Practical 2
* AUTHOR 1: Javier López Durán LOGIN 1: javier.lduran
* AUTHOR 2: Inés Faro Pérez LOGIN 2: ines.fperez
* GROUP: 3.1
* DATE: 03/05/19}
unit RequestQueue; //implementacion estática.
interface
const
	NULLQ = 'NULL';
	max = 25;
type
	tRequest = char;
	tPosq = integer;
	tItemQ = record
			request: tRequest;
			code: string;
			param1: string;
			param2: string;
		end;
	tQueue = record
			dato: array [1..max] of tItemQ;
			inicio,fin: tPosQ;
		end;
	
procedure createEmptyQueue (VAR Q:tQueue);
{OBJETIVO: Crear una cola vacía.
 ENTRADA: La cola.
 SALIDA: La cola vacía.
 POSTCONDICIÓN: La cola queda inicializada y vacía.
}
function plusone(i:integer):integer;
{OBJETIVO: sumar un elemento en la cola.
 ENTRADA: un entero que va a ser el módulo.
 SALIDA: el numero sumado
 PRECONDICIÓN:Que la cola no esté vacía.}
function isEmptyQueue (Q:tQueue): boolean;
{OBJETIVO: Determina si la cola está vacía.
 ENTRADA: La cola.
 SALIDA: TRUE si la lista está vacía, FALSE en caso contrario.
 }
function enqueue (VAR Q:tQueue; I:tItemQ): boolean;
{OBJETIVO: Insertar un nuevo elemento en la cola.
 ENTRADA: El elemento que se quiere insertar y la cola.
 SALIDA: TRUE si el elemento fue insertado, FALSE en caso contrario.
}
function front (Q:tQueue): tItemQ;
{OBJETIVO: Devolver el contenido del frente de la cola.
 ENTRADA: La cola.
 SALIDA: El elemento que está al frente de la cola.
 PRECONDICIÓN: La cola no esté vacía.
}
procedure dequeue (VAR Q:tQueue);
{OBJETIVO: eliminar el elemento que está al frente de la cola.
 ENTRADA: La cola
 SALIDA: La cola sin el elemento que estaba al frente de la cola.
 PRECONDICIÓN: que la cola no esté vacía.
}
implementation
	procedure createEmptyQueue(VAR Q:tQueue);
		begin
			Q.inicio:=1;
			Q.fin:=max;
		end;
(**********************************************************************)
	function plusone(i:integer):integer;
		begin
			if i=max then 
				plusone:=1
			else
				plusone:=i+1;
		end;
(**********************************************************************)
	function isEmptyQueue (Q:tQueue): boolean;
		begin
			isEmptyQueue := (Q.inicio=plusone(Q.fin));
		end;
(**********************************************************************)
	function enqueue (VAR Q:tQueue; I:tItemQ): boolean;
		begin
			if Q.inicio=plusone(plusone(Q.fin)) then
				enqueue:=FALSE
			else begin
				Q.fin:=plusone(Q.fin);
				Q.dato[Q.fin]:=I;
				enqueue:=TRUE;
			end;
		end;
(**********************************************************************)
	function front (Q:tQueue): tItemQ;
		begin
			front:=Q.dato[Q.inicio];
		end;
(**********************************************************************)
	procedure dequeue (VAR Q:tQueue);
		begin
			Q.inicio:=plusone(Q.inicio);
		end;
END.
