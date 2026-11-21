import wollok.game.*

class Gota {
    const property position

    method image() = "lluvia.png"

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