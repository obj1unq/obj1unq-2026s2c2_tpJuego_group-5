#  Cruzá hasta la UNQ

Juego estilo *Frogger* desarrollado en **Wollok**. Sos un alumno que tiene que cruzar varios carriles llenos de tráfico para llegar a la puerta de la Universidad Nacional de Quilmes (UNQ), sin perder todas tus vidas en el intento.

## Objetivo

Llegar a la puerta de la UNQ, en la parte superior del tablero, esquivando los vehículos que circulan por los carriles. El juego tiene tres niveles y cada uno suma dificultades nuevas.

## Niveles

| Nivel | Qué pasa | Vehículos |
|:-----:|----------|-----------|
| **1 · Cruzá con cuidado** | Cruzás cuatro carriles para llegar a la UNQ. | Autos y camiones |
| **2 · Los apuntes** | Arrancás en la puerta de la UNQ y tenés que bajar a buscar los apuntes (y el paraguas) y volver. Además, llueve. | Autos, camiones y motos |
| **3 · Dentro de la UNQ** | Cruzás cuatro carriles dentro del predio. *(Cronómetro en desarrollo.)* | Autos, camiones, motos y colectivos |

### Lluvia y paraguas (nivel 2)

- Al agarrar los apuntes, el alumno también consigue el paraguas.
- Con la tecla **P** lo abrís y lo cerrás, y el sprite del alumno cambia (`estudianteParaguas_<N>vida.png`).
- Con el paraguas abierto no se dibuja la lluvia en la fila del alumno ni en la de arriba y abajo.
- Si el alumno se queda sin vidas, se muestra el sprite normal.

##  El alumno

El sprite del alumno cambia según las vidas que le quedan (el juego carga `estudiante_<N>vida.png`).

| 3 vidas | 2 vidas | 1 vida |
|:-------:|:-------:|:------:|
| <img src="assets/estudiante_3vida.png" width="160" alt="Alumno con 3 vidas"> | <img src="assets/estudiante_2vida.png" width="160" alt="Alumno con 2 vidas"> | <img src="assets/estudiante_1vida.png" width="160" alt="Alumno con 1 vida"> |
| `estudiante_3vida.png` | `estudiante_2vida.png` | `estudiante_1vida.png` |

| Con paraguas (3 vidas) |
|:----------------------:|
| <img src="assets/estudianteParaguas_3vida.png" width="140" alt="Alumno con paraguas"> |

##  Cómo se juega

- El alumno comienza en la parte inferior del tablero (posición `(4, 0)`).
- Los carriles con tráfico están en las filas 1 a 4, y cada uno circula hacia la derecha o hacia la izquierda.
- Si un vehículo te atropella, perdés una vida y volvés al punto de inicio.
- Cuando te quedás sin vidas, el alumno muere y el juego termina.
- Si llegás a la puerta de la UNQ, ganás.

### Controles

> Completar con las teclas definidas en tu archivo de configuración del juego.

| Tecla | Acción |
|-------|--------|
| ↑ | Mover hacia arriba |
| ↓ | Mover hacia abajo |
| ← | Mover hacia la izquierda |
| → | Mover hacia la derecha |

| **C** | Continuar desde las pantallas de presentación |
| **R** | Reiniciar (recupera las vidas y vuelve al punto de inicio) |
| **P** | Abrir o cerrar el paraguas (solo si lo tenés) |


##  Elementos del juego

| Elemento | Descripción |
|----------|-------------|
| **Alumno** | Personaje principal. Su imagen cambia según las vidas que le quedan. |
| **Carriles** | Generan vehículos de forma continua. La dirección de cada uno se elige al azar. |
| **Vehículos** | Autos, motos, colectivos y camiones, creados por sus respectivas fábricas. |
| **Puerta de la UNQ** | La meta, ubicada en la posición `(5, 6)`. |

##  Estructura del proyecto

| Archivo | Contenido |
|---------|-----------|
| `main.wpgm` | Programa principal: inicia el tablero y el gestor de etapas. |
| `juego.wlk` | `gestorDeEtapas`, y las clases base `Etapa`, `Presentacion` y `Nivel`. |
| `nivel.wlk` | Menú, presentaciones y los tres niveles con su configuración. |
| `videojuegoGRUPO5.wlk` | `alumno` (movimiento, vidas, paraguas), `unq_Puerta` y `apuntes`. |
| `carril.wlk` | `Carril`, `Generador` y las fábricas de vehículos. |
| `vehiculo.wlk` | Autos, motos, colectivos y camiones. |
| `direccion.wlk` | Direcciones de movimiento. |
| `estado.wlk` | Estados del alumno (vivo y muerto) y manejo de la salud. |
| `lluvia.wlk` | Gotas de lluvia y su interacción con el paraguas. |
| `fondos.wlk` | Fondos de los niveles y de las presentaciones. |
| `worldUNQ.wlk` | Configuración del tablero. |
| `testJuego.wtest` | Tests del alumno, las vidas y las colisiones. |
| `assets/` | Imágenes del juego. |

##  Conceptos de programación aplicados

- **Polimorfismo**: los vehículos, las fábricas y los estados del alumno se usan de forma intercambiable.
- **Patrón State**: el alumno delega su movimiento en el estado actual (`vivo` o `muerto`).
- **Patrón Factory**: cada tipo de vehículo tiene su propia fábrica.
- **Delegación**: la interacción por colisión se resuelve con `algo.interaccion(alumno)`.
- **Composición**: los carriles reciben su dirección, fila, tiempo de espera y generador de vehículos.

## ▶ Cómo ejecutarlo

1. Instalá [Wollok](https://www.wollok.org) o la extensión de Wollok para VS Code.
2. Cloná o descargá este repositorio.
3. Abrí el proyecto y ejecutá el programa principal con *Run Program*.

##  Autores

 
- Mauricio Jose Chacolla Castellon 
- Daniel Rubio
- Juan Melo


Trabajo realizado para la materia Programación con Objetos I — Universidad Nacional de Quilmes.
