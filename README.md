# 🎓 Cruzá hasta la UNQ

Juego estilo *Frogger* desarrollado en **Wollok**. Sos un alumno que tiene que cruzar varios carriles llenos de tráfico para llegar a la puerta de la Universidad Nacional de Quilmes (UNQ), sin perder todas tus vidas en el intento.

## 🎯 Objetivo

Llegar a la puerta de la UNQ, ubicada en la parte superior del tablero, esquivando los vehículos que circulan por los carriles.

## 🧑‍🎓 El alumno

El sprite del alumno cambia según las vidas que le quedan (el juego carga `estudiante_<N>vida.png`).

| 3 vidas | 2 vidas | 1 vida |
|:-------:|:-------:|:------:|
| <img src="assets/estudiante_3vida.png" width="160" alt="Alumno con 3 vidas"> | <img src="assets/estudiante_2vida.png" width="160" alt="Alumno con 2 vidas"> | <img src="assets/estudiante_1vida.png" width="160" alt="Alumno con 1 vida"> |
| `estudiante_3vida.png` | `estudiante_2vida.png` | `estudiante_1vida.png` |

## 🕹️ Cómo se juega

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

## 🚗 Elementos del juego

| Elemento | Descripción |
|----------|-------------|
| **Alumno** | Personaje principal. Su imagen cambia según las vidas que le quedan. |
| **Carriles** | Generan vehículos de forma continua. La dirección de cada uno se elige al azar. |
| **Vehículos** | Autos, motos, colectivos y camiones, creados por sus respectivas fábricas. |
| **Puerta de la UNQ** | La meta, ubicada en la posición `(5, 6)`. |

## 🧱 Estructura del proyecto

| Archivo | Contenido |
|---------|-----------|
| `alumno` | Personaje principal: movimiento, vidas, estado y colisiones. |
| `Carril` | Clase que genera y retira vehículos de una fila. |
| `generadorDeCarriles` | Crea los carriles y los pone en marcha. |
| `fabricaDeVehiculos` y fábricas | Patrón *factory* para crear autos, motos, colectivos y camiones. |
| `unq_Puerta` | Meta del juego. |
| `vida.wlk` | Manejo de la salud del alumno. |
| `vehiculo.wlk` | Definición de los vehículos. |
| `direccion.wlk` | Direcciones de movimiento (derecha e izquierda). |
| `estado.wlk` | Estados del alumno (vivo y muerto). |

## 🧠 Conceptos de programación aplicados

- **Polimorfismo**: los vehículos, las fábricas y los estados del alumno se usan de forma intercambiable.
- **Patrón State**: el alumno delega su movimiento en el estado actual (`vivo` o `muerto`).
- **Patrón Factory**: cada tipo de vehículo tiene su propia fábrica.
- **Delegación**: la interacción por colisión se resuelve con `algo.interaccion(alumno)`.
- **Composición**: los carriles reciben su dirección, fila, tiempo de espera y generador de vehículos.

## ▶️ Cómo ejecutarlo

1. Instalá [Wollok](https://www.wollok.org) o la extensión de Wollok para VS Code.
2. Cloná o descargá este repositorio.
3. Abrí el proyecto y ejecutá el programa principal con *Run Program*.

## 👥 Autores

 
- Mauricio Jose Chacolla Castellon 
- Daniel Rubio
- Juan Melo


Trabajo realizado para la materia Programación con Objetos I — Universidad Nacional de Quilmes.
