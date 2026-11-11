import wollok.game.*
import vehiculo.*
import direccion.*
import estado.*

// =====================================================================
//  ALUMNO: PERSONAJE PRINCIPAL
// =====================================================================
object alumno {
    var property position = game.at(4,0)
    var estado = vivo
	
    method image() = "estudiante_" + estado.cuantasVidasHay() + "vida.png"
	
    method estaVivo() = estado.estaVivo()

    method descontarVida(){
		estado.vidaActual()
	}

	method anunciarDerrota() {
        game.say(self, "me morí") 
        self.derrotado()
	}

	method volverAlInicio() { position = game.at(4,0) }

	method mover(direccion) {
        estado.mover(self, direccion)
    }
	
    method derrotado(){estado = estado.opuesto()} 

    method reinicio() {
        if (!self.estaVivo()){
            estado = estado.opuesto()
        }
        estado.reiniciar()
        self.volverAlInicio()
    }
	//interacciones con colisiones:
	method interactuar(algo){
		algo.interaccion(self)
    }
    //interaccion con vehiculo: serAtropelladoPorVehiculo
    method serAtropelladoPorVehiculo(vidasPerdidas) {
		if (estado.cuantasVidasHay() - vidasPerdidas <= 0) {
			vidasPerdidas.times({ n => self.descontarVida()})
			self.volverAlInicio()
            self.anunciarDerrota()
		} else {
            vidasPerdidas.times({ n => self.descontarVida()})
			self.volverAlInicio()
        }
	}
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