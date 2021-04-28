{ programa que muestra como se trabaja con el archivo de datos }

Program CADPGames;

{ la instruccion USES permite utilizar funcionalidad definida en otro archivo, en este caso CADPDataLoader.pas. 
* Dicho archivo incluye las instrucciones para trabajar con los archivos de datos. }

Uses 
CADPDataLoader;

{------------------Type-------------------}

type 
salarioMin= record
		dniMin1, dniMin2,DNI: string;
		i,SalarioMin1,SalarioMin2,Salario: integer;
	end;

{-----------------Procedures---------------}

{ procedure de ejemplo que imprime un registro completo }
Procedure imprimirDato(d : Tdatos);
Begin
  writeln('Salario: ',d.salario, ' Edad: ',d.edad,' DNI: ',d.dni,' Legajo:',d.
          legajo);
End;

{ Procedure de Salario mínimo}

Procedure DNIsConSalarioMinimo(d:Tdatos; Salario: integer; DNI: string; Var SalarioMin1, SalarioMin2: integer; Var DNIMin1, DNIMin2: string);
Begin
  if(d.salario<=SalarioMin2) then
  Begin
    SalarioMin2:= SalarioMin1;
    SalarioMin1:= d.Salario;
    DNIMin2:= DNIMin1;
    DNIMin1:= DNI;
  End 
  else
    if(d.salario<=SalarioMin2) then
    Begin
      SalarioMin2:= d.Salario;
      dniMin2:= DNI;
    End;
End;

{ Procedure de Instruccion }

Procedure leerInstruccion(Var num : integer);
Begin

  readln(num);

End;

procedure LegEmple(a:Tdatos; var SalarioMax:real; var legajoMax:integer);
begin
  if (a.salario>SalarioMax) then begin
    SalarioMax:=a.salario;
    legajoMax:=a.legajo;
  end;
end;

{ Procedure de cantidad de 0 en el legajo }

Procedure LegajoCant0(d:Tdatos;var Cant0: integer;legajo:integer);
Begin
  while (d.legajo <> 0) do begin 
    if d.legajo MOD 10 = 0 then
      Cant0:= Cant0+1;
      d.legajo:= d.legajo DIV 10;
  end;
End;

{-----------------Functions---------------}

function contador(cont50y600:integer; dato:Tdatos):integer;
begin
  if (dato.edad>50) and (dato.salario<600) then cont50y600:=cont50y600+1;
  contador:=cont50y600;
end;

{ mucho textooo}

function promedio(cont50y600,total:integer):integer;
begin
    promedio:=((cont50y600*100) div total);
end;

{ mucho textooo}

Function salarioProm(salariosTotal: Longint; empleadosTotal: integer): real;
Begin
  salarioProm := (salariosTotal/empleadosTotal);
End;

{ mucho textooo}

function cantidaduno (legajoMax:integer):integer;
var
  dig:integer;
  cantuno:integer;
begin
  dig:=0;
  cantuno:=0;
  while (legajoMax<>0) do begin
    dig:=legajoMax mod 10;
    if (dig=1) then cantuno:=cantuno+1;
    legajoMax:=legajoMax div 10;
  end;
  cantidaduno:=cantuno;
end;

{-----------Variables-Globales--------------}

Var 
	dato : Tdatos;
  fin : boolean;
  num,legajoMax,digitosuno,empleadosTotal,cantEmpleados300,cont50y600,total,SalarioMin1,SalarioMin2,Cant0,Salario: integer;
  salarioMax,salarioPromedio:real;
  salariosTotal: Longint;
  dniMin1, dniMin2,DNI: string;

Begin

{---------Inicializacion-de-Variables----------}

  empleadosTotal := 0;
  cantEmpleados300 := 0;
  salariosTotal := 0;
  salarioPromedio := 0;
  digitosuno:=0;
  salarioMax:=-1;
  cont50y600:=0;
  total:=0;
  Cant0:=0;
  Salario:=0;
  SalarioMin1:=9999;
  SalarioMin2:=9999;
  
  {------------------Menu-------------------------}
  
  writeln('Grupo 35 - Agustin Mediotti, Gian Marcello, Emmanuel Marcello.');
  writeln('-----------------------------------------------------------------');
  writeln('Ingrese <1> Cantidad total de empleados');
  writeln('Ingrese <2> Cantidad de empleados cuyo salario es menor a 300 dolares');
  writeln('Ingrese <3> Salario promedio de los empleados');
  writeln('Ingrese <4> Cantidad de veces que aparece el digito 1 en el legajo del empleado con mayor salario');
  writeln('Ingrese <5> DNI de los dos empleados con menor salario');
  writeln('Ingrese <6> Cantidad de empleados cuyos legajos posee todos digitos pares o todos digitos impares');
  writeln('Ingrese <7> Porcentaje de empleados de mas de 50 anios y que cobran menos de $600 dolares');
  writeln('Ingrese <8> Cantidad de veces que aparece el digito 0 entre todos los legajos.');
  writeln('Ingrese <9> Cantidad de veces en las que un empleado cobra mas del doble del empleado anterior del listado');
  writeln('Ingrese <0> Para finalizar');
  writeln('-----------------------------------------------------------------');
  writeln('');

  leerInstruccion(num); // Inicia el programa

	while (num<>0) do
		Begin
		If (num=1) Then
			Begin
				CADPVolverAlInicio('DatosGrupo');
				Repeat
					CADPleerDato(dato,fin); { <<--- comienza la lectura de datos desde el principio, y nos asegura que se procesarán todos los datos. El parámetro indica el nombre del archivo a procesar }
					empleadosTotal := empleadosTotal+1; { <<---- este modulo retorna un registro ya cargado en el parámetro dato, y un boolean en el parámetro fin, indicando si quedan mas datos por leer }
				Until (fin);
				writeln('');
				writeln('Cantidad total de empleados es: ', empleadosTotal);
				CADPfinalizarLectura(); { <<---- una vez que se procesó todo el archivo, hay que cerrarlo correctamente }
			End

			Else If (num=2) Then
					 Begin
						 CADPVolverAlInicio('DatosGrupo');
						 Repeat
							 CADPleerDato(dato,fin);
							 If (dato.salario < 300) Then
								 Begin
									 cantEmpleados300 := cantEmpleados300+1;
								 End;
						 Until (fin);
						 writeln('');
						 writeln('Cantidad de empleados cuyo salario es menor a 300 dolares es de: ', cantEmpleados300);
						 CADPfinalizarLectura();
					 End

		Else If (num=3) Then
					 Begin
						 CADPVolverAlInicio('DatosGrupo');
						 Repeat
							 CADPleerDato(dato,fin);
							 empleadosTotal := empleadosTotal+1;
							 salariosTotal := salariosTotal+dato.salario;
						 Until (fin);
						 salarioPromedio := salarioProm(salariosTotal,empleadosTotal);
						 writeln('');
						 writeln('El salario promedio de los empleados es $: ',salarioPromedio:2:2);
						 CADPfinalizarLectura();
					 End

		Else If (num=4) Then
					 Begin
						 CADPVolverAlInicio('DatosGrupo');
						 Repeat
							 CADPleerDato(dato,fin);
							 LegEmple(dato,SalarioMax,legajoMax);
						 Until (fin);
						 digitosuno:=cantidaduno(legajoMax);
						 writeln('La cantidad de digitos 1 que tiene el legajo del empleado con mayor salario (',legajoMax,') es: ',digitosuno);
					 End

		 Else If (num=5) Then
					 Begin
						 CADPVolverAlInicio('DatosGrupo');
						 Repeat
							 CADPleerDato(dato,fin);
						 Until (fin);
						 DNIsConSalarioMinimo(Salario,DNI,SalarioMin1,SalarioMin2,DNIMin1, DNIMin2);
						 writeln('La cantidad de 0 que poseen todos los legajos son: ',DNIMin1, DNIMin2);
					 End

			Else if (num=7) then 
				begin
					CADPVolverAlInicio('DatosGrupo');
	    Repeat
	      CADPleerDato(dato,fin);
					cont50y600:=contador(cont50y600,dato);
					total:=total+1;
	    Until (fin);
         writeln('El porcentaje de empleados de mas de 50 anios y que cobran menos de 600 dolares es: ',promedio(cont50y600,total));
         leerInstruccion(num);
			End
			
			Else if (num=8) then 
				begin
					CADPVolverAlInicio('DatosGrupo');
	    Repeat
	      CADPleerDato(dato,fin);
	    Until (fin);
				LegajoCant0(Cant0,legajo);
        writeln('El dígito 0 aparece ',cant0, ' veces entre todos los legajos');
			End;

			leerInstruccion(num);
		End;


End.
