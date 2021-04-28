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

Procedure DNIsConSalarioMinimo(Salario: integer; DNI: string; Var SalarioMin1, SalarioMin2: integer; Var DNIMin1, DNIMin2: string);
Begin
  if(Salario<=SalarioMin1) then
  Begin
    SalarioMin2:= SalarioMin1;
    SalarioMin1:= Salario;
    DNIMin2:= DNIMin1;
    DNIMin1:= DNI;
  End 
  else
    if(salario<=SalarioMin2) then
    Begin
      SalarioMin2:= Salario;
      dniMin2:= DNI;
    End;
End;

{-----------------Functions---------------}

Function salarioProm(salariosTotal: Longint; empleadosTotal: integer): real;
Begin
  salarioProm := (salariosTotal/empleadosTotal);
End;

{-------------------Menu---------------------}

Procedure leerInstruccion(Var num : integer);
Begin
	writeln('');
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
  readln(num);
  {If ((num < 0) And (num >= 10)) Then
    writeln('-->Cerrando el programa<--');}

End;


{-----------Variables-Globales--------------}

Var 
  dato : Tdatos;
  fin : boolean;
  num : integer;
  empleadosTotal: integer;
  cantEmpleados300: integer;
  salariosTotal: Longint;
  salarioPromedio: real;

Begin

{---------Inicializacion-de-Variables----------}

  empleadosTotal := 0;
  cantEmpleados300 := 0;
  salariosTotal := 0;
  salarioPromedio := 0;

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
				//leerInstruccion(num);
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
						 //leerInstruccion(num);
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
						 //leerInstruccion(num);
					 End;

		{Else If (num=4) Then
					 Begin
						 CADPVolverAlInicio('DatosGrupo');
						 Repeat
							 CADPleerDato(dato,fin);
						 Until (fin);
					 End;}
					 
		 {Else If (num=5) Then
					 Begin
						 CADPVolverAlInicio('DatosGrupo');
						 Repeat
							 CADPleerDato(dato,fin);
						 Until (fin);
					 End;}
			leerInstruccion(num);
		End;


End.
