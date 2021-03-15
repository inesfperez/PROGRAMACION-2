{Teoria1PRO.pas }

unit ListaDinamcia;

interface 
const
 NULO:= nil;
type
 tDato:=...
 tPos:=^.tNodo;
 tNodo:= record
          dato: tDato;
          sig: tPos;
         end;
 tLista= tPos;
 
implementation
procedure ListaVacia(var L:tLista);
 begin
  L:=NULO;
 end;
function CrearNodo(var p:tPos): boolean;
 begin
  new(p);
  CrearNodo:=(p<>nil);
  end;
 (**********************************************************************)
 function InsertarDato(d:tDato, p:tPos, var L:tLista): boolean; {22/2/19}
  var
   q,r:tPos;
  begin
   if not CrearNodo(q) then
    InsertarDato:= FALSE
   else begin 
    InsertarDato:=TRUE;
   if L= NULO then begin
    q^.dato:=d;
    q^.sig:=NULO;
    L:=q;
   end;
   else if p=NULO then begin
    q^.dato:=d;
    q^.sig:=NULO;
    r:=L;
    while(r^.sig<>NULO) DO
     r:=r^.sig;
     r^.sig:=q;
    end;
   else begin 
    q^.sig:= p^.sig;
    p^.sig:=q;
    q^.dato:=p^.dato;
    p^.dato:=d;
   end;
  end;
  end; 
 (********************************************************************)
 procedure borrarLista (var L:tLista);
  var 
   p:tPos;
  begin
   while (L<>NULO) do begin
    p:=L;
    L:=L^.sig;
    dispose(p);
   end;
  end;
(**********************************************************************)
procedure eliminarPosicion(p:tPos; var L:tLista); {1/03/19)}
var
 q: tPos;
begin
 if L=P then
  L:=L^.sig
 else if p^.sig=NULO then begin
  q:=L;
  while q^.sig<> P do
   q:=q^.sig;
  q^.sig:=NULO;
 end
 else begin 
  q:=p^.sig;
  p^.dato:=q^.dato;
  p^.sig:=q^.sig;
  p:=q;
  end;
  dispose(p);
 end; 
(**********************************************************************)
function anterior(p:tPos; L:tLista): tPos;
 var
  q:tPos;
 begin
  if p=L then
   anterior:=NULO
  else begin
   q:=L;
    while (q^.sig<>p) do 
    p^.sig:=q^.sig;
   anterior:=q;
  end;
 end;
(**********************************************************************)
function siguiente(P:tPos; L:tLista): tPos; {Basta con acceder a la direccion de memoria que ya contiene informacion del siguiente elemento}
 begin 
  siguiente:=p^.sig;
 end;
(**********************************************************************)
function buscarDato (d:tDato; L:tLista):tPos;
 var
  p:tPos;
 begin
  p:=L;
  while (p<>NULO) and (p^.dato<>d) do
   p:=p^.sig;
  buscarDato:=p;
 end;
(**********************************************************************)
function primera (L.tLista):tPos;
 begin
  primera:=L;
 end;
(**********************************************************************)
function ultima (L:tLista):tPos;
 var
  q:tPos;
 begin 
  q:=L;
  while (q^.sig<>NULO) do
   q:=q^.sig;
   ultima:=q; 
 end;
(**********************************************************************)
function ObtenerDato(p:tPos;L:tLista):tDato;
 begin
  ObtenerDato:= p^.dato;
 end;
(**********************************************************************)
procedure ActualizarDato(var L:tLista; p:tPos;d:tDato);
 begin
  p^.dato:=d;
 end;
(**********************************************************************)
function CopiarLista(L:tLista; var M:tLista): boolean;
 var
  p,q,r:tPos;
 begin
  if L=NULO then begin
   M:=NULO;
   CopiarLista:=TRUE;
  end
  else begin 
   p:=L;
   M:=NULO;
   CopiarLista:= TRUE;
   while (p<>NULO) do begin
    if not CrearNodo(r) then begin
     CopiarLista:=FALSE;
     p:=NULO;
     end
    else begin 
     r^.dato:=p^.dato;
     r^.sig:=NULO
      if p=L then begin
       M:=r;
       q:=r;
      end
     else begin
      q^.sig:=r;
      q:=r;
     end;
     p:=p^.sig;
    end;
   end;
  end; 
 end; 
(**********************************************************************)
//12-03-19
function contarelementos(L:tLista):integer;
var
p:tPos;
cuenta: integer;
begin
cuenta:=0;
if not esListaVacia(L) then begin
 p:=primera(L);
 while (p<>NULO) do begin
  cuenta:=cuenta+1;
  p:=siguiente(p,L);
 end; {while} 
end; {if}
contarelementos:=cuenta;
end;
(**********************************************************************)
{Ahora vamos a definir un nuevo tipo abstracto de dato: Lista Ordenada}
function Insertardato(d:tDato; var L:tLista):boolean;
var
p:tPos;
begin
	if L.fin=MAX then
		Insertardato:=FALSE
	else begin
		Insertardato:=TRUE;
			if (L.fin=NULO) OR (d>L.datos[L.fin]) then
				L.datos[L.fin+1]:=
			else begin
				p:=L.fin;
				while 
					L.datos[p+1]:=L.datos[p];
					p:=p-1;
			end;
