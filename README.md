# 🚸 Cruzar la carretera

> Videojuego hecho con **Wollok Game** para la materia *Programación con Objetos 1* (Universidad Nacional de Quilmes) — **Grupo 5**.

Un estudiante tiene que cruzar una carretera muy transitada para llegar a la universidad. Parece fácil... hasta que aparecen las motos, los autos, los colectivos y los camiones. Tiene solo **3 vidas**: hay que cruzar con habilidad y buenos reflejos.

---

## 🎮 ¿En qué consiste el juego?

El jugador controla a un alumno que empieza en la parte inferior del tablero. Su objetivo es **llegar a la puerta de la UNQ**, ubicada del otro lado de la carretera, atravesando los carriles sin que lo atropelle ningún vehículo.

Cada vez que un vehículo choca contra el alumno, tiene una interacción distinta segun el tipo de vehículo que sea, la cual es detallada en la sección Obstáculos.

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

| Vehículo | Velocidad |
|---|---|
| 🏍️ Moto | La más rápida |
| 🚗 Auto | Rápida |
| 🚌 Colectivo | Media |
| 🚛 Camión | La más lenta |

**Cómo se comportan:**

- La carretera está formada por varios **carriles**. Cada carril tiene su propia fila en el tablero y su propia dirección: unos van hacia la derecha y otros hacia la izquierda, y se sortean al iniciar el juego.
- Cada vehículo avanza celda por celda hasta llegar al borde del tablero y desaparece.
- Después de unos segundos de espera, el carril genera un **nuevo vehículo de un tipo elegido al azar**, así que el tráfico nunca es igual dos veces.
- Si un vehículo toca al alumno, este es atropellado y pierde una vida.

---

## ⌨️ Controles

| Tecla | Acción |
|---|---|
| ⬆️ Flecha arriba | Mover hacia arriba |
| ⬇️ Flecha abajo | Mover hacia abajo |
| ⬅️ Flecha izquierda | Mover hacia la izquierda |
| ➡️ Flecha derecha | Mover hacia la derecha |

---

## 🗂️ Estructura del proyecto

| Archivo | Contenido |
|---|---|
| `main.wpgm` | Programa principal: configura el tablero, agrega los objetos y registra las teclas |
| `videojuegoGRUPO5.wlk` | Alumno, carriles, generadores y la meta (puerta de la UNQ) |
| `vehiculo.wlk` | Clase `Vehiculo` y sus subclases: `Auto`, `Moto`, `Colectivo` y `Camion` |
| `vida.wlk` | Las vidas del alumno |
| `direccion.wlk` | Direcciones de movimiento (`derecha`, `izquierda`, `arriba`, `abajo`) |
| `assets/` | Imágenes del juego |
| `testJuego.wtest` | Tests |

---

## 🧠 Conceptos de Programación con Objetos aplicados

- **Clases y herencia:** `Vehiculo` es una clase abstracta de la que heredan `Auto`, `Moto`, `Colectivo` y `Camion`; cada subclase define su nombre y su velocidad.
- **Polimorfismo:** las direcciones y los tipos de vehículo responden a los mismos mensajes, así que el código que los usa no necesita preguntar de qué tipo son.
- **Objetos bien conocidos:** el alumno, la meta y los generadores son objetos únicos.
- **Colecciones y bloques:** las listas de carriles, vidas y generadores se recorren con `forEach`, `anyOne` y similares.
- **Double dispatch:** cuando el alumno choca con algo, le avisa al otro objeto para que decida qué pasa (`interactuar` / `interaccion`), en vez de preguntarle qué es.
- **Responsabilidad de cada objeto:** cada carril sabe crear y reponer sus propios vehículos, y cada vehículo sabe moverse y avisarle al carril cuando termina su recorrido.

---

## 🚧 Próximas mejoras

- Pantalla de victoria al llegar a la UNQ.
- Reiniciar la partida con la tecla **R**.
- Interacciones distintas según el tipo de vehículo.
- Comida que aparece cada tanto y permite recuperar una vida.
- Zonas del tablero por donde el alumno no puede caminar.

---

## 👥 Equipo

**Grupo 5** — Programación con Objetos 1, Universidad Nacional de Quilmes

- _Nombre del integrante 1_
- _Nombre del integrante 2_
- _..._