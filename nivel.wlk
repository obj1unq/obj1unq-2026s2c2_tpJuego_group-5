import wollok.game.*
import videojuegoGRUPO5.*   
import direccion.*
import estado.*
import worldUNQ.*


object menuPrincipal {
    const property fondoActual = fondoMenu
    

    method empezar() {
        
        game.addVisual(fondoActual)

        keyboard.c().onPressDo({self.finalizado()})

        game.start()
    }

    method finalizado() {
        
        game.removeVisual(fondoActual)
        self.siguientePantalla().empezar()
      
    }

    method siguientePantalla() = nivel1
}
object nivel1 {
    const property fondo = fondoNivel1 

    method empezar() {
        game.addVisual(fondo)

        generadorDeCarriles.generar(4)
        
        salud.iniciar()
        
        game.addVisual(alumno)
        game.addVisual(unq_Puerta)

        game.onCollideDo(alumno, { algo => alumno.interactuar(algo) })

        keyboard.left().onPressDo({ alumno.mover(izquierda) })
        keyboard.right().onPressDo({ alumno.mover(derecha) })
        keyboard.up().onPressDo({ alumno.mover(arriba) })
        keyboard.down().onPressDo({ alumno.mover(abajo) })

        keyboard.r().onPressDo({alumno.reinicio()})
    }
}

class imagenFondo {
    method position(){
        return game.at(0,0) 
    }

    method image()
}
object fondoMenu inherits imagenFondo {
  override method image() = "pantalla1.jpeg"
}

object fondoNivel1 inherits imagenFondo {
  override method image() = "fondo_unq.png"
}