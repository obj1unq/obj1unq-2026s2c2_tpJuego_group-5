import wollok.game.*
import direccion.*
import vehiculo.*

class Carril {
    const fila
    const property direccion
    const tiempoDeEspera
    const generadorDeVehiculos 

    method fila() = fila
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

class Generador {
    const direcciones = [derecha, izquierda]
    const carriles = []          // ahora arranca vacía: acá van sólo los Carril

    method filasDisponibles()
    method tiempoDeEspera()
    method tipoDeFabrica()

    method generar(cantidad) {
        self.validarCantidad(cantidad)
        carriles.clear()         // por si el nivel se juega más de una vez
        cantidad.times({ numero => self.procesoDeGenerar(numero) })
        carriles.forEach({ carril => carril.iniciarViaje() })
    }
    method validarCantidad(cantidad) {
        if (cantidad > self.filasDisponibles().size()) {
            self.error("la cantidad de carriles es mayor a la de filas disponibles")
        }
    }

    method procesoDeGenerar(indice){
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
object carrilesDeVehiculo inherits Generador{
    const filasDisponibles = [1, 2, 3, 4]
    const tiempoDeEspera = 3000 // 3 segundos

    override method filasDisponibles() = filasDisponibles
    override method tiempoDeEspera() = tiempoDeEspera
    override method tipoDeFabrica() = fabricaDeVehiculos
}

object carrilesDeAuto inherits Generador{
    const filasDisponibles = [1, 2]
    const tiempoDeEspera = 2000 // 2 segundos

    override method filasDisponibles() = filasDisponibles
    override method tiempoDeEspera() = tiempoDeEspera
    override method tipoDeFabrica() = fabricaDeAutos
}

object carrilesDeMoto inherits Generador{
    const filasDisponibles = [1, 2, 3]
    const tiempoDeEspera = 1000 // 1 segundos

    override method filasDisponibles() = filasDisponibles
    override method tiempoDeEspera() = tiempoDeEspera
    override method tipoDeFabrica() = fabricaDeMotos
}

object carrilesDeColectivo inherits Generador{
    const filasDisponibles = [ 2, 3, 4]
    const tiempoDeEspera = 3000 // 3 segundos

    override method filasDisponibles() = filasDisponibles
    override method tiempoDeEspera() = tiempoDeEspera
    override method tipoDeFabrica() = fabricaDeColectivos
}

object carrilesDeCamion inherits Generador{
    const filasDisponibles = [3, 4]
    const tiempoDeEspera = 4000 // 4 segundos

    override method filasDisponibles() = filasDisponibles
    override method tiempoDeEspera() = tiempoDeEspera
    override method tipoDeFabrica() = fabricaDeCamiones
}
object carrilesDeAutosYCamiones inherits Generador {
    const filasDisponibles = [1, 2, 3, 4]
    const tiempoDeEspera = 3000 // 3 segundos

    override method filasDisponibles() = filasDisponibles
    override method tiempoDeEspera() = tiempoDeEspera
    override method tipoDeFabrica() = fabricaDeAutosYCamiones
}

object fabricaDeAutosYCamiones {
    const fabricas = [fabricaDeAutos, fabricaDeCamiones]

    method nuevoVehiculoPara(carril) = fabricas.anyOne().nuevoVehiculoPara(carril)
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