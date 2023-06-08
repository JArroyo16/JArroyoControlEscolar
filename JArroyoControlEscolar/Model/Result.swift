//
//  Result.swift
//  JArroyoControlEscolar
//
//  Created by MacBookMBP1 on 06/06/23.
//

import Foundation

struct Result<T : Codable> : Codable{
    var Correct : Bool
    var ErrorMessage : String?
    var Objects : [T]
    
//    init(){
//        self.Correct = false
//        self.ErrorMessage = ""
//        self.Objects = []
//    }
}
