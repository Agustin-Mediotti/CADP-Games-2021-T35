
Unit CADPDataLoader;

Interface

Type 
  TDatos = Record
    salario : integer;
    edad :  integer;
    DNI : string;
    legajo : integer;
  End;

Procedure CADPleerDato (Var d : TDatos; Var ultimo : boolean);
Procedure CADPVolverAlInicio(miArchivo : String);
Procedure CADPfinalizarLectura();

Implementation

Uses 
Sysutils;

Var 
  myfile : TextFile;

Procedure CADPVolverAlInicio(miArchivo : String);
Begin
  Assign(myfile, miArchivo);
  reset(myfile);
End;

Procedure CADPleerDato(Var d : TDatos; Var ultimo : boolean);
Begin
  If Not eof(myfile) Then
    Begin
      readln(myfile,d.salario);
      readln(myfile,d.edad);
      readln(myfile,d.dni);
      readln(myfile, d.legajo);
      ultimo := eof(myfile);
    End
  Else
    Begin
      d.salario := -1;
      ultimo := true;
    End;
End;

Procedure CADPfinalizarLectura();
Begin
  close(myfile);
End;

initialization
Begin

End;


finalization
Begin

End;
End.
