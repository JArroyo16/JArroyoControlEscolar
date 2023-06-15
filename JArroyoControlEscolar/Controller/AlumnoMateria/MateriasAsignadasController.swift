//
//  MateriasAsignadasController.swift
//  JArroyoControlEscolar
//
//  Created by MacBookMBP1 on 09/06/23.
//

import UIKit
import SwipeCellKit

class MateriasAsignadasController: UIViewController {
    
    
    @IBOutlet weak var txtNombre: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var materias : [AlumnoMateria] = []
    var IdAlumnoMateria = 0
    var nombre : String = ""
    var appellidoP : String = ""
    var apellidoM : String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        txtNombre.text = "Nombre: \(nombre) \(appellidoP) \(apellidoM)"
        tableView.register(UINib(nibName: "MateriasAsignadasCell", bundle: .main), forCellReuseIdentifier: "MateriasAsignadasCell")
        tableView.delegate = self
        tableView.dataSource = self
        updateUI()
    }
    
    func updateUI(){
        var resultados = AlumnoMateriaViewModel.GetMateriaAsignada(IdAlumnoMateria: IdAlumnoMateria, reponse: { result, error in
            if let resultSourece = result{
                for objmateria in resultSourece.Objects!{
                    let materia = objmateria
                    self.materias.append(materia)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    
}

extension MateriasAsignadasController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return materias.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MateriasAsignadasCell", for: indexPath) as! MateriasAsignadasCell
        cell.delegate = self
        cell.lblNombre.text = materias[indexPath.row].Materia?.Nombre
        cell.lblCosto.text = materias[indexPath.row].Materia?.Costo.description
        return cell
    }
    
}

extension MateriasAsignadasController : SwipeTableViewCellDelegate{

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {

        if orientation == .right{
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                AlumnoMateriaViewModel.Delete(IdAlumnoMateria: self.materias[indexPath.row].IdAlumnoMateria, reponse: {result, error in
                    self.updateUI()
                    if let resultSource = result{
                        DispatchQueue.main.async {
                            if result!.Correct{
                                let alert = UIAlertController(title: "Mensaje", message: "Materia eliminada correctamente", preferredStyle: .alert)
                                let action = UIAlertAction(title: "Aceptar", style: .default)
                                alert.addAction(action)
                                self.present(alert,animated: true)
                                self.updateUI()                    }
                            else{
                                let alert = UIAlertController(title: "Mensaje", message: "Ocurrio un error a eliminar la materia", preferredStyle: .alert)
                                let action = UIAlertAction(title: "Aceptar", style: .default)
                                alert.addAction(action)
                                self.present(alert,animated: true)
                            }
                        }
                    }
                })
            }
            return [deleteAction]
        }
        return nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MateriasNoAsignadas"{
            var formControl = segue.destination as! MateriasNoAsigndasController
            formControl.IdAlumnoMateria = self.IdAlumnoMateria
            formControl.nombre = self.nombre
            formControl.appellidoP = self.appellidoP
            formControl.apellidoM = self.apellidoM
            
            print(IdAlumnoMateria)
        }
    }

}

