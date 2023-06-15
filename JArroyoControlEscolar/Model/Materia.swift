//
//  Materia.swift
//  JArroyoControlEscolar
//
//  Created by MacBookMBP1 on 06/06/23.
//

import Foundation

struct Materia : Codable{
    var IdMateria : Int
    var Nombre : String
    var Costo : Double
    
    init(){
        self.IdMateria = 0
        self.Nombre = ""
        self.Costo = 0.0
    }
}
