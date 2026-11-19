import wollok.game.*
import estado.*
import juego.*


// =====================================================================
//  ALUMNO: PERSONAJE PRINCIPAL
// =====================================================================


object alumno {
    var property position = game.at(4,0)
    var estado = vivo
	
    method estado(_estado)  {estado =  _estado}  
    method image() = "estudiante_" + estado.cuantasVidasHay() + "vida.png"
	
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
	
    method derrotado(){estado = muerto} 

    method reinicio() {
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

    //interaccion choco con el objeto fondo que esta en (0,0):
    method interaccionConObjetoEstetico(){}
    //interacciones futuras:

}


// =====================================================================
//  META: FINAL DEL JUEGO
// =====================================================================
object unq_Puerta {
    var property position = game.at(5,6) 
	    
	method interaccion(visitante) {
        game.say(visitante, "¡Llegué a la UNQ!")
        gestorDeEtapas.avanzar()
    }
}