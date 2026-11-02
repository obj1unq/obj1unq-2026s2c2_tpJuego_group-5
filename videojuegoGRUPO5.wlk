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
		position = direccion.siguienteParaAlumno(self)
	  
	}
	method image() = "estudiante_" + vidasRestantes.cuantasVidasHay() + "vida.png"
	
	//interacciones con colisiones:
	method interactuar(algo){
		algo.interaccion(self)
    }
    //interaccion con vehiculo: serAtropelladoPorVehiculo

    //interaccion con vida:
    method paraDespues(){}
}

// =====================================================================
//  CARRILES 
// =====================================================================
class Carril {
    const fila
    const property direccion
    const tiempoDeEspera
    const generadorDeVehiculos = fabricaDeVehiculos

    method posicionInicial() = game.at(direccion.columnaInicial(), fila)

    method iniciarViaje() {
        const vehiculo = generadorDeVehiculos.nuevoVehiculoPara(self)
        game.addVisual(vehiculo)
        vehiculo.empezarARecorrer()
    }

    method retirarVehiculoYComenzarNuevoViaje(vehiculo) {
        game.removeVisual(vehiculo)
        game.schedule(tiempoDeEspera, { => self.iniciarViaje() })
    }
}

object generadorDeCarriles {
    const direcciones = [derecha, izquierda]
    const filasDisponibles = [1, 2, 3, 4]
    const tiempoDeEspera = 3000 // 3 segundos
    const carriles = []

    method generar(cantidad) {
        self.validarCantidad(cantidad)
        cantidad.times({ n => self.procesoDeGenerar()})
        carriles.forEach({ carril => carril.iniciarViaje() })
    }

    method validarCantidad(cantidad) {
        if (cantidad > filasDisponibles.size()) {
            self.error("la cantidad de carriles es mayor a la de filas disponibles")
        }
    }


    method procesoDeGenerar(){
        const fila = filasDisponibles.first()
        carriles.add(self.nuevoCarrilEnFila(fila))
        filasDisponibles.remove(fila)
    }
    method nuevoCarrilEnFila(fila) {
        return new Carril(
            fila = fila,
            direccion = direcciones.anyOne(),
            tiempoDeEspera = tiempoDeEspera
        )
    }
}

object fabricaDeVehiculos {
    const fabricas = [fabricaDeAutos, fabricaDeMotos, fabricaDeColectivos, fabricaDeCamiones]

    method nuevoVehiculoPara(carril) = fabricas.anyOne().nuevoVehiculoPara(carril)
}
object fabricaDeAutos {
    method nuevoVehiculoPara(carril) = new Auto(carril = carril)
}
object fabricaDeMotos {
    method nuevoVehiculoPara(carril) = new Moto(carril = carril)
}
object fabricaDeColectivos {
    method nuevoVehiculoPara(carril) = new Colectivo(carril = carril)
}
object fabricaDeCamiones {
    method nuevoVehiculoPara(carril) = new Camion(carril = carril)
}
// =====================================================================
//  META: FINAL DEL JUEGO
// =====================================================================
object unq_Puerta {
    var property position = game.at(5,6) 
	    
	method interaccion(alumno) {
        game.say(alumno, "¡Llegué a la UNQ!")
        // acá va lo que querés que pase: ganar el juego, pasar de nivel, etc.
        // game.stop()
}	
}