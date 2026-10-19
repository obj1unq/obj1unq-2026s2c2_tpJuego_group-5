import wollok.game.*

// =====================================================================
//  ALUMNO: PERSONAJE PRINCIPAL
// =====================================================================
object alumno {
    var vidaRestante = terceraVida
    var property position = game.at(4,0)
    var aspecto = alumnoSano
	
	method descontarVida(){
		vidaRestante.marcarComoPerdida()
		vidaRestante = vidaRestante.vidaInferior()
		aspecto = aspecto.siguienteEtapa()
	}
   
	method serAtropellado() {
		if (not self.estaMuerto()) {
			self.descontarVida()
			
			self.volverAlInicio()
			self.fueDerrotado()
		}
		
	}

	method fueDerrotado(){
		if(self.estaMuerto()){
			self.anunciarDerrota()
		}
	}

	method anunciarDerrota() {
		   game.say(self, "me morí") 
	}

	method volverAlInicio() { position = game.at(4,0) }

	method estaMuerto() {
		return vidaRestante.cantidadDeVidas() == 0
	}

	method mover(direccion) {
		position = direccion.siguiente(position)
	  
	}
	method image() = "estudiante_" + aspecto.nombre() + ".png"
}

/////////////////////////VIDA DE ALUMNO /////////////////////////

object alumnoSano{
	method nombre() = "3vidas"
	
	method siguienteEtapa() = alumnoLastimado
}
object alumnoLastimado{
	method nombre() = "2vidas"
	
	method siguienteEtapa() = alumnoMalherido
}
object alumnoMalherido{
	method nombre() = "1vida"
	
	method siguienteEtapa() = alumnoFallecido
}

object alumnoFallecido{
	method nombre() = "0vida"
	
	method siguienteEtapa() = self
}

// =====================================================================
//  VIDAS DEL PERSONAJE PRINCIPAL: se encarga de modelar las vidas del PERSONAJE PRINCIPAL y
// ademas tambien modela el aspecto que tiene el personaje segun su vida
// =====================================================================
class Vida{
	var property position
	const nombre
	const cantidadDeVidas
	var aspecto = conVida
	
	method cantidadDeVidas() = cantidadDeVidas
	
	method image() = aspecto.nombreDeVida(nombre) + "_vida.png"
	
	method marcarComoPerdida(){
		aspecto = sinVida
	}
		
	method vidaInferior() = primeraVida
}
object terceraVida{
	var property position = game.at(9,0)
	var aspecto = self
	
	method cantidadDeVidas() = 3
	
	method image() = aspecto.nombre()+"_vida.png"
	method nombre() = "tercera"
	
	method marcarComoPerdida(){
		aspecto = sinVida
	}
	
	method vidaInferior() = segundaVida
}
object sinVida{
	method nombreDeVida(nombre) = "sin"
	
	method estaPerdida() = true
}

object conVida{
	method nombreDeVida(nombre) = nombre
	
	method estaPerdida() = false
}

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
}
object abajo {
    method siguiente(posicion) {
        self.validarSiguiente(posicion)
        return posicion.down(1)
    }
        method validarSiguiente(posicion) {
        if(posicion.y() == 0 ) {
            self.error('No se puede mover hacia abajo')
        }
    }
}
// =====================================================================
//  CARRILES y todas las class y object que son de dominio obtaculos.
// =====================================================================
class Carril {
	const property fila
    const property direccion
	const property tiempoDeEspera
	const intervaloMinimo 
    const intervaloMaximo 
    const tiposDeVehiculo 


    method posicionInicial() = game.at(direccion.columnaInicial(), fila)
	
    method iniciarViaje() {
		const vehiculo = self.agregarVehiculoNuevo()
        game.addVisual(vehiculo)
        vehiculo.empezarARecorrer()
    }
	
	method retirarVehiculo(vehiculo){
		game.removeVisual(vehiculo)
		game.schedule(tiempoDeEspera, { => self.iniciarViaje() })
	}
	
	method agregarVehiculoNuevo(){
		return
			new Vehiculo(
				carril = self ,
				intervaloEnMs = self.intervaloEnMsAleatorio(),
				tipo = tiposDeVehiculo.anyOne() )
	}
	
	method intervaloEnMsAleatorio() = intervaloMinimo.randomUpTo(intervaloMaximo).truncate(0)
}

/////////////////////////VEHICULOS/////////////////////////
class Vehiculo {
    const carril
    const intervaloEnMs
    const tipo
	var property position = carril.posicionInicial()
    const tick = game.tick(intervaloEnMs, { self.avanzar() }, false)

    method image() = tipo.nombre() + ".png"

    method empezarARecorrer() { tick.start() }

    method avanzar() {
        if (carril.direccion().puedeAvanzar(position)) {
            position = carril.direccion().siguiente(position)
        } else {
			tick.stop()
			carril.retirarVehiculo(self)
        }
    }
	
	method interaccion(alumno){
		alumno.serAtropellado()
	}
}

object generadorDeCarriles {
    const direcciones = [derecha, izquierda]
    const tiposDeVehiculo = [auto, camion]
    const filasLibres = [1, 2, 3, 4, 5, 6]
	const carriles = []

    method generar(cantidad) {
        self.validarCantidad(cantidad)
        cantidad.times({ n => self.agregarCarrilesAleatorio() })
		carriles.forEach( {carril => carril.iniciarViaje()})
    }

    method validarCantidad(cantidad) {
        if (cantidad > filasLibres.size()) {
            self.error("la cantidad de carriles es mayor a la de filas disponibles")
        }
    }

    method agregarCarrilesAleatorio() {
        const filaElegida = filasLibres.anyOne()
        filasLibres.remove(filaElegida)
        carriles.add( new Carril( fila = filaElegida,
								direccion = direcciones.anyOne(),
								tiempoDeEspera = 5000 ,
								intervaloMinimo = 300 ,
								intervaloMaximo = 800 ,
								tiposDeVehiculo = tiposDeVehiculo ) 
					)
    }
}

object auto {
    method nombre() = "auto"
}

object camion {
    method nombre() = "camion"
}


// =====================================================================
//  META: FINAL DEL JUEGO
// =====================================================================
object unq {
    var property position = game.at(4,9) 

	method image () = "AccesoUNQ.jpg" 
}	