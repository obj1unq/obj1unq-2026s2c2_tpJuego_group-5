import wollok.game.*
//limitaciones del tablero
object tablero {
    const alto = 10
    const ancho = 10
    const tamañoDeCelda = 50
    const imagenDeFondo = "fondo_unq.png"
    const titulo = "Cruzar la carretera"

    method iniciar(){
        game.height(alto)
        game.width(ancho)
        game.cellSize(tamañoDeCelda)
        game.boardGround(imagenDeFondo)
        game.title(titulo)
    }

    method columnaInicialDerecha() = 0
    method columnaInicialIzquierda() = ancho - 1
    method filaInicialSuperior() = alto - 1

}


