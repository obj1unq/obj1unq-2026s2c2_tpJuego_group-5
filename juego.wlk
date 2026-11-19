import wollok.game.*
import videojuegoGRUPO5.*
import direccion.*
import estado.*
import fondos.*
import carril.*
import nivel.*

object gestorDeEtapas {
    var etapaActual = menuPrincipal

    method comenzar() {
        etapaActual.empezar()
        game.start()
    }

    method avanzar() {
        game.clear()
        etapaActual = etapaActual.siguienteEtapa()
        etapaActual.empezar()
    }
}

class Etapa {
    method fondo()
    method siguienteEtapa()
    method configurar()

    method empezar() {
        game.addVisual(self.fondo())
        self.configurar()
    }
}

class Presentacion inherits Etapa {
    override method configurar() {
        keyboard.c().onPressDo({ gestorDeEtapas.avanzar() })
    }
}

class Nivel inherits Etapa {
    method generadorDeCarriles()
    method cantidadDeCarriles()

    override method configurar() {
        self.generadorDeCarriles().generar(self.cantidadDeCarriles())

        salud.iniciar()
        alumno.volverAlInicio()
        game.addVisual(alumno)
        game.addVisual(unq_Puerta)

        game.onCollideDo(alumno, { algo => alumno.interactuar(algo) })

        keyboard.left().onPressDo({ alumno.mover(izquierda) })
        keyboard.right().onPressDo({ alumno.mover(derecha) })
        keyboard.up().onPressDo({ alumno.mover(arriba) })
        keyboard.down().onPressDo({ alumno.mover(abajo) })
        keyboard.r().onPressDo({ alumno.reinicio() })
    }
}