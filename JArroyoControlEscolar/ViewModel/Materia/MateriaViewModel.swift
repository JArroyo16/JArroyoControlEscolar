//
//  GetAll.swift
//  JArroyoControlEscolar
//
//  Created by MacBookMBP1 on 06/06/23.
//

import Foundation

class MateriaViewModel{
 
    static func Add(_ materia : Materia, reponse : @escaping(Result<Materia>?, Error?) -> Void ){
        let urlstring = "http://192.168.0.52/api/Materia"
        let url = URL(string: urlstring)!
        
        var request =  URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try!  JSONEncoder().encode(materia)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let dataSource = data{
                let decoder = JSONDecoder()
                let jsonString = String(data: dataSource, encoding: String.Encoding.utf8)
                let result = try! decoder.decode(Result<Materia>.self, from: dataSource)
            }
            if let errorSource = error {
                print("Error al insertar")
            }
        }.resume()
    }
    
    static func Update(_ materia : Materia, reponse : @escaping(Result<Materia>?, Error?) -> Void ){
        let urlstring = "http://192.168.0.52/api/Materia/\(materia.IdMateria)"
        let url = URL(string: urlstring)!
        
        var request =  URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = try!  JSONEncoder().encode(materia)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let dataSource = data{
                let decoder = JSONDecoder()
                let jsonString = String(data: dataSource, encoding: String.Encoding.utf8)
                let result = try! decoder.decode(Result<Materia>.self, from: dataSource)
            }
            if let errorSource = error {
                print("Error al insertar")
            }
        }.resume()
    }
    
    static func Delete(IdMateria : Int, reponse : @escaping(Result<Materia>?, Error?) -> Void ){
        let urlstring = "http://192.168.0.52/api/Materia/\(IdMateria)"
        let url = URL(string: urlstring)!
        
        var request =  URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let dataSource = data{
                let decoder = JSONDecoder()
                let jsonString = String(data: dataSource, encoding: String.Encoding.utf8)
                let result = try! decoder.decode(Result<Materia>.self, from: dataSource)
            }
            if let errorSource = error {
                print("Error al insertar")
            }
        }.resume()
    }
    
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
    
    static func GetById(IdMateria : Int, reponse : @escaping(Result<Materia>?, Error?) -> Void ){
        let url = URL(string: "http://192.168.0.52/api/Materia/\(IdMateria)")!
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
