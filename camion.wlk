/*Se pide que se le pueda cargar y descargar cosas (de 1 a vez) y también cual es el peso total del camión, incluyendo su tara que es de 1000 kg.
También se necesita conocer si los pesos de todas las cosas cargadas en el camión son números pares.
Debemos poder consultar si hay alguna cosa que pesa un determinado valor.
Para un mejor control del tipo de peligro que puede representar la carga, se debe poder obtener la primer cosa cargada que tenga un determinado nivel
de peligrosidad
Obtener todas las cosas que superan un determinado nivel de peligrosidad.
Para facilitar los controles, también nos piden que se pueda consultar la lista de cosas que superan el nivel de peligrosidad de una cosa dada.
Conocer si el camión está excedido del peso máximo permitido,que es de 2500 kg.
Saber si el camión puede circular en ruta. Eso depende de que no exceda el peso máximo permitido y ninguno de los objetos cargados supere un nivel máximo
de peligrosidad que depende del viaje, por eso para este caso el valor del nivel se pasará como argumento.*/
object camion {
    var carga = []

    method cargar(unaCosa) {
        carga.add(unaCosa)
    }
    method descargar(unaCosa) { carga.remove(unaCosa)}
    method pesoTotal() {
        return carga.sum({c=> c.peso()}) + 1000
    }

    method laCargaTienePesoPar() {
        return carga.all({c=> c.peso().even()})
    }

    method enlaCargaAlgoPesa(unPeso) {
        return carga.any({c=> c.peso()== unPeso})
    }

    method primerCosaConPeligrosidad(unNivel){
        return carga.find({c=> c.peligrosidad()== unNivel}) 
    }
    method cosasQueSuperanUnNivelDePeligrosidad(unNivel){
        return carga.filter({c=> (c.peligrosidad() > unNivel)}) 
    }

    method cosasQueSuperanElNivelDePeligrosidadDeUnaCosa(unaCosa){
        return carga.filter({c=> (c.peligrosidad() > unaCosa.peligrosidad())}) 
    }
    /*method cosasMasPeligrosasQue(unaCosa){
        return self.cosasQueSuperanUnNivelDePeligrosidad(unaCosa.peligrosidad())
    } */

    method estaExcedidoDePeso()= self.pesoTotal() > 2500 

    method puedeCircularEnRuta(unNivel){
        return  not self.estaExcedidoDePeso() and self.cosasQueSuperanUnNivelDePeligrosidad(unNivel).isEmpty()
    }

    method tieneAlgoQuePesaEntre(min,max){
        return carga.any({c=> c.peso().between(min, max)})
    }

    method cargaMasPesada() = carga.max({c => c.peso()})


}