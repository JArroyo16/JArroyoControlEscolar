//
//  AlumnoMateriaController.swift
//  JArroyoControlEscolar
//
//  Created by MacBookMBP1 on 09/06/23.
//

import UIKit

class AlumnoMateriaController: UIViewController {
    
    
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtAppelidoPaterno: UITextField!
    @IBOutlet weak var txtApellidoMaterno: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var alumnos : [Alumno] = []
    var alumnosFiltrados: [Alumno] = []
    var IdAlumno = 0
    var nombre = ""
    var appellidoP = ""
    var apellidoM = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "AlumnoCell", bundle: .main), forCellReuseIdentifier: "AlumnoCell")
        tableView.delegate = self
        tableView.dataSource = self
        alumnosFiltrados = alumnos
        updateUI()
    }
    
    func updateUI(){
        var resultados = AlumnoViewModel.GetAll { result, error in
        if let resultSource = result{
            for objalumno in resultSource.Objects!{
                let alumno = objalumno
                self.alumnos.append(alumno)
            }
            DispatchQueue.main.async {
                self.alumnosFiltrados = self.alumnos
                self.tableView.reloadData()
            }
        }
        }
    }
    @IBAction func btnBusqueda(_ sender: Any) {
        alumnosFiltrados = []
     
        //Nombre
        if txtNombre.text == "" && txtAppelidoPaterno.text == "" && txtApellidoMaterno.text == ""{
            alumnosFiltrados = alumnos
        }else{
            for alumno in alumnos{
                if alumno.Nombre!.lowercased().contains((txtNombre.text?.lowercased())!) {
                    alumnosFiltrados.append(alumno)
                }
                if alumno.ApellidoPaterno!.lowercased().contains((txtAppelidoPaterno.text?.lowercased())!){
                    alumnosFiltrados.append(alumno)
                }
                if alumno.ApellidoMaterno!.lowercased().contains((txtApellidoMaterno.text?.lowercased())!){
                    alumnosFiltrados.append(alumno)
                }
            }
        }
        self.tableView.reloadData()
        
        //apellidoPaterno
//        if txtAppelidoPaterno.text == "" {
//            alumnosFiltrados = alumnos
//        }else{
//            for alumno in alumnos{
//                if alumno.ApellidoPaterno!.lowercased().contains((txtAppelidoPaterno.text?.lowercased())!) {
//                    alumnosFiltrados.append(alumno)
//                }
//            }
//        }

//
//        //apellidoMaterno
//        if txtApellidoMaterno.text == "" {
//            alumnosFiltrados = alumnos
//        }else{
//            for alumno in alumnos{
//                if alumno.ApellidoMaterno!.lowercased().contains((txtApellidoMaterno.text?.lowercased())!) {
//                    alumnosFiltrados.append(alumno)
//                }
//            }
//        }
        
        
    }

}

extension AlumnoMateriaController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alumnosFiltrados.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlumnoCell", for: indexPath) as! AlumnoCell
        //cell.delegate = self
        cell.lblNombre.text = "\(alumnosFiltrados[indexPath.row].Nombre!) " + "\(alumnosFiltrados[indexPath.row].ApellidoPaterno!) " + "\(alumnosFiltrados[indexPath.row].ApellidoMaterno!)"
        cell.lblFecha.text = ""
        cell.lblGenero.text = ""
        cell.lblTelefono.text = ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Se selecciono \(alumnos[indexPath.row].Nombre!)")
        IdAlumno = alumnos[indexPath.row].IdAlumno
        nombre = alumnos[indexPath.row].Nombre!
        appellidoP = alumnos[indexPath.row].ApellidoPaterno!
        apellidoM = alumnos[indexPath.row].ApellidoMaterno!
        print(IdAlumno)
        self.performSegue(withIdentifier: "MateriasAsignadas", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MateriasAsignadas"{
            var formControl = segue.destination as! MateriasAsignadasController
            formControl.IdAlumnoMateria = self.IdAlumno
            formControl.nombre = self.nombre
            formControl.appellidoP = self.appellidoP
            formControl.apellidoM = self.apellidoM
            print(IdAlumno)
        }
    }
}
