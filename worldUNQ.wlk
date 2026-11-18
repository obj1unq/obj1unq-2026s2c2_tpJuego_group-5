import wollok.game.*
import nivel.*
//limitaciones del tablero
object tablero {
    const alto = 10
    const ancho = 10
    const tamañoDeCelda = 50
    const titulo = "Cruzar la carretera"

    method iniciar(){
        game.addVisual(fondoMenu)
        game.height(alto)
        game.width(ancho)
        game.cellSize(tamañoDeCelda)
        game.title(titulo)
    }

    method columnaInicialDerecha() = 0
    method columnaInicialIzquierda() = ancho - 1
    method filaInicialSuperior() = alto - 1

}


