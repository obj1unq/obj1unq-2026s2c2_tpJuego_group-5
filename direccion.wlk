// =====================================================================
//  DIRECCIONES del PERSONAJE PRINCIPAL. Tambien son usadas para Carriles/Vehiculos
// =====================================================================
object izquierda {

    method siguiente(posicion) {
        self.validarSiguiente(posicion)
        return posicion.left(1)
    }
    method validarSiguiente(posicion) {
        if (not self.puedeAvanzar(posicion)) {
            self.error('No se puede mover a la izquierda')
        }
    }
	
	method puedeAvanzar(posicion) = posicion.x() > 0

	method columnaInicial() = game.width() - 1
	
	method nombre() = "izquierda"

    //mensajes para limitar el movimiento del alumno:
    method siguienteParaAlumno(alumno) {
        self.validarSiguienteParaAlumno(alumno.position())
        return alumno.position().left(1)
    }
    method validarSiguienteParaAlumno(alumno) {
        if (!self.puedeAvanzarParaAlumno(alumno)) {
            self.error('No se puede mover a la izquierda')
        }   
        if (self.limiteSuperiorParaAlumno(alumno)){
            self.error('No se puede mover a la izquierda')
        }
    }
    method puedeAvanzarParaAlumno(alumno) = alumno.x() > 0 
    method limiteSuperiorParaAlumno(alumno) = alumno.y() == 6
}
object derecha {
    method siguiente(posicion) {
        self.validarSiguiente(posicion)
        return posicion.right(1)
    }
    method validarSiguiente(posicion) {
        if (not self.puedeAvanzar(posicion)) {
            self.error('No se puede mover a la derecha')
        }
    }
	
	method puedeAvanzar(posicion) = posicion.x() < game.width() - 1

	method columnaInicial() = 0
	
	method nombre() = "derecha"
    //mensajes para limitar el movimiento del alumno:
    method siguienteParaAlumno(alumno) {
        self.validarSiguienteParaAlumno(alumno.position())
        return alumno.position().right(1)
    }
    method validarSiguienteParaAlumno(alumno) {
        if (!self.puedeAvanzarParaAlumno(alumno)) {
            self.error('No se puede mover a la izquierda')
        }
        if (self.limiteSuperiorParaAlumno(alumno)){
            self.error('No se puede mover a la izquierda')
        }
    }
    method puedeAvanzarParaAlumno(alumno) = alumno.x() < game.width() - 1
        method limiteSuperiorParaAlumno(alumno) = alumno.y() == 6
}

object arriba {
    method siguiente(posicion) {
        self.validarSiguiente(posicion)
        return posicion.up(1)
    }
    method validarSiguiente(posicion) {
        if(posicion.y() == game.height() - 1 ) {
            self.error('No se puede mover hacia arriba')
        }
    }

    //mensajes para limitar el movimiento del alumno:
    method siguienteParaAlumno(alumno) {
        self.validarSiguienteParaAlumno(alumno.position())
        return alumno.position().up(1)
    }
    method validarSiguienteParaAlumno(alumno) {
        if (!self.puedeAvanzarParaAlumno(alumno)) {
            self.error('No se puede mover a la izquierda')
        }
        if(self.limiteSuperiorParaAlumno(alumno)){
            self.error('No se puede mover a la izquierda')
        }   
    }
    method puedeAvanzarParaAlumno(alumno) = alumno.y() < 6 
    method limiteSuperiorParaAlumno(alumno) = alumno.y() == 5 && alumno.x().between(0, 4) || alumno.x().between(6, 9)
}
object abajo {
    method siguiente(posicion) {
        self.validarSiguiente(posicion)
        return posicion.down(1)
    }
        method validarSiguiente(posicion) {
        if(!self.puedeAvanzarSiguiente(posicion)) {
            self.error('No se puede mover hacia abajo')
        }
    }
    method puedeAvanzarSiguiente(posicion) = posicion.y() > 0 
    
    //mensajes para limitar el movimiento del alumno:
    method siguienteParaAlumno(alumno) {
        self.validarSiguienteParaAlumno(alumno.position())
        return alumno.position().down(1)
    }
    method validarSiguienteParaAlumno(alumno) {
        if (!self.puedeAvanzarSiguiente(alumno)) {
            self.error('No se puede mover a la izquierda')
        }
    }
    //method puedeAvanzarParaAlumno(alumno) no es necesario, asi que reutilo el generio puedeAvanzarSiguiente()
}