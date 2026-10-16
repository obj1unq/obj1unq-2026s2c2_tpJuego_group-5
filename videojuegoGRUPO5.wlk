import wollok.game.*


//direcciones
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

class Carril {
    const direccion

    method direccion() = direccion

    method posicionInicial(fila) = game.at(direccion.columnaInicial(), fila)

    method agregar(vehiculo) {
        vehiculo.asignarCarril(self)
        game.addVisual(vehiculo)
        game.onCollideDo(vehiculo, { alumno => alumno.serAtropellado() })
        vehiculo.empezarARecorrer()
    }
}

object carrilDerecha inherits Carril(direccion = derecha) {}
object carrilIzquierda inherits Carril(direccion = izquierda) {}

/*
object generadorDeVehiculos {
    const carriles = [carrilDerecha, carrilIzquierda]
    const intervalosPosibles = [300, 400, 500, 600, 800, 900]
    const filasLibres = [1, 2, 3, 4, 5, 6]

    method generar(cantidad) {
        cantidad.times({ n => self.agregarVehiculoAleatorio() })
    }

    method agregarVehiculoAleatorio() {
        const fila = filasLibres.anyOne()
        filasLibres.remove(fila)

        const carril = carriles.anyOne()
        const intervalo = intervalosPosibles.anyOne()

        carril.agregar(new Vehiculo(fila = fila, intervaloEnMs = intervalo))
    }
}

*/













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

object unq {
    var property position = game.at(4,9) 

	method image () = "AccesoUNQ.jpg" 
}

object autoADerecha {
    var property position = game.at(0,2) 
	
	method posicionInicial() = game.at(0,2) 
	
	method empezarARecorrer() {
		game.onTick(800, "moverD", {self.autoMueveDerecha()})
	}
	method image () = "auto.png" 

	method autoMueveDerecha() {
		if (position.x() < 10){
			position = position.right(1)
		}else{
			position = self.posicionInicial()
		}
	}
}

// =====================================================================
//  VIDAS DEL PERSONAJE PRINCIPAL
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


//=====Sector de alumno===
//
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

class Vehiculo {
    const fila
    const intervaloEnMs
    var carril = null
    var property position = null
    var property tipoVehiculo = auto
    

    method image() = tipoVehiculo.nombre() + ".png"


    

    method asignarCarril(unCarril) {
        carril = unCarril
        position = unCarril.posicionInicial(fila)
    }

    method empezarARecorrer() {
        const tick = game.tick(intervaloEnMs, { self.avanzar() }, false)
        tick.start()
    }

     method avanzar() {
        if (carril.direccion().puedeAvanzar(position)) {
            position = carril.direccion().siguiente(position)
        } else {
            game.removeVisual(self)
            generadorDeVehiculos.agregarEnCarril(carril.)
        }

    }
}





object auto{
    var property otroVehiculo = camion 

    method nombre() = "auto"

}

object camion {
  var property otroVehiculo = auto

  method nombre() = "camion"
}




object generadorDeVehiculos {
    const carriles = [carrilDerecha, carrilIzquierda]
    const filasLibres = [1, 2, 3, 4, 5, 6]

    method generar(cantidad) {
        cantidad.times({ n => self.agregarVehiculoAleatorio() }){
            self.error("la cantidad de autos es mayor a la de carriles")
        }
    }

    method agregarVehiculoAleatorio() {
        const filaRandomElegida = filasLibres.anyOne()
        filasLibres.remove(filaRandomElegida)

        const carril = carriles.anyOne()
        self.agregarEnCarril(carril)
     
    }

    method pruebaIntervaloRandom() {
      return 75.randomUpTo(500)
    }


method agregarEnCarril(carril) {

   const intervalo = self.pruebaIntervaloRandom()
        const tiposDeVehiculo = [auto, camion]
        //intervalosPosibles.anyOne()//

        carril.agregar(new Vehiculo(fila = carril, intervaloEnMs = intervalo, tipoVehiculo = tiposDeVehiculo.anyOne()))  
}












}	