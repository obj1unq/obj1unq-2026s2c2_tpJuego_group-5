import wollok.game.*
import videojuegoGRUPO5.*   
import direccion.*
import estado.*
import worldUNQ.*

class Niveles{
 method empezar()
 method finalizado()
 method siguientePantalla()
}

object menuPrincipal inherits Niveles{
    const property fondoActual = fondoMenu
    

  override  method empezar() {
        
        keyboard.c().onPressDo({self.finalizado()})
        game.start()
    }

   override method finalizado() {
        game.removeVisual(fondoActual)
        self.siguientePantalla().empezar()
    }

  override  method siguientePantalla() = nivel1
}
object nivel1 inherits Niveles {
    const property fondo = fondoNivel1 

  override  method empezar() {
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
    override method finalizado(){}
    override method siguientePantalla(){}
}

class ImagenFondo {
    method position(){
        return game.at(0,0) 
    }

    method image()
}
object fondoMenu inherits ImagenFondo {
  override method image() = "pantalla1.png"
}

object fondoNivel1 inherits ImagenFondo {
  override method image() = "fondo_unq.png"
}