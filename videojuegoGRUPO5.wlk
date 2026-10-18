import wollok.game.*


/////////////////////////DIRECCIONES/////////////////////////
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
    // en object izquierda
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
    // en object derecha
    method nombre() = "derecha"
}


/////////////////////////CARRIL/////////////////////////
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

/////////////////////////ALUMNO/////////////////////////
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

/////////////////////////FACULTAD/////////////////////////
object unq {
    var property position = game.at(4,9) 

	method image () = "AccesoUNQ.jpg" 
}



//=====Sector de Vida=== //
object primeraVida{
	var property position = game.at(7,0)
	var aspecto = self

	method cantidadDeVidas() = 1

	method image() = aspecto.nombre() + "_vida.png"
	method nombre() = "primera"

	method marcarComoPerdida(){
		aspecto = self.vidaInferior()
	}
	method vidaInferior() = sinVida	
}
object segundaVida{
	var property position = game.at(8,0)
	var aspecto = self

	method cantidadDeVidas() = 2

	method image() = aspecto.nombre() + "_vida.png"
	method nombre() = "segunda"
	
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
	method nombre() = "sin"
	
	method vidaInferior() = self
	
	method cantidadDeVidas() = 0
}
//=====Aca finaliza===


/////////////////////////VEHICULOS/////////////////////////
class Vehiculo {
    const fila
    const intervaloEnMs
    var carril = null
    var property position = null
    var property tipoVehiculo = auto

    method image() = tipoVehiculo.nombre() + "_" + carril.direccion().nombre() + ".png"

    method nombreTick() = "mover" + self.identity()

    method asignarCarril(unCarril) {
        carril = unCarril
        position = unCarril.posicionInicial(fila)
    }

    method empezarARecorrer() {
        game.onTick(intervaloEnMs, self.nombreTick(), { self.avanzar() })
    }

    method avanzar() {
        if (carril.direccion().puedeAvanzar(position)) {
            position = carril.direccion().siguiente(position)
        } else {
            game.removeTickEvent(self.nombreTick())
            game.removeVisual(self)
            generadorDeVehiculos.agregarEnCarrilConPausa(carril, fila)
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
    const fila = filasLibres.anyOne()
    filasLibres.remove(fila)
    self.agregarEnCarril(carriles.anyOne(), fila)
}

method pausaRandom() = 500.randomUpTo(2000).truncate(0)

method agregarEnCarrilConPausa(carril, fila) {
    game.schedule(self.pausaRandom(), { self.agregarEnCarril(carril, fila) })
}

method agregarEnCarril(carril, fila) {
    const tiposDeVehiculo = [auto, camion]
    carril.agregar(new Vehiculo(
        fila = fila,
        intervaloEnMs = self.intervaloRandom(),
        tipoVehiculo = tiposDeVehiculo.anyOne()
    ))
}
method intervaloRandom() = 300.randomUpTo(900).truncate(0)

}	