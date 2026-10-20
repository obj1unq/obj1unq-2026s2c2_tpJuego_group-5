import wollok.game.*

// =====================================================================
//  ALUMNO: PERSONAJE PRINCIPAL
// =====================================================================
object alumno {
    const vidasRestantes = salud
    var property position = game.at(4,0)
	
	method descontarVida(){
		vidasRestantes.perderUnaVida()
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
		return !vidasRestantes.hayVidas()
	}

	method mover(direccion) {
		position = direccion.siguiente(position)
	  
	}
	method image() = "estudiante_" + vidasRestantes.cuantasVidasHay() + "vida.png"
	
	//interacciones con colisiones:
	method interactuar(algo){
		algo.interaccion(self)
	}
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
	
	method marcarComoRecuperada(){
		aspecto = conVida
	}
	
	method estaPerdida() = aspecto.estaPerdida()
}
object salud {
	//Es en orden descendente, es decir, de la vida mas alta (3) hasta la mas baja (1)
	const vidas = [
        new Vida(position = game.at(9,0), nombre = "tercera",   cantidadDeVidas = 3),
        new Vida(position = game.at(8,0), nombre = "segunda",   cantidadDeVidas = 2),
		new Vida(position = game.at(7,0), nombre = "primera",   cantidadDeVidas = 1)
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
}

//Objetos de tipo estadoDeVida que son usados por salud
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
	
	method nombre() = "izquierda"
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

class Vehiculo {
    const carril
    const intervaloEnMs
    const tipo
	var property position = carril.posicionInicial()
    const tick = game.tick(intervaloEnMs, { self.avanzar() }, false)

    method image() = tipo.nombre() + "_" + carril.direccion().nombre() +".png"

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
								tiempoDeEspera = 3000 ,
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