import videojuegoGRUPO5.*
/*=====================================================================
  VEHICULO: clase abstracta que representa un vehiculo en el juego.
  ====================================================================*/

class Vehiculo {
    const carril
    var property position = carril.posicionInicial()
    const tick = game.tick(self.intervaloEnMs(), { self.avanzar() }, false)

    method intervaloEnMs()
    method nombre()

    method image() = self.nombre() + "_" + carril.direccion().nombre() + ".png"

    method empezarARecorrer() { tick.start() }

    method avanzar() {
        if (carril.direccion().puedeAvanzar(position)) {
            position = carril.direccion().siguiente(position)
        } else {
            tick.stop()
            carril.retirarVehiculoYComenzarNuevoViaje(self)
        }
    }

    //mensaje de colisión contra el alumno
    method interaccion(atropellado) {
        atropellado.serAtropelladoPorVehiculo()
    }
}

class Auto inherits Vehiculo {
    override method intervaloEnMs() = 300
    override method nombre() = "auto"
}

class Moto inherits Vehiculo {
    override method intervaloEnMs() = 100
    override method nombre() = "moto"
}

class Camion inherits Vehiculo {
    override method intervaloEnMs() = 800
    override method nombre() = "camion"
}

class Colectivo inherits Vehiculo {
    override method intervaloEnMs() = 500
    override method nombre() = "colectivo"
}