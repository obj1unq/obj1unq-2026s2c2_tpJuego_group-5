import wollok.game.*
import videojuegoGRUPO5.*   
import direccion.*
import estado.*
import worldUNQ.*
import menu.*
import nivel.*
object juego {

    var property estado = menuPrincipal
    method comenzar() {
        estado.empezar()
    }
}