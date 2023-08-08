//
//  DummyController.swift
//  PruebaTecnicaEstefanini
//
//  Created by danielmateos14 on 25/07/23.
//

import Foundation

protocol DummyProtocol{ //Protocolo para llevar el objeto a otra pantalla
    func actualizarUI(recibeObjetoCorreos: [DummyModel])
}

class DummyController {
    static let shared = DummyController() //Singleton para ejecutarlo en otra pantalla
    var delegate: DummyProtocol? //Delegado para el protocolo
    func crearUrlJsonLoca(name: String, fileExtension: String) -> URL? {
        guard let archivoJsonURL = Bundle.main.url(
            forResource: name,
            withExtension: fileExtension
        ) else {
            print("Could not locate file \(name).\(fileExtension)")
            return nil
        }
        return archivoJsonURL
    }
    
    func requestDummy(){
        if let jsonURL = crearUrlJsonLoca(name: "Dummy", fileExtension: "json") {
            guard let jsonData = try? Data(contentsOf: jsonURL) else {
                fatalError("Could not gather data from file")
            }
            
            let jsonDecoder = JSONDecoder()
            
            guard let dummy = try? jsonDecoder.decode([DummyModel].self, from: jsonData) else {
                fatalError("Could not parse data")
            }
            self.delegate?.actualizarUI(recibeObjetoCorreos: dummy)
            print(dummy)
//            print(dummy.emisor)
//            print(dummy.hora)
//            print(dummy.leido)
            print("-----")
        }
        
        
    }
}
