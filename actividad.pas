{ programa que muestra como se trabaja con el archivo de datos }

program CADPGames;
   
{ la instruccion USES permite utilizar funcionalidad definida en otro archivo, en este caso CADPDataLoader.pas. 
* Dicho archivo incluye las instrucciones para trabajar con los archivos de datos. }   
uses  
  CADPDataLoader;

{-----------------Procedures---------------}

{ procedure de ejemplo que imprime un registro completo }
procedure imprimirDato(d : Tdatos);
begin
	writeln('Salario: ',d.salario, ' Edad: ',d.edad,' DNI: ',d.dni,' Legajo:',d.legajo);
end;

{-----------------Functions---------------}

Function salarioProm(salariosTotal: Longint; empleadosTotal: integer): real;
Begin
  salarioProm:=(salariosTotal/empleadosTotal);
End;

{-------------------Menu---------------------}

procedure leerInstruccion(var num : integer);
begin
    writeln('-----------------------------------------------------------------');
    writeln('Ingrese <1> Cantidad total de empleados');
    writeln('Ingrese <2> Cantidad de empleados cuyo salario es menor a 300 dolares');
    writeln('Ingrese <3> Salario promedio de los empleados');
    writeln('Ingrese <4> Cantidad de veces que aparece el digito 1 en el legajo del empleado con mayor salario');
    writeln('Ingrese <5> DNI de los dos empleados con menor salario');
    writeln('Ingrese <6> Cantidad de empleados cuyos legajos posee todos digitos pares o todos digitos impares');
    writeln('Ingrese <7> Porcentaje de empleados de mas de 50 años y que cobran menos de 600 dolares');
    writeln('Ingrese <8> Cantidad de veces que aparece el digito 0 entre todos los legajos.');
    writeln('Ingrese <9> Cantidad de veces en las que un empleado cobra mas del doble del empleado anterior del listado');
    writeln('-----------------------------------------------------------------');
    readln(num);
    if ((num < 0) and (num > 10)) then
		writeln('Cerrando el programa...');

end;

{-----------Variables Globales--------------}

var
  dato : Tdatos;
  fin : boolean;
  num : integer;
  empleadosTotal: integer;
  cantEmpleados300: integer;
  salariosTotal: Longint;
  salarioPromedio: real;

begin

{---------Inicializacion de Variables----------}

		empleadosTotal:=0;
		cantEmpleados300:=0;
		salariosTotal:=0;
		salarioPromedio:=0;
		
    leerInstruccion(num); // Inicia el programa
    
    if(num=1) then
			begin
				CADPVolverAlInicio('DatosGrupo'); { <<--- comienza la lectura de datos desde el principio, y nos asegura que se procesarán todos los datos. El parámetro indica el nombre del archivo a procesar }
						repeat
							CADPleerDato(dato,fin);		   { <<---- este modulo retorna un registro ya cargado en el parámetro dato, y un boolean en el parámetro fin, indicando si quedan mas datos por leer }
							empleadosTotal:=empleadosTotal+1;
						until(fin);
						writeln('Cantidad total de empleados es: ', empleadosTotal);
						CADPfinalizarLectura();            { <<---- una vez que se procesó todo el archivo, hay que cerrarlo correctamente }
						leerInstruccion(num);
			end
			
			
			else if(num=2) then
				begin
					CADPVolverAlInicio('DatosGrupo');
					repeat
						CADPleerDato(dato,fin);	
						if(dato.salario < 300) then
							begin
								cantEmpleados300:=cantEmpleados300+1;
							end;
					until(fin);
					writeln('Cantidad de empleados cuyo salario es menor a 300 dolares es de: ', cantEmpleados300);
					CADPfinalizarLectura();
					leerInstruccion(num);
			end
			
			else if(num=3) then
				begin
					CADPVolverAlInicio('DatosGrupo');
					repeat
						CADPleerDato(dato,fin);
						empleadosTotal:=empleadosTotal+1;
						salariosTotal:=salariosTotal+dato.salario;
					until(fin);
					salarioPromedio:=salarioProm(salariosTotal,empleadosTotal);
					writeln('El salario promedio de los empleados es $: ', salarioPromedio:2:2);
					CADPfinalizarLectura();
					leerInstruccion(num);
				end
				
			else if(num=4) then
				begin
					CADPVolverAlInicio('DatosGrupo');
					repeat
						CADPleerDato(dato,fin);
					until(fin);
			end;
    

end.
