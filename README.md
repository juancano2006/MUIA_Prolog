# MUIA_Prolog

Supongamos que se dispone del casillero cuadriculado que puede verse en la figura, en la que se
encuentra situado un androide en la casilla L7 y dos cajas en las casillas L5 y L6 respectivamente. 

![alt text](https://i.imgur.com/6UhSLer.png)

Se desea construir un programa que permita al androide trazar un plan para llevar las dos cajas (a las
que llamaremos C1 y C2) a las casillas sombreadas, que como puede verse en la figura, son L8 y L9.
Téngase en cuenta que en el estado meta se considerará irrelevante cual de las cajas esté ocupando
cualquiera de las casillas destino siempre y cuando ambas casillas estén cubiertas con una de las cajas.
Para realizar esta tarea, el androide puede realizar dos operaciones: moverse y empujar una caja. En lo
que se refiere a la operación de desplazamiento, el androide sólo puede moverse cada vez a UNA casilla
vacía que sea adyacente a la casilla correspondiente a su posición actual en una de las siguientes
direcciones: (N)orte, (S)ur, (E)ste y (O)este. Para clarificar este supuesto, podríamos por ejemplo decir,
que la casilla L2 es adyacente con la casilla L1 hacia el Oeste, y que L9 es adyacente con L6 hacia el
Norte. De la misma forma, L6 sería adyacente con L9 hacia el Sur. Como se decía anteriormente, el
androide también puede empujar una caja a una casilla adyacente vacía en una dirección determinada (N,
S, E, O) siempre y cuando las casillas ocupadas por el androide, la caja, y la posición a la que se desea
mover la caja sean adyacentes entre sí en la dirección de empuje. Por ejemplo, tal y como se muestra en la
figura adjunta, si el androide desease empujar la caja que se encuentra en la casilla L5 hacia el Norte,
entonces debería situarse en la casilla L8, mientras que si desease empujarla hacia el Sur, entonces
debería ubicarse en L2. No podría, por ejemplo, empujar la caja L5 hacia el Este desde L4 dado que L6
está ocupada con otra caja. Por acción de la inercia, una vez el androide ha empujado una caja, este pasará
a ocupar la posición que inicialmente ocupaba la caja. Se asumirá también que no puede haber más de un
elemento en una casilla.
