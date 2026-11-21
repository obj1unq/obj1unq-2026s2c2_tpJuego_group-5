  import wollok.game.*
import direccion.*
import vehiculo.*

class Carril {
    const fila
    const property direccion
    const tiempoDeEspera
    const generadorDeVehiculos

    method fila() = fila
    method posicionInicial() = game.at(direccion.filaInicial(), fila)

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

class Generador {
    const filasDisponibles
    const tiempoDeEspera
    const tipoDeFabrica
    const direcciones = [derecha, izquierda]
    const carriles = []

    method filasDisponibles() = filasDisponibles
    method tiempoDeEspera() = tiempoDeEspera
    method tipoDeFabrica() = tipoDeFabrica

    method generar(cantidad) {
        self.validarCantidad(cantidad)
        cantidad.times({ numero => self.procesoDeGenerar(numero) })
        carriles.forEach({ carril => carril.iniciarViaje() })
    }

    method validarCantidad(cantidad) {
        if (cantidad > self.filasDisponibles().size()) {
            self.error("la cantidad de carriles es mayor a la de filas disponibles")
        }
    }

    method procesoDeGenerar(indice) {
        carriles.add(self.nuevoCarrilEnFila(self.filasDisponibles().get(indice - 1)))
    }

    method nuevoCarrilEnFila(fila) {
        return new Carril(
            fila = fila,
            direccion = direcciones.anyOne(),
            tiempoDeEspera = self.tiempoDeEspera(),
            generadorDeVehiculos = self.tipoDeFabrica()
        )
    }
}

class FabricaMixta {                                                                                    //esta fabrica crea autos en el carril, pero se pueden sumar y restar de a uno
    const fabricas

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