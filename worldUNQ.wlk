import wollok.game.*
import nivel.*
//limitaciones del tablero
object tablero {
    const alto = 10
    const ancho = 10
    const tamañoDeCelda = 50
    const titulo = "Cruzar la carretera"

    method iniciar(){
        game.height(alto)
        game.width(ancho)
        game.cellSize(tamañoDeCelda)
        game.title(titulo)
    }

    method filaInicialIzquierda() = 0
    method filaInicialDerecha() = ancho - 1
    method topeTablero() = alto - 1

}


