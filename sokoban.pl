% Se hacen uso de las funciones:
% -Member(X,L): tiene éxito cuando X es miembro de la lista L. 
% 		Se puede usar para verificar si un elemento dado es miembro de una lista y 
%		también se puede usar para seleccionar de manera no determinista un elemento de una lista
% -Select(X,L,R): lo mismo que Member(X, L), excepto que enlaza R con el resto de la lista después de que X se selecciona de L.
% -Sustract(X,Y,Z): Elimina todos los elementos del conjunto. La eliminación se basa en la unificación mediante la verificación de contenido.
%		Un conjunto se define como una lista desordenada sin duplicados. Los elementos se consideran duplicados si se pueden unificar.
% -Append(X,T,U): La lista X y T es la concatenación de X y T.
% -Write & writeln: Enviar output.

% Funciones para esclarecer que Casilla 2 está inmediatamente en la parte superior de la casilla 1

top(7,4).
top(4,1).
top(8,5).
top(5,2).
top(9,6).
top(6,3).

% Ubicación de Cas2 está inmediatamente a la derecha de Cas1

right(1,2).
right(2,3).
right(4,5).
right(5,6).
right(7,8).
right(8,9).

% Posicion final cajas

meta(8).
meta(9).

% Cas2 es la siguiente ubicación de Cas1 a lo largo de la dirección dir.

adyacente(Cas1,Cas2,norte) :- top(Cas1,Cas2).
adyacente(Cas1,Cas2,sur) :- top(Cas2,Cas1).
adyacente(Cas1,Cas2,este) :- right(Cas1,Cas2).
adyacente(Cas1,Cas2,oeste) :- right(Cas2,Cas1).

% Ninguna caja se puede mover a una esquina a menos que sea un cuadrado de almacenamiento

corner(X) :- \+ noncorner(X).
noncorner(X) :- top(_,X),top(X,_).
noncorner(X) :- right(_,X),right(X,_).

% Dos casillas en Cas1 y Cas2 constituyen un punto muerto si están al lado del otro por una pared,
% a menos que ambas ubicaciones sean cuadrados de almacenamiento.

stuck(X) :-  \+ meta(X), corner(X).
stuck(X,Y) :- (right(X,Y);right(Y,X)), (\+ meta(X); \+ meta(Y)), (\+ top(X,_), \+ top(Y,_); \+ top(_,X), \+ top(_,Y)),!.
stuck(X,Y) :- (top(X,Y);top(Y,X)), (\+ meta(X); \+ meta(Y)), (\+ right(X,_), \+ right(Y,_); \+ right(_,X), \+ right(_,Y)),!.

% Si cada ubicación en L es una ubicación de almacenamiento, alcanzamos la meta

meta_alcanzada(Locs) :- foreach(member(Loc, Locs), meta(Loc)).

% Moverse a una posición que no esté ocupada por una caja o no es una casilla peligrosa

dest_correcto(X, Cajas) :-
  \+ member(X, Cajas),
  (corner(X)->meta(X);true),
  \+ stuck(X),
  foreach(member(Caja, Cajas), \+ stuck(X, Caja)).
	
% Acción de movimiento del Robot

accion(Robot, Cajas, move(Caja, Dir), NewRobot, NewCajas) :-
  select(Caja, Cajas, CajasRestantes),
  adyacente(Caja, SigLoc, Dir),
  dest_correcto(SigLoc, CajasRestantes),
  adyacente(PushPosition, Caja, Dir),
	llegable(Robot, PushPosition, Cajas),
	elegir_dest(Robot,Caja,Dir,NewRobot,NewPosicion,NewCajas),
  subtract(Cajas, [Caja], TempList),
  adyacente(Caja, NewPosicion, Dir),
  append(TempList, [NewPosicion], NewCajas).
	
% Elegir dirección destino y posición destino pasa a ser la nueva localización

elegir_dest(Loc,SigLoc,_Dir,Dest,NewSokobanLoc,_BoxLocs) :- 
	Dest=SigLoc, 
	NewSokobanLoc=BoxLoc.

elegir_dest(Loc,SigLoc,_Dir,Dest,NewSokobanLoc,_BoxLocs) :- 
	Dest=SigLoc, 
	NewSokobanLoc=BoxLoc.
	
elegir_dest(Loc,SigLoc,Dir,Dest,NewSokobanLoc,BoxLocs) :- 
	adyacente(SigLoc,NewSokobanLoc,Dir), 
	dest_correcto(NextNextLoc,BoxLocs), 
	elegir_dest(SigLoc,NextNextLoc,Dir,Dest,NewSokobanLoc,BoxLocs).
	
% Se verifica si hay una ruta de cuadrados libres desde una ubicación a otra y evitar bucles.
	
llegable(Cas1,Cas2,BoxLocs) :- 
	adyacente(Cas1,Cas3,_), 
	\+ member(Cas3,BoxLocs). 
	
% Si el estado final es igual al estado final, acaba o recorremos nuevos estados

resolver_o_avanzar(Robot, Cajas, _Cola, [], Len) :-
  estado_final(Robot, Cajas),
	Len=0.

resolver_o_avanzar(Robot, Cajas, Cola, [Move|Moves], Len) :-
  accion(Robot, Cajas, Move, NewRobot, NewCajas),
  resolver_o_avanzar(NewRobot, NewCajas, [NewRobot, NewCajas|Cola], Moves, Len1),
	Len is Len1+1.

% Estado inicial
	
estado_inicial(7, [5, 6]).

% Estado final

estado_final(Robot, Cajas) :-
  meta_alcanzada(Cajas), !.

% EJECUCION:
% resolver(X, Len).
% OUTPUT:
% Problema Robot
% =============
% Estado inicial: Robot en la casilla 7 y cajas en las casillas [5,6]
% Solucion final: 
% X = [move(5, sur), move(6, sur)],
% Len = 2 .
	
resolver(Solucion, Len) :-
	estado_inicial(Robot, Cajas),
  writeln('Problema Robot'),
  writeln('============='),
	write('Estado inicial: Robot en la casilla '),write(Robot),write(' y cajas en las casillas '),writeln(Cajas),
	writeln('Solucion final: '),
  resolver_o_avanzar(Robot, Cajas, [Robot, Cajas], Solucion, Len).

