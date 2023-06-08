//
//  GetAll.swift
//  JArroyoControlEscolar
//
//  Created by MacBookMBP1 on 06/06/23.
//

import Foundation

class AlumnoViewModel{
 
    static func Add(_ alumno : Alumno){
        let urlstring = "http://192.168.0.52/api/Alumno"
        let url = URL(string: urlstring)!
        
        var request =  URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try!  JSONEncoder().encode(alumno)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let dataSource = data{
                let decoder = JSONDecoder()
                let jsonString = String(data: dataSource, encoding: String.Encoding.utf8)
                let result = try! decoder.decode(Result<Alumno>.self, from: dataSource)
            }
            if let errorSource = error {
                print("Error al insertar")
            }
        }.resume()
    }
    
    static func GetAll(reponse : @escaping(Result<Alumno>?, Error?) -> Void ){
        let url = URL(string: "http://192.168.0.52/api/Alumno")!
        URLSession.shared.dataTask(with: url){ data, response, error in
            
            if let dataSource = data {
                let decoder = JSONDecoder()
                let result = try! decoder.decode(Result<Alumno>.self, from: dataSource)
                reponse(result,nil)
            }
            if let errorSource = error {
                reponse(nil, errorSource)
            }
        }.resume()
    }
    
}
