REPORTE PRACTICA_2 - JOBS
Oziel Elias Rodriguez Gonzalez
Base de Datos II
Practica 2 - JOBS
13/09/2026


---


Marco Teorico:
Un jobs es un sistema que funciona mediante un evento es decir se hace un evento y se establece cada cuanto y por cuanto tiempo se repetira esto lo podemos ver con sintaxis en mysql como un (CREATE EVENT) y (AT SCHEDULE ON) estos dos comandos nos ayudan a poder crear un jobs y establecer su funcionamiento es decir
esto hace que podamos ahorrar tiempo a diferencia de los procesos manuales esto crea una automatizacion como la de actualizar estados y poder hacer listados o resumenes (recuentos) del dia, semana o mes en curso esto es una exelente ventaja porque el costo operativo se vuelve de una sola vez.


---


Disenio:
'''mermaid
erDiagram
    A["Inico de el evento"] -->B[("Hay prestamos en estado activo que esten vencidos?")]
    B --> |SI |C[("Actualizamos los estados a vencidos")]
    B --> |NO |E[("FIN")]
    C --> E

---

Conclusion:
En esta practica pude mejorar mi tiempo de identificacion de los datos necesarios para inicar y definir un job como tambien mi velocidad a la hora de escribir la sintaxis y los datos mi tiempo fue rapidamente cambiante y generalmente me ayudo a poder identificar que datos pueden ir si bien el primero me tardo unas horas los demas fueron mas rapidos y eficientes


---


Eviencias:

