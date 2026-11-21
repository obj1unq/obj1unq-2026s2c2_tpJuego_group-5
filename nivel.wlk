import wollok.game.*
import videojuegoGRUPO5.*
import direccion.*
import estado.*
import fondos.*
import carril.*
import juego.*
import lluvia.*

object menuPrincipal inherits Presentacion {
    override method fondo() = fondoMenu
    override method siguienteEtapa() = presentacionNivel1
}

object presentacionNivel1 inherits Presentacion {
    override method fondo() = fondoDescriptivoNivel1
    override method siguienteEtapa() = nivel1
}

object nivel1 inherits Nivel {
    override method fondo() = fondoNivel1
    override method generadorDeCarriles() = new Generador(
        filasDisponibles = [1, 2, 3, 4],
        tiempoDeEspera = 3000,
        tipoDeFabrica = new FabricaMixta(fabricas = [fabricaDeAutos, fabricaDeCamiones])        // la fabrica solo es de autos y camiones
    )
    override method cantidadDeCarriles() = 4
    override method siguienteEtapa() = presentacionNivel2
}

object presentacionNivel2 inherits Presentacion {
    override method fondo() = fondoDescriptivoNivel2                                    //esta es la imagen en el Agora
    override method siguienteEtapa() = nivel2
}

object nivel2 inherits Nivel {
    override method fondo() = fondoNivel2
    override method generadorDeCarriles() = new Generador(
        filasDisponibles = [ 2, 3, 3],
        tiempoDeEspera = 1000,
        tipoDeFabrica = new FabricaMixta(fabricas = [fabricaDeAutos, fabricaDeCamiones, fabricaDeMotos])        //la fabrica es de motos, autos y camiones
    )
    override method cantidadDeCarriles() = 3
    override method ambiente() { lluvia.iniciar() }                                                             // <- esta línea hace que llueva en el nivel 2
    override method siguienteEtapa() = presentacionNivel3
}

object presentacionNivel3 inherits Presentacion {
    override method fondo() = fondoDescriptivoNivel1
    override method siguienteEtapa() = nivel3
}

object nivel3 inherits Nivel {
    override method fondo() = fondoNivel3
    override method generadorDeCarriles() = new Generador(
        filasDisponibles = [2, 3, 4, 5],
        tiempoDeEspera = 3000,
        tipoDeFabrica = new FabricaMixta(fabricas = [fabricaDeAutos, fabricaDeCamiones, fabricaDeMotos, fabricaDeColectivos])      //la fabrica es de motos, autos, camiones y colectivos 
    )
    override method cantidadDeCarriles() = 4
    override method siguienteEtapa() = menuPrincipal
}
