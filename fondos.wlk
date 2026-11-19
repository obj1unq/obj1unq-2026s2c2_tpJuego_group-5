
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
object fondoNivel2 inherits ImagenFondo {
    override method image() = "fondo_2.jpeg"
}
object fondoNivel3 inherits ImagenFondo {
    override method image() = "fondo_3.jpeg"
}