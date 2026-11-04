import videojuegoGRUPO5.*
import direccion.*
import vida.*
class EstadoPersonaje{
    method mover(alumno, direccion){
    }
}

object vivo inherits EstadoPersonaje {
    override method mover(alumno, direccion){
    alumno.position(direccion.siguienteParaAlumno(alumno))
    }
}

object muerto inherits EstadoPersonaje {

}