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
    var property objetivo = unq_Puerta  
	var tieneParaguas = false                               //se agrego para configurar el paraguas
    var paraguasAbierto = false                             //se agrego para configurar el paraguas


    method estado(_estado)  {estado =  _estado}  
    method image() = "estudiante" + self.sufijoParaguas() + "_" + estado.cuantasVidasHay() + "vida.png"

    // no existe estudianteParaguas_0vida.png, asi que sin vidas se muestra el personaje normal
    method sufijoParaguas() = if (self.paraguasAbierto()) "Paraguas" else ""

    // ---- paraguas ----
    method tieneParaguas() = tieneParaguas
    method paraguasAbierto() = paraguasAbierto && estado.cuantasVidasHay() > 0   // la lluvia puede consultar esto
    method conseguirParaguas() { tieneParaguas = true }
    method sinParaguas() {
        tieneParaguas = false
        paraguasAbierto = false
    }
    method alternarParaguas() {
        if (tieneParaguas) { paraguasAbierto = !paraguasAbierto }                               //hasta aca necesita para implementar el paraguas
    }
    
    
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

    method spawn(_spawn) {spawn = _spawn} 

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

    method agregarObjetivo(){}
    method interaccion(macaquito) {
        if (macaquito.objetivo() == self && !llegando) {
            llegando = true
            game.say(macaquito, "¡Llegué a la UNQ!")
            game.schedule(2500, { => llegando = false                           //aca espera un poco, para que se vea que el personaje dice que llego a la unq
                gestorDeEtapas.avanzar()
            })
        }
    }
}

object apuntes{
    var property position = game.at(2,0)
    method image() = "paraguas-apuntes.png"                                     //modigique la imagen
    method agregarObjetivo() { game.addVisual(self) }
     method interaccion(macaquito) { 
        game.removeVisual(self)
        macaquito.conseguirParaguas()                                           //cambia el estado 
        game.say(macaquito, "tengo los apuntes y el paraguas (P), ahora puedo ir a rendir")
        macaquito.objetivo(unq_Puerta)
        macaquito.spawn(macaquito.position())
        }
}