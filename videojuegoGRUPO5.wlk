import wollok.game.*
import estado.*
import juego.*


// =====================================================================
//  ALUMNO: PERSONAJE PRINCIPAL
// =====================================================================


object alumno {
    var property position = game.at(4,0)
    var estado = vivo
    var spawn = game.at(4,0)
	
    method estado(_estado)  {estado =  _estado}  
    method image() = "estudiante_" + estado.cuantasVidasHay() + "vida.png"
	
    method descontarVida(){
		estado.vidaActual()
	}

	method anunciarDerrota() {
        game.say(self, "me morí") 
        self.derrotado()
	}

     method empezarEn(posicion) {
        spawn = posicion
        self.volverAlInicio()
    }


	method volverAlInicio() {position = spawn}


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
    var llegando = false

    method interaccion(visitante) {
        if (!llegando) {
            llegando = true
            game.say(visitante, "¡Llegué a la UNQ!")
            game.schedule(2500, { => llegando = false                           //aca espera un poco, para que se vea que el personaje dice que llego a la unq
                gestorDeEtapas.avanzar()
            })
        }
    }
}