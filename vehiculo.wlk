class Vehiculo {
    const property carril
    var property intervaloEnMs = 0
	var property position = carril.posicionInicial()
    const tick = game.tick(self.intervaloEnMs(), { self.avanzar() }, false)

    method image() 

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
		alumno.serAtropelladoPorVehiculo()
	}
}

class Auto inherits Vehiculo{
	const tipo = auto

	override method intervaloEnMs() = 300

	override method image() = tipo.nombre() + "_" + carril.direccion().nombre() +".png"
}

class Moto inherits Vehiculo{
const tipo = moto

override method intervaloEnMs() = 100
override method image() = tipo.nombre() + "_" + carril.direccion().nombre() +".png"
}

class Camion inherits Vehiculo{
	const tipo = camion
	override method intervaloEnMs() = 800
	override method image() = tipo.nombre() + "_" + carril.direccion().nombre() +".png"
}

class Colectivo inherits Vehiculo{
	const tipo = colectivo

	override method intervaloEnMs() = 500

	override method image() = tipo.nombre() + "_" + carril.direccion().nombre() +".png"
}


object auto {
    method nombre() = "auto"
	method crearVehiculo(carril) = new Auto(carril = carril)
}

object camion {
    method nombre() = "camion"
	method crearVehiculo(carril) = new Camion(carril=carril)
}

object moto {
	method nombre() = "moto"

	method crearVehiculo(carril) = new Moto(carril = carril)
}

object colectivo {
	method nombre() = "colectivo"

	method crearVehiculo(carril) = new Colectivo(carril = carril)
}
