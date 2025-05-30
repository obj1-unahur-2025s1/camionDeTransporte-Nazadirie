
/*Knight Rider: pesa 500 kilos y su nivel de peligrosidad es 10.
Bumblebee: pesa 800 kilos y su nivel de peligrosidad es 15 si está transformado en auto o 30 si está como robot.
Paquete de ladrillos: cada ladrillo pesa 2 kilos, la cantidad de ladrillos que tiene puede variar. La peligrosidad es 2.
Arena a granel: el peso es variable, la peligrosidad es 1.
Batería antiaérea : el peso es 300 kilos si está con los misiles o 200 en otro caso. En cuanto a la peligrosidad es 100 si está con los misiles y 0
en otro caso.
Contenedor portuario: un contenedor puede tener otras cosas adentro. El peso es 100 + la suma de todas las cosas que estén adentro. Es tan peligroso 
como el objeto más peligroso que contiene. Si está vacío, su peligrosidad es 0.
Residuos radioactivos: el peso es variable y su peligrosidad es 200.
Embalaje de seguridad: es una cobertura que envuelve a cualquier otra cosa. El peso es el peso de la cosa que tenga adentro. El nivel de peligrosidad
es la mitad del nivel de peligrosidad de lo que envuelve*/
object knightRider {

    method peso()= 500
    method peligrosidad()= 10
}

object bumblebee {
    var estaTransformadoAuto = false

    method peso()= 800
    method peligrosidad(){
        if(estaTransformadoAuto){
            return 15
        }else 
            return 30
    }
    method transformarseEnRobot(){
        estaTransformadoAuto = false
    }
    method transformarseEnAuto() {
        estaTransformadoAuto = true
    }
}

object paqueteLadrillos {
    var cantidadDeLadrillos = 0

    method ladrilloPeso() = 2
    method peligrosidad() = 2
    method peso() {
        return cantidadDeLadrillos* self.ladrilloPeso()
    }
    method cantidadLadrillos(unaCantidad){
        cantidadDeLadrillos = unaCantidad
    }

}

object arenaAGranel {
    var property peso = 4

    method peligrosidad() = 1


}
/*Batería antiaérea : el peso es 300 kilos si está con los misiles o 200 en otro caso. En cuanto a la peligrosidad es 100 si está con los misiles y 0
en otro caso.*/
object bateriaAntiAerea {
    var estaCargada = true

    method peso(){
        if(estaCargada){
            return 300
        } else 
            return 200
    }
    method peligrosidad() {
        if(estaCargada){
            return 100
        }else
            return 0
    }
    method descargarBateria() {
        estaCargada = false
    }
    method cargarBateria() {
        estaCargada = true
    }

}

object contenedorPortuario {
    var contenido = []

    method agregar(unaCosa){
        contenido.add(unaCosa)
    }
    method quitar(unaCosa) {
        contenido.remove(unaCosa)
    }
    method agregarVariasCosas(listaDeCosas){
        contenido.addAll(listaDeCosas)
    }
    method peso() {
        return contenido.sum({c => c.peso()}) + 100
    }
    method peligrosidad() {
        if(!contenido.isEmpty()){
            return contenido.max({c=> c.peligrosidad()}).peligrosidad()
            }
            else 
                return 0
    }
}

object residuosRadioActivos {
    var property peso = 30

    method peligrosidad() = 200
}

object embalajeDeSeguridad{
    var property loDeAdentro = residuosRadioActivos

    method peso() = loDeAdentro.peso()
    method peligrosidad() {
        return loDeAdentro.peligrosidad() / 2
    }
}

