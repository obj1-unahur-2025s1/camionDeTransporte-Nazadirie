

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
    method estaExcedidoDePeso()= self.pesoTotal() > 2500 

    method puedeCircularEnRuta(unNivel){
        return  not self.estaExcedidoDePeso() and self.cosasQueSuperanUnNivelDePeligrosidad(unNivel).isEmpty()
    }

    method tieneAlgoQuePesaEntre(min,max){
        return carga.any({c=> c.peso().between(min, max)})
    }

    method cargaMasPesada() = carga.max({c => c.peso()})


}
