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

	//mensaje de colisión contra el alumno
	method interaccion(alumno) {
        alumno.paraDespues()
    }
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