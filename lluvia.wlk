import wollok.game.*
import videojuegoGRUPO5.*

class Gota {
    const property position
    
    method image() = if (self.protegidaPorParaguas()) "sinLluvia.png" else "lluvia.png"             // si  el paraguas abierto, no se dibuja la lluvia en su fila ni en la de arriba y abajo

    method protegidaPorParaguas() = alumno.paraguasAbierto() && (position.y() - alumno.position().y()).abs() <= 1

   method interaccion(alguien) {}
}

object lluvia {
    method iniciar() {
        game.width().times({ columna => game.height().times({ fila =>
                game.addVisual(new Gota(position = game.at(columna - 1, fila - 1)))
            })
        })
    }
}