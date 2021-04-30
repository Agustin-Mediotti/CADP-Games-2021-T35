{ programa que muestra como se trabaja con el archivo de datos }

Program CADPGames;

{ la instruccion USES permite utilizar funcionalidad definida en otro archivo, en este caso CADPDataLoader.pas. 
* Dicho archivo incluye las instrucciones para trabajar con los archivos de datos. }

Uses 
CADPDataLoader;

{-----------------Procedures---------------}

{ procedure de ejemplo que imprime un registro completo }
Procedure imprimirDato(d : Tdatos);
Begin
  writeln('Salario: ',d.salario, ' Edad: ',d.edad,' DNI: ',d.dni,' Legajo:',d.
          legajo);
End;

{ Procedure de Salario mínimo}

Procedure DNIsConSalarioMinimo(d:Tdatos; DNI: string; Var SalarioMin1, SalarioMin2: integer; Var DNIMin1, DNIMin2: string);
Begin
  if(d.salario<=SalarioMin1) then
	  Begin
		SalarioMin2:= SalarioMin1;
		SalarioMin1:= d.Salario;
		DNIMin2:= DNIMin1;
		DNIMin1:= d.DNI;
	  End 
  else
    if(d.salario<=SalarioMin2) then
    Begin
      SalarioMin2:= d.Salario;
      dniMin2:= d.DNI;
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

Procedure LegajoCant0(d:Tdatos;var Cant0:integer);
Begin
  while (d.legajo <> 0) do begin 
    if d.legajo mod 10 = 0 then
      Cant0:= Cant0+1;
      d.legajo:= d.legajo div 10;
  end;
End;

{Contador de legajo con todos los digitos Par o todos los digitos Impar}

procedure ParoImpar(a:Tdatos;var cantimp,cantpar:integer);
var
  dig:integer;
begin
   while (a.legajo<>0) do begin
     dig:=a.legajo mod 10;
     if (dig mod 2=0) then begin
       while (a.legajo<>0) and (dig mod 2=0) do begin
         a.legajo:=a.legajo div 10;
         if (a.legajo=0) then cantpar:=cantpar+1
         else dig:=a.legajo mod 10;
       end;
       end
       else begin
         if (dig mod 2=1) then begin
           while (a.legajo<>0) and (dig mod 2=1) do begin
           a.legajo:=a.legajo div 10;
           if (a.legajo=0) then cantimp:=cantimp+1
           else dig:=a.legajo mod 10;
          end;
         end;
       end;
   end;
end;
{---------------------------------------------------------}

{-----------------Functions---------------}

function contador(cont50y600:integer; dato:Tdatos):integer;
begin
  if (dato.edad>50) and (dato.salario<600) then cont50y600:=cont50y600+1;
  contador:=cont50y600;
end;

{ Funcion de empleado cobra doble }

function EmpleadoCobradoble(d: Tdatos; Doble:integer): integer;
var
  cant:integer;
begin
    cant:=0;
    if (d.Salario > Doble*2) then cant:= cant + 1;
    EmpleadoCobradoble:=cant;
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
  num,legajoMax,digitosuno,empleadosTotal,cantEmpleados300,cont50y600,total,SalarioMin1,SalarioMin2,Cant0,cantImpar,cantPar,CantCobranDoble,DobleSalario: integer;
  salarioMax,salarioPromedio:real;
  salariosTotal: Longint;
  dniMin1, dniMin2,DNI: string;

Begin

{---------Inicializacion-de-Variables----------}
  DobleSalario:=0;
  CantCobranDoble:= 0;
  
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
				 empleadosTotal := 0;
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
						 cantEmpleados300 := 0;
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
						 empleadosTotal:=0;
						 salariosTotal:=0;
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
						 salarioMax:=-1;
						 digitosuno:=0;
						 CADPVolverAlInicio('DatosGrupo');
						 Repeat
							 CADPleerDato(dato,fin);
							 LegEmple(dato,SalarioMax,legajoMax);
						 Until (fin);
						 digitosuno:=cantidaduno(legajoMax);
						 writeln('La cantidad de digitos 1 que tiene el legajo del empleado con mayor salario (',legajoMax,') es: ',digitosuno);
					         CADPfinalizarLectura();
					End

		 Else If (num=5) Then
					 Begin
						 DNI:='';
						 SalarioMin1:=9999;
                         SalarioMin2:=9999;
						 CADPVolverAlInicio('DatosGrupo');
						 Repeat
							 CADPleerDato(dato,fin);
						         DNIsConSalarioMinimo(dato,DNI,SalarioMin1,SalarioMin2,DNIMin1, DNIMin2);
						 Until (fin);						 
						 writeln('El DNI del empleado con salario mas chico es: ',dniMin1,' y el segundo menor es: ', DNIMin2);
					         CADPfinalizarLectura();
					 End
		 Else if (num=6) then
			         begin
				 cantImpar:=0;
                                 cantPar:=0;
				 CADPVolverAlInicio('DatosGrupo');
				 Repeat
				 CADPleerDato(dato,fin);
				 ParoImpar(dato,cantImpar,cantPar);
				 Until (fin);
				 writeln('Cantidad de legajos con solo digitos impar: ',cantImpar);
                                 writeln('Cantidad de legajos con solo digitos par: ',cantPar);  
				 CADPfinalizarLectura();
				End

		 Else if (num=7) then 
				begin
					total:=0;
					cont50y600:=0;
					CADPVolverAlInicio('DatosGrupo');
				Repeat
				  CADPleerDato(dato,fin);
							cont50y600:=contador(cont50y600,dato);
							total:=total+1;
				Until (fin);
				 writeln('El porcentaje de empleados de mas de 50 anios y que cobran menos de 600 dolares es: ',promedio(cont50y600,total));
					CADPfinalizarLectura();
					End
			
			Else if (num=8) then 
				begin
					Cant0:=0;
					CADPVolverAlInicio('DatosGrupo');
				Repeat
				  CADPleerDato(dato,fin);
				  LegajoCant0(dato,Cant0);
				  Until (fin);
						LegajoCant0(dato,Cant0);
				writeln('El dígito 0 aparece ',cant0, ' veces entre todos los legajos');
					CADPfinalizarLectura();
					End


			Else if (num=9) then 
                begin
                      CADPVolverAlInicio('DatosGrupo');
                      CADPleerDato(dato,fin);
                      DobleSalario:=dato.salario;
                    Repeat
                                          CADPleerDato(dato,fin);
                      CantCobranDoble:=CantCobranDoble+EmpleadoCobraDoble(dato,DobleSalario);
                      DobleSalario:=dato.salario;
                    Until (fin);

                    writeln('las veces en las que un empleado cobra mas del doble del anterior son: ',CantCobranDoble);
                    CADPfinalizarLectura();

                End;
	leerInstruccion(num);
	end;

End.
