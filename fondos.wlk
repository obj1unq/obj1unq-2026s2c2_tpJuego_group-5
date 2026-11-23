
class ImagenFondo {
    method position() = game.origin()
    method image()

    method interaccion(persojePrincipal){
      persojePrincipal.interaccionConObjetoEstetico()
    }
}

object fondoMenu inherits ImagenFondo {
    override method image() = "pantalla1.png"
}
object fondoDescriptivoNivel1 inherits ImagenFondo {
    override method image() = "pantallaNivel1.jpeg"
}
object fondoNivel1 inherits ImagenFondo {
    override method image() = "fondo_unq.png"
}
object fondoDescriptivoNivel2 inherits ImagenFondo {
    override method image() = "llegoALaUnq.png"
}

object fondoDescriptivoNivel22 inherits ImagenFondo {               //esta pantalla es agregada para que sepa que puede usar el paraguas
    override method image() = "pantallaParaguas.png"                
}

object fondoNivel2 inherits ImagenFondo {
    override method image() = "fondo_2.jpeg"
}

object fondoDescriptivoNivel3 inherits ImagenFondo {
    override method image() = "pantallaLlegandoTarde.png"
}


object fondoNivel3 inherits ImagenFondo {
    override method image() = "fondo_3.jpeg"
}