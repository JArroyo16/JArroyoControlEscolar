//
//  MateriaViewModel.swift
//  JArroyoControlEscolar
//
//  Created by MacBookMBP1 on 06/06/23.
//

import Foundation

class MateriaViewModel{
 
    static func GetAll(reponse : @escaping(Result<Materia>?, Error?) -> Void ){
        let url = URL(string: "http://192.168.0.52/api/Materia")!
        URLSession.shared.dataTask(with: url){ data, response, error in
            
            if let dataSource = data {
                let decoder = JSONDecoder()
                let result = try! decoder.decode(Result<Materia>.self, from: dataSource)
                reponse(result,nil)
            }
            if let errorSource = error {
                reponse(nil, errorSource)
            }
        }.resume()
    }
    
}
