import videojuegoGRUPO5.*
import direccion.*
import vida.*
class EstadoPersonaje{
    method mover(alumno, direccion)
    method estaVivo()  
}

object vivo inherits EstadoPersonaje {
    override method mover(alumno, direccion){
    alumno.position(direccion.siguienteParaAlumno(alumno))
    }
    override method estaVivo() = true
}

object muerto inherits EstadoPersonaje {
    override method mover(alumno, direccion){}
    override method estaVivo() = false
}