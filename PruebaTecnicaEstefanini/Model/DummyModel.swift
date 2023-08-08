//
//  Model.swift
//  PruebaTecnicaEstefanini
//
//  Created by danielmateos14 on 25/07/23.
//

import Foundation

struct DummyModel: Codable {
    let emisor: String
    let correoEmisor: String
    let asunto: String
    let mensaje: String
    let hora: String
    let leido: Bool
    let destacado: Bool
    let spam: Bool
}
