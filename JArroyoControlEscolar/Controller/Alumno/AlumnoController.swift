//
//  AlumnoController.swift
//  JArroyoControlEscolar
//
//  Created by MacBookMBP1 on 06/06/23.
//

import UIKit

class AlumnoController: UITableViewController {
    
        var alumnos : [Alumno] = []
        var IdAlumno = 0
    //var result = Result<Alumno>()
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "AlumnoCell", bundle: .main), forCellReuseIdentifier: "AlumnoCell")
        updateUI()
        
        var alumno = Alumno()
        alumno.Nombre = "Prueba"
        alumno.ApellidoPaterno = "Tets"
        alumno.ApellidoMaterno = "POST"
        alumno.FechaNacimiento = "01-01-2000"
        alumno.Genero = "M"
        alumno.Telefono = "123456789"
        AlumnoViewModel.Add(alumno)
        
        
//        AlumnoViewModel.GetAll{ result, error in
//            if let resultSource = result{
//                print(resultSource)
//            }
//        }
    }
    
    func updateUI(){
        var resultados = AlumnoViewModel.GetAll { result, error in
        if let resultSource = result{
            for objalumno in resultSource.Objects{
                let alumno = objalumno
                self.alumnos.append(alumno)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return alumnos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlumnoCell", for: indexPath) as! AlumnoCell
        //cell.delegate = self
        
        cell.lblNombre.text = "Nombre: \(alumnos[indexPath.row].Nombre) " + "\(alumnos[indexPath.row].ApellidoPaterno) " + "\(alumnos[indexPath.row].ApellidoMaterno)"
        cell.lblFecha.text = "Fecha de nacimiento: \(alumnos[indexPath.row].FechaNacimiento)"
        cell.lblGenero.text = "Sexo: \(alumnos[indexPath.row].Genero)"
        cell.lblTelefono.text = "Telefono: \(alumnos[indexPath.row].Telefono)"
        
        return cell
    }

   
}
