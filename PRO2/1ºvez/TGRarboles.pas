function NumNodos (a:tArbolBin): integer;
begin	
	if EsArbolVacio(a) then 
		NumNodos:=0
	else 
		NumNodos:=1+NumNodos(HijoIzquierdo(a))+NumNodos(HijoDerecho(a));
end;
(**********************************************************************)
function NumNodosInternos(a:tArbolBin):integer;
begin
	if EsArbolVacio(a) or EsArbolVacio(HijoIzquierdo(a)) and EsArbolVacio(HijoDerecho(a)) then
		NumNodosInternos:=0
	else 
		NumNodosInternos:=1+NumNodosInternos(HijoDerecho(a))+NumNodosInternos(HijoIzquierdo(a));
end;
(**********************************************************************)
function Altura(a:tArbolBin): integer;
begin
	if EsArbolVacio(a) then 
		NumNodosInternos:=0
	else 
		Altura:=1+Max(Altura(HijoDerecho(a)),Altura(HijoIzquierdo(a)));
end;
(**********************************************************************)

