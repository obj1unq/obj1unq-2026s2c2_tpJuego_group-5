// =====================================================================
//  DIRECCIONES del PERSONAJE PRINCIPAL. Tambien son usadas para Carriles/Vehiculos
// =====================================================================

class Direccion{
    method nombre() 
    method texto()
    method mover(posicion)
    method puedeAvanzar(posicion)

    method mensajeDeError() = "No se puede mover" + self.texto()

      method siguiente(posicion) {
        self.validarSiguiente(posicion)
        return self.mover(posicion)
    }

      method validarSiguiente(posicion) {
        if (!self.puedeAvanzar(posicion)) {
            self.error(self.mensajeDeError())
        }
    }

      method siguienteParaAlumno(alumno) {
        const posicion = alumno.position()
        self.validarSiguienteParaAlumno(posicion)
        return self.mover(posicion)
    }

      method validarSiguienteParaAlumno(posicion) {
        if (!self.puedeAvanzarParaAlumno(posicion) || self.limiteSuperiorParaAlumno(posicion)) {
            self.error(self.mensajeDeError())
        }
      }  

       method puedeAvanzarParaAlumno(posicion) = self.puedeAvanzar(posicion)

        method limiteSuperiorParaAlumno(posicion) = posicion.y() == 6
    
}

object izquierda inherits Direccion {
    override method nombre() = "izquierda"
    override method texto() = "a la izquierda"
    override method mover(posicion) = posicion.left(1)
    override method puedeAvanzar(posicion) = posicion.x() > 0

    method columnaInicial() = game.width() - 1
}

object derecha inherits Direccion {
    override method nombre() = "derecha"
    override method texto() = "a la derecha"
    override method mover(posicion) = posicion.right(1)
    override method puedeAvanzar(posicion) = posicion.x() < game.width() - 1

    method columnaInicial() = 0
}
object arriba inherits Direccion {
    override method nombre() = "arriba"
    override method texto() = "hacia arriba"
    override method mover(posicion) = posicion.up(1)
    override method puedeAvanzar(posicion) = posicion.y() < game.height() - 1

    override method puedeAvanzarParaAlumno(posicion) = posicion.y() < 6
    override method limiteSuperiorParaAlumno(posicion) =
        posicion.y() == 5 && (posicion.x().between(0, 4) || posicion.x().between(6, 9))
}
object abajo inherits Direccion {
    override method nombre() = "abajo"
    override method texto() = "hacia abajo"
    override method mover(posicion) = posicion.down(1)
    override method puedeAvanzar(posicion) = posicion.y() > 0

    // abajo no tiene límite superior
    override method limiteSuperiorParaAlumno(posicion) = false
}
    //method puedeAvanzarParaAlumno(alumno) no es necesario, asi que reutilizo el generico puedeAvanzarSiguiente()