import wollok.game.*
import videojuegoGRUPO5.*
import direccion.*
import estado.*
import fondos.*
import carril.*
import juego.*


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
    override method generadorDeCarriles() = carrilesDeAutosYCamiones                    //esto hace que solo se vean autos y camiones
    override method cantidadDeCarriles() = 4                                            //volvemos a 4 carriles
    override method siguienteEtapa() = presentacionNivel2
}

object presentacionNivel2 inherits Presentacion {
    override method fondo() = fondoDescriptivoNivel2                                    //esta es la imagen en el Agora
    override method siguienteEtapa() = nivel2
}

object nivel2 inherits Nivel {
    override method fondo() = fondoNivel2
    override method generadorDeCarriles() = carrilesDeMoto
    override method cantidadDeCarriles() = 3
    override method siguienteEtapa() = presentacionNivel3
}

object presentacionNivel3 inherits Presentacion {
    override method fondo() = fondoDescriptivoNivel1
    override method siguienteEtapa() = nivel3
}

object nivel3 inherits Nivel {
    override method fondo() = fondoNivel3
    override method generadorDeCarriles() = carrilesDeColectivo
    override method cantidadDeCarriles() = 2
    override method siguienteEtapa() = menuPrincipal
}
