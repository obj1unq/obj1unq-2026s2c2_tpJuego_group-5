# 🚸 Cruzar la carretera

> Videojuego hecho con **Wollok Game** para la materia *Programación con Objetos 1* (Universidad Nacional de Quilmes) — **Grupo 5**.

Un estudiante tiene que cruzar una carretera muy transitada para llegar a la universidad. Parece fácil... hasta que aparecen las motos, los autos, los colectivos y los camiones. Tiene solo **3 vidas**: hay que cruzar con habilidad y buenos reflejos.

---

## 🎮 ¿En qué consiste el juego?

El jugador controla a un alumno que empieza en la parte inferior del tablero. Su objetivo es **llegar a la puerta de la UNQ**, ubicada del otro lado de la carretera, atravesando los carriles sin que lo atropelle ningún vehículo.

Cada vez que un vehículo choca contra el alumno, tiene una interacción segun el tipo de vehículo que sea, la cual es detallada en la sección Obstáculos.

---

## 👤 Personaje principal: el alumno

Es el único personaje que controla el jugador.

- **Objetivo:** cruzar todos los carriles y llegar a la UNQ.
- **Vidas:** empieza con **3 vidas**, que se muestran como corazones en pantalla. Cada atropello descuenta una y el corazón correspondiente se vacía.
- **Aspecto cambiable:** la imagen del alumno cambia según las vidas que le quedan, así se ve de un vistazo en qué estado está.
- **Al ser atropellado:** pierde una vida y regresa a su posición inicial.
- **Al quedarse sin vidas:** anuncia su derrota ("me morí") y pierde la partida.
- **Límites:** no puede salirse del tablero.

---

## 🚗 Obstáculos: los vehículos

Los obstáculos son vehículos que recorren los carriles de lado a lado. Hay cuatro tipos, cada uno con su propia velocidad:

| Vehículo | Velocidad | Daño 
|---|---| --- |
| 🏍️ Moto | La más rápida | 1 |
| 🚗 Auto | Rápida | 1 |
| 🚌 Colectivo | Media | 2 |
| 🚛 Camión | La más lenta | 2 |

**Cómo se comportan:**

- La carretera está formada por varios **carriles**. Cada carril tiene su propia fila en el tablero y su propia dirección: unos van hacia la derecha y otros hacia la izquierda.
- Cada vehículo avanza celda por celda hasta llegar al borde del tablero y desaparece.
- Después de unos segundos de espera, el carril genera un **nuevo vehículo de un tipo elegido al azar**, así que el tráfico nunca es igual dos veces.
- Si un vehículo toca al alumno, este es atropellado y pierde una vida o 2 vidas.

---

## ⌨️ Controles

| Tecla | Acción |
|---|---|
| ⬆️ Flecha arriba | Mover hacia arriba |
| ⬇️ Flecha abajo | Mover hacia abajo |
| ⬅️ Flecha izquierda | Mover hacia la izquierda |
| ➡️ Flecha derecha | Mover hacia la derecha |

---

## 🚧 Próximas mejoras (ideas futuras)

- Pantalla de victoria al llegar a la UNQ.
- Interacciones que agreguen mas mecanicas distintas según el tipo de vehículo.
- Comida que aparece cada tanto y permite recuperar una vida.
- Niveles.

---

## 👥 Equipo

**Grupo 5** — Programación con Objetos 1, Universidad Nacional de Quilmes

- Daniel Rubio
- Juan Melo
- Mauricio Chacolla
