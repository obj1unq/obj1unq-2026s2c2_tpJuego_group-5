import videojuegoGRUPO5.*
import direccion.*
// =====================================================================
//  ESTADO DEL PERSONAJE PRINCIPAL: se encarga de modelar el aspecto del PERSONAJE PRINCIPAL y
//  lo se para en 2 estados claves, vivo y muerto, decidiendo cuando puede moverse.
// =====================================================================
class EstadoPersonaje{
    const vida = salud
    method mover(alumno, direccion)
    method estaVivo()  
    method vidaActual()
    method cuantasVidasHay() = vida.cuantasVidasHay()
    method opuesto()
	method reiniciar()
}

object vivo inherits EstadoPersonaje {
    override method mover(alumno, direccion){
        alumno.position(direccion.siguienteParaAlumno(alumno))
    }

    override method vidaActual() {
        vida.perderUnaVida()
    }

    override method estaVivo() = true
    override method opuesto() = muerto

    override method reiniciar() {
        vida.recuperarTodas()
    }
}


object muerto inherits EstadoPersonaje {
    override method mover(alumno, direccion){}
    override method vidaActual() {
        vida.perderUnaVida()
    }

    override method estaVivo() = false
    override method opuesto() = vivo
	override method reiniciar(){
		alumno.estado(vivo)
		vida.recuperarTodas()
	}
}


// =====================================================================
//  VIDAS DEL PERSONAJE PRINCIPAL: se encarga de modelar las vidas del PERSONAJE PRINCIPAL y
// es usada en Estado del personaje para elejir el aspecto que tiene el personaje segun su vida
// =====================================================================
class Vida{
	var property position
	const cantidadDeVidas
	var aspecto = conVida
	
	method cantidadDeVidas() = cantidadDeVidas
	
	method image() = aspecto.nombreDeVida() + ".png"
	
	method marcarComoPerdida(){
		aspecto = sinVida
	}
	
	method marcarComoRecuperada(){
		aspecto = conVida
	}
	
	method estaPerdida() = aspecto.estaPerdida()

	//mensaje de colisión contra el alumno
	method interaccion(alumno) {
        alumno.paraDespues()
    }
}
object salud {
	//Es en orden descendente, es decir, de la vida mas alta (3) hasta la mas baja (1)
	const vidas = [
        new Vida(position = game.at(9,0),   cantidadDeVidas = 3),
        new Vida(position = game.at(8,0),   cantidadDeVidas = 2),
		new Vida(position = game.at(7,0),   cantidadDeVidas = 1)
    ]

    method iniciar() {
        vidas.forEach({ vida => game.addVisual(vida) })
    }

	method cuantasVidasHay() = 
		if (self.hayVidas()) {self.encontrarVidaNoPerdida().cantidadDeVidas()}
		else { 0 }
	method hayVidas() = vidas.any({vida => !vida.estaPerdida()})
	method encontrarVidaNoPerdida() = vidas.find({vida => !vida.estaPerdida()})
	
	method perderUnaVida(){
		if(self.hayVidas()){
			self.encontrarVidaNoPerdida().marcarComoPerdida()
		}
	}

	method recuperarTodas() {
		vidas.forEach({ vida => vida.marcarComoRecuperada() })
	}
	/*metodos para recuperar vidas, idea a futuro:
	method ganarUnaVida(){
		self.validarGanarVida()
		self.encontrarVidaPerdida().marcarComoRecuperada()
	}
	method validarGanarVida(){
		if(!self.hayAlgunaVidaPerdida()){
			self.error("Tengo las vidas llenas")
		}
	}
	method hayAlgunaVidaPerdida() = vidas.any({vida => vida.estaPerdida()})
	method encontrarVidaPerdida() = vidas.filter({vida => vida.estaPerdida()}).last()
	*/
}

//Objetos de tipo estadoDeVida que son usados por salud
object sinVida{
	method nombreDeVida() = "muerto"
	
	method estaPerdida() = true
}

object conVida{
	method nombreDeVida() = "vivo"
	
	method estaPerdida() = false
}