//
//  Alumno.swift
//  JArroyoControlEscolar
//
//  Created by MacBookMBP1 on 06/06/23.
//

import Foundation

struct Alumno : Codable{
    var IdAlumno : Int
    var Nombre : String
    var ApellidoPaterno : String
    var ApellidoMaterno : String
    var FechaNacimiento : String
    var Genero : String
    var Telefono : String
    
    init(){
        self.IdAlumno = 0
        self.Nombre = ""
        self.ApellidoPaterno = ""
        self.ApellidoMaterno = ""
        self.FechaNacimiento = ""
        self.Genero = ""
        self.Telefono = ""
    }
}
