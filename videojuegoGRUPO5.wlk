import wollok.game.*
import vida.*
import vehiculo.*
import direccion.*

// =====================================================================
//  ALUMNO: PERSONAJE PRINCIPAL
// =====================================================================
object alumno {
    const vidasRestantes = salud
    var property position = game.at(4,0)
	
	method descontarVida(){
		vidasRestantes.perderUnaVida()
	}
   
	method serAtropelladoPorVehiculo() {
		if (!self.estaMuerto()) {
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
//  CARRILES 
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
		const vehiculoDeViaje = self.agregarVehiculoNuevo()
        game.addVisual(vehiculoDeViaje)
        vehiculoDeViaje.empezarARecorrer()
    }
	
	method retirarVehiculo(vehiculoDeViaje){
		game.removeVisual(vehiculoDeViaje)
		game.schedule(tiempoDeEspera, { => self.iniciarViaje() })
	}
	
	method agregarVehiculoNuevo(){
		const vehiculoAGenerar = tiposDeVehiculo.anyOne()
		return vehiculoAGenerar.crearVehiculo(self)

	}
	
	method intervaloEnMsAleatorio() = intervaloMinimo.randomUpTo(intervaloMaximo).truncate(0)
}


object generadorDeCarriles {
    const direcciones = [derecha, izquierda]
    const tiposDeVehiculo = [auto, camion, moto, colectivo]
    const filasLibres = [1, 2, 3, 4  ]
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

// =====================================================================
//  META: FINAL DEL JUEGO
// =====================================================================
object unq_Puerta {
    var property position = game.at(4,7) 
	    
	method interaccion(alumno) {
        game.say(alumno, "¡Llegué a la UNQ!")
        // acá va lo que querés que pase: ganar el juego, pasar de nivel, etc.
        // game.stop()
}	
}