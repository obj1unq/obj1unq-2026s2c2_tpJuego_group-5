import wollok.game.*

object cronometro {
    const property position = game.at(1, 9) //Ubicacion en el mapa
    var tiempoRestante = 300 //Indica el timepo restante que durara en segundos. 5 minutos = 300 segundos

    method text() {
        const segs = self.segundos()
        return self.minutos().stringValue() + ":" + self.segundosFormateados(segs)
    }

    method minutos() = tiempoRestante.div(60)
    method segundosFormateados(segundo) = if (segundo < 10) {"0" + segundo.stringValue() }else {segundo.stringValue()}
    method segundos() = tiempoRestante.rem(60)

    method textColor() = "FFFFFFFF" // Color del texto. Por el momento Texto en blanco 

    method iniciar() {
        game.addVisual(self)
        // Evento periódico de 1 segundo (1000 ms)
        game.onTick(1000, "descontarTiempo", { => self.perderUnSegundo() })
    }

    method perderUnSegundo() {
        if (tiempoRestante > 0) {
            tiempoRestante -= 1
        } else {
            self.tiempoAgotado()
        }
    }

    method tiempoAgotado() {
        game.removeTickEvent("descontarTiempo") //Clave para eliminar el tick de iniciar()
        game.say(self, "¡Tiempo agotado!")
        // Aquí se podria agregar algo mas interesante
    }
}