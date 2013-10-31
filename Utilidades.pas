unit Utilidades;

interface

uses SysUtils;

procedure ObtenCodigo (cadena : string; var codigo : String );

implementation
//##############################################################################################
procedure ObtenCodigo (cadena : string; var codigo : String );
Var
  f,g : integer;
  cadenaAux : String;
  finCadena : Boolean;
  delimitador : Boolean;

begin
    //Obtenemos el código que hay después de "//"
    finCadena:=False;
    delimitador:=False;
    cadenaAux:='';
    f:=1;
    while ( (NOT delimitador) AND (NOT finCadena) ) do
    begin
      if ( (cadena[f]='/') AND (cadena[f+1]='/') )
      then begin
              delimitador:=true;
              f:=f+2;
           end
      else begin
              if f=length(Cadena)
              then finCadena:=true
              else f:=f+1;
           end;
    end;
    if Not finCadena
    then begin
            for g:=f to Length(Cadena) do
              cadenaAux:=cadenaAux+Cadena[g];
         end;
    Codigo:=Trim(cadenaAux);
end;
end.
