/*Agregamos al dominio la información sobre la cantidad total de bultos que el camión tiene cargados. Cada cosa puede ocupar en el camión 1 o más bultos, y depende de cada cosa:
KnightRider, arena a granel y residuos radioactivos ocupan 1 bulto cada uno en el camión.
Bumblebee y embalaje de seguridad ocupan 2 bultos cada uno.
Al cargar una cosa en el camión, esta pueda sufrir cambios. Estos cambios tienen que ocurrir automáticamente cuando, por ejemplo, se ejecuta camion.cargar(arenaGranel). Cómo debería reaccionar cada cosa:
CONSECUENCIA DE LA CARGA:
KnightRider: no hace nada;
Bumblebee: cambia a robot;
paquete de ladrillos: agrega 12 ladrillos;
arena a granel: pierde 10 kilos;
batería antiaérea: carga misiles;
contenedor portuario: hace que reaccione cada una de las cosas que tiene adentro;
residuos radioactivos: agrega 15 kilos;
embalaje de seguridad: nada.*/


object knightRider {

    method peso()= 500
    method peligrosidad()= 10
    method bultos()= 1
    method consecuenciaDeLaCarga(){}
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
    method bultos () = 2
    method consecuenciaDeLaCarga(){
        self.transformarseEnRobot()}
}
/*Paquete de ladrillos depende de la cantidad de ladrilos:
hasta 100 ladrillos ocupa 1 bulto.
Entre 101 y 300, 2 bultos.
301 o más, ocupa 3 bultos. */

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
    method bultos(){
        if(cantidadDeLadrillos>=100){
            1
        } else if (cantidadDeLadrillos.between(101, 300)){
            2
        } else 3
    }
    method consecuenciaDeLaCarga(){
        cantidadDeLadrillos += 12
    }

}

object arenaAGranel {
    var property peso = 4

    method peligrosidad() = 1
    method bultos() = 1
    method consecuenciaDeLaCarga(){
        peso -= 10
    }


}
/*Batería antiaérea : el peso es 300 kilos si está con los misiles o 200 en otro caso. En cuanto a la peligrosidad es 100 si está con los misiles y 0
en otro caso.
Batería antiaérea: ocupa 1 bulto si no tiene los misiles y 2 si los tiene cargados.
Contenedor portuario: 1 + los bultos de las cosas que tiene adentro.*/
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
    method bultos(){
        if(!estaCargada){
            1
        } else 
            2
    }
    method consecuenciaDeLaCarga(){
        self.cargarBateria()
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
    //method bultos()= 1 + contenido.bultos()
    method bultos() { 1+ contenido.sum({c=> c.bultos()})}
    method consencuenciaDeLaCarga() {contenido.forEarch({c=>c.consencuenciaDeLaCarga()})}
}

object residuosRadioActivos {
    var property peso = 30

    method peligrosidad() = 200
    method bultos() = 1
    method consecuenciaDeLaCarga(){
        peso += 15
    }
}

object embalajeDeSeguridad{
    var property loDeAdentro = residuosRadioActivos

    method peso() = loDeAdentro.peso()
    method peligrosidad() {
        return loDeAdentro.peligrosidad() / 2
    }
    method bultos () = 2
    method consecuenciaDeLaCarga(){}

}
